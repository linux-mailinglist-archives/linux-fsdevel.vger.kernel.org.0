Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D175D6D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJOCMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 22:12:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfJOCMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:12:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so8806232plp.6;
        Mon, 14 Oct 2019 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QkrBW78afE0mQwWYjfkjXOFMLoHqmY36U1/V151SyV4=;
        b=OZVQhXv/nbs175o9O2gug9qXbAkURJTb5dRnma8sorrZi4V2NYZNFz6aJ0ZJUXDxEM
         ukXnyaB5/9c+Bm8kpCXHusb60AFqZ7R/zOtJtXysndSXoQ/O2R/ppi0znVmvlPWLTPCh
         aZbhtfC/vdtYe1md2ezzkAuz35pGxMd4RpbDiUX6h8m9x3/X8T+rrvgbOy7AQOfuz+6j
         AKNvNU8/HPlNt4yxnNr5wwwxMwFiJZvO8pLj8dd1sMFcA7p958Cst+tPxbj59638G1Ju
         F39PTHoDVM6ACPeEBGeQdWTfxVj2Jxq87+h4gz2ncTEbMqnvwHF4xkDfPZFsDd8yBMts
         i+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QkrBW78afE0mQwWYjfkjXOFMLoHqmY36U1/V151SyV4=;
        b=jkEJRygXEcYt4q94oEl1cL1383FF9/JdjmlsmakS9xm1wabXZXDFFXsLe/NEWKJ9s9
         FXDFxAcP2cvoWVgB+K2MMlyNxv4wHSwRx5uR03cFG70YmiHRwbg6UwBCa5voI6a3CTim
         i0tGCK7JKx/Jy2396ewrCY+75Tp1T7OKCDWcLNwHvtolL8u9sZcl2Tdv7siT8I54ze8q
         eyINFmy90gvw4y5DHfale4PW8vI9DMYJXGtzWKJUZLl/KXchOxl5rznU7VgLzywuBBmk
         /xykjGjmh4DsYUtReaxcWUwmf3FoT1zgPUGxLzOB2/TOoRiVm16zuc1CdJ3gVfnMKrNz
         Q5sg==
X-Gm-Message-State: APjAAAVz94/uJQ0BMPp848Y1+AkkmzQHBHdETCoGCBFkUdxE+ih3Mo7D
        f43JKIP8e+nu36q6QVNYSw==
X-Google-Smtp-Source: APXvYqxU06DbwSsvNnwFQ7+825WJKzoBMS5002wiGqa3CdsIYCBQ+5QUDJjG8RSeC96No3dtrNx9DQ==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr33837178plo.145.1571105569194;
        Mon, 14 Oct 2019 19:12:49 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f6sm20266446pfq.169.2019.10.14.19.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 19:12:48 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:12:42 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: introduce "metasync" api to sync metadata to fsblock
Message-ID: <20191015021242.GB14327@mypc>
References: <1570977420-3944-1-git-send-email-kernelfans@gmail.com>
 <20191013163417.GQ13108@magnolia>
 <20191014083315.GA10091@mypc>
 <20191014094311.GD5939@quack2.suse.cz>
 <d3ffa114-8b73-90dc-8ba6-3f44f47135d7@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ffa114-8b73-90dc-8ba6-3f44f47135d7@sandeen.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:23:39AM -0500, Eric Sandeen wrote:
> On 10/14/19 4:43 AM, Jan Kara wrote:
> > On Mon 14-10-19 16:33:15, Pingfan Liu wrote:
> > > On Sun, Oct 13, 2019 at 09:34:17AM -0700, Darrick J. Wong wrote:
> > > > On Sun, Oct 13, 2019 at 10:37:00PM +0800, Pingfan Liu wrote:
> > > > > When using fadump (fireware assist dump) mode on powerpc, a mismatch
> > > > > between grub xfs driver and kernel xfs driver has been obsevered.  Note:
> > > > > fadump boots up in the following sequence: fireware -> grub reads kernel
> > > > > and initramfs -> kernel boots.
> > > > > 
> > > > > The process to reproduce this mismatch:
> > > > >    - On powerpc, boot kernel with fadump=on and edit /etc/kdump.conf.
> > > > >    - Replacing "path /var/crash" with "path /var/crashnew", then, "kdumpctl
> > > > >      restart" to rebuild the initramfs. Detail about the rebuilding looks
> > > > >      like: mkdumprd /boot/initramfs-`uname -r`.img.tmp;
> > > > >            mv /boot/initramfs-`uname -r`.img.tmp /boot/initramfs-`uname -r`.img
> > > > >            sync
> > > > >    - "echo c >/proc/sysrq-trigger".
> > > > > 
> > > > > The result:
> > > > > The dump image will not be saved under /var/crashnew/* as expected, but
> > > > > still saved under /var/crash.
> > > > > 
> > > > > The root cause:
> > > > > As Eric pointed out that on xfs, 'sync' ensures the consistency by writing
> > > > > back metadata to xlog, but not necessary to fsblock. This raises issue if
> > > > > grub can not replay the xlog before accessing the xfs files. Since the
> > > > > above dir entry of initramfs should be saved as inline data with xfs_inode,
> > > > > so xfs_fs_sync_fs() does not guarantee it written to fsblock.
> > > > > 
> > > > > umount can be used to write metadata fsblock, but the filesystem can not be
> > > > > umounted if still in use.
> > > > > 
> > > > > There are two ways to fix this mismatch, either grub or xfs. It may be
> > > > > easier to do this in xfs side by introducing an interface to flush metadata
> > > > > to fsblock explicitly.
> > > > > 
> > > > > With this patch, metadata can be written to fsblock by:
> > > > >    # update AIL
> > > > >    sync
> > > > >    # new introduced interface to flush metadata to fsblock
> > > > >    mount -o remount,metasync mountpoint
> > > > 
> > > > I think this ought to be an ioctl or some sort of generic call since the
> > > > jbd2 filesystems (ext3, ext4, ocfs2) suffer from the same "$BOOTLOADER
> > > > is too dumb to recover logs but still wants to write to the fs"
> > > > checkpointing problem.
> > > Yes, a syscall sounds more reasonable.
> > > > 
> > > > (Or maybe we should just put all that stuff in a vfat filesystem, I
> > > > don't know...)
> > > I think it is unavoidable to involve in each fs' implementation. What
> > > about introducing an interface sync_to_fsblock(struct super_block *sb) in
> > > the struct super_operations, then let each fs manage its own case?
> > 
> > Well, we already have a way to achieve what you need: fsfreeze.
> > Traditionally, that is guaranteed to put fs into a "clean" state very much
> > equivalent to the fs being unmounted and that seems to be what the
> > bootloader wants so that it can access the filesystem without worrying
> > about some recovery details. So do you see any problem with replacing
> > 'sync' in your example above with 'fsfreeze /boot && fsfreeze -u /boot'?
> > 
> > 								Honza
> 
> The problem with fsfreeze is that if the device you want to quiesce is, say,
> the root fs, freeze isn't really a good option.
Yes, that is the difference between my patch and fsfreeze.  But
honestly, it is a rare case where a system has not a /boot partition. Due
to the activity on /boot is very low, fsfreeze may meet the need, or
repeatly retry fsfress until success.
> 
> But the other thing I want to highlight about this approach is that it does not
> solve the root problem: something is trying to read the block device without
> first replaying the log.
> 
> A call such as the proposal here is only going to leave consistent metadata at
> the time the call returns; at any time after that, all guarantees are off again,
My patch places assumption that grub only accesses limited files and ensures the
consistency only on those files (kernel,initramfs).
> so the problem hasn't been solved.
Agree. The perfect solution should be a log aware bootloader.

Thanks and regards,
	Pingfan
