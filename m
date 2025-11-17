Return-Path: <linux-fsdevel+bounces-68690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F0C634E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46214F173E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52E32ED47;
	Mon, 17 Nov 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZxXXmyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474A32ED22;
	Mon, 17 Nov 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372111; cv=none; b=XHBWBpvYE45JxjHNR4nqL85hGYk3bDqYU2Cxw4Dcq5FJZRwSVIxvd21sutyf2+9Bswc6Ffa/N1GTN1jy6UnLQrJ80zD++59Y2083D/fPsi05X1yu5ZQ+kqZ5CvIMdLgx8bha3dhf028Q9uM3Cb+wzz+erEYsJX/3ZBf1p4A+fhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372111; c=relaxed/simple;
	bh=EDVLrYGSVDxhPMAvkLtSTFIuFW69/ElWMJsnZop8NBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElWp3EDbK9abdxnAD0k0KWSxMJDlHAKCKG2hWI8r6fQyxB76OD6HNFl1HtpMiz4g+cXUSMy6j1WJUZ8GTVSNbehpj+yiOMpqr97oNQcj1xt6lshTE5JfVXRJpcGcT3zV8JXEX9mlcta0j+98EqmJQm3STDPsv+d218gVWh+sahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZxXXmyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A99C113D0;
	Mon, 17 Nov 2025 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372110;
	bh=EDVLrYGSVDxhPMAvkLtSTFIuFW69/ElWMJsnZop8NBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pZxXXmyVzwGrJ7Y/l/pXxgxqHKyyFI8MPm2lvsovNtiyU3M1mvz6yTgmSYqvqtU73
	 HFdFJYFn7lTWsphiw1K/GUI9DZHWK+slvDpB6K6a64JM9gOQ59n007A7qYYMEx7/Nr
	 aGqapxFXxnTQeZz2w5F0Skkm5jXxrETKc+fd/H1HRjAdaAtCgsYc83xlp0yDV7yvYC
	 2ZsMpoPphRM0i2Q1SPdv7yWXJYNdg3Mex7LlgNYgjBhnFoovgvaXBRISAuDBGjwzx5
	 kM9LxW0fmYuwq/xHvMos0F5ZW678wafKGAVk7k/fXltLlcRlrqMUrDsJ84hNjmfs/V
	 QzH6Wm92dPMyg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:41 +0100
Subject: [PATCH v2 4/6] ovl: mark ovl_setup_cred_for_create() as unused
 temporarily
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-4-bd1c97a36d7b@kernel.org>
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EDVLrYGSVDxhPMAvkLtSTFIuFW69/ElWMJsnZop8NBM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXGtWSU8Ny1dSTXjzT3Na3mZPycK+eqwZNxtDBRY3
 XTmrHpCRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ47Bj+WX6v03GrO/rKXn6j
 eVaH6Jdig513/0jcML/CLeecK2f0muGv6D2b2LCL8/hXCHGHeP35uvHcIxVFjs5NB9YK38so9XT
 nBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The function will become unused in the next patch.
We'll remove it in later patches to keep the diff legible.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 150d2ae8e571..1bb311a25303 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -611,7 +611,7 @@ DEFINE_CLASS(ovl_override_creator_creds,
 	     ovl_override_creator_creds(dentry, inode, mode),
 	     struct dentry *dentry, struct inode *inode, umode_t mode)
 
-static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
+static const __maybe_unused struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 						    struct inode *inode,
 						    umode_t mode,
 						    const struct cred *old_cred)

-- 
2.47.3


