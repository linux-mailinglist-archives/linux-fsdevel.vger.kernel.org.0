Return-Path: <linux-fsdevel+bounces-48462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C4AAF614
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21003B28D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFE262FF3;
	Thu,  8 May 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mau1NM5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B923A9B3;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694454; cv=none; b=GWvMDF1JZ9HkW4EQOoDWL2Ae14pNhxPMVlUOYvWZYm6vsF5xWonYaXh//hXZf5utLrvkkA7mRhxB96Re6ENoM3jkFk0njIjiSBB2Ffl5BoSpfWsXQolDXDAa3meRas2XSjNV8oLSE1dStBZAYYifL5n9VxGrbvJg/k9W4/MTUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694454; c=relaxed/simple;
	bh=v/JeCC0zei40yfy+D9huwYbkieCaFfFFzax9gBj3owU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRNAJX1gK9lgjVTgRzlfHNbxyY0r049WRzsBVnaR+K7CZmyyBHVnxU0SBNQEA8LY4mWQgvxGrIjUYwDw+7fMs1gJ5oGSs83Wst7nnZOXhaVUwWd7TXc4gmMJE7TwPYpD8Dpx60Wq1PmzyywqhEKXbsPVFXgm1xVGM/i2G5mVbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mau1NM5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524B7C4CEED;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694454;
	bh=v/JeCC0zei40yfy+D9huwYbkieCaFfFFzax9gBj3owU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mau1NM5kA8bVVCxDFfqD3XqaHpERPiVwXINSlGKn9d5A2lb/x8CFgrJ9WOgNTY/FR
	 tzIrBpt32sgonbEg+9e5P+jUUDoLZZiQp5aCYrNy1NJr9Nc3fIaj6Jg7vvvL+cv5+5
	 mdvsyQEjqDA3jeR6Ag2XQ3dSo+Ddi5eQiMCCxJYY3XIc6MniCUgTDG2M09dOYBtMrL
	 IwKPavXsVAyHH81429bb2qYNS/zbJ1ASOdhdT6l/BteCK8NtlxI3o/CqcdkA9kyPNg
	 CaD5wUokJTLJcVty/7/WRGZaVfXAqVUkMvGDdbb108akyKEFwqvXEoWKOcBzZAfV44
	 QoxQ4dplJbtNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A38C3ABC0;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Thu, 08 May 2025 16:53:44 +0800
Subject: [PATCH v2 1/3] fs: fuse: add const qualifier to
 fuse_ctl_file_conn_get()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-fusectl-backing-files-v2-1-62f564e76984@uniontech.com>
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
In-Reply-To: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=5gsZgPpE9DdgJfjYJLZW01nMHgcjhblXor/5EfeOtfc=;
 b=kA0DAAoBdh7mFDmZrosByyZiAGgccSyhL2I1RGp5aE6Oi7v3yNvrXxNaW2mUx61V2VhZzF26t
 4kCMwQAAQoAHRYhBM7VUSUCTrF2/LRlWnYe5hQ5ma6LBQJoHHEsAAoJEHYe5hQ5ma6Llf4P+wVF
 AFOZayfsTWPOyAnfC7cM89rseJKs3NbylmfKz6jgD1QFtfs4pL4fZ9VN4wiz8Hv+ARcZ2gBr2O2
 XS4xIS9jTrZWFVMViuBWhAmsWoAH6IAopxPBWkqVTcwjUyrE2mupldzydmGZ0dgR1ugI6ErUsTb
 3OSouN+R0KAAaEey30IC9MXPCC9hfp6dD5mcg/KpNxa2TtItwyS3iXznFdmM/azcdXN8e8xjIpn
 z+litVFXZBw/z+dc+WHn9kqLFMBx78AXMvOZtMXbgdUr/POEduNJwvcf/QbKcn+kPy7IIK4PxIa
 gpzC+Ur6izsh+AuTwIoAdtadHuFVWXuJE3DPgnE680GSKy7voi4JvBqCV+M8Ppj7Nb8d1C/vG/c
 GoOTo6BicSToFD9PRasGtv7RQJyKKacKwarfD2rr4Y48IThLXOottiUnDs4Sy/322QmpldRVjn0
 sm1LrwzjTEHg2srN1J7qD1Cfyj0Nts/Br6lJb6kIOvQdtguoJucF7oY0vRPPiXM835gCwnee81p
 Q/+kMAIFsi+Mvq0cdDRtcGagrJfmHbU01Vew2/pOkLLik11yrr8ZIS3jryzUzfChwRdiSmOgPS7
 mRsTaWoNyyiC9peAlYF9f2WszTsbFTuDxrzvV6MiklM4KRO7CzfBSqt296oZWux+jyeeq8Cw2/V
 aQBIJ
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

Add const qualifier to the file parameter in fuse_ctl_file_conn_get
function to indicate that this function does not modify the passed file
object. This improves code clarity and type safety by making the API
contract more explicit.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/fuse/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..f0874403b1f7c91571f38e4ae9f8cebe259f7dd1 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -20,7 +20,7 @@
  */
 static struct super_block *fuse_control_sb;
 
-static struct fuse_conn *fuse_ctl_file_conn_get(struct file *file)
+static struct fuse_conn *fuse_ctl_file_conn_get(const struct file *file)
 {
 	struct fuse_conn *fc;
 	mutex_lock(&fuse_mutex);

-- 
2.43.0



