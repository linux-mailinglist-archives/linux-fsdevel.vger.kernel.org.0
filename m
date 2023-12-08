Return-Path: <linux-fsdevel+bounces-5333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E580A947
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791731F21058
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E338DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiI+sykI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EA172A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca2a6f07b6so27708307b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050689; x=1702655489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez7w5bWzPjceJz/ogLgu//o7gCYQ9rmHzEg4Eyh+tpY=;
        b=OiI+sykI7ABTNfFFiWg+BXkPOh0zfU0Yc1b4kDzirWYqcmSP1JByG7wu6XtCj+PTgI
         /gj2zeKvjykqUOOiRFxGm+ZfJVHNwaGBXyZGx06o5CaMU6I4FsgH0AW14JbOUhmqnsT9
         dKZT6hLKU39MDeUwjJ2GJbABX9REzX18CeXvbtFqCJ5FON+Ex/O5KWpkF+7pnyBdSo5l
         ct/Nm7iaXJMiL2xBEHciyQ3ERdsJz9UYrF71eFz9IZAFRdM/0QtnncRicy3nNeGbU8iQ
         rPizPtF5q6dUyTZg0l67Opivof5PsO5egfzxgK8k0cI8OGnAziKhhyKJzCULppKEAElt
         jTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050689; x=1702655489;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ez7w5bWzPjceJz/ogLgu//o7gCYQ9rmHzEg4Eyh+tpY=;
        b=h6VCOdod/auuPDzTz01MLwSlZn86GmZNYTmgaR/LeNpAaZm9e9zqGbapviWsFb+cHA
         sWh3l6sdD7tvi3D2wFDxqURR3vdxTH50AVsrWXS35cSjEUtbSNLd+XyqhUU7lztY1X/D
         9ykfKtbGdTRkGTRdv2em1nABq2ueOOqmoWz0hikp9pZmGcybKzpdtgqZ3mEZomwy/+x/
         afgO/cXWydbjTMLzhBhBYZ3Twpqvrkqg3zHv1htd3Xh18ZhfTSnYkRUr8+LT5j67iLvh
         FhMPe291WNmkW3oopZgCDJ3IMozpwfCAN3XVF8k3dVYcPSUcoPciqNLZA0JS2WLgHT//
         kmzw==
X-Gm-Message-State: AOJu0YyH/ilHGoaGiR/f+33+cEWnttjN+pmaktBwuaTdQOsp0kmC2EsE
	xxj6X5Y+rSzEjhOrrV7VxyOSujvrlAA=
X-Google-Smtp-Source: AGHT+IHRbLajaEqB17GmhKG2OlJp/V82vAaj5clrRbCfEGGmtCGCdZTHFPym4wjVbfllWReG7gz6ihhINHA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a05:690c:c1c:b0:5d8:8d39:f67e with SMTP id
 cl28-20020a05690c0c1c00b005d88d39f67emr1976ywb.7.1702050689305; Fri, 08 Dec
 2023 07:51:29 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:13 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 1/9] landlock: Remove remaining "inline" modifiers in .c files
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

For module-internal static functions, compilers are already in a good
position to decide whether to inline them or not.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/fs.c      | 26 +++++++++++++-------------
 security/landlock/ruleset.c |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bc7c126deea2..9ba989ef46a5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -193,7 +193,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *co=
nst ruleset,
  *
  * Returns NULL if no rule is found or if @dentry is negative.
  */
-static inline const struct landlock_rule *
+static const struct landlock_rule *
 find_rule(const struct landlock_ruleset *const domain,
 	  const struct dentry *const dentry)
 {
@@ -220,7 +220,7 @@ find_rule(const struct landlock_ruleset *const domain,
  * sockfs, pipefs), but can still be reachable through
  * /proc/<pid>/fd/<file-descriptor>
  */
-static inline bool is_nouser_or_private(const struct dentry *dentry)
+static bool is_nouser_or_private(const struct dentry *dentry)
 {
 	return (dentry->d_sb->s_flags & SB_NOUSER) ||
 	       (d_is_positive(dentry) &&
@@ -264,7 +264,7 @@ static const struct landlock_ruleset *get_current_fs_do=
main(void)
  *
  * @layer_masks_child2: Optional child masks.
  */
-static inline bool no_more_access(
+static bool no_more_access(
 	const layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
 	const layer_mask_t (*const layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS],
 	const bool child1_is_directory,
@@ -316,7 +316,7 @@ static inline bool no_more_access(
  *
  * Returns true if the request is allowed, false otherwise.
  */
-static inline bool
+static bool
 scope_to_request(const access_mask_t access_request,
 		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
 {
@@ -335,7 +335,7 @@ scope_to_request(const access_mask_t access_request,
  * Returns true if there is at least one access right different than
  * LANDLOCK_ACCESS_FS_REFER.
  */
-static inline bool
+static bool
 is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 	  const access_mask_t access_request)
 {
@@ -551,9 +551,9 @@ static bool is_access_to_paths_allowed(
 	return allowed_parent1 && allowed_parent2;
 }
=20
-static inline int check_access_path(const struct landlock_ruleset *const d=
omain,
-				    const struct path *const path,
-				    access_mask_t access_request)
+static int check_access_path(const struct landlock_ruleset *const domain,
+			     const struct path *const path,
+			     access_mask_t access_request)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
=20
@@ -565,8 +565,8 @@ static inline int check_access_path(const struct landlo=
ck_ruleset *const domain,
 	return -EACCES;
 }
=20
-static inline int current_check_access_path(const struct path *const path,
-					    const access_mask_t access_request)
+static int current_check_access_path(const struct path *const path,
+				     const access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
=20
@@ -575,7 +575,7 @@ static inline int current_check_access_path(const struc=
t path *const path,
 	return check_access_path(dom, path, access_request);
 }
=20
-static inline access_mask_t get_mode_access(const umode_t mode)
+static access_mask_t get_mode_access(const umode_t mode)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -600,7 +600,7 @@ static inline access_mask_t get_mode_access(const umode=
_t mode)
 	}
 }
=20
-static inline access_mask_t maybe_remove(const struct dentry *const dentry=
)
+static access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
 		return 0;
@@ -1086,7 +1086,7 @@ static int hook_path_truncate(const struct path *cons=
t path)
  * Returns the access rights that are required for opening the given file,
  * depending on the file type and open mode.
  */
-static inline access_mask_t
+static access_mask_t
 get_required_file_open_access(const struct file *const file)
 {
 	access_mask_t access =3D 0;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ffedc99f2b68..789c81b26a50 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -305,7 +305,7 @@ int landlock_insert_rule(struct landlock_ruleset *const=
 ruleset,
 	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
 }
=20
-static inline void get_hierarchy(struct landlock_hierarchy *const hierarch=
y)
+static void get_hierarchy(struct landlock_hierarchy *const hierarchy)
 {
 	if (hierarchy)
 		refcount_inc(&hierarchy->usage);
--=20
2.43.0.472.g3155946c3a-goog


