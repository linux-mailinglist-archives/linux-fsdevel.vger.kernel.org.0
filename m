Return-Path: <linux-fsdevel+bounces-50522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E046BACCFAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE7918970E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9A25394A;
	Tue,  3 Jun 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ILYYPhNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26A25291D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988934; cv=none; b=J/6V7/WBzHQAIXfVVgjrEn6TCzG3EGPDh+PlAfLlrxPqG1fkittXOGItWP8d/jA48cN0zqQwGvzWutkEdVsQUnbOJPdczlle4PVNjx6mkABhn4vAnpyCcmAh3/RB+xcpVi5pupJTsAD/Fcm5MiTr1KmuM7sWTE1vZiLIfZrlvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988934; c=relaxed/simple;
	bh=g27oyTD6/jrBAqdANGNVmDLwLJKx2ZUNNdLuTW4r2Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7vA4FYdwRQvCW4FfNS4YCHYGxvcwk9KmvZ4StolO1b0/4nKc7duS3mtdBmRVkN3qz6yKO3cZWOvPp4IRVPaP7zQD8hDAQoVkG1mUSlSXrqBjbu6rXUjYZ8czsBiKyExqElJiKCBiL4PEz3Y2b6UcVOyMibm/m3+ChAvH8GBaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ILYYPhNM; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553LAoE5028355
	for <linux-fsdevel@vger.kernel.org>; Tue, 3 Jun 2025 18:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=Lfp69DiYOeQKA1pcsNzgw4KPGHdSjVYUj1VSH3quNCM=;
 b=ILYYPhNMp9nd+ku4UA3Gik0QL3CXW5MM7ZS4qPGtIsMBAg2oyfYY6TvaseOOpfP6IYaq
 GLR1AtGDrP48EQ8LMzaKlvhxk/j+wFbAHWfiEE9NObS0vQCtD6qnRjKKd39ldsSVGDCa
 OxbGy1xKxClLMZSScE4BEgPgpRP22G+TYGc2dvAvZqF+XwxyX/tqQbteda/zrAOr66Lg
 QOMU+4UAHKI4Kpo8t1lQvp6aWBWw37iIbWZUsZvBMdk3/cGHNGhToPTkQHAwGsuFwANm
 2tBDOzS81w2hIlsUIZyEiAp7+33qEZGk0N6ubGbkzcSpVx/4GAPMTnM8X1dUY1Vt4buQ iA== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 46ywy0gy21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 18:15:31 -0400
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a42d650185so73634331cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 15:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988906; x=1749593706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lfp69DiYOeQKA1pcsNzgw4KPGHdSjVYUj1VSH3quNCM=;
        b=PtbgAH/JdwQ9zmtSZODnHWor7G/xUN+O0GS2g260ETvkSt1NHgupOpFjTrgCWwR7vr
         moi+TvYZRJjUtVUkbryyaiUml1SlqBd8RtRY3RrhtwMByAwAZ3T72jwHsQXQ/AO5VDpj
         G5y0ZRybOzCTZChxn6rl0qj+zazM6MwBhp6Fsm02kFQLxtm2CQ9zKiG1cNGULuwcBJp0
         SUUcUW+uLJOxbOSHB0FMmguHzP8Qv/hkqcejgGim8jPGD7qn8+X6OfJMolazKSapOoSC
         uzf6l463WZ/dEpIna/luY5UZLEHpt51YfN3gdbGi2Y5VfXiMC379UV2IcSNxxK4YNrud
         1Rww==
X-Forwarded-Encrypted: i=1; AJvYcCXCudpsjoYGS5TC2tjt/JNIVX66dzogb9ThtKC080oW004gvlEOHcljloTnCPQChoZVwG4rzpI0W3xH0M69@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwM1YXZt4VTuevJ/8cC9d24LXm8i/XaDEFse41LPXRAXZ+5yv
	aam0092GhNIxiB6a3Nw20WRhh728AI1EsrTk4lLDaHfwRuZ1L9uicgaROkQCUfcZans4y63r0KL
	u3/mQUtpy+6HVMPJX3B34QOz0MorLRvd4TfDZElqI7ws9FBSUmVB6sBB9OI1d2OA=
X-Gm-Gg: ASbGnct7o5WqWs73rDUaC5OJNET6RgMKy6DN98pZmjmJXr0iqNjtDEZQBfJeDeXWeU0
	9W+A5pABBlBzBjtWX9SflvSQGJCj96pt1rxTunZYwgVGCEU0dLgvGFKOdlaqkKZ0q4dDaTRyOT9
	7bC1zu70MovUruo4pE2nuH2o59VENePp5+D+BesvFextqhWItXV7O3DYCNhjuHAiIPkFC4I0K2j
	EvXHI3hN/CBYDJ3F6YhaVT/JQB7yJrGTJ5iW1uIFw+AaISb4BAOzKW1wZSil7EITZVJnVfPfnKr
	7M2q/OHipm79mkQlOhbwdabF7bsBID/GOBD3rpfmWCwZNiimHR23mEBviTFCgRnN1B/H
X-Received: by 2002:a05:622a:4819:b0:494:b914:d140 with SMTP id d75a77b69052e-4a5a57f0ef2mr8844761cf.43.1748988906193;
        Tue, 03 Jun 2025 15:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3r+PJxJ7QkVzaMR5o9MP2GSalSCVTrXWtLu6GU0AT2AKuvSzgDe0WZeGkRGDRbidaKgnbkQ==
X-Received: by 2002:a05:622a:4819:b0:494:b914:d140 with SMTP id d75a77b69052e-4a5a57f0ef2mr8844291cf.43.1748988905724;
        Tue, 03 Jun 2025 15:15:05 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-95.net.columbia.edu. [128.59.176.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a5919064dbsm33085741cf.53.2025.06.03.15.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:15:05 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Jun 2025 18:14:22 -0400
Subject: [PATCH 3/3] userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and
 UFFD_FLAGS_SET
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-uffd-fixes-v1-3-9c638c73f047@columbia.edu>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
In-Reply-To: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Pavel Emelyanov <xemul@parallels.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748988902; l=1458;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=g27oyTD6/jrBAqdANGNVmDLwLJKx2ZUNNdLuTW4r2Xc=;
 b=/XIMrYtbF5Y68qcMiwHj35HHywny0Un8ee+I0CUXo50KzxtW2KYaTD4j2taaBviXzq47kEjjp
 v0QqS3mP22GAE07Teo5dLuKCi931LxkSWAeIzPAUiVFzfkda3ZYvYQR
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5MyBTYWx0ZWRfX+m7uRdvGrRtR fqsJnxAuBy9x5Bp43Ia7EOd1r2PbYl9f0V37zYXMrtOLMO/MCJtUKljDzh3U6prHvgXLNgfpXiK eVNgndV3FTCxoXIKGu15PfGAOHv2EaVk/CVjTNT2lX3ykZ8FLaFx6JgUxCNn81yKrCWISvfmlpX
 gc8sAPilfZ/DaFzcNVmYxrnaxh6Ub/NPbx0rIq/JKtu5j5N/+x7HLAUriTUsDyiNExupHMiT0sH GBssCj31ftoY26kLYbIQs557ZAtMibBdUMt4B3uu7Qxg3Y6S6tOkG2ujzspQMqFMU7UH2ku2Ev3 sjxw2MTyL3OMDfL+Ji4suLnl1ziTlQTs/9r7Elt3C9HIjWMlNyuYq/qBShSYxkoVF5Vca9IXYkO Uza1zIVO
X-Proofpoint-GUID: PoGeek6QmYzim70xFtMhSaWx5L6JQzt7
X-Proofpoint-ORIG-GUID: PoGeek6QmYzim70xFtMhSaWx5L6JQzt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=10 suspectscore=0 mlxlogscore=468 clxscore=1015 spamscore=0
 mlxscore=0 lowpriorityscore=10 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030193

UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET have been unused since they
were added in commit 932b18e0aec6 ("userfaultfd: linux/userfaultfd_k.h").
Remove them and the associated BUILD_BUG_ON() checks.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c              | 2 --
 include/linux/userfaultfd_k.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9289e30b24c4..00c6662ed9a5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2121,8 +2121,6 @@ static int new_userfaultfd(int flags)
 
 	/* Check the UFFD_* constants for consistency.  */
 	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
-	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
-	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
 	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
 		return -EINVAL;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index f3b3d2c9dd5e..ccad58602846 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -30,11 +30,7 @@
  * from userfaultfd, in order to leave a free define-space for
  * shared O_* flags.
  */
-#define UFFD_CLOEXEC O_CLOEXEC
-#define UFFD_NONBLOCK O_NONBLOCK
-
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
 /*
  * Start with fault_pending_wqh and fault_wqh so they're more likely

-- 
2.39.5


