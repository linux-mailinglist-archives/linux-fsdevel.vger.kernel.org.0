Return-Path: <linux-fsdevel+bounces-4587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9662B800D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F13B20E84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BB3D992
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ba4EDtYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F0170F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:31:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb6271b225so37044097b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441071; x=1702045871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHv5r2nFt7uEKH+N98ywQLZZENznpsQB4F5i/duIh6c=;
        b=ba4EDtYPPdx/BuF8gWor9ccjAPt/2Vz9H4oELoFCrbKA2CER4teWp5NSMQw0TGZ3Nl
         gm9Hg5NyWp/WXikCZjmwK+XVOWQiEmKFnLNBPotjGUE4XCeYC3anykbwpVmbgD5G2aGy
         cG3vuI+IEnXVEBVzljfXO+OQ1j00bHAj6fFhzOuA8JgEec0cpKI5hqqAM8MpWF/PHmCP
         a5ix3T23NHY9TNA4Mfab0FMOC6uK04Ei2UgpHqL3pOetoxVDsVqx/Ogyh4miiNd+OjQz
         z1bL51EW9Ej7s8Q7fPwSYE3JlEl5RZ0c3b6tQOwjsQfQ1jQrIqSmpmsQu90XV1n+suNp
         9LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441071; x=1702045871;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nHv5r2nFt7uEKH+N98ywQLZZENznpsQB4F5i/duIh6c=;
        b=eidi5H1aXat1ATtNw9ciXxcWCxcFYDmVfTFREi/+kbtGrA6Rnk3TGCxuxBOoWxrvKx
         q3i1PRHuDbgae54uui8CodSEoKGdcJbqVTuFH/3a0s5TqRE9IdxDHJP2BU5aq3R9Kdiv
         JD+xT3CG8A2zbtBPm46KfO3ehySVxzKj91OOPhe1XBlaiOdN+4/3j1+DSf0LjDRaUkRd
         EDMhcueccjA8qwzxoBAcEeT9r4JDdVM1Cpx7zM5CP1/2oUUx1ZX4eI4iS4sJXUsFYyEM
         fjH5kaKxjK9c8k9wJBgu5qG4JUmpK5kiF1YQuNPLb1BCKKZdSKCF8wDNpKMIronSzQSo
         8Lmg==
X-Gm-Message-State: AOJu0Ywm5X62J7WHm89KWJo23MKekANZBEqZ03EIaa1scTGutLPnCCjw
	kPM50nmF8c6trzBAKZXZltDaKPuGLZA=
X-Google-Smtp-Source: AGHT+IG70Okx0fgLGQVBf3UwIVnERJsYKXlyRatTnCbnk8ydms/45EhWSgMq4Tjfv6xcLw790Q4GdI18Hi8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a81:ae21:0:b0:5d4:ce2:e90b with SMTP id
 m33-20020a81ae21000000b005d40ce2e90bmr78578ywh.7.1701441070943; Fri, 01 Dec
 2023 06:31:10 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:41 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..d7323e5526be 100644
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
@@ -199,11 +200,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -317,6 +319,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.43.0.rc2.451.g8631bc7472-goog


