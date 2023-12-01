Return-Path: <linux-fsdevel+bounces-4580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D263D800D53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B56B20C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBED3E470
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oVyBIUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992A10FD
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:30:55 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-a1a4bc50361so22019366b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441053; x=1702045853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig8lIHEbad4HUQf1qWZKpo59x8aQCHJymOa08eKBFx0=;
        b=1oVyBIUsouOcLSZL0KpiVzSvm24+sCx4rGl2eT/OEGp8ns7agR7MBWdgs0mcwuy/a6
         pPscaVQB/vU1w7cSYPfbTTYtemeyFlioFOYK2DgMWew0PXjYEvwf8/xYKX8l2ISwiH3V
         ZddkgypcANEfH6ZAGYieOEOv6do00ZGN7+5I57lD0n3oRYwJjQIay+FCGpbWn08qwXKL
         BAkHDzCgWOApe3lFhLW6cIqgWLU4APXNv8UDW5sbHNK/WTHtwAzuDcj6bnyd692EL8Xz
         Y/3HmjjFwnJ4oJ1rkEw66e2XwEFDCimXTW3YCYd82iHzY0qhws8OsSycHLjZ5JG7RrUh
         cPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441053; x=1702045853;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ig8lIHEbad4HUQf1qWZKpo59x8aQCHJymOa08eKBFx0=;
        b=f+zeGqMu2Y17gKvrGLJiV9fibUW6BJBXmgfbDdlvBSzN/s8byd4k10VNNB+LufzeQf
         aRkSxOV4SbtWbrwxbrcn38k3Imv8x8IsDT+/D2Wu8uP+LiUUSAAkL5tSP/SF0M/aww11
         8ncv4immtvvYJYQrGQneBIisqSJJbXjC7+JhYUrS2gIQ9veVmeLyOYbLBkQhr7haexTy
         y5L3bhYexLXYdxkYwNhT2KDENCfr/wWNuDThuA5KrGP7tHP1TtTUDLwDoNFxln/U3WrL
         zFXD0OWWN+uQkoOmxiycR1aRFxpEMbWKFpiZvAyA356mralHlX1nk68QTwc0Tvt/AAxH
         5F2A==
X-Gm-Message-State: AOJu0YxRCuOrx/nx20DocP8ymGQTON0sTEBJeOFZjXHmBdHIfdpKTtJ6
	LTtu1e3Sdw5KOTDxFKZc7hYyp5oZUPg=
X-Google-Smtp-Source: AGHT+IHfTcA/cPDDFNQfDjlpw7cTfYp/i+bSjjm6XSymoV1IkAVTFLqRIOscEJMnTIKp+5zW2ztp1v2adDA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a17:907:7891:b0:9b9:ff14:9ecb with SMTP id
 ku17-20020a170907789100b009b9ff149ecbmr7475ejc.4.1701441053451; Fri, 01 Dec
 2023 06:30:53 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:35 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 2/9] selftests/landlock: Rename "permitted" to "allowed" in
 ftruncate tests
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index a1d17ab527ae..50818904397c 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3688,7 +3688,7 @@ FIXTURE_TEARDOWN(ftruncate)
 FIXTURE_VARIANT(ftruncate)
 {
 	const __u64 handled;
-	const __u64 permitted;
+	const __u64 allowed;
 	const int expected_open_result;
 	const int expected_ftruncate_result;
 };
@@ -3697,7 +3697,7 @@ FIXTURE_VARIANT(ftruncate)
 FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3706,7 +3706,7 @@ FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3715,7 +3715,7 @@ FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D EACCES,
 };
@@ -3724,8 +3724,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE |
-		     LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3734,7 +3733,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D EACCES,
 };
=20
@@ -3744,7 +3743,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	const struct rule rules[] =3D {
 		{
 			.path =3D path,
-			.access =3D variant->permitted,
+			.access =3D variant->allowed,
 		},
 		{},
 	};
@@ -3785,7 +3784,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differen=
t_processes)
 		const struct rule rules[] =3D {
 			{
 				.path =3D path,
-				.access =3D variant->permitted,
+				.access =3D variant->allowed,
 			},
 			{},
 		};
--=20
2.43.0.rc2.451.g8631bc7472-goog


