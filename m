Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEE13AE55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgANQE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:04:58 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:34301 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgANQE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:04:57 -0500
Received: by mail-io1-f41.google.com with SMTP id z193so14393330iof.1;
        Tue, 14 Jan 2020 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3IvYmcGimwuEN+/tbhVg4f+uAHLk1U4Opz1X1TABkM=;
        b=BRbkRaQGkZsDAKCG9VdBHFPU2jVnKOc8SEywhumuz9LXfxBFF/KBBf/ViobDyt8Ltb
         4hb70Rjjr0euUf9mDAeTSnbf3hyDF9Yi9/aoJPc4Wq378qeHrR9dkJCyTkgCgrutTcSm
         GrdNhZXaJt3XXLDpYuy2VQDPwa/pCKxq9ja26hHjjLX4bwVckP/QuJ5eniHv0S5zMjyw
         Y6Ek+zq5zVEiso8lC9uRb8ZznFJn1IPvy0G4tJ/1MTz662zOiB4pYbAvihW3AbPILxht
         Z1XvLwv+T2fuen4V6E4+QAnBKB/dOfItyaxyzUOuSfhNgYM/STjacljtbPdt17bLZwpm
         1YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3IvYmcGimwuEN+/tbhVg4f+uAHLk1U4Opz1X1TABkM=;
        b=p+FKbeeXawEcGz7wW1d2m0kyDIbh281u38SEFLiCeCqxLEd/NWJw+7xvskMthwswM0
         gEj5SpnhkI7zN2inWhpngmRcDrlONmsW4MNJddVzOpN8OWp09jXXVOyVpf9MtBNRq5Fc
         wKO3pvqaK/a7f0sQ1YQ7qcpBv+7lIc4WGZ/g8Ng8ZmptcVJ+690zSPmuIjHcnmam15Ti
         FsgU0rUs5HEmpZXjcwKVf4Xt3RzrMH1Lp51yOD5gL4OWYIu6S8bMehYbe6WyHsnx7rKf
         /fsIUkUAzbS+ayZSarfkFppA3tDTQJhxnFBbaFAmPP3T+/JMpZca/fP2RwkyCFgfm+c2
         Ae1A==
X-Gm-Message-State: APjAAAXR3fEdTYY2zQ/T49nDovIH2gAweZ+I4SFMD+J7s1WNyYeSWRim
        xQ6r5mZcPptTfm4/Da1cxIFu6Myzf+hAb4m9Plg=
X-Google-Smtp-Source: APXvYqyLvxCk0Y5/M9spC9uyi7Y+XWQiWwIY1wxE92OOmzgTP3PKC8QOD4Iqs18UgnfXReUZQaI752wU3S2Eqz5kObE=
X-Received: by 2002:a5d:93d1:: with SMTP id j17mr18349954ioo.300.1579017897096;
 Tue, 14 Jan 2020 08:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20200110070608.18902-1-yu.c.chen@intel.com> <20200114092450.GA31032@zn.tnic>
In-Reply-To: <20200114092450.GA31032@zn.tnic>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 15 Jan 2020 00:04:44 +0800
Message-ID: <CADjb_WRicSYZP3cXz+PWzXCY42qxgHM2Q5uoqqiSzKtfQ--AZQ@mail.gmail.com>
Subject: Re: [PATCH][v6] x86/resctrl: Add task resctrl information display
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Boris,
On Tue, Jan 14, 2020 at 5:25 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 10, 2020 at 03:06:08PM +0800, Chen Yu wrote:
> > Monitoring tools that want to find out which resctrl control
> > and monitor groups a task belongs to must currently read
> > the "tasks" file in every group until they locate the process
> > ID.
> >
> > Add an additional file /proc/{pid}/cpu_resctrl to provide this
> > information.
> >
> > The output is as followed, for example:
> >
> >  1)   ""
> >       Resctrl is not available.
> >
> >  2)   "/"
> >       Task is part of the root group, task is not associated to
> >       any monitor group.
> >
> >  3)   "/mon_groups/mon0"
> >       Task is part of the root group and monitor group mon0.
> >
> >  4)   "/group0"
> >       Task is part of resctrl control group group0, task is not
> >       associated to any monitor group.
> >
> >  5)   "/group0/mon_groups/mon1"
> >       Task is part of resctrl control group group0 and monitor
> >       group mon1.
>
> So this way to present the information is totally non-intuitive,
> IMNSVHO. What's wrong with:
>
> 1)
>         res_group:
>         mon_group:
>
> 2)
>         res_group: /
>         mon_group:
>
> 3)
>         res_group: /
>         mon_group: mon0
>
> 4)
>         res_group: group0
>         mon_group:
>
> 5)
>         res_group: group0
>         mon_group: mon1
>
> ?
>
> You can even call the file "cpu_resctrl_groups" so that it is clear that
> it will dump groups and then do:
>
>         res: group0
>         mon: mon1
>
> which is both human-readable and easily greppable.
>
Yes, to display resctrl control and monitor group separately might be more
friendly to the user.  Although I was thinking if the user would like
to see the full path of
the resource, which might make it easier to be parsed:
A) res: group0
    mon: mon1
vs
B) res: /group0
    mon: /group0/mon_groups/mon1
as proposal B might introduce duplication I'll send a new version
based on proposal A.
> > +/*
> > + * A task can only be part of one resctrl
> > + * control group and of one monitor
> > + * group which is associated to that resctrl
> > + * control group.
>
> Extend those comments to 80 cols.
>
Okay. will do.
> > + * So one line is simple and clear enough:
>
> Actually, the one line format you've done is confusing and can be done
> much more human- and tool-readable.
>
Got it.
Thanks,
Chenyu

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
