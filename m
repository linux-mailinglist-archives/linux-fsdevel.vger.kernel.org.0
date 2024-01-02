Return-Path: <linux-fsdevel+bounces-7078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FF82198E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F13B1F2254E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AFD298;
	Tue,  2 Jan 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CgQBf/r4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A6DDA8;
	Tue,  2 Jan 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40290BDM008490;
	Tue, 2 Jan 2024 10:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=TKE+z7MPL99KH0FwSMGY0U4EYmicn6R6cs3c3zAd4uk=; b=Cg
	QBf/r4U7yqcSmpSVjrtBmzkchJ8M+63B72sBm5Y1IMkHjbB3xdjbAYoTiWfsiHMl
	COLe0hLdLN5/xw1SjU26kWLVjZQN5eFnBxaMsPaa3sToeJvXZISYz0qRJYs2Ghn1
	h1xS2bzRdPKmcw47VwMIsAVbfJHsm6H+oq8hwAPG61QLFTOTLs3bpE68ynme88bt
	IuOCYEEqU0PeyXX1tjzWaBBE1MaR5fjcEaTCU9l9/738ZiTcLHuHTI5OHSDlhZkm
	qECaYAsRomGqeJjoXZ7ZvaiTv0uZ2dMu00755LdELgPmz+9AuSHb5gowHebVTOFP
	I7HbBj5fFmfoehIMp07g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcets86f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 10:19:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402AJmfg017016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 10:19:48 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 02:19:46 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <mhiramat@kernel.org>
CC: <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH 1/1] fs/proc: remove redudant comments from /proc/bootconfig
Date: Tue, 2 Jan 2024 18:19:37 +0800
Message-ID: <1704190777-26430-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IaT6njKLW-3z3epJRkiol-xdoAyFzQ0r
X-Proofpoint-GUID: IaT6njKLW-3z3epJRkiol-xdoAyFzQ0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020078

commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
/proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.

/proc/bootconfig shows boot_command_line[] multiple times following
every xbc key value pair, that's duplicated and not necessary.
Remove redundant ones.

Output before and after the fix is like:
key1 = value1
*bootloader argument comments*
key2 = value2
*bootloader argument comments*
key3 = value3
*bootloader argument comments*
...

key1 = value1
key2 = value2
key3 = value3
*bootloader argument comments*
...

Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 fs/proc/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 902b326..e5635a6 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				break;
 			dst += ret;
 		}
-		if (ret >= 0 && boot_command_line[0]) {
-			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
-				       boot_command_line);
-			if (ret > 0)
-				dst += ret;
-		}
+	}
+	if (ret >= 0 && boot_command_line[0]) {
+		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
+			       boot_command_line);
+		if (ret > 0)
+			dst += ret;
 	}
 out:
 	kfree(key);
-- 
2.7.4


