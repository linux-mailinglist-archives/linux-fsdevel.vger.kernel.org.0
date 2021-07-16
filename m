Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570103CB1C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGPFJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 01:09:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34507 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhGPFJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626411974; x=1657947974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+RJetkQJAlujgb54/ncsbR/ySOohL1aLmzdWeK6uV5Q=;
  b=g+UkGkD+lodYx8TAyKGE6M3j3UdkHt58v18ZolKZCyI5qdGv0LtzHUQ/
   5ZNoFBYzb6Q4F4redYt9nTBZqTIIclwScHiyFhWy8vhCfmaNM8J0dsYJl
   bpnpIRnD4U7GJdrQUOvJmsn6QqQKpTgQtKlB0Qr+n3JjS6mBPHAHZU1AN
   iFW6VEBY5/WQ1VFJzZiNrilF7uWm8/6LtDpG/R1HPD1rPd0PYb2rNHFFo
   ZCqhPjqINOnTIS+TNrHeDTHKMacXuqJ39QSbRNDXW94uuQ+Vhu+9zLDtw
   xZiUyCGz3BB0tfO0Mk3UymgsRDBAmSLqIIkuRJdVcN4+YCdCbHyLgG7R9
   g==;
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="179550058"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2021 13:06:14 +0800
IronPort-SDR: Jlo08w0vJjNjGgxanByufPKmdznakqTs4YEWZRQo5+ul4O6A3iqc7C2UfZIiecwiONeRevNQIE
 G1rsiFX0F1AXiFg00eF/2XdwZXEXXRubA4wDjjzEiTc8LdjwqcMByjxsAiQFsWd6DzzrjQAlEZ
 kWKRXY2eK5aIBG8HzglxCkrUAqPpbK4SUbisMPzt2jeUd02x8/CqTR6NihP1jPbmIpSbImZ7cj
 srrLU7ZDtxmpooJgj/C4i61m9PRnOyN3G4VGnYe8ADXD7Cn+VI8ATGc9CD/diNHNRnHG/Mh+35
 bhn6KVG6cuums8JR1NU4NkED
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 21:44:16 -0700
IronPort-SDR: X7MajQWbUfTFitRDkopRc6Th0kL4lFPZgeuKSMJ9Zij9Pl9miHCyNBM/Zh9u4wrI3jWrwCDX/m
 TBb+ER1qaYb3swPSq8JZy8+btqJbtjA6qrC6/woZDb6T4odvOcLlJQqPQgdvYi8/PA4+WcxXhs
 p4Bqg1BP6lBDeHZ89kku6ru93ef4jCx/xsUzXbgIbYSOwpYFelQIIcLMc+XnBi5Z0cH1uxs+wD
 1bCn+8s8wYOHplbztITPKnHTraqZw8Dv9vnEp1GyByolYEOnieXcgomDQJWRObwBOBjexweUJR
 V6E=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jul 2021 22:06:14 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.14-rc2
Date:   Fri, 16 Jul 2021 14:06:13 +0900
Message-Id: <20210716050613.875067-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

A single patch for this pull request which I missed during the merge window.
My apologies for sending this late.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.14-rc2

for you to fetch changes up to 2f53d15cf95824ed320abed3c33759b8b21aca15:

  zonefs: remove redundant null bio check (2021-07-16 13:45:18 +0900)

----------------------------------------------------------------
zonefs fixes for 5.14-rc2

A single patch for this pull request, to remove an unnecessary NULL bio
check (from Xianting).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Xianting Tian (1):
      zonefs: remove redundant null bio check

 fs/zonefs/super.c | 3 ---
 1 file changed, 3 deletions(-)
