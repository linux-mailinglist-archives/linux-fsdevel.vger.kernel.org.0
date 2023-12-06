Return-Path: <linux-fsdevel+bounces-5058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B539F807B71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7016B28202C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422E4185E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="h/r7fKGw";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="UgfsXt6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a48-177.smtp-out.amazonses.com (a48-177.smtp-out.amazonses.com [54.240.48.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36291D5B;
	Wed,  6 Dec 2023 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896586;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=OCAlzX7SebA+j0HU4Sd7LjmJRCytQLzLNtjNPcYsg/M=;
	b=h/r7fKGwNyRQXQ/klZ0/fqeYYMmBzNl5n9mnuZL1ohKmcjySR0APw9WYzIRomCgm
	cvK++RoQJxfhIzH3u5eT+IMw3D3IcDf84JdaUMG1U5q2uDDALvgmvaDg6CPBYoT2gHK
	vQgc9fH23NGP5DuMD8LdntCcGHHIsnmCQCfF/XdI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896586;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=OCAlzX7SebA+j0HU4Sd7LjmJRCytQLzLNtjNPcYsg/M=;
	b=UgfsXt6Or2ojBf76Wxu+AjMwJLnevzWfnydHUHZV10RKwXRG8xZFAeT4f98ghuOO
	sZTChlvoCdJCkD9gWYrcZTnPHXFOZDoWVK1ey3FRvSdybHdgln6I4R5CAh8qfYanjMN
	GinrcGELwDU5KWuy10CRatFMrr5sUHnJOc04snqc=
Subject: [PATCH RFC 4/4] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel build
 parameter
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Cc: =?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Wed, 6 Dec 2023 21:03:06 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20231206210252.52107-1-john@jagalactic.com>
References: <20231206210252.52107-1-john@jagalactic.com> 
 <20231206210252.52107-5-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRAAAASpN
Thread-Topic: [PATCH RFC 4/4] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel
 build parameter
X-Wm-Sent-Timestamp: 1701896584
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f105c7-7e0d722c-4602-4956-8c3a-52f693e97e7c-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.48.177

From: John Groves <john@groves.net>

Add CONFIG_DEV_DAXIOMAP kernel build parameter
---
 drivers/dax/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a88744244149..b1ebcc77120b 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,10 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_IOMAP
+       depends on DEV_DAX && DAX
+       def_bool y
+       help
+         Support iomap mapping of devdax devices (for FS-DAX file
+         systems that reside on character /dev/dax devices)
 endif
-- 
2.40.1


