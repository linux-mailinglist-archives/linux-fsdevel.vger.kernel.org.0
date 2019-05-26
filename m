Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5172A969
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEZLiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 07:38:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfEZLiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 07:38:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so3080032pfq.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=anmRnLt1sw+EfKgIF1GATNfdw6tpF7fjRAZA1LRcUfw=;
        b=cVVrYOhbU75qooBCbQ7K6Udq72/XR3qvWjvdHZLAIgpYUwsW5SJXOP/Gsf4glOBJlf
         o/K8Fmcxe6aoV2JPJ7Q8rqD8xjQp0nEFxpY2O0xwOM26BuxlzqUR8ZHz4SIyu8doWyL8
         qlqV7dw/j6BQR1WgxjHrsY4DwQ7fLb+6pbZBoHJLvAl2Ndo49XYlzi79e0NQ01hE7hdW
         WnlEhuptVfnNPG7mdRugEJ3AXtdYR37QMKXMqHEzYFQi4aIQVbY/f+BIaPB9dpL7u2sx
         5thFU/W8FbBrD9pY/EcqVF4FYgsGmIbLCwzKqH+tyrXx/anCHnoS2jkn5aj97ALjV5yC
         LqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=anmRnLt1sw+EfKgIF1GATNfdw6tpF7fjRAZA1LRcUfw=;
        b=Gd8WQtEdeb2vhJRtur1GhET84la10MJuzI0B+052s9oM24RKeTY/FowE0pS/CRmlXe
         7tlgTVBfcA2996VMzXs4x9MQKBlOerFrP8aVdQ07oW/J3ogNvF4Vgwwn5mB9VKAhXDdt
         mopCP/E1RxLfPuMLrbFTuIluJ+rYf0PBHqo3sEtnluSpZXRV6fUTO7PojLgVySsdHgdX
         kXqIKyKT8dbbq11Vq+cd4exzFi37dTCB7sWg/lt2fbtY51fn+qFSt1qg+SNJvmUHA7kY
         JN6cH7yJd3Qr7s7f8ikxIcDuJVaAHItnk3KQvZXg/IWjHQgjmyL0PVTysYc1MzWmwVUp
         c3SA==
X-Gm-Message-State: APjAAAWdI3yEESPGUXCAKQDA4Pl/5ULHEDyYowOBoUjuVsgitU8uPDVg
        ErvScIVv/lUA/z9lexGe5LYHHSy1yg==
X-Google-Smtp-Source: APXvYqxMs1FWq+gbmGBPPgYOXiiulPmBnwpGxItS8emm0ZeYjxWHOc7Hvs3rguCNaf391A9xR6vUqQ==
X-Received: by 2002:a63:1663:: with SMTP id 35mr22144945pgw.253.1558870690144;
        Sun, 26 May 2019 04:38:10 -0700 (PDT)
Received: from poseidon.Home ([114.78.0.167])
        by smtp.gmail.com with ESMTPSA id v4sm9040858pff.45.2019.05.26.04.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 04:38:09 -0700 (PDT)
Date:   Sun, 26 May 2019 21:38:04 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: Disallow permission events for proc filesystem
Message-ID: <20190526113802.GB3346@poseidon.Home>
References: <20190515193337.11167-1-jack@suse.cz>
 <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
 <20190516083632.GC13274@quack2.suse.cz>
 <20190521215716.GB20383@neo>
 <20190522094201.GF17019@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522094201.GF17019@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 11:42:01AM +0200, Jan Kara wrote:
> On Wed 22-05-19 07:57:18, Matthew Bobrowski wrote:
> > On Thu, May 16, 2019 at 10:36:32AM +0200, Jan Kara wrote:
> > > On Thu 16-05-19 08:54:37, Amir Goldstein wrote:
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >  fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
> > > > >  1 file changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > > > index a90bb19dcfa2..73719949faa6 100644
> > > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > > @@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static int fanotify_events_supported(struct path *path, __u64 mask)
> > > > > +{
> > > > > +       /*
> > > > > +        * Proc is special and various files have special locking rules so
> > > > > +        * fanotify permission events have high chances of deadlocking the
> > > > > +        * system. Just disallow them.
> > > > > +        */
> > > > > +       if (mask & FANOTIFY_PERM_EVENTS &&
> > > > > +           !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {
> > > > 
> > > > Better use an SB_I_ flag to forbid permission events on fs?
> > > 
> > > So checking s_type->name indeed felt dirty. I don't think we need a
> > > superblock flag though. I'll probably just go with FS_XXX flag in
> > > file_system_type.
> > 
> > Would the same apply for some files that backed by sysfs and reside in
> > /sys?
> 
> So far I'm not aware of similar easy to trigger deadlocks with sysfs. So I
> opted for a cautious path and disabled permission events only for proc.
> We'll see how that fares.
> 
> > > > > +               return -EOPNOTSUPP;
> > > > 
> > > > I would go with EINVAL following precedent of per filesystem flags
> > > > check on rename(2), but not insisting.
> > > 
> > > I was undecided between EOPNOTSUPP and EINVAL. So let's go with EINVAL.
> > 
> > I was also thinking that EINVAL makes more sense in this particular
> > case.
> 
> Good, that's what I used in v2.
> 
> > > > Anyway, following Matthew's man page update for FAN_REPORT_FID,
> > > > we should also add this as reason for EOPNOTSUPP/EINVAL.
> > > 
> > > Good point.
> > 
> > I've followed up Michael in regards to the FAN_REPORT_FID patch series,
> > but no response as of yet. I'm happy to write the changes for this one
> > if you like?
> 
> If you had time for that, that would be nice. Thanks!

Simple. I will write the changes and send it through for review.

-- 
Matthew Bobrowski
