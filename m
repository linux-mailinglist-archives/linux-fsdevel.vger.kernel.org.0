Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221B5F3C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 06:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJDEeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 00:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJDEeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:34:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D462E6AF;
        Mon,  3 Oct 2022 21:34:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so14106117wrr.3;
        Mon, 03 Oct 2022 21:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=sXX5hX07BGx/rUvDQD47pclnXvdWt2TdZfsk0DmyS1o=;
        b=Ag6joGOw0nFt/ikjUoadX/LWmbO2Y4s+CvAVFJ+GKUhejJhijT2cjlnHDRqmuLfqe8
         lylGx4AYVDkLY3g2NGoRZCBD7j5YwLvfkJIIUc7xX2fcCXzriqcU8hx+fjp1AnRTI30V
         EYLnz8tZf1F+B+ESApinPKhqKRg7tl4tQHfoSUupHAL1g9RDGSDsBUhWX18KJpgoyjDo
         L7+np3fGiiixl2kxymfMTMI/Q+kjetK3H1QRt8UX2D8P7vjVPdQnZFH5AvN/bVAbEFSa
         hJUBU7UgrwStNERmSCKyAPj3c/stlY1hZvSAhqjQjcxdFCwXoTZSHSuVUgnBO4TTO4w9
         uNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=sXX5hX07BGx/rUvDQD47pclnXvdWt2TdZfsk0DmyS1o=;
        b=yiH0be3uMH4fAgCvgwRimu5P2LI1NKYibgnz978G+EKcmaengTHSteXz/zerPNrDA2
         Caiywk5sh30rJYX3wt7rKvFytZXJaPHYfwiZFWCxDzhLPeMX6ADlFbDNVhdFusUAn43R
         VGbZeBef6FSPizgnfYaQ9A4wd4XPNq95h0I3SnAjValhbtUJhV8u2W/BBo6xyxwBGyME
         X2K6QdZoWKvloU0+GxDCYY3yeAENPYkI5DSSTi4bKdVv0VQWnmCZvwoUVQaqO6r4khMY
         hXJ3Ctyij33lU4qQtah/1SsbtjdklY3bKp89V4J0ptT1kFkslCUjkl0jZ3uDBkFMhziJ
         ByGg==
X-Gm-Message-State: ACrzQf2lXhGngr5x5rPkena8ftMFW97tK84Gn0/zRZjzvelfTZKkKjiD
        YWJusfcMOQfftp3BXq0lKsTUab+UwgmSrA==
X-Google-Smtp-Source: AMsMyM7/ZkC7rTcZwmP8+Aw/TsKUwPG9cD4Kuvg4bXZi43PX7RBEHVGW3WErXO4pDtfiSCfHrNqj3g==
X-Received: by 2002:a5d:5849:0:b0:22b:a0e:11e0 with SMTP id i9-20020a5d5849000000b0022b0a0e11e0mr15606160wrf.72.1664858049476;
        Mon, 03 Oct 2022 21:34:09 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-3-75.netvisao.pt. [217.129.3.75])
        by smtp.gmail.com with ESMTPSA id x6-20020adfdcc6000000b0022add371ed2sm11415547wrm.55.2022.10.03.21.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 21:34:09 -0700 (PDT)
Message-ID: <9f8c3c0e-189b-87d0-965f-fbe68ff9b883@gmail.com>
Date:   Tue, 4 Oct 2022 05:34:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH] fs/ntfs3: add system.ntfs_attrib_be extended attribute
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NTFS-3G provides the system.ntfs_attrib_be extended attribute, which
has the same value as system.ntfs_attrib but represented in big-endian.
Some utilities rely on the existence of this extended attribute.

Improves compatibility with NTFS-3G by adding the system.ntfs_attrib_be
extended attribute.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/xattr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index aeee5fb12092..8620a7b4b3e6 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -15,9 +15,10 @@
 #include "ntfs_fs.h"
 
 // clang-format off
-#define SYSTEM_DOS_ATTRIB    "system.dos_attrib"
-#define SYSTEM_NTFS_ATTRIB   "system.ntfs_attrib"
-#define SYSTEM_NTFS_SECURITY "system.ntfs_security"
+#define SYSTEM_DOS_ATTRIB     "system.dos_attrib"
+#define SYSTEM_NTFS_ATTRIB    "system.ntfs_attrib"
+#define SYSTEM_NTFS_ATTRIB_BE "system.ntfs_attrib_be"
+#define SYSTEM_NTFS_SECURITY  "system.ntfs_security"
 // clang-format on
 
 static inline size_t unpacked_ea_size(const struct EA_FULL *ea)
@@ -796,7 +797,8 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		goto out;
 	}
 
-	if (!strcmp(name, SYSTEM_NTFS_ATTRIB)) {
+	if (!strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE)) {
 		/* system.ntfs_attrib */
 		if (!buffer) {
 			err = sizeof(u32);
@@ -805,6 +807,8 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		} else {
 			err = sizeof(u32);
 			*(u32 *)buffer = le32_to_cpu(ni->std_fa);
+			if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
+				*(u32 *)buffer = cpu_to_be32(*(u32 *)buffer);
 		}
 		goto out;
 	}
@@ -889,10 +893,14 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		goto set_new_fa;
 	}
 
-	if (!strcmp(name, SYSTEM_NTFS_ATTRIB)) {
+	if (!strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE)) {
 		if (size != sizeof(u32))
 			goto out;
-		new_fa = cpu_to_le32(*(u32 *)value);
+		if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
+			new_fa = cpu_to_le32(be32_to_cpu(*(u32 *)value));
+		else
+			new_fa = cpu_to_le32(*(u32 *)value);
 
 		if (S_ISREG(inode->i_mode)) {
 			/* Process compressed/sparsed in special way. */
