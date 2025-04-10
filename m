Return-Path: <linux-fsdevel+bounces-46197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F12A84202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E1217A6BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADA2853F4;
	Thu, 10 Apr 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Obq6f4i4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9C2853E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285570; cv=none; b=WxH4TUUYWuCG7kWt3Zy8bINzReJaKH/5W7xwEQlYeohKq7tnPLvaVZqp4b4CmUevsDxG1BemhPGpglPkYi2v1uNeWdqodHGGuokfkv6TaqNZpk3V8K+ot/2Y6YrU3n3zOfkemMz+3LUD9ja+l21W3TIRqYAj58OEbvfLtm426vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285570; c=relaxed/simple;
	bh=DVnsjomPSF5bxb2nTDpMndwEoLHx/PKuaBexCy0g8c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CROnPTZzHuKtABUExFBzfMKg6pwKGj2c+l/xQhZS+4nuRVzACqDRcGzizR1/xUVusRi3nG38lyd+kzk6ADW2HcyNvf83QL2PzvSUrUFgznJcADI3676nNloPU6HU4nrkUD20AnGh3Mgdt4nyEClOhRdTq/G8AVw2lc4RZ3Lg+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Obq6f4i4; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=r4cwnM2naJBhys/ZEhnMP0ewYkylFqSW9802uv3re74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Obq6f4i42jg2upEEt/Ai/0lYPqEeioHNjLPVrKl0QcJ7lwLU58CuYYy/xTri2VcqO
	 dCgtuMNcWGGUu7cdLmeuAKSHkYOfgmZSQ0gXxFvnEofCtjrO96fLPssFK8VqLQXeyx
	 azr0XVhPsFFQLiaFqSN6rRDycrScNkTQFRFaZgS+mDAo0y/ORYADplh0Cnjl5+5O+P
	 KhInUXGK6KBClJVGxZW9CI+ABVXBicwoMaZwqxywRLZ/iomLX5/ETQwUGcz7HYmDir
	 /n0VNX0QkoFebRwFt+tUSexR99HUYP3TQC64LAOoL14xmsY8d4hfjoNac0m5+Q/a2Z
	 vAwINYBelMskw==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id 8C9723058308;
	Thu, 10 Apr 2025 11:46:07 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 68E97305859F;
	Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:45:30 +0800
Subject: [PATCH 4/5] fs/fs_parse: Correct comments of
 fs_validate_description()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_fs-v1-4-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
In-Reply-To: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: N2ScF9jyyauzOuQ-N56oq7nKtJVweg4Y
X-Proofpoint-ORIG-GUID: N2ScF9jyyauzOuQ-N56oq7nKtJVweg4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For fs_validate_description(), its comments easily mislead reader that
the function will search array @desc for duplicated entries with name
specified by parameter @name, but @name is not used for search actually.

Fix by marking name as owner's name of these parameter specifications.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/fs_parser.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ef7876340a917876bc40df9cdde9232204125a75..77fd8133c1cf191158de13ec556a5e3c7c2bb12a 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -432,9 +432,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 }
 
 /**
- * fs_validate_description - Validate a parameter description
- * @name: The parameter name to search for.
- * @desc: The parameter description to validate.
+ * fs_validate_description - Validate a parameter specification array
+ * @name: Owner name of the parameter specification array
+ * @desc: The parameter specification array to validate.
  */
 bool fs_validate_description(const char *name,
 	const struct fs_parameter_spec *desc)

-- 
2.34.1


