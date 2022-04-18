Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6B504A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiDRBOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiDRBOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9365A12AE1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244331; x=1681780331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyuGdQFhmJj22wD+jStdwCkb/iLoObCZL50TUHdz5+c=;
  b=L9yG5XzthjgyQF7EPZH24HhJQVG+ECRCcxYo7qpHJLoUHkOyvXGvz1Ar
   BY44xi8hkYCyb9bTPqrAh9oObCeg6OQ8bkaOkrZItVkLXpWwyu6OP2LW9
   RR6msDW15hyjkGFNwatORwrwJiFoc+zRf/yjXiVzm3roW0V69xbQ/c4mJ
   ul5RYscqYCi3H6ucTgRScEhrnLYxcNW4XW/LToy0oyXbcEEWRtUscioWh
   pldBzEA508gJU3fN4R8SbliVwJ/3D6FDuCe5l0mBInO5V5aE2cukB7zDU
   YskA5b4eReRtQ1T6yEmBpbmZ7+DEKgh0Lb9PlzHOAYAi4j8Rloc2naJAc
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313763"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:10 +0800
IronPort-SDR: NQjbyJ2Zz2nKO9rhvh+Vc4iE8uPhCthQy1EMmcEIUJSR9OLgiUI/nWEljSMksq80Fmo7yGUjzc
 w+oXnwgsPV4RNzTxmb+1K2iYOIbCxtY5kmUkA52IBXboLs0YLlyB0Cn5NzXs4uTD39ep5+dl/I
 ciD6QbV3uxeHvbbT8/6+heiBiSDJ+IKIl0vzhgBU710VwP9V4qtI/jkSZQQjhLVr6CTWNB3Pzk
 4XwVQ6vy+waJ53d2FdUsCu9joYR7T+nBcx8/U8zDC1Kw85Td5p9iRojpaM+wUSCRol9HN1N92B
 bLEejTVpwim2dt42b0+e+Qcq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:32 -0700
IronPort-SDR: LbVO5AzkmUq0tpczUajD5qZr50j02PrlIjsqv/ppiZqrjNHx5NDKiKfax2wKm3E5t4gwhSt6Yd
 jh8qqgfLFfEznbY9/tp86MLQ2asGbKf0Fjdcwl/9sdxW7ZJUTpyczClqeQCgP6IDFiJBcrSsKE
 XJ3S1ijlLF0XIl2uGLWLc2ipTZUpAtRNI2s2wNruJeHdTGCF1J7ISenyqAlXBtzKYN0wlcuJbW
 6ontxhqaKXPCJbjzY3ZQrejEab7h7UY5DmVq1JcsPyJNrrOTckjRrw37qEeuGqh2Kn86zAmPmP
 Zbo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRt41V0z1SVnx
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1650244330;
         x=1652836331; bh=HyuGdQFhmJj22wD+jStdwCkb/iLoObCZL50TUHdz5+c=; b=
        PRiEudTMf45YA7ITIoMQgzjfbuM1KGEjMXsRMwvN9eqUoJTej7A8RrnaEQLbwwHQ
        dn7iRYd/M3MroC0zZ00VTwWF92DhCynkwMQpKoGn2++91c6lhsSQAvuuSMDDAbkM
        gRlqmkOJXo0URVBdIc9U3Bfpeb3mcQlnZO1tZhBojZxiJk/ps4vFm7zagle3p055
        kjCUyZG8posJlqGKszvWYiexh/VG0RGoIGg0+2sqdu4n+xXyyDuNuOYDNx63CGgR
        DAfRaQ9YoALsUkeKwbunYYvULiXQWaN19hYONDBUfEdSzGGR0reBXKKLS9CgnBvS
        XEKuh0ETt+XjhS8aAsX9CQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WQCyrXXjmjf8 for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRs4Qrnz1Rvlx;
        Sun, 17 Apr 2022 18:12:09 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/8] zonefs improvements
Date:   Mon, 18 Apr 2022 10:11:59 +0900
Message-Id: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
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
 fs/zonefs/super.c                    | 219 +++++++++++++++++++++------
 fs/zonefs/sysfs.c                    | 139 +++++++++++++++++
 fs/zonefs/zonefs.h                   |  18 ++-
 5 files changed, 376 insertions(+), 54 deletions(-)
 create mode 100644 fs/zonefs/sysfs.c

--=20
2.35.1

