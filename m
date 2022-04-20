Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31411507EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348646AbiDTCig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiDTCie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FD237C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422149; x=1681958149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKBV8m2W+8+Iz9gHClP8gmWZnJ0OCTEdcRvBDh6oDew=;
  b=E1d4b79neHkVVdG2Oip5fFpAmLi9EmYVPxW++X2p7OUCFgnMKG4/iQ/Z
   crUwir+UIUUgHKONyj/8tcdqFhA4K/50YmVInWcHpjaylkpkAyAO+kc6u
   IJySANFHm0P+h354CamoQffVDb4e7BIdNbbWl5NtDs9ZrU2G+WLG23b4C
   N7aLGS5qLjeYNqUmpLmUrn8v3B8GQsNT6WbIszjUKlQYzZvaRwv+x4MZ6
   knihN6saGHngHduPaqEN/T5J6ltaWgN1QgQMSEwk559oeCEsoI+KKSw3o
   yX1uKG0g1TLd0E3gDMhjWBFRwwpwpOuHRiPOdB5n6j+UgqPkj/cEEabGS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177970"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:48 +0800
IronPort-SDR: +unSK/WgGLLZ/QndIgj//CqsRUXsSn3T9K90QvuO1HgJ32QMm1E0f89XHqMzU/f/3qU9HcaOqu
 BA45vtwuXLRnU6Rk9KVGlRFEP908AqZDVjMAoVWPkbI4kBv/RnmiimqJTWuBYZgRsNRGa9e6XE
 rr+sesWZ/QTdvY0oJQvZ9NVsazLL7NrFlJlDcbecs8chycVDDWm4bU5eqJW4B8b2qPdLE/Tbqg
 NwlXgMu5F8ILO7YcyU611X/+A0vJGD9XZkPrjx5726YPezUhSSuIwcbZjSqSSVe6t2UP81YpvC
 jiTI/4WpkBE/XHks7LpqQJV2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:07 -0700
IronPort-SDR: 4Zg6GsnIspJ7ypMvM9qW4kbpw3Fr4OwPPs6M+Qzx7cKor5GR3S6pB1iImziDSe02ikqD2r5Wd8
 W8xY7htJo+6xtu45dchf0LZlCgyNENOsa9a5tZC0ISaDuk4GYtVwMQKzhcZLrUQjlVU/hOzK+y
 u1G+fQtQjmoPMl2SyQcfAc5Rwx5divOMsjPd5dZavn7tnBsFwtfOLUx2ytUbAopiXymOK2oBz6
 sjTBO7Cr/UCuwINKI1aVJZs2Xic/6P2vLVbh8u7Zl0AY4d2lvwi/zaxEEM8XDTeoORhMZ8jNwE
 M0Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCR4vDfz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1650422147;
         x=1653014148; bh=yKBV8m2W+8+Iz9gHClP8gmWZnJ0OCTEdcRvBDh6oDew=; b=
        m6LhjT1qepMLEjWzFDkhkBEUWrhHQ5yesZbVviK3YwfqquxkGQTpymkwM6Q3gmau
        vk70OJETihkyqAoBrIaxIj+nHEktEJY+2qTjIhD8ybH7reLTg8Q1cEk7BBWKIWTL
        vs8emcrhmigBCJC4uLhJd5nX30X014F6Y1wPb43siDRmqyT/asMb6J/mPHXTcFVS
        AnPbeuwCHUEKaYcvzXkwiP+DbrCJp8UnQtviaIE0ObvY8UTvWFFIReMi3ikBkUtU
        BNR6jlE4ItZ12jqnRR+wluJMaMICazOcEeMfxRvkYLG2FcYnuKz4/7c4gNm4DeKo
        iZ6Hj13R8AwtLcFZ4syj0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JS-6ETzF0et3 for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:47 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCQ5nqTz1Rvlx;
        Tue, 19 Apr 2022 19:35:46 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/8] zonefs improvements
Date:   Wed, 20 Apr 2022 11:35:37 +0900
Message-Id: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first 2 patches of this series are bug fixes intended for 5.18. The
remaining patches improve zonefs zone resource accounting:
* Accounting of the number of sequential zone files that are write open
  is changed to be unconditional, regardless of the use of the
  explicit-open mount option.
* Add accounting for active sequential zone files, that is, maintian a
  count of the number of sequential zone files that are not empty nor
  full or that have an explicit open zone.
* Add sysfs attributes to export the above 2 counters as well as the
  device defined limits for open and active zone resources.

Changes from v1:
* Changed patch 6 to add lockdep_assert_held() in the function
  zonefs_account_active().
* Added Review tags.

Damien Le Moal (8):
  zonefs: Clear inode information flags on inode creation
  zonefs: Fix management of open zones
  zonefs: Rename super block information fields
  zonefs: Always do seq file write open accounting
  zonefs: Export open zone resource information through sysfs
  zonefs: Add active seq file accounting
  documentation: zonefs: Cleanup the mount options section
  documentation: zonefs: Document sysfs attributes

 Documentation/filesystems/zonefs.rst |  52 ++++++-
 fs/zonefs/Makefile                   |   2 +-
 fs/zonefs/super.c                    | 224 +++++++++++++++++++++------
 fs/zonefs/sysfs.c                    | 139 +++++++++++++++++
 fs/zonefs/zonefs.h                   |  18 ++-
 5 files changed, 381 insertions(+), 54 deletions(-)
 create mode 100644 fs/zonefs/sysfs.c

--=20
2.35.1

