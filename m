Return-Path: <linux-fsdevel+bounces-48928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DCAB60A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 04:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE364A2DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF11DEFFE;
	Wed, 14 May 2025 02:02:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2317736;
	Wed, 14 May 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188149; cv=none; b=YcQoHtBv8dG+2hrcT3Ep7P/v83RT59NSoRPhy+JkG0ly8eIhnjwNB9Qyzbw7fRb9bTHkPg8ux8brmyprtOplobPm23PguFCNGGeeQE8NU8fzdC/gs0OR2XfLRTbY75MyX1rwvg6EFN7SFAQTvlpgxXo2A6qjAiWpzzPpYyAG4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188149; c=relaxed/simple;
	bh=9gZ+V/mzuQKZTq/D1Z4x1IxGr2aBpJFoWrl3VOdws7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQ2TB01wiXecrWWzuDkApMTf1vTFDlkSeBAIDdW3EaMMqdauHQE/6LzPjeB1kwssmxFkJy4sZ7vnHK3mm1wLI/EIAvRW7CrClwo47KDcEGHn2Zm3UkXjWudnbLWFIfb28WREtn8XkSN9TiSMm3yzpbSQTaYT++pmg8fjDlsS7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5ba363f1aso1004574385a.0;
        Tue, 13 May 2025 19:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747188147; x=1747792947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Q9xaOIn3zBynpsjqY4jBiZO//jx0sk7GdoLvm9O8dQ=;
        b=X0kmNDujZE+F8P+7+l6B1y0aqa17KFoFMpX0fuhLHDK0Hm2w3Sy8uPZlZjpOjT+RY4
         jKhzNXBx5XCA4EmP7lmcta8BraLX6jS2Sz/wvwvTOqyNPE9WO4jEZujsWaMyLyoE6XN4
         1lPFttLO+MSRbUJYbXEbUaf16wilmtzFoGBn5TcnPZSmVTSyUdoboqCw8DGbOSI3EhMc
         oS5Ff7Uygez9Ze06NPAZFPsfGBOiP3+x80HJzKQ7Kod4F0zOr1Avjipo+bAN5fTEzviK
         0SLy+xCu2PWRj4I9XVMfew2bnmp/cdeJHqZOXC6FsXUlSkaR2h5DK+pk6phHKyPRFe5h
         LQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUlBeWVuKMH1+WKhuWQ48snqBXakJJMZgm09U7NAF1oEGtAJQ13knzWqLojl17oOZlWbchDgJ3fYnKbROWXkMd7@vger.kernel.org, AJvYcCVjApsEU7WkUyMoVMYSO/Vw78REUtk1Cpc3KI645RXOHfxO5UA7DXBJkrkCXhkb5YpmmQIzpkcKp9Nk6HdU@vger.kernel.org, AJvYcCWkSOZOzVGOAS2jXHNyjWk6eHx9KlLFb/m9yndZnfof2PRVsbwa40eLN/djJYJt/asa3PF2k1rH5tr15xli@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAUjXmEEcjEnGJ5b4KTGesPVe1g7AGQe52wgjeCzAFa2xLBnr
	GYs9Kt5Nez0GEVQZ1Q6Vkp+2TgUUV1Kp8cKe0aHGenOOVNIUyZAc4/J4BysLpmo=
X-Gm-Gg: ASbGncufjCiHfQ2eYCvp9UMOTZRMaIK3Rq0EHyXYxWTYFNPx5SpTCew1NHR3/hcjWMF
	QAxu883b1CPBZgcnumoyyxAkPYYQp7MkLf6rIjWPKIrr1mjAHouPX/I3DZnjMkMCtVtHUUctvmg
	qn3CpA+l+aPGbNuSV7VqErOfjF7GZXqflrWc69pZaRg/5XHDDYCkM9jzH3kaJH6qgUa/ErOUHEP
	Jv5CeHySiuODVlwLVXThL6nUGBoBNxm7TXs1PqgDuTQl7EyRRyJReoGBiePmQFoCoBis+q1mFkF
	297IOjW3WxVhXL7CQ1s90nvZvivJl3s7euj1kBZ1A3/bG0iXIkEI1eye8JFDx5//SfDnXwR342u
	XQGW+CkMLUDM=
X-Google-Smtp-Source: AGHT+IFETPzTQLmaXKcK8Kq/hNxJjRgRYtgHuQwMQbuYn6Fys4VHp0rQxmasyeEorxDcwD0jthBUGA==
X-Received: by 2002:a05:620a:1928:b0:7c5:3d60:7f91 with SMTP id af79cd13be357-7cd28817cacmr239763685a.15.1747188146611;
        Tue, 13 May 2025 19:02:26 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f9b24esm778229085a.62.2025.05.13.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 19:02:26 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: remove duplicated function definition
Date: Wed, 14 May 2025 10:02:02 +0800
Message-ID: <20250514020203.198681-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I failed to build this test on Ubuntu 24.04. Compiler complains that
function sys_open_tree has already been defined in
"../filesystems/overlayfs/wrappers.h".

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 48a000cabc971..eaa4e912120ab 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -173,11 +173,6 @@ static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flag
 #define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
 #endif
 
-static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
-{
-	return syscall(__NR_open_tree, dfd, filename, flags);
-}
-
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
 	ssize_t ret;
-- 
2.43.0


