Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A931A830
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBLXIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBLXIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:08:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934AEC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 15:07:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id z19so1822833eju.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golang-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19/J/MKeVun+8K6ne5h+OKv0Km1x2p3pOwY4yYgbfjc=;
        b=iMBUdZsyK1oIq/8qqc04l4lBwM3+kA4e6mUAz9PWetmleCVFmkAAspOmPqV/x+9SE+
         NbciUl7l14tSCj9VDjKCTxvyp/r+cH+rbtHNGOZ3iCUakN58OdVFmy+wiE21Qt+F3Tpf
         D71vpLHLAHgdjenHvXCKKM9chVl9hr+zy5HgNrx3nDs6pAlQ+LZKjCTQtey/ooCwS15F
         wF1fwBNm+uEt+1j/HYGIE3LxrxydxlZyGJxdnvXBgCeW3WeCngw7YqwteHIzJF092we/
         9FDmtOr3o6IG3RgLSUL4HH1Onko+xmhMla76ecNtKjqPBasykckWxxa3iXGuEA+mFRTD
         3x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19/J/MKeVun+8K6ne5h+OKv0Km1x2p3pOwY4yYgbfjc=;
        b=Cerru+GGEu5nmORohoDh8jyAn0amHQLTPKLDjwpaFQGx0sHHE7S0GvOhWGVQQpSvik
         ACq8qIfGepDsfiblwA9vP8kFRYj3gB0cLxUr3aNLNKHxYmOm3KS0doEjFHhAvmZPq92M
         /ROyN2UCNJxkNBDbfst1Tp469dfdaDdwIvTQy7l7QHuxkPc5GxTwoy0d94HyLz0yACzT
         5Ab9iT/YCA+PVvA5zQa/tkR0umehrjz4T/RGuBdI3xdiOA6coB3uFdU2YhMNDIgscOao
         RAmxSV+MWqk+MNGRYzRzfANQPT2ayuh2ny6Ma+MS891iZ3ZxXvNYrXX5s7R9LY92zK9l
         XUdQ==
X-Gm-Message-State: AOAM531ftGTt5CQMIdD1+bsEtlEf645JnIGUYllvPevhE9x0efhK88e/
        jl6NM9H2VITO/3eSGmBVOTRIjG+eLxpxf43t6GhurnOaqt8=
X-Google-Smtp-Source: ABdhPJwJTBQJSHJUlnT7a+fMPTRST8COW0B3LqUTlHI10bnLL2S3yp4py5n/V6UWtykSs0NPd6Ba/E/9oxRAkyToP9I=
X-Received: by 2002:a17:906:8555:: with SMTP id h21mr5089568ejy.403.1613171270311;
 Fri, 12 Feb 2021 15:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com> <20210212230346.GU4626@dread.disaster.area>
In-Reply-To: <20210212230346.GU4626@dread.disaster.area>
From:   Ian Lance Taylor <iant@golang.org>
Date:   Fri, 12 Feb 2021 15:07:39 -0800
Message-ID: <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Dave Chinner <david@fromorbit.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 12, 2021 at 04:45:41PM +0100, Greg KH wrote:
> > On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > > files in the first place?  They can not seek (well most can not), so
> > > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > > problem that userspace should not do.
> > >
> > > This may have been covered elsewhere, but it's not that people are
> > > saying "let's use copy_file_range on files in /proc."  It's that the
> > > Go language standard library provides an interface to operating system
> > > files.  When Go code uses the standard library function io.Copy to
> > > copy the contents of one open file to another open file, then on Linux
> > > kernels 5.3 and greater the Go standard library will use the
> > > copy_file_range system call.  That seems to be exactly what
> > > copy_file_range is intended for.  Unfortunately it appears that when
> > > people writing Go code open a file in /proc and use io.Copy the
> > > contents to another open file, copy_file_range does nothing and
> > > reports success.  There isn't anything on the copy_file_range man page
> > > explaining this limitation, and there isn't any documented way to know
> > > that the Go standard library should not use copy_file_range on certain
> > > files.
> >
> > But, is this a bug in the kernel in that the syscall being made is not
> > working properly, or a bug in that Go decided to do this for all types
> > of files not knowing that some types of files can not handle this?
> >
> > If the kernel has always worked this way, I would say that Go is doing
> > the wrong thing here.  If the kernel used to work properly, and then
> > changed, then it's a regression on the kernel side.
> >
> > So which is it?
>
> Both Al Viro and myself have said "copy file range is not a generic
> method for copying data between two file descriptors". It is a
> targetted solution for *regular files only* on filesystems that store
> persistent data and can accelerate the data copy in some way (e.g.
> clone, server side offload, hardware offlead, etc). It is not
> intended as a copy mechanism for copying data from one random file
> descriptor to another.
>
> The use of it as a general file copy mechanism in the Go system
> library is incorrect and wrong. It is a userspace bug.  Userspace
> has done the wrong thing, userspace needs to be fixed.

OK, we'll take it out.

I'll just make one last plea that I think that copy_file_range could
be much more useful if there were some way that a program could know
whether it would work or not.  It's pretty unfortunate that we can't
use it in the Go standard library, or, indeed, in any general purpose
code, in any language, that is intended to support arbitrary file
names.  To be pedantically clear, I'm not saying that copy_file_range
should work on all file systems.  I'm only saying that on file systems
for which it doesn't work it should fail rather than silently
returning success without doing anything.

Ian
