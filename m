Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838195426AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiFHGom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiFHGEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:04:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBE25B060
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654664348; x=1686200348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5MCC2NCfizAc51KKnCPh5+tZCCgO8+U9GNalsixgaXM=;
  b=hh9wGaj2PyiWibwh/5CqvBTRb3yzeSYDSMjFBofbPUgcNI0vnNKDnzb8
   mxGU4klkZbblrChkVHLP+PtIQbs/F8E4g4ROei3XlSS3He3XYTrzmeckN
   mG0q3f66sFhjZ8Z7Yi6d6akubAl6lKZ9NVoAvOF8Adl0WlcJnKL8mvr+v
   MzhlxTipPFyG4qW1pqvCLbH6Etu7ThTKpcHgpNBsLKagRwzwdXSuOJ5Il
   ImxX91z/fECgSoDpyxZlmKoXy46YIvk8FGebpfFPOnv69BxtlL6jCnGTM
   AmPfaABxFYQofGfuPRmZAMQjdKTLjy/c1wZB0wwM19lfiDEqj6LFviKwI
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201289624"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 12:56:31 +0800
IronPort-SDR: TCxifgpJkh2JVry2BlA3R5cJZY9zMXvwycCc7jS8s4HF5kQWCRRlj2oFKFFOTKEd9HLVhbqSsN
 2vu8O5xi2UCBqPoucoAihjgGkt1S90Ao36/iYSZvwbb1MosmyPOoYHQhnT3zj7AYYqxIhj2/4T
 di+C27khMagOPytHCaLMSFpx14182MPmzh64OmW1v27Mydd8Pb85Bik+OYOpNRxw4avLWIyVZk
 S5VBDYuG3KNdpiZRldllOJJDgZT8OgX4bwyRO96IOWQvOBX5gEsY3ImcNpbXdRAIZLwl+uQ706
 Rw8fab1q0JYKdZgVoX4oX2vL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:15:20 -0700
IronPort-SDR: Fjjh9QmasPdBRAe9PIbhubQy9e8GWmzITCb5iJUarrWVHAG+AhxQhDJmrt6zDYV229sJz8LhIS
 scRgDLtXR4kyacMbzmWoyVUxMg1GHiG+sX6qnFrd2oySpisEue23mMnFvVnegkyW9Eo9Ssg9XJ
 qwLAgTKj7N3Eham6xg+sGDIYsrMg8eGYPDOGlvaj5ZZbhnIketSHqLlGHg67PNA2G6APm10f35
 Cqt/Y73XutmHYN8RXPNTqDnBB57tS1ZjlU2jnTLGCB+kD3fWDfQw6aEjPVTNDD+u765IZQTicU
 zEs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:56:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHw1C0QDzz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:56:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654664190;
         x=1657256191; bh=5MCC2NCfizAc51KKnCPh5+tZCCgO8+U9GNalsixgaXM=; b=
        NVeRIfhZfwh4tj2B5FIbIv9/WOHkC8MgAerJBKILeHzXr0pM7Gb4UpRdG4LTPjgu
        kpTWRMkxO7OvrEDJnEdDAyqUQ6PLYiawmGpHq1DYT4vOia877poXq8+bGJawQ8LY
        c7xCvyzJX80iADT7Sd/na7Lse9QO6GeDC8mzUkiCE6BVl1PyjItnvnwfT47Oosfh
        3Tm2ZfjU9Kg3/GXnmqlo9zB8iTeHVaZt62JDK+mLxJIrjfVrb15DXLK3BVmiIOa5
        33Rlb8+Ibw7hX5W38GTpm/M7YKuUANUX/XEkeXypcErSwFDASW5gOrzxYVBDw1fC
        GqdPMSFxPkT3wOfEWquCIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HPvsQSJfFAQW for <linux-fsdevel@vger.kernel.org>;
        Tue,  7 Jun 2022 21:56:30 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHw194ldVz1Rvlc;
        Tue,  7 Jun 2022 21:56:29 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/3] zonefs fixes
Date:   Wed,  8 Jun 2022 13:56:24 +0900
Message-Id: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

3 patches to address zonefs fixes for bugs discovered with an improved
zonefs test suite.

The first 2 patches fix handling of the explicit-open mount option. The
third patch fixes a hang triggered by readahead reaching the end of a
sequential file.

Changes from v1:
* Added review tags to patch 1 and 2
* Replaced patch 3 with a more extensive cleanup fix.

Damien Le Moal (3):
  zonefs: fix handling of explicit_open option on mount
  zonefs: Do not ignore explicit_open with active zone limit
  zonefs: fix zonefs_iomap_begin() for reads

 fs/zonefs/super.c | 111 ++++++++++++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 37 deletions(-)

--=20
2.36.1

