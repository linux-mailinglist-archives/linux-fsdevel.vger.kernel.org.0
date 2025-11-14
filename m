Return-Path: <linux-fsdevel+bounces-68463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DAC5C8BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FB6D4EF284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF83101B4;
	Fri, 14 Nov 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/+ugTEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EA30F545;
	Fri, 14 Nov 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115339; cv=none; b=ADdOb0YU6o6+n/AA1+VRLvu5JM6AznWR4khm/1ynk+Bauq6YygXQ8TuERw06J8uW9/T7qo9L7qMfASI5rC+O+q4svzdKSnOC49S6fC9+yUBd85udCgi3hQ/jcGTAv6xWz+XAp4EHobfC4d4cOVc4y88nPYudthoAO5fvl79blXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115339; c=relaxed/simple;
	bh=VTcpZf++DdoOZc7b5v7VEHLZWSpUt3ddhQgbOB2RN0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut0f2PiB0VlioWD1oWP0oPlM03nfw/gpNcwg2O/KEoavQjyudmnGXGB1psgkBvNXZdQi6wAlGnHcgBQYIPsek2m/H0Ikg/jH67OrVmr5nI1IEWuYET/bsSZb+tQT2J3wYHRudt8z6p/h54FAriJErH0MUFBYfAg9Ht4fHhIEttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/+ugTEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF81C4CEF8;
	Fri, 14 Nov 2025 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115339;
	bh=VTcpZf++DdoOZc7b5v7VEHLZWSpUt3ddhQgbOB2RN0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/+ugTEX9BRASh/Ic7NM92DTKxO4dRL4XcrJvUcvirUMPyrEXenpGrgOEj0yehoeo
	 MKFRpbLB20d2FnBo+5xJRB992SPA3rLkiy/D99D52n9OhIUJP7sT9OVcO7GQtDMyeH
	 VbIVVsMFQZ/aU2cfaAUDLrEUS+KaPUTTxav/fkZHbNEgbhDPh5mZbBpEHeAm9ApbOL
	 WdtZKXfrJ2nXSw3v9Fms2zZfH/S6o7X6UaEeTfiBJgZyR7PNZ3/5SrcUwpNO+MF0rC
	 whm2ZC5i9XznDe5c/9zESEt62S4mNDgGbwtJZw106Nu0DrMoSfZt0ouBSicJ1XOypZ
	 GmNPRPT4kneJg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:19 +0100
Subject: [PATCH 4/6] ovl: mark ovl_setup_cred_for_create() as unused
 temporarily
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-4-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VTcpZf++DdoOZc7b5v7VEHLZWSpUt3ddhQgbOB2RN0s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzrZHGkWbHjjb8Uzq+rEVIaejwfXrVnHvfVvuc2uK
 31ebUt2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk8V+G/4HZBkE6b1kTC1Uf
 qX//NG1meHy06kqlbb6JMnN0pYIlDRn+yu3Ms5gYsWG2uEqnJK9LhtVKrdjL54TWLvnEK3Hk3MM
 9DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The function will become unused in the next patch.
We'll remove it in later patches to keep the diff legible.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff30a91e07f8..f42e1a22bcb8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -611,7 +611,7 @@ DEFINE_CLASS(prepare_creds_ovl,
 	     ovl_prepare_creds(dentry, inode, mode),
 	     struct dentry *dentry, struct inode *inode, umode_t mode)
 
-static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
+static const __maybe_unused struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 						    struct inode *inode,
 						    umode_t mode,
 						    const struct cred *old_cred)

-- 
2.47.3


