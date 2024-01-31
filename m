Return-Path: <linux-fsdevel+bounces-9707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4284479C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207171C22570
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216355C5E3;
	Wed, 31 Jan 2024 18:54:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369838FA0;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727298; cv=none; b=NEs6IleJ5snY2LbZIDGbZXJHdome6f4cKx8bTlWb/m/nRmF90fvfXj4H0O5IqISJbI+J0NunuVYAtxhG6clmVqMS3cQqmNoXnJByke/ZgWMwDBJOsKSLGAJqaBH2cpvcX1Hh3WQX1XRRbzaE7DRqP2hqAGQijMcyZ/8bxuoTCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727298; c=relaxed/simple;
	bh=ryuvbz2YC+7XgFZae3ZU4jkaJ3KY5fCxQDuCm/pUEeI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QJiG8RDtGXy2q5lEeyGyyUy5+ygjOo4FX2aoEoC0jipKI1uZY1+qr0Wr4M+GBbaY+7KFIdDT9FtYdYuvX4dslI+af5VBe009cyiv8tnu8FbllbUgZD6+f+kIEMT4TqrdE7gMEV0uj1smOD0y0qU4QWldF7mRTMkyRMCE5fsjp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4DFC41679;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjt-000000055Ro-0RDp;
	Wed, 31 Jan 2024 13:55:13 -0500
Message-ID: <20240131185512.961772428@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 5/7] eventfs: Remove unused d_parent pointer field
References: <20240131184918.945345370@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

It's never used

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/

Cc: stable@vger.kernel.org
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Original-patch: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-4-torvalds@linux-foundation.org

 fs/tracefs/event_inode.c | 4 +---
 fs/tracefs/internal.h    | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4878f4d578be..0289ec787367 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -686,10 +686,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	if (!parent->is_freed) {
+	if (!parent->is_freed)
 		list_add_tail(&ei->list, &parent->children);
-		ei->d_parent = parent->dentry;
-	}
 	mutex_unlock(&eventfs_mutex);
 
 	/* Was the parent freed? */
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 09037e2c173d..932733a2696a 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -36,7 +36,6 @@ struct eventfs_attr {
  * @name:	the name of the directory to create
  * @children:	link list into the child eventfs_inode
  * @dentry:     the dentry of the directory
- * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @attr:	Saved mode and ownership of eventfs_inode itself
@@ -51,7 +50,6 @@ struct eventfs_inode {
 	const char			*name;
 	struct list_head		children;
 	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			*d_parent;
 	struct dentry			**d_children;
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
-- 
2.43.0



