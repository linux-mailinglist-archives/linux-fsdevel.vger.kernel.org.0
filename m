Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D341067AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVITA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:19:00 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:39947 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVITA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:19:00 -0500
Received: by mail-il1-f182.google.com with SMTP id v17so2189530ilg.7;
        Fri, 22 Nov 2019 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysnhqpcDifNtA6ZEpiA8FU7zKxqqga8EknENlPaN0u8=;
        b=YtlNhRdAncXEsgQ+beLXQOZQm2MQA/W53swM6V4mhNax3lEDiAejf05GfOiyJ19Py0
         7te741stGu86F2U/IFoY2XQrGDxESPtCUUNMfRGpW58eUDw1q4MYLJL5w9lga4PjbpoY
         tjMZyFnxj7ILPTGAGSitHz5YRO7Yvgc8UFsAOdm6RKoEEwWA4HKmByUyCggvKP6IXjmf
         8DM5SvBPmG8kXNbbzxYuEQdvuIxX7VONW41/j5V+kvzm7C4GfAl06J9uhWJjxL834yG1
         sz28B/mFlFUPNwRH6zLNWeZwcOnBMs0cEvOxMd8a0uvsxd80b4dbRYv50Xh2hZ056b9E
         lM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysnhqpcDifNtA6ZEpiA8FU7zKxqqga8EknENlPaN0u8=;
        b=dy2fRvpKPmJjBqcx6EXGlQaRFoUP4WHHVBNE1FTEV9lq7KqZo0/IQ4n0dsIz3HfPuu
         Y+bjCAiLzINPRssTAstkyPuGHFxnLP89+z6ANPQ34C/V7to/kiQ+5NarwPw/LJHZvFoY
         vnUuwCcfLBusrXYd/XXSJlEjcLoEirIbHW6hDTozQWvgcBFikzcHkiM2Fv0iu2HWmhAs
         PoI4BHYl/kpaLhSn2+6RDTzzv0Vf6q5BneD/24WVgpPr3KvHjN1Licpuny/aLBn5gor7
         q4HupomDshn7qD0NxLqQbIbGhQ8p/1l2OfHXtbHMdDi6vdW6Oc/CVOe2R+ozerVpVn5z
         MoNg==
X-Gm-Message-State: APjAAAUGPKOMqXdyLsWQkpJzDsmmpjCkrVh0wuqZwJi+9sOkGCXForPS
        xJRC8F39IN3nftKjgR8pI8lZ9r99LO4F3s9Ab/Y=
X-Google-Smtp-Source: APXvYqxvYsfe3tlRWTOvw0hcohTpGGT03glJaVhRL0xnuYE2VyeVqqG1xEXn+ALRkzIfjaJuE0x1jN3IXIBV24nUUig=
X-Received: by 2002:a92:5b86:: with SMTP id c6mr14683342ilg.135.1574410737554;
 Fri, 22 Nov 2019 00:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20191120081628.26701-1-yu.c.chen@intel.com> <alpine.DEB.2.21.1911201055260.6731@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911201055260.6731@nanos.tec.linutronix.de>
From:   Yu Chen <yu.chen.surf@gmail.com>
Date:   Fri, 22 Nov 2019 16:18:46 +0800
Message-ID: <CADjb_WR4Lwjdu9aQOnfm21rcYqoAK-25V-cmRABPzpduUWBGsQ@mail.gmail.com>
Subject: Re: [PATCH][v3] x86/resctrl: Add task resctrl information display
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,
On Wed, Nov 20, 2019 at 7:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 20 Nov 2019, Chen Yu wrote:
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
>
> The formatting is quite ugly and I don't see why this needs to be multiple
> lines and have these uppercase prefixes.
>
> A task can only be part of one control group and of one monitoring group
> which is associated to the control group. So just providing:
>
>  1)   ""
>  2)   "/"
>  3)   "/mon_groups/mon0"
>  4)   "/group0"
>  5)   "/group0/mon_groups/mon1"
>
> is simple and clear enough, i.e.:
>
> #1: Resctrl is not available
>
> #2: Task is part of the root group, task not associated to any monitoring
>     group
>
> #3: Task is part of the root group and monitoring group mon0
>
> #4: Task is part of control group group0, task not associated to any
>     monitoring group
>
> #5: Task is part of control group group0 and monitoring group mon1
>
> Hmm?
>
Yes, good idea, this is much more simpler.  I'll send the new version
out based on this.

Thanks,
Chenyu
