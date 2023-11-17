Return-Path: <linux-fsdevel+bounces-3029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED57EF5AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93852281376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB523EA99;
	Fri, 17 Nov 2023 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb40egpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B4127
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da31ec03186so1715827276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236187; x=1700840987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUD2X0nvvEDGbnvAFUxCT0dn9azP0EmEwTtnwK9EbZA=;
        b=rb40egpM6vr1wa2ULlH5lfOwXOA7h/YA/5YzR+b21ixTYu+DzXzDZEoQ98f5I8r3qO
         3dovVIz6vr3Ch4TLkt9GXGQClsEBOR/Z9Ps0eOlgQ9+GrmEZXnzhluPznF9QcKpEqnPq
         Eq94HEMd2wSlc7iIebcYnZuY1C3OxKSM9F/ZDrLgwom6fIjujodkgis1DQUwI9/0KjQR
         n2Gs9qUoM1KFxlnt/zEQZhLpdDpKkl68YiXX3nzDPyrfRdp8KtnxQuyhkYodhOpogc9H
         tWifWDK0yM8hTbm77JVdAyuHSMjE36iVIhr6gsLseQFDDkwN3/XhA9XlDTe+Xzt0gORU
         9ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236187; x=1700840987;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gUD2X0nvvEDGbnvAFUxCT0dn9azP0EmEwTtnwK9EbZA=;
        b=fxhYS3Jpi180TOWYFLqhXL5teMK7IOL3YSOfbVPpX7oC6EMwMhdLreDgrvc6qUoEr5
         hjPTbpYfWvQHHro0IfpUG6E5iwlGX1S7tERQjmCeyorElrHHuTA4h+PeiGUdjA0I1ejV
         mD/PI6VN7uv+nqv/0D0P8hYXXV4SwptiXvoxRz04ZbLRU8eVfbNRQrTVB3F6GsXBMPvs
         3/50M3X5jo8tLY4sAB7HHzgRv7FKLXrqyJ7xJC9JrA/9zOg8pNNAIfWMwKJ7H2VghmBl
         uFpqRPH1oa0NcRl6u1UTS5eDxKOFzSkVPksC+MIxd0tO+R00R4TerhsS/9ZU/RhDO4nh
         rZew==
X-Gm-Message-State: AOJu0Ywyy4X/62X1N6HnuLRgCs+PSFv9yIVq5GpdXgKyn5Y+phFCKMCa
	bqzmPVUiPpMDUd/wjX8g2Akb7ga/pOs=
X-Google-Smtp-Source: AGHT+IEoMJQSIFBYsYtsknULEvtZin7eG5XtCpIJtwavDFcIjeEacaz5DtzZcCHfQMRD+iQVH2HkbZKNAa8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:e041:0:b0:da0:37e1:558e with SMTP id
 x62-20020a25e041000000b00da037e1558emr165975ybg.6.1700236187263; Fri, 17 Nov
 2023 07:49:47 -0800 (PST)
Date: Fri, 17 Nov 2023 16:49:19 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 6/7] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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
Co-developed-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
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
2.43.0.rc1.413.gea7ed67945-goog


