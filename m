Return-Path: <linux-fsdevel+bounces-67781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC0C49DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49513A9FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FBC199EAD;
	Tue, 11 Nov 2025 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="MHv9s7Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C30194A6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820605; cv=none; b=mkG9Uf+JBaTIJEEo9LY6FIyYQKfKdx58A2LTW0X+YMdZOr8I4ufbltknKmn8hvfefPhcGbvLhxA9tWAlGVqPGuaN/S4fewnnIcYGy48AhU8vt74ymDnhc6oYBpq0YfNhdGyJuBEAZj8KW5wbj+nXy1ety5aiwMjMxsi4CGqXDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820605; c=relaxed/simple;
	bh=bPPdzsFCYqmZxZG1oaCETVPCkyCDDs3i4xm8UUoKQvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nuhw5f5W7AbJzD+CCYgKaJxehAdDw4RDzUrq4TEU7/MBCfa1MZ7qxAJuYW6It6k3iMwsir3xdO0a3p1m8Dj+BeyNMVuxeIQKLxUyUiGckJyb511PK87olkkg8RJZBiJeCQDVj/jw5a1vIBsOkqq3C69ODT5vJKNzMTJAvDIBDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=MHv9s7Ny; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Tue, 11 Nov 2025 00:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1762820591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MzVfzkvlgrw/5KjtWHCkGWxkY9koFjZVoe3P9pnd+0=;
	b=MHv9s7NyTDDpSTBAokrLPAFFoIjoc34+qo8Nw3cILbrnBCkLgGVbXuKQkXdJJTeVa+S25J
	/aj9f2w3MOXh/8hXywySn9TX4XgKbN7zCXYrsd/wvQc8d3OrQWe8Gpkt1Up1xJgtqtHRpC
	+Xi2Hdd0DCZEMYhYf3DtCWW4EuM0HiL8/+546z0oB8CUk+Jp7mX5IRoVG399MsXGDVSPS7
	5ekbkJ+p6w3DObP+U8w1Wi5ZxrW2iBA0+Iir4k7730t5AobI86QGZ7pZnzBWbabFxOTV0H
	bSt761VAkd2k5ia3QRhk19TwwpFeX/0rYkYN6IBteypNOnOMu6Bp4JZI0wKVHQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hfs: Update sanity check of the root record
Message-ID: <aRKB8C2f1Auy0ccA@Bertha>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-4-contact@gvernon.com>
 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
 <aRJvXWcwkUeal7DO@Bertha>
 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 10, 2025 at 11:34:39PM +0000, Viacheslav Dubeyko wrote:
> On Mon, 2025-11-10 at 23:03 +0000, George Anthony Vernon wrote:
> > On Tue, Nov 04, 2025 at 11:01:31PM +0000, Viacheslav Dubeyko wrote:
> > > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > > syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> > > > operation when the inode number of the record retrieved as a result of
> > > > hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
> > > > b905bafdea21 ("hfs: Sanity check the root record") checked the record
> > > > size and the record type but did not check the inode number.
> > > > 
> > > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b    
> > > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > > ---
> > > >  fs/hfs/super.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > index 47f50fa555a4..a7dd20f2d743 100644
> > > > --- a/fs/hfs/super.c
> > > > +++ b/fs/hfs/super.c
> > > > @@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > > >  			goto bail_hfs_find;
> > > >  		}
> > > >  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> > > > -		if (rec.type != HFS_CDR_DIR)
> > > > +		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
> > > 
> > > This check is completely unnecessary. Because, we have hfs_iget() then [1]:
> > > 
> > > The hfs_iget() calls iget5_locked() [2]:
> > > 
> > > And iget5_locked() calls hfs_read_inode(). And hfs_read_inode() will call
> > > is_valid_cnid() after applying your patch. So, is_valid_cnid() in
> > > hfs_read_inode() can completely manage the issue. This is why we don't need in
> > > this modification after your first patch.
> > > 
> > 
> > I think Tetsuo's concern is that a directory catalog record with
> > cnid > 15 might be returned as a result of hfs_bnode_read, which
> > is_valid_cnid() would not protect against. I've satisfied myself that
> > hfs_bnode_read() in hfs_fill_super() will populate hfs_find_data fd
> > correctly and crash out if it failed to find a record with root CNID so
> > this path is unreachable and there is no need for the second patch.
> > 
> 
> Technically speaking, we can adopt this check to be completely sure that nothing
> will be wrong during the mount operation. But I believe that is_valid_cnid()
> should be good enough to manage this. Potential argument could be that the check
> of rec.dir.DirID could be faster operation than to call hfs_iget(). But mount is
> rare and not very fast operation, anyway. And if we fail to mount, then the
> speed of mount operation is not very important.

Agreed we're not worried about speed that the mount operation can reach
fail case. The check would have value if the bnode populated in
hfs_find_data fd by hfs_cat_find_brec() is bad. That would be very
defensive, I'm not sure it's necessary.

Maybe is_valid_cnid() should be is_valid_catalog_cnid(), since that is
what it is actually testing for at the interface with the VFS. Would you
agree?

> 
> > > But I think we need to check that root_inode is not bad inode afterwards:
> > > 
> > > 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
> > > 	hfs_find_exit(&fd);
> > > 	if (!root_inode || is_bad_inode(root_inode))
> > > 		goto bail_no_root;
> > 
> > Agreed, I see hfs_read_inode might return a bad inode. Thanks for
> > catching this. I noticed also that it returns an int but the return
> > value holds no meaning; it is always zero.
> > 
> > 
> 
> I've realized that hfs_write_inode() doesn't check that inode is bad like other
> file systems do. Probably, we need to have this check too.

Good point, and similarly with HFS+. I'll take a look.

Thanks,

George

