
cimport pyzed.globals as sl

cdef extern from 'zed/Mat.hpp' namespace 'sl::zed':
    
    cdef enum DATA_TYPE:
        FLOAT
        UCHAR


    cdef enum MAT_TYPE:
        CPU
        GPU


    cdef cppclass Mat:

        Mat()
        Mat(int width, int height, int channels, DATA_TYPE data_type, sl.uchar* data, MAT_TYPE mat_type)

        sl.uchar3 getValue(int x, int y) const

        void setUp(int width, int height, int step, sl.uchar* data, int channels, DATA_TYPE data_type, MAT_TYPE mat_type)

        void setUp(int width, int height, int channels, DATA_TYPE data_type, MAT_TYPE mat_type = CPU)

        void allocate_cpu(int width, int height, int channels, DATA_TYPE data_type)

        void allocate_cpu()

        void deallocate()

        int getWidthByte() const

        int getDataSize() const

        void info()

        int width
        int height
        int step

        
        sl.uchar* data
        int channels
        DATA_TYPE data_type
        MAT_TYPE type


cdef toNumpy(Mat img)
