Return-Path: <linux-fsdevel+bounces-42785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A6A48960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 21:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882FA16DB0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE826FA4E;
	Thu, 27 Feb 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWXcTkPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B926F47C;
	Thu, 27 Feb 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686717; cv=none; b=Vmg+9VeUA0brhQOYzHRXESydAvqoGdXweyPPpPX92ADyKLbMS49RDbJA5y19Fvz7S7DHV5RvpFCU+8vXiOs94HxgtFhTavH7nIHDvN8uDLk82YdHNaMHY3q5+HYr2rHu7htd4d9CR8HMus+LL7Q+5Ldgy5nXc+ee1kMGK4wDsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686717; c=relaxed/simple;
	bh=cKyiFi3SZsXOOEUVfU1WBhvUnONEWzPDCgQb2dLAIRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGn7RAB6hUk6sbJV8ZuiMkd8Nq/IJOZDts+54V92W/RDDgxCEuHeI4YudMceM7Dwk8Zu26IjD3JWcLCzHwxuFMev6Cl9PeW9pxLC9JuFYqKvAcfubPCToNsLWVq37bL4tdgmOiK6HMJaEryVMS6BMXbCwExICo6ZVY/154JkTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWXcTkPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE9C4CEDD;
	Thu, 27 Feb 2025 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686717;
	bh=cKyiFi3SZsXOOEUVfU1WBhvUnONEWzPDCgQb2dLAIRA=;
	h=From:To:Cc:Subject:Date:From;
	b=sWXcTkPJ2HTXK1CfdPxUOJMMwCq+SLAdiSvrFPjFVPGvizQ4MapMHE1QL7IL532Cb
	 yqhOPv+8o05VaBY2vMjIH9AHfRFf72BWwrekv4nRCkIAgSDs9xescGnuaW5sSDLPga
	 3+tUctsevxD4zr+XHYuMuB2uY3KKJU/kTbzRz6/buUXdn2IgCk9ZpNyzKGmxIdBD5v
	 eSkdIH0t67B8DrQk46//Oti+hRmHOKfW/VQEGZlQjev/kcJ3nK/FOeRYtzF96Crch7
	 rVQR3WTfJwrtMFTf3dbtX3x1hLF/cg+JMi6OlQn8Hb6YcimBP686kpxNRdcyv+JODm
	 9hEc6kr+1QkTA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] README: add supported fs list
Date: Fri, 28 Feb 2025 04:05:14 +0800
Message-ID: <20250227200514.4085734-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To clarify the supported filesystems by fstests, add a fs list to
README file.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

David Sterba suggests to have a supported fs list in fstests:

https://lore.kernel.org/fstests/20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m742e4f1f6668d39c1a48450e7176a366e0a2f6f9

I think that's a good suggestion, so I send this patch now. But tell the truth,
it's hard to find all filesystems which are supported by fstests. Especially
some filesystems might use fstests, but never be metioned in fstests code.
So please review this patch or send another patch to tell fstests@ list, if
you know any other filesystem is suppported.

And if anyone has review point about the support "level" and "comment" part,
please feel free to tell me :)

Thanks,
Zorro

 README | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/README b/README
index 024d39531..055935917 100644
--- a/README
+++ b/README
@@ -1,3 +1,85 @@
+_______________________
+SUPPORTED FS LIST
+_______________________
+
+History
+-------
+
+Firstly, xfstests is the old name of this project, due to it was originally
+developed for testing the XFS file system on the SGI's Irix operating system.
+With xfs was ported to Linux, so was xfstests, now it only supports Linux.
+
+As xfstests has some test cases are good to run on some other filesystems,
+we call them "generic" (and "shared", but it has been removed) cases, you
+can find them in tests/generic/ directory. Then more and more filesystems
+started to use xfstests, and contribute patches. Today xfstests is used
+as a file system regression test suite for lots of Linux's major file systems.
+So it's not "xfs"tests only, we tend to call it "fstests" now.
+
+Supported fs
+------------
+
+Firstly, there's not hard restriction about which filesystem can use fstests.
+Any filesystem can give fstests a try.
+
+Although fstests supports many filesystems, they have different support level
+by fstests. So mark it with 4 levels as below:
+
+L1: Fstests can be run on the specified fs basically.
+L2: Rare support from the specified fs list to fix some generic test failures.
+L3: Normal support from the specified fs list, has some own cases.
+L4: Active support from the fs list, has lots of own cases.
+
++------------+-------+---------------------------------------------------------+
+| Filesystem | Level |                       Comment                           |
++------------+-------+---------------------------------------------------------+
+| AFS        |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Bcachefs   |  L1+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Btrfs      |  L4   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Ceph       |  L2   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
++------------+-------+---------------------------------------------------------+
+| Ext2/3/4   |  L3+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Exfat      |  L1+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| f2fs       |  L3-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| FUSE       |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| GFS2       |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Glusterfs  |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| JFS        |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
++------------+-------+---------------------------------------------------------+
+| ocfs2      |  L2-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| overlay    |  L3   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| pvfs2      |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
++------------+-------+---------------------------------------------------------+
+| tmpfs      |  L3-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| ubifs      |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| udf        |  L1+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Virtiofs   |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| XFS        |  L4+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| 9p         |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+
 _______________________
 BUILDING THE FSQA SUITE
 _______________________
-- 
2.47.1


