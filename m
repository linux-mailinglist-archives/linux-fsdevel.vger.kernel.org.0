Return-Path: <linux-fsdevel+bounces-71353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C18CBEA00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F0883015DCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C50334C20;
	Mon, 15 Dec 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e13qmcjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1B33469D;
	Mon, 15 Dec 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812335; cv=none; b=uTfZt3yKhsizA152hCEuVVcOWfWod1K9BwHbLsV+916gapSUiu4gd+HNtFQQTZm4K7lgaMmOFNowie0ywyO6fIe0f16OlhutCOTFYqgelazhVdgVvTRDp7NASMNpvQqpJFd3rpuGJmacpfjJftjFk/K6hLIUBZRlDU7UCmpptPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812335; c=relaxed/simple;
	bh=mkIo7KJEQTeZErn4R1TynpXwcTTiQfApK6kMsQXsfQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SVNkKUtJuCsRQeGlmUNudqvvc3DMx0EgCjrqOAC9XUMVbuarxm47xBF1Y/i+wAsW5GFYUy8UaRu2q33pFoHtHVf4An5IHEqy2urjan/tOI6tm727BSSK46YBDAHll1e10FaWQoTU2GBM86UWAB16k58mFZcCizwgbHxdIjRfs1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e13qmcjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C58A1C4CEFB;
	Mon, 15 Dec 2025 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765812334;
	bh=mkIo7KJEQTeZErn4R1TynpXwcTTiQfApK6kMsQXsfQk=;
	h=From:Date:Subject:To:Cc:From;
	b=e13qmcjAwrPhAeC0cAhHznqo59gRv3HU4KJyh28RW3Nu9t+c8BjFfY9RU/Xi+4lEy
	 LDgSGpCSpSy37b6TfLKenV0MQ60KrtVcIgw91MbweoyKzvZ6bF6ubBWCHnl61mGFct
	 00x0DGAslok/PGpWBOZrv9i+Yio4qp7J8oiRShdyrEDy+hIhb1NQXpxG7foBxM169i
	 J0MytsHpUQ+OtJ4Gv8zMMqQrKG56aRljQNt2/H7qXea8b11MuANjyts41jXKtS8x9m
	 IB2+0s6SgMJddzp7sJrqTzHZIxMhpt+Die/IVqIqEsINGIfrpBHOh6SjViY0TmKPs8
	 ZWgJr6JPgSV6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0528D5B16C;
	Mon, 15 Dec 2025 15:25:34 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 15 Dec 2025 16:25:19 +0100
Subject: [PATCH] sysctl: Remove unused ctl_table forward declarations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF4oQGkC/x3MSwqAMAwA0atI1hZMoVi8iohIGjUiKo34Qby7x
 eVbzDygHIUVquyByIeorEsC5hnQ2C0DGwnJYAvr0KIzUzcYvZX2ue3PNjDNxnkq0ZfoyBOkcIv
 cy/VP6+Z9PwnR03lkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=mkIo7KJEQTeZErn4R1TynpXwcTTiQfApK6kMsQXsfQk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlAKG1vvzqtVGOj5deDTFASziA+J0o6GzQpS
 K9/VN+bko9gyIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQChtAAoJELqXzVK3
 lkFPAaQL/2BXoApyadWKDJjcZKhfBYyuqiQr7rMW2CIoeSMCjKsOLeBbHC0m6BAtuGLdmqdBsb3
 /PtOT1k9iyez0roDo8NQemHT0SupdxouZ7zEtHF03aG+6DnLpcw4xiYx+mgMLKI3wm2fyhkgXpb
 PSj4DBMPF5cx1gzGQ1K91g5lKE9pSo6/SSXkI1R35iTOay1OQMVfE0NaI5oa7kJuS8I1L1oO26u
 z4jZJQKzRpkL07mKiL0GWyAvuDPjMFbb9e7tlZEACNEEZoFvRW9rpZGU97v/j/6T6LjSsTUQWUJ
 Ar2s55t7h405SKOSjEfNbJnrotmNLxG3DigYGQ5xEPzpyS8lmksyhRSzJWrwAa+SW+aYIyYaU1R
 rIczJx1OYp9MD+YtE3Xg+FWLZO2AsAEtZ2oNg4CDXiHgrNBVhz0OjegA4G4bYgNuTnaM/YlZghR
 kMgN4tKwwJBtc8chd7QEMbxHaaWzdtYKOZ7Um9ebZNJc781OX74vcH0nL1GfpWHuKqBXwf86zM4
 XI=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove superfluous forward declarations of ctl_table from header files
where they are no longer needed. These declarations were left behind
after sysctl code refactoring and cleanup.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Apologies for such a big To: list. My idea is for this to go into
mainline through sysctl; get back to me if you prefer otherwise. On the
off chance that this has a V2, let me know if you want to be removed
from the To and I'll make that happen
---
 include/linux/fs.h      | 1 -
 include/linux/hugetlb.h | 2 --
 include/linux/printk.h  | 1 -
 include/net/ax25.h      | 2 --
 4 files changed, 6 deletions(-)

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
 

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-jag-sysctl_fw_decl-58c718715c8c

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



