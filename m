Return-Path: <linux-fsdevel+bounces-21627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526C906970
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6951F238E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5C1411F8;
	Thu, 13 Jun 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqmuBfJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F394140E22;
	Thu, 13 Jun 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272542; cv=none; b=fKX60B7m6jB/U1xYJLrvw3qvYkfsJnQXLQOFjIilJDNHMbVO1Q/hPmSvxzSUtI9+AUpP8VTpZHoNJ8d4/aYDnyaKXXl2ext6akw3AJmPHueDHEtIOLQAkIpmXWSubvNWoBBvIiHZc2KTb0lDT7+stJhJKtIbIyOneAeQy1rqKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272542; c=relaxed/simple;
	bh=XmS+lF9Ds2ss/fP43EzxkHbFuhkOym3rDSSC14WaCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GayyhwC6fmTSzP25e6kh5Y0ORw1SJWxlpMtvfpYLrfTJPUDD7K1XxSusy+sEePrq0eq9846z7nICmIfChBh7rvORsHlaySjit6/JCzahrZvPsuqCT7tjbyt6n7lyT19xc9OTuigpAr3hMEZOreWZeMXtpDyQLhG7hRrXwoamQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqmuBfJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4425EC3277B;
	Thu, 13 Jun 2024 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718272541;
	bh=XmS+lF9Ds2ss/fP43EzxkHbFuhkOym3rDSSC14WaCpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqmuBfJyQ4ulCxseiCrrkDyL3guNZ29qhM/nw9/qf902UeGvp+PzW/70QDUWHtXB/
	 eJxK8BCW7uu/3vi4UosB69ghoU196sWwfaIhsQUQ4i/dE0eBjibdHnvPENskMtJ2CU
	 O9SNGkbCeMfKv3fxMQjwjjk1K5FbafqpZamVKJmn5QEwffu8s8t/qs6fvQH4Afow9d
	 TtxMeemVo9PifqenT0pJhdS4SJzfeQltd5M6J8OXETwPxlHvF66QDaWpiI+R0wI8BS
	 YGdEjjUp+cdgZ20w4CJEzd8yFlYS64KParP7UdMaFzuJWG8BAjITTqYHSKVU9hNHAE
	 ugTk/SRH+Zm5A==
Date: Thu, 13 Jun 2024 11:55:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, 
	linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Flaky test: generic/085
Message-ID: <20240613-lackmantel-einsehen-90f0d727358d@brauner>
References: <20240611085210.GA1838544@mit.edu>
 <20240611163701.GK52977@frogsfrogsfrogs>
 <20240612-abdrehen-popkultur-80006c9e4c8d@brauner>
 <20240612144716.GB1906022@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhjf4qywshxgjish"
Content-Disposition: inline
In-Reply-To: <20240612144716.GB1906022@mit.edu>


--zhjf4qywshxgjish
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jun 12, 2024 at 03:47:16PM GMT, Theodore Ts'o wrote:
> On Wed, Jun 12, 2024 at 01:25:07PM +0200, Christian Brauner wrote:
> > I've been trying to reproduce this with pmem yesterday and wasn't able to.
> > 
> > What's the kernel config and test config that's used?
> >
> 
> The kernel config can be found here:
> 
> https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/config-6.1
> 
> Drop it into .config in the build directory of any kernel sources
> newer than 6.1, and then run "make olddefconfig".  This is all
> automated in the install-kconfig script which I use:
> 
> https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig
> 
> The VM has 4 CPU's, and 26GiB of memory, and kernel is booted with the
> boot command line options "memmap=4G!9G memmap=9G!14G", which sets up
> fake /dev/pmem0 and /dev/pmem1 devices backed by RAM.  This is my poor
> engineer's way of testing DAX without needing to get access to
> expensive VM's with pmem.  :-)
> 
> I'm assuming this is a timing-dependant bug which is easiest to
> trigger on fast devices, so a ramdisk might also work.  FWIW, I also
> can see failures relatively frequently using the ext4/nojournal
> configuration on a SSD-backed cloud block device (GCE's Persistent
> Disk SSD product).
> 
> As a result, if you grab my xfstests-bld repo from github, and then
> run "qemu-xfstests -c ext4/nojournal C 20 generic/085" it should
> also reproduce.  See the Documentation/kvm-quickstart.md for more details.

Thanks, Ted! Ok, I think I figured it out.

P1
dm_resume()
-> bdev_freeze()
   mutex_lock(&bdev->bd_fsfreeze_mutex);
   atomic_inc_return(&bdev->bd_fsfreeze_count); // == 1
   mutex_unlock(&bdev->bd_fsfreeze_mutex);

P2						P3
setup_bdev_super()
bdev_file_open_by_dev();
atomic_read(&bdev->bd_fsfreeze_count); // != 0

						bdev_thaw()
						mutex_lock(&bdev->bd_fsfreeze_mutex);
						atomic_dec_return(&bdev->bd_fsfreeze_count); // == 0
						mutex_unlock(&bdev->bd_fsfreeze_mutex);
						bd_holder_lock();
						// grab passive reference on sb via sb->s_count
						bd_holder_unlock();
						// Sleep to be woken when superblock ready or dead
bdev_fput()
bd_holder_lock()
// yield bdev
bd_holder_unlock()

deactivate_locked_super()
// notify that superblock is dead

						// get woken and see that superblock is dead; fail

In words this basically means that P1 calls dm_suspend() which calls
into bdev_freeze() before the block device has been claimed by the
filesystem. This brings bdev->bd_fsfreeze_count to 1 and no call into
fs_bdev_freeze() is required.

Now P2 tries to mount that frozen block device. It claims it and checks
bdev->bd_fsfreeze_count. As it's elevated it aborts mounting holding
sb->s_umount all the time ofc.

In the meantime P3 calls dm_resume() it sees that the block device is
already claimed by a filesystem and calls into fs_bdev_thaw().

It takes a passive reference and realizes that the filesystem isn't
ready yet. So P3 puts itself to sleep to wait for the filesystem to
become ready.

P2 puts the last active reference to the filesystem and marks it as
dying.

Now P3 gets woken, sees that the filesystem is dying and
get_bdev_super() fails.

So Darrick is correct about the fix but the reasoning is a bit
different. :)

Patch appended and on #vfs.fixes.

--zhjf4qywshxgjish
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-don-t-misleadingly-warn-during-thaw-operations.patch"

From 35224b919d6778ca5dd11f76659ae849594bd2bf Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Jun 2024 11:38:14 +0200
Subject: [PATCH] fs: don't misleadingly warn during thaw operations

The block device may have been frozen before it was claimed by a
filesystem. Concurrently another process might try to mount that
frozen block device and has temporarily claimed the block device for
that purpose causing a concurrent fs_bdev_thaw() to end up here. The
mounter is already about to abort mounting because they still saw an
elevanted bdev->bd_fsfreeze_count so get_bdev_super() will return
NULL in that case.

For example, P1 calls dm_suspend() which calls into bdev_freeze() before
the block device has been claimed by the filesystem. This brings
bdev->bd_fsfreeze_count to 1 and no call into fs_bdev_freeze() is
required.

Now P2 tries to mount that frozen block device. It claims it and checks
bdev->bd_fsfreeze_count. As it's elevated it aborts mounting.

In the meantime P3 calls dm_resume() it sees that the block device is
already claimed by a filesystem and calls into fs_bdev_thaw().

It takes a passive reference and realizes that the filesystem isn't
ready yet. So P3 puts itself to sleep to wait for the filesystem to
become ready.

P2 puts the last active reference to the filesystem and marks it as
dying. Now P3 gets woken, sees that the filesystem is dying and
get_bdev_super() fails.

Fixes: 49ef8832fb1a ("bdev: implement freeze and thaw holder operations")
Cc: <stable@vger.kernel.org>
Reported-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20240611085210.GA1838544@mit.edu
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index b72f1d288e95..095ba793e10c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1502,8 +1502,17 @@ static int fs_bdev_thaw(struct block_device *bdev)
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
 
+	/*
+	 * The block device may have been frozen before it was claimed by a
+	 * filesystem. Concurrently another process might try to mount that
+	 * frozen block device and has temporarily claimed the block device for
+	 * that purpose causing a concurrent fs_bdev_thaw() to end up here. The
+	 * mounter is already about to abort mounting because they still saw an
+	 * elevanted bdev->bd_fsfreeze_count so get_bdev_super() will return
+	 * NULL in that case.
+	 */
 	sb = get_bdev_super(bdev);
-	if (WARN_ON_ONCE(!sb))
+	if (!sb)
 		return -EINVAL;
 
 	if (sb->s_op->thaw_super)
-- 
2.43.0


--zhjf4qywshxgjish--

