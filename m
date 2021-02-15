Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87D331B552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 06:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhBOF5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 00:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOF5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 00:57:39 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E4C061574;
        Sun, 14 Feb 2021 21:56:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id i8so1345952iog.7;
        Sun, 14 Feb 2021 21:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIgh8HuKJYUrgA4jcFeRQpYRrHR/5oXsXAmQ+VRmojs=;
        b=a+bEWXewbA9u10rreL16bakqpNGBlKTBw5WunBquVeucHWziR61pdoPwcoZ96Uht/Q
         CPPp1cp/4TglTl7zk8kNLOuXO/l36t58m1lhn770MhURTFLYj/3LIGauGnXaA6z03T+a
         onBHUDHv/XxwYu/pG5b5xCrS4q318Q+SF6Sw2JcJNJXe1PQ/43xCshPO/pm8iqKKpVwM
         WKs38rXxc0jlbf1Zw/mFQi7plVgccYbvH6Vpxd0JfgAuA0Du2APJqPaIIJjxSlMztUW7
         1sI9AUYZGZD27yTtO7iZNXn4PNAUSILmj/ZjpSfVEBu1msRshDM+Txa5IeX2yhLVNwxy
         B6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIgh8HuKJYUrgA4jcFeRQpYRrHR/5oXsXAmQ+VRmojs=;
        b=f2KMZoufnRLlQDLCA3tCM/QgrQU03YVqCFc7vtRsMZm32ymh3JROQfFrnCByv765aP
         xjjM+zXOkTBaizot2tfxvcW8LmaDGVeSIdkNrjnEDXcD0uoXFB+OXVHWG/50X00rhxhX
         YQSOmUzSsMC8khrHgkEuf5WkYeG3QlZBlGOknNXLXYCzl2BE8JiUKynGx77aSc758G4k
         /2xIuhcMd7yK+qKeWZGKy2jcxgfeTePJ0UlnGfF2HLN5/TQbAsLSeTadQYa6KBlmQJ7x
         iTCc66//V5U3SYd5ntcprYZOOcROtTaatLSpMRLjin6yrTgxh+JDuNayDX1I5RCX0wf6
         kMCQ==
X-Gm-Message-State: AOAM531rA/X7g13TMcDR4t1qKOVz5pn0T/7+h/2v8hUBBaL4BWR624up
        4wJm2oUUtJkNqM9AOFs7kE2J2SrNkdZT87UL3vg=
X-Google-Smtp-Source: ABdhPJzpCf4+eLP4+jIdm5H7oLLWkeS1rbn5yYM8jOjGkofSKNPdQ+Py9ipaA6ELmrAFzJkq7CYS0enRLf/yI4KHVH8=
X-Received: by 2002:a02:ca45:: with SMTP id i5mr7687809jal.123.1613368618345;
 Sun, 14 Feb 2021 21:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com> <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area> <20210212235448.GH7187@magnolia>
 <20210215003855.GY4626@dread.disaster.area> <CAOyqgcX6HrbPU39nznmRMXJXtMWA0giYNRsio1jt1p5OU1jvOA@mail.gmail.com>
 <CANMq1KDv-brWeKOTt3aUUi_1SOXSpEFo5pS5A6mpRT8k-O88nA@mail.gmail.com>
In-Reply-To: <CANMq1KDv-brWeKOTt3aUUi_1SOXSpEFo5pS5A6mpRT8k-O88nA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Feb 2021 07:56:47 +0200
Message-ID: <CAOQ4uxjX2v6nERGCPubz4NBV+4we01+=Yx-H4kMKQ78FLPv48Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Ian Lance Taylor <iant@golang.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 3:27 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Mon, Feb 15, 2021 at 9:12 AM Ian Lance Taylor <iant@golang.org> wrote:
> >
> > On Sun, Feb 14, 2021 at 4:38 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Fri, Feb 12, 2021 at 03:54:48PM -0800, Darrick J. Wong wrote:
> > > > On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> > > >
> > > > > If you can't tell from userspace that a file has data in it other
> > > > > than by calling read() on it, then you can't use cfr on it.
> > > >
> > > > I don't know how to do that, Dave. :)
> > >
> > > If stat returns a non-zero size, then userspace knows it has at
> > > least that much data in it, whether it be zeros or previously
> > > written data. cfr will copy that data. The special zero length
> > > regular pipe files fail this simple "how much data is there to copy
> > > in this file" check...
> >
> > This suggests that if the Go standard library sees that
> > copy_file_range reads zero bytes, we should assume that it failed, and
> > should use the fallback path as though copy_file_range returned
> > EOPNOTSUPP or EINVAL.  This will cause an extra system call for an
> > empty file, but as long as copy_file_range does not return an error
> > for cases that it does not support we are going to need an extra
> > system call anyhow.
> >
> > Does that seem like a possible mitigation?  That is, are there cases
> > where copy_file_range will fail to do a correct copy, and will return
> > success, and will not return zero?
>
> I'm a bit worried about the sysfs files that report a 4096 bytes file
> size, for 2 reasons:
>  - I'm not sure if the content _can_ actually be longer (I couldn't
> find a counterexample)
>  - If you're unlucky enough to have a partial write in the output
> filesystem, you'll get a non-zero return value and probably corrupted
> content.
>

First of all, I am in favor of fixing the regression in the kernel caused
by the change of behavior in v5.3.

Having said that, I don't think it is a good idea to use ANY tool to copy
a zero size pseudo file.
rsync doesn't copy any data either if you try to use it to copy tracing into
a temp file.
I think it is perfectly sane for any tool to check file size before trying
to read/copy.

w.r.t. short write/short read, did you consider using the off_in/off_out
arguments? I *think* current kernel CFR should be safe to use as long
as the tool:
1. Checks file size before copy
2. Does not try to copy a range beyond EOF
3. Pass off_in/off_out args and verify that off_in/off_out advances
    as expected

Thanks,
Amir.
