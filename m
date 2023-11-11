Return-Path: <linux-fsdevel+bounces-2749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F330C7E89BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 09:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180D11C2093B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9C011193;
	Sat, 11 Nov 2023 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LDZsNfK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2F1094B;
	Sat, 11 Nov 2023 08:13:33 +0000 (UTC)
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC583C0C;
	Sat, 11 Nov 2023 00:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699690407; bh=Qqrfldlz7J/reS2ISXYE9aOwEm9dnN1drwDuYH65t08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LDZsNfK07NSlewqEX3WvJVIbtFXjjkNwZXZG68IAYeyFa0zd5DwrzzemqoeRgtO5y
	 gdjqehYFyX+sr6Ltwy3CSnKPzzvAFNfbrwnZ3rzvJ/LSvOIV2CuECN9m9kW2xDmrlJ
	 0Owah4DLkPpCPQUw0D2GW78V34J00E7qfn5sxRaM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 357A4425; Sat, 11 Nov 2023 16:13:23 +0800
X-QQ-mid: xmsmtpt1699690403t4hmdfcmb
Message-ID: <tencent_82622979A3A74448177BF772E6D1736E4305@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWf9rinpoXhvRaEBOxbNV8HPBs3AjPrsECUKXlbUFihgTPBeiWXzL
	 Xy22K48693IE4Wopx/x4O8DOC13QOLyhyHN0rV2Xl7v7xJrBdCjAhVGbWZAY06y/7/bWGwU0IbMJ
	 I61veVK7gJ9WADW/PcGh7ZiZqe4jHYYzad10BqwznM5UkRLWf6PMeFRj48jwdqLYwU+a045eKa/f
	 ZzQVUPm/xvnXpk1Mv4qWtGLSWdzaNRGPjZ9MeYnqYhycGMMYGVk75zz33AEYJD34nz+a5tjo51Ns
	 nug9KxJXBkLSvSKfniOrOwCZrNeXvCUx8OXqx5r3h1NdrOhuqINx61588dSmrVJMhXdXpyy6fmvK
	 b3YTE9+f7mhE6//AF6mJtxy6QnXErpkQ/tq8t0X/FjA6zjshtjzDAkJ8Al3o8nwCPTPl4duRWUtQ
	 OoEeqryIdrlqN3QGJDOV9tTxyihF/EqNtWxGNATwTNQYIwdu6eG7JaWm5CdlDVbYiC0ksdz6G2k8
	 Fr9xyoINSql+jFHBUK96nXi6XKavSNdMky119EkUWmSZmBPSJBpcFACiMoywvWmsosr/GnKtNp0l
	 461hBvfVDxoXdFEjWTfXrQ7BXVqWLxDV79BuRtMaU2S89YK49o0Eo8OgcQ6122YK2sJ0SgTRmn81
	 l0KdQMmSuAJUuSx4Jokeipq7WgOhboW5BNHKM1mpGieNpKxOKNCctpMbS8KgIRyawZ20FzlrjE4g
	 KE3PeA1ZGs/D1lb+9P5okCuGe76Ced3d9QMD8EkzSRMmwyswm0fCyAInpIejkipG846tQIIpZS7h
	 VbOFOnF87onXJL56DiEHxkXOrOv3HZyjzxWoAEBwh6mvquQUSg77ni5BnkZjrOX5sZGrQAVijwTk
	 7m47qzcS8lHxuJkOwjbb7fVihG/WstNjMtnTISl3UPNj+rltM+gyzhH5CZx6mjz/SBAaN6hDeq20
	 hV+pn3HR0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: willy@infradead.org
Cc: boris@bur.io,
	clm@fb.com,
	dsterba@suse.com,
	eadavis@qq.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] test 305230142ae0
Date: Sat, 11 Nov 2023 16:13:24 +0800
X-OQ-MSGID: <20231111081323.4190569-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZU8dS0dlOGOblbxf@casper.infradead.org>
References: <ZU8dS0dlOGOblbxf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Nov 2023 06:20:59 +0000, Matthew Wilcox wrote:
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
> >  		goto out;
> >  	}
> >  
> > -	*objectid = root->free_objectid++;
> > +	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
> > +	*objectid = root->free_objectid;
> 
> This looks buggy to me.  Let's say that free_objectid is currently 3.
> 
> Before, it would assign 3 to *objectid, and increment free_objectid to
> 4.  After (assuming the loop terminates on first iteration), it will
> increment free_objectid to 4, then assign 4 to *objectid.
> 
> I think you meant to write:
> 
> 	while (find_qgroup_rb(root->fs_info, root->free_objectid))
> 		root->free_objectid++;
> 	*objectid = root->free_objectid++;
Yes, your guess is correct.
> 
> And the lesson here is that more compact code is not necessarily more
> correct code.
> 
> (I'm not making any judgement about whether this is the correct fix;
> I don't understand btrfs well enough to have an opinion.  Just that
> this is not an equivalent transformation)
I don't have much knowledge about btrfs too, but one thing is clear: the qgroupid 
taken by create_snapshot() is calculated from btrfs_get_free_ojectid(). 
At the same time, when calculating the new value in btrfs_get_free_ojectid(), 
it is clearly unreasonable to not determine whether the new value exists in the
qgroup_tree tree.
Perhaps there are other methods to obtain a new qgroupid, but before obtaining 
a new value, it is necessary to perform a duplicate value judgment on qgroup_tree,
otherwise similar problems may still occur.

edward


