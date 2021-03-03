Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA4C32C516
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbhCDATM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11621 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356359AbhCCKrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614768449; x=1646304449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mwEiZukLHyEY2ZqMVPnhIRvP/i8j+blxwkBaWAlD3h8=;
  b=BdLB3jhY9JGlMxdaVMsFiLmQlqp/9Wy+Q2XR6TBSLogFooLrIeYmzBwd
   8GXhH6r59223FAonsxqrv1vPyZ38j8CJNUUwCaPFKn5/ogTcLX/F/haKn
   Ff1Z+X8bbrXWPB3zW+ELt4npXylAUZuFuLR6LKSqmuCmKDyqwJjkpH/Up
   Bsy0FU2C5FeJMMiVFJMTWGuoiHYAV0K3tJsNAy5RQTnRv68AYcNoewyEX
   zT98X+UHF6g9HKPB7XwWlsYMeW/+t1CZdtRgxUkPnA9blBwxZigy3QqGo
   J66WJ9MqsYhzQi5J6Cn8FW1li4/xk960GmYBN+vCvQThjCPPYbsYYgPZh
   A==;
IronPort-SDR: GMhT9YD1WD76abItvTN1e1oL7MNUdwxmTovajQwi73wuNEHPR3gD4G5cJehga0Hs5ArS9Wlp4Z
 HJjtQMtreLulIZg3HpbsLPhfNlYEl+Soc/0AvR/02ULGLPLug+aCRhjj2HZTLbUf3eyfy/w3Ao
 O98zE4Viz2x+ouA8bPDDcB+ytCxeZiOkDf885URhyZfKhHe7DWt7RV+Ht8GREsOs8zd9J7dzxx
 y4SHZ1DgHr3jJaR/Zk3e46hj71hqBaqkzd6hZHXQ4V8gvR4bbFGN4yesUaJZW2gp9iOJfOP1By
 buE=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271857766"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:55:53 +0800
IronPort-SDR: AddLnUUrq5azr3mgC7U2Tp6pWKAIC12ZVTG0Vand7w7I4pctdsPc6cdZ2oCqPluc7mXrJbeXMU
 G7jvzwOwNluXbitWm5cKx066vsjpu7XWlaDI3dDxL+VOvcPn1tRRJ0nFmJuYbtpEF31j+v36ke
 4rr6avz+Jfn/79vP7Ja5sMlGDS7CNH1t83HPsQDLExk2ASI1nGqlM2pHiF+wGCwBRQAnbTtGCB
 zY+4SJm9LfMIJrXGEoXqotaUmGAwYnVDxh83AdL/KUs/ohhh/a7ZBru3XalVAS1axZ+xh+gK6+
 rt/qwjlDqsNc5ZFfaNyhKgNV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:37:08 -0800
IronPort-SDR: YoLaA3w03cH6wzj6CAbcP0Hlp9WBCBlTyL04cyIb1ylgchy6S8nqJUE9nKICv2sWbeAOtYS0m8
 011zRhnrMZObBYejxOzjTM2GhMEJGfdB1X6ssyrK/HcRlHjgPd2tUdy9aWusw/L7t6LzpeF2XL
 Ng/AjuKMHKSzYdej9EQzh9a1iGZQheh8HsTG9iVVli2/z3iWAW2MVXDXq0zRnXC4AfWv6Vx56T
 1hYVH00SHRpRXe6TX1vSS7YM74412E3KLvoYNqvCkegaewV452roMUyRQqct+2eRETTA2hp9lX
 2XA=
WDCIronportException: Internal
Received: from jpf010014.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 00:55:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] Fixes for zoned mode
Date:   Wed,  3 Mar 2021 17:55:45 +0900
Message-Id: <cover.1614760899.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are fixes for zoned btrfs.

Patch 01 fixes the type of a zone sector variable.  

Patch 02 moves the superblock location to address based.

Patch 03 fixes zone_unusable acconting when a block group is read-only.

v1 -> v2:
 - Move the type fix patch to be the first one
 - Fix the type of variable instead of casting
 - Introduce #define's for the superblock zone locations and maximum zone
   size

Naohiro Aota (3):
  btrfs: zoned: use sector_t to get zone sectors
  btrfs: zoned: move superblock logging zone location
  btrfs: zoned: do not account freed region of read-only block group as
    zone_unusable

 fs/btrfs/free-space-cache.c |  7 ++++++-
 fs/btrfs/zoned.c            | 39 +++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.30.1

