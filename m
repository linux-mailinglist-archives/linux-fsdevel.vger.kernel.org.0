Return-Path: <linux-fsdevel+bounces-76887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJiGvOWi2kCXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:37:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA311F0D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E148A3042099
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947433291B;
	Tue, 10 Feb 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="CFBdwPFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9832F745
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755817; cv=pass; b=uc7WhZSLIS7pdJZsKw+t56eDk+B7T7QfqdVC1qKSwizGOSFcaMRoWpAWxmol/d24jfd5hI/kENtLpwMWpoXVk8a7l07J4ESVy1KsoCqApNr1o5to4ZzJc+GWAMf/d43jNTCLJlc9vT5TK4d4Jlw36SiDeecffi3M61QmHEBQ66A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755817; c=relaxed/simple;
	bh=ey7h6BYYQrtrrr8rCF85a8/FuLjvnQ7u8djxXUs8qgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEukDdFDPFu5jpQ50bne7778WQe+1HgVE28Q6Q41ixfwtz3huMK+WaUXZ5NbkYAlD3CeThsfL1QDd7qhPsN98HYIqTDLRhOb180M7JtRqZfDZKM7/+MLfGhjnBiybiOhAMeI88DJJS1GkmhjFenyFVKAmCXzdzzrhLZpmwDWIMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=CFBdwPFY; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59dd54b1073so4611089e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 12:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770755814; cv=none;
        d=google.com; s=arc-20240605;
        b=bWrtDPB7MJh54ZCAwu+c3wfHJOKYfWC1Nt95GzKrpsM59soqtea8slW9/dszJXr6C9
         co2F9W2ECIGhldPVkY5NDsqELPYpAYeJW9GubW+39LMgIIuTVKPatJYWWcLnn96Wk2Gn
         CRHP2ckul6yTkA4tqvNxUqii1Okdh5rYSNRBzASsaKZV7oLW7yHw2AJCMLNWpEl+RPsu
         MmXa0NRQJuebas090MXDuQe7ILE0YVu35xUuByUNegVRqhjGPmM+KDV4+dfEqxVK82qF
         qh7eVZa4IrzfY0Dc+j/yyzOTY8KChoGh2kCUC9R30K4b3KqX/jIiIocVeqbAewmNr3lG
         X/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/RVEjU7kEYe1QZq8m5Yk/boKMRnRFHVBS46XFdmJlx8=;
        fh=JjAulbV9As1EAXcFOcqR9JLrvzQggguzS03zBgzVRuY=;
        b=Rv97Hrhb66DkfK6Bbe78Te/3ocUj901LIuQA1K2I5Qr1Z2xlgK/GxoIW1N70vbBJQb
         7LSqKq3jCuBegEiESaiP4d6MpipSy/cwHeSZzYWhCsdgAu1Rx/sqZQlMwSfxd37Kofpq
         06WoqVpRWdufgBIjZlvywyAQuj9lH5ckE0NJ8SgJZf7mIIPd1lYn1NHl9KVn6qbNIxO5
         LQaIFj4f9t/XRukamIs3s5jbM4+fCNYM0UzYcF0t3oAdvZVevsb64EAtuymShFcQAlkB
         Ohfk3KJVRXyI2txxWiMBdHcn17wrTyUZWBSxwtBodn3zuoewxdinqsX5v7PySWaKF9qz
         wtIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770755814; x=1771360614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RVEjU7kEYe1QZq8m5Yk/boKMRnRFHVBS46XFdmJlx8=;
        b=CFBdwPFY6n/Mulx7895ZXhD3a03SN8YFIDLzIivQkRDsiB50ac64mXF6vGyLP1lsb/
         xO/BeAuTlIN2N1/SKb5K0ELnTMssSiryfUq7yE6SGk21LASVyozQcOuVkmH3+ULYdCnc
         xez1Gg5lbKd4oyn+Fb1nfKit5pTPHgbBFsYhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770755814; x=1771360614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RVEjU7kEYe1QZq8m5Yk/boKMRnRFHVBS46XFdmJlx8=;
        b=qKo7IyebrsAQUAPzNr/KFxSQIXSLQzhomUVCrUCjToGjkwiAmqa8bkKH2KjU/TCrVs
         Hv4FXlO2DdIo1IMtDs5jtOyVlClCC2sAbMXlfTeLCcIKHVfjFzzrBPRsPG6WwDKPjV5X
         E1dALTHhFmj5fmY2oy/EChWmvRnF3T2uLOf6TFSNOE1IRquQPv9Yd8RLsQMfRFy8TdlM
         F0KapYJYb6tNuRrRuBZxG4AdOoJbfbN/wJZHNQ6hzOcEVoKnbq1gXju4tvju1tczZApa
         s/Ax2gAVxNyBqcwKEkDVSjVk966JVtXVPCw716xxIBT0w/ctWI0sUV6O4YTvmGUoY0TG
         ya6g==
X-Forwarded-Encrypted: i=1; AJvYcCV5rolP91OEMwC2k0Cp5Mgjq5v2+YSNLTV/jDARBKaR60EmxCJWvnuDPNW9zMXsoO34i2Nyw/c7domM34dZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5GlIfCXH8cnPRuBBixFpQ8gEigHmepYOa6gX1B/qOWfW88Cj
	HYeL1ZIpphJGtbAdCC1MIQGBsyTJixmpEpKFlADMg/NbuK0TAdP0hA2vNkpDBsQcwAzYJB1c0do
	cSp/flUxN9uWHnTwqcK9vR9HNSFN/wGlJWC1T2Cs6jg==
X-Gm-Gg: AZuq6aJdQOh6pmEFIDEeC6s7kL+qXxQTtH+KyNobXCXiXnQjNdHI6MrzhrGQa9EBqIk
	Qdk6j53IjwUQU/1aodXtx9o9oS7yWLG3bUpX7c7XdpChJbr9HQqnKQSX/ThjHte7lW9MebgMy4r
	hY5YFOUN5ZwzbTXs/Nwz/K1r/432N1RImgGbkvQQ6drgpZi/EhxjCNvLo9p9QsRaEx6W/TnpxLW
	9/yWyqYu+NLcBlFoOg9ovhh2WdOcd2UYfPDDOK93gKWC5niD+qCKLh6v6zqSxyXqe8Y2ZqAlSHX
	l6fcGQaiatH3AQwQ/z0O6ByGy5WmQNzxvucZqME=
X-Received: by 2002:a05:6512:1301:b0:59e:1a8:5e86 with SMTP id
 2adb3069b0e04-59e5c3f991amr134928e87.41.1770755808592; Tue, 10 Feb 2026
 12:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com> <20260209190605.1564597-4-avagin@google.com>
In-Reply-To: <20260209190605.1564597-4-avagin@google.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 10 Feb 2026 21:36:36 +0100
X-Gm-Features: AZwV_QgjfoRdQrlUqWSC4XnkqPkyYSWTA1P5z4cr4cHfm0maV7oMuAR0P9Khr8M
Message-ID: <CAJqdLrqFJm5s4qgczWUi50muoMbUm7tbDZ4vTp=3ktEDYoi7wA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76887-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEFA311F0D1
X-Rspamd-Action: no action

Am Mo., 9. Feb. 2026 um 20:06 Uhr schrieb Andrei Vagin <avagin@google.com>:
>
> The mm->saved_auxv array stores the auxiliary vector, which can be
> modified via prctl(PR_SET_MM_AUXV) or prctl(PR_SET_MM_MAP). Previously,
> accesses to saved_auxv were not synchronized. This was a intentional
> trade-off, as the vector was only used to provide information to
> userspace via /proc/PID/auxv or prctl(PR_GET_AUXV), and consistency
> between the auxv values left to userspace.
>
> With the introduction of hardware capability (HWCAP) inheritance during
> execve, the kernel now relies on the contents of saved_auxv to configure
> the execution environment of new processes.  An unsynchronized read
> during execve could result in a new process inheriting an inconsistent
> set of capabilities if the parent process updates its auxiliary vector
> concurrently.
>
> While it is still not strictly required to guarantee the consistency of
> auxv values on the kernel side, doing so is relatively straightforward.
> This change implements synchronization using arg_lock.
>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  fs/exec.c      |  8 ++++++--
>  fs/proc/base.c | 12 +++++++++---
>  kernel/fork.c  |  7 ++++++-
>  kernel/sys.c   | 29 ++++++++++++++---------------
>  4 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 7401efbe4ba0..d7e3ad8c8051 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1793,6 +1793,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>
>  static void inherit_hwcap(struct linux_binprm *bprm)
>  {
> +       struct mm_struct *mm = current->mm;
>         int i, n;
>
>  #ifdef ELF_HWCAP4
> @@ -1805,10 +1806,12 @@ static void inherit_hwcap(struct linux_binprm *bprm)
>         n = 1;
>  #endif
>
> +       spin_lock(&mm->arg_lock);
>         for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
> -               long val = current->mm->saved_auxv[i + 1];
> +               unsigned long type = mm->saved_auxv[i];
> +               unsigned long val = mm->saved_auxv[i + 1];
>
> -               switch (current->mm->saved_auxv[i]) {
> +               switch (type) {
>                 case AT_NULL:
>                         goto done;
>                 case AT_HWCAP:
> @@ -1835,6 +1838,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
>                 n--;
>         }
>  done:
> +       spin_unlock(&mm->arg_lock);
>         mm_flags_set(MMF_USER_HWCAP, bprm->mm);
>  }
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 4eec684baca9..09d887741268 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1083,14 +1083,20 @@ static ssize_t auxv_read(struct file *file, char __user *buf,
>  {
>         struct mm_struct *mm = file->private_data;
>         unsigned int nwords = 0;
> +       unsigned long saved_auxv[AT_VECTOR_SIZE];
>
>         if (!mm)
>                 return 0;
> +
> +       spin_lock(&mm->arg_lock);
> +       memcpy(saved_auxv, mm->saved_auxv, sizeof(saved_auxv));
> +       spin_unlock(&mm->arg_lock);
> +
>         do {
>                 nwords += 2;
> -       } while (mm->saved_auxv[nwords - 2] != 0); /* AT_NULL */
> -       return simple_read_from_buffer(buf, count, ppos, mm->saved_auxv,
> -                                      nwords * sizeof(mm->saved_auxv[0]));
> +       } while (saved_auxv[nwords - 2] != 0); /* AT_NULL */
> +       return simple_read_from_buffer(buf, count, ppos, saved_auxv,
> +                                      nwords * sizeof(saved_auxv[0]));
>  }
>
>  static const struct file_operations proc_auxv_operations = {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0091315643de..c0a3dd94df22 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1104,8 +1104,13 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>                 __mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
>                 mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
>
> -               if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +               if (mm_flags_test(MMF_USER_HWCAP, current->mm)) {
> +                       spin_lock(&current->mm->arg_lock);
>                         mm_flags_set(MMF_USER_HWCAP, mm);
> +                       memcpy(mm->saved_auxv, current->mm->saved_auxv,
> +                              sizeof(mm->saved_auxv));

nit: I was looking for this memcpy(mm->saved_auxv,
current->mm->saved_auxv, sizeof(mm->saved_auxv)) while reviewing
a previous patch. Shouldn't it be there?

LGTM.

> +                       spin_unlock(&current->mm->arg_lock);
> +               }
>         } else {
>                 __mm_flags_overwrite_word(mm, default_dump_filter);
>                 mm->def_flags = 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 6fbd7be21a5f..eafb5f75cb5c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2147,20 +2147,11 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>         mm->arg_end     = prctl_map.arg_end;
>         mm->env_start   = prctl_map.env_start;
>         mm->env_end     = prctl_map.env_end;
> -       spin_unlock(&mm->arg_lock);
> -
> -       /*
> -        * Note this update of @saved_auxv is lockless thus
> -        * if someone reads this member in procfs while we're
> -        * updating -- it may get partly updated results. It's
> -        * known and acceptable trade off: we leave it as is to
> -        * not introduce additional locks here making the kernel
> -        * more complex.
> -        */
>         if (prctl_map.auxv_size) {
> -               memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>                 mm_flags_set(MMF_USER_HWCAP, current->mm);
> +               memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>         }
> +       spin_unlock(&mm->arg_lock);
>
>         mmap_read_unlock(mm);
>         return 0;
> @@ -2190,10 +2181,10 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>
>         BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
>
> -       task_lock(current);
> -       memcpy(mm->saved_auxv, user_auxv, len);
> +       spin_lock(&mm->arg_lock);
>         mm_flags_set(MMF_USER_HWCAP, current->mm);
> -       task_unlock(current);
> +       memcpy(mm->saved_auxv, user_auxv, len);
> +       spin_unlock(&mm->arg_lock);
>
>         return 0;
>  }
> @@ -2466,9 +2457,17 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
>  static int prctl_get_auxv(void __user *addr, unsigned long len)
>  {
>         struct mm_struct *mm = current->mm;
> +       unsigned long auxv[AT_VECTOR_SIZE];
>         unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
>
> -       if (size && copy_to_user(addr, mm->saved_auxv, size))
> +       if (!size)
> +               return sizeof(mm->saved_auxv);
> +
> +       spin_lock(&mm->arg_lock);
> +       memcpy(auxv, mm->saved_auxv, size);
> +       spin_unlock(&mm->arg_lock);
> +
> +       if (copy_to_user(addr, auxv, size))
>                 return -EFAULT;
>         return sizeof(mm->saved_auxv);
>  }
> --
> 2.53.0.239.g8d8fc8a987-goog
>

