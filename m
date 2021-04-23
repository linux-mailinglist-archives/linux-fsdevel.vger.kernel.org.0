Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E413690E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbhDWLL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 07:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242185AbhDWLLy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CB076144D;
        Fri, 23 Apr 2021 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619176278;
        bh=s73o/wJyILS/DuFAVBhZN9buVbYK3YsL1DQcVOccoKY=;
        h=From:To:Cc:Subject:Date:From;
        b=g3jVFAJEjEM2SpG7kg49TskFCuLKxVXVPnO2Go5mp5UKcQIZhKtL20M8Rb/IAd8GP
         XK0WJUYIvAK47aqfrGEQFmXpICLx0WlJ8mIKq126MODuC595UOCFC9CdvWXmrmcdkV
         6dyHe2S0Ve+CcGrMuviyu38XgON5MPFGU3xRVk1Wk7emP2VvmwRk6/78s6HP+YDEBS
         3qxk/cUWY57UqZFB6hf/oc7zZGg47T79OQ82C5wAQbOhaEIo5AofTAMBnWt5C6pyHg
         z5citsw7R6+Wjx9XlNwhstxANH2HAB4JXLNMdax2xHitGrD6ZSt2bBAg4fbqx/czlU
         a3ztuQ5U8tMQg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] fcntl: remove unused VALID_UPGRADE_FLAGS
Date:   Fri, 23 Apr 2021 13:10:35 +0200
Message-Id: <20210423111037.3590242-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DTBkIkRNd4bcqOtvuhl7Obc19oP2/yrBuWrgwMlrBXs=; m=0y+NHR64JJHm7BpbyCR9AQq8KTzHwBNJkqNrGCv0xYA=; p=1vlusdo5gjwAF0kBP5kBKm1VG2vyL2qLrK4eGEkLgIQ=; g=9d11c722bc61e3dc9015e1ec2b7c3e9cbb3b59e8
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIKrKAAKCRCRxhvAZXjcotawAQDMqM0 ob6cY2MziRdtPhAVET825LXg9MZIPprND2+59oAEArI4fjVv8ULQVccPX2ktmWbC9AHgMcYaWgURG Os8Wzgs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We currently do not maky use of this feature and should we implement
something like this in the future it's trivial to add it back.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/fcntl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 766fcd973beb..a332e79b3207 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,10 +12,6 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
-/* List of all valid flags for the how->upgrade_mask argument: */
-#define VALID_UPGRADE_FLAGS \
-	(UPGRADE_NOWRITE | UPGRADE_NOREAD)
-
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \

base-commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
-- 
2.27.0

