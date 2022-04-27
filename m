Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C9511078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbiD0FYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 01:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345574AbiD0FYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:24:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E78118B2E
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651036871; x=1682572871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5aGUGc4LaVLJAlWIANwUnyjPpo9e+OdkG/7bCU57rps=;
  b=S/5ndp4ePi4X9JyAvUON6pxTtDIOkV7LnjJ6GyhhBgrk+Fo11TJqSrYu
   PQrrFSlSLvsKloHJUBEjH0P6NQX4wzIk5CjjVctdQ9u0pC5QHYMssmcmb
   q/NF3QLQpzprcv4lrq8qo1XuoVrgm/B5SM0DEuUCY86d2trO5h6Y6oiNB
   SFWso9gtcZps+6cqFSlImZPdH5El3jIiMqBjFRytMefId7UqhcGXBl+eV
   QjbKFlsqZdylaQwsMmmvrtb/eI+PvcCsSsbTLIebmIMPLTOhJ/AjlmURk
   FGMRS0hZBojcm6lWgcozg9+pGfMPkB0BBi+ZvVWTO5JIpoSyYiYXN+B0I
   w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="303131812"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 13:21:10 +0800
IronPort-SDR: uCW73EwvBDDYF2Du58DZbPPuC7l8OIBdTjMgcgnxRcF3thL/bDUf7fyoly/q2/iC+AvLW32Rdt
 y30htz2sRuqky9ZFTgtGH57Mh3ikrK34QPEG96ONR3nrqXBP+vDAC4uYMO/vuWHfdbMmM49ISP
 oNQpqwZKlvc/R+U/oZSsKe893tDKXpgWXWXymylHa/1jKBbb3dgaV+dwmIFzYt3AmyLk4BLV5f
 0HSlWyJ4CXZ1kr4q1s7ooEOwUFjr9H33STCajip7FgACSr/d9wtRWilmwWYD2m4URytJOu9jrA
 Cn34E8TAaPVSpsIsQh/lthBn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 21:52:03 -0700
IronPort-SDR: qpBSv5VyNGky85BXDYCSCKOPpa1yNRrisHcrOvWkbSpWCvoipF+NRl2hv2QVwTg7JDTblN8IZ3
 W1NBh00TBONDrNOIPxfKO2AE2N6nBhtqJwMcLf5DHTJdxN1PQLlE/m4SCJT2TWEnttmLVv/ZJl
 CTlxAzkyTBihiCedkDThKI3oZTDrXyUBORnAZSvYDW/KKwphU+gWEWUYcB/t3qsSz6cbVakarl
 182meZ4+M84BNzgu/fBsC7aNd2mGLK/+TS9AHmGe2Xrz5SHrOtuWARJnyBz2K+93/eTcMxF7pg
 itI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 22:21:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp6Y21dTQz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 22:21:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1651036869;
         x=1653628870; bh=5aGUGc4LaVLJAlWIANwUnyjPpo9e+OdkG/7bCU57rps=; b=
        B65LLA5JCrZtNlKMEYs4nBzrxzSZM4gmsQEZMYgf0vs1DX+34WBZKinvM+5dY8h4
        Z0AKDnhVW2M3BXOiCxIkxK5wgzayhar/t54W/HjkOBLpg65jv57ygVBvRS3rukCq
        GW24CDMi1fWTZvVYw9GtGB1Ss+S1JQhvxtMq30CtRpJOwfmXrvNg9sSP+wsIgItD
        Oy6seOOs9Qi/X8J7oxsg9c+VSaGsYdloHpqSXe5u3vKwkNwB4oGHrAV7ZneenF2g
        wuVwyl4v3IBq2IljTD0kUDL/MFgkuCaHFt2a+GQaPmOvJPlyZDBAsAm0JIYbxEhM
        ocQfrg5mumGuJnpzDnoD5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nxsH7p2xZIBC for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 22:21:09 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp6Y114rNz1Rvlc;
        Tue, 26 Apr 2022 22:21:08 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.18-rc5
Date:   Wed, 27 Apr 2022 14:21:07 +0900
Message-Id: <20220427052107.9812-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit b2d229d4ddb17db541098b83524d901257e938=
45:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-5.18-rc5

for you to fetch changes up to 1da18a296f5ba4f99429e62a7cf4fdbefa598902:

  zonefs: Fix management of open zones (2022-04-21 08:39:20 +0900)

----------------------------------------------------------------
zonefs fixes for 5.18-rc5

Two fixes for rc5:

* Fix inode initialization to make sure that the inode flags are all
  cleared.

* Use zone reset operation instead of close to make sure that the zone
  of an empty sequential file in never in an active state after closing
  the file.

----------------------------------------------------------------
Damien Le Moal (2):
      zonefs: Clear inode information flags on inode creation
      zonefs: Fix management of open zones

 fs/zonefs/super.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)
