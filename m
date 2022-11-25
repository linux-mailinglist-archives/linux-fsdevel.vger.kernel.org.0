Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783676391A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 23:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKYWyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 17:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYWyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:54:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A0317DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669416851; x=1700952851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUqPOOEtZqPZ5WLWSnCdZeVz7AV2KOJXM7SsJk9Tz5Q=;
  b=gUQRK63ZfO6hQ2nCKrjShPwScjo4No9R2a0fVG9y15l/lnRyI5UjU5ZZ
   DoNMadzsVHmGt+SuNop6FGvDyOdQaSd2l/e+pG2Q5iDsnB+T0UJw4Zp5E
   RBUrLaUEIjL+4Vyn900Y9nFQm/GdatQC3J81gcXvXZO3Dam75ObrlSWM4
   emUnx6cXpqHU6R3cL0fn1IeDjh5TLURnsQhl45/97TcRquR17Oe/BG1Or
   K3WQ4IgTEnmzWkws7JYE1jiNDmEt7LehRxKB8jqPNp1UYfAHCSSLBjsFo
   N2zGQGu28DDXnDJbDvQbo5vTRJtVyiHdgNbbtWLZGEmyDOzrhtRrjJTKb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,194,1665417600"; 
   d="scan'208";a="217496590"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2022 06:54:10 +0800
IronPort-SDR: P+Wy35s1UTz4MlgkvIn5NPr6e9SzkU5CqSv6tHuOg5/+/a/ebfs8Om9iTL/d/vVr4EopXfPvDX
 0FNDjbiHpCIv9bkPRaTTjhwI1EXSwNOgmjFNdvhybXFiCurOdM5O2jauhKmfXBEyU0Ofm1Udxg
 PKVI5zEjJTwfyJzeRrt/P9NhwNVUPxKeYsB0hyyUrlDEkV26VWPQKOBCJt/gYhXg+6VlyD1Uy5
 etE1HUcwBMy8X4vlOE032kjO8qHCpa802Hh+PaYoey9SbpbWjxvDYUbLXoGExq4y6dXtf3JsIu
 eJU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 14:07:11 -0800
IronPort-SDR: Mky8cMhl+q1l6bb9sLxVSFMfZ1xewp0r/xrAmgc8eNl7FlxV58gh8fuUe3E8CYQultZYQl5fcj
 yjMXBL0MSogzrAJSfHqhzdsRHc3jjZr8169dvgpBeK/QbzAzHrWH3LwcYu9SExWMEkIOkyoI9X
 xiefoHjv2Rw4ZoO7njcWhHZr0ork/CXhXqZniR3SmP+ecCPpNtSfEC/MGmcmUQR63dn+cEGN/T
 GdsYeNRw+nr45qQAw8LBgpsIQyFRO1twHAIP+l2Ous5BIEv8wq/JezKjQOqQ+q2G0ru+h8VrH9
 KXA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 14:54:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NJqtB48Ygz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 14:54:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1669416850;
         x=1672008851; bh=mUqPOOEtZqPZ5WLWSnCdZeVz7AV2KOJXM7SsJk9Tz5Q=; b=
        YAjpMyC85lP6qtDfS1x8BbkIlsnP8ce8pPIuYoOBG5FkQdEskXw/XEVrpW70I69m
        QgpVRNjDgAKZtk2ROaWfmBOOPFLX9XbARxQ8dl4lAyjz3YTK3mpdHFBze71n6ul0
        x64hWCxAQIiR4pJjmrElqL5PY24spj0KG2EmPSZst2WmnzeBiMlvpNlIvPpse+CV
        /I4st5GrmCWUyqXplBtLFAxqNVuXu9DV+MKYGkRCcwb/IwgQ5Ra2Czzzy5SYA+RG
        sFJOxkJRrjYbeiM0Xo3XeR/dCTHuMTIEOPBnUq2BxG25YIvA8PdihFUCpdGRZC9h
        vriDDZQTeK+nYGswkQxmtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tqD1t3pYUf7j for <linux-fsdevel@vger.kernel.org>;
        Fri, 25 Nov 2022 14:54:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NJqt95YQ8z1RvLy;
        Fri, 25 Nov 2022 14:54:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.1-rc7
Date:   Sat, 26 Nov 2022 07:54:08 +0900
Message-Id: <20221125225408.769615-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
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

The following changes since commit 61ba9e9712e187e019e6451bb9fc8eb24685fc=
50:

  zonefs: Remove to_attr() helper function (2022-11-16 16:08:31 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-6.1-rc7

for you to fetch changes up to db58653ce0c7cf4d155727852607106f890005c0:

  zonefs: Fix active zone accounting (2022-11-25 17:01:22 +0900)

----------------------------------------------------------------
zonefs fixes for 6.1-rc7

 - Fix a race between zonefs module initialization of sysfs attribute
   directory and mounting a drive (from Xiaoxu).

 - Fix active zone accounting in the rare case of an IO error due to a
   zone transition to offline or read-only state (from me).

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: Fix active zone accounting

Zhang Xiaoxu (1):
      zonefs: Fix race between modprobe and mount

 fs/zonefs/super.c  | 23 +++++++++++++++++------
 fs/zonefs/zonefs.h |  6 ++++--
 2 files changed, 21 insertions(+), 8 deletions(-)
