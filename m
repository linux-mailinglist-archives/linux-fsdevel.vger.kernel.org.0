Return-Path: <linux-fsdevel+bounces-1937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB417E05E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB5F281F0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B11C6A2;
	Fri,  3 Nov 2023 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itzsqItw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2541C68A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:57:52 +0000 (UTC)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B7D57
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:57:50 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9c983b42c3bso367987566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027069; x=1699631869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOCNSi1HIkBnaTYGa33qWxOS2ibI+ZQHcixXpo/0924=;
        b=itzsqItwgIX/RNyhHk3m1S18cQ282d/vKlq8rAbXwh3qt7LiZxVlcXGgbhqwL4y9ka
         wQoGfpH1wpEF1efWNDlBw4Us6i6Eb3Sd38xA/pXuGg/F8GZkCKSsQAe3gNULo0CqmFAM
         NhdpVy8oMXfEV4I51wtwTXQ7sy3WZz8l0PhBMYVK+CUX4s8or/TUdoTfQxRRSwlCqw+F
         oH/J2RQ+QoyjdzkOPWT4BFokAcMOOMlShvid/bRASg1FDiYvesfOOIGtrGlgKBQxyNfL
         CIbH0OpSojMNwHt0bHM+wJlKWbK3Yo48KY1mBVUbjUjStIghP1dhNpEn6FuqowehveH0
         N+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027069; x=1699631869;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xOCNSi1HIkBnaTYGa33qWxOS2ibI+ZQHcixXpo/0924=;
        b=dXQeHPkyhiVM2MhkX9dluu3Fccr61SMJpAGDXowvIfzBF9hrxzObkIlqR7C2T5fwX9
         qQFDfvcHuumj0dbfqhRFqC986CNgIf8sFZt4K3Ppd9fIGEXKmMtbwxgihRhz16S9k4cl
         hK7YOM1Xio++fABh/7gxj8P0diRKoQyOXIiVGTkVuqg1N/UpDo3xd8VHz5Epn1DFfril
         aeAYiPaL4+SPv6253fX8E9ymU/RpXuuegUVCSTIi4jIzKKHfzJqFVmKkTCVg5e6Tf9H7
         Ag/dS1/93hWAbHPDX0a7bZ1SGzf+FhzkiX/Ouru30+Lld+5hf/0PMOwqLQjTYqR1WMT5
         bN5w==
X-Gm-Message-State: AOJu0Yy4j2HDNP6u66QPbEXLbtSzOvhT6ehNRZCWEMfMRhugrETUqzoj
	46DIG0L6hlTlEFZTEDBMJcluOHo9Lk0=
X-Google-Smtp-Source: AGHT+IEkjzZ+rWUnr2Uwoa4MxxIej/VkJvLcmZBXO+gs6KbP6tb8ZrfPNm41/EtPvHWpnRUgCLiFbgdH7YE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:a17:906:e285:b0:9cd:8a9e:c90d with SMTP id
 gg5-20020a170906e28500b009cd8a9ec90dmr25450ejb.6.1699027068990; Fri, 03 Nov
 2023 08:57:48 -0700 (PDT)
Date: Fri,  3 Nov 2023 16:57:16 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 6/7] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..a4b2bebaf203 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -199,7 +200,8 @@ static int populate_ruleset_net(const char *const env_v=
ar, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -317,6 +319,10 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.42.0.869.gea05f2083d-goog


