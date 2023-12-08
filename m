Return-Path: <linux-fsdevel+bounces-5305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E406F809E33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 09:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7D1C209C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C0111A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPxTry74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753741BC0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 00:01:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso24475105e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702022499; x=1702627299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+g570Kecn1QUPIxnJiz1Io/D9SgWVJC1TczCI47CnY=;
        b=EPxTry74xYrVrCvF55k+jdfhO4Ck8iBrfE79LC38I6jSTORh2wO+wpqWLZ+fnb5Jez
         wjsOFEKdOHpKSOsT35OwKv+7AAB1TkdbL1Qh0RUTTo6r2ebzCha9qbgNzzc60DmRhaCb
         nrd274s3KMPZPo21M2l1Hf5R0hckDbukSejdXNOxkgA/ig04HnCHGKidjCeh1cYmUfPD
         2XQCRpArC8sGmTc1pQZj/garvMhofqTM0ZdyfrlfZkXEki73mVp9AmGYhDu/MZrbcPqP
         667x0JpcZTFQDglXq1RLMUFBqSsHgTHbxwzINWs1AK1/cumR1KczEH0SXOTWqTqmrlg0
         3ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702022499; x=1702627299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+g570Kecn1QUPIxnJiz1Io/D9SgWVJC1TczCI47CnY=;
        b=pTj9QflsWGpaAGhnoIPhkfm8j1JXvoT4GtKSBdpVCo0thz8KN0X2HS8v1w1Ni/yiaM
         P/n7dDn1w8AldTr0VvsDzqNNObxP3ogzM7t+j2HaAQtshHDBNxfNs11l1NHZFsMho87q
         mkFSvYAhvQvzmID/ChZ40OSdGDVG7vVbL/kXgmkB9V1HTP31ZpktHVX/Fr/0bwZJQcEG
         lQbrOnWgTjbY7HIELl+zqkX7LAz/7x0dUGPgd4zBLRWJuMuds/6LAglnN5T0oDTs4fJm
         wFibMSjQJ1kji6iamMtkb/rMEDhUVTR5Hevop6eMWjpT4WXrm8eMq2kPskUTlw46fXzE
         yt2w==
X-Gm-Message-State: AOJu0Yz5QPZjSi9oAEd4NNFTzkLH8w/AXItYbgqfgdO7Pc5BHNeBz360
	fd2AOjYVOlrV1dFWyI9NJSv+2QbMTLY=
X-Google-Smtp-Source: AGHT+IH19jX7BZJq1UyUc5upL2cZzYl5Zwvxb1OoOontt3feHbx7CapPOPBshom37rB+AvOWMiEdjg==
X-Received: by 2002:a05:600c:2290:b0:40c:2c6a:8558 with SMTP id 16-20020a05600c229000b0040c2c6a8558mr1158056wmf.5.1702022499162;
        Fri, 08 Dec 2023 00:01:39 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040b56f2cce3sm4309853wmo.23.2023.12.08.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:01:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
Date: Fri,  8 Dec 2023 10:01:35 +0200
Message-Id: <20231208080135.4089880-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With FAN_DENY response, user trying to perform the filesystem operation
gets an error with errno set to EPERM.

It is useful for hierarchical storage management (HSM) service to be able
to deny access for reasons more diverse than EPERM, for example EAGAIN,
if HSM could retry the operation later.

Allow userspace to response to permission events with the response value
FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error.

The change in fanotify_response is backward compatible, because errno is
written in the high 8 bits of the 32bit response field and old kernels
reject respose value with high bits set.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

I remember discussing this API change with you and I even remember that
you preferred to send the errno as an extra info record with the response,
but I could not find any private or public email about this.

So let that be my first public proposal of the FAN_DENY_ERRNO(errno) API.
I would like you to recondsider the inline errno proposal vs. an extra
errno info record, seeing how simple and fundumental the inline errno
response is.

I should mention that I was specifically asked about providing this
functionality by developers from Meta, because it is needed for their
use case.

What I am not sure about is whether we should allow FAN_DENY_ERRNO
response to any permission event, also the legacy ones, or we should
limit the FAN_DENY_ERRNO response to new HSM events or new HSM group
class (FAN_CLASS_PRE_PATH).

I was aiming at the latter option, but I can't realy think of a good
enough reason to deny this functionality from legacy permission events
as the way that the API is extended is fully backward compat.

If you also think that this could be useful for legacy permission
events and if the patch looks reasonable to you, then you may go
ahead and consider it for 6.8 already as it is independent from the
rest of the HSM event patches.

Thoughts?

Thanks,
Amir.


 fs/notify/fanotify/fanotify.c      |  7 +++++--
 fs/notify/fanotify/fanotify_user.c | 10 +++++++---
 include/linux/fanotify.h           |  9 ++++++++-
 include/uapi/linux/fanotify.h      |  7 +++++++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1e4def21811e..87798fdc06e7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -256,18 +256,21 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (FAN_RESPONSE_ACCESS(event->response)) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
 	case FAN_DENY:
+		/* userspace can provide errno other than EPERM */
+		ret = -(FAN_RESPONSE_ERRNO(event->response) ?: EPERM);
+		break;
 	default:
 		ret = -EPERM;
 	}
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT,
+		audit_fanotify(FAN_RESPONSE_ACCESS(event->response),
 			       &event->audit_rule);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f83e7cc5ccf2..6b17d33a06aa 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -336,11 +336,12 @@ static int process_access_response(struct fsnotify_group *group,
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	int errno = FAN_RESPONSE_ERRNO(response);
 	int ret = info_len;
 	struct fanotify_response_info_audit_rule friar;
 
-	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
-		 group, fd, response, info, info_len);
+	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
+		 __func__, group, fd, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -349,8 +350,11 @@ static int process_access_response(struct fsnotify_group *group,
 	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
 		return -EINVAL;
 
-	switch (response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (FAN_RESPONSE_ACCESS(response)) {
 	case FAN_ALLOW:
+		if (errno)
+			return -EINVAL;
+		break;
 	case FAN_DENY:
 		break;
 	default:
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4f1c4f603118..2004a4d3b1dc 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -125,7 +125,14 @@
 /* These masks check for invalid bits in permission responses. */
 #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
 #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
-#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
+#define FANOTIFY_RESPONSE_VALID_MASK \
+	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
+	 FANOTIFY_RESPONSE_ERRNO)
+
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_RESPONSE_ACCESS(res)	((res) & FANOTIFY_RESPONSE_ACCESS)
+#define FAN_RESPONSE_ERRNO(res)		((int)((res) >> FAN_ERRNO_SHIFT))
 
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index cd14c94e9a1e..a8bb25c99dd1 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -223,6 +223,13 @@ struct fanotify_response_info_audit_rule {
 /* Legit userspace responses to a _PERM event */
 #define FAN_ALLOW	0x01
 #define FAN_DENY	0x02
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_ERRNO_BITS	8
+#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
+#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
+#define FAN_DENY_ERRNO(err) \
+	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
+
 #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
 #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
 
-- 
2.34.1


