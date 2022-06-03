Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EC53C993
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiFCLtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFCLtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:49:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D2381B4
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654256984; x=1685792984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aJTMQkaVEdwaScmj45E5LsGCLAGld0vlae6CqQ5aQxA=;
  b=HYBAdKA/REIJKeT2nEZcLJbBINhqB1mZJh/EAqNvY18IIRk7yuzDpheT
   6kKNWVdhgE+b6gfoTFtk3SZ96HHruBxRlfHnLZ79Z1g4ECMGA/VHd8g8P
   QotRvvOE1DGrPATbQt4Su08Etf1BfRYbFUlDSkyCo89S7a4OLkxl/jYJb
   deDmpGWBsAWqaH1dOr9ooXeX8olwUvnTpAXLjjLdAZe5f4wHtJU5T0zis
   RnF85rWcw7afKYOOkSdnkxyKG6PhcTxUOZiinWWwJHK1ZRSYaDOLpYscd
   2QENFPzqbHIQAHs1Q/uGx3lijMRewgpsv5rxV1SSaryFEeCPo8lxAp7ar
   A==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="306454531"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 19:49:42 +0800
IronPort-SDR: akQpUzmYUzurSCcW4Yyu0vL9+JdaBpXmLI64ngM1O4ugkpPPnhUhcKWfzAv4PfkfBHiXgvzRS2
 FN4kA2IWQ2q7caQScxoksryWiQq7JNkVKcL5QJb/h4hvaZPfu6k9L87vKk4rcNpue3ofynRmK1
 uE1x27W6k05ZA2+nD3KOZtoADuN+3L9pUEM0XDMqHfqcNMJj4gRCC1IPUDxt9dpfdNMWEb2LKh
 AjogTCQphXHI0LyufXuONqsSYUU3HzBqTUXZ9UVMH+wa/oCUhWkR5byLRQqdlLs7ZW2DoayWCn
 UqwXsm0xZ5Jdzf9oifMljaQk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:08:46 -0700
IronPort-SDR: ew0gD3J3oPFvvJxHOliGdXA3BlUPfAjcvWqmMXy93Lcj/AR7iI473e86bco+fUwj1kSIMbdwH7
 06vMgQo98ibTVl0QuH9e0YilkrH6JrGVc7aVnx9XBX2uFYn2f2bRl0ZMGBX0btwM5UClYC2gMX
 YPw5CXpJ7zKkNVp1j3LxwdJ8awcF356Z1Uhemp1lstfF/mZfNm2PiCW+Q+6ZXpRPSi/8vxb1qT
 FPlyjzWXZPPN865NqrN4M038/ky4GZA6k9C+NjjIZaZp6PSo0kJKqJU51XDXcf4d2Vh8N+Vv52
 2FM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:49:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LF1QG01fKz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654256981;
         x=1656848982; bh=aJTMQkaVEdwaScmj45E5LsGCLAGld0vlae6CqQ5aQxA=; b=
        ag9Gr/JB6EOqiiOH+GRr+Ohqu5SpSYuKGYBKTMjkOa/epmHT/a3Vajcc/vQuu/me
        jmn8If/MiONAr0Jhs+HMNhd1uuLwYZw5I8u/inn1EPa9eZ6H17clwLNdihK8YD3u
        GuE8xWi2gffVJjLLfc//cQLM86kecONQKVC/cqeSHHMfwk4kkcz/by9/7BlGw8yb
        uM5SWYEeuwQjQ89z6eeU2LjtpEwMaKct1Oi0l2V3tCvjqvrnU4aDWGF5NoL0goLh
        l0zW7C5a89TkMof6axo1J8ceGA2ueZ0aOu+3MEidOEY74FvJ19cesm5AULN7du0+
        3sjs+wHCIZ8Fkfimxw5vzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M6uv6YRrXcpE for <linux-fsdevel@vger.kernel.org>;
        Fri,  3 Jun 2022 04:49:41 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LF1QF0CVGz1Rvlc;
        Fri,  3 Jun 2022 04:49:40 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] zonefs fixes
Date:   Fri,  3 Jun 2022 20:49:36 +0900
Message-Id: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
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

3 patches to address zonefs fixes for bugs discovered with an improved
zonefs test suite.

The first 2 patches fix handling of the explicit-open mount option. The
third patch fixes a hang triggered by readahead reaching the end of a
sequential file.

Damien Le Moal (3):
  zonefs: fix handling of explicit_open option on mount
  zonefs: Do not ignore explicit_open with active zone limit
  zonefs: fix zonefs_iomap_begin() for reads

 fs/zonefs/super.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--=20
2.36.1

