Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00410CC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfK1P75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbfK1P7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89FU53QP+FVdCHuWN3syk61UhVN7dJid03CYqivJN7g=;
        b=LZx2U7KTBUUCsHYgKxhLAIRXqeyyl1wxnMxIkhw2MgBAIeE+LNG0i8JpkxkHy2Sp/ObKHc
        wah1Fdq8Fovwf5+6sNso6V0Dk/7ssec1JizKHaA6Z4JZuJBNklkgU0Usagob+GV7+nfU0M
        K+wwg5GhvYOw5Eh02le8n1MiKaVp7rQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-wH_SnTZfPnGEZNOAUgd1Vw-1; Thu, 28 Nov 2019 10:59:49 -0500
Received: by mail-wm1-f71.google.com with SMTP id v8so3709101wml.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We7AjSpHB0jAIiAGPVmWNU/mWAeg9C5/h8gzjyUehfM=;
        b=rJv46ixGe2abyWqzWhwxtEERgLUOiuR9dxJ4IbbL0XjpGXyGLrp1xbNsfWxwtTem2U
         VLZu5vd9TB7ZgV8WwE5CmQQpRVji8tHIwkutH0xFiRm4zp+Ywk8vS9+Jv3iZAxmA8Syf
         LPTLsnCUDTFTLiFtvOqqFzFtqMPB4NfbgI9ZtM4+VztleD+nwMs8tURUmRlbCnCRv55a
         02bmPYws7z4W8Vh8h1UV1L0D6TJikK3nD824dPA/IokehFDchKJtD9mZVgaAgcfy1hu7
         Oueo1Hz1TgHQbzjnO/UzqW/liU3uDW/MLSMk/PcACWD6gHKsUfhL+TTZEoivjkTovlUA
         nwZg==
X-Gm-Message-State: APjAAAU5Ah4Q3oxz6Q7zVzH1ZFLpY3YlJUksPjpqc9VMoNIZeOI4KaGq
        76cj6Z0jPk1nIDmu+lI1N0Ap0nCh9wZUgRqyiJU9Q6H4Zoz/juw3ganx8MgPHEUK0Di7vkSk++X
        JWxlsBD6jnhmfdzWUrI9Jm423xQ==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr18321003wrx.309.1574956788030;
        Thu, 28 Nov 2019 07:59:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZlM1qNOSuQ0BjA6Dge73Z5zincJX0ZfyB62XBUZ05W3bav2LiNzP/KI8T9gSRKH3uWCXhlA==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr18320980wrx.309.1574956787755;
        Thu, 28 Nov 2019 07:59:47 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:47 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 04/12] uapi: deprecate STATX_ALL
Date:   Thu, 28 Nov 2019 16:59:32 +0100
Message-Id: <20191128155940.17530-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: wH_SnTZfPnGEZNOAUgd1Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Constants of the *_ALL type can be actively harmful due to the fact that
developers will usually fail to consider the possible effects of future
changes to the definition.

Deprecate STATX_ALL in the uapi, while no damage has been done yet.

We could keep something like this around in the kernel, but there's
actually no point, since all filesystems should be explicitly checking
flags that they support and not rely on the VFS masking unknown ones out: a
flag could be known to the VFS, yet not known to the filesystem.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 fs/stat.c                       |  1 -
 include/uapi/linux/stat.h       | 11 ++++++++++-
 samples/vfs/test-statx.c        |  2 +-
 tools/include/uapi/linux/stat.h | 11 ++++++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index c38e4c2e1221..7899d15722a0 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -68,7 +68,6 @@ int vfs_getattr_nosec(const struct path *path, struct kst=
at *stat,
=20
 =09memset(stat, 0, sizeof(*stat));
 =09stat->result_mask |=3D STATX_BASIC_STATS;
-=09request_mask &=3D STATX_ALL;
 =09query_flags &=3D KSTAT_QUERY_FLAGS;
=20
 =09/* allow the fs to override these if it really wants to */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7b35e98d3c58..ed456ac0f90d 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS=09=090x00000400U=09/* Want/got stx_blocks */
 #define STATX_BASIC_STATS=090x000007ffU=09/* The stuff in the normal stat =
struct */
 #define STATX_BTIME=09=090x00000800U=09/* Want/got stx_btime */
-#define STATX_ALL=09=090x00000fffU=09/* All currently supported flags */
+
 #define STATX__RESERVED=09=090x80000000U=09/* Reserved for future struct s=
tatx expansion */
=20
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To =
avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL=09=090x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_m=
ask.
  *
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index a3d68159fb51..76c577ea4fd8 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -216,7 +216,7 @@ int main(int argc, char **argv)
 =09struct statx stx;
 =09int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
=20
-=09unsigned int mask =3D STATX_ALL;
+=09unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
=20
 =09for (argv++; *argv; argv++) {
 =09=09if (strcmp(*argv, "-F") =3D=3D 0) {
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/sta=
t.h
index 7b35e98d3c58..ed456ac0f90d 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS=09=090x00000400U=09/* Want/got stx_blocks */
 #define STATX_BASIC_STATS=090x000007ffU=09/* The stuff in the normal stat =
struct */
 #define STATX_BTIME=09=090x00000800U=09/* Want/got stx_btime */
-#define STATX_ALL=09=090x00000fffU=09/* All currently supported flags */
+
 #define STATX__RESERVED=09=090x80000000U=09/* Reserved for future struct s=
tatx expansion */
=20
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To =
avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL=09=090x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_m=
ask.
  *
--=20
2.21.0

