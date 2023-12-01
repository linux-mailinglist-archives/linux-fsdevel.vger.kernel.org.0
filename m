Return-Path: <linux-fsdevel+bounces-4582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A464800D55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1463B20E43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A153E477
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHs+efl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8710F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:30:58 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-54c64c3a702so316619a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441056; x=1702045856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzXi78AHjIIVJFmJ8Pjwy9iFwVciKDRlY3Gz48xNASk=;
        b=qHs+efl+gKpPZseCZdbBm2cAFKE2mIQki/zon67m/NWJaySGYW1zrEe9FaVBMCa6rn
         MyroHYxzyOh9ycHJup/ktzuOjXeGqBzH24XAiirWGHcWeHOB0G42uIz8V3fx5IOfEk0y
         o0I8nglUecoWcj66tjZP24WN0iJC1eX1uFiBgmG+5VwI8JNQ4YV/qHCKpo/hTiDbc3Dj
         MwXuPUhG9DVi3qQqsVNaumJHx8YctSOGaGSWGVtJjK4WbPaqdheJAFLAxJtiChzL76jw
         k9154RRmBOCRHS2SESfRSjizl745+hkZbk68SVM2yYnc1DP26tk+IuMbxVQIuPD0hvfk
         SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441056; x=1702045856;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzXi78AHjIIVJFmJ8Pjwy9iFwVciKDRlY3Gz48xNASk=;
        b=QGCdJkmi+cj82RgQ7SLAdX9gpDA5U7J0EgM+7LStzVgOD9FvsLrg2ugpUTG9gwc7m5
         C7EDLJNVJbKgVoauJcFnzqaaeme0m5jNujwxKbVaf0QI/mGQauPoe6PiVnK0tueGl1TY
         Y0nnJLY1+WiU4ALyJR/hbC25ppOUYsAspS3acMkxtRlXf8j24aGUbyq2rs0NkPbXhZmF
         mjXbGjObvoQ4jvHoO/ENnoMO2Cbd9331lf0RPJR/hAykDIXk3T1D5ZP3KXx+UeUXK2bc
         Q98rwe3lLzmWCDokg6NfRWoi9eDuEbeaxLk2eQWWo3Fozn1fMcY57SExHMu7FmS44vmX
         /TEw==
X-Gm-Message-State: AOJu0YwPjFfVKZGYkQ2FMEYwsVdcrj/EzVlCUUxh7gjCv2ecpdguKPtM
	Al1r70fSeCZWnBP+H9qzsyGQavqChC0=
X-Google-Smtp-Source: AGHT+IHrfjV9UWblloFL5FiPtnKNBSA+8TPUWL6LBb0pU0Mkj2XV9draZ8tZxUqjUfruJWzLqENcfHs7u8Y=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a50:fb81:0:b0:54c:6fc0:484d with SMTP id
 e1-20020a50fb81000000b0054c6fc0484dmr2579edq.4.1701441056664; Fri, 01 Dec
 2023 06:30:56 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:36 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 3/9] landlock: Optimize the number of calls to
 get_access_mask slightly
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

This call is now going through a function pointer,
and it is not as obvious any more that it will be inlined.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/ruleset.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 789c81b26a50..e0a5fbf9201a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -723,11 +723,12 @@ landlock_init_layer_masks(const struct landlock_rules=
et *const domain,
 	/* Saves all handled accesses per layer. */
 	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++) =
{
 		const unsigned long access_req =3D access_request;
+		const access_mask_t access_mask =3D
+			get_access_mask(domain, layer_level);
 		unsigned long access_bit;
=20
 		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) &
-			    get_access_mask(domain, layer_level)) {
+			if (BIT_ULL(access_bit) & access_mask) {
 				(*layer_masks)[access_bit] |=3D
 					BIT_ULL(layer_level);
 				handled_accesses |=3D BIT_ULL(access_bit);
--=20
2.43.0.rc2.451.g8631bc7472-goog


