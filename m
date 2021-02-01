Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD330A39A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBAIxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:53:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56041 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhBAIxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612169594; x=1643705594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MRG2lFISjAebwXSuPbANGepT5pX0Ij8q1PaV2u3WcpE=;
  b=Ig6SgCBn3BLOmpY8TrJb19rW5YQj7KMynox5uYONs8Z0WqqBHJ7J9WKC
   rDfF7VpbHFQMX1qafZJQ0DYLlYu5hRBHOsz73EUnR3FmMlfK9tHy98Y+I
   BcELQvkh8zKjkPiQQl2RBw7/bF4TieAVQCqDGcL8EL1PAcIbM0XsJrvBG
   LxARWG50v9+WAqIZ3wihUqfJec0zRX1dZ/stYTInoZMmcU7kFrSV0VHZI
   tZ5LDWn2IoNfFPRkfngeS9gTqWRr1h4lCOuBLVkZDvIL/df1nWWZjTuHW
   vxmE2W67vF9rRM1HUOuIyeyhCpOcNwiLw/pilEjiNSE0qmb0eXoAW/RZ3
   w==;
IronPort-SDR: ZMEFtwlHUPURmKfMJUITpNdi8qrXdtAEAeuqUl1n/2S6ggmOIwGkPTqTNopFChx1lUddm8pq/z
 +v5NCfl/17yB0mfMlIIlVreaEFp92AXzpDZSVVsIjzznBBZBBW1XP/mQpd9lWrKgp0XlQSoNng
 A1QF+qcEEnXuT4RAtifALi7QBi4Nce1MgglPeVfzMaw/I/pjzg7bK0RoVDWAj4A+37lLpfa+mX
 aTV1tEk40RwkrV2uMH2P6vSnA3RtP2XQCnwwxAD86WA706ptjnR6ukBnX6XqjmJiWsntcGYjrf
 hZI=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="159979478"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 16:52:08 +0800
IronPort-SDR: avhj0YdQluF+i4hM2i36lnuVlP2mOdB1UWh2kO8d3gm/chiEE0m7VEec4qTScrTx/qWhJxONJy
 30fZ6eCyzdNpOtFYENO13AN72MFSwfU+frV16Q+dHzNN2tHp2UOcVQJvAasAxzQJkH3100Wyba
 bJwSQwkZB5oWEBjqYAIQ8PcQD7YPd01TMMIdZqbT6lL5p02V2P6z1yeGBzCAkjjaHANSqqj6E2
 kuwrb12ZUEqawl6bphg8IRK943d9bVtVQnisTsNiLeRz4UewfG95Iq99fZfrV+KX32qC7NcjiB
 hLfvdQ3fKoJ0ZX2xjycS2Flt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:36:17 -0800
IronPort-SDR: Tcp8OBCKBKqIAxY8EC52MDJGJ4EcqN4gTwNuXu0cgf7QBHMQwfjO1fum6IqfIKqTUx+mp4mhlv
 EF8nCGj7hPnKVwlC/3vwFrsrQHLRoxjVXITJXe6Ha4Zsxdx+iMM/iHpqxYHZ5i4wLI2WThnfiZ
 mSMSnTZg1IgNSwvhE65atWs037YtrsmKJaXq8OL/5AnPBnksAiEj6SuiYr0gXKFkXhsD/6iCJp
 fSbRYSz7d7nDYaW2XcHw8fR3XxsiTnW/G2seruvYnWkhJaY1xu+dEeMDmxG4J3bOd7hqwMVXQf
 ZXk=
WDCIronportException: Internal
Received: from 7459l3apk6t.hitachigst.global (HELO naota-xeon.wdc.com) ([10.84.71.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Feb 2021 00:52:05 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH for-next 0/3] Fix potential deadlock, types and typo in zoned series
Date:   Mon,  1 Feb 2021 17:52:01 +0900
Message-Id: <20210201085204.700090-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

The kernel test bot, Julia and Anand reported a lock incorrectness, a type
mis-match and a typo.

Here are the fixes.

Naohiro Aota (3):
  btrfs: fix to return bool instead of int
  btrfs: properly unlock log_mutex in error case
  btrfs: fix a typo in comment

 fs/btrfs/tree-log.c | 1 +
 fs/btrfs/volumes.c  | 8 ++++----
 fs/btrfs/zoned.c    | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.30.0

