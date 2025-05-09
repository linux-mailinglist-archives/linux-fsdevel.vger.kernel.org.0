Return-Path: <linux-fsdevel+bounces-48533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438DAB0AA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14401B62E38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 06:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33126B951;
	Fri,  9 May 2025 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv6NSuk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3E2746C;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772456; cv=none; b=MKnIQWlgVAzPi688teYpA3nvuR07ANXGvUbvUiCwyA8N2XjpCYxW4rtb+LQ7libV5BOi/VmztU2AXrWE1pmZZzkMgkQ5zhS3RDCJnNIZPUUhAauPDrJwGxUEL0cNBO1tntldTBIkiaD7Zopvm7eCWUE5LrNYXjnVcl8rC2KhQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772456; c=relaxed/simple;
	bh=v/JeCC0zei40yfy+D9huwYbkieCaFfFFzax9gBj3owU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qziWuYx2RbHmeqfMcBDKvCyHx5KAgerk3qpZCpCYT080EhFSdLEXBD4lXSrgSQ1cH8WUmxE6d4HrtBtPc1B7cGBW80TLrI/zTav6c5WVet/lPOy4Qr7jXO2Y4i1SiEBNfmvlRd1c1bcgJsIs4Iy451Q0xHQjfNcZVPuFZhDX7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv6NSuk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 775E0C4CEE9;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746772455;
	bh=v/JeCC0zei40yfy+D9huwYbkieCaFfFFzax9gBj3owU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rv6NSuk4adnrMXKq+VlDyhZn9nIJF1tdVBwNBO7diVh716ZmcF4wW64JfJzzPwrlr
	 f28X63vpY2BoaECUEP6ggbK7h4I/tKR6meSlz8S07Wddp29hs5Ajtgrgm4Ril/lexg
	 nAFPy35r9zFhH1KTPwRp680UnqqKM2UMuAVkLVS/z7cHzbbARKKx2OCFagI1WyzJRL
	 7DS2f/GbA8xsQA/KtcSd0Fv92xy2vDUIpZbHBP6Vwkn0XM/nxf2RmBQw7bhQG2NJ8V
	 +RsKy6FAgtWk1JarMHHssBtbjYkB89XMS6ASiCpQQrTuuaVLM/7IHfr4Uq3F218N3d
	 HNBG/QZ3wCv+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D44C3ABC9;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Fri, 09 May 2025 14:33:53 +0800
Subject: [PATCH v3 1/3] fs: fuse: add const qualifier to
 fuse_ctl_file_conn_get()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-fusectl-backing-files-v3-1-393761f9b683@uniontech.com>
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=5gsZgPpE9DdgJfjYJLZW01nMHgcjhblXor/5EfeOtfc=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoHaHiGBTYKTNPLygt65IWwju1YTcRzZlzExW2K
 7EfQHe2FhaJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaB2h4gAKCRB2HuYUOZmu
 i0T8D/0V2wpmoYFcyUr4RitSZ6jcZ1nvzzmOVRs7e/J1xspBATHnhbH+Apfu0vleG2vBc2FPHg9
 c3vJlViJKQhida9zgXtDfCDc8PjwaeRNiKmiVmvq6Yug3+AjJE2fdRL4cilxe3h0ms/MEzXgP+H
 170FDIGZ1Udm7BzdSVwK+t4XUmINkfKKkl7VJTmQh2JCBbQRa+6t4ZOapdJIir8hWPHUzfmcE9F
 Y3kF+heZJrTU5rJzO6vMeDj9NfEVMXKgTroMsjiZ3VjBL23Ig4NRch4TL50ef9KMH0j53L9EV/2
 +clnoh65gDkv4hT9EYrF9EZxgS467tuRvjjnQuWRLVKXTjDmudDKpA9hft5qERyO4TXNIU5EVJR
 AY9BxoLvWTtga8kF8pgpn1ewu99ItD1b65VRf/xZc8z9/nNhVNzxNLarcKTF8edcxoR66UDxiX7
 Smvw0XbG5U3y+70cvPNzOsnbi760+CkU3w+gB9hPrB08/73kFVUMB3veXj7bRaFx45TqvRTqLXp
 85EAbo2gAiI5nUJnCfa324u7tKxRsV3IvxTKCYFszvTxu+ORiLfz7jCg7VhziAk5A1omoDIE+mI
 tRoy+OYpJSQLeOoWDdXPE7bONi4O/wP7FjjdzZUjHrczQaZw0tJUpxx1JB5t24eFfqYihDn7QOP
 LWLrDnHL2HDKJ3w==
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



