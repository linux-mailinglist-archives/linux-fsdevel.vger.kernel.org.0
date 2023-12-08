Return-Path: <linux-fsdevel+bounces-5334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2680A948
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196911C2093C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B738DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fXDyaE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370010EB
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:33 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-54db2c98694so1192438a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050692; x=1702655492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kWpQGARUuYr0YqUEA1D+Re6NElKsOYqdPIeXFsPG38=;
        b=2fXDyaE7ozq3tM27EOya8UmO4n5z+W3gnPNO764Aip06t5Y4eB6iPe9MHdz5pJkSxz
         Q7HTf/4Y3Ayr+8I3ROWP9S/VhK3BEGtJPHmk7nlsFGU/1/XHlI3QefKBzx4/23NKQe70
         KLMvDsv7eC2NgCx5qEmimOQ7QGLxifWCYmojdqc+wIYLCzJ+sJqt07C1ImNDUmt9E2MA
         laJLwGiTFUyBBsyxA/Y1s/Q/eEXzvLax1hjDXadNSkbSa3mGyUgJZw+BZmQcSNjPnYj6
         vekPBsh16G+p6HedonzObcMx7uBrahm/tUcp6DHB8OfT99107nSuo3uc/X321XmuRKpY
         ArBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050692; x=1702655492;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kWpQGARUuYr0YqUEA1D+Re6NElKsOYqdPIeXFsPG38=;
        b=qMx/HAvcjPiicfhEsUCwhChs/tgULJDjx9ICkLLR8X8qA49hzaEXWIJMkuKSFoW90A
         Vra+1i8H6qjOtQSMMLOu0aE2Bl6GMneAb2oXskD2XfyNCwBFkcEjeamI5aCgjMv6EHpL
         MmEpCLwOOgaoJwBzJDjTpE8xJECoiRARG7JN6ftigss7cufvfYKx0E6iGmKfI9L1Med3
         Vm2yPjJ60C+kVj1aRe2iXI7dswtAyk6St/EwvcJqpf6pjIElg/DfrKAJKKGNIWwszqDZ
         3S8rxdv71T1v9gJaUnXRlCo8TLgIOBAlD5TuMOCtYYkw0i99nGA1jXl5Kex/D9noum9S
         JTsg==
X-Gm-Message-State: AOJu0YwMYwTtrRRVi9caQ7QhhyCdeQ4fvW81kP8CYk7atM0KQLRJOYZz
	RF4jjNOvUWAuLqTcdSqadAUmEaOnBN8=
X-Google-Smtp-Source: AGHT+IEmKWtB5JCKmUgMb8Dj9DXsjPZORR5fK4vDweMRskchlYpAqg79BFHUKJBKX3h8yttseayvSepE4ZM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a50:9eca:0:b0:54f:4811:2a9c with SMTP id
 a68-20020a509eca000000b0054f48112a9cmr2234edf.6.1702050691941; Fri, 08 Dec
 2023 07:51:31 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:14 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 2/9] selftests/landlock: Rename "permitted" to "allowed" in
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
2.43.0.472.g3155946c3a-goog


