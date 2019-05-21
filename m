Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AF25A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEUV50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 17:57:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41650 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUV50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 17:57:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so171936pgp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIltc2Hu1zZzkC+Vq1d4j3ZMtjHqyYeiNsrF2aiFQWg=;
        b=axzxYQV0RWm7r7Qxg61535aTjvYWPTGz+cOuSV1XRn/ZJATUXMrZ7FidH9bTOFNizb
         TxMl7EWxnlPyIZMsyjmC4YcC+5EdWgckcvAs5HKogRei+MdNkOuN3ruO3LbWC6lU16e7
         Ftc2slcXMG3o00+sVtWuhPXTPWEyvAVkK/Jib1IsHg/lk4iRljRNYmGeNw8DdQzs0qQp
         tyV8YUfFw7cvE9uYdFiuVtJrgTlf1yNwv0SN5WghL3+Lc28JkQ2JpHApHY3J8DFku0Zd
         pnqn96jJ0CHQHCc/UMj/j7cxFnFUW1I1470Xe5eEBf1+MoRZhrismsIGOF/Ua9qgo/gg
         fG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIltc2Hu1zZzkC+Vq1d4j3ZMtjHqyYeiNsrF2aiFQWg=;
        b=Vps1WeGsar37UMA1oSdT4TvfgwrZY4oup7cBWselDC8VItpH5a0B3yqirNzadBBV49
         q60+3h20xiYBM+7pN9yccKSf80siIGd5yyh4vfpVy/UFF7gX1wx5qBMVWFdHCaEZB426
         Nq0aJpgLjWVjxb4XF8p6pJQTDVs6SbthiKhUs31AebIyBtvjIoxSikxYxqCRn3o74vOw
         audJic5Xa99YL7sdRS9okvVQbqHsZyzmBDJjTjQAgzJLDmysWnW2Sj7lvwXw08/NfdGN
         GviHF+iKrbMdw98Gbg61FSlyCcxNXS9qHCzgz64qwBX2wrI+1mnCRtGnQel26DJqPsVH
         Cohw==
X-Gm-Message-State: APjAAAVkbpap1ZarTNxhgg6q3ZScQpwm07ZouZRTNJrkXU0DOQodkKZA
        4TqA3+WHveq7Bmtw10DFlc7X7QA+xg==
X-Google-Smtp-Source: APXvYqy0vR/xK2Nu7qrv6gpfTPKOMRPr1/DbQ6DjWCVcBdCh4ULlE2BXxdDM0EPxiXqSVMhLlhPBbg==
X-Received: by 2002:a63:1212:: with SMTP id h18mr35786102pgl.266.1558475845390;
        Tue, 21 May 2019 14:57:25 -0700 (PDT)
Received: from neo ([120.17.20.160])
        by smtp.gmail.com with ESMTPSA id g22sm25796013pfo.28.2019.05.21.14.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 14:57:24 -0700 (PDT)
Date:   Wed, 22 May 2019 07:57:18 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: Disallow permission events for proc filesystem
Message-ID: <20190521215716.GB20383@neo>
References: <20190515193337.11167-1-jack@suse.cz>
 <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
 <20190516083632.GC13274@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516083632.GC13274@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:36:32AM +0200, Jan Kara wrote:
> On Thu 16-05-19 08:54:37, Amir Goldstein wrote:
> > On Wed, May 15, 2019 at 10:33 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Proc filesystem has special locking rules for various files. Thus
> > > fanotify which opens files on event delivery can easily deadlock
> > > against another process that waits for fanotify permission event to be
> > > handled. Since permission events on /proc have doubtful value anyway,
> > > just disallow them.
> > >
> > 
> > Let's add context:
> > Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/
> 
> OK, will add.
> 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index a90bb19dcfa2..73719949faa6 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> > >         return 0;
> > >  }
> > >
> > > +static int fanotify_events_supported(struct path *path, __u64 mask)
> > > +{
> > > +       /*
> > > +        * Proc is special and various files have special locking rules so
> > > +        * fanotify permission events have high chances of deadlocking the
> > > +        * system. Just disallow them.
> > > +        */
> > > +       if (mask & FANOTIFY_PERM_EVENTS &&
> > > +           !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {
> > 
> > Better use an SB_I_ flag to forbid permission events on fs?
> 
> So checking s_type->name indeed felt dirty. I don't think we need a
> superblock flag though. I'll probably just go with FS_XXX flag in
> file_system_type.

Would the same apply for some files that backed by sysfs and reside in
/sys?
 
> > 
> > > +               return -EOPNOTSUPP;
> > 
> > I would go with EINVAL following precedent of per filesystem flags
> > check on rename(2), but not insisting.
> 
> I was undecided between EOPNOTSUPP and EINVAL. So let's go with EINVAL.

I was also thinking that EINVAL makes more sense in this particular
case.
 
> > Anyway, following Matthew's man page update for FAN_REPORT_FID,
> > we should also add this as reason for EOPNOTSUPP/EINVAL.
> 
> Good point.

I've followed up Michael in regards to the FAN_REPORT_FID patch series,
but no response as of yet. I'm happy to write the changes for this one
if you like?

-- 
Matthew Bobrowski
