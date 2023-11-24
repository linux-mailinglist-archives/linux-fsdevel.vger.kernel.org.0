Return-Path: <linux-fsdevel+bounces-3754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD267F7A62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2F6B21100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2483381CC;
	Fri, 24 Nov 2023 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Es9cdRn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B41701
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:37 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-a047cdc0294so153075066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847036; x=1701451836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHuLL/RrZm9MFgLTJrL/JWVFan8E6pN9n/zvC9iRwos=;
        b=Es9cdRn2sPYEhxUNfzFCyVyuPmzuh8IGLWCBaxOMeqoJLZr068L/C4TrMfoyURQt07
         ExbdYm5DoBIAiE+ufgv1mb49v6lwL0+oNtTk4tJn9NurdGE+2yKRrENObosdoWVg/DHZ
         DNtccLB7FGZ1YWtt9LEZwxquWRlpWCxqH2RxohDYyReeBEIUCmdVlY/kup2grcRc188G
         0G42sHe+RRBr2fMmL2cH5DkHOPpKT743OGC4BMQvl2WCcfejajfPHbiCvsUG0m6jvCPB
         PTWhO4eVu8cThI2BMuigUNMqeFUIOX2AOxNtJwmglSDfPd18YFGi/QZxTA6yj/UL4xMW
         DYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847036; x=1701451836;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHuLL/RrZm9MFgLTJrL/JWVFan8E6pN9n/zvC9iRwos=;
        b=hc+ZcQQuKQ44wddUSiKDqL9NMrGZtwlZiA3Yxs5FQCdlozoiUQQ/e+JFlVPgdfMFSS
         aoD0lgtBA4bZ5yEhgN7dcCqzCpEU5UiadkW4Z0F/kXOTFcNs9EEvHH5KCfBSAoK4/7Cy
         BnS4KLXwiX4imLq5TCQzxNhAEfVLiz/opmGQGlVKIRaWXXLQNEU5BwH9vjT9IroXPyUh
         3f+bmTlou4DX9XLBJWv4R8jPCNOCzCJVbbNg4Fxdf3CcERVh/HgUuykJjhGSaXRF//1I
         dgVh90048aGeA6T/y+wwXf8PUf0LcR9w1lorhQ2rEzUkxHcofkHCrJYj0cSb+02SRxo4
         Q+5g==
X-Gm-Message-State: AOJu0YwN37ZV7c5lzMsPYgULPpMKseC1ep2xGBW3JcqJ1532on2rkCDc
	xpD/01M4tYFeXPffUOnCZvjp/y7fV98=
X-Google-Smtp-Source: AGHT+IGc9qOP8qXncKlYFF1SOvM4i8WMlDCp1BbsVq0O5n/FmiWyx4WcGVp8y8fbwUcs5B0RxD6Fee+IgF4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:906:3102:b0:9ae:4a0b:d7aa with SMTP id
 2-20020a170906310200b009ae4a0bd7aamr35202ejx.6.1700847035976; Fri, 24 Nov
 2023 09:30:35 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:19 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 2/9] selftests/landlock: Rename "permitted" to "allowed" in
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
index 18e1f86a6234..971a7bb404d6 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3627,7 +3627,7 @@ FIXTURE_TEARDOWN(ftruncate)
 FIXTURE_VARIANT(ftruncate)
 {
 	const __u64 handled;
-	const __u64 permitted;
+	const __u64 allowed;
 	const int expected_open_result;
 	const int expected_ftruncate_result;
 };
@@ -3636,7 +3636,7 @@ FIXTURE_VARIANT(ftruncate)
 FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3645,7 +3645,7 @@ FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3654,7 +3654,7 @@ FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D EACCES,
 };
@@ -3663,8 +3663,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE |
-		     LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3673,7 +3672,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D EACCES,
 };
=20
@@ -3683,7 +3682,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	const struct rule rules[] =3D {
 		{
 			.path =3D path,
-			.access =3D variant->permitted,
+			.access =3D variant->allowed,
 		},
 		{},
 	};
@@ -3724,7 +3723,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differen=
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
2.43.0.rc1.413.gea7ed67945-goog


