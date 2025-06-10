Return-Path: <linux-fsdevel+bounces-51089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAAFAD2BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B6B189016F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E523F291;
	Tue, 10 Jun 2025 02:11:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A7221DAD;
	Tue, 10 Jun 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521513; cv=none; b=gzhuynrBvQti8/m1mEDFwAMzA44Jg54wtBtRxcNjGaYpb3DDCEiadNi3SQB+58Ciy+DbCHuYRiVqtWKi08ej9wVo4JwBFXrKNghbXfHFz5vzf2Vjc23x7oK52eJAmn3qJXigEJZkehqpoyalu8wAyqUISUgHeEgHHuUHyJf3gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521513; c=relaxed/simple;
	bh=CWHORAXG2oiiaHYAWxfkNRLv9y4YW0URPt7RpnYjehg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0gy4mPTI45vL/ZDcYfjkpEoYGH3RxzFEogqLFbqa2F85WMWaIilX4L6wa4oF+B5+HMetoiR9i0VFSpLtglAqFIBJ14cS2QXPj+RwsQo4xpg3AeYFN4rVRJC+3CBCSUxcowB/fBQbDw5W8xHXOhgS7/hAN7lx9llEbuKewpOjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so33032681cf.0;
        Mon, 09 Jun 2025 19:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521510; x=1750126310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ckf4J7K6nhKzDsTt0cIUCHXIZuk9xFjMGBfmOU3gBK0=;
        b=ljO68A1RGktZwWvCLWQ/WRyPhzvg5TgO5M1NK6amgY/Q6XOGh8gZ3fa3+1y06HC358
         UsvxhctzBRpgpRrPaQyBSKIoJ9ppqO05RSrZsn0TWnp5h9VJsLWKRC2XsL1eBIIouF5U
         RJzF5WZALO70iSh80D5W21ifZQI6VrYKPCj2B8RDPZYiU9F3QRn0aO6ZsA8cMSs861JV
         +Q4wdnFEAS7wmcKiuiIm5QzKU1h2jRRA9cdVtgDN3qj/SzmYMIOueEAYZPqV5Ji9mdB7
         5o5EmSHTTcnv9E+4lkf9cpeZI2pry6G3oU4YQhglMRdstl/Bh8p9EAXPxZhHIrr/m7Yr
         00VA==
X-Forwarded-Encrypted: i=1; AJvYcCVaTBTBVipOnsH1Z8bdmcHPPcz59Kfw/SEHVox0mCETx4q4fk/cQcfORGw1mHr3+RP6FqEIIfOlFjcsElibhg==@vger.kernel.org, AJvYcCVhua6D6R7OncQmNAtZ9kQaPtFdXJ4IrYDgtFdZJXO0OV9pg/+FlOl58p1Ql3HshMAaUcQX5uT3vYw=@vger.kernel.org, AJvYcCXBdTDs7kUfTxNgbITdNbwxRUutfZMYpj/4uyUEH2fYczLoCpnIRFzsYHzpYbaNXXEz70shJUR9A0N7ZCeI@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDe6hI/OnROH7zfta2k3v0u6SiYPUs7lr/jkUgzjvgd2ToIc2
	JGPS7/vn8ys9KlpXmdS7P18zmA/QjWQ8EJGO2IQqMkHt52xlM/1p+NTv
X-Gm-Gg: ASbGncu7d4+2T18g7LtMcwKCBvPkVAlNQE1whjGAK59Xo9TJNoFJNBSjSkc/UMSlmLE
	2f0om9kbsL3MmAMPSgE4ZoXbH4zHUHOpq4yySTtzaRQYO0+/jyrrBCNfxDlCgFQ2zrWRhE6bLNf
	ZYG/TS8dxA/+NVKoKwZvRllz3C9HOH4xJfzf61LPUeoOSE/39UI1kMIqKmv9IfTBojhukoqrW5C
	CWiqFOy3F73k2aAfn/iQmnpFuh1y3PrPNj8TJFzUrwrXgx50MJzyMnC9hMTnvu3sGn3cg2uNdPC
	KORa0fvc37c0DfTxr9LaOakR01m43cl/ur3u8+ModIiZEueUBZrGS9XftihESnAf8oEbOuec5hs
	swjbJTgesis/8V9rgirwIGg==
X-Google-Smtp-Source: AGHT+IGNnDHYclUyHAoKMYivG6olKNNmJJk2Yuc9+l6b5bPprUMJMh5GFyd7t+oNAOyvMHBrev76OA==
X-Received: by 2002:a05:622a:4a8e:b0:48e:9b77:38a4 with SMTP id d75a77b69052e-4a5b9d324c6mr254645271cf.26.1749521510558;
        Mon, 09 Jun 2025 19:11:50 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61a924sm625707785a.91.2025.06.09.19.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:11:50 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jonathan Corbet <corbet@lwn.net>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] doc: fuse: Add max_background and congestion_threshold
Date: Tue, 10 Jun 2025 10:11:25 +0800
Message-ID: <20250610021124.2800951-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I preparing patches adding selftests for fusectl,
I notice that documentation of max_background and congestion_threshold
is missing.

This patch add some descriptions about these two files.

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/filesystems/fuse.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index 1e31e87aee68c..c589316c8bb35 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -129,6 +129,20 @@ For each connection the following files exist within this directory:
 	  connection.  This means that all waiting requests will be aborted an
 	  error returned for all aborted and new requests.
 
+        max_background
+          The maximum number of background requests that can be outstanding
+          at a time. When the number of background requests reaches this limit,
+          further requests will be blocked until some are completed, potentially
+          causing I/O operations to stall.
+
+        congestion_threshold
+          The threshold of background requests at which the kernel considers
+          the filesystem to be congested. When the number of background requests
+          exceeds this value, the kernel will skip asynchronous readahead
+          operations, reducing read-ahead optimizations but preserving essential
+          I/O, as well as suspending non-synchronous writeback operations
+          (WB_SYNC_NONE), delaying page cache flushing to the filesystem.
+
 Only the owner of the mount may read or write these files.
 
 Interrupting filesystem operations
-- 
2.43.0


