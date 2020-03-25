Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1480F191F91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 04:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYDLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 23:11:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27927 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585105908; x=1616641908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qM3lSY4QNqQvT1Jbi+Tz3leooBMmTUQVq1mj6DxU704=;
  b=DOZtcAzmq/2KNlkl+bVJ9aY9UW6VSYx+hdRp327WvTn2SamWweU2dzt/
   qFtWr0WGA+PIuhCtQNlRUmOR1YbC8EZwPaW7MF6yeSbJ8nLhq6ArDHIVR
   r/CFU+io4+v3u1b/tOle25sGlKNPeSbGeCf8ISQl327a0gwjD/uGHrwyY
   GRYkcotwO42uGqhQl0HcsdEOC2NS8fAWa4JIXr8QJeyghmIQjhl5XLhkM
   wh8p7BFRcWhWlobqIJ2fapdVAuGMOhdt42N7/J7ck/aNS4pYKZElNiA3d
   B5bxoe3Hvned1rU4k/gsPtGUQFlhBdrvpEUfkWxqpA6/O8Auy8vQ9yCHm
   w==;
IronPort-SDR: 6rh8lF7ugcPR65pPq9IE9bSgrNuFSXRmGAdx6MzXS2xPdfTMfzBA6wJpDOlgMouzo0AvevWUuu
 0jJygbzMripaJSQ2h/P/j3YR5lG7jzXqKuBmEG0ATCA0ZtqRqCZ91tqPOXHVBKfI/rV0EGnuw8
 9RggfGKg+/Mx7Y9dPeg6XK+Q1nZKUUgEN0DwFJBur0Ejym+lpaCAcP49tQmT5JmnckmjbJcbXz
 Iz3GtAiLpqX9b/Ak1zcEPivvCt/xFHZTrpk6obP1XcmLCQEHCOTxcLJuGwkx7N0Bf0ggl1Ici8
 Ju8=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="133861392"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:11:48 +0800
IronPort-SDR: wnK6H27IlocAAgW0PxS3Fu6F2R5LLT2LVFSj5Ux/xACgU2YgNvlJUqmcA4gft+pufdAay9Les0
 D/al64rf6nepymi3vg1HIstbEiHLqC7TJNyd9dK0JJ+z7q4NUQLBSJGEInypohtdVtzSEws8pE
 zInnvKVm/Qk87vS8oWYe9FeqScDU5MsthrZ7/JByDVuA1bGXkSaU4mx5kaxTYhnG8k+fxqckLZ
 sEdnSuoAxL2BuIba8EoUK2i1uKTkwrl430d0UTIL59K7a7DpvO0Sivy8OD0hMdvz//AVL3rxdb
 qrVVja+2BQaY9AWVfw8+2Jnf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:03:26 -0700
IronPort-SDR: f7zISp+bQbxJ0mhqNAk+9A1vk4QVX9rATRTRb2TK3mQc5b49TqCKhZRKOQ4lHbyn4bD+jJWUld
 7UKmvZj13HPkoBOTOQ28cNl+TnCdPIeKLqBuuU/6jWhJxhzrLr3LX4eVVuv48Nnr2gwJwIUJQG
 KQs+8iUkSKoPwWUJBzdfDxksg5bJJJz1ekJePdZLeieyER6kZhDEjYbYbDDQ9nIgP/69jVxXyq
 2f0v/zDttZXwSf6iELOuroaeUWQCax5QDU93UR+qYqVJCQgmX0ekueopWau0YqhT2uygUrcj76
 BbE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 20:11:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.6-final
Date:   Wed, 25 Mar 2020 12:11:46 +0900
Message-Id: <20200325031146.289311-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 0dda2ddb7ded1395189e95d43106469687c07795:

  zonefs: select FS_IOMAP (2020-02-26 16:58:15 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc7

for you to fetch changes up to ccf4ad7da0d9c30a962a116cb55bcd7d8c44b0fe:

  zonfs: Fix handling of read-only zones (2020-03-25 11:28:26 +0900)

----------------------------------------------------------------
zonefs fixes for 5.6 final

A single fix in this pull request to correctly handle the size of
read-only zone files (from me).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Damien Le Moal (1):
      zonfs: Fix handling of read-only zones

 Documentation/filesystems/zonefs.txt | 18 +++++++++++++-----
 fs/zonefs/super.c                    | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 12 deletions(-)
