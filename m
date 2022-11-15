Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B813629324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKOIRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOIRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:17:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A96621244;
        Tue, 15 Nov 2022 00:17:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g12so22702454wrs.10;
        Tue, 15 Nov 2022 00:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpkg0m971HY0liHkJ/8urftydU+FB+sjslyYJScsb4A=;
        b=S8N5KtFFXoiH16LGGy//yyZAOBdK7b1h6f1ERj5H5CaCfp0MKCOcT4rdZI/l7OiLGa
         6gCVRYlLEy4knPC9Oy3mM5e5KmuYc+zcbRWHLDT3SEUrZ7KBgf+gC4YdkbF2HffdLOXR
         Kceoyjyg7Xp+9R3M4ThsLy20cobziIs2cox1da/QoFGyPOvUEXWF7+ScEBVBvnXqmONv
         8HNBRik9uyTV9h6/HmmMK0BhI1CTS9AuYM8PDSUop76maX1HtF7mRSaxU5PsGNJeD1fD
         AWzIpbUzL3K/bRfiXpP6GTvDCfY5FfLytfabVIQ6i9XQv7nOSEuLk2t6FwUdegPCJg6q
         pq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpkg0m971HY0liHkJ/8urftydU+FB+sjslyYJScsb4A=;
        b=ZrVYH/88e2/w8yLQfxOZ+QJBlMvshKjeu8PEBqaekV2jsLivC0rRoAe6OxRPj37s8s
         omf+fPbbbSXj3f1WRpYLB2LctZBV5G0SKl7WfzyU53ubpEbqEqJ3KAweqc/aBwBq2JOl
         7FZc1W4ecbtbB8f73P+IbwVae/UdK2+DMXSZMDyWy4AAr5a2GRupq1QxJtFdXSXtMX9t
         L5ZWW0OFdvkZzZjY58r7nuVBAAdo57/6n2czVOuTqr7+LWMz7eQ+EhfwNGL4F0dFTwu9
         /DdzjzhteGvTzSbhHuLgMwB97TYCpIU2pNsc3WxFkRceq4KclXzGllSEhvciVByFc6lS
         139w==
X-Gm-Message-State: ANoB5pl6pWeLs5xmkOd1XasC2bA/IGnECTtGfCHiT/buHLJiM8bsQhyc
        guBdX7G5q7LEEzVCbSkhNxJud+e75nA=
X-Google-Smtp-Source: AA0mqf6KIRLo/vGkozM6QZ5P64pW0K46zCw3yKUC9G1QWS2uS+82ZOGSMV/aw7fJWJbKcLooxQo1pA==
X-Received: by 2002:a5d:4568:0:b0:22a:e51c:458a with SMTP id a8-20020a5d4568000000b0022ae51c458amr10360348wrc.577.1668500255329;
        Tue, 15 Nov 2022 00:17:35 -0800 (PST)
Received: from [192.168.42.102] (mo4-84-90-72-130.netvisao.pt. [84.90.72.130])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b003a2f2bb72d5sm26267347wmo.45.2022.11.15.00.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:17:34 -0800 (PST)
Message-ID: <be1a2495-1c46-cda1-4f89-7e3a39d939db@gmail.com>
Date:   Tue, 15 Nov 2022 08:17:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: pt-PT, en-US
To:     kernel test robot <lkp@intel.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH] fs/ntfs3: fix wrong cast in xattr.c
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

cpu_to_be32 and be32_to_cpu respectively return and receive
__be32, change the cast to the correct types.

Fixes the following sparse warnings:
fs/ntfs3/xattr.c:811:48: sparse: sparse: incorrect type in
                         assignment (different base types)
fs/ntfs3/xattr.c:901:34: sparse: sparse: cast to restricted __be32

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 8620a7b4b3e6..6056ecbe8e4f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -808,7 +808,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 			err = sizeof(u32);
 			*(u32 *)buffer = le32_to_cpu(ni->std_fa);
 			if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
-				*(u32 *)buffer = cpu_to_be32(*(u32 *)buffer);
+				*(__be32 *)buffer = cpu_to_be32(*(u32 *)buffer);
 		}
 		goto out;
 	}
@@ -898,7 +898,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		if (size != sizeof(u32))
 			goto out;
 		if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
-			new_fa = cpu_to_le32(be32_to_cpu(*(u32 *)value));
+			new_fa = cpu_to_le32(be32_to_cpu(*(__be32 *)value));
 		else
 			new_fa = cpu_to_le32(*(u32 *)value);
