
CXX = g++
CXXFLAGS = -Wall -std=c++11
TARGET = lab_1_op_sys.exe
OBJ = lab_1_op_sys.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $@ $^ -lkernel32

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	del /Q $(TARGET) *.o *.s

# Генерация ассемблерного кода с разными уровнями оптимизации
asm:
	$(CXX) -S -O0 -o optimizaion_O0.s lab_1_op_sys.cpp
	$(CXX) -S -O1 -o optimizaion_O1.s lab_1_op_sys.cpp
	$(CXX) -S -O2 -o optimizaion_O2.s lab_1_op_sys.cpp
	$(CXX) -S -O3 -o optimizaion_O3.s lab_1_op_sys.cpp
	$(CXX) -S -Os -o optimizaion_Os.s lab_1_op_sys.cpp