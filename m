Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12D5464B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiFJKys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 06:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349860AbiFJKyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:54:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F145503
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654858278; x=1686394278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BFV4fGH297O+nETw2XmAaPAhO8AMspHX9U8upONvgj4=;
  b=qXQXktl4aLcsC9MUXIa2uBKqlR0ccnUE9prYEGTgO+YK754XoGvV3f0H
   bpuff0L8QF1jLQnElTVvNmKKNfzR4/lhMuXmxryeUHY+SMbispwXph2y6
   l3h8imm0FIjXioQ6Qem28K2u2FhOYusjQ4NECMl9anDaeaEKylajWm0vt
   yDnEKuEnhUWOax7JBodLbfADO/oNeABR0fKYLrzTZ6dNSScdMuZ527q3o
   kbwLF3Xkj2paBRTH3WS/3Yw91eG5w6O84oCXyAfU4X/uC+seRJMfflou6
   IkT3JDzC9vbKbJeyWFO/NtVSNU1yFVbOWZqE8wdgE9VKSweQ5kgiZExM5
   A==;
X-IronPort-AV: E=Sophos;i="5.91,290,1647273600"; 
   d="scan'208";a="314843455"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 18:51:17 +0800
IronPort-SDR: kEy3613UB5DLXJ5nUPXRyFHdz8q1mQ2xRRz//gZW/A42jsTqISNsN0usZn9TScXzcwbfrQGIEA
 VE8/wJJJHyIlR+jtx+rN1wxvPCuUKgGW2axvTusnCoM57nHkmrenKPAaSUQJ8bUdrnD39Zgo3K
 MYyT1Og/6SOmt3RGA9YmvxGoUV2MUC5CocWbTmtn8ppE5ygGJxyFOC+9enzsyXcaKPSoJwXsUM
 8dWTi9R69y9xt2PLhCL5kSYq5+3w1CuX5O8LD7mWsAF1wHZfnheBL566cVfVu/KsdPPsmK0RdA
 HUkW1dyTV1MeSVuNkQB8P9xA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2022 03:10:00 -0700
IronPort-SDR: 8Ec/WMedPil+9SEEPvW7d3qF26V9lKFJWKauekR+I4JQG88nkU88IhccYgys10PMaV2Nauy6bh
 M0v+IT/RCyI0raUDeLXSIvOF2TDRXcLDvsgQvdPdaIVCp+hoJCPM0dr6syuHykCaBGYUI2jvEd
 +y+izlaj8izzKsaYhax6yFdUDwcpxrZpLyPDlVI7DnkjhjkwaSXBzx2n4e8QhYAKZFgJqPFrrU
 fjbQSA1YEBBd6uTAoAX2SThMf6tD0C0peHbuaA6TejsTL2y80zU7Qkur70c7LSkV8QWm8AW6sr
 SNQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2022 03:51:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LKHnc6Vnhz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 03:51:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654858275;
         x=1657450276; bh=BFV4fGH297O+nETw2XmAaPAhO8AMspHX9U8upONvgj4=; b=
        G3SbPJ+vlse4wd3W6wPXjgbFhMcFM6wjxE0sH/kLBF9ZQQQSI3jP15CeIMqgSYYE
        Ro/szi3dzalD+8Z5gzhT9FFXB4sJ6Jq89OVW6nkexYeqrxFqzbC1GO6mxs56YSTv
        rR/DsRHE9ughM7SvKU+L86AvPWcsBr+h1U+U4JK60PixkeA1YWTuNKbsNQLeDrXk
        anD9DfJIkmSDFRknenvVczMyrBdlMST23p8DeZtrc0pfnA5+3PRSUOv0pGtIfLbh
        LSc+8PFlT5IkY889oJNUikaGLrmwPrJGrUwbPiGimLRkdGsi7ILG7UYbeRva8GfJ
        hhbpPda70cSasjS2sDjijw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3936UeBLQhp6 for <linux-fsdevel@vger.kernel.org>;
        Fri, 10 Jun 2022 03:51:15 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LKHnb1DJLz1Rvlc;
        Fri, 10 Jun 2022 03:51:14 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.19-rc2
Date:   Fri, 10 Jun 2022 19:51:13 +0900
Message-Id: <20220610105113.788534-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a=
56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-5.19-rc2

for you to fetch changes up to c1c1204c0d0c1dccc1310b9277fb2bd8b663d8fe:

  zonefs: fix zonefs_iomap_begin() for reads (2022-06-08 19:13:55 +0900)

----------------------------------------------------------------
zonefs fixes for 5.19-rc2

* Fix handling of the explicit-open mount option, and in particular the
  conditions under which this option can be ignored.

* Fix a problem with zonefs iomap_begin method, causing a hang in
  iomap_readahead() when a readahead request reaches the end of a file.

----------------------------------------------------------------
Damien Le Moal (3):
      zonefs: fix handling of explicit_open option on mount
      zonefs: Do not ignore explicit_open with active zone limit
      zonefs: fix zonefs_iomap_begin() for reads

 fs/zonefs/super.c | 111 ++++++++++++++++++++++++++++++++++++------------=
------
 1 file changed, 74 insertions(+), 37 deletions(-)
