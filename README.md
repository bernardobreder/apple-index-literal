# Introdução

O componente IndexLiteral tem a responsabilidade de representar um índice na forma de String ou Inteiro. Para certos componentes que possui o conceito de array, o índice na forma de String e Inteiro é propício.

# Exemplo

O exemplo abaixo mostra o índice na forma de String:

```swift
let a: IndexLiteral = "abc"
print(a.string) // "abc"
print(a.int) // nil
a.string { s in print(s) } // "abc"
a.int { i in print(i) }
a.literal(string: { s in print(s) }, int: { i in print(i) }) // "abc"
print(a.isString) // true
print(a.isInt) // false
```

O exemplo a seguir demonstra o índice na forma de Inteiro: 

```swift
let b: IndexLiteral = 1
print(b.string) // nil
print(b.int) // 1
b.string { s in print(s) }
b.int { i in print(i) } // 1
b.literal(string: { s in print(s) }, int: { i in print(i) }) // 1 
print(b.isString) // false
print(b.isInt) // true
```

O exemplo abaixo mostra a codificação na forma de String de um índice de String ou Inteiro

```swift
let a: IndexLiteral = "abc"
let aa: IndexLiteral = IndexLiteral(encoded: a.encode())
print(a == aa) // true

let b: IndexLiteral = 1
let bb: IndexLiteral = IndexLiteral(encoded: a.encode())
print(b == bb) // true
```

# Api

## Funções

* Caso o índice seja uma String, a função irá ser chamada

```swift
func string(_ f: (String) -> Void)
```

* Caso o índice seja uma Inteiro, a função irá ser chamada

```swift
func int(_ f: (Int) -> Void) 
```

* Invoca a função correspondente ao tipo do índice 

```swift
func literal(string: (String) -> Void, int: (Int) -> Void)    
```

* Converte o valor correspondente ao indicie

```swift
fun literal<E>(string: (String) -> E, int: (Int) -> E) -> E 
```

## Campos

* Retorna o tipo de valor do indice

```swift
let type: IndexLiteralType
```

* Retorna o valor nativo na forma de String ou Int

```swift
let value: Any
```

* Retorna o valor na forma de String se for um

```swift
let string: String?
```

* Retorna o valor na forma de Int se for um

```swift
let int: Int?
```

* Indica se é um inteiro

```swift
let isInt: Bool
```

* Indica se é uma String

```swift
let isString: Bool
```

## Protocolo ExpressibleByStringLiteral

```swift
init(stringLiteral value: StringLiteralType)
init(extendedGraphemeClusterLiteral value: StringLiteralType) 
init(unicodeScalarLiteral value: StringLiteralType) 
```

## Protocolo ExpressibleByIntegerLiteral

```swift
init(integerLiteral value: IntegerLiteralType)
```

## Protocolo CustomStringConvertible

```swift
var description: String
var debugDescription: String
```

## Protocolo Hashable

```swift
static func ==(lhe: IndexLiteral, hrs: IndexLiteral) -> Bool
var hashValue: Int
```

