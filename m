Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F72EFC22
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAIA3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 19:29:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29707 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAIA3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610152188; x=1641688188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wSinMeipgMMKxmH/1a6lg0iEXmDqQUS51K7NI5tV/sY=;
  b=gyBJHX7LcCwR797BxyJtfTlB7/xNAhyRpexJ0PZq7Zr+0UyV7tJVb63Q
   YENAZAskf5PBTqQp8y6wCb461l3dAgFNcOGAXcUThu0iEgWCTO/QYGyfm
   iVDcmeU6KDH1gMPQRuSwfR8/nuppqFZpy6oWwzfRqCEQ9VW3Tw9mhYCqw
   yfmVOl7U2w3CviZZjkj3VWiXF4cjRTiRuuQde72iqWhUeUzhRjTebTmHN
   7AGDS2VIVxwophQDjvyWHlWZf4F/UWasQ4uVQdm4bg7VYQxklqft2u3/+
   6PcU8YH8l3EfgLQV+++wJYBQT/EMYSD8EOCxE4lxPvsZ0tTNou7xhCzF9
   g==;
IronPort-SDR: ezlZeJ9oIDJ90sSVpM+RkLoYq7MyquAnyXctQ1h96gHk/Au8zLf+7YLe5BH2RTHLnx4qWu8Tv9
 7lqpMmp3wFzydlM1SSRCiWT1aQq1NY/XAC5xMW6uEx3rnWuqUamdbB9a0hrgWhIGlWJLGi2MvA
 9x3E+WpaW2QTUh0W9FeJdHUhEqjp7p4EzIwU5LycuW9S4y33yCDtt1+2cxo9dHt89soTaJqra8
 IBnU+67rErDGKHFaKF+DYqJHxkGKuv1sPNK0xbELsDJew+EZdBQYe5x5xoQeEaVszWivy6xpbR
 dr0=
X-IronPort-AV: E=Sophos;i="5.79,333,1602518400"; 
   d="scan'208";a="158165075"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2021 08:28:43 +0800
IronPort-SDR: FK9C7tkSTpjHQXLRVsoj+PE404IQpOu1qzaugQSc3i8mr5GxHbRR78FNygruOMa7yLo4+Hl5zz
 1aVuAwK6bIrQYxkNIjNGagoub84xm11sOqc1JC9LG34IvGdytOvsa4VO/r5rLDWsGmMIpBO24U
 8ESaaPhGHs66IFk6GhhN5jyabe7dbSNyjIdQpmphmTsi6XYedETY79yG3hQUjcJkhC2YfYDl1F
 xS+9466KQhJ06vGtrDfChOCPxzdzZ4fK1Dyjyl6RfsMbtyIJnCViXhg0iRLwhLJ5g/7TG+GSub
 FxYCXSjFmdn6QBWlJ0j2d87K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 16:11:40 -0800
IronPort-SDR: AeraTzhFJ39ZuxOqBTV+Yag1mMLmIalIWmE/zNLn1dBVBLwpLQ5PUjSpzUpVpJABbmGw8e2NLw
 3VM62SBvO3//LWEvExM4Thrd+ENU3D55ZEUcJj3VHdFpQ95pZz7yzrv8AoVptRnC3C9jUzqlIz
 u1QsFN6hd+c121SsODyRQzfZ/HlijCf2+yJ9yzGZaDSMEQtdLlUvD7asdVyQn0xTp9U+oZQMlC
 2Qy/6UM2zkM8ubC6wsytt2hNSu+M9UNn6dDCc96w/WygkCYog3FuolIqxRwbAFC0ssYlM7qa8B
 yEw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2021 16:28:42 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.11-rc3
Date:   Sat,  9 Jan 2021 09:28:41 +0900
Message-Id: <20210109002841.941893-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.11-rc3

for you to fetch changes up to 4f8b848788f77c7f5c3bd98febce66b7aa14785f:

  zonefs: select CONFIG_CRC32 (2021-01-04 09:06:42 +0900)

----------------------------------------------------------------
zonefs fixes for 5.11-rc3

A single patch from Arnd in this pull request to fix a missing
dependency in zonefs Kconfig.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      zonefs: select CONFIG_CRC32

 fs/zonefs/Kconfig | 1 +
 1 file changed, 1 insertion(+)
