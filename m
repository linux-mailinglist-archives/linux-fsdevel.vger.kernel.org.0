Return-Path: <linux-fsdevel+bounces-68117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8DC54C05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680623AF6F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A082EC557;
	Wed, 12 Nov 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jir4MDTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLfz97DO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B92D662F;
	Wed, 12 Nov 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987851; cv=none; b=HD5Xal+Zr7lriij/G0bjyszNOGPePlRtVdhzrmLq8H3OW65U5IwIFmuYeYh2zHFQArQPpcEb1LdYcjc93Hq7/O5oV61h6uh+lNqvJyl1MG1nCG7ZoDEOy/mZPaZTKy2IC7jhrhYGxR6CrmcRLuoTb2UQWShXcHjRoI2tPi+YhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987851; c=relaxed/simple;
	bh=gk7jTwjg4YxTK3MshudwEyHBJmgG7UmOjt2m1+Hpy58=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OFR7JHd88JXJxIrLb7TcuuQUsxn5OON07B63a3EzAWjkgZjr0aeBFKif2EA6r7JeuW3sgxakuroMtigzpEzXjyVGgbd7T1F0a4IrCKFe2CG0IaGO5gO0KA27SpThmk/ljpPNPnLH60Vop0rM847w9jErooqjvsxnLF5aj8pHxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jir4MDTS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLfz97DO; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 2988313806A6;
	Wed, 12 Nov 2025 17:50:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Nov 2025 17:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762987847; x=1762995047; bh=hNbQnRc+kFUP5bxPugl1ooBdBy11Z0986aY
	SJmKRoLs=; b=jir4MDTSxsZfdM2IRl9MZbN0ALWiQls5PQ+nkklZ0+Odf25WN63
	px+vcxmJZ/343yP0NnlBKVwK9UifM3DSBJDQPbAFUEV9RD5AqwZvUJdQhaLuTQmw
	UMa/+H1qYZUQYbJ01k3iXjj+uLQe7TureLQBiP2RBEbTDpfefArurTdZIdbV79J/
	VG9hoPkx4Re71SD1pdP5jdsU8c4x8Ezycn/VnUN5FCrl/jR70BlyL4zfNzJy/h3A
	nfRtqg2lcQaFC5lamfb3UvooMox2B6ZgIGDv1YGF6LqG6+o9WobjyEhGWpJol2dM
	OhU0GqkHlPpxdhVwG/7n3HoSAb6+icZzBmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762987847; x=
	1762995047; bh=hNbQnRc+kFUP5bxPugl1ooBdBy11Z0986aYSJmKRoLs=; b=B
	Lfz97DOs9f3pV8SMym55iFWtFF0Whk7qDnQ7uIoppMUeJlo6Z0wL/odbqfprJdGy
	FnYb68xmGsmOb4bwylkvMw9b4omvIT1aH6A93ZOUtT4iIQDLLSTrgX0qy9L8EkJx
	2zLSUyHXFGTj3nsbQOhT9OJZCobm3DukzPSXo2q4pi0NvwU8nF5h8OcA0NO+5+WA
	0PEOnjwgyw2GICsat/bKQx5g2FiKE36lmJ2EeDP81tYbdF2UKae3j5A0ArfiPEkq
	tRNKKiTUoVkBXzLbRPb+3CMC74viLl/0M55NkH+tCt3g9/mQCG6MbNsCmCzOGKZi
	c2sokfrybzXBgGwQIO8xQ==
X-ME-Sender: <xms:RQ8VafhhigNHwThNGgZL6VDUmCMzXzWdXCNwp2pF9cAfKCwuajl6KA>
    <xme:RQ8VaRrwL2PAkM5MKDdTENePzo0MjHhfVHYDfATSpFFtRSDGrSBcOfJ_2gZsV_Bhk
    uahMwsauI6qCdXkAeG549afc_l-kQDyx0JOK71rMbO5t_g8>
X-ME-Received: <xmr:RQ8VaXJM8GaoDYtM7fK95Dxg6WkypMVogX_gysXAEdMyX14QpFP4ew9huDyHB4B5ld3mGurSzbtmUMvrPXcurN68ClN2Anzm-nOx7SrNsNiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpegtgfgghffvvefujghffffkrhesthhqre
    dttddtjeenucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhl
    rdhnvghtqeenucggtffrrghtthgvrhhnpeffhefggfegfeefuddtvdektdekheduudeftd
    dufefhgfetteffudehheffjeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhs
    hiiisghothdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeg
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlih
    hnuhigrdhorhhgrdhukhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtihhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RQ8VaU_TZlxPuvrWeAqkACaP2k8Al-3-wPUeHNBrUxdJjRalfLbJiQ>
    <xmx:RQ8VabLvN9wKNh7vsrGQuPbdRitR6XBWPg0OYSH6a_8Jv-ozj0HwQA>
    <xmx:RQ8VacyF-HUMepz3fbS9mezvCzbSlJV_E4Q-4rygphXSIubclEfTDQ>
    <xmx:RQ8VaZQFjRq0rKiXJyTmjlzTiI1hgqKgTB2deemjEUNcNAYbcMDMYQ>
    <xmx:Rw8VaRng3xIxkUPzVLT2SQWh71AIXEEteEsvxx4LCf38ADBus3t6KOp1>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:50:34 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "syzbot ci" <syzbot+ci853f3070c3383748@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, cem@kernel.org,
 chuck.lever@oracle.com, clm@fb.com, code@tyhicks.com, dai.ngo@oracle.com,
 dakr@kernel.org, dhowells@redhat.com, djwong@kernel.org,
 dsterba@suse.com, ecryptfs@vger.kernel.org, gregkh@linuxfoundation.org,
 jack@suse.cz, jlayton@kernel.org, jmorris@namei.org,
 john.johansen@canonical.com, linkinjeon@kernel.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, lorenzo.stoakes@oracle.com, miklos@szeredi.hu,
 mjguzik@gmail.com, netfs@lists.linux.dev, okorniev@redhat.com,
 omosnace@redhat.com, paul@paul-moore.com, rafael@kernel.org,
 selinux@vger.kernel.org, senozhatsky@chromium.org, serge@hallyn.com,
 smfrench@gmail.com, stefanb@linux.ibm.com,
 stephen.smalley.work@gmail.com, viro@zeniv.linux.org.uk,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: Create and use APIs to centralise locking for
 directory ops.
In-reply-to: <690c6437.050a0220.baf87.0083.GAE@google.com>
References: <20251106005333.956321-1-neilb@ownmail.net>,
 <690c6437.050a0220.baf87.0083.GAE@google.com>
Date: Thu, 13 Nov 2025 09:50:26 +1100
Message-id: <176298782655.634289.16817979269470605281@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, syzbot ci wrote:
> syzbot ci has tested the following series
>=20
> [v5] Create and use APIs to centralise locking for directory ops.
> https://lore.kernel.org/all/20251106005333.956321-1-neilb@ownmail.net
> * [PATCH v5 01/14] debugfs: rename end_creating() to debugfs_end_creating()
> * [PATCH v5 02/14] VFS: introduce start_dirop() and end_dirop()
> * [PATCH v5 03/14] VFS: tidy up do_unlinkat()
> * [PATCH v5 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and end_cr=
eating()
> * [PATCH v5 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing() and =
end_removing()
> * [PATCH v5 06/14] VFS: introduce start_creating_noperm() and start_removin=
g_noperm()
> * [PATCH v5 07/14] VFS: introduce start_removing_dentry()
> * [PATCH v5 08/14] VFS: add start_creating_killable() and start_removing_ki=
llable()
> * [PATCH v5 09/14] VFS/nfsd/ovl: introduce start_renaming() and end_renamin=
g()
> * [PATCH v5 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
> * [PATCH v5 11/14] Add start_renaming_two_dentries()
> * [PATCH v5 12/14] ecryptfs: use new start_creating/start_removing APIs
> * [PATCH v5 13/14] VFS: change vfs_mkdir() to unlock on failure.
> * [PATCH v5 14/14] VFS: introduce end_creating_keep()
>=20
> and found the following issues:
> * WARNING: lock held when returning to user space in start_creating
> * possible deadlock in mnt_want_write
>=20
> Full report is available here:
> https://ci.syzbot.org/series/4f406e4d-6aba-457a-b9c1-21f4407176a0
>=20
> ***
>=20
> WARNING: lock held when returning to user space in start_creating

I think this was due to a bug in=20
   VFS: change vfs_mkdir() to unlock on failure.
in ovl_create_real()

That patch removed a end_creating() call that was after
ovl_create_real() returned failure, but didn't add end_creating() in
ovl_create_real() on failure.  So it could exit with the lock still
held.

This patch should fix it, particularly the second hunk.

Thanks,
NeilBrown

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a4a0dc261310..739f974dc258 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -187,7 +187,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct=
 dentry *parent,
 			if (!err && ofs->casefold !=3D ovl_dentry_casefolded(newdentry)) {
 				pr_warn_ratelimited("wrong inherited casefold (%pd2)\n",
 						    newdentry);
-				dput(newdentry);
+				end_creating(newdentry);
 				err =3D -EINVAL;
 			}
 			break;
@@ -237,8 +237,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct=
 dentry *parent,
 	}
 out:
 	if (err) {
-		if (!IS_ERR(newdentry))
-			dput(newdentry);
+		end_creating(newdentry);
 		return ERR_PTR(err);
 	}
 	return newdentry;

