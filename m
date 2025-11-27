Return-Path: <linux-fsdevel+bounces-69987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C025CC8D6C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDBB74E3082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0139322DCB;
	Thu, 27 Nov 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Sru5lX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A8523A;
	Thu, 27 Nov 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233986; cv=none; b=r327t4PrYkBXPowkFeEhLQYB2581v1sDbO+lk2ygThsQoxpTjt9ku+7LvV+jw06cL6V1BV6Aqru8ks+Q6BqhiHSZ/OJ2vsdrTakPyVcFwg5QhzUFB2MOq8Ys/fw5USZFCZfnME8v+G5YWrhhoa8r6szmSGSzw234BSGxV1+m9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233986; c=relaxed/simple;
	bh=K7L4/jvZc//+cYcnqmq6QC79EIlf70HKP8W2f73TFCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q39trTrVUkMi/BFY8NI96YqQ8uKhaTrItcUEmMVJBZJR09kjkyFGBbAKrFIPfmBUy23o+h+FQlCFQ3+Twql0G3SIAalnzAIYu1JZW1owKHjX2j2zQes23ePVDmVilrBBW0iNzTBj20Peq1cZUhEEp/cFfImVf107HyJ5HS4b3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Sru5lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E85C4CEF8;
	Thu, 27 Nov 2025 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764233985;
	bh=K7L4/jvZc//+cYcnqmq6QC79EIlf70HKP8W2f73TFCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5Sru5lX8VMq7bXc72QG80lNHav95iyKAr9Z/9u2PCdU3Zg6TeRd9lFqNaQC34F8/
	 3EY4PR23KeAv5ubheVNPO6fVwAs3/Fo63xzK2jspyb3KrY+gWokDn57y1CV3BruPay
	 GAh2s1elh85S43p5cYzOXvKX5u84UbwOc6APy86uceLoqvey0APNYD1bZ2ltvUu/kz
	 bf7WjE5h7IOsRk2UF5RfXjpSflE/FjdAVYnh4BTg/NA3yieY85tFXuvgqi4t5E6Bdi
	 UoQQhnOXr4ju4E3WzWGGBwBKmTwVMA+kE8+0ldAWzEksBTXnkrwvubFwtCq3ZITCSN
	 bxyhLPOw0JXQg==
Date: Thu, 27 Nov 2025 09:59:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>, 
	"jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>, 
	"frank.li@vivo.com" <frank.li@vivo.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>, "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com" <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
Message-ID: <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>

On Wed, Nov 26, 2025 at 10:30:30PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2025-11-26 at 17:06 +0100, Mehdi Ben Hadj Khelifa wrote:
> > On 11/26/25 2:48 PM, Christian Brauner wrote:
> > > On Wed, Nov 19, 2025 at 07:58:21PM +0000, Viacheslav Dubeyko wrote:
> > > > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > The regression introduced by commit aca740cecbe5 ("fs: open block device
> > > > > after superblock creation") allows setup_bdev_super() to fail after a new
> > > > > superblock has been allocated by sget_fc(), but before hfs_fill_super()
> > > > > takes ownership of the filesystem-specific s_fs_info data.
> > > > > 
> > > > > In that case, hfs_put_super() and the failure paths of hfs_fill_super()
> > > > > are never reached, leaving the HFS mdb structures attached to s->s_fs_info
> > > > > unreleased.The default kill_block_super() teardown also does not free
> > > > > HFS-specific resources, resulting in a memory leak on early mount failure.
> > > > > 
> > > > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> > > > > hfs_put_super() and the hfs_fill_super() failure path into a dedicated
> > > > > hfs_kill_sb() implementation. This ensures that both normal unmount and
> > > > > early teardown paths (including setup_bdev_super() failure) correctly
> > > > > release HFS metadata.
> > > > > 
> > > > > This also preserves the intended layering: generic_shutdown_super()
> > > > > handles VFS-side cleanup, while HFS filesystem state is fully destroyed
> > > > > afterwards.
> > > > > 
> > > > > Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
> > > > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6  
> > > > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> > > > > ---
> > > > > ChangeLog:
> > > > > 
> > > > > Changes from v1:
> > > > > 
> > > > > -Changed the patch direction to focus on hfs changes specifically as
> > > > > suggested by al viro
> > > > > 
> > > > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/  
> > > > > 
> > > > > Note:This patch might need some more testing as I only did run selftests
> > > > > with no regression, check dmesg output for no regression, run reproducer
> > > > > with no bug and test it with syzbot as well.
> > > > 
> > > > Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
> > > > failures for HFS now. And you can check the list of known issues here [1]. The
> > > > main point of such run of xfstests is to check that maybe some issue(s) could be
> > > > fixed by the patch. And, more important that you don't introduce new issues. ;)
> > > > 
> > > > > 
> > > > >   fs/hfs/super.c | 16 ++++++++++++----
> > > > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > > index 47f50fa555a4..06e1c25e47dc 100644
> > > > > --- a/fs/hfs/super.c
> > > > > +++ b/fs/hfs/super.c
> > > > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
> > > > >   {
> > > > >   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > > > >   	hfs_mdb_close(sb);
> > > > > -	/* release the MDB's resources */
> > > > > -	hfs_mdb_put(sb);
> > > > >   }
> > > > >   
> > > > >   static void flush_mdb(struct work_struct *work)
> > > > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > > > >   bail_no_root:
> > > > >   	pr_err("get root inode failed\n");
> > > > >   bail:
> > > > > -	hfs_mdb_put(sb);
> > > > >   	return res;
> > > > >   }
> > > > >   
> > > > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
> > > > >   	return 0;
> > > > >   }
> > > > >   
> > > > > +static void hfs_kill_sb(struct super_block *sb)
> > > > > +{
> > > > > +	generic_shutdown_super(sb);
> > > > > +	hfs_mdb_put(sb);
> > > > > +	if (sb->s_bdev) {
> > > > > +		sync_blockdev(sb->s_bdev);
> > > > > +		bdev_fput(sb->s_bdev_file);
> > > > > +	}
> > > > > +
> > > > > +}
> > > > > +
> > > > >   static struct file_system_type hfs_fs_type = {
> > > > >   	.owner		= THIS_MODULE,
> > > > >   	.name		= "hfs",
> > > > > -	.kill_sb	= kill_block_super,
> > > > 
> > > > It looks like we have the same issue for the case of HFS+ [2]. Could you please
> > > > double check that HFS+ should be fixed too?
> > > 
> > > There's no need to open-code this unless I'm missing something. All you
> > > need is the following two patches - untested. Both issues were
> > > introduced by the conversion to the new mount api.
> > Yes, I don't think open-code is needed here IIUC, also as I mentionned 
> > before I went by the suggestion of Al Viro in previous replies that's my 
> > main reason for doing it that way in the first place.
> > 
> > Also me and Slava are working on testing the mentionned patches, Should 
> > I sent them from my part to the maintainers and mailing lists once 
> > testing has been done?
> > 
> > 
> 
> I have run the xfstests on the latest kernel. Everything works as expected:
> 
> sudo ./check -g auto 
> FSTYP         -- hfsplus
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7 #97 SMP
> PREEMPT_DYNAMIC Tue Nov 25 15:12:42 PST 2025
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/001 22s ...  53s
> generic/002 17s ...  43s
> 
> <skipped>
> 
> Failures: generic/003 generic/013 generic/020 generic/034 generic/037
> generic/039 generic/040 generic/041 generic/056 generic/057 generic/062
> generic/065 generic/066 generic/069 generic/070 generic/073 generic/074
> generic/079 generic/091 generic/097 generic/101 generic/104 generic/106
> generic/107 generic/113 generic/127 generic/241 generic/258 generic/263
> generic/285 generic/321 generic/322 generic/335 generic/336 generic/337
> generic/339 generic/341 generic/342 generic/343 generic/348 generic/363
> generic/376 generic/377 generic/405 generic/412 generic/418 generic/464
> generic/471 generic/475 generic/479 generic/480 generic/481 generic/489
> generic/490 generic/498 generic/502 generic/510 generic/523 generic/525
> generic/526 generic/527 generic/533 generic/534 generic/535 generic/547
> generic/551 generic/552 generic/557 generic/563 generic/564 generic/617
> generic/631 generic/637 generic/640 generic/642 generic/647 generic/650
> generic/690 generic/728 generic/729 generic/760 generic/764 generic/771
> generic/776
> Failed 84 of 767 tests
> 
> Currently, failures are expected. But I don't see any serious crash, especially,
> on every single test.
> 
> So, I can apply two patches that Christian shared and test it on my side.
> 
> I had impression that Christian has taken the patch for HFS already in his tree.
> Am I wrong here? I can take both patches in HFS/HFS+ tree. Let me run xfstests
> with applied patches at first.

Feel free to taken them.

