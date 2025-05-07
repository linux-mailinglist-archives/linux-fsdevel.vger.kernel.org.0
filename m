Return-Path: <linux-fsdevel+bounces-48324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E9AAD508
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160AA46887D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76291FDA8E;
	Wed,  7 May 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPjrTq05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36B1F4624;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595038; cv=none; b=SBE/Tj/AWR0Nmb54DeDkPgUvDrNEMM+I+0VX+WxiCVIwbVv07VScq7QwMps6JKB6X9+zIJ9/UYKoSRpjSNadiN+glLv6eePyP35sEN1kfu688w/NB9NT/9mEcC+6iNKNQ9NEKZI+abgDnK0QSWOxKCmBFqxF1z7cVKjwx7CS0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595038; c=relaxed/simple;
	bh=B8NpKxrwYZxSz9hMVHyj20Mac0krr+WWB9ISsB4QJcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2Er0EbWJ12CAcmHbZKCeCUbjkOERWHH9ongOm7AKS4OmzmjD1ElDJUCaxYZbN/ffm5Wm0uRWibTAyX9f+4+dEPYdIXE/tnO0x41MY6adOtwGi92jH/EHLwt12DRSkhiQqF/0CkamiVN2CJ6YzvHVEh8SXvFSBc9vwfgeRvpcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPjrTq05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92344C4CEE7;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595037;
	bh=B8NpKxrwYZxSz9hMVHyj20Mac0krr+WWB9ISsB4QJcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bPjrTq05A6FGoVu8jzxanIsL8aKa0VD8lP4hMsiEWwcTwMlaHmBMtFR94CD+iGILU
	 CT2As708AncNlD+GX06AGwiUIY7l5FU5QWH5iyqIuAeQ3X165ocDbCqzErlucyij+S
	 0VKaZTaeV74e3T22u7F1rqoVsjs8FWlCkAHn+9T4+teGsLjhEWbseRhBVDrufcn45k
	 TxX5wlIHEa4eZR3J8KQcF98m6YNZMjS9Hwu7t0xPLB2f2rejIzhSs9umTSoc/5+MY3
	 f+89cEky7vmlbakNc1u/td4Oc0AN5fp/hMww9tKp911Q/PeRtpFQ4k6GijIT43ue/4
	 1Z6qYCfV+bnDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB14C3ABB6;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 07 May 2025 13:16:41 +0800
Subject: [PATCH 1/2] MAINTAINERS: update filter of FUSE documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-fuse-passthrough-doc-v1-1-cc06af79c722@uniontech.com>
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=P4ex4ef6eoPig/ZnjlaXABq/hCbg/0h544yo4BjXjlo=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGuzZSHEV6MyFNTei3rnABGWONK5m6STtjTshr
 jQKp2xUFKKJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBrs2QAKCRB2HuYUOZmu
 i6/UEACcakG+wlHZWpeHpcX3EraI3QxJN9nqyfzFLNBcPL1UaaSiD/z/lm/ar++ujtxTLKwASrV
 jL9iduRXWt5WdTc/I97Ssrs+d35LbS+7ehacMBZUOow78d6JHtWTrZL/Y5gpMc62EcE+bEkunyF
 VGePbYz8BMQxB7c2pvQSY7aFUomtLa6aXgizf5FOvcfL3WnmwYT/GOsUl2Kch4sG2ctSlFeOs5c
 YhN1bxeunBBwVC3JZ4ixaTr9cQqherl8rXk0GvSZSalfN5em1bofUWIg0U5lH0ag3CGjOTlMJrJ
 t01yrpFE7jv3S0aAZ2HgiDyqs2hVSBH5JeLo7gSht8Hbkpw3uKA4kmhcPtkaSFreGPsUjfE0JvQ
 iPuPd48C+MBjpD+yICwhjwBm1PpqPUewXmS2c3cM4cePwxExoS+MFBuLEwz7rZziejhWqjFQF3E
 hK0D6hQM1UrQ+XbBTFqgBskaWAU6WqoplI6rf+vpPDVwkOpNCPlNshW+oJSD1ORbRgL6kqVHH1n
 ZV8IE1mQc2Oejb1s/Ps+u37/lFNEIK+u8b/IKQMRYwjidNE9dtpRx1tGOc1/OF12CC/LJ/jNYiA
 I/0IGCLfjv0LZjq/SPynk6w80NJQPLXbOvOwZuSAgH8mnYrGtcC0pkH4jAtB4DurObI7u42w/6K
 rlh0YdSKuLsvlFQ==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

There are some fuse-*.rst files in Documentation directory,
let's make get_mantainers.pl work on those file instead of only
fuse.rst.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f8688630c014d2639ed9023ba5a256bc1c28e25..08cedaa87eb3f7047ca49d0e6f946dbd8e7ad793 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9736,7 +9736,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 W:	https://github.com/libfuse/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
-F:	Documentation/filesystems/fuse.rst
+F:	Documentation/filesystems/fuse*
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
 

-- 
2.43.0



