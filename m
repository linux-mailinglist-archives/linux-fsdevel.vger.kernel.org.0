Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CF1809BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 21:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCJU6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 16:58:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47079 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJU6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:58:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id a22so15343927oid.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/UHe/Z2KYMMhMaL8b+qDKyko05KbGSgYzdkzaqTp1Q=;
        b=f3d2SeYQpgVLrJGn+2fJsyTeZ33RbVfXHprKDGfMDVqGkosVqqxK/2QXtZccWWFuRj
         3H1Vuq4RzFKICAJIacPrBnjEijgIAt06KHj7SPbMytEDqSc2bQCFpebWWEhlsNbb9CQg
         0EENSDiMqajsXSRPNxRgfWg0lSNXm01HzaC2Q189Cu68mrW/BbRm8UCiSyi/wK9LxpS6
         2v8SST6X243GaY75zF1ejIgXl1Ziq9i2BGhV2I5VVTBY9HyN2WhdvxYYHsUo+yxyBCvr
         aBlu3LRwvU/UnCu6xf8M8cmA31C/oA+zYoaj/I7R69+QrHOXlVUvmKSQJ/HHZdO+QW+x
         of0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/UHe/Z2KYMMhMaL8b+qDKyko05KbGSgYzdkzaqTp1Q=;
        b=FI3w3YATcnPSpaPU42IkNfu0OiiXJjNjR5qPum7KMWltFEfhnw0Facr09533n2kLbc
         XesvJXHNXP9oispgrXOmnY2wQDfFr0R/+g75L3FCQOI1Kybmb3dtpHwf0coO61QWWRgV
         EukrnJ6JXgzrdg01z2q4hEmvL06Iw5yavx4HTCo1jBneWaFVj5e4jJWBxAot54ot+GYo
         JVwZzWoc62l9g1UlUDps+q+dfa32wREEXtcbrXK+TUH6IMYfpwK23yHs0FUQtfz6i7am
         XfdTNV/OJNsJkoU83JctOoNTjAHCYmBww+oeiO/FiBHaYJ+vHZTSzFVEvxfEagmItfGh
         KNcA==
X-Gm-Message-State: ANhLgQ0AphNYUHDSib7XGyP5Z3Vzcz1+P1Zf9RRF4kld765mewu0rZTn
        aLva+h5h4FYaEzjgPX9cMkUy+SyALBaHeWzZmRv+dA==
X-Google-Smtp-Source: ADFU+vveR/NtgdKskuKzJj+LjAOU8LqlTlt4FhpeIgNWQrIm7zC/54AAfayNITfGUlBfRAVwDMOppGapffo777LuptY=
X-Received: by 2002:aca:b187:: with SMTP id a129mr2648252oif.175.1583873897432;
 Tue, 10 Mar 2020 13:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB5170EB4427BF5C67EE98FF09E4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87k142lpfz.fsf@x220.int.ebiederm.org> <AM6PR03MB51704206634C009500A8080DE4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <875zfmloir.fsf@x220.int.ebiederm.org> <AM6PR03MB51707ABF20B6CBBECC34865FE4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87v9nmjulm.fsf@x220.int.ebiederm.org> <AM6PR03MB5170B976E6387FDDAD59A118E4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <202003021531.C77EF10@keescook> <20200303085802.eqn6jbhwxtmz4j2x@wittgenstein>
 <AM6PR03MB5170285B336790D3450E2644E4E40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87v9nlii0b.fsf@x220.int.ebiederm.org> <AM6PR03MB5170609D44967E044FD1BE40E4E40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87a74xi4kz.fsf@x220.int.ebiederm.org> <AM6PR03MB51705AA3009B4986BB6EF92FE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y8dqqz.fsf@x220.int.ebiederm.org> <AM6PR03MB517053AED7DC89F7C0704B7DE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB51703B44170EAB4626C9B2CAE4E20@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87tv32cxmf.fsf_-_@x220.int.ebiederm.org> <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <87eeu25y14.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eeu25y14.fsf_-_@x220.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 21:57:50 +0100
Message-ID: <CAG48ez2aYfcwC7Sr6RseFk=PpvLAddcHsVsrTr_AS=jLvUu2KA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] exec: Move cleanup of posix timers on exec out of de_thread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 8, 2020 at 10:39 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> These functions have very little to do with de_thread move them out
> of de_thread an into flush_old_exec proper so it can be more clearly
> seen what flush_old_exec is doing.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index ff74b9a74d34..215d86f77b63 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1189,11 +1189,6 @@ static int de_thread(struct task_struct *tsk)
>         /* we have changed execution domain */
>         tsk->exit_signal = SIGCHLD;
>
> -#ifdef CONFIG_POSIX_TIMERS
> -       exit_itimers(sig);
> -       flush_itimer_signals();
> -#endif
> -
>         BUG_ON(!thread_group_leader(tsk));
>         return 0;
>
> @@ -1277,6 +1272,11 @@ int flush_old_exec(struct linux_binprm * bprm)
>         if (retval)
>                 goto out;
>
> +#ifdef CONFIG_POSIX_TIMERS
> +       exit_itimers(me->signal);
> +       flush_itimer_signals();
> +#endif

nit: exit_itimers() has a comment referring to de_thread, that should
probably be updated
