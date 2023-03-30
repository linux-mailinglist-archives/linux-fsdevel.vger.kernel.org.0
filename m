Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611326D0490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjC3MWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjC3MWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:22:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C4A268
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680178923; x=1711714923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MI/owUclnjgKsOuhU0z+lhGTWBPR9h3ftC5077adJ1U=;
  b=jo/bKrPQylQSKmlQHU83XEAnGcft+fw6xQC7hmHTO4U67YoDqZuhIGw2
   MgimYNqMuww5KY/JHYlnuhfFD4aXMJYqhsLQj+DoJAiZTAx2p5Hbw4N/p
   koM0eJrYpSBfNtr31cm6WotCZw5neaX/KO7M7+QSnqHalR/r8AmFT/0Ek
   smqRS2zQZjbOxmMvceDPH2DILRDEZoJNy0J9x5SHB34VCceZiml5FAfay
   Hvk+4XC82eoK+mLwjoDMnJ3I1qTmjjykER/+7xyNJjWWwqUpRjM57ru4k
   E6ZZDN4WKKIg9xmQt8EB869/3R9L6L4PUIQXdsZGsqP3FZSUdAXRzn6y4
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="231860024"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 20:22:02 +0800
IronPort-SDR: AkEgpKcsX5r4D6SW7PNepI+NJq1CV8bkSrdv3u/KbZ9NBWC3Q/03UiWK8C3XDBU5CaHNxed4+B
 FB834jWKpUwXRrnOiS3a9NZMIsUJ+i9dR7QjtufN400MVNI5l2SLUtvkykbkaj+H5HL5kI/zvV
 d/yXFBuKsiJczGIDCwTCrAdGdwcEf9IkHzZ8jIJIAiFZJbkUOZX6JIc5/Dzxh9eFr2VMPNnxuZ
 +MreOHpDcJFDL9yv+AlCfG12JmqkCOpVn/IPOL6Ae7xkIS6CiTcTOMle7FyX25vkh8HgZ+9H3q
 WT0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 04:32:30 -0700
IronPort-SDR: y3AeMQrn8VeYeWHxvvJOu10IwPw4OGxvPVcqREeJCJ+y87z/MCxNGOONFwH0Tc5x4cfQXrm+2p
 nqXkTA2Ajmnnygjz/fMgncyFti+DgXRo1/pjCbQEEwsf5o7MrycCKqGL4T0LYG4XkAsMW2fnMj
 C4GHNGUuWHgpOW3W7qJbuC2blgtJyihjdjfd74zLVbhy6eBVUzImszvNlvHoe+3ZNT2Cp5tgmP
 Jt389h8LFNzpmrmjKGMdij3zPhPVIAaRRtjWfLO/0WZn5ERh38SJKlqxqK5KZtIxX1YRI0lunN
 cBY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 05:22:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnMx64bWkz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 05:22:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1680178922;
         x=1682770923; bh=MI/owUclnjgKsOuhU0z+lhGTWBPR9h3ftC5077adJ1U=; b=
        Jez+slpxbRJvPMrg5iVWIKOx1iyltL+w16RUIhWPjTFeEX5LMHRdP7xLa+9SlrlE
        nhtBTo592FeIgugN/4IjZN9MA5RHrZ9Jf43AGSDahhVkegUe3z1XaxGaOoSl6MUY
        9jJ/vFKe+NfsD7Uq2ZgxyW5GO0hXxZsIKH2pO1m8Y9QcJiPXq+1I/hqQFMAzDvv0
        iG/csKLkVlQXyloSUMsdsk/YwN8vASQZj1niiKzL+m/hWpoDPzVdlZrn+Tbb37Wr
        oQmJftRPHEUqGavOyoytl4ZOtaz7Of5NE4SJQ8QrFainfYmYGOLfFWcfdhKaTO6+
        lKxnpqH61kGzq1JdyyI9Cg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HFmuHLW4i_W3 for <linux-fsdevel@vger.kernel.org>;
        Thu, 30 Mar 2023 05:22:02 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnMx563Ydz1RtVm;
        Thu, 30 Mar 2023 05:22:01 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.3-rc5
Date:   Thu, 30 Mar 2023 21:22:00 +0900
Message-Id: <20230330122200.2663128-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292=
aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-6.3-rc5

for you to fetch changes up to 77af13ba3c7f91d91c377c7e2d122849bbc17128:

  zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space (20=
23-03-30 20:56:02 +0900)

----------------------------------------------------------------
zonefs fixes for 6.3-rc5

 * Make sure to always invalidate the last page of an inode straddling
   inode->i_size to avoid data inconsistencies with appended data when
   the device zone write granularity does not match the page size.

 * Do not propagate iomap -ENOBLK error to userspace and use -EBUSY
   instead.

----------------------------------------------------------------
Damien Le Moal (2):
      zonefs: Always invalidate last cached page on append write
      zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space

 fs/zonefs/file.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)
