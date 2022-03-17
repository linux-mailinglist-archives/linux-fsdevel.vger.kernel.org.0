Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5814DD147
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiCQXty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiCQXtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:49:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8A1A844F;
        Thu, 17 Mar 2022 16:48:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s42so8205425pfg.0;
        Thu, 17 Mar 2022 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyzclAfIr+1FEbAjXUVMbsyC4Y6KT1lKsbzt7mnyN1k=;
        b=B+POt2+357+jg0w3MH9VzPkPpg2huHa1LaNJSdbtOFdDBE2P3b1/uiLCzvO4mowKri
         M+JCXnJkM88uH/IGF+8NCbtX0ERJoEeYXQ9EPwKQohwD73STyK9TlLjE4LZXknrMgkgB
         nUB6CQyck+w+BGd2Q2zOvJQ8WySSa8Qd1Q1Y66mlYkLiybT1I0GyT6toTY+GYsaPjqxU
         iYmiIEBV62087RuWTv0hq5f0ajY+Ej15hcloLXZKdX7//4QCvGeX3Q4PKJj0RVUwuH1H
         89VDc+E+cnTvOjS2CzSCsABFiVpnKpYSmDv4+b+KG9pEMTKiiSafhVZHN5J8QRnZUFQr
         0rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyzclAfIr+1FEbAjXUVMbsyC4Y6KT1lKsbzt7mnyN1k=;
        b=o0j53uAIFRb+fwP8xPAj6/SDhZKh7MRP6GjSUv+69QqfzbiRFf1zbiMCAnM2qYs8RD
         /+CcwQewUQzYzHvosn2obp05WdzKLoYVq1iEm1frDVhuQZVbVlsEkZ0i9Onf7mbqrhzj
         O/+TcLwyttUgHYCXvco/PbrtdXLkWFPI0/LkN3Df2aH3AuzgeefwGcl//wrnT56aPy2g
         XKN490cpOhuZWAdut+SK9mjdHnqfMo5OLHIrVweaZFE9d1pNBnTxIOMUQRdiJ77jDmqI
         QF4/qW+mTUzH/WZQNdzBMHL92gTPr89VtEZoLLCHjMnesOrajdOd9g0qcwqNhtHXGiZL
         Ej2g==
X-Gm-Message-State: AOAM530RTjEUlkAwOxfqNt4kGaFnY7luPLBwjiODKJyR/i+0A+q+66AW
        8wt4GholkhAWTYNXPWKfhW4MwdavKDE=
X-Google-Smtp-Source: ABdhPJysc5kigtJLM1MC/aHUAOynsRRlp97FjWauCN2Z2NpoLEeaoc2CDwBJJfBhTRZVPCVjCAa+rQ==
X-Received: by 2002:a63:1b66:0:b0:37c:728a:e06f with SMTP id b38-20020a631b66000000b0037c728ae06fmr5594295pgm.458.1647560915746;
        Thu, 17 Mar 2022 16:48:35 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:35 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
Date:   Thu, 17 Mar 2022 16:48:19 -0700
Message-Id: <20220317234827.447799-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Changelog
v2: * Collected reviewed-by tags from Miaohe Lin.
    * Fixed build error for patch 4/8.

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But it is kind of "random luck" for khugepaged to see the
readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
  - Anon huge pmd page fault
  - VMA merge
  - MADV_HUGEPAGE
  - Shmem mmap

If the above conditions are not met, even though khugepaged is enabled
it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
explicitly to tell khugepaged to collapse this area, but when khugepaged
mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
is not set.

So make sure readonly FS vmas are registered to khugepaged to make the
behavior more consistent.

Registering the vmas in mmap path seems more preferred from performance
point of view since page fault path is definitely hot path.


The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
but I'd like to hear some comments before doing that.


Tested with khugepaged test in selftests and the testcase provided by
Vlastimil Babka in https://lore.kernel.org/lkml/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/
by commenting out MADV_HUGEPAGE call.


 b/fs/ext4/file.c                 |    4 +++
 b/fs/xfs/xfs_file.c              |    4 +++
 b/include/linux/huge_mm.h        |    9 +++++++
 b/include/linux/khugepaged.h     |   69 +++++++++++++++++++++----------------------------------------
 b/include/linux/sched/coredump.h |    3 +-
 b/kernel/fork.c                  |    4 ---
 b/mm/huge_memory.c               |   15 +++----------
 b/mm/khugepaged.c                |   71 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 b/mm/shmem.c                     |   14 +++---------
 9 files changed, 102 insertions(+), 91 deletions(-)

