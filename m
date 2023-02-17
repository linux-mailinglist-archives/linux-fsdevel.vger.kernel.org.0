Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAC69AE4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBQOs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBQOs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:48:57 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979EC6C029;
        Fri, 17 Feb 2023 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676645330; i=@fujitsu.com;
        bh=f7RS4VoQymNw3nqGIM9aul8WyGrGip/7nYMdzgpTuhE=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=U5669r+xZfPHi/dyCrNEX9vQe9GHPkyJvSnLVcNNKQQI9aqQJUdP2bceDkTCLFnFe
         oObd+AyhEaaN/2ql8hH77bYIXpgwfZ/VUmaVjN0OnQwsjp1gs2Ymq795cVuRBH9A7A
         D0Vv30QQeIKV5svWHgWZi8/8Tu+TeiwnW1BjWqZojrVp8/+PhT1qpuFgi2OgIMysKM
         9YUbG2zbTkf0pTQG/HuA+BMXY2rI5Ve80jcXByHTN8FOqsGlMkIRUOsLPcSSwV38Ra
         O+IDdV7Jf1ErD3eqw3J6reOevUwqdGS/8dnbPWtxgKgR+lo4YldvETcxVboweTrEey
         B2Iidnxzo8UVA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsViZ8OxWffC5Pf
  JBtsWWVjMWb+GzWL61AuMFluO3WO0uPyEz+L0hEVMFrtf32Sz2LP3JIvFvTX/WS12/dnBbrHy
  xx9Wi98/5rA5cHucWiThsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTxebJ7J6PHx6S0Wj8+b5
  AI4o1gz85LyKxJYMxZ1b2ctWMVe0XbmK3sD41HWLkYuDiGBDYwSm87dZIJwljBJLGz9wQ7h7G
  OU2LFhLVCGk4NNQEfiwoK/rCC2iEChxIpTR1lAipgFjjNKbFm+iRkkISzgJTHr/hpGEJtFQFV
  iYvcjsGZeAReJe21NYLaEgILElIfvmSHighInZz5hAbGZBSQkDr54ARTnAKpRkpjZHQ9RXinR
  +uEXC4StJnH13CbmCYz8s5B0z0LSvYCRaRWjaXFqUVlqka6JXlJRZnpGSW5iZo5eYpVuol5qq
  W55anGJrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZg5KQUs77dwfi/96/eIUZJDiYlUV7DhPfJQn
  xJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4T/cD5QSLUtNTK9Iyc4BRDJOW4OBREuGdnA+U5i0uSMw
  tzkyHSJ1i1OVY23BgL7MQS15+XqqUOK/gJKAiAZCijNI8uBGwhHKJUVZKmJeRgYFBiKcgtSg3
  swRV/hWjOAejkjDv84lAU3gy80rgNr0COoIJ6IgFzG9BjihJREhJNTCVPd+5SVwgVtx8XtlE5
  csXfwUeTfox1cLNc+1lzoypz08VbfuwYZnO5MNP/jBIzIhzVpn7mlvELKLL9+EX60rPVVIRPs
  qzgvIedYr1ie8Pmhc9fY2tT9X0kilXRLcb371v63WbYYqpEc+eSm4Lrb3aPKu8I56fOBr4ufW
  QUpafnNK6msyq7gKNOZVnf5nbFMZ99dXLFS7tKrfoERA5fOOtSt3Vr1MPN6ktL4qIW/sn+2tp
  +5ld/g/DnU3lCwOYZ/rwLevbfMFT5LXtau3Nzj/v1R2RnuE1Ve2z7vOPNQ/YBKcqSqiKpZ6p0
  NCvVq+49vXITaO/+Ru/2cZfyAjkupux67fty3SvlA8VizfMiFRiKc5INNRiLipOBABj+k2cow
  MAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1676645328!167560!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3712 invoked from network); 17 Feb 2023 14:48:48 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Feb 2023 14:48:48 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 78A6D7B;
        Fri, 17 Feb 2023 14:48:48 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 6C0A473;
        Fri, 17 Feb 2023 14:48:48 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 17 Feb 2023 14:48:44 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ruansy.fnst@fujitsu.com>
Subject: [PATCH v10 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Fri, 17 Feb 2023 14:48:29 +0000
Message-ID: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v9 RESEND:
  1. P1: Simplify the assignment expression:
    len -= offset + len - 1 - ddev_end; => len = ddev_end - offset + 1;
  2. P2: Add '*' after '/*' to make it a part of kernel-doc
  3. P2: Replace 'void *unused' with a specific function signature
  4. P3: Freeze the fs before invalidate dax mapping

Shiyang Ruan (3):
  xfs: fix the calculation of length and end
  fs: introduce super_drop_pagecache()
  mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind

 drivers/dax/super.c         |  3 ++-
 fs/drop_caches.c            | 29 +------------------------
 fs/super.c                  | 43 +++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c | 34 +++++++++++++++++++++++++----
 include/linux/fs.h          |  2 ++
 include/linux/mm.h          |  1 +
 include/linux/pagemap.h     |  1 +
 mm/truncate.c               | 20 +++++++++++++++--
 8 files changed, 98 insertions(+), 35 deletions(-)

-- 
2.39.1

