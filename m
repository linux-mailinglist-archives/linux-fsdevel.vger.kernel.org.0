Return-Path: <linux-fsdevel+bounces-6841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F981D574
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EF21C212B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15012E5B;
	Sat, 23 Dec 2023 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MUFagebX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBD1400D
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Dec 2023 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703354100; bh=+BUihYEmwpKBOXBgyCUAxNcYzC7MGIJaZ07zSEzIue0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MUFagebXnWOV5NX28RZg8ingJY7KzFiAkD4aXbdi3bZK41ox5ZTwuszAdHb6jAsE+T4uzbOMl5IlXSjjP0YNyHyXUvVAFAoitxLUjWXB3RHZfN3UnLpLGKMoNOBXhj3/cugxw3YiB7vSkf3/1PULFaRdyT0iaVDpHYlJ+3MBtEHLZUWFt+CZDAv9YPMiYR0Rr605KS8nWJsmWRgVptMjGkfWV3OW9kVXoFtQZUts/kfVFeyHJuUfQygJy2Sp+gmKoB/y4zbXZe9ds4crTQesOHqbmytAkP1sSuGN9/5toLMMHp60RhJztbSq6ylXYvs+X0Pk9A9RoW/DnRlbdymbfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703354100; bh=y2AJ3MsKb8+gEvQhyQGJg0OFE1fVl8en5f6yq1hSfh4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RFI6CEnQDo5siFvpm+vWhRmpYgI/vR2FcsiLHq/OgjsXAyLEm7iRVof3ZRM5SHeoi9PV3Nf0nmDuW+ZPoBXpKlwB6NxD/4nqeGDAbgs4OMAP+2KkYv/YNJ6SGX9nPPfJhomd3BNhMLGDImk8w6xuzoio56iHiPL3N667n/m0qeq79ZCItmGivGdm6K2wYYib+hmRpuzSJ67j2Wkm1pCRKnoPCzQlihv6CMNxcFzPhz4h9zgH6RfSwnpBQdhajXl7bPzfUrEAAtDMzYfILGUYUKZJ8yD/ikIsfUsSHs8v4onzqKv5azttNDvyB32CZZX0gY0FFyQqKBB8snwzoRpBtg==
X-YMail-OSG: 9htz1pYVM1n4Db.uRNJhixl7krdxFlGAUtsiRK4cJJEnBOyS0POIuGzmYmfYfcC
 Q6ulN9dPgkYt2l3Bq3TkvQ7yhKD84YgIvREXr40VYu.1B8rs_cSvaXypVjxkF6V0oMDMcLoZYZdD
 f8fnu9HlvRfoR2vg0V6DuU7uw5x1TgX3ntT2j9HTMEiLPg4Edb6Lnvwzvmr.JqngNUE_SFpGnokz
 KLrrqPtFd4KHoVeyN117Pg5kR2DsC7qL94qq2ZsYtnyuD7NJ2SGnFgrxB6Uyp7pUdGwJgLuT8f0e
 _iDVRELaSmsG0zn2ZvGWEL94mfaXUJXpda5so4wEuU5ZisZp.r.m6qVfUl0qRZYldkHUm2Q0pNVR
 T2U1UWokPkuJ0qNaLfUfpTNynyLlHxwU1X3opgAWVkrDAXJLLoQCU6Fbn.VvYs2suJD7oE9wUQ8v
 rDSdPDlPvdcL5HXbzTTPf7Z_vLEcR11iLU9xEm9ai8_UgkugZ6qnqeVMC8fdKGD7qjR7HmB.yaaW
 U.T2I.NxaYXVdAMYLZOI9tXceZUHFlgmrDIIXrSqU_R2ya_ILNVBKDtq597t5RgiDE2T4UsHtnvZ
 GKD9nikQdH49gv6L4p0wW9mTCjZfOAJwccrsa0BWrksQnQEyKRdcZ6kpXB_8bmymrwY0AeK81kvq
 lY6H.Gao1mvAKYAYBtUoRi38GTM7Y91HX52HRrnR_zC7mmR42bGc3IWaQhk7XVQsAtiBF_5bzNFc
 f5fejp7zNAUmck3aVjAOE2aTWMiRZFy5yKAbGXUtASeRZfTjwri3s2K8mtJs2zfZ6yEAkdyWk89m
 .gqMaIZPHIOBM6aWCf9i.9NBkp2rQRT5rMWzTPIC4na22KwSZa0iCkbEFsGPJIJytQsU_JieDAVx
 0tiNOrusMCQ44WZB7lu9mAsbnVp_WtjaHCQhRlRPugCR8OxQWHA8ZAH4Pt2B1ZZst_a7xMDyFJ9E
 MlI0shqQxJjWfBUuaA8IBjrJvvFkB2JLhK0caHJlpH2Xund4xpa_pfyqCI4si00E1R5EeYYGThTp
 j1Cqu3ACHYVWfon1AG9PhM7iHGktYxl1f26OKlM2e8qgeWqhxHO8_MFnnWysODQmDUIfYobQElL0
 AUQrVdVt9nWCYc5ZB3ejpDIqjhPAIBxPnEOt4Hnqb_f5RxOKoUx3o6.F0cSHaqMSRutkHeSPXvbH
 MJfhIPR28ix8WfhHQaeTZGS.jjSq_68_LMhqB5idxLkkFHgnUFIAGX.ktawB7kFqxzyTJCb3Xbzn
 44Z3tLXczrdS9nDQ1hOxGcmRNnAXQe7yJWwsJ4pZNZrUJ4ydm3Xo_XmAcubL6LJM9DggGSrW5gXP
 W7kDg8gHr2ct041YZxo0RCSMp3lB_iGFMwD9_vVUOnkJnthgqFyEUgJdUhOBes_k.czCvC_IIG8I
 SUTfbL2d5yU0aiok7kMe8nt33Xy3XaSMrEN5Kc8sfgjWMtERZ5JQ9QgMTS5ClGWGMF17.q7bTGpo
 JipwfiWE6KuO5IhNb4FBmJFXQ6DOXKsYeYEN6oiTcvdhPjJFM5EGUf5YIwfysHerVqIOCnX9Tr0G
 _hFKAeRd30VE7ZElzu0l6Oy1fllpeiKjVXjp1oYr6ddCwiRgAEwCdOaI97kUKKUybIbNYXi6zbBy
 3FuBx7MSqqLVPoT_VyDn8yg58BHBFWfPbBSDmr4Go_FS3UiKyPRdfya8NF.0AkGnZybsGe8yP5Sh
 wUx4L5AlizC2JBeLbXn3IAYOc5j86FU5H14coU7WQ51pVnM1GHtpJDXNNyNIMO1PUlxhqcizzOay
 D2dYdLLTDAl1rfpUNkGLVf2j.98gh4OeSc.OPVXQjkSbQeqsPCnUDlEalogYKN6ewyQwbUqmsekl
 HKzMsSw88VLb3f4KfMwumufW0s6MwRxhpN83evVkKvpzJhI.oN15SOp3ilopTeATOTIFiVwxPuAa
 mk96gRCdbmXEFgkKMkmm7PTym5ExPtga9qQwxIC.sdA8zOBB7tUtaaaTh6cvbAfN7qoNPY6q6anG
 KKADnESIpZwRuZSlZNJGEtmNTD..6gKetEsLTATYTFu3hWK4m0FjuQ.rsGB5Il5IXO0O82RWVn8U
 NadKjX._dzZ8DXys6qvwUnpmnx0U8D7c9GLYGxWT_YBjEl_cU1khNss4HOaHRduQoIILL.Q6ve2u
 vCb1.BHwvgmZlv.R.ic2DhlnsAoqGj6H6RPsIRoeJytUzGNnzYuE_06uNLqMuS85T8Y5BldCF_Vk
 LIT00taXFeyPsOkk45JjbDAC_3voVe2nz6e8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e4b7efd3-40f1-4db6-83ca-323de262d875
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 Dec 2023 17:55:00 +0000
Received: by hermes--production-gq1-6949d6d8f9-qkzts (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc33e83e16324ee3dc32a1a8a5a85207;
          Sat, 23 Dec 2023 17:54:54 +0000 (UTC)
Message-ID: <145aad92-4e32-42e2-b50e-5d56d5f38b52@schaufler-ca.com>
Date: Sat, 23 Dec 2023 09:54:53 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/22/2023 5:23 PM, Paul Moore wrote:
> On Tue, Dec 19, 2023 at 4:09 AM Alfred Piccioni <alpic@google.com> wrote:
>> Some ioctl commands do not require ioctl permission, but are routed to
>> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
>> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>>
>> However, if a 32-bit process is running on a 64-bit kernel, it emits
>> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
>> being checked erroneously, which leads to these ioctl operations being
>> routed to the ioctl permission, rather than the correct file
>> permissions.
>>
>> This was also noted in a RED-PEN finding from a while back -
>> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>>
>> This patch introduces a new hook, security_file_ioctl_compat, that is
>> called from the compat ioctl syscall. All current LSMs have been changed
>> to support this hook.
>>
>> Reviewing the three places where we are currently using
>> security_file_ioctl, it appears that only SELinux needs a dedicated
>> compat change; TOMOYO and SMACK appear to be functional without any
>> change.
>>
>> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
>> Signed-off-by: Alfred Piccioni <alpic@google.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  fs/ioctl.c                    |  3 +--
>>  include/linux/lsm_hook_defs.h |  2 ++
>>  include/linux/security.h      |  7 +++++++
>>  security/security.c           | 17 +++++++++++++++++
>>  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
>>  security/smack/smack_lsm.c    |  1 +
>>  security/tomoyo/tomoyo.c      |  1 +
>>  7 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index f5fd99d6b0d4..76cf22ac97d7 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -920,8 +920,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>>         if (!f.file)
>>                 return -EBADF;
>>
>> -       /* RED-PEN how should LSM module know it's handling 32bit? */
>> -       error = security_file_ioctl(f.file, cmd, arg);
>> +       error = security_file_ioctl_compat(f.file, cmd, arg);
>>         if (error)
>>                 goto out;
> This is interesting ... if you look at the normal ioctl() syscall
> definition in the kernel you see 'ioctl(unsigned int fd, unsigned int
> cmd, unsigned long arg)' and if you look at the compat definition you
> see 'ioctl(unsigned int fd, unsigned int cmd, compat_ulong_t arg)'.  I
> was expecting the second parameter, @cmd, to be a long type in the
> normal definition, but it is an int type in both cases.  It looks like
> it has been that way long enough that it is correct, but I'm a little
> lost ...
>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index ac962c4cb44b..626aa8cf930d 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>>          unsigned long arg)
>> +LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
>> +        unsigned long arg)
>>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>>          unsigned long prot, unsigned long flags)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 5f16eecde00b..22a82b7c59f1 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -389,6 +389,7 @@ int security_file_permission(struct file *file, int mask);
>>  int security_file_alloc(struct file *file);
>>  void security_file_free(struct file *file);
>>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg);
>>  int security_mmap_file(struct file *file, unsigned long prot,
>>                         unsigned long flags);
>>  int security_mmap_addr(unsigned long addr);
>> @@ -987,6 +988,12 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>>         return 0;
>>  }
>>
>> +static inline int security_file_ioctl_compat(struct file *file, unsigned int cmd,
>> +                                     unsigned long arg)
>> +{
>> +       return 0;
>> +}
>> +
>>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>>                                      unsigned long flags)
>>  {
>> diff --git a/security/security.c b/security/security.c
>> index 23b129d482a7..5c16ffc99b1e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2648,6 +2648,23 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  }
>>  EXPORT_SYMBOL_GPL(security_file_ioctl);
>>
>> +/**
>> + * security_file_ioctl_compat() - Check if an ioctl is allowed in 32-bit compat mode
>> + * @file: associated file
>> + * @cmd: ioctl cmd
>> + * @arg: ioctl arguments
>> + *
>> + * Compat version of security_file_ioctl() that correctly handles 32-bit processes
>> + * running on 64-bit kernels.
>> + *
>> + * Return: Returns 0 if permission is granted.
>> + */
>> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
>> +{
>> +       return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
>> +}
>> +EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
>> +
>>  static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
>>  {
>>         /*
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 2aa0e219d721..c617ae21dba8 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3731,6 +3731,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>>         return error;
>>  }
>>
>> +static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
>> +                             unsigned long arg)
>> +{
>> +       /*
>> +        * If we are in a 64-bit kernel running 32-bit userspace, we need to make
>> +        * sure we don't compare 32-bit flags to 64-bit flags.
>> +        */
>> +       switch (cmd) {
>> +       case FS_IOC32_GETFLAGS:
>> +               cmd = FS_IOC_GETFLAGS;
>> +               break;
>> +       case FS_IOC32_SETFLAGS:
>> +               cmd = FS_IOC_SETFLAGS;
>> +               break;
>> +       case FS_IOC32_GETVERSION:
>> +               cmd = FS_IOC_GETVERSION;
>> +               break;
>> +       case FS_IOC32_SETVERSION:
>> +               cmd = FS_IOC_SETVERSION;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return selinux_file_ioctl(file, cmd, arg);
>> +}
> Is it considered valid for a native 64-bit task to use 32-bit
> FS_IO32_XXX flags?  If not, do we want to remove the FS_IO32_XXX flag
> checks in selinux_file_ioctl()?
>
>>  static int default_noexec __ro_after_init;
>>
>>  static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
>> @@ -7036,6 +7063,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>         LSM_HOOK_INIT(file_permission, selinux_file_permission),
>>         LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
>>         LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
>> +       LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>>         LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
>>         LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
>>         LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 65130a791f57..1f1ea8529421 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4973,6 +4973,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>>
>>         LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
>>         LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
>> +       LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
>>         LSM_HOOK_INIT(file_lock, smack_file_lock),
>>         LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
>>         LSM_HOOK_INIT(mmap_file, smack_mmap_file),
>> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
>> index 25006fddc964..298d182759c2 100644
>> --- a/security/tomoyo/tomoyo.c
>> +++ b/security/tomoyo/tomoyo.c
>> @@ -568,6 +568,7 @@ static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
>>         LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
>>         LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
>>         LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
>> +       LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
>>         LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
>>         LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
>>         LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
> I agree that it looks like Smack and TOMOYO should be fine, but I
> would like to hear from Casey and Tetsuo to confirm.

Smack should be OK.



