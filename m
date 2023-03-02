Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F06A786A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCBAa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 19:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCBAa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:30:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097446085
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 16:30:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ky4so15897468plb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEfabSCp43QhqfB0SyHwstZnkFYZGWQHuKxqbl01Qrc=;
        b=Fz+0nQX0M3bCI9yyqAUwTWZ7nCQyIf55zIf5cW6AnTF0YdhjK61lTzZaquyFW+1j1B
         RSQwjpwXOpvUQxn6EjPl9U9xfkNcYpNIOCAQI/iMDi5AG8zP7mxFXAILN4PvJT11eWgS
         NH+EP4CfsIgGKFMcgw8gV9S/fVGz4OvT7yiqdMHQmCbE5+yCd7Jj6AEaV/bgbXH6H2DB
         NatZn/uokrYSWXBDpeFzxpKOk5/xvKIOiXIYR7r4ZK7U5QhocipNUjSsqifd01d3O2TI
         HLto6lNxJOxprR7Stu3rqpAQ+vZx+zrKpSzcsDJSh7IDR+Pi+OLnfj2z+X0bdB0Yu2Vs
         JCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEfabSCp43QhqfB0SyHwstZnkFYZGWQHuKxqbl01Qrc=;
        b=eEzKGMPxW6xbjm3oinm/dqDfl2Z2nhdkoBRz7jE+ZPkKaSXfHQ+5f6kToinEoZL7VK
         8VDLsKgIVxs1E26wPEbjXpv31SesIDeexflEM1lKzmg7EGQbVVxVJzvp9Hr3oCUKx/GT
         5Na5TYFC/GyFhOyTyJHUhtZ30ur3EquSGgvQlCP43/VcMsLjG946EoXRYFVZ4kInSFbX
         JxQplBkjAm6ejiF4F4/R7KQqgblGxdvw2pKqK3KT+hpwffj//OwO2YzZec6xAmj/yqMZ
         /kCSNdbsjSK6Ya9q4MvP+0/UyUIZ5HNqI9if1SWT+xdBd/7zPoHTXIntBE8/6kc+rLte
         J9HA==
X-Gm-Message-State: AO0yUKUCAMv86wSI2VYy7ytZNUAbRdNJHEM0C72X0qIgKFgAC7esf6WL
        1uYbF6QaCtmgZJxEqggHU1kewg==
X-Google-Smtp-Source: AK7set/ohYphdqi8H6Ih8jwhlS6b9fdJmP5PfntnIPn2GT5iLGVQQbZ7U3f+KBexXWIkCqsANWF38Q==
X-Received: by 2002:a17:90b:4b8d:b0:234:68d:b8ea with SMTP id lr13-20020a17090b4b8d00b00234068db8eamr9269752pjb.39.1677717054642;
        Wed, 01 Mar 2023 16:30:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id bg9-20020a17090b0d8900b002310ed024adsm361502pjb.12.2023.03.01.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 16:30:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pXWqQ-003iuX-Of; Thu, 02 Mar 2023 11:30:50 +1100
Date:   Thu, 2 Mar 2023 11:30:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230302003050.GI360264@dread.disaster.area>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
 <Y/mEsfyhNCs8orCY@magnolia>
 <20230228015807.GC360264@dread.disaster.area>
 <20230301123628.4jghcm4wqci6spii@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301123628.4jghcm4wqci6spii@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:36:28PM +0100, Jan Kara wrote:
> On Tue 28-02-23 12:58:07, Dave Chinner wrote:
> > On Fri, Feb 24, 2023 at 07:46:57PM -0800, Darrick J. Wong wrote:
> > > So xfs_dir2_sf_replace can rewrite the shortform structure (or even
> > > convert it to block format!) while readdir is accessing it.  Or am I
> > > mising something?
> > 
> > True, I missed that.
> > 
> > Hmmmm. ISTR that holding ILOCK over filldir callbacks causes
> > problems with lock ordering{1], and that's why we removed the ILOCK
> > from the getdents path in the first place and instead relied on the
> > IOLOCK being held by the VFS across readdir for exclusion against
> > concurrent modification from the VFS.
> > 
> > Yup, the current code only holds the ILOCK for the extent lookup and
> > buffer read process, it drops it while it is walking the locked
> > buffer and calling the filldir callback. Which is why we don't hold
> > it for xfs_dir2_sf_getdents() - the VFS is supposed to be holding
> > i_rwsem in exclusive mode for any operation that modifies a
> > directory entry. We should only need the ILOCK for serialising the
> > extent tree loading, not for serialising access vs modification to
> > the directory.
> > 
> > So, yeah, I think you're right, Darrick. And the fix is that the VFS
> > needs to hold the i_rwsem correctly for allo inodes that may be
> > modified during rename...
> 
> But Al Viro didn't want to lock the inode in the VFS (as some filesystems
> don't need the lock)

Was any reason given?

We know we have to modify the ".." entry of the child directory
being moved, so I'd really like to understand why the locking rule
of "directory i_rwsem must be held exclusively over modifications"
so that we can use shared access for read operations has been waived
for this specific case.

Apart from exposing multiple filesystems to modifications racing
with operations that hold the i_rwsem shared to *prevent concurrent
directory modifications*, what performance or scalability benefit is
seen as a result of eliding this inode lock from the VFS rename
setup?

This looks like a straight forward VFS level directory
locking violation, and now we are playing whack-a-mole to fix it in
each filesystem we discover that requires the child directory inode
to be locked...

> so in ext4 we ended up grabbing the lock in
> ext4_rename() like:
> 
> +               /*
> +                * We need to protect against old.inode directory getting
> +                * converted from inline directory format into a normal one.
> +                */
> +               inode_lock_nested(old.inode, I_MUTEX_NONDIR2);

Why are you using the I_MUTEX_NONDIR2 annotation when locking a
directory inode? That doesn't seem right.

Further, how do we guarantee correct i_rwsem lock ordering against
the all the other inodes that the VFS has already locked and/or
other multi-inode i_rwsem locking primitives in the VFS?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
