Return-Path: <linux-fsdevel+bounces-52123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCEADF81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0FE4A003A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3C21D3C6;
	Wed, 18 Jun 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuRU+GpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348221D3FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280044; cv=none; b=Ld8k+z8YI71cvwZNHw/LMlGyX121Bb4RL5XY8OkpWYEUu7HVKHOmY+UJwK0KPKerMjcdX1LOWUoCEsFYxixcwzc545KOJorwgASwKFsDfVGFDR93khJuWlxB/Gt6nn2gkagngi4JZqDlVIiGpgc4c2pkg1CnsStDrlADiJ8hnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280044; c=relaxed/simple;
	bh=d9CLACUE7WmW3UnqqZURZjT8Cr8JfI2DSnf6F4lsg/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gv8MFdFbClTPEYdF6mXIoWNrr5JFZVHTmfPBSDC7hkp5a6WP2WbNdHJ/PmXw6n0FM3lCnVDCcHb3oiOEP3fy8M9+XR/WiXipfulslz0zIcUyj1esvSKVsrhJj/RuXOL3Weru2SflnIPyg5YH6NoJitDbvFhfkOtz/hXq2wM9BrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuRU+GpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF253C4CEEF;
	Wed, 18 Jun 2025 20:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280044;
	bh=d9CLACUE7WmW3UnqqZURZjT8Cr8JfI2DSnf6F4lsg/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MuRU+GpQU0ynmpIhe0VrDHnHNMeY3bJpBnZtRWxVA7ftRTsNV/0/sWHifSg/xjpqV
	 FDXFZfpy6ajRLZRFqmNkmrTWiitC5uuXxcJ7Xrbt3dAQx/aVDsadIqUWbkqlrD3e56
	 37TJr9CrHWtqSSHEj37mg5AoJrRgQOKofDTbx87ijaDsTZ2YG1SOGP1xROzPvXi+DX
	 Q2G1C0EwBuGqNj4nM/KPwV6cJoNh3XFkL+k8u9ftJz8cfUO4XOUBTHRNOD9ScyjplG
	 jf9cvtXciefaV71cHtDrXbovXOqf6OYMJqQL1m8xojfCJ764X6och7EYZQbXBzpqPF
	 z4qZ3N15kvr+g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:40 +0200
Subject: [PATCH v2 06/16] pidfs: remove unused members from struct
 pidfs_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-6-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d9CLACUE7WmW3UnqqZURZjT8Cr8JfI2DSnf6F4lsg/Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0caXGLetvCA+VR9DXe1kIT75d2bru7e/F43KuoyY
 7O+7tfWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImonGZkuKiiWnH5nP9yjlM3
 Xm6w1jWc+uDaniurNbYIvn2V+i8xzZiR4eq76fkLHz1bprD27V8lmwcf/CpTH1ecWOv88krvs73
 L+VkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We've moved persistent information to struct pid.
So there's no need for these anymore.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 6a907457b1fe..72aac4f7b7d5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -46,8 +46,6 @@ struct pidfs_attr {
 };
 
 struct pidfs_inode {
-	struct pidfs_exit_info __pei;
-	struct pidfs_exit_info *exit_info;
 	struct inode vfs_inode;
 };
 
@@ -696,9 +694,6 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
 	if (!pi)
 		return NULL;
 
-	memset(&pi->__pei, 0, sizeof(pi->__pei));
-	pi->exit_info = NULL;
-
 	return &pi->vfs_inode;
 }
 

-- 
2.47.2


