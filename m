Return-Path: <linux-fsdevel+bounces-5335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C117780A94C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4632811CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C634567
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpPIyhMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862E172A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:36 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a1e88b30248so225642866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050695; x=1702655495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQQhASvSHEVVJUGZcFZxCWmvl8oJFIsiHif6PfFONLA=;
        b=MpPIyhMH3GGBtJo7PjgoWRlOiUAzfhtTvNSppGTgwe4ajNgUiPHHVuWA/j6y4UdnmA
         hoUUP9Rh36OPB+XrH6tW7CnPVntasphZzkbx/l7P8WBABqsjm8H4dzxxON8RKLsMy6mn
         y6LIoQC1a0uzu7NB3+QaGxu7pMzxOexXsij+g/YLfpQToUJRtro56+9r4CoBfMQpLmVy
         acuj7cKwSJtvIhdudPe/B0m7r25XCOQtYH296EzvlODsjQ26g7A8JDfC9iFfLTgj60EN
         P6wa2dyZgkwarljtUn0TVSAnO5qHbnUFg7xSF4a1U+L114n/JwKZaVKQh6d09WnZ/w4S
         pTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050695; x=1702655495;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQQhASvSHEVVJUGZcFZxCWmvl8oJFIsiHif6PfFONLA=;
        b=PDdBQvDJYrcrCUR7fmpG5waiOL1D8CiQGsnbAtDyhdSPc2QoG4YDws0as/TWiDiuGP
         2ULq7Ee96jxbpZR4f5tNSMgf6/G2UmjNeMGnQWOco6966NyU4Eb6a0uyr7prrOoDlH3t
         MdecBfsbAOJ/E3Hpx6XRTe2kE18AZj5ZN0Yi5ElL/ib9TWdxv2meHsNQmwb0cBor4AHR
         tdKZ3BnCjZ/waJBZ9C54IkkHgj7IlgzaC3YclCnDTV0uRANVAE/eYMA0M4Db9y8BRMdj
         724LtLgrCe6d+ngwM/SzRVQHUL1fT567e5YQlpz8eSxxZCBFBl32UnFq4NPYkBHtSqxd
         zPNQ==
X-Gm-Message-State: AOJu0YzkuwhFzrXkYZchZfZEiV6q//8Ww0vmXIUlbKBt52mmUg5cn2pP
	4W3UO602xpu1nuDmKoaMdZu1x72RE5c=
X-Google-Smtp-Source: AGHT+IFpaD++LK4E7OEiQC7I4oXVtYGVHw5pHI4ByxvRkcjujlRVCN4Pq1RUgImtFRqk9PUtqPZi4UFPhls=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a17:907:1b20:b0:a1a:36ed:f807 with SMTP id
 mp32-20020a1709071b2000b00a1a36edf807mr14369ejc.2.1702050695110; Fri, 08 Dec
 2023 07:51:35 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:15 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 3/9] landlock: Optimize the number of calls to
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
2.43.0.472.g3155946c3a-goog


