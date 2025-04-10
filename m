Return-Path: <linux-fsdevel+bounces-46193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69310A841FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5929E179146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5C2836B4;
	Thu, 10 Apr 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LU5losaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AD1372
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285562; cv=none; b=b9rfZUeOyjGr350rnbjW08XixGMNw920oP0zBdy0iU91P3w0btDpM8PcjWuQQe/qN6IWvzOcSRGh4UyhCAI6OBcJ8K7LPkeyqBM3ym2S7UHMd6y5jnC1dchIMzjt5kMUHd09bQcaU1ga4csSipafRLjtmt7ZzB0XYXVLqaMOgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285562; c=relaxed/simple;
	bh=GVSI3yLAe8iBgIhr2BFx/RHKmLPHfabtA6T/8urNtO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VtL+Mlni4cMjD8h8NbO7Lo4DTH+O0Heo8r2GHbz1BYMuDSMRe3/5GGpaJJ+xNEZLGxgwje4430cMQY12O46KvtJe+LnYruFByFHX9O79vgC8ElrzX3WTEoV8D7UcJ0/hWchQyrHTbBfGqRdXXFDPlLWy1QrTXIJuZmmlbtZYTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LU5losaj; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=2c2V8G2G668O+kzkW6zgkPmbyaYXpuuS4fz+rUNbAYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=LU5losajtf/qCEkdCytSUv0gaUHT2FnlSlYRjgj+TmZVGu9PWMkwvSIMdMJ3arJF2
	 tuXPWVmDJcDNpjP8toRkM8qPVx4BJHdT+e8GaAoACh/T8xgN3Tpwk8DJBJz3wCpD9o
	 LBoCTbRXYIAopr1W2u0MOQv5m767Xczxg+Pf2VTbruHz6IQyaZORIzzgsSDk4MnWwq
	 7jgWe8W5tjzhrO/5I+G1LuvEZkfBXrnB5pQzXSEtoO+jYc5lIOOkamPeDA3bNR7XaV
	 SppqfM1frosi8JwxS7ikS+xxdugv4gJe8wi1Liaculzsjjy2Q9Leg/2N+L/7xMaGqS
	 7B8rXTkBjv6Tg==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id 2A1C730585AA;
	Thu, 10 Apr 2025 11:45:58 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id B2D4C30585B9;
	Thu, 10 Apr 2025 11:45:56 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/5] fs: bug fixes
Date: Thu, 10 Apr 2025 19:45:26 +0800
Message-Id: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFav92cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3bTMivi0Yl2zVINES/Nkk1RTyzQloOKColSgDNig6NjaWgCJ9PK
 DWAAAAA==
X-Change-ID: 20250410-fix_fs-6e0a97c4e59f
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 0Ww1hwHIy3X58pVxguCVzk_hK9c8j9t8
X-Proofpoint-GUID: 0Ww1hwHIy3X58pVxguCVzk_hK9c8j9t8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=957
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (5):
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      fs/fs_parse: Fix macro fsparam_u32hex() definition
      fs/fs_parse: Fix 3 issues for validate_constant_table()
      fs/fs_parse: Correct comments of fs_validate_description()
      fs/fs_context: Mark an unlikely if condition with unlikely() in vfs_parse_monolithic_sep()

 fs/filesystems.c          | 14 +++++++++-----
 fs/fs_context.c           |  2 +-
 fs/fs_parser.c            | 13 ++++++++-----
 include/linux/fs_parser.h |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-fix_fs-6e0a97c4e59f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


