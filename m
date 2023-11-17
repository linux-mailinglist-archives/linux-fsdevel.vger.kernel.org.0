Return-Path: <linux-fsdevel+bounces-3024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4A7EF59F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F3F1F25077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901753A8D2;
	Fri, 17 Nov 2023 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwD9QI7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83884B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03390793fso2655892276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236173; x=1700840973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUQR230Th2KVt3Dfu08HOgX0IUW01YM78cSblFoPosM=;
        b=HwD9QI7PMriII0wgYsOrUaAWmcmmpEjfGbLh+yiJvqN9N0WNFAcc/PsLLawINVWFCf
         ITg3bL3XCmz16Jk0c3GZDpbsfqedSs5fn6jiIiiR5eUiekfrC828ahlf4iZPOdV/7LDh
         6rMvB5CXg8Oty+SxMgE940oXRkFlp4t3hHnau4hWDcYmRGOZmYold0qZSjyZZd6puR+p
         Xx52ex6F/bfoTKeS6jOA202rF2223Kcs8joHRGQcEXNsgWgFOvVNNt7Ylw4sgC1S3EkN
         VPaCkHQE5j89Xg7X/AMHRnvbGR8TidLzK2RrffzR5KLxYsxzoeC2x+gcvi9hj5KtDL/Q
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236173; x=1700840973;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUQR230Th2KVt3Dfu08HOgX0IUW01YM78cSblFoPosM=;
        b=NO0G1VHCJHgn+qSzUaIc75+bFiQo04koBTy4bft1AOGn+VJyxsyWDpkh2GqrcQVNXq
         myCC9raPT9ZTLuhGxsNmW1CbknDyKDvpceDcbhTmmfKic6NbajstRypzRgbMu8kJHyIh
         u8flfweEILaX/xFEONstinhw5J/six+Q6uugEfkpYk/kQCoulv7q2SqGk3RSngr3gYy0
         +kiiQXlKetS//i+xEIptNNJZz7qsW+bavSeJnUWPmEUz39P1wNJLAORBJFgiikuBwGGI
         4u9jzWvAYJbMvOn8d7WXGVQOVQysaJfZZCFepDhRkWOf4tZNrFq/1aTDz9IpIcTu9dq2
         Ojog==
X-Gm-Message-State: AOJu0YygQKYYkqbwZpH0SrDN7lLJ1WJiFqbh7JKAqoA4qgrLrmUYmvpZ
	DfxuG+SVDa0V9kVPV3Wduhg+cU/CBXc=
X-Google-Smtp-Source: AGHT+IEL0KN+UN641Uljfkbo9Y8VJux8UtnfrFtKYw25d9lH69ZCE1Akdny0XuTJKn9ys7mvg1QxeivIUMo=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6902:206:b0:d9a:e3d9:99bd with SMTP id
 j6-20020a056902020600b00d9ae3d999bdmr460875ybs.5.1700236172782; Fri, 17 Nov
 2023 07:49:32 -0800 (PST)
Date: Fri, 17 Nov 2023 16:49:14 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 1/7] landlock: Optimize the number of calls to
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
index ffedc99f2b68..23819457bc3f 100644
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
2.43.0.rc1.413.gea7ed67945-goog


