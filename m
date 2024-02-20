Return-Path: <linux-fsdevel+bounces-12088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A32F85B26D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DF128379B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75057302;
	Tue, 20 Feb 2024 05:47:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3331545942;
	Tue, 20 Feb 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408078; cv=none; b=b3tnxKMQEBOxqKK1lpi0feRyRWv6oV1wb9hK2r/IhCs52biy5CBlJB/IoirQvi4nhnGC0OdKlbCN5LFwSTCgIe4zlZMI3Rbk8RmMfqxgYl1vJsbDP5VZa9Oyvl2fH+6gFrqJ0wo2CjNVf4IfZfyHOhoe4qa3NTZFuwroxr50TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408078; c=relaxed/simple;
	bh=wY1HYl2XkOtEM52sVVhgKFR+TXADjtjGZU+zJjoT+os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tTWKlPLLo078IJ2jgh/FWfeb/bgOK+NRbYE+5AH5+m6AEDG9XSH4vZCm3dxWpLUK8pZqrkozh7HCKmrlxiylCT7yAqczRoOIuK6bmsP0jM11eUAu6TClj1gs5S2X64zR5sdyncYfw9P0LkMN/B4/wt+y8XJBIcZxHWxMm4eSMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E9A9560263E24;
	Tue, 20 Feb 2024 13:47:41 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?fs=5Fcontext:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Tue, 20 Feb 2024 13:47:35 +0800
Message-Id: <20240220054735.65310-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ret variable is assigned when it does not need to be defined, as it
has already been assigned before use.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 98589aae52085..3ff30227a061a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -207,7 +207,7 @@ int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
 			     char *(*sep)(char **))
 {
 	char *options = data, *key;
-	int ret = 0;
+	int ret;
 
 	if (!options)
 		return 0;
-- 
2.18.2


