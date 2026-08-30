import { describe, it, expect } from "vitest";
import { cn } from "./utils";

describe("cn", () => {
  it("nối các clas string bình thường", () => {
    expect(cn("foo", "bar")).toBe("foo bar");
  });

  it("bỏ qua giá trị falsy", () => {
    expect(cn("foo", undefined, null, false, "", "bar")).toBe("foo bar");
  });

  it("hỗ trợ cú pháp object điều kiện của clsx", () => {
    expect(cn("base", { active: true, disabled: false })).toBe("base active");
  });

  it("giải quyết xung đột class tailwind, class sau thắng", () => {
    expect(cn("px-2", "px-4")).toBe("px-4");
  });
});
