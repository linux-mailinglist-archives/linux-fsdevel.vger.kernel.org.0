Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535551ED9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFCXyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 19:54:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59964 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCXyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591228491; x=1622764491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/voAKbPJfRyko279AV3pA0ysaiEHLivEtmD58nV3uM=;
  b=MF20dZj1ZY4Plwd0wcpcZX1OK9L2WxvZaG3nYJ4azryd8rHISi1SXsOX
   8jjwZKjS7crkZ9MtVoR0L9GUff4xTHJ8abZhYBCYTLm0UWnf5sQneZn80
   wNtU+/FIAET9dQBu9wyUQ7QQju3gbBGdE8m+GekRKXUCuT2w86eHETWuq
   PLoC6EQWiGEI9Ux3pWIPI5rBlNSF9Bmyyy1bQxP7nh0zDgYiRhoWjkfjm
   V/iePPlGxpfCMlqYbz8dgZkYcnXvDBebL8nKGdAnoM+U8WVcDB32NSGHZ
   jCh8pCY+smzdRRRvDmAeTU4MWuDJF6mRVzjqrO631aA+E9PsX/o+H3Rgs
   Q==;
IronPort-SDR: NgsEFNldSqwkbzVsFIS4BxAyMhWEO3B7jXN6nBQ2y+77eIItiE4a445afDUtzIqxFhuaR3orsj
 d3MCGNEBjvgMXVQu5Ay44hfKdd8oHf2tdTVL/tc87jNvX29s2KpuJIuWI5w9mPFnjnFcERBlhH
 GzVMqIegZZ47fZo4MaL96oQGdwR+pN3wADqJev/sqGPWffYMf9Ae0YMhMOV8P6lIQfPnSEseuX
 GGolwLIA2dB3xsffqlrNK8mmzKPzwtHuvcFxsfu4K/HmoM/NaORGNWHHA1DyA8+lpdTW29Dzvk
 Rdg=
X-IronPort-AV: E=Sophos;i="5.73,470,1583164800"; 
   d="scan'208";a="139147151"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 07:54:50 +0800
IronPort-SDR: GNEv0JNha1tSlAKzbHsJkLUJWzDT+0fZXcFMrd1PGLoU7p6zHFBiF0OU554563Byfx7Vzaz9um
 4d8loLTOMm7mms+YxP+79sTHNe9RyEtcI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 16:43:55 -0700
IronPort-SDR: FKg8mvbrKUh+OQxdsUsrJ3TmS5+VY3gd0JDbetUb4BApuaWpJlkS5Pun3tNEr0Z2J2oAj7p5Xr
 T2cDMSCQY6Uw==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Jun 2020 16:54:50 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 5.8
Date:   Thu,  4 Jun 2020 08:54:49 +0900
Message-Id: <20200603235449.26207-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.8-rc1

for you to fetch changes up to 568776f992c4cb5e1b5715dc4ab62e6ae906b80d:

  zonefs: Replace uuid_copy() with import_uuid() (2020-04-27 08:51:39 +0900)

----------------------------------------------------------------
zonefs changes for 5.8

Only one patch in this pull request to cleanup handling of uuid using
the import_uuid() helper, from Andy.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Andy Shevchenko (1):
      zonefs: Replace uuid_copy() with import_uuid()

 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
