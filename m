Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89382612F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 04:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJaDAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJaDAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:00:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612CB7673
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667185211; x=1698721211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TkWmTltrVmRAMucyaH4x/maGLP1/Y4UHqWbkISOwqFQ=;
  b=GDEOiuqYydReRMU/xJvED8SgUSllqb2PM4Fb25TfvaLZ4AEyJAIMHeep
   KEoAMrsbgoHOzXewN5k6D/GuhQTj+6d86aSibLAlrU2adewvaqKNLrukK
   NU1hwPnPcz2tAMhuS6L8Cw3b4HlYbqxxffs/+QSkBFT9xyRH2Eyk94Oqo
   d/eoS7r5mzd7Z7CPPYN4ALfqN8KS+YPPyj3b+lul7q9T8mCzlj2ghZaN1
   CtxkgwOGjeaNt/pjVY1wMgbjpFcZPJq41yO0VZt9wOT2dEakxoj2cWylL
   1LIrpug7omvXgHZGR86n45U7gG17SQhti4qer+i3yRD6SMktXo95YrMZx
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="319427239"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 11:00:10 +0800
IronPort-SDR: J0JdGo+qw/iJFCFWPocBj7BgwMiDQnbjGruLg0SqUkS7AJjQIjcLEC79NeFoEX1WbSqkQMSpdQ
 NnGb3zQeLFME7UaTAWBg+IaCu9crLHfgtehurebE1UJI0zmyaJKrJFLdloDj2fWoMsYrytTFSb
 WohPQmx6e+KtVc4+FPdxYmtYxDkPvKMcTtLH2I13Dy2nU4bLVVM3CJbIX7bxFYUevociNf0Rdw
 khxKTSTm6Tua8v9hCWSMnPbXOzOB2KojUMK9yHKEzYkyl+AbXS20NXUrA/6nZAp0t/uMDuxHKx
 QoHCGpUL9mhaVasnhLRvoEjN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:13:43 -0700
IronPort-SDR: fXYnTPFkP9SBigqvFGqsDN21yOrk00c+xYl6MxTh8NfqZY8MrCXWhxxKeB2B4Y545rTZO2FaEf
 bvJRIwQKfVKN9QtoxPFwJvYPQGSxSM8hBnRyolD0bLI+3J6288WzVLaVfCvQUGiweb5vNEV0x8
 gpoI/a7bgq8FdXdMBfIghKCSXvuFRbrueSj51rIN5wupHFyvC6Yp+YZw60ROHADm1oyvgaw58/
 F6oeb85huVzfNSQJYYxLUnjypmyRz0HnrSnqN+k/bQAk6fo2WlVk9s31XQZzxBD0k+NCLE8SCp
 tZE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 20:00:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0yZ21P6Cz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:00:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667185209;
         x=1669777210; bh=TkWmTltrVmRAMucyaH4x/maGLP1/Y4UHqWbkISOwqFQ=; b=
        RkwrKtEuZbYCqnSXwIecmrLOaOoJ8TClH9ajIKwsAMjEtUTgNl95FsZrDtQxxSyd
        ODB2okamQXW61gpT2hCamdc3ddvSSr0Jwwbwc9oFN6eXMy9flwGvQaUwAYvvn+Uh
        j92nXApNPNPaHHNwRuS0wBAlTBeJAAcu9rlZ//xLmMwu0lIiiUnUggaXM3J0KOuO
        ORZZdhpExvQTp5wpGmdQ4ilbIMk2oo8JrGIU3nj9dmn5h5SzQZSeB5g5t8pLafmg
        lLs+Z+ertfw5cSeXE2FfZ4dtB54PS0ZtbGeyWr6yOVDJoxTNEDPfPdAA84jspcaH
        MfBq7ISbp6pm4YvNt+/94g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2PfcAsBTU0HP for <linux-fsdevel@vger.kernel.org>;
        Sun, 30 Oct 2022 20:00:09 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0yZ10MZnz1RvLy;
        Sun, 30 Oct 2022 20:00:08 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] zonefs fixes
Date:   Mon, 31 Oct 2022 12:00:05 +0900
Message-Id: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
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

The first patch fixes a bug with the execution of zone report after an
IO error. The second patch removes unused code (not technically a bug
but this removes a warning when compiling with clang).

Damien Le Moal (2):
  zonefs: fix zone report size in __zonefs_io_error()
  zonefs: Remove to_attr() helper function

 fs/zonefs/super.c | 12 ++++++++++--
 fs/zonefs/sysfs.c |  5 -----
 2 files changed, 10 insertions(+), 7 deletions(-)

--=20
2.38.1

