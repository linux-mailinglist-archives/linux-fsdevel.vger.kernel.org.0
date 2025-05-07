Return-Path: <linux-fsdevel+bounces-48334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD1AADA5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E09872B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22F20E71D;
	Wed,  7 May 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8vt4voB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C71E4AE;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607367; cv=none; b=CLZ0CB2WNRNHSa4TyOLNkxlFguRA6DXs5LfEyX9t0np43/JmUBK7bdLFVFLsIu4p2VKoqvh55P3NnQqoDoKWQlTXraoIlRespFI1y2aw1d3PMvSzYKwHDR+PFPYfOIV5ZMjh18ICEsGrMU9LNevPOlDP1xR6TCNh0l9SYgCTQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607367; c=relaxed/simple;
	bh=kUhCRBq248hSPNfPnHMQzMgJGoZH/qz2S3cP/dYgX3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPeZBsootkVSd3mY4zQUSbxJBlLDTFqki0vfLc4fDVhYN4CF1Zd/rD1erOFqBUymnLOtRsnRZ1ifv0lh5VNQ5KizUa/mUgsBroFwj9R7Hl+xnFGUBAcBtRlNuyVLAGmjh502cYa4bIN8NdLMZ4wrnXfHFiIAawdhFdpy91CMYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8vt4voB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B07D0C4CEEE;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746607366;
	bh=kUhCRBq248hSPNfPnHMQzMgJGoZH/qz2S3cP/dYgX3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D8vt4voBAvGihdx7U76lgzP7jOSTwTUEbOv2JMITD0nZFUt5Oavhx6UbUM0rQUvYw
	 vOholWnxuH1nFrKy+YXcau5d3w0tK7VCdnKasxLi2hIs1PqcQU5msI0aB5jKsgfv7j
	 nNc7DtAzZAmLcOBV9aTGpsmD28q8PZXQ+i8CjPGpj5zmnqozXtl/VmtPVKmtDfWLx9
	 qOvf713IO0yi1mZe+O5kuJgUMYCxozyfELNq7Ykzq+CI6t69h6dWgcQaQyvXUFfvH7
	 PwpuxkThAtpCWmp3d9Jiz+QOkpacuvp+myxARwqcWrtVwVSzFeh6Ra0Ddu2kdGtia8
	 Ddp67eNaYW99w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A6C3ABC0;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 07 May 2025 16:42:16 +0800
Subject: [PATCH v2 1/2] MAINTAINERS: update filter of FUSE documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-fuse-passthrough-doc-v2-1-ae7c0dd8bba6@uniontech.com>
References: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>, 
 Amir Goldstein <amir73il@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=y42qoLgQli2vjKWNdl397i8EcidQOg+VhEWweGEDgMQ=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGx0D4Lng+/PWfbuRBECYjR3GOdxRrrem5npZO
 RxvyFHnioKJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBsdAwAKCRB2HuYUOZmu
 i4WEEACEiCfgkn/+Uh4aJp1ZgralHr+/z3NAEsQiarUZgLTRWT47ShbUYw603AdA8FOb8x8b9LV
 bWnDA5t5gM85bpgMpnjxi7lR6cQJwGKuhU3e4ErM3q2vm0Ab2xxMOw4tOo+X9zcXWSB4gBCpz3u
 cnVGkp6qxUgcpNY4Wicg5v3D3IBSOjWWDMaH3i1GU7TSs842ixqTeXM0E9wUCanN4eRm1LGDzm+
 cOxIFyKKyXuEP4pbmuCnvZRCMJdEpodgmhBWIKicMf8ggWd2KwF7gL0o611KFMnv4FGWWFWJjxm
 7SwvyekAaFhhvoNvxnHNNwUvAPak2PPtWBVa5R7adp8Tg/AwohX5grOy3dqNSVntRVsaTl07iBZ
 aleSnassOaKzJzl13tHELjK2iRBw0G3QZn1/CjfKWVV5XLaa39GxSu1PsY/kUxdLI6UYk/ZDoCL
 8X1UdYfp/jsbtfd1c+I2aQbBvTFqqXLaAq9uaN8LeP3Fgwm28ib28xkxdf1Og2rX1ZUrjHNEyxC
 Wt58ChOL7v6FGBHo30wZzpolwMOl4RCC4FF4r2d+ok1W1bUKlrWJQxrLuN3GH12lNIeHJqALezX
 shJDQcNX+vPRCGLIHouni2aplzsGMHbgKP/nU3ZHDaTwJp6HZKlojYMBf2NHLlj4N/i1zlXUuSG
 HJqUX3M9koNMynQ==
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



