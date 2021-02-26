Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB932602C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBZJgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:36:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36886 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZJgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614332196; x=1645868196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PO/xiueYIa1AfvbL+2OAjCVUgROFhH0Saq97eSICpCY=;
  b=kZY9oIpoorvGGyH7T/W9mHb6XsLDH6kNVbgpbokCPEMcO7hHlSGh/pg7
   iM1JE0flyEkDTkn/wKqb/eUeYkrhUSnb+5GmEOAGU8X6SByCsu3urodAw
   On68iTAj0WJfNfjMjuaEp2tSQep7u7lQUMhIMop89WB/KhuwKgPR/JBdK
   TsOZ2I0p9FBXTcJXvahp5htgZFlIBueU2CsWrtYRl5ETRxta8sbLkiliH
   ThPgk5uOfzhtOV0A1jBehPD1U7Stxn9lAGQsHJL1CQeCvemwcGywd/qcx
   mKk26UKD42S1AhW7oU4ILwzHkyGiCDN2jFaF0Ahkf+LAq4Bacw2SjtdX1
   Q==;
IronPort-SDR: ONPm5BH+EVTjfp/4jlr80f0IJ06ff0WOTu3V+EdkVch8VTOOpvMd301BjGQ4W/DuS0agFNscQi
 3QJjzrubjijJqNAyJqXyyh3YO/9mnCbq//42Mji7iWES2JhtwNayfkSPsLnlrRNa2ME8n7Mu1s
 hEPoAlBlTWYiX0MtWLIv1BAB094v71WsVFf8qGJLWMpALUhRjiBcb2dvz9SCfncY/pGsHq1Xud
 I8aDSLP6MlSFPE4q5Q/ZqYMMuWyQZYAr3AOw53hPh1rYGJgpWeczdJ2OIUvOkpDQzlAm/DRuL1
 ogk=
X-IronPort-AV: E=Sophos;i="5.81,208,1610380800"; 
   d="scan'208";a="162045389"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 17:35:31 +0800
IronPort-SDR: bEgSHSKzUIC8IPToUAHH7hX6AUtyyVJpOUm+0+lKOw8x440LJFWPjfHLlU4Zu3QSgO1hTJuuEt
 D7AEZqM+NqTN7KmhotN2Ys2PMgtE4B/y5Aand0yW9IX3cv7NU5M9iB6HPfhctzgw3zcFQJWKoE
 sGrdEy9No4tSn2dgZeam3+/9dAG7stqrm6FBILT/bRCJ/dTF0SzDncg3kPdfMExlnS5B9aFSjM
 1JNo3sd1+yuZWddeu0dgTJRdxwmwah+HaCCFqNCwbOjSKQMs42BMx0KRoIzKEaQTwr17bP2eyN
 fnFJ1t42QaaTzU1RPpFO9ziU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 01:18:44 -0800
IronPort-SDR: bzj4NkJVlAaTP6rv5BvOg2APHWMBZjAHxNvr7hZr7mIUjQSfZIlAzw06f2tX5cQQHpbAVq6WzA
 PrtdfYFcLhXXrYdwJVEFPw4qy2kMGFt7WEX1kRmmNvFbXu9fJ1G/JBTHNDJi8Js9TlIIsKMuTa
 Tg62xp9GQdYq3lzpGvAYS1eerprB28PuSMOcxPdgatCQAtT3PY5ei6E54c0EiaTKApKQyoCajF
 vgoikCgNiuqqQef0FK99qIENpC9JIg4GF4fonjpsibNKeDFFp+3ntXZH2jrw41e4Nj2bd/wEEy
 8qc=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.63.216])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2021 01:35:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] Fixes for zoned mode
Date:   Fri, 26 Feb 2021 18:34:35 +0900
Message-Id: <cover.1614331998.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are fixes for zoned btrfs.

Patch 01 moves the superblock location to address based. Patch 02 fixes
type conversion for zone size >= 4G. Patch 03 fixes zone_unusable acconting
when a block group is read-only.


Naohiro Aota (3):
  btrfs: zoned: move superblock logging zone location
  btrfs: zoned: add missing type conversion
  btrfs: zoned: do not account freed region of read-only block group as
    zone_unusable

 fs/btrfs/free-space-cache.c |  7 ++++++-
 fs/btrfs/zoned.c            | 23 ++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.30.1

