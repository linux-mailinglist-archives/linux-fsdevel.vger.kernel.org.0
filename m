Return-Path: <linux-fsdevel+bounces-4128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F57FCB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628A71C204BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632E1851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0sxLTib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB581850;
	Wed, 29 Nov 2023 00:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A6C433C7;
	Wed, 29 Nov 2023 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218250;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0sxLTib1738DoqAYLa6Z6IamyW7WkvG4ynFLHRkwSv2nkb/IztwsDdcgtxbM6DwW
	 gdmz4bKoT5Cf3obYq0p+0RLZvP8V91e0LvShf80A9/hTD07vtXuE3sNUdEYCf1CogI
	 BRTyad3Hsw3t4e7HXFGbyxSKAsdnpFh/QlmbSFPdV9V1RajimsRtWJMOnspRM8OSHF
	 V2ZEp5V8JOpFTlE1tjXBkRQTMfYmTGI819Q2c/WwHU28rhKXKolCmj5G5w04YcURgH
	 ma5uayHb4/uLKXw7zWYOun1Ra/5kRc8EyYudUMI1KWcAc0MijZol/LuHpbfvAV8qx4
	 PajgbwYgGpNTw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v14 bpf-next 4/6] selftests/bpf: Sort config in alphabetic order
Date: Tue, 28 Nov 2023 16:36:54 -0800
Message-Id: <20231129003656.1165061-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129003656.1165061-1-song@kernel.org>
References: <20231129003656.1165061-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move CONFIG_VSOCKETS up, so the CONFIGs are in alphabetic order.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3ec5927ec3e5..782876452acf 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -82,7 +82,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
+CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
-CONFIG_VSOCKETS=y
-- 
2.34.1


