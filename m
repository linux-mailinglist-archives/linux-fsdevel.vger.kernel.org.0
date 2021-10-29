Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E807944002B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2QTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ2QTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:19:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA5C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so10952346pji.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
        b=DDH8LvTf1NbwlDisv+efQao95HUsWm01LKrhjJ2uX5etHAjxnlYc1fVorsh9C2tZeZ
         IZjJyefUE9sV7SNEI3aifqWin72xUpU2BtMndIJi3ywQQBX2XMdIqeYY8510szP8t2sH
         kdBhiAG5maV3WHr8hudaPmgocYD17sC0B0D26/b8Pbwzr3F117FlSlFBx3SQdqHiOhCS
         AzK0mVaRm+n9lGW4xPZYMjIFamXjTmcm5QI7QOVxfQm9omv4teemj/fppXRavbXh1qYb
         2mUwDH8Lkp2dgVW/pz350uqfUJeZ+MOAK0wy10AUYRh1hsJJ2oVH6yHtRzop5uS3RMQt
         86wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
        b=4ugVoCd89/igb0EqSjPnyKTyTLEJJKTI7RDFBYrgA2KUOt3y0NNFzUI7PzNlea35rB
         36yuOGQrgEXvBwX5L00lUNF6OBy6NOVJNiVKNe95Fd2vgdr6XdUXSFjBIFJOdMWQkzOP
         WKaBZwUXX6PkyDqIVJzLxiWyCu+1B8hJEtNH/DJHBJw8w51zkGGm6IDliyf+cnL5zRtP
         COc3DVrV3Ofjqp6uhqlWkNs3+3fKUyrA2tV1Ii/fohXkRUXUAGKPGq9gce0eS7cK8TYO
         I8lpiJxVhS5uJ1sj11NM8PQAqagUsWqbEmnklv8P/6/pnCGw3ruCNNbl6gnqFdCSL5B3
         +jUw==
X-Gm-Message-State: AOAM532iWajNa8Ko8/jCpJJMoMPqfhFpITMnPAjtUIss2fGHnEU3rrPZ
        FXBUfoNjAZ5sWRPFcJpRP56n6kFz+UU5N2b+EgeGXg==
X-Google-Smtp-Source: ABdhPJy6oDDE8Tua+O/7LJsaoOuN022Twl1T27YRaF2rK5Jgwv2I/UmljReJn3ItDXvNR8dsDNU53ltbLhzG+bw6RwY=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr12425415pjb.220.1635524207375;
 Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au> <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
 <20211029155524.GE24307@magnolia>
In-Reply-To: <20211029155524.GE24307@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 09:16:35 -0700
Message-ID: <CAPcyv4hL7ox5a7L7pBs-uoj_h+9F7E_nBs-qnJKBbJ7PHpWAjw@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 8:55 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Oct 29, 2021 at 08:42:29AM -0700, Dan Williams wrote:
> > On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > My merge resolution is here [1]. Christoph, please have a look. The
> > > > rebase and the merge result are both passing my test and I'm now going
> > > > to review the individual patches. However, while I do that and collect
> > > > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > > > this is coming. Primarily I want to see if someone sees a better
> > > > strategy to merge this, please let me know, but if not I plan to walk
> > > > Stephen and Linus through the resolution.
> > >
> > > It doesn't look to bad to me (however it is a bit late in the cycle :-(
> > > ).  Once you are happy, just put it in your tree (some of the conflicts
> > > are against the current -rc3 based version of your tree anyway) and I
> > > will cope with it on Monday.
> >
> > Christoph, Darrick, Shiyang,
> >
> > I'm losing my nerve to try to jam this into v5.16 this late in the
> > cycle.
>
> Always a solid choice to hold off for a little more testing and a little
> less anxiety. :)
>
> I don't usually accept new code patches for iomap after rc4 anyway.
>
> > I do want to get dax+reflink squared away as soon as possible,
> > but that looks like something that needs to build on top of a
> > v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
> > enough soak time, but otherwise I want to take the time to collect the
> > acks and queue up some more follow-on cleanups to prepare for
> > block-less-dax.
>
> I think that hwpoison-calls-xfs-rmap patchset is a prerequisite for
> dax+reflink anyway, right?  /me had concluded both were 5.17 things.

Ok, cool, sounds like a plan.
