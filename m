Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256584ED9E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiCaM4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiCaM42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:56:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3788170091;
        Thu, 31 Mar 2022 05:54:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id jx9so23946246pjb.5;
        Thu, 31 Mar 2022 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8ueS+6eM6LzxmZNzgFTSM5N/JS9ols3wxxZjAjcXrY=;
        b=GXuICvc+jnGQmEnQIaCe7Z0h85RmrrE69OlQ2Ju+z6V7Qjmd8gNKH8se8DJY//otu/
         5EBatTDWRLe7CMuw1WsNHbhl2saj0blOrcubo/SEynKX5sbr5mDMTJjOF9bqfKl1kA6B
         BNttlKT2ybHgIhs6NIDNPicWp5ZD0EUFlydeBrYLZOj9ic93RWVm1VQttDXlRyjkgz9w
         fylan+mikAG2LchlVdCaOAM34n/SbsBMGbu7RuGuCweDcPOlVVz1XDmv1MlSYILe5Jmf
         B7inFMhEx0x/hLzIfrIsWDQvfzD/+P2UU6dsl0OpnYEXDdJGfQp7FiwXFT3AqXKYcmSa
         sw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8ueS+6eM6LzxmZNzgFTSM5N/JS9ols3wxxZjAjcXrY=;
        b=dFdNkTQcoKUgc9BdPDnkg4bq7xfe5Udok6TzRNzOjh9yUAzr2RghNP8u8vp+RFPlDZ
         FCdXxiIbpOM9j9lV8lPzQOxOAoWRW7mX6AECvJIjuth/qBqpAgelAPuT18n98P3zSs4C
         7+tHyekiADZblUntTqVmiOFCI+TDn1RUhIHo/8n4F7fGTT6coWnqoYJprmHBmJwOVbXS
         IJ4Sq1jDzfnl4ZBea8cXi3/5EFgs/WOUnLIusY9n/yS8h9HYchirOLZZ5WIH7bvIakPE
         c9gs8MHMAttQFlJh3+eTOqIJW/yDPyZ00QuchSCzCocOdTuMOI3x35fTywaZgEaH2jA1
         KwKg==
X-Gm-Message-State: AOAM5318NdB32Y7gxUNptTuUhK9/sRcxdop5KGu7z9iICwMnowbjX5pF
        dgsMSKDdai8JG1mTFqZZXQAuPE4/owU=
X-Google-Smtp-Source: ABdhPJx13uzzKnDWM6cNy3U/3LrcjPnOSeOBjZFtVGebXCttbZ5mKRU32TMnaZtQi5OO2A9DL8TnNw==
X-Received: by 2002:a17:90a:ce:b0:1ca:308:977f with SMTP id v14-20020a17090a00ce00b001ca0308977fmr6069246pjd.195.1648731280964;
        Thu, 31 Mar 2022 05:54:40 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id j11-20020a63230b000000b00372a08b584asm22203758pgj.47.2022.03.31.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:54:40 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 1/4] generic/468: Add another falloc test entry
Date:   Thu, 31 Mar 2022 18:24:20 +0530
Message-Id: <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1648730443.git.ritesh.list@gmail.com>
References: <cover.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

Add another falloc test entry which could hit a kernel bug
with ext4 fast_commit feature w/o below kernel commit [1].

<log>
[  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
[  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743

This happens when falloc -k size is huge which spans across more than
1 flex block group in ext4. This causes a bug in fast_commit replay
code which is fixed by kernel commit at [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/468     | 8 ++++++++
 tests/generic/468.out | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/tests/generic/468 b/tests/generic/468
index 95752d3b..5e73cff9 100755
--- a/tests/generic/468
+++ b/tests/generic/468
@@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
 
+# blocksize and fact are used in the last case of the fsync/fdatasync test.
+# This is mainly trying to test recovery operation in case where the data
+# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
+blocks=32768
+blocksize=4096
+fact=18
+
 testfile=$SCRATCH_MNT/testfile
 
 # check inode metadata after shutdown
@@ -85,6 +92,7 @@ for i in fsync fdatasync; do
 	test_falloc $i "-k " 1024
 	test_falloc $i "-k " 4096
 	test_falloc $i "-k " 104857600
+	test_falloc $i "-k " $(($blocks*$blocksize*$fact))
 done
 
 status=0
diff --git a/tests/generic/468.out b/tests/generic/468.out
index b3a28d5e..a09cedb8 100644
--- a/tests/generic/468.out
+++ b/tests/generic/468.out
@@ -5,9 +5,11 @@ QA output created by 468
 ==== falloc -k 1024 test with fsync ====
 ==== falloc -k 4096 test with fsync ====
 ==== falloc -k 104857600 test with fsync ====
+==== falloc -k 2415919104 test with fsync ====
 ==== falloc 1024 test with fdatasync ====
 ==== falloc 4096 test with fdatasync ====
 ==== falloc 104857600 test with fdatasync ====
 ==== falloc -k 1024 test with fdatasync ====
 ==== falloc -k 4096 test with fdatasync ====
 ==== falloc -k 104857600 test with fdatasync ====
+==== falloc -k 2415919104 test with fdatasync ====
-- 
2.31.1

