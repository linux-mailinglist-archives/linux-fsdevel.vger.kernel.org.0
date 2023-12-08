Return-Path: <linux-fsdevel+bounces-5340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8E80A954
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35C21F2106B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3485138DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXlkAdUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283951724
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d749e4fa3dso27573917b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050709; x=1702655509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kdDoWcSv0tcnaDo2x6ejdD3WMv5LtvRZfR97Sl3d0s=;
        b=jXlkAdUzu4Mz5/JrjNNonlaEdm09xjEDO2MsTRjP4SGdZHj3511mAf06MQEnQVhvSk
         38J9sSQf9p+B5Ll4Y2uJCAe/iCri6LR0zx8XcCTHAMJ+Yqz4gua+HMlfam9xu5JoDPk6
         Y9pK/+Scx2wuA9yuMAEr8TA1AKtqQ0gdPCb+6Drlw2hdO8CeW2yHJBk4kS9MnxTsscgq
         GLsO7sTMCX3V8QUpglfZjXVI+JGpFwb+8yc9nYZ4kPkG9k7zBETQ35m3a/jSOWZKNunA
         Gv0J6Y7RrV1lTvkezODyVjAASosSH1tsxW5IdRQ7ISEY6AR15abBLJi9WZI0dlgvq27+
         aJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050709; x=1702655509;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kdDoWcSv0tcnaDo2x6ejdD3WMv5LtvRZfR97Sl3d0s=;
        b=G0Xw9ryXDRCvEjwCJtmYI/SvmPVZe6GPRInujQzo9b5jWc9Lea2BUrZu+HRJtw8qnv
         3P0qRvGFUNDGzOBkkFLM+gDT1jO+Jvzq/FakOSF7A/NVt4HQWy87Wyui1jKPLRpy0J7F
         0hNzQR9ZMUcAl2av04eJajD68/MbV0Fl5tcm1XNjmS7420uKyqRuEKlFkIhCgsHyYpAe
         x5hqYIYzaQK3HtPZbHkcUunNtbWyFT28nidlgk2+PJw3uxdItmxfOxIjEqqcUAHUbYZi
         tDvDKVKv3e4F53b7bk2M9V3JPr5K0rP1eoSt5/H0cunT+QEFVjzh3FoSyhDvUFutBH6j
         kF2Q==
X-Gm-Message-State: AOJu0YxU54bzcXPYnUvafVOuN1P5rLUNsOrlLVqLZkLX4PXYZ3MxReF0
	dKLQioFMxCONmdKXq3+XImtbBSol70U=
X-Google-Smtp-Source: AGHT+IH2GK2Km/C+rYT3PFzl4qwVpQygC8rxDh3OJ/ae0rcaiPeC3ig+gpdwmILJ+jIPiMLTvaxKXK7nyak=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a05:690c:3505:b0:5ca:c025:3cb9 with SMTP id
 fq5-20020a05690c350500b005cac0253cb9mr2108ywb.1.1702050709352; Fri, 08 Dec
 2023 07:51:49 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:20 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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
2.43.0.472.g3155946c3a-goog


