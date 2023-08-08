Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500277435F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHHSCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjHHRvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741769EE1;
        Tue,  8 Aug 2023 09:23:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40398ccdaeeso29131091cf.3;
        Tue, 08 Aug 2023 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511780; x=1692116580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tT3Th0/cW0C8QpOpbxiYIDyUxnSvmk/dEVgZXb7Tjac=;
        b=iHGZkB29fNcL61mi7ibfI2d32f7EdZPicl4/eEsU8HY5431IdVR+/vRgEk7pmEZCzr
         kM6O5EfmYD2UnXmdKV63J4pxLezUNwHm2AKWfW46OlLP4sszCSsak6bcwXpoT50t6Tm2
         ZJAAdKD/aZKS4X5uWzRX2+jbjoTS7EIU72g0rxNe4L2PjYbHheh96M9chWqhCU9nG6n1
         CLz3X0DXz0PXd6pO0Lg1F02qk4GBqWSpqD8s36HfVWIKlrPbP2MPOSoHmn3BJa4d5+0g
         1Eembnz7blEs9okI/z1GseBVE+Php9izJzz9B8eRaiHMWfkTFxM+bdkX0iv6yUBRTiyB
         EoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511780; x=1692116580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT3Th0/cW0C8QpOpbxiYIDyUxnSvmk/dEVgZXb7Tjac=;
        b=PvtUhrTGkGPdEGup7cPKfDs/yRbcOYnIQTrgb/ISTtwX3qD5YKiL2h2cHAjQ+v3iEY
         vf002b2YRsVJZTSWSiKgFCnV3fAZTuu+X4BCMZK7Z4CbNgHhqwI6JzSnUT38SusZ58dj
         QN2LugAR9C2x8QVv2Jt6J/qcDLFrkS2ak0Mu2uZThk8xgFUWGW4bdf0ucmrmaCS+J1SZ
         xhe9gfeeoZ04GVlF8lOdeAvhAmcTC6vwJ9qx5aeGPm6FN4gJtroA+NP5slNsNYU+IwXs
         hIekfPt9O4y4CZ7/i7ef9HSKcs9+8kv6rGxiK7YPWDjF1LlYDRtXK0x7mH/744oLNwpG
         YYrw==
X-Gm-Message-State: AOJu0YzOdXjj7y+HK88XK+GdJvp0lcYj2eyOxDGtZovJljV/cjwAZ5r6
        rUI6xLGCtQTSSQjTbRYpG56AHp+F7XWYPIlc
X-Google-Smtp-Source: AGHT+IEDVzUF/xiLAO/scynI8YtPCMd8bJNj1zeo/rRkV58CULjDs5vKoh76aCZ85kWCLMCO9sTzzQ==
X-Received: by 2002:a05:6a20:96d7:b0:137:a3c9:aaa2 with SMTP id hq23-20020a056a2096d700b00137a3c9aaa2mr10921555pzc.30.1691469275697;
        Mon, 07 Aug 2023 21:34:35 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b0068779015507sm6978787pff.194.2023.08.07.21.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 21:34:35 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: [PATCH] ntfs : fix shift-out-of-bounds in ntfs_iget
Date:   Tue,  8 Aug 2023 10:04:05 +0530
Message-Id: <20230808043404.9028-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added a check to the compression_unit so that out of bound doesn't
occur.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
---
 fs/ntfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c3f38d66579..2ee100a7df32 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1077,6 +1077,17 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					goto unm_err_out;
 				}
 				if (a->data.non_resident.compression_unit) {
+					if(a->data.non_resident.compression_unit + 
+						vol->cluster_size_bits > 32) {
+							ntfs_error(vi->i_sb, "Found "
+								"non-standard "
+								"compression unit (%u).   "
+								"Cannot handle this.",
+								a->data.non_resident.
+								compression_unit);
+							err = -EOPNOTSUPP;
+							goto unm_err_out;
+						}
 					ni->itype.compressed.block_size = 1U <<
 							(a->data.non_resident.
 							compression_unit +
-- 
2.37.2

