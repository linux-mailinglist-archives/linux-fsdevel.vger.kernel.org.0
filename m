Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAA227FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGUMKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 08:10:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65330 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGUMKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595333472; x=1626869472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l+9C7sA599KYjhy8WDDYetFbOMtr9Euwzl6AMDahZnk=;
  b=QMOcBOPenqsWj7K0NXxjFFPB3knbP7TZ+IjHN7hFpWC1qRNvtqyWwZJO
   RXScf44WNnuKhQgQnKCp203NcYhjzhVL7V8IdlPLl4QIyeRnZj37ZZjc2
   03qt7oQyhSMNz1dmmplA5ImVr+3fTKmDqYcx8wABKzSSjmvwPSbaMQLea
   1l25lQxUSEBvdTIIhcMwj7Y9HntriaZEvLCpYDHLbVD3/ZcJp7iq/7Hyc
   WVwwXBEHSgcUZQ87SYsb5dlmeNIw+fJPx31CLx/6iZuLfQrd3J4AkIQgU
   oCWRpXyuUN0weeir9XUcBoB0fQUVNQapTqTO7KFxCPo5wSQAcyUxlI1Zc
   Q==;
IronPort-SDR: mti62SuSJwT72GjIhzGDnPbmHwbCdfLdJ4UVBBEHXbX4VxdQ9y3ZEtO3l9H8NZxT4CtpLGnPGn
 3GSREAxZ5vSZIUk2NnJfahd1jDiKlwl6RlwUgxTKaulPt0IBFYZEfhgrLU2q05reJefg7rFSQY
 Xt6WmkOYWrR1JQ0doLtqW9rscICICTIXqVXmFj56DD/XrcqWruF1MyG6ChCaFOIyHlFmdlPCYs
 Gs4pZS2KY0Z4roe1pc2WvKzxyZiHTjxSrWaczsrnVx74XCmEEaztX2tteJiheyYiKMzNbtNiVf
 dlY=
X-IronPort-AV: E=Sophos;i="5.75,378,1589212800"; 
   d="scan'208";a="246053968"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 20:11:12 +0800
IronPort-SDR: q+el17tFbKDSJi8at+b1fZo6LDgWLcAhHx2Bo7vDzMmccphN4tDAV2g2x9buYb39BxM3ufQk5B
 ZJqUR2eq6tWm2J9X+X06/mLAUjLLbBSas=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 04:58:14 -0700
IronPort-SDR: nHtfnutEkoqqhgf6Lwjg84bcwAb5jEg53OsmO3XcT3su1ZRecu8B1lu+7KiYobDL0FjgsajCV7
 m6gIzzRC/raA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2020 05:10:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/2] zonefs: add support zone capacity support
Date:   Tue, 21 Jul 2020 21:10:25 +0900
Message-Id: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for zone capacity to zonefs. For devices which expose a zone capacity
that is different to the zone's size, the maximum zonefs file size will be set
to the zone's (usable) capacity, not the zone size.

Changes to v3:
- Fix error handling of aggr_cnv case

Changes to v2:
- Update aggr_cnv case
- Fixup changelog

Changes to v1:
- Fix zone size calculation for aggregated conventional zones 

Johannes Thumshirn (2):
  zonefs: add zone-capacity support
  zonefs: update documentation to reflect zone size vs capacity

 Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------
 fs/zonefs/super.c                    | 16 ++++++++++++----
 fs/zonefs/zonefs.h                   |  3 +++
 3 files changed, 27 insertions(+), 14 deletions(-)

-- 
2.26.2

