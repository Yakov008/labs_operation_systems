#include <windows.h>
#include <iostream>
#include <string>
#include <vector>

struct SharedData {
    int input;
    unsigned long long result;
    bool data_ready;
    bool result_ready;
    bool exit_flag;
};

unsigned long long factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
// Функция для работы дочернего процесса
DWORD WINAPI child_process(LPVOID lpParam) {
    SharedData* shared = (SharedData*)lpParam;
    HANDLE hMutex = OpenMutexW(MUTEX_ALL_ACCESS, FALSE, L"FactorialMutex");

    while (true) {
        WaitForSingleObject(hMutex, INFINITE);

        if (shared->exit_flag) {
            ReleaseMutex(hMutex);
            break;
        }

        if (shared->data_ready && !shared->result_ready) {
            shared->result = factorial(shared->input);
            shared->data_ready = false;
            shared->result_ready = true;
        }

        ReleaseMutex(hMutex);
        Sleep(10); // Небольшая пауза для уменьшения нагрузки на CPU
    }

    CloseHandle(hMutex);
    return 0;
}

int main() {
    // Создаем мьютекс для синхронизации
    HANDLE hMutex = CreateMutexW(NULL, FALSE, L"FactorialMutex");
    if (hMutex == NULL) {
        std::cerr << "CreateMutex failed: " << GetLastError() << std::endl;
        return 1;
    }

    // Создаем разделяемую память
    HANDLE hMapFile = CreateFileMappingW(INVALID_HANDLE_VALUE,NULL,PAGE_READWRITE,0,sizeof(SharedData),L"FactorialSharedMemory");

    if (hMapFile == NULL) {
        std::cerr << "CreateFileMapping failed: " << GetLastError() << std::endl;
        CloseHandle(hMutex);
        return 1;
    }

    SharedData* shared = (SharedData*)MapViewOfFile(hMapFile,FILE_MAP_ALL_ACCESS,0,0,sizeof(SharedData));

    if (shared == NULL) {
        std::cerr << "MapViewOfFile failed: " << GetLastError() << std::endl;
        CloseHandle(hMapFile);
        CloseHandle(hMutex);
        return 1;
    }

    // Инициализация разделяемых данных
    shared->data_ready = false;
    shared->result_ready = false;
    shared->exit_flag = false;

    // Создаем дочерний процесс
    STARTUPINFO si = { sizeof(si) };
    PROCESS_INFORMATION pi;

    if (!CreateProcess(NULL,(LPSTR)"child_process.exe",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)) {
        std::cerr << "CreateProcess failed: " << GetLastError() << std::endl;
        UnmapViewOfFile(shared);
        CloseHandle(hMapFile);
        CloseHandle(hMutex);
        return 1;
    }

    // Основной цикл взаимодействия
    while (true) {
        std::cout << "Enter a number to compute factorial (or -1 to exit): ";
        int num;
        std::cin >> num;

        if (num == -1) {
            WaitForSingleObject(hMutex, INFINITE);
            shared->exit_flag = true;
            ReleaseMutex(hMutex);
            break;
        }

        if (num < 0) {
            std::cout << "Number must be non-negative!" << std::endl;
            continue;
        }

        // Отправляем данные дочернему процессу
        WaitForSingleObject(hMutex, INFINITE);
        shared->input = num;
        shared->data_ready = true;
        shared->result_ready = false;
        ReleaseMutex(hMutex);

        // Ждем результат
        while (true) {
            WaitForSingleObject(hMutex, INFINITE);
            if (shared->result_ready) {
                std::cout << "Factorial of " << num << " is " << shared->result << std::endl;
                ReleaseMutex(hMutex);
                break;
            }
            ReleaseMutex(hMutex);
            Sleep(10);
        }
    }

    // Ожидаем завершение дочернего процесса
    WaitForSingleObject(pi.hProcess, INFINITE);

    // Освобождаем ресурсы
    UnmapViewOfFile(shared);
    CloseHandle(hMapFile);
    CloseHandle(hMutex);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}
