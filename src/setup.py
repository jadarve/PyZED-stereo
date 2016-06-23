#!/usr/bin/env python

'''
    setup.py
    ----------

    :copyright: 2015, Juan David Adarve. See AUTHORS for more details
    :license: 3-clause BSD, see LICENSE for more details
'''


from distutils.core import setup, Extension
from Cython.Build import cythonize

import numpy as np

incDirs = ['/usr/local/zed/include',
           '/usr/local/cuda/include',
           np.get_include()]

libDirs = ['/usr/local/zed/lib',
           '/usr/local/cuda/lib64',
           '/usr/local/lib']


libs = ['cudpp_hash', 'cudpp', 'sl_calibration', 'sl_depthcore', 'sl_zed',
        'opencv_core', 'opencv_highgui', 'opencv_imgproc',
        'cudart', 'nppi', 'npps']
cflags = ['-std=c++11']

cython_directives = {'embedsignature' : True}

def createExtension(name, sources):

    global incDirs
    global libDirs
    global libs

    ext = Extension(name,
                    sources=sources,
                    include_dirs=incDirs,
                    library_dirs=libDirs,
                    libraries=libs,
                    runtime_library_dirs=libs,
                    language='c++',
                    extra_compile_args=cflags)

    return ext

# list of extension modules
extensions = list()

#################################################
# PURE PYTHON PACKAGES
#################################################
py_packages = ['pyzed']

# package data include Cython .pxd files
package_data = {'pyzed' : ['*.pxd']}

#################################################
# CYTHON EXTENSIONS
#################################################
GPUmodulesTable = [ ('pyzed.globals', ['pyzed/globals.pyx']),
                    ('pyzed.mat', ['pyzed/mat.pyx']),
                    ('pyzed.camera', ['pyzed/camera.pyx']),
                  ]

for mod in GPUmodulesTable:
    extList = cythonize(createExtension(mod[0], mod[1]), compiler_directives=cython_directives)
    extensions.extend(extList)


# call distutils setup
setup(name='pyzed',
    version='0.1',
    author='Juan David Adarve',
    author_email='juanda0718@gmail.com',
    maintainer='Juan David Adarve',
    maintainer_email='juanda0718@gmail',
    url='TODO',
    description='TODO',
    license='3-clause BSD',
    packages=py_packages,
    ext_modules=extensions,
    package_data=package_data)
