Return-Path: <linux-fsdevel+bounces-46293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCB3A861ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B15F3B3B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3D2144CF;
	Fri, 11 Apr 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N1fEhiPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7F21324D
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385533; cv=none; b=ACitl3B4zZ1yFgWlVlvDKIebcRZy5O4DGsjIDi1udRT/5oL8tQYzoKNnV49IAM24TeHxk++DGmOzIlgkROGjtgltskEIXANiofUSYnmcdD2MLkgyc4Ca7JfHYvcbMh8eZ5BHmHcMSJoPrHgY62EnrTsvnWSm0WoN/+vHpAQDY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385533; c=relaxed/simple;
	bh=L+NjD98jeIgGvG3e7T7D5XKYSaKioqNqTBGxSFJKsjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwmSEEmm3X86BXc72jwytCvyhTN0GOjp91FuMUqlt7CkbXgkwSu/HrNf/vEz4tgStiqJfVaJ/bziICG+cNger5d9CkGAQlMqbQHTW1pMe9+ohBhJpw9MYlVo7w3zE5GYoMmADyYol8i8ymdfGs5iJxI1tru+PwNm1FLK5qfIyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N1fEhiPY; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=WTZ2rWFZFpUMuhTf3kMad1h/efoH+xBRhnVrWJyrBes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=N1fEhiPYfDqXcB1CvOj/tm2yqGulIbq8RP9HoC7IWPJbY/zJ+hny2bALLdWQsB7/h
	 S3f9FhauPl3VwOQ411AaQUdMhzs49I5xrcZEWuu0Ix6OPGkaVTwDL8LPqWDRZHgCl6
	 AUtAuNlQTgQ+TvOiBj0oiy+ENB2pRZmq/YIrveGSnd+MiYPFyn0gUwxIExeqLsAbI/
	 FPyiASli1KtFJlpRs3JKDo5SmXBmK+/LgxdMw++TgHFayUj7WrmjlRpJc3tyq0PjI+
	 i0yvycY2kV+/jD5UiVrJ2mySuQGpopym3ptkoeUK65IonfrH4uigxecDXiflzcXvKY
	 MNQmfcfUW9uFQ==
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPS id 9B64D1E00EB;
	Fri, 11 Apr 2025 15:32:09 +0000 (UTC)
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id A07721E034B;
	Fri, 11 Apr 2025 15:32:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 11 Apr 2025 23:31:40 +0800
Subject: [PATCH v2 1/2] fs/fs_parse: Delete macro fsparam_u32hex()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-fix_fs-v2-1-5d3395c102e4@quicinc.com>
References: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
In-Reply-To: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: aBGD5axrkUVoFiTjoyPmIrztKsTTw9GB
X-Proofpoint-ORIG-GUID: aBGD5axrkUVoFiTjoyPmIrztKsTTw9GB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504110099
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Delete macro fsparam_u32hex() since:

- it has no caller.

- it uses as type @fs_param_is_u32_hex which is never defined, so will
  cause compile error when caller uses it.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 Documentation/filesystems/mount_api.rst | 1 -
 include/linux/fs_parser.h               | 2 --
 2 files changed, 3 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index d92c276f1575af11370dcd4a5d5d0ac97c4d7f4c..47dafbb7427e6a829989a815e4d034e48fdbe7a2 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -671,7 +671,6 @@ The members are as follows:
 	fsparam_bool()		fs_param_is_bool
 	fsparam_u32()		fs_param_is_u32
 	fsparam_u32oct()	fs_param_is_u32_octal
-	fsparam_u32hex()	fs_param_is_u32_hex
 	fsparam_s32()		fs_param_is_s32
 	fsparam_u64()		fs_param_is_u64
 	fsparam_enum()		fs_param_is_enum
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 53e566efd5fd133d19e313e494b975612a227b77..5057faf4f09182fa6e7ddd03fb17b066efd7e58b 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -125,8 +125,6 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
-#define fsparam_u32hex(NAME, OPT) \
-			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)

-- 
2.34.1


