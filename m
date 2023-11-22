Return-Path: <linux-fsdevel+bounces-3425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5777F468A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EA1C208D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B9C4AF71;
	Wed, 22 Nov 2023 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAGLmXve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D65495FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 12:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66ADC433CA;
	Wed, 22 Nov 2023 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700657098;
	bh=uKuNPUXLK2gLNkKe02Yai19TRRbzLMVmA8ccRa9KuT8=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=WAGLmXvek6I8o1UXBXRZ+3ezbedQFioQ2B06F/QUW9CfTzWLescH+j08J0dThEhYA
	 m+WGfJHA6e3bv2du+c8+tuyKi96OknqfL3Cu4tPF/SHt8xF/Zeup+811iNErDl+evz
	 SC1ZQ8HqDUjQfGo+TXwDQDRnYjScXSGynihJ5RyozXc/xGdqg+tK0WhTIbeIoCCoWf
	 E6HjKsTH7rUV1KaCpzoZf2+QdYI8rHx/TI2i+0VJfawwwTFln3n3LVK9bHhKUcCTLr
	 ZQdhvnlRC3+/3xaQ1E760lEVuBmpckK1TV0OFq9lQGPmZZda5qo95yJXt55BY6/u5g
	 kvbB96XqQJkNw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Nov 2023 13:44:40 +0100
Subject: [PATCH 4/4] fs: reformat idmapped mounts entry
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-vfs-mnt_idmap-v1-4-dae4abdde5bd@kernel.org>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
In-Reply-To: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uKuNPUXLK2gLNkKe02Yai19TRRbzLMVmA8ccRa9KuT8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGfj/CaldwV7Pw5bzDoYxifnLrmvKUNX7NY9A7uFV2M
 jPTtlXuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP54MPwP1zZa5GjjSNz/Zbd
 bQ7tPhWSbAtLzTNDstc2uxfumymzmZHhj/Kb45t+cm1xPc+s56Zp1Hr4Be/78MNfN7XWvFE8l/G
 CHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reformat idmapped mounts to clearly mark where it belongs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 MAINTAINERS            | 20 ++++++++++----------
 include/linux/uidgid.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..d0a7b6f357ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8177,6 +8177,16 @@ F:	fs/exportfs/
 F:	fs/fhandle.c
 F:	include/linux/exportfs.h
 
+FILESYSTEMS [IDMAPPED MOUNTS]
+M:	Christian Brauner <brauner@kernel.org>
+M:	Seth Forshee <sforshee@kernel.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	Documentation/filesystems/idmappings.rst
+F:	fs/mnt_idmapping.c
+F:	include/linux/mnt_idmapping.*
+F:	tools/testing/selftests/mount_setattr/
+
 FILESYSTEMS [IOMAP]
 M:	Christian Brauner <brauner@kernel.org>
 R:	Darrick J. Wong <djwong@kernel.org>
@@ -10252,16 +10262,6 @@ S:	Maintained
 W:	https://github.com/o2genum/ideapad-slidebar
 F:	drivers/input/misc/ideapad_slidebar.c
 
-IDMAPPED MOUNTS
-M:	Christian Brauner <brauner@kernel.org>
-M:	Seth Forshee <sforshee@kernel.org>
-L:	linux-fsdevel@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
-F:	Documentation/filesystems/idmappings.rst
-F:	include/linux/mnt_idmapping.*
-F:	tools/testing/selftests/mount_setattr/
-
 IDT VersaClock 5 CLOCK DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index 7806e93b907d..415a7ca2b882 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -195,7 +195,7 @@ static inline u32 map_id_down(struct uid_gid_map *map, u32 id)
 	return id;
 }
 
-static inline u32 map_id_up(struct uid_gid_map *map, u32 id);
+static inline u32 map_id_up(struct uid_gid_map *map, u32 id)
 {
 	return id;
 }

-- 
2.42.0


