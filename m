Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74026E176C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfJWKLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 06:11:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35177 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390965AbfJWKLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:11:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id c8so7055355pgb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/JJfj5UCucEgZ1HT5YmSO7z7+4ytGahSLO8+3xBQlI=;
        b=zTe9+cj7KqcrGF1xNdawr9cqizWjoo62iqFQs0WN6/IQxvRPq1feLRdoHi60og98C5
         JYmt134fHesenLSvKkhEQfAfF2915td09xSrxFZiIyvAAtkgjrP59uWfgeObFhUgr47P
         0JPpByTtA4seUmFVc+gEWC0QELydJWr4f3KbE2IvU3ngTlyF8amHLNCK+k/LN3eS/bjQ
         1YMnglz634vVJShIWeW6flse75fXhMc2AJ95j/TbUAqxr8Vic9FlplHucpPpLqgxxaba
         kaN/6WVuKU5xQHAd7IJrctxbPsHaEKmbWqmwWnOqQ0vArjT6Ww2FXLD3mHG9Jsu6CLt7
         k1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/JJfj5UCucEgZ1HT5YmSO7z7+4ytGahSLO8+3xBQlI=;
        b=U83wnc1vh5XdNyNKyEGzMX1RKOapQzqyMV7OvgTj+qffKfjXeQenlxoNIJVAbnjS0+
         ds2ej1OMJN1C8hdnwzPtToGIkp2hDJzHNQ15oAg92IJyXluggWKWXwZ7+6A66G9QvibP
         hYy/7vWDWoy3LvpzQvcw0J/JglrEDnaad9eX0w4B9umk3iZbhD23SmpT8sz3oBiJsmyK
         KIRpL7Q8eWKexlWeIStJNH4W+FZgQmHrEEV/CueO2oivHwCFoNMoF7dFzNhHbBdvPD7R
         zxrPQ9VoGDlTmGHMFWa8CNdXA/Uoy+QLMiQs3iLM0H0r9xQ7k50Jzvzs1KBbwT0nkB0w
         9SAg==
X-Gm-Message-State: APjAAAUxV8NvpSw3v6a7SIXdHzybimz+HhLC3/lWpSoldHUvAgY6PBFD
        cKWwbwVyUJ544Fv+wJdY8g4URujP8w==
X-Google-Smtp-Source: APXvYqwHCn9oC4NGlpxjKkMAz5iBHxT8IueONjaFYpoPpmJGp6pJz4DMffXTVmfg23K0cpYM4JMLcA==
X-Received: by 2002:aa7:9aa2:: with SMTP id x2mr9729165pfi.103.1571825505035;
        Wed, 23 Oct 2019 03:11:45 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id k17sm30781107pgh.30.2019.10.23.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:11:44 -0700 (PDT)
Date:   Wed, 23 Oct 2019 21:11:38 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191023101138.GA6725@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
 <20191023023519.GA16505@bobrowski>
 <20191023100153.GB22307@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20191023100153.GB22307@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 12:01:53PM +0200, Jan Kara wrote:
> On Wed 23-10-19 13:35:19, Matthew Bobrowski wrote:
> > On Mon, Oct 21, 2019 at 09:43:30PM +0200, Jan Kara wrote:
> > > On Mon 21-10-19 09:31:12, Theodore Y. Ts'o wrote:
> > > > Hi Matthew, thanks for your work on this patch series!
> > > > 
> > > > I applied it against 4c3, and ran a quick test run on it, and found
> > > > the following locking problem.  To reproduce:
> > > > 
> > > > kvm-xfstests -c nojournal generic/113
> > > > 
> > > > generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
> > > > [    7.959477] 
> > > > [    7.959798] ============================================
> > > > [    7.960518] WARNING: possible recursive locking detected
> > > > [    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
> > > > [    7.961991] --------------------------------------------
> > > > [    7.962569] aio-stress/1516 is trying to acquire lock:
> > > > [    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
> > > > [    7.964109] 
> > > > [    7.964109] but task is already holding lock:
> > > > [    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
> > > 
> > > This is going to be a tricky one. With iomap, the inode locking is handled
> > > by the filesystem while calling generic_write_sync() is done by
> > > iomap_dio_rw(). I would really prefer to avoid tweaking iomap_dio_rw() not
> > > to call generic_write_sync(). So we need to remove inode_lock from
> > > __generic_file_fsync() (used from ext4_sync_file()). This locking is mostly
> > > for legacy purposes and we don't need this in ext4 AFAICT - but removing
> > > the lock from __generic_file_fsync() would mean auditing all legacy
> > > filesystems that use this to make sure flushing inode & its metadata buffer
> > > list while it is possibly changing cannot result in something unexpected. I
> > > don't want to clutter this series with it so we are left with
> > > reimplementing __generic_file_fsync() inside ext4 without inode_lock. Not
> > > too bad but not great either. Thoughts?
> > 
> > So, I just looked at this on my lunch break and I think the simplest
> > approach would be to just transfer the necessary chunks of code from
> > within __generic_file_fsync() into ext4_sync_file() for !journal cases,
> > minus the inode lock, and minus calling into __generic_file_fsync(). I
> > don't forsee this causing any issues, but feel free to correct me if I'm
> > wrong.
> 
> Yes, that's what I'd suggest as well. In fact when doing that you can share
> file_write_and_wait_range() call with the one already in ext4_sync_file()
> use for other cases. Similarly with file_check_and_advance_wb_err(). So the
> copied bit will be really only:
> 
>         ret = sync_mapping_buffers(inode->i_mapping);
>         if (!(inode->i_state & I_DIRTY_ALL))
>                 goto out;
>         if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
>                 goto out;
> 
>         err = sync_inode_metadata(inode, 1);
>         if (ret == 0)
>                 ret = err;
> 
> > If this is deemed to be OK, then I will go ahead and include this as a
> > separate patch in my series.
> 
> Yes, please.

Heh!

I just finished writing and testing it and exactly what I've done
(attached). Anyway, I will include it in v6. :)

--<M>--

--jRHKVT23PllUwdXP
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-update-ext4_sync_file-to-not-use-__generic_file.patch"

From 4c82edb34324f91788c941956954d4e7e1886c2c Mon Sep 17 00:00:00 2001
From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Wed, 23 Oct 2019 17:43:23 +1100
Subject: [PATCH 1/2] ext4: update ext4_sync_file() to not use
 __generic_file_fsync()

When the filesystem is created without a journal, we eventually call
into __generic_file_fsync() in order to write out all the modified
in-core data to the permanent storage device. This function happens to
try and obtain an inode_lock() while synchronizing the files buffer
and it's associated metadata.

Generally, this is fine, however it becomes a problem when there is
higher level code that has already obtained an inode_lock() as this
leads to a recursive lock situation. This case is especially true when
porting across direct I/O to iomap infrastructure as we obtain an
inode_lock() early on in the I/O within ext4_dio_write_iter() and hold
it until the I/O has been completed. Consequently, to not run into
this specific issue, we move away from calling into
__generic_file_fsync() and perform the necessary synchronization tasks
within ext4_sync_file().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/fsync.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..9e11868e82f9 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -116,8 +116,21 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
+
 	if (!journal) {
-		ret = __generic_file_fsync(file, start, end, datasync);
+		ret = sync_mapping_buffers(inode->i_mapping);
+		if (!(inode->i_state & I_DIRTY_ALL))
+			goto out;
+		if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+			goto out;
+
+		err = sync_inode_metadata(inode, 1);
+		if (!ret)
+			ret = err;
+
 		if (!ret)
 			ret = ext4_sync_parent(inode);
 		if (test_opt(inode->i_sb, BARRIER))
@@ -125,9 +138,6 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 
-	ret = file_write_and_wait_range(file, start, end);
-	if (ret)
-		return ret;
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
-- 
2.20.1


--jRHKVT23PllUwdXP--
