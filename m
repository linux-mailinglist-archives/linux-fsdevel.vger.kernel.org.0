Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306D504A5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiDRBPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiDRBOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3613E25
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244336; x=1681780336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asTIHqFZU3QkWrq7EC0LeYhRj6GxxpvuDNvgjXX4FuY=;
  b=JJ4wViECTsJYByaTmpdfV+zMaGUuDc+mI7Wmqfm4U2pWlNVO38J/qjlf
   phuZGZRV6TzegkR6k6CJOfDj6bbfthzeZoRVZnQpBlU69iMfqB7LUwp57
   o7lbLsZfk/PLTeuypdL8eMX7qSAGLsyH7NfPkeKbNpnzRak8jNKUIoBCX
   REt5PWW4yZYjNzSGBnRGgH4+L05Smpa+nhRDO92YtLHuFwv16BH81SmA2
   3mWQD2uunCjye4JZWEYco8SrZ7atX2QpxKKvYZNPAq/i3vMhcWgPQSHgA
   0WdlWCJrob4/RyNa0vfCiY9Xb3AikS7vjwEOrGDqTIFiJEYKK0qEymGis
   A==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313774"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:15 +0800
IronPort-SDR: fOf/MEYgHlfuHAxLh44vu/223roTOq9AaJ0xJx0lOSq3GL7evo7HIzih73rM95T/hfhFEhUKJc
 NvWKvLSKSZmupCtIkpIKzhUHMpr+dA1CYM7TrrM0sILc3wEGflJdOBlxTsiy75JPgP6yCV5edx
 SwGGOMhVCpQQWrVMMs7luMXz0blx/OBRptG5CprBrCBboghXiXI+FHSOn0GoPvew+gABJL94R2
 WOPKPJg+nUQZaKsBojTMTErcOIIrTPP5zHG3VQYNjatf63wLibCCFh/HIh2RUuLg6UduI4UAX8
 IKe+f3EM9JZPBZVh8ZA5HzsN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:36 -0700
IronPort-SDR: Tusallhtzmeq/1BcZnmlEI15pMTkzMhbgO8f1pKhto2zf0ObScVFWOg3u1XG2JeVK2U9O+jZN4
 HLyu59AaoUlGMAgH8YVrF9cI9ZNerrsLjaCyix2KyvxrL9lVI67Or024niYCON8aB8YwPH7rI0
 Sk3QUKT6KXrzBf3V6CnUAdM3RrgzNxCTjH6q5WuF2qh9Cgvj8LiwzgNyDtv+SKtB43755Y0bks
 FAPw+MRUnGvnswXcMnwA7PpUOTyc26eSw3xGhtwNN/wNmxLTKqNHdgvx5XzKxMUtwwucgFcWeK
 SEA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRz2XvRz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244335; x=1652836336; bh=asTIHqFZU3QkWrq7EC
        0LeYhRj6GxxpvuDNvgjXX4FuY=; b=eKG+9DlJnrtqIE1577qdJgN8fViQki0Ksk
        zH5XMTJFQ/IJ0zLFfJVzDiQ9+NfITmCBYcjx+7FMSJwMV+UtOc8IwqJmvA4VOHfY
        yS0r+DYySVYr6pw8EJZuBheQYnidXXUXCgFZEcEZsdQTfB484m89zC/OP6wfu/US
        Tfij34d3VA+MAkqSWeDFH8ZSGjgiNqJWPEGvdBEbhxXZoZ9bq8xkaRJ9N860zEAH
        MoSelh7rl5elyZMlLCazS8vEI8I5t+NEpjPZEbVyfUFLaWyb6yM/yqGvl8uicu0f
        flrZPBaDIxbrdpWjboDq6WWygjDxQ2d5qDWySHE+StXWuyvO5Nog==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t1XAUWzWbXwC for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:15 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRy4Pczz1Rwrw;
        Sun, 17 Apr 2022 18:12:14 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 7/8] documentation: zonefs: Cleanup the mount options section
Date:   Mon, 18 Apr 2022 10:12:06 +0900
Message-Id: <20220418011207.2385416-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use subsections to separate the descriptions of the "error=3D" and
"explicit-open" mount sections.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 Documentation/filesystems/zonefs.rst | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesys=
tems/zonefs.rst
index 6b213fe9a33e..72d4baba0b6a 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -306,8 +306,15 @@ Further notes:
 Mount options
 -------------
=20
-zonefs define the "errors=3D<behavior>" mount option to allow the user t=
o specify
-zonefs behavior in response to I/O errors, inode size inconsistencies or=
 zone
+zonefs defines several mount options:
+* errors=3D<behavior>
+* explicit-open
+
+"errors=3D<behavior>" option
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The "errors=3D<behavior>" option mount option allows the user to specify=
 zonefs
+behavior in response to I/O errors, inode size inconsistencies or zone
 condition changes. The defined behaviors are as follow:
=20
 * remount-ro (default)
@@ -326,6 +333,9 @@ discover the amount of data that has been written to =
the zone. In the case of a
 read-only zone discovered at run-time, as indicated in the previous sect=
ion.
 The size of the zone file is left unchanged from its last updated value.
=20
+"explicit-open" option
+~~~~~~~~~~~~~~~~~~~~~~
+
 A zoned block device (e.g. an NVMe Zoned Namespace device) may have limi=
ts on
 the number of zones that can be active, that is, zones that are in the
 implicit open, explicit open or closed conditions.  This potential limit=
ation
--=20
2.35.1

