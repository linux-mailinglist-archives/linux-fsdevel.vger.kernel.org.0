Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E347C53088C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiEWFBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 01:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEWFBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 01:01:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D317AAA
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 22:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653282107; x=1684818107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LhYT1qk/00M5euPuEEmh6wT72QqcMRnlhn7+r0v8TE4=;
  b=igAQdcd1+lVquEdFBtNihImlKzqgawQ5qu4v0vehnWv5aSE2+yCuPmOj
   zo5l3oY9VhKo8JqDErJzNxsvvwb5Jq88aPB/DGZb8wQqzUYCvmWtfyodV
   VetNTgVGDNWpg9qnM1Kn/xRGWkLupSWUsMA25tFyCZ6utPa+0TYxMi8FD
   z4eOla0/b/p/gv99fxPKFFXFQ5pxr2Vng72S0M6FYPZtkj5hNKcTMVG2d
   kx8rZVGQDrMTuKSJMZLHwQ4BQrfVw4e/CcJZzcSkn6jaRjJSVG1BBs6xz
   ztuMAPb02hPPizl3+cWJ9hj7S4hu5Dk5zp1eAcwFtM8+ZV9KwaiEjmdm3
   w==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="205985982"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 13:01:46 +0800
IronPort-SDR: Jq6TgtvTVYlo7fYFU+iI2Z78RkKb2RhaiFS0KE3j/OgSlJM6mI1U+gwkN1dNqlHzoIfs4qrkas
 96RNOITamlctfBL6fFzojhnqB/W9eC1IFrn8zfrrKLEmjZl9dLoVeroF4LPUm1llHz/2PNcusX
 Tx7YD2geRDlW1KAcgRmi8k2ziC3x6+s6wizYdKyQ+5K5/1XDY5mzXTmVkopozjr7NMucnPkzsT
 ms/c2JLSeqGZpG6K2NzdFuQ8vOGS/YiKESYTY2jwgspcMfIoWRPJ1QVrHDrKga7C8DugTfBxbF
 M+vLSRyJWRI6/SFJnp10Ub2s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 21:21:21 -0700
IronPort-SDR: 3+UyJow53wiq/ZilA2q7NZTH/qdSfWUR6SU3xSa+cPFBHjFuDgKDVnoxh9zrxcpLJmONmcAFFC
 VgN6Qy7sjdOt6JYnJuVbyO9DAyK+L9Fdlr8AFheQzaSHtrYXDaqnqf79qQfuDVjEBSwgM0L+6X
 UAPAJHc1VCPHecTWxgwu1Ac2Faijoi9JzQafW8tR8abakh992yHi02adhh8Qr7Gu+/kYRFUMaO
 hutejijCKqmyTR7t1ImsXuWDBD8eJ1Ut6aiT6OvhlZ+xs9ZeK5vb/BfQ9GwGINE61FYB39mc5Z
 0ME=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 22:01:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L64tf5yQbz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 22:01:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1653282106;
         x=1655874107; bh=LhYT1qk/00M5euPuEEmh6wT72QqcMRnlhn7+r0v8TE4=; b=
        bqZDiWkBCxu+CM20jv1en0FPGjmwC4Nr1xtXdGHUgZTvSojBwBtKSjC2Uwbp7orV
        Yk1mA+Npav8z0QkXnfSruAO/n6fLKoMJiEmmJQHZukwDUYhwDCyg+xp8O8rJTYsL
        bNAdIjrRAFch3lMkc7pbuhr+jARZatTNa6Z5DAlRnRunQopaTYkwakNQ2t65mx2o
        x9blOEZuSr/MeUNN9/5VlD8tBe0wANetW1QGudjNnmpgIznkFL8jIRW+R8HjHlpA
        aFdptDAyfvtVX9KXxbq3nSk/+OpEY9Hxq5WZU/bUH+EYwwNom7bsnW2n3ZvkAPxj
        DznrxObRJCM50phH0EBLcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JCtW7pDYXc8e for <linux-fsdevel@vger.kernel.org>;
        Sun, 22 May 2022 22:01:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L64tf00cvz1Rvlc;
        Sun, 22 May 2022 22:01:45 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 5.19-rc1
Date:   Mon, 23 May 2022 14:01:44 +0900
Message-Id: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
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

Linus,

The following changes since commit 19139539207934aef6335bdef09c9e4bd70d18=
08:

  zonefs: Fix management of open zones (2022-04-21 08:37:35 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-5.19-rc1

for you to fetch changes up to 31a644b3c2ae6d0c47e84614ded3ce9bef1adb7a:

  documentation: zonefs: Document sysfs attributes (2022-04-26 14:53:06 +=
0900)

Note: I made a mistake during this PR preparation and inadvertantly delet=
ed the
for-5.19 branch used for this PR. I recreated it and prepared the PR usin=
g this
newly pushed for-5.19 branch. All patches have been in linux-next for a w=
hile.
I hope this does not trigger any problem on your end.

----------------------------------------------------------------
zonefs changes for 5.19-rc1

This set of patches improve zonefs open sequential file accounting and
adds accounting for active sequential files to allow the user to handle
the maximum number of active zones of an NVMe ZNS drive. sysfs
attributes for both open and active sequential files are also added to
facilitate access to this information from applications without
resorting to inspecting the block device limits.

----------------------------------------------------------------
Damien Le Moal (6):
      zonefs: Rename super block information fields
      zonefs: Always do seq file write open accounting
      zonefs: Export open zone resource information through sysfs
      zonefs: Add active seq file accounting
      documentation: zonefs: Cleanup the mount options section
      documentation: zonefs: Document sysfs attributes

 Documentation/filesystems/zonefs.rst |  52 +++++++++-
 fs/zonefs/Makefile                   |   2 +-
 fs/zonefs/super.c                    | 186 ++++++++++++++++++++++++++---=
------
 fs/zonefs/sysfs.c                    | 139 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  18 +++-
 5 files changed, 344 insertions(+), 53 deletions(-)
 create mode 100644 fs/zonefs/sysfs.c
