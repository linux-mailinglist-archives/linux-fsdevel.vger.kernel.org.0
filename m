Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83CE31B3DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 02:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBOBNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 20:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBOBNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 20:13:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E0C061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 17:13:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g5so5160278ejt.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 17:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golang-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY17sg8S71FdSn0fjawRFa+xVg7WnNBoI/+IkEhD4Os=;
        b=VkF2aNUtGx0+uHVXB/4FJsHcU4FPR81RzZpop2ZMocnYIIHzX/NeChRlOajUrcQ2aC
         AnJHPRtImJTlcrpBzGRdgx5fRvicfQMQiMbYnznS2mzcAAJskYeT9g8UZ8N6DxCmyUYW
         9yNWOB+5FOwnyVAACfh4dI6HBE/TOKsf8j5uG6mz82BzEewDKtsU23Rztf0mnHryfGhi
         8uKsqDN5yIX6u/miVK8rn1NPP/vGoZFQ/sx2E1a47XQPcapaGJZ3v3wTFydAV6FGz7Ps
         y+5Acn/HB1hNatrDouN2WH0MX1pFMSPKeoqvRxXC+leE8uH+LtALM3xXvdHf4Z7gPMLH
         qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY17sg8S71FdSn0fjawRFa+xVg7WnNBoI/+IkEhD4Os=;
        b=afhKIek+cHGRcZb5DIItCcDdWc8B9rl27f7QQqHAa1ULaQPZwLHUFNErcpLQC0lyQt
         l4d53DGcVcZ5IdLJWonS4ltI5vjYT8c3BcbmNBKcMVu6EUC+bqv9kXQbON3bicRjjrxx
         bHvp1MkpYPiYiFlxfoeMQj1w2Ao+8nfDDYYywpw6PV+YdnDgSeL/ilBipYCghXhxDQ4d
         /6xYdrcuN1pqbc5/neGjJ/DUqm/HewArWPec3qpF9ER+9gTcyAlMW9ONn0LznltD4h7O
         v7Nun5na/a/yGOSiFdyVrYfuu8uxG7Y+k/+rCzabLcTW53i5/Hw3pspLC+OZ+zF7Bkmf
         89Kw==
X-Gm-Message-State: AOAM533G/Uefy47QACluHGb6oBBA4o15721XUGAwyJdGM4KOOTVkgqj3
        F0iaktCP7TkMxB7AvKGkfW219pZIdE/uwScxH7YuKw==
X-Google-Smtp-Source: ABdhPJxb6bpR3iYUtSchKq0DDC6Q4/vuSnaE/VibZttbylvQuVec+Qc/zCmxbK1BUx1hec9xTU5U4XAClnOyC//UqtY=
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr13771299ejc.332.1613351578887;
 Sun, 14 Feb 2021 17:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com> <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area> <20210212235448.GH7187@magnolia> <20210215003855.GY4626@dread.disaster.area>
In-Reply-To: <20210215003855.GY4626@dread.disaster.area>
From:   Ian Lance Taylor <iant@golang.org>
Date:   Sun, 14 Feb 2021 17:12:47 -0800
Message-ID: <CAOyqgcX6HrbPU39nznmRMXJXtMWA0giYNRsio1jt1p5OU1jvOA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 4:38 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 12, 2021 at 03:54:48PM -0800, Darrick J. Wong wrote:
> > On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> >
> > > If you can't tell from userspace that a file has data in it other
> > > than by calling read() on it, then you can't use cfr on it.
> >
> > I don't know how to do that, Dave. :)
>
> If stat returns a non-zero size, then userspace knows it has at
> least that much data in it, whether it be zeros or previously
> written data. cfr will copy that data. The special zero length
> regular pipe files fail this simple "how much data is there to copy
> in this file" check...

This suggests that if the Go standard library sees that
copy_file_range reads zero bytes, we should assume that it failed, and
should use the fallback path as though copy_file_range returned
EOPNOTSUPP or EINVAL.  This will cause an extra system call for an
empty file, but as long as copy_file_range does not return an error
for cases that it does not support we are going to need an extra
system call anyhow.

Does that seem like a possible mitigation?  That is, are there cases
where copy_file_range will fail to do a correct copy, and will return
success, and will not return zero?

Ian
