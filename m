Return-Path: <linux-fsdevel+bounces-46294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8FA861EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC843B60B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE144215779;
	Fri, 11 Apr 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Un0jMtNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7461F3BA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385537; cv=none; b=SO5yJe2EPtqZkoVVCISMujSwpMAO6KpT0WFwpuFVyloS+JhH7IZ1E5iM/dodcQ9jnqzNjk46SrU5a11qj+9DgmugeTmp6L6PWC4xMh4SQ/BkbbSscxhokyCsrezn1Mo+NwRjfmfajJkBQ5NZcXxj/ecFgSl6CBJo1/tJFUiLhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385537; c=relaxed/simple;
	bh=Q+b1uj2Yuc5VJ/ui7Oz4J9OvaUP+S6G9VrEPYRna1yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt9VKoK0sF3ipQPpUWBLlrOfKfLBfN88AQ6+vVyYjdSTbEh169Cwl/kSGZojA3j/k1HhZ718UPbb7hLdRvtOCg1Yg83Qe7CvCN2mt1x9Gj3Olp7Xcxn2q0SwJeWDERdiSOfbK03IciKxrgwsQ8PebE7JOxVw6Pc8a8ptTG79W5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Un0jMtNS; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=yujqbfWH4Vu7cBrznjNw3PAx5cjIMFD5qOZHcZDi32I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Un0jMtNSdWU2dsdyZUgCWkrlVJa6I76EN2yfmOwITLHYCbrazYz57jWQjPNRploRi
	 coP0v/uNj/aVWU+Q9IY2peqx9zjZ3ntuvyt11U+9UPo38HYwn2Nw/IOMhCaiqV/ux9
	 SRoP4dwDcP4kZwQ9nYPQU/aEKMQf1wa5b4emqZqqsZx4tvi+I9TAvo5TH8DVq6Dujx
	 /p324vBUOT2iK6CwclIK1N7pBzXYoAArgcUo8h2sw2gyo8G1EosfkbMBtv45at6lYm
	 IQJ5dGya/1PjZL6Bm//E1UJS5/DzviTpjkyfhhoNPp47e9VlDAfCOTHlzvaHJ1phUj
	 jNOKikgk0CE/Q==
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPS id 5A8FB1E0310;
	Fri, 11 Apr 2025 15:32:13 +0000 (UTC)
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id 648961E034D;
	Fri, 11 Apr 2025 15:32:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 11 Apr 2025 23:31:41 +0800
Subject: [PATCH v2 2/2] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com>
References: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
In-Reply-To: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: oVcoFRum3OnSNydi8BgdF6TLHwzlIMor
X-Proofpoint-GUID: oVcoFRum3OnSNydi8BgdF6TLHwzlIMor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504110099
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Constant table array array[] which must end with a empty entry and fix
below issues for validate_constant_table(array, ARRAY_SIZE(array), ...):

- Always return wrong value for good constant table array which ends
  with a empty entry.

- Imprecise error message for missorted case.

- Potential NULL pointer dereference since the last pr_err() may use
  'tbl[i].name' NULL pointer to print the last constant entry's name.

Fortunately, the function has no caller currently.
Fix these issues mentioned above.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/fs_parser.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 	}
 
 	for (i = 0; i < tbl_size; i++) {
+		if (!tbl[i].name && (i + 1 == tbl_size))
+			break;
+
 		if (!tbl[i].name) {
 			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
 			good = false;
@@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 				good = false;
 			}
 			if (c > 0) {
-				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
+				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
 				       i, tbl[i-1].name, tbl[i].name);
 				good = false;
 			}
 		}
 
-		if (tbl[i].value != special &&
+		if (tbl[i].name && tbl[i].value != special &&
 		    (tbl[i].value < low || tbl[i].value > high)) {
 			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
 			       i, tbl[i].name, tbl[i].value, low, high);

-- 
2.34.1


