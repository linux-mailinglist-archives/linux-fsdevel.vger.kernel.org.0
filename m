Return-Path: <linux-fsdevel+bounces-67772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F9C49B18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9844ED6CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A802FF648;
	Mon, 10 Nov 2025 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="A9ijqw1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BB22B8B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815842; cv=none; b=dNz5SOqeV7jpf5KC5WUN30QdzGp2KXRY5tycekcW7uYnR977SYxlW7t8syScoSrLGhKPjCkPmK0OEsX5dlEtS3cetbWkKn8izx7za5NBmGikDsIwXKtIzRTPfMBx3g0BY9fGi0n980xzUHR3PNUGy92Ye0BUjDPzIUFvPsA950w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815842; c=relaxed/simple;
	bh=SpBXcCXhucc4vOTbhq3IyeNwX9Ph+ezvTLGmCPeyPVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu1j2aTPlOnKOrask8XMUF3IfsuXQ1S7HKJv9ILcDRg4/2gHrqfF/ZFu8ZUTqO14qCjlyjcHJTzeqBEC3XmszcOdT1E8CZ65M5AHYmmIMjk+MAsJBUSSr4WDXn+MMhgkDneQ8a2dwvklmvQoLZBtuUxwSl0jdTaq4zEFsMe1QqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=A9ijqw1p; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Mon, 10 Nov 2025 23:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1762815828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqdKJLsgz2wpHczRCT84sJa40n6KuIUNVZ83IxQxhI8=;
	b=A9ijqw1pL8UsQDLt09M5yWaNkOxZZs3w2n/hJKCSDEOoJQtfrfqr1f9FXTYEZB+3V5BKbl
	8hnHF+QyjocsFwB5e9MP53PAUIuF+dvBApji7K/1Iymd/b0LJs/xMy6H7B3tSsI1QsPu19
	cKSvlVg2Ex/PHP+w8pTnIWejlyV0g+Ul6uwT7BEkZuUkaD7km6RT62AEKjW2Kv5r0LkZNM
	KUnq4K/n2R94lR4AnHaDB+5k2SvgITC6BzQthfthvxc2MAR+LoZ+F0uha4cDYnWBbwDOPb
	EkPaXiaHNCIaftkFawrYP4AqnWt+CTYNmtzu4HI3UYvDgCqDB8AQ08kXGpnDkg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>,
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 2/2] hfs: Update sanity check of the root record
Message-ID: <aRJvXWcwkUeal7DO@Bertha>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-4-contact@gvernon.com>
 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 04, 2025 at 11:01:31PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> > operation when the inode number of the record retrieved as a result of
> > hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
> > b905bafdea21 ("hfs: Sanity check the root record") checked the record
> > size and the record type but did not check the inode number.
> > 
> > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b  
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > ---
> >  fs/hfs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index 47f50fa555a4..a7dd20f2d743 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  			goto bail_hfs_find;
> >  		}
> >  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> > -		if (rec.type != HFS_CDR_DIR)
> > +		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
> 
> This check is completely unnecessary. Because, we have hfs_iget() then [1]:
> 
> The hfs_iget() calls iget5_locked() [2]:
> 
> And iget5_locked() calls hfs_read_inode(). And hfs_read_inode() will call
> is_valid_cnid() after applying your patch. So, is_valid_cnid() in
> hfs_read_inode() can completely manage the issue. This is why we don't need in
> this modification after your first patch.
> 

I think Tetsuo's concern is that a directory catalog record with
cnid > 15 might be returned as a result of hfs_bnode_read, which
is_valid_cnid() would not protect against. I've satisfied myself that
hfs_bnode_read() in hfs_fill_super() will populate hfs_find_data fd
correctly and crash out if it failed to find a record with root CNID so
this path is unreachable and there is no need for the second patch.

> But I think we need to check that root_inode is not bad inode afterwards:
> 
> 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
> 	hfs_find_exit(&fd);
> 	if (!root_inode || is_bad_inode(root_inode))
> 		goto bail_no_root;

Agreed, I see hfs_read_inode might return a bad inode. Thanks for
catching this. I noticed also that it returns an int but the return
value holds no meaning; it is always zero.

> Thanks,
> Slava.
>

Many thanks again,

George

