Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872BA158248
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgBJS3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgBJS3h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:29:37 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB24020873
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359377;
        bh=75Y6o+R2RT1l2imBwb+jNktBnqH/sCmtNtwqXoR4Pes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EF8eHmVaJ5TifBzp1HvD/JNbwlvbm/aA4/9GdfxXGs3EBE23gGR5jRMoWysBmEhEv
         bM6+LM746QhXKsuJTk3aLNyym1Qk1hyrZeoazQHonF+iT4ek20ZURTP7yQAWWJKVQT
         HDcYXHCPea9x7ocZPOeejOQ7WIoXpvg6lSfHI8Z8=
Received: by mail-wr1-f48.google.com with SMTP id y17so9040085wrh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:29:36 -0800 (PST)
X-Gm-Message-State: APjAAAUjM2dzaozwjKy0mBfZPqvE/WHbFQUCVKQ01GwLJw36o4EVHe1i
        ImF4SM0UqeQhGzyfdC7BIXG9ipV6r4UNt96/U48Kog==
X-Google-Smtp-Source: APXvYqxWu0bxr7kTaxx7yZUgmkxyJ8dLufVkbPuDhZYClHKf5Jt0/P1jTw5e62T+H/SIPu7YOj0kdetnzt7Dw9LkXbw=
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr3278410wrt.70.1581359375255;
 Mon, 10 Feb 2020 10:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-11-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-11-gladkov.alexey@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 10:29:23 -0800
X-Gmail-Original-Message-ID: <CALCETrWOXXYy5fo+D0wVBEviyk38ACqvO5Fep_oTEY6+UrS=4g@mail.gmail.com>
Message-ID: <CALCETrWOXXYy5fo+D0wVBEviyk38ACqvO5Fep_oTEY6+UrS=4g@mail.gmail.com>
Subject: Re: [PATCH v8 10/11] docs: proc: add documentation for "hidepid=4"
 and "subset=pidfs" options and new mount behavior
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  Documentation/filesystems/proc.txt | 53 ++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 99ca040e3f90..4741fd092f36 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -50,6 +50,8 @@ Table of Contents
>    4    Configuring procfs
>    4.1  Mount options
>
> +  5    Filesystem behavior
> +
>  ------------------------------------------------------------------------------
>  Preface
>  ------------------------------------------------------------------------------
> @@ -2021,6 +2023,7 @@ The following mount options are supported:
>
>         hidepid=        Set /proc/<pid>/ access mode.
>         gid=            Set the group authorized to learn processes information.
> +       subset=         Show only the specified subset of procfs.
>
>  hidepid=0 means classic mode - everybody may access all /proc/<pid>/ directories
>  (default).
> @@ -2042,6 +2045,56 @@ information about running processes, whether some daemon runs with elevated
>  privileges, whether other user runs some sensitive program, whether other users
>  run any program at all, etc.
>
> +hidepid=4 means that procfs should only contain /proc/<pid>/ directories
> +that the caller can ptrace.

I have a couple of minor nits here.

First, perhaps we could stop using magic numbers and use words.
hidepid=ptraceable is actually comprehensible, whereas hidepid=4
requires looking up what '4' means.

Second, there is PTRACE_MODE_ATTACH and PTRACE_MODE_READ.  Which is it?

> +
>  gid= defines a group authorized to learn processes information otherwise
>  prohibited by hidepid=.  If you use some daemon like identd which needs to learn
>  information about processes information, just add identd to this group.

How is this better than just creating an entirely separate mount a
different hidepid and a different gid owning it?  In any event,
usually gid= means that this gid is the group owner of inodes.  Let's
call it something different.  gid_override_hidepid might be credible.
But it's also really weird -- do different groups really see different
contents when they read a directory?
