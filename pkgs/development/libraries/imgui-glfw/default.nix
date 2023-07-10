{ stdenv
, lib
, fetchFromGitHub
, cmake
, glfw
}:

stdenv.mkDerivation rec {
  pname = "imgui-glfw";
  version = "1.89.7";

  src = fetchFromGitHub {
    owner = "ocornut";
    repo = "imgui";
    rev = "v${version}";
    sha256 = "sha256-kio1zy1DVL/Uh4eOqmHNCTE+Tb0GAIvsT4XDPkgHqYs=";
  };

  propagatedBuildInputs = [ glfw ];

  nativeBuildInputs = [ cmake ];

  postUnpack = ''
    cd $sourceRoot
    cp -v ${./CMakeLists.txt} CMakeLists.txt
    cp -v ${./imgui-config.cmake.in} imgui-config.cmake.in
    cd ..
  '';

  cmakeFlags = [
    "-DIMGUI_BUILD_OPENGL3_BINDING=ON"
    "-DIMGUI_BUILD_GLFW_BINDING=ON"
  ];

  meta = with lib; {
    description = "Graphical user interface for C++ with GLFW/OpenGL3 backend";
    homepage = "https://github.com/ocornut/imgui";
    license = licenses.mit;
    maintainers = with maintainers; [ mkoerner ];
    platforms = platforms.all;
  };

}
