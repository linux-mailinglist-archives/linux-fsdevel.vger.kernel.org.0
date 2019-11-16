Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C096FECC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfKPPB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 10:01:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43351 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKPPB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:01:26 -0500
Received: by mail-io1-f67.google.com with SMTP id r2so8599443iot.10;
        Sat, 16 Nov 2019 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70Jvx3vkhwPfIehKPa34OVbS25rHZjyV2djtKv+JlWE=;
        b=H7PIYRUDbc6WJrQp87zP4xTZ/29c7hX5O8LQqbCOEYR2zJZEYNBl8zkRUyMIgVAGMP
         KfkuHKN00XyfOle2o8EkV9sQSg9zAURlcr4Qm1QreMqvJCeHBPkVCy0WGr2nkjslxjDT
         mPGRxxb0G4WdDYvkHB2kMAnrgMPVkd6npO8qKPnTg+ISRXmGbMttGEZVa7xzjGTJdoLg
         ZfJo7rd+16kzXZBAjZvoz643nqNFKnDnKBlYqH5Jym4gNBJfP5rK6BghgIf8/p81QX40
         fWorpFLbGrrFPj0DOHBqE0CoLZznc2JtrOBXH1acWiVjiEI3/oQAafU9OnLxLXBBCZxx
         wSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70Jvx3vkhwPfIehKPa34OVbS25rHZjyV2djtKv+JlWE=;
        b=CfblOujECdPSIuvtfPBErfD9vBltVfVoMu7+vxKe9aadaWcGihGXt2UP4r6r8Uap28
         tbri+PcleWKOMCoeLFhEgLX+vyPHWG0oLFVQXjkV6Poh9Oz/e1Y/rUo9/clrBaurNJ1h
         kGVYj7KMKnjnf55ajSYRHDjCt+JE16Z2uEQuF9Gox1Jovfei/YeH/13AkxfauNN4thTd
         mL0jLStPgfoFUW9ePIb/oyG5i4St2oIWeimePtaw3rJUxn4CHfqFZm6U8l3NhV4cquBn
         3W774mL6ZSY9tHRITFUAbe9lNwMa3XjSlkZuWujyXQpHbNMptXevZzLTKMnYKl6iksDw
         BK6w==
X-Gm-Message-State: APjAAAXe3El1g9K9q1jnJ4vIPj1e1u/3JwzTnYeS4skw43todYJ87GZB
        9U/0d0qJJ5oxePA9NRdegYMhhpEB+gtD+MRW6Rw=
X-Google-Smtp-Source: APXvYqyhmf37mEXcw5Pd6HR9pfETRRsjLHxtOkhyTkLJwAWAmRFnuKpChj4SNEWrZdHjPE7ik/BGcyZvdI0JFEDYKcg=
X-Received: by 2002:a6b:8bcc:: with SMTP id n195mr5557079iod.135.1573916483656;
 Sat, 16 Nov 2019 07:01:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573788882.git.yu.c.chen@intel.com> <5dcd6580b51342c0803db6bc27866dd569914b0d.1573788882.git.yu.c.chen@intel.com>
 <20191115092420.GF18929@zn.tnic>
In-Reply-To: <20191115092420.GF18929@zn.tnic>
From:   Ryan Chen <yu.chen.surf@gmail.com>
Date:   Sat, 16 Nov 2019 23:01:12 +0800
Message-ID: <CADjb_WR_DNAR_4jVEJ1C4LO7Xfnc54J2u2AoqyCjZT39+AhrWA@mail.gmail.com>
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
On Fri, Nov 15, 2019 at 5:25 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 15, 2019 at 01:25:06PM +0800, Chen Yu wrote:
> > Monitoring tools that want to find out which resctrl CTRL
> > and MONITOR groups a task belongs to must currently read
> > the "tasks" file in every group until they locate the process
> > ID.
> >
> > Add an additional file /proc/{pid}/resctrl to provide this
> > information.
> >
> > For example:
> >  cat /proc/1193/resctrl
> > CTRL_MON:/ctrl_grp0
> > MON:/ctrl_grp0/mon_groups/mon_grp0
> >
> > If the resctrl filesystem has not been mounted,
> > reading /proc/{pid}/resctrl returns an error:
> > cat: /proc/1193/resctrl: No such device
>
> Eww, this doesn't sound very user-friendly. How is the user supposed to
> know that the resctrl fs needs to be mounted for this to work?
>
> Why does the resctrl fs need to be mounted at all to show this?
>
> I'm guessing if it is not mounted, you have no groups so you don't have
> to return an error - you simply return "". Right?
>
Right, we can return 'blank' to user and let the user to parse the information.
And there is a similar behavior in cgroup that, for kernel thread that
does not belong
to any cgroup, /proc/{pid}/cgroup just show 'blank' without returning an error.

> > Tested-by: Jinshi Chen <jinshi.chen@intel.com>
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
>
> When you send a new version which has non-trivial changes, you should
> drop those tags because they don't apply anymore. Unless those people
> have managed to review and test the new version ...
>
Got it, thanks for telling me this.
> Looking at CONFIG_PROC_PID_ARCH_STATUS for an example of proc/ calling
> arch-specific functions, I guess you need to do:
>
> select CPU_RESCTRL if PROC_FS
>
Yes, only when PROC_FS is set, /proc/{pid}/resctrl
can be displayed. However, CPU_RESCTRL might not
depend on proc fs, it is possible that the CPU_RESCTRL
is enabled but without PROC_FS set. If I understand correctly,
 CPU_RESCTRL is the 'root' config for X86_CPU_RESCTRL,
after reading this thread:
https://lists.gt.net/linux/kernel/3211659
 If this is the case, shall we add the new file at kernel/resctrl/resctrl.c?
And the generic proc_resctrl_show() could be put into this file. In the future
the generic code for resctrl could be added/moved to kernel/resctrl/resctrl.c

Thanks,
Chenyu

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
