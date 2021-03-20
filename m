Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9018434296E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 01:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTA1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 20:27:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5489 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhCTA1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616200041; x=1647736041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sg5xcL0RkzlKh/Ee73AUuPE+W4DNGMzOSE2MTxLLL8o=;
  b=LRK+V084HfmT+GPIfArOIcoXCnmTTxwNZFDsA5aF3qkFmJXHYKcoLfn4
   HLR36gMRZxBkVoG9jiccg/LQJHyVG9RvxntjE7UGM4a26jMwCV64nItdE
   t7GQZ6Rc2QStpwQHq5p7BjBx5FORAYy8qiK2nAx2c4zLRgVDIIFduxlTS
   02twAUvKXPER3vS02JAiNoszd7cBlg/U5X2PwTubXXCZDHN65ZfiyHt0b
   yMn8uyrzNrsYfMgxCpMndiaQCruR59wl6DRZIb6sPkZLoI6HSso1Fo/x7
   XOTSqSzN0iYypAnRjcxhtsfnJhniS1nnALTy1tAcizWgLjAb0NrjNVwiI
   Q==;
IronPort-SDR: 3so6ViqBZoFG2scmOcvB/oQ4t2PP7wxbyEm94yTKbEOnvmgNWt8rgxUVuKXzg9LzyBekIN1Jl9
 fBXjYcbq90CwED4OEQAu1np4S7F6QhTvbRxw1zWEqOdKVFflbVlmuteoV79gBMUBGS5OayOXkg
 O810v86moYMx6RB1CGBobbOsZE8jYaW10AL91F+sHK5ycRS5eV9fBJhARP+tUH7GXpdjeMGatt
 VzVbDF8Z7k1O9JvYRfdv0PYznm3udW8GGLP+cMVE1VoffqtnYggx8U7VJ0YJwXPtqYyIC4Nkxm
 Q4I=
X-IronPort-AV: E=Sophos;i="5.81,263,1610380800"; 
   d="scan'208";a="266993970"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2021 08:27:20 +0800
IronPort-SDR: VF1E4m7PQqbGOMcHnF60ZpUY1p0gUWJ8I0aoPTYq97nGDDklTHWZxNUFdN8nT9+uVr9dKWVjnb
 nXECf40NtSeDCoAmIw4YUStKbPM71Y/FpXiEE4ARchDaZiwzos81PbX/+r+TwkeTRICCVK9c6o
 qBTJRHtWImYlENqoNOcPOrV/06WCNh3m7IZN994CfXtqlbMO3T+2Dblz3+5FGyo3N5jbRu5Uk8
 /cxwo5I0e447amxtHZXm0Bukb74VKxfNawsWSwk5JiE/qXkEvUAj9mqrIRKc6p8Ba30oIKzPtC
 F11cLyYHqM/SbMWCt63fXMsz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 17:07:47 -0700
IronPort-SDR: rXIT4ZhlUxp3BMaB/9HEZEZT/mydUDepMmvNjaj6hadxRW2gXsrH6Qytb35Ad6VpbawYsoMah7
 /2VP/xNcYJD3VaHa90Zptnvb0qFhdUscHiUEgzQDDeaafI6YqMOQRK/r+NbG2HOVtx0pkQlJLO
 SNoxA2CxB6FDnasSQXdjAfft5qTyyxhGyYUCVEdQTdyqiRhfcpMM0ODlF2yO36uZNu92ndgdWH
 8lo/L3Z6EsOjneTm/O3xwTR5bhKJnUKp2oRyLU32RnAIsMm/ji/d6BEmlkwCyBLCEAk9VDb411
 peI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 17:27:15 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.12-rc4
Date:   Sat, 20 Mar 2021 09:27:14 +0900
Message-Id: <20210320002714.436286-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc4

for you to fetch changes up to 6980d29ce4da223ad7f0751c7f1d61d3c6b54ab3:

  zonefs: fix to update .i_wr_refcnt correctly in zonefs_open_zone() (2021-03-17 08:56:50 +0900)

----------------------------------------------------------------
zonefs fixes for 5.12-rc4

3 patches in this pull request:
- A fix of inode write open reference count, from Chao
- Fix wrong write offset for asynchronous O_APPEND writes, from me
- Prevent use of sequential zone file as swap files, from me

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Chao Yu (1):
      zonefs: fix to update .i_wr_refcnt correctly in zonefs_open_zone()

Damien Le Moal (2):
      zonefs: prevent use of seq files as swap file
      zonefs: Fix O_APPEND async write handling

 fs/zonefs/super.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 14 deletions(-)
