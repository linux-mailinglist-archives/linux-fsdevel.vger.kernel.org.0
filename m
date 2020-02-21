Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FAB167BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgBULP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:15:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22858 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgBULP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582283759; x=1613819759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=smufDUIPUiHTXgrF8iMYKXeL2NNjpHDuXgKntwGXrow=;
  b=LDU88pC0Wr8P163NKDnY8oDrPMJwsljNmDxkJtMUIyKeJBxqlVFPn7nq
   sQjj/3fYa2WXUMvZOCEwCEmC4d0sHGBQmU6A+BopaXXAwThGeC+z+oDMp
   OaFBGDewyPKIcX099ElqGlSmts4k5+cnA3V9u3lzMq0vTAGC7LUUJFZaA
   hzIdLUIWj0OmnvesGyFLPoFj17SprYnEL4INjDEkUYc24h1YcWQLmvVO3
   s9lpqcSaZlPAwAK8REhWqDPC43EEZen5L4LjRdMx6pzJyXQi5GPJGkRan
   HGMRpvSj3nGZHcNg8jrS/bNZOZl02LtjXtB9wN2+uAx1iJl5LCGEqVPoy
   Q==;
IronPort-SDR: 3PSl+y7vrMh2206F1HXlvTe4rH76n+FUR2XQuepOIVYH4sxtpNxZqHPBjTPuVqPCoWgYt3IXFb
 tycu0NAlfK0XWJlPOvmyst8QDw/2Pc00+tKRiQ5PeXsZxEXoDoB4pDTVtnkKBtl2XpvqQWOIUq
 dB4LrztVDZXbVIyiwNOVzgX8y52P0ky92i3U1cQCRfbjqRcJKvncldqOusrVmTEURRFTghGAj+
 pm2J4+313AYoRUr42Gx1TJTAz4LbNlyhrAY8E9xEpTD67M5EDxuXnHcQdfrmIN77XWZr6w9x+t
 VBg=
X-IronPort-AV: E=Sophos;i="5.70,468,1574092800"; 
   d="scan'208";a="134746904"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 19:15:59 +0800
IronPort-SDR: VonaL4YWSfZbCSqTuJIfhZ05EVsKWR5uHkb/6fmpFmrRGZF95HSAn6AQ26CWX3vOO19Y/Xdw6Q
 PesuxHvqtzPfvNbN0Hq4PU3XF4IqHBfo94Rpn1s78aRKFSCHJCFVirEy9m8CrWNnyhzyBh2WdN
 EWyzDC2bEfRkzFsUlLDIvTm6RMVG2qXBnrHUrzpB4d4tFdF4ULP0xBQ+lRaQhB6WENatjiHY8B
 SStYNgw3WjVwnNGovcYMrq0UPU8wTgPlj2nnXH5TylFgQcqXFtugudM+4osKZBZ2/fQ/5o4HaB
 z7MH2S15EltAI2xAqtsckmB2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 03:08:33 -0800
IronPort-SDR: YvFgsuz8G/bPmgWtPlYUGjZZsCPf6sCT5OHOdcAWExyrk6pipcKzFZusQ8+0t+GqKp/LUR0zHE
 s/t3l/KSXQoHJczidLLVmaHYYYrMEjauOPt4AZiV/gF+r2TUlHwxX6tckjqP3o4SUl3qxjdUvE
 3ELuQ2FOrB1TiOPRZ24ZaLSeA2YwI+f/WWgXnQduVKc0eQMCzCpZNqZLlp5/xxKV1lmsDKKsFe
 JbP6pwY8/3ET3O30Nr1y54Hn/cN8mSHlWIpS9TUFrqE+ixWiUzeuWrLwP2DG92EUlPSD90HvzE
 jZQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Feb 2020 03:15:58 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.6-rc3
Date:   Fri, 21 Feb 2020 20:15:58 +0900
Message-Id: <20200221111558.9841-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc3

for you to fetch changes up to 4c5fd3b791a06021084b42d5610400f846d206b5:

  zonefs: fix documentation typos etc. (2020-02-21 18:09:26 +0900)

----------------------------------------------------------------
fs/zonefs patches for 5.6-rc3

A single patch for this pull request fixing typos in the documentation
file.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Randy Dunlap (1):
      zonefs: fix documentation typos etc.

 Documentation/filesystems/zonefs.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
