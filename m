Return-Path: <linux-fsdevel+bounces-3569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08AD7F698E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BD281A0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5603405FD;
	Thu, 23 Nov 2023 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuabFbCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B814F8F;
	Thu, 23 Nov 2023 23:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C595FC433C8;
	Thu, 23 Nov 2023 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700782833;
	bh=6IoTRz3NXYHV8pBke6hkoYRnh3FOSX8xy/nXoYMfI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuabFbCr9L9xOlZe0xRdYeXrw+E+U5U8v5YoRXydiKtOQ4f5Frtpw9tZmhOyPCJGn
	 Z59/Kr9cad39wl5MC9ICwCKV/RQ3j16t2bQ5Px+pRSdvk4M0qpBOrGuO9p6AggkZiI
	 Pqkc+UndPU/aK+Rdfip8HUYgzr7moq929M+kALwvIQu9uuXH5TjIM2TFn6ovshQG0i
	 YqgbIJbLFfIwOUCqpKtM83qVcQBcNYZ92vjQLPf/2ltwSYVwziJxVqN1dwpucKDsFJ
	 oCbw48xKmad+jDvEYOzV7igzd6Vxp4I11B8ftoTfqHfFQFt1VyM8aoy8VxvwiYkj4V
	 VOzFGVqmDBzxg==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v13 bpf-next 4/6] selftests/bpf: Sort config in alphabetic order
Date: Thu, 23 Nov 2023 15:39:34 -0800
Message-Id: <20231123233936.3079687-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123233936.3079687-1-song@kernel.org>
References: <20231123233936.3079687-1-song@kernel.org>
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


