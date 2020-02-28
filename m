Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5473173269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 09:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1IFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 03:05:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4968 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgB1IFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582877153; x=1614413153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6PjcQdOtie0dSx+BLWRxFWYVr63yvtH7J5uSDKS9ulc=;
  b=KHQiMOHKhQOmcsqHMulUfNNA0x1STwyFsQv0ECvypuIq7qpaisB+3R17
   +9ICyRVVlacpMfmXTNs6x4tMKr/ggum29IsBdj0woxcUrH1EaGztOCKJu
   A3FDny0u8Ff/HfecGtal/ahlpJqmpIFYDO7KVViGFa5hrxg8p252rVjbG
   KT4ViljC1Y1Z7HMo6Sda90jtmlcODQr50O1g5+yIQ8JWr8ie8sXJDDAKc
   HzL6+9k6tedi2cZFu+w1lnxJCq6cAHrTPIuZzpXLlee0RM1aYakETvuvv
   G3YDyg4lrXjUnE+JTgdBvm7m61EdpFKhg94eR2uy8zi7MGGg6N7WASQRN
   A==;
IronPort-SDR: CrfHzLAXrE6fnqdpqAgWpVhK3ExquAvoGbhJU4i76kkVhUrjjx1Cnua0nQvUsdNWErgQSt5udt
 h721JGuGhDc89qquNLVvsvRb1EC0stSLTKb7/wacswBSr32TdYpw5drAeyKO/ENeFeiq9hO9B/
 +uhg8X9ycc9F0qgnpzK3HVy1VP/SVqbMoXnuUAKqef1SXp7uVwHJ6i6VsSWgGzjEM+Z7LAfVhi
 m+QpyKWILkG68fiqZJwFVjDYKTrOh6wGONAm39Ltl0zH8RdiwivZPWz7TUjB2Uz+BNFgtY6ZgD
 AbU=
X-IronPort-AV: E=Sophos;i="5.70,495,1574092800"; 
   d="scan'208";a="239156865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 16:05:51 +0800
IronPort-SDR: kSeUgbsCyIeBirdCK4aiiH37X7LUIuaEI1SqOJtKmJD3O9OAGXqlOVYjq7fWgE4khv4HLm7TtH
 gwOe5umJNp3lZ510vfoST2KatimCae9LzpxWsSdhDWYMFwY0KeMUJ+oR1Nns3r1bvY6VPjtI8W
 pjMBdx4G6Toars+i9PDTFv34woQpTiACcorPgG47TRzFLfiqLG6tdQ0nLr/Ad4mPqCClcGE57l
 aLiKhYOAx7sv6zeK6guz+DsDkZw7ThJu7UBVAexmkWn95eKlVmVcT40tCFJv+W+GbROGMa73st
 32sAERIvFYO1+XjHMS9qIgGr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 23:57:50 -0800
IronPort-SDR: HvCO+tOiIzzKv1W19gRYKMn+Sgjp8V8ntV9Pft2N1rKQEj+cQUc7Wi6/qD9X1uLshS8r9Iv90I
 I84vs+SDTlYm+eLXfZM4lKwwWjbwL/hWv0g8WVnf0hKktK8rhZDgfpcPYtVbjE1tfy0VGbkvFk
 AVw1tqeqbjSF07x3AKvwq2HB8CCZvEv6H+b6c87aS1WShpl53DO3/0ov0k1YXpwwLEpJCce9DP
 PsgHTJZ7mLXDOY7twqat1LfYbXwRClIYx+JzzQlPPENVnE6dckq2npeoHolcmX658LuiDeeFyN
 R08=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2020 00:05:51 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.6-rc4
Date:   Fri, 28 Feb 2020 17:05:50 +0900
Message-Id: <20200228080550.229277-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 4c5fd3b791a06021084b42d5610400f846d206b5:

  zonefs: fix documentation typos etc. (2020-02-21 18:09:26 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc4

for you to fetch changes up to 0dda2ddb7ded1395189e95d43106469687c07795:

  zonefs: select FS_IOMAP (2020-02-26 16:58:15 +0900)

----------------------------------------------------------------
zonefs fixes for 5.6-rc4

Two fixes in this pull request:
* Revert the initial decision to silently ignore IOCB_NOWAIT for
  asynchronous direct IOs to sequential zone files. Instead, return an
  error to the user to signal that the feature is not supported (from
  Christoph)
* A fix to zonefs Kconfig to select FS_IOMAP to avoid build failures if
  no other file system already selected this option (from Johannes).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Christoph Hellwig (1):
      zonefs: fix IOCB_NOWAIT handling

Johannes Thumshirn (1):
      zonefs: select FS_IOMAP

 fs/zonefs/Kconfig | 1 +
 fs/zonefs/super.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)
