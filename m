Return-Path: <linux-fsdevel+bounces-32411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D39A4BC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C7E284B8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37D1DE4FE;
	Sat, 19 Oct 2024 07:17:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A31D54D3;
	Sat, 19 Oct 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322262; cv=none; b=R+Lm1VVxiZKZRX4T2HNWEEhDo6UpRXR0YZv65fUbvbt2j6fBSt31Y5Gmo2SyNfxzXpZNrG7i4ezhuAwg+shUP00CuqKFmWokPqthWwiO16J81tzuTkBd7X40OzEJzkq6mOl29XAnhtBlkxDf/ofvCeQeg0O3cVW7UhmXuNbg2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322262; c=relaxed/simple;
	bh=Z5Q8B4bck1mews/VXCUSRyo4bdvk5UfW/acuCx1L4IE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/ouwQV07OFGdEcIWVM+wADnqgMaQ4C3+r2Bm8WYMG5DLacd+9rjritnI2YChW3+gfFcm3UV90qm0Wx38Jj3Kp144OE3+4HvD5v7TfOjGYTpcxRf5YxgwRBSeKy655fCa1/53u/cpYLrJqagZRITCR9vFCxPO6DY0qN25q8g2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322177tbh1ui
X-QQ-Originating-IP: gaImgFu32Uh/c26jfCC4kBP+8UkdjHLBLPOMsCWpONg=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:16:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16716936677098621295
From: chenxiaosong@chenxiaosong.com
To: corbet@lwn.net,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 2/3] docs: filesystems: fix compile error in netfs_library.rst
Date: Sat, 19 Oct 2024 15:15:38 +0800
Message-Id: <20241019071539.125934-3-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
References: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MzQ3kK1NFVdtbyNQqC/NW/vd0Py0Qlt5KVRuvjZ+R0C/NzlRqD4ywbwg
	0HR6I0ZW9Zxei/lI1TPAVmuQHMDUVRX5pvLuLJKqfksW5v/rf+XwaMMmM6hfis93qu125QC
	qXdOgfndt842VGVteIFIJ8vzStF5scUT/42oAf2I7RxBfX4m5zaiYVeK7jtpJ4t4PsZzoD4
	dcPQD0wWxqWpQ7YkFv/tMZYAkRQ1+mKDYP0jWcCErcGLZQTJIsFktuv6ryizs7o1Tvd5QXt
	o1NST0+0HbBJf3Fw0lkiSi2hKt2B0eDb/Wlp12wOmJbjwN52Y/HqaaoaCtnFxM1dCuGwZVo
	tTlOxOlqRy/mWjRA4CjTjhhYSCC3KOwKsnd2Z8cxDAkjcLtbaEbqnP53CwtOCLPgMl1VkDD
	ev402suzXqht/4a4YEmOHrLMcH9An4FcrI3u4h4ms5rNypJ9kTdZSzYcgWZRldJClhA/LGg
	Om7OiEbB+WI2Oz+TsaBiWrnuJ/Y0HP6K0OLjBqinv3Dl0tWapQUGIMoDxyGW+9D2515VRP2
	4ZZCLZUxW/4TDxYy3236JgRmSs+bMqRv9N+A4LFWpGnebdrUNjD1ALw/IvP9ysobM/05C0s
	lsNSHNlnAy2kcyb1cK+QSWwdrnVCiSV0cB6Ei/28YnMghE/+g/6lsgkL7wS2pDG+BcWd7Tr
	ylBJx9gKPt8AxdiHXuiqIXTJIaek4XoRYvenpDMBGlyR4f8M3YeH9ftL/jjXOBmSaw8PeNP
	u4EzQufSAm1HcmJ/djnvwkkpiXDAxHIgDZ0KoEI2jr+SDvVFHatwt5cJtZnKFdCmpBlRmQT
	g1k5pskZ04tUmHw18UyxPN8aLedNdxxrvRlvixptRbs5+GV2mNC1GKp0F6r/PpQ69ZdOIYO
	ChwX4RqfoGt9EX/UhfeM5PGFmuINFtkZhUoJosqXQAcGS+SpA7KO+YITtDPcC3zh
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

`make htmldocs` reports the following error:

  Error: Cannot open file fs/netfs/io.c

Fix it by removing the unused kernel-doc reference.

Fixes: 86b374d061ee ("netfs: Remove fs/netfs/io.c")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 Documentation/filesystems/netfs_library.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index f0d2cb257bb8..73f0bfd7e903 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -592,4 +592,3 @@ API Function Reference
 
 .. kernel-doc:: include/linux/netfs.h
 .. kernel-doc:: fs/netfs/buffered_read.c
-.. kernel-doc:: fs/netfs/io.c
-- 
2.34.1


