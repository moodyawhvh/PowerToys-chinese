> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。

# 编码指引

## 字符串处理

为了支持本地化,**请不要**在代码中硬编码 UI 显示字符串。应改为使用资源文件来管理字符串。

### C++ 方式

使用 [`StringTable` 资源][String Table] 存储字符串,用资源头文件(`resource.h`)存放与 UI 显示字符串关联的 ID。在资源定义脚本文件中添加带 ID(从头文件引用)的字符串。可以用 [Visual Studio 资源编辑器][VS Resource Editor] 创建和管理资源文件。

- `resource.h`:

XXX 必须是列表中唯一的整数(通常是最后一个字符串 ID 加一):

```cpp
#define IDS_MODULE_DISPLAYNAME                    XXX
```

- 资源定义脚本文件 `validmodulename.rc` 中的 `StringTable`:

```
STRINGTABLE
BEGIN
    IDS_MODULE_DISPLAYNAME               L"Module Name"
END
```

- 在代码中使用 `GET_RESOURCE_STRING(UINT resource_id)` 方法获取字符串。
```cpp
#include <common.h>

std::wstring GET_RESOURCE_STRING(IDS_MODULE_DISPLAYNAME)
```

### C# 方式

使用 [XML 资源文件(.resx)][Resx Files] 存储 UI 显示字符串,并在代码中通过 [`Resource Manager`][Resource Manager] 获取这些字符串。可以用 [Visual Studio][Resx Files VS] 创建和管理 XML 资源文件。

- `Resources.resx`

```xml
  <data name="ValidUIDisplayString" xml:space="preserve">
    <value>Description to be displayed on UI.</value>
    <comment>This text is displayed when XYZ button clicked.</comment>
  </data>
```

- 在代码中使用 [`Resource Manager`][Resource Manager] 获取字符串。
```csharp
System.Resources.ResourceManager manager = new System.Resources.ResourceManager(baseName, assembly);
string validUIDisplayString = manager.GetString("ValidUIDisplayString", resourceCulture);
```

如果使用 Visual Studio 创建资源文件,直接使用自动生成的 `Resources.Designer.cs` 文件中的 `Resources` 类即可,它封装了 [`Resource Manager`][Resource Manager] 的逻辑。

```csharp
string validUIDisplayString = Resources.ValidUIDisplayString;
```

## 更多编码指引

请继续阅读以下与编码标准相关的简短文档:

* [代码风格](development/style.md)
* [代码组织](readme.md)


[VS Resource Editor]: https://learn.microsoft.com/cpp/windows/resource-editors?view=vs-2019
[String Table]: https://learn.microsoft.com/windows/win32/menurc/stringtable-resource
[Resx Files VS]: https://learn.microsoft.com/dotnet/framework/resources/creating-resource-files-for-desktop-apps#resource-files-in-visual-studio
[Resx Files]: https://learn.microsoft.com/dotnet/framework/resources/creating-resource-files-for-desktop-apps#resources-in-resx-files
[Resource Manager]: https://learn.microsoft.com/dotnet/api/system.resources.resourcemanager?view=netframework-4.8
