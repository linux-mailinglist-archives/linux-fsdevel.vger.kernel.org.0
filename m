Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B066413D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAJNIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjAJNIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:35 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039858323
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356114; x=1704892114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZMVTtHCYlf2fLph00pi57kzq7npznS37BchL98+gdVQ=;
  b=R35lBL9T/iMcMXwWC2clpEUt4PyI6HVCSv7isuMFDWi2rxOyJp/k1MYG
   ds3JHsA2twReuFef55HOWMxn8gv1T59iQODIdYHjFvE7VkDrAwzEbAN7E
   RifZYz3AKxwPIuKyuxCUoyRXPLiqLun+H8H4KUP8U6OReCuXzS/BMMc/5
   lxlVrUxm8rATLV2f7CjuxxmKe88Zanz73+6LtNJTZRsGkiznOHNe8JA4w
   eXNB0rCk7wItnXwSlQRn6NmszEGGHYO1BDpfJGYuzCLAd4dTJZHB9hSDQ
   99Z6u3DHAqh8G83jeN+rDnx8nGuvGSelH52kSclWy25n1j8ZQQBG3VVKD
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:33 +0800
IronPort-SDR: n06hbHXznxZLux0ZNmXYur3va1hw98vDpEt3LA5T/tjbYQafEafQ+K2c2ty+cy5Wyjh+Tx+RNy
 oHGt+0rNjX1Ap7WcgKaybA/PKN3093SDXlfZv08O8ns18T4lK8aCndgdhjNovRQr4az8scqAzO
 BO0T+bUGxYhuZQlJNvcuN8D5UVrOnNGAwAreVWK94mcXrI0Ey7QGqwaUx1kLIWIWBuqUbIayW/
 X4po2ejmqBK7LYt8mqTn1grJnhnZhfnl3KCGagHoQAZsOwwYjIwudA67/BH+O8limAZ2r+UZZi
 jYk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:38 -0800
IronPort-SDR: XJNw4px3PmRD0qNSMoOaxh93y+xKpr2aX+kY4J0E0c2EhQM8+/Sz3ru8ggZ2TrIXn8oG+jXiKF
 eMIxA7900UWJa24wKvDlLX3CDqDSK/U1LkfrBRJzf4kvo2Tw8Vmd0M/ztIpq7eoir9cGREU0gO
 jlJAMmppA3iAeZIOCe1WTJbxf8m04EYfzuG0et27CneyWc31CSEL9HoF+QjiTMqR9G2/ToLrEV
 BFQqyjAaAv8l3PGJNL1tnnPbZgEXWCdAqG6OD5sonb6MfytphcZvWR0xqXWaJravkxWxAdUDKo
 Z6E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjF1X9vz1RwqL
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1673356112;
         x=1675948113; bh=ZMVTtHCYlf2fLph00pi57kzq7npznS37BchL98+gdVQ=; b=
        mxyXuoFpK5ZA96U31WNHvaKe4o8zkXU/WEzJpHubbCeEdcvuos2rnukWM6Xce3b9
        57u7WEcUD/waG3DPx45tVL9jCH0bZvUa3dX39cJtjVLGLkheO3DI2MTkS+xK6f33
        WTvz4nuhVZoucHu152t7OMmVigYjL+/CUEx2XrPzoWEBdlqsrC50jsKssi5fNAlL
        HGRFbcJ3fuO70+WpxYURrusjBwKnBCIWpYoF2NNFMFzxb20Qryuj81zIgwDEDQV0
        1mYUkQDv5pan0rsJKktmRFLZQmUyAC/rFglrTBmbJ4xIsMVEv1nAVhMusjy8Magb
        L5qdsZZ4HxmRbGP6ocV9sg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iRjDzZaTOU3v for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:32 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjD1gSRz1RvLy;
        Tue, 10 Jan 2023 05:08:32 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 0/7] Reduce zonefs memory usage
Date:   Tue, 10 Jan 2023 22:08:23 +0900
Message-Id: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series improves memory usage by switching to using dynamically
allocated inodes and dentries, similarly to regular file systems. This
drastically reduces the memory consumption of zonefs when the file
system is mounted. E.g., for a 26 TB SMR HDD with over 95000 zones,
memory usage is decreased from about 130 MB down to a little over 5 MB.

Since zonefs does not have persistent metadata of its own and relies
completely on the device zone state management, information such as the=20
zone write pointer position (used to determine an inode size) is kept in
memory at all time, even when an inode is evicted from the inode cache.=20
Dentries can be trivially searched for and created dynamically as needed
due to the static file tree structure of a zonefs volume (fully
determined by a zoned device zone configuration).

The patch series is organized as follows. Patch 1 fixes a problem with
synchronous write error detection and error recovery. Patch 2
reorganizes the code (splitting out file operation code into a new file)
and patch 3 simplifies the IO error recovery code. Patch 4 and 5 cleanup
inode zone information and split that information out of the zonefs
inode structure. Finally, Patch 6 implements dynamic inode and dentry
allocation and maanagement operations. Ptch 7 introduces a small
optimization to reduce file open latency.

Damien Le Moal (7):
  zonefs: Detect append writes at invalid locations
  zonefs: Reorganize code
  zonefs: Simplify IO error handling
  zonefs: Reduce struct zonefs_inode_info size
  zonefs: Separate zone information from inode information
  zonefs: Dynamically create file inodes when needed
  zonefs: Cache zone group directory inodes

 fs/zonefs/Makefile |    2 +-
 fs/zonefs/file.c   |  878 ++++++++++++++++++++
 fs/zonefs/super.c  | 1923 ++++++++++++++++----------------------------
 fs/zonefs/trace.h  |   20 +-
 fs/zonefs/zonefs.h |  110 ++-
 5 files changed, 1684 insertions(+), 1249 deletions(-)
 create mode 100644 fs/zonefs/file.c

--=20
2.39.0

