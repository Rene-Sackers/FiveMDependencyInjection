# FiveM client-side C# dependency injection framework

Well, this is a first. A GTA multiplayer mod that has enough freedom in the client-side C# scripting that you can build a DI framework.

I did the absolute bare minimum to get a "working" framework.

NuGet:  
[FiveMDependencyInjection](https://www.nuget.org/packages/FiveMDependencyInjection/)

## Example

```csharp
var builder = new ContainerBuilder();

// Single instance & "As" registration
// Registers ChatService as a single instance (singleton). Can be resolved in constructors as ChatService or IChatService
builder
	.RegisterType<ChatService>()
	.SingleInstance()
	.As<IChatService>();

// Factory registration
// Registers the EventHandlerDictionary of the current BaseScript so you can access it elsewhere using DI
builder
	.Register(() => EventHandlers)
	.As<EventHandlerDictionary>();

var container = builder.Build();
```

## Resolving all services implementing type X

Most DI frameworks allow you to do the following:

```csharp
public class MyClass
{
	public MyClass(IEnumerable<SomeServiceType> someServices) {
		...
	}
}
```

Due to client-side restructions on reflection, this only works with array types:

```csharp
public class MyClass
{
	public MyClass(SomeServiceType[] someServices) {
		...
	}
}
```

Does the same, but will immediately provide the constructor of your service with instances of the type you're looking for.

## Debugging

The DI framework has a little bit of logging, but in order to make it work, you have to make this call before you build any containers in your `BaseScript` constructor:

```csharp
FiveMDependencyInjection.LogHelper.LogAction = Debug.WriteLine;
```

It will at least tell you what it's trying to resolve.

## Implementing

Make sure you copy the `FiveMDependencyInjection.dll` to your resource and add it to `client_scripts` in `fxmanifest.lua`.

## NuGet feed

```
https://nuget.pkg.github.com/Rene-Sackers/index.json
```