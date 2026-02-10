Return-Path: <linux-fsdevel+bounces-76885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CBLMJCRi2n/WAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:14:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D411EEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B40303E4B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0CB331A5C;
	Tue, 10 Feb 2026 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="RZWe37SK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74E32E68F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770754437; cv=pass; b=k8PGVW9NcKJsG29envIQtUEmTewjMPyNdzZdhnwUaDxjW5fv4iCNG1oyi5pFEya/GqWtY+cpmecqEeCrmZTB6B49njiDh13lO8LC+tkTE0pX9UJX/tittTVvgtodv5K3aWfl62oTKKOHAiBm8DaYWYMj0dqXKhfcUQaRWh3lAaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770754437; c=relaxed/simple;
	bh=QshdCsTUjKyqyPaWmy4QDu9BmrHT6vSCGl3jBYcCwbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHOmOU8L1P6yWfHzoV0gb516uRMLOF/sLu/Axwgp6xLgYUAFRpVsRErSbDDUwN5QzNqPNRvGNN+t/FAp0g8q1sQAePnvKcksJSiw5NyZfk1YqyXmnrO65LFfbO5uLJOOYiPEiSvGcadYVlryL1yjL726IBigVjac1atYCJvCyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=RZWe37SK; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dcdf60427so1326881e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 12:13:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770754432; cv=none;
        d=google.com; s=arc-20240605;
        b=R7tyhFWfQ6xSvNI2QgcyKhlLh45IILLfUf8JKvXVbEHTqfpKOCWX1mPzaJM8q7L6wh
         0tz5fNTlOGan2Pm/6vFJhzIv0sJA6hcYo3Oo/68RV78PQxAdEkA1dBENCyX+C8unroMP
         XebKciTaXKx1UG9njfot9btbvHMUHA7SKvQqTnXr4jstHrpt4ZPZQTeebMdjuM7vGR65
         0Sd644xzvdn7y7QBDqepwcIO0f3oXFk3RAsULsgUXv2ut+76Gz9epZRqZieuJSZmkEJ5
         9vhOjrAyAE/KJ57A5WDgYsxV0r7HFXQLeqUqa79VzYKrSjQOcDl7lz+YCYnB41jsbL2y
         c/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xE4HPFLV4wxMbDW18a6mpuhV8ULKkz9tZ9KJu12oN84=;
        fh=vA+q66tcR96rC6I0FcNtUFBVrUoz0UCYwpvIRk0miwQ=;
        b=lrDV7yEnITyTUaKCYSy36yYrFAia1kUWW0m7vL8+T+HWH2uKTV9+V4fliaxFKuQ6H9
         WoOvQq3xuxLNplshludzIJVNOxYL5qyAOB89HiW1/tOF8zinw1jpYa3ZNBMC8rmGQob5
         TRoglAzIAvWJVfUl/TeYasVcAKaIah5dpjhclKn39WFS0il7mDsBhGqxgaOLTFBoFPlP
         okwJw8G8W+4Cd/I4O3VVykJoHQu6ezchNeEXxx2Ow/TE/EBX8ZCfyl1fI6pKK4jWF9T/
         WGlNS0E4XC7AN+wISxQw8eesXVMlcO0zHwGkBGMJ9OTd+c5fQyZbvZEa8MTW+LqRNgWx
         qJww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770754432; x=1771359232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xE4HPFLV4wxMbDW18a6mpuhV8ULKkz9tZ9KJu12oN84=;
        b=RZWe37SK6xViLM3Oj8fFqWp9JJBZLznMGAIVpwTUfNZ7/5kU+S1ijKuWUMwCkoc41o
         GtGOTFKiwajaMO2tcevbFxnlGvH+aErwGbE06DdIVKMGBivDetaQtErkqg10M35/TzAi
         hobENGn9q0C8zItIEqjecOaztJVz99Aec57qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770754432; x=1771359232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE4HPFLV4wxMbDW18a6mpuhV8ULKkz9tZ9KJu12oN84=;
        b=LOrtOUlldGQiIVNOPokQ7rYeDe0pWQbQQt7aScJ4Jt+lAzgMtKXmDuH657cU/viMM8
         1C+tPB/fTOWFJiVo+nMEwc8u37/QahmMaQJQrPbdqFx4L2lMQjpHOes1HcZ3l296hiOH
         mo/PZ40HlhWyrMBXQhxVlGturHz3gXSJeTCC/ZgZSybBf76sPwaT0u12/3myHbfimbvL
         15fac49RtPT+y81ZQ05nmh6UMgk5BtXIBZ71ziLKAwHCmbB5wwuuxEBM4HlPhe1jOgCj
         SeWpRa5XYr1v6d5wxLgQMVxgoRz2Mpk8Y852dhmrr/0tMOo5tJtixtgpUWhlsOdgeQ1f
         3zbw==
X-Forwarded-Encrypted: i=1; AJvYcCVuGXSKymi3EDyJf42I3ooH1/5uLzgUlWZ9kRP/oPQTTnJZhsPBu9iQ8ORrCIpIOJ/KnTdAXCGZ7AxCW8Np@vger.kernel.org
X-Gm-Message-State: AOJu0YyneASMsZr4LoKVanpW//B7jG6z/ZteYaGQq3o+e6WIbU6mGJhw
	yJY5wqDzWmOHB1t+JX9tr1H4t2dJyK3hzHJCBXSbf3xCH5wy+3FpKxy6CZuwwt6WxxDFotR/Da4
	GrGbiBBFvcsuPDGdBZpSYMlsNIAiT5SC3cRNfPRTt/Q==
X-Gm-Gg: AZuq6aIQyzide8BZHWy6CFlkXgTTParUF4/VsJYDPjdvFV+fMtgj4pqsT+1G4S9qoEs
	2qMcLG12/t8aiRMtXcmqXwYraJp340v8LH2GYhgD1qSabwB084lEbQaZL517dc2EOaejLDMt/6Y
	+QencNPKtNzpcb6NvglQreJQRxBJBbMRNvefbVfrEhOLkudh0tkVdPzKCBmEyuPz3IX5EBsLZ3z
	5+TaNC8AQAtNRx9la8UayqbMOLoJvu4U886tobSJmTqQpdaE+mA54/h2ZYha+mWUtKJuQ9EYQuA
	BisnSclp4kKPEW7xjcBl2uYHiq16jhOvN4Iwka4=
X-Received: by 2002:a05:6512:2391:b0:59e:1846:1d83 with SMTP id
 2adb3069b0e04-59e45159f85mr5082195e87.28.1770754431824; Tue, 10 Feb 2026
 12:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com> <20260209190605.1564597-3-avagin@google.com>
In-Reply-To: <20260209190605.1564597-3-avagin@google.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 10 Feb 2026 21:13:39 +0100
X-Gm-Features: AZwV_QhjVYT6qDnfaDJCVklCsmeouFRZOW5DUXZzIAeF4nFNqiJH8NjGgTgoV-0
Message-ID: <CAJqdLrogefL5ZkxJfbQ75u45BFFJxttJd1V4yf=KUPxdHg7ocg@mail.gmail.com>
Subject: Re: [PATCH 2/4] exec: inherit HWCAPs from the parent process
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76885-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mihalicyn.com:dkim,mail.gmail.com:mid,futurfusion.io:email]
X-Rspamd-Queue-Id: 2D5D411EEC3
X-Rspamd-Action: no action

Am Mo., 9. Feb. 2026 um 20:06 Uhr schrieb Andrei Vagin <avagin@google.com>:
>
> Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> AT_HWCAP2, etc.) from a parent process when they have been modified via
> prctl.
>
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster.
>
> This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
> execve() is called, if the current process has MMF_USER_HWCAP set, the
> HWCAP values are extracted from the current auxiliary vector and stored
> in the linux_binprm structure. These values are then used to populate
> the auxiliary vector of the new process, effectively inheriting the
> hardware capabilities.
>
> The inherited HWCAPs are masked with the hardware capabilities supported
> by the current kernel to ensure that we don't report more features than
> actually supported. This is important to avoid unexpected behavior,
> especially for processes with additional privileges.
>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Cool stuff, LGTM!

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  fs/binfmt_elf.c          |  8 +++---
>  fs/binfmt_elf_fdpic.c    |  8 +++---
>  fs/exec.c                | 61 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/binfmts.h  | 11 ++++++++
>  include/linux/mm_types.h |  2 ++
>  kernel/fork.c            |  3 ++
>  kernel/sys.c             |  5 +++-
>  7 files changed, 89 insertions(+), 9 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 3eb734c192e9..aec129e33f0b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -246,7 +246,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>          */
>         ARCH_DLINFO;
>  #endif
> -       NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> +       NEW_AUX_ENT(AT_HWCAP, bprm->hwcap);
>         NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>         NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>         NEW_AUX_ENT(AT_PHDR, phdr_addr);
> @@ -264,13 +264,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>         NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>         NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>  #ifdef ELF_HWCAP2
> -       NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +       NEW_AUX_ENT(AT_HWCAP2, bprm->hwcap2);
>  #endif
>  #ifdef ELF_HWCAP3
> -       NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +       NEW_AUX_ENT(AT_HWCAP3, bprm->hwcap3);
>  #endif
>  #ifdef ELF_HWCAP4
> -       NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> +       NEW_AUX_ENT(AT_HWCAP4, bprm->hwcap4);
>  #endif
>         NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>         if (k_platform) {
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index a3d4e6973b29..55b482f03c82 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -629,15 +629,15 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>          */
>         ARCH_DLINFO;
>  #endif
> -       NEW_AUX_ENT(AT_HWCAP,   ELF_HWCAP);
> +       NEW_AUX_ENT(AT_HWCAP,   bprm->hwcap);
>  #ifdef ELF_HWCAP2
> -       NEW_AUX_ENT(AT_HWCAP2,  ELF_HWCAP2);
> +       NEW_AUX_ENT(AT_HWCAP2,  bprm->hwcap2);
>  #endif
>  #ifdef ELF_HWCAP3
> -       NEW_AUX_ENT(AT_HWCAP3,  ELF_HWCAP3);
> +       NEW_AUX_ENT(AT_HWCAP3,  bprm->hwcap3);
>  #endif
>  #ifdef ELF_HWCAP4
> -       NEW_AUX_ENT(AT_HWCAP4,  ELF_HWCAP4);
> +       NEW_AUX_ENT(AT_HWCAP4,  bprm->hwcap4);
>  #endif
>         NEW_AUX_ENT(AT_PAGESZ,  PAGE_SIZE);
>         NEW_AUX_ENT(AT_CLKTCK,  CLOCKS_PER_SEC);
> diff --git a/fs/exec.c b/fs/exec.c
> index 9d5ebc9d15b0..7401efbe4ba0 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1462,6 +1462,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
>          */
>         bprm->is_check = !!(flags & AT_EXECVE_CHECK);
>
> +       bprm->hwcap = ELF_HWCAP;
> +#ifdef ELF_HWCAP2
> +       bprm->hwcap2 = ELF_HWCAP2;
> +#endif
> +#ifdef ELF_HWCAP3
> +       bprm->hwcap3 = ELF_HWCAP3;
> +#endif
> +#ifdef ELF_HWCAP4
> +       bprm->hwcap4 = ELF_HWCAP4;
> +#endif
> +
>         retval = bprm_mm_init(bprm);
>         if (!retval)
>                 return bprm;
> @@ -1780,6 +1791,53 @@ static int bprm_execve(struct linux_binprm *bprm)
>         return retval;
>  }
>
> +static void inherit_hwcap(struct linux_binprm *bprm)
> +{
> +       int i, n;
> +
> +#ifdef ELF_HWCAP4
> +       n = 4;
> +#elif defined(ELF_HWCAP3)
> +       n = 3;
> +#elif defined(ELF_HWCAP2)
> +       n = 2;
> +#else
> +       n = 1;
> +#endif
> +
> +       for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
> +               long val = current->mm->saved_auxv[i + 1];
> +
> +               switch (current->mm->saved_auxv[i]) {
> +               case AT_NULL:
> +                       goto done;
> +               case AT_HWCAP:
> +                       bprm->hwcap = val & ELF_HWCAP;
> +                       break;
> +#ifdef ELF_HWCAP2
> +               case AT_HWCAP2:
> +                       bprm->hwcap2 = val & ELF_HWCAP2;
> +                       break;
> +#endif
> +#ifdef ELF_HWCAP3
> +               case AT_HWCAP3:
> +                       bprm->hwcap3 = val & ELF_HWCAP3;
> +                       break;
> +#endif
> +#ifdef ELF_HWCAP4
> +               case AT_HWCAP4:
> +                       bprm->hwcap4 = val & ELF_HWCAP4;
> +                       break;
> +#endif
> +               default:
> +                       continue;
> +               }
> +               n--;
> +       }
> +done:
> +       mm_flags_set(MMF_USER_HWCAP, bprm->mm);
> +}
> +
>  static int do_execveat_common(int fd, struct filename *filename,
>                               struct user_arg_ptr argv,
>                               struct user_arg_ptr envp,
> @@ -1856,6 +1914,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>                              current->comm, bprm->filename);
>         }
>
> +       if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +               inherit_hwcap(bprm);
> +
>         retval = bprm_execve(bprm);
>  out_free:
>         free_bprm(bprm);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 65abd5ab8836..94a3dcf9b1d2 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_BINFMTS_H
>  #define _LINUX_BINFMTS_H
>
> +#include <linux/elf.h>
>  #include <linux/sched.h>
>  #include <linux/unistd.h>
>  #include <asm/exec.h>
> @@ -67,6 +68,16 @@ struct linux_binprm {
>         unsigned long exec;
>
>         struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
> +       unsigned long hwcap;
> +#ifdef ELF_HWCAP2
> +       unsigned long hwcap2;
> +#endif
> +#ifdef ELF_HWCAP3
> +       unsigned long hwcap3;
> +#endif
> +#ifdef ELF_HWCAP4
> +       unsigned long hwcap4;
> +#endif
>
>         char buf[BINPRM_BUF_SIZE];
>  } __randomize_layout;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 78950eb8926d..68c9131dceee 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1871,6 +1871,8 @@ enum {
>  #define MMF_TOPDOWN            31      /* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK       BIT(MMF_TOPDOWN)
>
> +#define MMF_USER_HWCAP         32      /* user-defined HWCAPs */
> +
>  #define MMF_INIT_LEGACY_MASK   (MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>                                  MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>                                  MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..0091315643de 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1103,6 +1103,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>
>                 __mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
>                 mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
> +
> +               if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +                       mm_flags_set(MMF_USER_HWCAP, mm);
>         } else {
>                 __mm_flags_overwrite_word(mm, default_dump_filter);
>                 mm->def_flags = 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8d199cf457ae..6fbd7be21a5f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>          * not introduce additional locks here making the kernel
>          * more complex.
>          */
> -       if (prctl_map.auxv_size)
> +       if (prctl_map.auxv_size) {
>                 memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
> +               mm_flags_set(MMF_USER_HWCAP, current->mm);
> +       }
>
>         mmap_read_unlock(mm);
>         return 0;
> @@ -2190,6 +2192,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>
>         task_lock(current);
>         memcpy(mm->saved_auxv, user_auxv, len);
> +       mm_flags_set(MMF_USER_HWCAP, current->mm);

nit: s/current->mm/mm/

There is no issue, because this function assumes mm == current->mm implicitly.

Maybe we should get rid of (struct mm_struct *mm) argument here? (not
a suggestion for change
of this patch, but just mentioning it here).

LGTM!

>         task_unlock(current);
>
>         return 0;
> --
> 2.53.0.239.g8d8fc8a987-goog
>

