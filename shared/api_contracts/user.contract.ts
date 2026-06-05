export interface UserContract {
  id: string;
  email: string;
  firstName?: string;
  lastName?: string;
  role: "player" | "coach" | "admin";
}

export interface AuthResponse {
  success: boolean;
  data: {
    user: UserContract;
    accessToken: string;
  };
  error: string | null;
}
