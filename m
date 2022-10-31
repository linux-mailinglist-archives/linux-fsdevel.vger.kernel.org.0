Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370B4612F41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 04:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJaDNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaDNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:13:08 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01F9582
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667185987; x=1698721987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UEvtd6hL6Ua+d79+pB3qZT1zmFnxmKhTOqEW/R52Png=;
  b=XICosE3RhL+eQXS7CfltcNf31hNSQApueIApPtDozIv5OZNX6M5+gFc0
   mKY2UGBMJRoPXAP1y3yVcgLASgpfkol+Jiodod65mgAt3g9fwH0yadaWP
   g1ZxVCB2G9zOWpZzjC+NxIfPqS3LSoh0eH6qCtpN+Ja44zsM054IeA0WC
   D+PR6PKJvb8d0Ck987A0SJNH5fsSqKxtjDTdfl5BKZoIYA6cwtNzoI225
   BL3VeHtV4Vlo1b4ivexa6Nzz3AZUlOEjSTgZnM/HtRKTOUNmQp7i7p2gD
   36BicQ5IUGM0nj1ZOag8jfaQvy8zVFXRv7qcBrylWPYNqyAK/pXDz/6bM
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220250883"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 11:13:06 +0800
IronPort-SDR: Jf629WKaDgXEUVkMJHZw1kqhpPCWA8T9KkF+Bm0LM6nDP0d62m9fpFIzZOidWVnHQ6Nw0IUyQ0
 vOjIvwSAVSheTZc7zhgyVVOvo4TfCkEvYunhrOqBogU+Degx1vDmqEwI2am9Q4WZeLncfzigIX
 hzaLvTHEonmTH75okIVEAaSHUNAFcj3DsLMDw5wcpMr1dZcWTN9bOKmz+PlnXSvSso6tELUMzv
 E16G+hhBox3p+wrjnvk9YllEV46IUTJScNnBIUNuZaVZwKJqGysh1GhY8GdN/qm9tPTPhZz/1h
 8bzFjf+AL9ljUa8rip0T+XCS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:32:23 -0700
IronPort-SDR: vy9iWOLf94JTsYH7QeLOuFiVjcdgPknwpNCnp10EXEk+E8rcCgxBwzbq/3A6Hx1GHOy8l2Z4ZK
 +KPoCltyYW5T9qQz6LIEmdBvuRKRjHbXQqgmjcC7Gn9Qb9UkPrbzQFAN+NDuiz99soJQBeILvT
 EOM7Ju83D0LnBe9Oip2iE9M512BkqLt1C5/P8hblAXc++QrNak+rdldEIXfzHzuCtc+CHN40Ya
 mq1crYc0fFhDUQErzcRHv1tUjCbBWzfXqubeC+1N/ZgttqwTm0PgY2ZbEH1b34C9q7pl7CcHpC
 RVU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 20:13:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0yZ34yrvz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:00:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667185211; x=1669777212; bh=UEvtd6hL6Ua+d79+pB
        3qZT1zmFnxmKhTOqEW/R52Png=; b=WQ8l4QyIk/ghIzU+hPJcIF4OKrqkzr2pxK
        ok5hXKz13cpr7mmFyvLbnJAy9sIwno+Vk1nhoxPQCjQ3nO5caHUSXyiLiL/a7900
        0AeD1GTldRSJpX/kXPU5HK+kln1Z2ywbHIGI6JEgwlyt3pb2gbdYIz5pyrmwFKCN
        5RGGV39MZ9E6It1Kk7UsHvV51KAkUi3LdDhfg67TXHG4QNuYNhshmCSi5tjXRDuP
        EuoZXlDyKlKIHS1EBPRafGEWjCseYHjVYDZO+4Nrq0rZEqV+S+2LKaWV+fp4ce8l
        CbHXP2fnzimBBxACesQp0lsuqxb6RPkxj+XD837NzvNipKaoQk8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ow9tcyE8Cu-z for <linux-fsdevel@vger.kernel.org>;
        Sun, 30 Oct 2022 20:00:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0yZ23T8Dz1RvLy;
        Sun, 30 Oct 2022 20:00:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] zonefs: Remove to_attr() helper function
Date:   Mon, 31 Oct 2022 12:00:07 +0900
Message-Id: <20221031030007.468313-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
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

to_attr() in zonefs sysfs code is unused. Remove this function code.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 9cb6755ce39a..9920689dc098 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -15,11 +15,6 @@ struct zonefs_sysfs_attr {
 	ssize_t (*show)(struct zonefs_sb_info *sbi, char *buf);
 };
=20
-static inline struct zonefs_sysfs_attr *to_attr(struct attribute *attr)
-{
-	return container_of(attr, struct zonefs_sysfs_attr, attr);
-}
-
 #define ZONEFS_SYSFS_ATTR_RO(name) \
 static struct zonefs_sysfs_attr zonefs_sysfs_attr_##name =3D __ATTR_RO(n=
ame)
=20
--=20
2.38.1

