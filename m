Return-Path: <linux-fsdevel+bounces-2772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A77E8F85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E481C2048C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C560749C;
	Sun, 12 Nov 2023 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Nwy7SChJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C16FC4
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:02 +0000 (UTC)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025F2D73
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699785838; bh=HrpCd4J0WeUnO2tdeTZYvo3s73m5X/szpZoUvs/U++4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nwy7SChJdbFZYL+AieeEyDXnYemm+Fr5UWJvDMUp4EQnkVMliB/hXen+XLqcTWdVx
	 vLnAge8r8HPcuD2cGupeAk+gsVemdyJxv2Rm0nQvmG4hWs7wnP4C/R4odY9U+wixOz
	 nYHT48O8w/gq36wf0eJkBl14Ot9+EhdoicINQLFI=
Received: from pek-lxu-l1.wrs.com ([2408:8409:7820:a380:549b:dd5b:edb5:dcb3])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 8EF32421; Sun, 12 Nov 2023 18:35:47 +0800
X-QQ-mid: xmsmtpt1699785347t50uz6kj9
Message-ID: <tencent_3FF186FD92C8C658498FEEEE6EDACC8BA706@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8H18Ua3VvosnJaKYelyVV+BDuBv69pnfyiFo8cel5u3VBxYvHww
	 iYNSeNvtDiJjxAApeiGaraPJvISvn6QhBlF1IlUc6lAcrA3rIfbnSRLirRayinnkGChM786Gn2hx
	 9GxgTeIa2EjKb+w5V4/oIG8w7AZFYduvv4JrCXJhj+qCJxHZWCEKEf91qLouWNqOMPFCdJssMa++
	 ZhS97XoBkD8ghXNPfPxatHF+uQrLBnxntvDtdpFbc4oNoDIqi6fL+pRhcvwvGFx7OxzN5ynnSPCX
	 uwFCmYExnT2nu+J3+XJfZ0XyDurdj2rSKK+yuBU4SwWDaUKqrcxK8N8CE/rgSWUxLj5WbXrpnJHr
	 9vU1oUGX2t0f2/mb+9DBHXCUOh+b8Y/etlcYghzI+RrQpuJzq9qSI8SveqGXTYPJOqyldtD4aupA
	 TeY8bMVf5VKmLy15DsmDD68UDSuSp8vIS9bMpHfWRw+ka7iojqKh6YqP1zqv/ehT+JTCgEk2clqn
	 gitUWJaa1YHu0tkyTQbZ9uEOcc6EpERpG/0L3wj8g186JJaz2FuWd07jQA8HnKLgXox9dq61iPtX
	 eLq52yRuWcIeQl/TZUbzrO6dDvWU8dnBhz7htaOvCXaGOxV1NJgfP5E54JFAObXcPeAJUnkqqYRp
	 8YcQDNt/YXWAguz/i/Njp/Bw8/hAucf+Nc/JCKddfGWqb7DfeSp743Wwxtkisbi7BnZgmirzLioq
	 kXmOEFLI1OiKFI0PGPwddJIUUPL9fxf8anhMEXU2mDAsdDNmy8AjouGT77f9phL+4JRSYlRNvXF/
	 WzXWN4SaG4vNl1ZHNcqH6OEyz+WIkSvMlJI172Sz4h0f9ZTNwdinhCrJ4U7J2/0vw8xOB/wvjzcQ
	 BLJ0oLEl8VvONpi8XOJ/gva5jkb9+IQWJmBMZaX/ah1VBeqs9+94846jhmXXRPzdy/HztSxDIRWa
	 E1h+i+LZZbBvPmsoeHbg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ovl: fix memory leak in ovl_parse_param
Date: Sun, 12 Nov 2023 18:35:47 +0800
X-OQ-MSGID: <20231112103546.939432-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003c31650609ecd824@google.com>
References: <0000000000003c31650609ecd824@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

After failing to parse parameters in ovl_parse_param_lowerdir(), it is 
necessary to update ctx->nr with the correct nr before using 
ovl_reset_lowerdirs() to release l->name.

Reported-and-tested-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/overlayfs/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index ddab9ea267d1..1f73f0173015 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -530,6 +530,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	return 0;
 
 out_put:
+	ctx->nr = nr;
 	ovl_reset_lowerdirs(ctx);
 
 out_err:
-- 
2.25.1


