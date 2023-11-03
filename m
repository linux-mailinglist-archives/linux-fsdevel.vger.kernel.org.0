Return-Path: <linux-fsdevel+bounces-1932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C87E05D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B333281EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B41C690;
	Fri,  3 Nov 2023 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dt3Yl9HC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8C6FBF
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:57:38 +0000 (UTC)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B08111
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:57:36 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-54366567af4so2648591a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027055; x=1699631855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6BXobpp4sPDST4BqTcqb5616NyPMhrIjRqGtfUtN18=;
        b=Dt3Yl9HCsrU4amyJChUBftK0tRbst+rdHzunPbnYQ3/XGSMcbTu7HvW+HSoLuvQhV4
         NgrPRGJvpbIDJpmObu30fwrJ1E408u2qLDpjXZa55JFlNQl6fm89IBxb+/hCUtknQzbT
         p6mTdvMs/yz04Fpp9qQ4+KO2nelZOaB59Rs0jrvZ8My7epn6yDmLqB8HrykwEEopUArU
         HRBCxXwc2rKrxJYVgsM3O4mDGCFuEN6IpKQEAn+m+0XNQj0JBv8YHF++hNFLaedJGzPb
         v9UBbA7trUJn9uhpoK+nM0bgWHJSpySMpRh3ZOy0oLW0sEHAAgujwvLpONx254ip3jW4
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027055; x=1699631855;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6BXobpp4sPDST4BqTcqb5616NyPMhrIjRqGtfUtN18=;
        b=WODuoUWkP5epIENdF6ehPFoB6Q/AFMLyCpyBTRT9xtBgk67Pk7Z9Ch2F/ukfuXTBlu
         KJfzRVarjfr4MuqcP7F3oRqKzL67G4k/G1EkXFV07rfCN4FtfQcGv2ykzMglFpARcxDJ
         Wy6ozJrKJYhP0L1Gc1aAQE+MP+r5yiLiwTvV5sWTbLLnPH+q77fPE6T5H2CkH+FJwI6D
         qZFPlX+jcPGEGq8O22icICfwBCeDYmXzVUoXHGDWDY8K7q83MPQsUlWDUT3Cv+u6JOUc
         Xjr6pvvUyaqkgm6+W6xckiXKA9oC7Nft2l7T+iH0z8k8UY5grcobspPKJssPl3l94R9s
         fA8g==
X-Gm-Message-State: AOJu0YxOb4QFPWAbk5A5zAbVX1Ad4O9q5+9iXZ7stw3Zmg93l706RNP0
	fH4kHi7tJMCrjzt5crx/+oqk+mTYvZo=
X-Google-Smtp-Source: AGHT+IH3Zh4iRAyCpfHS5ZF+J3OqKDW0BOVI3/9VrmNUI86MZogwKLyG6Lha7P7zVEEk42aQQZEi3QTPqkQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:aa7:ce03:0:b0:53d:ad8a:b0bd with SMTP id
 d3-20020aa7ce03000000b0053dad8ab0bdmr36531edv.3.1699027055268; Fri, 03 Nov
 2023 08:57:35 -0700 (PDT)
Date: Fri,  3 Nov 2023 16:57:11 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 1/7] landlock: Optimize the number of calls to
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
index ffedc99f2b68..fd348633281c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -724,10 +724,11 @@ landlock_init_layer_masks(const struct landlock_rules=
et *const domain,
 	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++) =
{
 		const unsigned long access_req =3D access_request;
 		unsigned long access_bit;
+		access_mask_t access_mask =3D
+			get_access_mask(domain, layer_level);
=20
 		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) &
-			    get_access_mask(domain, layer_level)) {
+			if (BIT_ULL(access_bit) & access_mask) {
 				(*layer_masks)[access_bit] |=3D
 					BIT_ULL(layer_level);
 				handled_accesses |=3D BIT_ULL(access_bit);
--=20
2.42.0.869.gea05f2083d-goog


