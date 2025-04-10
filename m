Return-Path: <linux-fsdevel+bounces-46194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A490A841FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7F43A547F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA89283CBF;
	Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uulJVwZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51694283C98
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285564; cv=none; b=hVZo33VRQiIecn5JHT2g0RASClsLlpiGTOJ+M7Y31Yfvqq5QkVoW36ZC6cTr38gWd7kgFJgZv8M7kAjKJt3VJ1I1xEFb4OXQG3S0fQ4+A55Ul7VDxw91F2CU8eAU+oLsLKD1sxLLqV8Nr7JGszQSzJ9OiyZ7lcZrnxdVi0B5YXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285564; c=relaxed/simple;
	bh=f9qpikZGNzYBNk8FJCaVHkFKoG83Vw5bqouTnUPhpKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2TO53aSmBJGGKwixRD4QaHo6icPFix39cml49CyfA0F2qdw0+OFGE+G/r6Lio5M/Nx3LLChGuqjyuj9aabFnm8FvpOq7eLCz8Jkw1iLQ7efEgnzANGeeo2Ps5pWNIvkL+BOX4/9ZGFzg/+X0X5xoff0CihQKWoK2pi+8cpEYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uulJVwZC; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=pepr9oDPPVIjbW97KHWR9Cogp5XUAGS7567ILCBA7M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=uulJVwZCqpgffvADKvG2GT8cOe1rIicAcETQQi/YJinv0zP9vzTo7Wo1swc7i3tmR
	 fzRUCIDx25wW2HbvbG6o/Z9o21br5NTZVXiY1upXsTBKklb7nAMWepqimYLC0MSXUs
	 2oDuvqqHO51pkHw+YLB3cGIsaViAEMa4D8tCN9DOfiguBI2lPhFQCMfWyjiUBoZ4Ww
	 W7LvRJhaVUMHvHDvY0G6Mesi2LxuRSp4eATgL3wVlm4namiOsIeYw2XqIsMpL0Q8f6
	 2Ju7XchIR1+UBXcb5s8069EcDQaAjbw/EvTVpHrNGmh0r/0Rgis32i7rCuixWEC51n
	 kHV31ZLakoD1A==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id 3C21430585BC;
	Thu, 10 Apr 2025 11:46:01 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id DF33B30585B7;
	Thu, 10 Apr 2025 11:45:58 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:45:27 +0800
Subject: [PATCH 1/5] fs/filesystems: Fix potential unsigned integer
 underflow in fs_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
In-Reply-To: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: iZdleNWSw2lUlcGpHJetWjeVvzO4iEac
X-Proofpoint-ORIG-GUID: iZdleNWSw2lUlcGpHJetWjeVvzO4iEac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

fs_name() has @index as unsigned int, so there is underflow risk for
operation '@index--'.

Fix by breaking the for loop when '@index == 0' which is also more proper
than '@index <= 0' for unsigned integer comparison.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/filesystems.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391ce814e580709b518b405e0f9cb8a..95e5256821a53494d88f496193305a2e50e04444 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -156,15 +156,19 @@ static int fs_index(const char __user * __name)
 static int fs_name(unsigned int index, char __user * buf)
 {
 	struct file_system_type * tmp;
-	int len, res;
+	int len, res = -EINVAL;
 
 	read_lock(&file_systems_lock);
-	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
-		if (index <= 0 && try_module_get(tmp->owner))
+	for (tmp = file_systems; tmp; tmp = tmp->next, index--) {
+		if (index == 0) {
+			if (try_module_get(tmp->owner))
+				res = 0;
 			break;
+		}
+	}
 	read_unlock(&file_systems_lock);
-	if (!tmp)
-		return -EINVAL;
+	if (res)
+		return res;
 
 	/* OK, we got the reference, so we can safely block */
 	len = strlen(tmp->name) + 1;

-- 
2.34.1


