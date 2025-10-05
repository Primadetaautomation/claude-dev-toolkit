# 🎨 Frontend Development - UI, Components & User Experience

**Auto-loaded when:** UI, formulier, knop, pagina, component, frontend, scherm tonen

---

## Component Standards

### React/Next.js Best Practices
**COMP-1 (MUST)** Functional components met hooks
**COMP-2 (MUST)** Props interface/types definition
**COMP-3 (SHOULD)** Component per file (single responsibility)
**COMP-4 (MUST)** Descriptive component names (PascalCase)

```typescript
// Good example
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
  return (
    <button
      className={`btn btn-${variant}`}
      onClick={onClick}
      disabled={disabled}
    >
      {label}
    </button>
  );
}
```

### Component Structure
```
src/
├── components/
│   ├── ui/           # Reusable UI components (Button, Input, Card)
│   ├── forms/        # Form components
│   ├── layout/       # Layout components (Header, Footer, Sidebar)
│   └── features/     # Feature-specific components
├── pages/           # Next.js pages or React Router routes
├── hooks/           # Custom React hooks
├── lib/             # Utilities, helpers
└── styles/          # Global styles, themes
```

---

## State Management

### Local State (useState)
```typescript
// Simple component state
const [count, setCount] = useState(0);
const [isOpen, setIsOpen] = useState(false);
const [formData, setFormData] = useState({ name: '', email: '' });
```

### Global State (Context API)
```typescript
// Create context
const UserContext = createContext<User | null>(null);

// Provider
export function UserProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);

  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
}

// Consumer hook
export function useUser() {
  const context = useContext(UserContext);
  if (!context) throw new Error('useUser must be used within UserProvider');
  return context;
}
```

### Server State (React Query / SWR)
```typescript
// Fetching data
function UserProfile({ userId }: { userId: string }) {
  const { data, isLoading, error } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => fetch(`/api/users/${userId}`).then(res => res.json())
  });

  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;

  return <div>{data.name}</div>;
}
```

**STATE-1 (SHOULD)** Use React Query/SWR voor server state
**STATE-2 (MUST)** Avoid prop drilling (use Context voor deep props)
**STATE-3 (SHOULD)** Zustand/Redux alleen voor complexe apps

---

## Forms & Validation

### Form Handling (React Hook Form)
```typescript
import { useForm } from 'react-hook-form';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';

// Schema validation
const schema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Password must be at least 8 characters')
});

type FormData = z.infer<typeof schema>;

function LoginForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema)
  });

  const onSubmit = async (data: FormData) => {
    await fetch('/api/login', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}

      <input type="password" {...register('password')} />
      {errors.password && <span>{errors.password.message}</span>}

      <button type="submit">Login</button>
    </form>
  );
}
```

**FORM-1 (MUST)** Client-side validation vóór submit
**FORM-2 (MUST)** Server-side validation altijd (trust nothing from client)
**FORM-3 (MUST)** Show clear error messages
**FORM-4 (SHOULD)** Disable submit tijdens processing
**FORM-5 (MUST)** Handle loading/success/error states

---

## Styling

### Tailwind CSS (Recommended)
```tsx
// Utility-first CSS
<button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
  Click me
</button>

// Responsive design
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  {items.map(item => <Card key={item.id} {...item} />)}
</div>
```

### CSS Modules (Alternative)
```tsx
// Button.module.css
.button {
  padding: 0.5rem 1rem;
  border-radius: 0.25rem;
}

.primary {
  background-color: blue;
  color: white;
}

// Button.tsx
import styles from './Button.module.css';

export function Button() {
  return <button className={`${styles.button} ${styles.primary}`}>Click</button>;
}
```

**STYLE-1 (MUST)** Consistent spacing system (4px, 8px, 16px, etc.)
**STYLE-2 (MUST)** Color palette definition (primary, secondary, etc.)
**STYLE-3 (SHOULD)** Dark mode support
**STYLE-4 (MUST)** Mobile-first responsive design

---

## Data Fetching

### Server-Side Rendering (Next.js)
```typescript
// app/users/page.tsx
async function UsersPage() {
  const users = await fetch('https://api.example.com/users')
    .then(res => res.json());

  return (
    <div>
      {users.map(user => (
        <UserCard key={user.id} user={user} />
      ))}
    </div>
  );
}
```

### Client-Side Fetching
```typescript
'use client';

function UsersList() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/users')
      .then(res => res.json())
      .then(data => {
        setUsers(data);
        setLoading(false);
      })
      .catch(error => {
        console.error(error);
        setLoading(false);
      });
  }, []);

  if (loading) return <LoadingSpinner />;

  return <div>{users.map(user => <UserCard key={user.id} {...user} />)}</div>;
}
```

**FETCH-1 (MUST)** Loading states voor alle async operations
**FETCH-2 (MUST)** Error handling met user-friendly messages
**FETCH-3 (SHOULD)** Optimistic updates waar mogelijk
**FETCH-4 (MUST)** Prevent race conditions (abort controllers)

---

## Accessibility (A11Y)

### Essential Accessibility
**A11Y-1 (MUST)** Semantic HTML elements
```tsx
// Good
<button onClick={handleClick}>Click me</button>
<nav><ul><li><a href="/about">About</a></li></ul></nav>

// Bad
<div onClick={handleClick}>Click me</div>
<div className="nav">...</div>
```

**A11Y-2 (MUST)** Alt text voor images
```tsx
<img src="/profile.jpg" alt="User profile picture" />
```

**A11Y-3 (MUST)** ARIA labels waar nodig
```tsx
<button aria-label="Close modal" onClick={onClose}>
  <XIcon />
</button>
```

**A11Y-4 (MUST)** Keyboard navigation support
**A11Y-5 (MUST)** Color contrast ratio (WCAG AA: 4.5:1)
**A11Y-6 (SHOULD)** Screen reader testing

---

## Performance

### Code Splitting
```typescript
// Dynamic imports
const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <LoadingSpinner />
});
```

### Image Optimization (Next.js)
```tsx
import Image from 'next/image';

<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={600}
  priority // Voor above-the-fold images
/>
```

### Memoization
```typescript
// Expensive calculation
const expensiveValue = useMemo(() => {
  return calculateExpensiveValue(data);
}, [data]);

// Prevent re-renders
const MemoizedComponent = memo(function Component({ data }) {
  return <div>{data}</div>;
});

// Callback stability
const handleClick = useCallback(() => {
  doSomething(id);
}, [id]);
```

**PERF-1 (SHOULD)** Lazy load routes/components
**PERF-2 (MUST)** Optimize images (WebP, lazy loading)
**PERF-3 (SHOULD)** Bundle size monitoring (<200KB initial)
**PERF-4 (MUST)** Avoid unnecessary re-renders

---

## Routing

### Next.js App Router
```typescript
// app/
├── layout.tsx          # Root layout
├── page.tsx           # Home page (/)
├── about/
│   └── page.tsx       # About page (/about)
├── users/
│   ├── page.tsx       # Users list (/users)
│   └── [id]/
│       └── page.tsx   # User detail (/users/123)
```

### Navigation
```tsx
import Link from 'next/link';
import { useRouter } from 'next/navigation';

// Link component
<Link href="/about">About</Link>

// Programmatic navigation
const router = useRouter();
router.push('/dashboard');
```

---

## Testing

### Component Testing (Jest + React Testing Library)
```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from './Button';

describe('Button', () => {
  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button label="Click me" onClick={handleClick} />);

    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('is disabled when disabled prop is true', () => {
    render(<Button label="Click me" onClick={() => {}} disabled />);
    expect(screen.getByText('Click me')).toBeDisabled();
  });
});
```

**TEST-FE-1 (MUST)** Test user interactions
**TEST-FE-2 (MUST)** Test conditional rendering
**TEST-FE-3 (SHOULD)** E2E tests voor critical flows
**TEST-FE-4 (MUST)** Accessibility tests

---

## Common Patterns

### Loading States
```tsx
function DataComponent() {
  const { data, isLoading, error } = useQuery('data', fetchData);

  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!data) return <EmptyState />;

  return <DataDisplay data={data} />;
}
```

### Error Boundaries
```tsx
class ErrorBoundary extends React.Component {
  state = { hasError: false };

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong</h1>;
    }

    return this.props.children;
  }
}
```

---

*Auto-loaded bij: UI, component, formulier, knop, pagina, frontend, tonen op scherm*
