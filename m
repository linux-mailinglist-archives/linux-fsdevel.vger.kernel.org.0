Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8910356A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 08:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKTHoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 02:44:01 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44699 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTHoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:44:01 -0500
Received: by mail-il1-f196.google.com with SMTP id i6so1196822ilr.11;
        Tue, 19 Nov 2019 23:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkQsYkZTBURdSBu7Km88dbeDD4v2tqzLVxlvJwXXnOc=;
        b=MxFJyVx6PCgpMNt2O04IWjcDOolLOuLR/6AbsAd7e/3bC+tnlNFNdghV28/5eACfYt
         ZbRyLzYtWFtJdIkz/avVtteHcmN+J3vdRPN/l6OqQZ84zvusS8DyBIRqIt3+XQgxY8+Z
         Cd9nsmI6batsaWqIF/8luo2xdkJ3L23jacmiEsT5+JZPkwPb8ueAHQpVYQEXo3GzFczC
         Pl1KNr2sOAIvpvhmIn9GkXTz0mnD1Uh9DJhSRW30FkQZayi3kagKP+0Dgc2qGAnnqSHm
         8J/JgQ2f0xqLmGTrn6wIsm4Y8MkYF61DHDeh4lNgn25lvTtsbJxR1l9gw2AyjMGMreGQ
         0L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkQsYkZTBURdSBu7Km88dbeDD4v2tqzLVxlvJwXXnOc=;
        b=HqrtLkMEF34eBKXiJtuDVqI2qmYDfQXnlW8UBvKo+QNFWlNw4D7a5KGrlspRKu47DN
         lV6ulcVrnc3Ssec0Qh6PPETH/fo/YAoIO8hhXQebsbCK7/CZCczjXBbISk4EODI4PqsQ
         RWJEfxDGlFGu/p9YTzKtc09utNe4rBGiBB4FvqTth8q+VyHmbGPlThPTE1DmcevYKPQZ
         g7IdTh+qBlRtDjfaX2EC5ooeH1QdXV7/Pi5HYPFUZrmNwt3ToW2eC/RSAd+njgqzQb1f
         0vexfssj5nOY3JdGSYiBmZZ9ElgEJO+yW8MK1RhMxNe2zyNYmTCGXSC95ZAmcuOaWPBJ
         nhBQ==
X-Gm-Message-State: APjAAAVpoWC0t4kzYUqIgcKyygJCuXFUk/l0k8HxxPHHnKXzinmVFT/1
        tV9KhkQIu3nLvNoXpMq/4afvWn+wdNf28MfwruM=
X-Google-Smtp-Source: APXvYqzNksFY5wJfyJHnWvllXmrch0W6oTDjaDq5IVkhokY3fvgAPZkK2jYw6g6gMnJBNSvLZsU/tgMYfVY182IULmk=
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr2012169ilq.272.1574235839220;
 Tue, 19 Nov 2019 23:43:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573788882.git.yu.c.chen@intel.com> <5dcd6580b51342c0803db6bc27866dd569914b0d.1573788882.git.yu.c.chen@intel.com>
 <20191115092420.GF18929@zn.tnic> <CADjb_WR_DNAR_4jVEJ1C4LO7Xfnc54J2u2AoqyCjZT39+AhrWA@mail.gmail.com>
 <20191118144807.GE6363@zn.tnic>
In-Reply-To: <20191118144807.GE6363@zn.tnic>
From:   Yu Chen <yu.chen.surf@gmail.com>
Date:   Wed, 20 Nov 2019 15:54:46 +0800
Message-ID: <CADjb_WQVa0rFb0BXtu4xU7RfywUa36kLDgGLpLmUWifnLB2NAA@mail.gmail.com>
Subject: Re: [PATCH 2/2][v2] x86/resctrl: Add task resctrl information display
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Shakeel Butt <shakeelb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Boris,

On Mon, Nov 18, 2019 at 10:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Nov 16, 2019 at 11:01:12PM +0800, Ryan Chen wrote:
> > Right, we can return 'blank' to user and let the user to parse the information.
>
> There is nothing to parse - the task doesn't belong to any groups. That's it.
>
> > And there is a similar behavior in cgroup that, for kernel thread that
> > does not belong
> > to any cgroup, /proc/{pid}/cgroup just show 'blank' without returning an error.
>
> By 'blank' I assume you mean the empty string '' ?
>
Yes, it is 'empty string'.
> > Yes, only when PROC_FS is set, /proc/{pid}/resctrl
> > can be displayed. However, CPU_RESCTRL might not
> > depend on proc fs, it is possible that the CPU_RESCTRL
> > is enabled but without PROC_FS set. If I understand correctly,
> >  CPU_RESCTRL is the 'root' config for X86_CPU_RESCTRL,
> > after reading this thread:
> > https://lists.gt.net/linux/kernel/3211659
>
> I'm not sure I know what you mean here. There's no CPU_RESCTRL option - you've
> added it in the previous patch:
>
> [ ~/kernel/linux> git grep -E CONFIG_CPU_RESCTRL
> [ ~/kernel/linux> git grep -E "\WCPU_RESCTRL"
> [ ~/kernel/linux>
>
> And if you want to use that option in proc/, then it needs
> to depend on PROC_FS, like the the example I gave you with
> CONFIG_PROC_PID_ARCH_STATUS.
>
> Or do you mean something else?
>
Previously I was thinking of introducing CONFIG_CPU_RESCTRL
to the kernel, so that platform-independent resctrl code could be moved under
this config. The idea was seen in the following commit log:
commit e6d429313ea5c776d (x86/resctrl: Avoid confusion over the
new X86_RESCTRL config)
But since we only touch proc fs in this patch, I think a config named
CONFIG_PROC_CPU_RESCTRL declared in fs/proc/Kconfig
might be more appropriate(similar to CONFIG_PROC_PID_ARCH_STATUS).
> >  If this is the case, shall we add the new file at kernel/resctrl/resctrl.c?
> > And the generic proc_resctrl_show() could be put into this file. In the future
> > the generic code for resctrl could be added/moved to kernel/resctrl/resctrl.c
>
> Not worth it for a single function. Leave it in
> arch/x86/kernel/cpu/resctrl/rdtgroup.c where you had it.
>
Okay, got it. Let me send the v3 patch out and to see if it is suitable.
Thanks,
Chenyu
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
