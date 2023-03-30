Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203656CF8E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 03:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjC3Byh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 21:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC3Byg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:54:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5249119B
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680141267; x=1711677267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CeEhaDsLJaXZ9ZMzK+AvVog1yjOeCC+Udbd/NKVAvH4=;
  b=pwslH6wFHs7rQFA8xzhxZnyz0O5gnLr13oUth4rtLmnQntnMow6daVwS
   tm0YOsIYFOjtqwYK5AzQ8gtd46OglOnUb4pt8eW4VJTcO+W5RhCVCW1Jz
   XsMA31PkTxV4xtAXLItLcsrdqxvd5BZ/zprCcHR19GVsR9SfHe8PngW0Q
   hLA0X1jX7YsuQzkCnvfhuazjx8QST8IWcHMkp4l6VyvsfOuB5u1UD57ot
   oFdU0gw7XTwbTaQXst4RkxH0rMGJA4YTnCBH/BnO7ZgS2TZjFJ++5bn3c
   7RCjxP8KaepVrnWUyRlJPSEKQXAMGt7pdmOdDNcwPrIhu5hU66JlZh+oD
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="338912431"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 09:54:26 +0800
IronPort-SDR: YO6tFTVd2xZ/U9Sq2FI5FWtG97mo7FBQaoZumxfLGZzwaz0rDPYo2P2jUJbIIi5ysQ9U5IXojM
 XcaPSka0XrFt0QqSFUvRUC+RoGRwPflskrBjd7yR1s9yuNXxUB9DFwrW3JY4JHZnj4MwgLuCEp
 7CIgvuegnf+SqcL8Js8gh1OlJ3xzQSQvsKsJLpiO6BT1apXLL74T14s0QTONOyKsrnBt8DTyYu
 wR/0SisLslRvK8iD9br+4Mvfy/qcEUuO7k1YSMQl57uI9bjd7PK3DN2FPEgnxoGR9kuDvfN7Wr
 z9I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:10:35 -0700
IronPort-SDR: 0ViQ0aJ6xEIqM0vji3IeF99QlzknnAV4TXkIiCqGQf+eFUyHGpGkurmOLI4z9ot+zZmY3PB4E2
 uljrxy1AbqAo82xDFlYVOLiAvZwmMYCuUrXSHLtU2u6Xmrk1TK3RRc7Eo/73zvYdfunhVHu/h/
 c6jnVuWH0cVq8D4gKer07k+/ADbb3dJI6cEOmA5rlcsfBp9rzp+T7tXddkyPqOQLXjeFlK8/GW
 pCheIBYstKrM3gLvR+Mi4HAS5DCAtWlLuk4Pzu5I5JkzSVniPxnxQHEkhGtu3+6uVzwtf++9+w
 qR0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:54:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn60y3D4Kz1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1680141266;
         x=1682733267; bh=CeEhaDsLJaXZ9ZMzK+AvVog1yjOeCC+Udbd/NKVAvH4=; b=
        WJFdqYPIkXy7w+clTOmGbZpukpdQecq7ehM4GOXgp3NmhPvsYsEoAzBeZr6kma+P
        F2rQ6i5BASwauBwZRZmrK/SBQxiEzyXmFYMHBdlhRDO5Z1cGDgoAHdyyXBBQiKtj
        PJBfQeaLRj4B3nIT897icKOfRHW0NO2IrB2y8L9n6GGuZ57q51wVLZ5mAPeaiRNH
        qlt9ka9bP/9YeUUIZtcQ2CyeLiqkpixdsD7TDTky4qn6G3kN5GUG3cKDKhsM445p
        3UTJK9f6vebqAmswLNI93yXwIVFCI0CsJq2pkGpMGpj2S9MQ2nsGtxus3Iq72RU6
        EnauJT7mww1x5BTP7k2Fbw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wgvHmtgj1ST6 for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 18:54:26 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn60x1T2hz1RtVm;
        Wed, 29 Mar 2023 18:54:24 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] zonefs: Fix data corruption and error return
Date:   Thu, 30 Mar 2023 10:54:21 +0900
Message-Id: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
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

Patch 1 fixes a potential data corruption when the last page of the
inode is cached and a sync append direct write partially modify the
data of that page on disk. The second patch avoids propagating to user
space the -ENOTBLK error potentially returned by iomap_dio_rw().

Changes from v1:
 - Reworked patch 1 commit message and use an exact end argument for the
   call to invalidate_inode_pages2_range().
 - Added patch 2.

Damien Le Moal (2):
  zonefs: Always invalidate last cached page on append write
  zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space

 fs/zonefs/file.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--=20
2.39.2

