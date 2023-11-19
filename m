Return-Path: <linux-fsdevel+bounces-3132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAA7F0471
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 06:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30E2B20A73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 05:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A615523B;
	Sun, 19 Nov 2023 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLwfzujh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77E131;
	Sat, 18 Nov 2023 21:08:09 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77a453eb01cso219602985a.0;
        Sat, 18 Nov 2023 21:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700370488; x=1700975288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=kLwfzujhtcN7CZHqFridaiwh5DejVaby6ED50VH/LE7ZsGe6YH0IX+3kgeTzSbdJSx
         wwITf85mToOMCW8CyulE81L5GrrUSZss7MeQ7PCMbVQmKafxoiSOCfXbvtOp/iDLKxKm
         LCvycD9W5j7ss3mhtCvnAfvZwJUyZwh0carFmJZsLuGIteoZFW5aqeXlmMOrJKoA5XDr
         WNHMVX/Dg5aTe1JQtFCHzcMqiKNeUO4T/XAfJiz8mmxeNw4I4FV1X1HAmWqqSomr4L4z
         8TPdomQLx5am/jKtOjbRd6ln6iY4Slw2J2hMjXTKontS5YMi/UKvLick4/2kh62GClNg
         N2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700370488; x=1700975288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=R4Om6p1PBrhMaqK4rerTIVtxnD+0ZiVo5a+y7+Gb33i8cHATI++b7mWlwpWVfQXQoV
         aR+2/sxIGOJTRA9bvEUNeiX9weJW3SUh9u9ENgfiHElduLNZngcDZ2kv9kYdYuRXrHZr
         pelnZ0UqWvS+PLjCNkiCliQKX63btH+AVoyr5cKZfQS1WEp5kMsT5t9gwe/SRc6Ptn6r
         zeaDEIaVrnhQJvT8mJlnpnynycPOnuvaQ4LMiw+bwEVNH02+1ou9W5k4nxJxODO7Ob5I
         D0lZGWQJ+qmrcaZE4Bh5u8T5DzvruDRr5YDWQ+TzWq/tHQUJdE9MoTMX4F3AhWM49pgi
         3Hww==
X-Gm-Message-State: AOJu0Ywfc4pCFTuekUtOB7LGJgPVyz7W/V+RH50qAtqVTm8uhxkvXpH5
	Ts70Fd6pRYbzFx7PtmD5FYPIl90z6biseQ==
X-Google-Smtp-Source: AGHT+IGZt43Jfyy2ih3iBT+vcAlXdVHLGh+ZkU/C4gig3TcjiA4MYoWEgwa7E/vhCtGPI7Wue2o2Qw==
X-Received: by 2002:a37:e203:0:b0:773:be2d:7cd2 with SMTP id g3-20020a37e203000000b00773be2d7cd2mr4632174qki.45.1700370487842;
        Sat, 18 Nov 2023 21:08:07 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id pb8-20020a05620a838800b0076dae4753efsm1757059qkn.14.2023.11.18.21.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 21:08:07 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: linux-kselftest@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:proc-empty-vm: Remove unused debug write callIn the function test_proc_pid_statm
Date: Sat, 18 Nov 2023 23:08:01 -0600
Message-Id: <20231119050801.52177-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

In tools/testing/selftests/proc/proc-empty->because the return value of a write call was being ignored. This call was partof a conditional debugging block (if (0) { ... }), which meant it would neveractually execute.

This patch removes the unused debug write call. This cleanup resolves the compi>warning about ignoring the result of write declared with the warn_unused_resultattribute.

Removing this code also improves the clarity and maintainability ofthe function, as it eliminates a non-functional block of code.

This is original warning: proc-empty-vm.c: In function ‘test_proc_pid_statm’:proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’ declared with>385 |                 write(1, buf, rv);|

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca..74ef8627f 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -382,7 +382,10 @@ static int test_proc_pid_statm(pid_t pid)
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
 	if (0) {
-		write(1, buf, rv);
+		ssize_t written = write(1, buf, rv);
+		if (written == -1) {
+			perror("write failed /proc/${pid}");
+		}
 	}
 
 	const char *p = buf;
-- 
2.39.2


