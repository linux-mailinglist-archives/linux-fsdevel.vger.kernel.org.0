Return-Path: <linux-fsdevel+bounces-31953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489B99E2BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490BA28137F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703261DC182;
	Tue, 15 Oct 2024 09:25:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A2185B47;
	Tue, 15 Oct 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984301; cv=none; b=jNqVAUaSJ3nJqjPwgUSUlnipHNN0Atnq68N3uej9WHvmnNO8YEnBHuPSIoW6wGyCo+jr9DrSoEGtQUXG1tmzF+4Jz7KfoHOiPJV8mgvrvzAQx9cTVPfWhg7Ugfscg6iGgzVrmvTXb8WHv5C/0e0uHC8SYlO+zriHdk/L4PpQLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984301; c=relaxed/simple;
	bh=rxLKrS7w7zyUKYbg5SX26OFOZE9TL/dqWvHJIVhx6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pe20TfBVm5esx6y3O0KvRHHVOUZNWKC57ZWjR4BoaXgPc748xMDugkBKiXcdO8yX8G0hQm090xwVI7VDUhJXomnDyyZ4o/MQC/AVFh/48wVfA8StIDJy8e5Ne0/wrdtMN+T+Yspp4D84eYRyG3mPtRuesfA4RuoHH+nNSKma79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrABnEBW3NA5nsIgQAQ--.40021S2;
	Tue, 15 Oct 2024 17:24:07 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDX34+1NA5nRCI5AA--.24175S2;
	Tue, 15 Oct 2024 17:24:06 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com,
	Dongliang Mu <dzm91@hust.edu.cn>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: fix a reference of a removed file
Date: Tue, 15 Oct 2024 17:23:55 +0800
Message-ID: <20241015092356.1526387-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABnEBW3NA5nsIgQAQ--.40021S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1xZFyrZw45WrW8XFWkWFg_yoW3JFX_JF
	yfJFs5XryDArs7JF18KFn8WF13Z3W0kFy8Xw13JwsIv347J395CFZ3X3s0yrsxXrs29rn5
	WFWkXrZxXFy7tjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmkYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XVy3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Since 86b374d061ee ("netfs: Remove fs/netfs/io.c") removed
fs/netfs/io.c, we need to delete its reference in the documentation.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
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
2.43.0


