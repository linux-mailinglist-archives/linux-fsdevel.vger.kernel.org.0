Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63E3193000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 19:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYSAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 14:00:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38751 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCYSAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:00:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so3818965wmi.3;
        Wed, 25 Mar 2020 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2vECe2orURQBDgSGUswq0Em3Lt1cG8LhmyDWMenie4=;
        b=pcB8/P4NNmGc9jdx2cKv4xLm0LYKUe/enar+zNO7y4vivuI8tC96COsdPMsSERrJYl
         8PVqD0Ryt1WAvO9bHnakhvnUfsIgChkC7qbdx86g7WKZuyOUA3mnnQ+he6x9gSy+4cpx
         c6Q6vhS8Mm4rJylbtRie9w3bHOiCVzrhIRvJEdtRumQ5g7sTuldciIcsSt+D//krTaVi
         VwHm1SINNqM+sRZows4xI9xhUJ9uh1lwV4NKyK/Ng5sr3WIS2jMszdmOFH+lEufdeQxy
         yKgiUcMYDK6gAYDYTJBA3p14X99t6sm/bK7aD6+jXW/YVjBnPSxkU4iCFIq5tDotccO5
         IGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2vECe2orURQBDgSGUswq0Em3Lt1cG8LhmyDWMenie4=;
        b=TcSH5A6/97JRlRPCmaJ8jynyv8j2g2TLuWBBso7yKok0vJP78KyUSTEqFiux4JFbhY
         4/QhAG2jk6jrP7MSU6nhIi99yACOwjf+Hv+5GFq2zWj6m+/9dacjtq18qGB8dOvWtinh
         Uzkq5xtkzBrlAHV798RS6U6xSGzv7Aeh1xFzdbNHb6j8X9eZAFmKXeXQGNbMA8JDXEPt
         R10oF7J1yHPcpaTBgZO6F9VQcH3G1MQ1T4JHbSV1t7Sfr5mftvbLrjQ5+9Q2cNoAi9Ya
         0Q89jUb5Oh571kbQ+2I7whLueIj/8lmDTBaWw9ruoPsme7QLvo6P2yvvdvvXe7WG81Uv
         P7pA==
X-Gm-Message-State: ANhLgQ0GgDWwQd2V+OTfVWeaHQsJEIagg3y7FNXzjMtPxvXKrcLzF2Bu
        EIf+wl/VrXToP88imKr9PQ==
X-Google-Smtp-Source: ADFU+vskQBpU1fwag571AUWx4l8lwesSLXv4/Nn4D9x3DELZa5yjkr7FUq1vp/cSRcIq8i0IZhnnuQ==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr4697972wmj.170.1585159219122;
        Wed, 25 Mar 2020 11:00:19 -0700 (PDT)
Received: from avx2 ([46.53.251.45])
        by smtp.gmail.com with ESMTPSA id y200sm10085730wmc.20.2020.03.25.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 11:00:18 -0700 (PDT)
Date:   Wed, 25 Mar 2020 21:00:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Gladkov <legion@kernel.org>,
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
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RESEND v9 3/8] proc: move hide_pid, pid_gid from
 pid_namespace to proc_fs_info
Message-ID: <20200325180015.GA18706@avx2>
References: <20200324204449.7263-1-gladkov.alexey@gmail.com>
 <20200324204449.7263-4-gladkov.alexey@gmail.com>
 <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:21:59PM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 1:46 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >
> > +/* definitions for hide_pid field */
> > +enum {
> > +       HIDEPID_OFF       = 0,
> > +       HIDEPID_NO_ACCESS = 1,
> > +       HIDEPID_INVISIBLE = 2,
> > +};
> 
> Should this enum be named...
> 
> >  struct proc_fs_info {
> >         struct pid_namespace *pid_ns;
> >         struct dentry *proc_self;        /* For /proc/self */
> >         struct dentry *proc_thread_self; /* For /proc/thread-self */
> > +       kgid_t pid_gid;
> > +       int hide_pid;
> >  };
> 
> .. and then used here instead of "int"?
> 
> Same goes for 'struct proc_fs_context' too, for that matter?
> 
> And maybe in the function declarations and definitions too? In things
> like 'has_pid_permissions()' (the series adds some other cases later,
> like hidepid2str() etc)
> 
> Yeah, enums and ints are kind of interchangeable in C, but even if it
> wouldn't give us any more typechecking (except perhaps with sparse if
> you mark it so), it would be documenting the use.
> 
> Or am I missing something?
> 
> Anyway, I continue to think the series looks fine, bnut would love to
> see it in -next and perhaps comments from Al and Alexey Dobriyan..

Patches are OK, except the part where "pid" is named "pidfs" and
the suffix doesn't convey any information.

	mount -t proc -o subset=pid,sysctl,misc

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
