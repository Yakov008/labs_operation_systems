
#include <windows.h>
#include <iostream>
#include <string>

unsigned long long factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

// Функция для работы дочернего процесса
DWORD WINAPI child_process(LPVOID lpParam) {
    HANDLE hMapFile = (HANDLE)lpParam;
    // Получаем указатель на разделяемую память
    unsigned long long* pBuf = (unsigned long long*)MapViewOfFile(hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(unsigned long long));
    if (pBuf == NULL) {
        std::cerr << "Could not map view of file: " << GetLastError() << std::endl;
        CloseHandle(hMapFile);
        return 1;
    }
    // Вычисляем факториал (в этом примере просто число 5)
    *pBuf = factorial(5);
    // Освобождаем ресурсы
    UnmapViewOfFile(pBuf);
    return 0;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <number>" << std::endl;
        return 1;
    }
    int num = atoi(argv[1]);
    if (num < 0) {
        std::cerr << "Number must be non-negative" << std::endl;
        return 1;
    }
    // Создаем разделяемую память
    HANDLE hMapFile = CreateFileMappingW(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, sizeof(unsigned long long), L"FactorialSharedMemory");

    if (hMapFile == NULL) {
        std::cerr << "Could not create file mapping object: " << GetLastError() << std::endl;
        return 1;
    }
    // Создаем дочерний поток
    HANDLE hThread = CreateThread(NULL, 0, child_process, hMapFile, 0, NULL);

    if (hThread == NULL) {
        std::cerr << "CreateThread failed: " << GetLastError() << std::endl;
        CloseHandle(hMapFile);
        return 1;
    }
    // Ждем завершения дочернего потока
    WaitForSingleObject(hThread, INFINITE);
    // Читаем результат из разделяемой памяти
    unsigned long long* pBuf = (unsigned long long*)MapViewOfFile(hMapFile, FILE_MAP_READ, 0, 0, sizeof(unsigned long long));
    if (pBuf == NULL) {
        std::cerr << "Could not map view of file: " << GetLastError() << std::endl;
        CloseHandle(hMapFile);
        return 1;
    }
    std::cout << "Factorial of 5 is " << *pBuf << std::endl;
    // Освобождаем ресурсы
    UnmapViewOfFile(pBuf);
    CloseHandle(hMapFile);
    CloseHandle(hThread);
    return 0;
}
