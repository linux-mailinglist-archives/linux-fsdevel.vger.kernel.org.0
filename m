Return-Path: <linux-fsdevel+bounces-71563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984F3CC79AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEBFF3087F79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BF340A4A;
	Wed, 17 Dec 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX/EJFlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B333C533;
	Wed, 17 Dec 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973821; cv=none; b=iBE86aQxZEgvjv+jQc5QIKBb8mop+SmowP1bh6EhF6YtinQwZppZAn784ljDx+XjodazxVe+P3c6HMny8tAuCGzZ0xCjxiv7ljvs9P47Euzu2423nGCGCol5/fz9zOPUeQNo57W8xPkpqu98QHDU/d4Mvi1NZ6abiGtdoJI/EZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973821; c=relaxed/simple;
	bh=+N4sH+sHD/mZO0Dopjn0v7xWI8qX66vpH1TR36avIcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kkPforGC+B2l2iX+9l2lsLkFawvjBYnKx3IlnMS1hpzY3oNSrMTiCjWFzGp+8dCJGCb50NNuK1D0tQrkByr8wbnETWCyh2lgSt0T47o67cj2xmzNDNfrRzhAWuQytyiIbM4pIyW21Y15rgVawg9JF5cRzGcgvlP6rMvp1x9T6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX/EJFlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D4CCC113D0;
	Wed, 17 Dec 2025 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973819;
	bh=+N4sH+sHD/mZO0Dopjn0v7xWI8qX66vpH1TR36avIcM=;
	h=From:Date:Subject:To:Cc:From;
	b=PX/EJFlQdIuBgyDARQas6jPR6/RoewsC7HadKO+icTia7eEJOVUDgH0NHanwK6WHq
	 I6+mma7n9dPpK9KaTnCyCwpZAnZKommqNmqvbkwq9Ki3KNRFSXNH5tdvE/oUQo5EdW
	 R2FZAA9OBebqk4yxX6GN5ZOJRyQ6t09SlmQsrOw7+77kXujs+Ffvj8itQ0j8SrB1dA
	 3GTYsehdaup6CH/k4fBawqPNEg8KBHR9KcRkO/DjT5DloAhTjUjG3SAgJ2HYQxSELf
	 2sKvCVjwcsa1D0K77SP6ivJWUrN3szeBX5A9nrGfbd7VnarXM2RpW2ljzBCVwRM95u
	 xQPoJ/l7DIoAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC2D65550;
	Wed, 17 Dec 2025 12:16:59 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 13:16:42 +0100
Subject: [PATCH v2] sysctl: Remove unused ctl_table forward declarations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
X-B4-Tracking: v=1; b=H4sIACmfQmkC/32NQQrDIBBFrxJmXUtHIrFd9R4lBDGjsRUNGtKG4
 N1rc4Au34P//g6ZkqMMt2aHRKvLLoYK/NSAnlSwxNxYGfiFC+Qo2FNZlresFz+Y9zCS9kxI3aH
 sUGipoQ7nRMZ9juijrzy5vMS0HR8r/uzf3IoMGVdXZTrZttLI+4tSIH+OyUJfSvkCUBUTnLUAA
 AA=
X-Change-ID: 20251215-jag-sysctl_fw_decl-58c718715c8c
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4070;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=+N4sH+sHD/mZO0Dopjn0v7xWI8qX66vpH1TR36avIcM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCnzn3+gSU0+j0UAVfyYseAC+Luiy67oOfV
 qoKl7xQ38Gdt4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQp85AAoJELqXzVK3
 lkFP6CUL/2DCbeAT7eVMIUFZuqFbctu8L27EdqamYQi/f14ivfW67IvMpQd8Ecs34YCaZK0a57n
 VIl4Z4L0Ryr0Ft1STkGYh1/pbipbCooRk3yYNucpnyHHJZpNrh89htfwoo43BNMR7dR83TrEQT1
 NCvvC0oKxZkeHvhidOVij1Z5Sbon0SHgnBuTRa23Nn8EGG+LqerkB/k0iFGtLGp5y7tFOruDgzo
 M0oGggM5rMfY2qCxSnYjSUAOLtYXznHU+hNAAxVC17o8jf8UZRRLLOkiADhHIqFTbZrTjP/2QAF
 O/A49Iw58uDNGcNHrvqfIOfHQ/O41LM1wXsCo5+0ijFAr9Ba0GMFlIjz3hCVO327HR792KjIf8H
 BjvCs2nQs+AX2XhGgZ+G+kS7SCm76yJr3Djq4RVTNN/0t9cFixWp93vjU1N6N20awGC38ev6EwK
 h0OwtNUDISj1y7LaFQgLFCXs+0yIZjVPe5uzzq5qMhx0RcXJUP/1kVq20J4OxdFpLO3aoZIsKW8
 zo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove superfluous forward declarations of ctl_table from header files
where they are no longer needed. These declarations were left behind
after sysctl code refactoring and cleanup.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Apologies for such a big To: list. My idea is for this to go into
mainline through sysctl; get back to me if you prefer otherwise. On the
off chance that this has a V3, let me know if you want to be removed
from the To and I'll make that happen
---
Changes in v2:
- Replaced a ctl_table forward declaration in kernel/printk/internal.h
  with an actual #include <linux/sysctl.h>
- Link to v1: https://lore.kernel.org/r/20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org
---
 include/linux/fs.h       | 1 -
 include/linux/hugetlb.h  | 2 --
 include/linux/printk.h   | 1 -
 include/net/ax25.h       | 2 --
 kernel/printk/internal.h | 2 +-
 kernel/printk/sysctl.c   | 1 -
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d5caadb68643bf68b7a78e17c08d4..77f6302fdced1ef7e61ec1b35bed77c77b294124 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3487,7 +3487,6 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
 				 size_t len, loff_t *ppos);
 
-struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 019a1c5281e4e6e04a9207dff7f7aa58c9669a80..18d1c4ecc4f948b179679b8fcc7870f3d466a4d9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -16,8 +16,6 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/nodemask.h>
 
-struct ctl_table;
-struct user_struct;
 struct mmu_gather;
 struct node;
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 45c663124c9bd3b294031d839f1253f410313faa..63d516c873b4c412eead6ee4eb9f90a5c28f630c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -78,7 +78,6 @@ extern void console_verbose(void);
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
 extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
-struct ctl_table;
 
 extern int suppress_printk;
 
diff --git a/include/net/ax25.h b/include/net/ax25.h
index a7bba42dde153a2aeaf010a7ef8b48d39d15a835..beec9712e9c71d4be90acb6fc7113022527bc1ab 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -215,8 +215,6 @@ typedef struct {
 	unsigned short		slave_timeout;		/* when? */
 } ax25_dama_info;
 
-struct ctl_table;
-
 typedef struct ax25_dev {
 	struct list_head	list;
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5f5f626f427942ed8ea310f08c285775d8e095a6..29a3bd1799d426bc7b5ebdc28ff8b75214c57a57 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,9 +4,9 @@
  */
 #include <linux/console.h>
 #include <linux/types.h>
+#include <linux/sysctl.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
-struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index da77f3f5c1fe917d9ce2d777355403f123587757..f15732e93c2e9c0865c42e4af9cb6458d4402c0a 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -3,7 +3,6 @@
  * sysctl.c: General linux system control interface
  */
 
-#include <linux/sysctl.h>
 #include <linux/printk.h>
 #include <linux/capability.h>
 #include <linux/ratelimit.h>

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-jag-sysctl_fw_decl-58c718715c8c

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



