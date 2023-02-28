Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CE6A50DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB1B6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjB1B6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:58:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFE9EFB
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:58:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l1so8216138pjt.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IQfEkl9N9Eb8JqhaqUhkVBmkkek4NGuGxLJiLA7OV8=;
        b=O2r92sW8hewMqpgo2id3u3qTmHBviNXgpg853ZKniWpQ/iM7l5uNesk9tWYlZ2MlAK
         6RlzBr9zGZIif4+I11KlQrmdLFov0GmadkCpJ3G2tgMLDtDZZKk7orVKy+wU+SRUJOqR
         Cf6Fklr6hgfusnNP5dOn2XivsI4MwAon0O0SYGXBpNl5EQDU+QBprLmuEkkbzSBZK+Qh
         H560+YWMcK415X7tRlJi0ZRmAbB3Tbcn38w3nsUi+aB7lLAm6vjn7RrUOOhq0kamB5zh
         M3552ZyNc+qVYNRw5yN59Z3+LaqGW6GNyZsKHv//Qps14XlXUWa3em/NZ3dh+eDLAzrW
         VYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IQfEkl9N9Eb8JqhaqUhkVBmkkek4NGuGxLJiLA7OV8=;
        b=FPd3julljFskyLzrIYvyoGUlKsaJXXktuKzzlF/kZB1D5UKT1klVYgECgN9rmRFNQg
         SDzqU9suSAV+Yr/CQFME3Ahc7K7T+UUCSBnqqwu5PHUej+zAOpUQu82luNba5LTnOouK
         apTezwvlG8x1MV6kKlAYcnGqQXd0rHCg2ab7voZaJ1Ys9Jq2zTPKhH+H7rQyCvcUn6Cx
         QSd1YP+4v3dUiXvrqIgGxzgIfntKjVG8n56irIKtOO6fUKAKe3laF6bV2nccNVw5t64N
         HHemKi5ZTwQvAykZqNPKRGAWnIzkuw3gzdHuw2+ezi4CkMugTBSLSk1tOdgZK3KOSLPv
         IiwQ==
X-Gm-Message-State: AO0yUKWlvfToWois26Ose1zK331lreVjFN+V5QP23aL27CcvK3OzTfs7
        AKCtyONvUo8qZtkrAA9LZvTwsg==
X-Google-Smtp-Source: AK7set/9pnqfWvqqQb6rymPyFlcrobtBuWxf+b5OI6R4nHlNiTXp67XTClDKSp9g8uPSfP0ZriaPnA==
X-Received: by 2002:a17:903:40c6:b0:19c:d6d0:7887 with SMTP id t6-20020a17090340c600b0019cd6d07887mr930273pld.30.1677549492664;
        Mon, 27 Feb 2023 17:58:12 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709028d8200b0019a84b88f7csm5229016plo.27.2023.02.27.17.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:58:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWpFn-002xPT-Uu; Tue, 28 Feb 2023 12:58:08 +1100
Date:   Tue, 28 Feb 2023 12:58:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230228015807.GC360264@dread.disaster.area>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
 <Y/mEsfyhNCs8orCY@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/mEsfyhNCs8orCY@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:46:57PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 18, 2023 at 08:44:57AM +1100, Dave Chinner wrote:
> > On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> > > Hello!
> > > 
> > > I've some across an interesting issue that was spotted by syzbot [1]. The
> > > report is against UDF but AFAICS the problem exists for ext4 as well and
> > > possibly other filesystems. The problem is the following: When we are
> > > renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> > > 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> > > 
> > >         if (!is_dir || (flags & RENAME_EXCHANGE))
> > >                 lock_two_nondirectories(source, target);
> > >         else if (target)
> > >                 inode_lock(target);
> > > 
> > > However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> > > hurt by this as well because it converts among multiple dir formats) need
> > > to update parent pointer in 'dir' and nothing protects this update against
> > > a race with someone else modifying 'dir'. Now this is mostly harmless
> > > because the parent pointer (".." directory entry) is at the beginning of
> > > the directory and stable however if for example the directory is converted
> > > from packed "in-inode" format to "expanded" format as a result of
> > > concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> > > in case of UDF).
> > 
> > No, xfs_rename() does not have this problem - we pass four inodes to
> > the function - the source directory, source inode, destination
> > directory and destination inode.
> 
> Um, I think it does have this problem.  xfs_readdir thinks it can parse
> a shortform inode without taking the ILOCK:
> 
> 	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL)
> 		return xfs_dir2_sf_getdents(&args, ctx);
> 
> 	lock_mode = xfs_ilock_data_map_shared(dp);
> 	error = xfs_dir2_isblock(&args, &isblock);
> 
> So xfs_dir2_sf_replace can rewrite the shortform structure (or even
> convert it to block format!) while readdir is accessing it.  Or am I
> mising something?

True, I missed that.

Hmmmm. ISTR that holding ILOCK over filldir callbacks causes
problems with lock ordering{1], and that's why we removed the ILOCK
from the getdents path in the first place and instead relied on the
IOLOCK being held by the VFS across readdir for exclusion against
concurrent modification from the VFS.

Yup, the current code only holds the ILOCK for the extent lookup and
buffer read process, it drops it while it is walking the locked
buffer and calling the filldir callback. Which is why we don't hold
it for xfs_dir2_sf_getdents() - the VFS is supposed to be holding
i_rwsem in exclusive mode for any operation that modifies a
directory entry. We should only need the ILOCK for serialising the
extent tree loading, not for serialising access vs modification to
the directory.

So, yeah, I think you're right, Darrick. And the fix is that the VFS
needs to hold the i_rwsem correctly for allo inodes that may be
modified during rename...

-Dave.

[1]:

commit dbad7c993053d8f482a5f76270a93307537efd8e
Author: Dave Chinner <dchinner@redhat.com>
Date:   Wed Aug 19 10:33:00 2015 +1000

    xfs: stop holding ILOCK over filldir callbacks
    
    The recent change to the readdir locking made in 40194ec ("xfs:
    reinstate the ilock in xfs_readdir") for CXFS directory sanity was
    probably the wrong thing to do. Deep in the readdir code we
    can take page faults in the filldir callback, and so taking a page
    fault while holding an inode ilock creates a new set of locking
    issues that lockdep warns all over the place about.
    
    The locking order for regular inodes w.r.t. page faults is io_lock
    -> pagefault -> mmap_sem -> ilock. The directory readdir code now
    triggers ilock -> page fault -> mmap_sem. While we cannot deadlock
    at this point, it inverts all the locking patterns that lockdep
    normally sees on XFS inodes, and so triggers lockdep. We worked
    around this with commit 93a8614 ("xfs: fix directory inode iolock
    lockdep false positive"), but that then just moved the lockdep
    warning to deeper in the page fault path and triggered on security
    inode locks. Fixing the shmem issue there just moved the lockdep
    reports somewhere else, and now we are getting false positives from
    filesystem freezing annotations getting confused.
    
    Further, if we enter memory reclaim in a readdir path, we now get
    lockdep warning about potential deadlocks because the ilock is held
    when we enter reclaim. This, again, is different to a regular file
    in that we never allow memory reclaim to run while holding the ilock
    for regular files. Hence lockdep now throws
    ilock->kmalloc->reclaim->ilock warnings.
    
    Basically, the problem is that the ilock is being used to protect
    the directory data and the inode metadata, whereas for a regular
    file the iolock protects the data and the ilock protects the
    metadata. From the VFS perspective, the i_mutex serialises all
    accesses to the directory data, and so not holding the ilock for
    readdir doesn't matter. The issue is that CXFS doesn't access
    directory data via the VFS, so it has no "data serialisaton"
    mechanism. Hence we need to hold the IOLOCK in the correct places to
    provide this low level directory data access serialisation.
    
    The ilock can then be used just when the extent list needs to be
    read, just like we do for regular files. The directory modification
    code can take the iolock exclusive when the ilock is also taken,
    and this then ensures that readdir is correct excluded while
    modifications are in progress.
    
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Reviewed-by: Brian Foster <bfoster@redhat.com>
    Signed-off-by: Dave Chinner <david@fromorbit.com>


The referenced commit is this:

commit 40194ecc6d78327d98e66de3213db96ca0a31e6f
Author: Ben Myers <bpm@sgi.com>
Date:   Fri Dec 6 12:30:11 2013 -0800

    xfs: reinstate the ilock in xfs_readdir
    
    Although it was removed in commit 051e7cd44ab8, ilock needs to be taken in
    xfs_readdir because we might have to read the extent list in from disk.  This
    keeps other threads from reading from or writing to the extent list while it is
    being read in and is still in a transitional state.
    
    This has been associated with "Access to block zero" messages on directories
    with large numbers of extents resulting from excessive filesytem fragmentation,
    as well as extent list corruption.  Unfortunately no test case at this point.
    
    Signed-off-by: Ben Myers <bpm@sgi.com>
    Reviewed-by: Dave Chinner <dchinner@redhat.com>

Which references a commit made in 2007 (6 years prior) that
converted XFS to use the VFS filldir mechanism and that was the
original commit that removed the ILOCK from the readdir path and
instead relied on VFS directory locking for access serialisation.


> 
> --D
> 
> > In the above case, "dir/" is passed to XFs as the source inode - the
> > src_dir is "foo/", the target dir is "bar/" and the target inode is
> > null. src_dir != target_dir, so we set the "new_parent" flag. the
> > srouce inode is a directory, so we set the src_is_directory flag,
> > too.
> > 
> > We lock all three inodes that are passed. We do various things, then
> > run:
> > 
> >         if (new_parent && src_is_directory) {
> >                 /*
> >                  * Rewrite the ".." entry to point to the new
> >                  * directory.
> >                  */
> >                 error = xfs_dir_replace(tp, src_ip, &xfs_name_dotdot,
> >                                         target_dp->i_ino, spaceres);
> >                 ASSERT(error != -EEXIST);
> >                 if (error)
> >                         goto out_trans_cancel;
> >         }
> > 
> > which replaces the ".." entry in source inode atomically whilst it
> > is locked.  Any directory format changes that occur during the
> > rename are done while the ILOCK is held, so they appear atomic to
> > outside observers that are trying to parse the directory structure
> > (e.g. readdir).
> > 
> > > So we'd need to lock 'source' if it is a directory.
> > 
> > Yup, and XFS goes further by always locking the source inode in a
> > rename, even if it is not a directory. This ensures the inode being
> > moved cannot have it's metadata otherwise modified whilst the rename
> > is in progress, even if that modification would have no impact on
> > the rename. It's a pretty strict interpretation of "rename is an
> > atomic operation", but it avoids accidentally missing nasty corner
> > cases like the one described above...
> > 
> > > Ideally this would
> > > happen in VFS as otherwise I bet a lot of filesystems will get this wrong
> > > so could vfs_rename() lock 'source' if it is a dir as well? Essentially
> > > this would amount to calling lock_two_nondirectories(source, target)
> > > unconditionally but that would become a serious misnomer ;). Al, any
> > > thought?
> > 
> > XFS just has a function that allows for an arbitrary number of
> > inodes to be locked in the given order: xfs_lock_inodes(). For
> > rename, the lock order is determined by xfs_sort_for_rename().
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 

-- 
Dave Chinner
david@fromorbit.com
