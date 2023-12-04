Return-Path: <linux-fsdevel+bounces-4744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6984802D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F7CB20405
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B8FBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HwF1ZmCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2653D42;
	Sun,  3 Dec 2023 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=YBK5uUUq4Kh+mKXkGIMtbxBTs5GdJO+UnTKPHI6RDtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HwF1ZmCkK3/cZsLZOJv8oo4VnkXsmy+e83QTxGR6OAMWy6034AS1J05Qn6iJDUsRa
	 NARdauvNtYkyLtyyJLRFVL7ZgNTceZ1GxnYNFemiMoGsmcTpJCCoAvGGCwuh/bqW8H
	 7eXQnHLp1awlSAlZluXVC2x32y7csTxkaF56ZgfA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:29 +0100
Subject: [PATCH v2 16/18] const_structs.checkpatch: add ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-16-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=637;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YBK5uUUq4Kh+mKXkGIMtbxBTs5GdJO+UnTKPHI6RDtU=;
 b=nnAQEMVMy+ZyEC0A8HsNGfIvnZ+oZD9y9hLvLr/X2z+gUtVWX0NEtzyKPo6I2oGRHVEgqgT2b
 3WDkqH05KtyB4unVcVSlwDpFO055j+V5E2NTovlZVL9t8mub1r/wjSp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the sysctl core can handle "const struct ctl_table", make
sure that new usages of the struct already enter the tree as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 188412aa2757..0621c2d652bb 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -5,6 +5,7 @@ block_device_operations
 clk_ops
 comedi_lrange
 component_ops
+ctl_table
 dentry_operations
 dev_pm_ops
 dma_map_ops

-- 
2.43.0


