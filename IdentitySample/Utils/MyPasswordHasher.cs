using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IdentitySample.Utils
{
    using Microsoft.AspNet.Identity;

    public class MyPasswordHasher : PasswordHasher
    {
        public override PasswordVerificationResult VerifyHashedPassword(string hashedPassword, string providedPassword)
        {
            return hashedPassword.Equals(HashPassword(providedPassword)) ? PasswordVerificationResult.Success : PasswordVerificationResult.Failed;
        }

        public override string HashPassword(string password)
        {
            return password;
        }
    }
}