Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D06308A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiKSBqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiKSBpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:45:49 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBD80980
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668820149; x=1700356149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gKgoktrAN057cqxOyJdMmYRPUXzTjJTZkfiT2avEmng=;
  b=FJEuON30hazgwI5ZmL/vSgJgLjNIfxyjQ5Wb7bzGS3inaIV038EzNkTb
   8dfd+va8/gntQOVA/VDFAzsTTOVZo9sCy96L5rXdK97mYixVEaoVD5RjJ
   6zRemkzskL9IRlXYdWjBL/Qw3KIf0/7xANyHSEz/lHITwn3NxgFTh1qEt
   kNSKRrrRZX+RHTv5sw6X3T4eikU5V4k/QByCJk4fQqktt4jMhPdjzLXvu
   KnpLh4bfMeJKRRNiNh8/UMtOtO8dk66YA9hvKxUsQZ9eFFB5E4Ar9gFKF
   TF8RP+eJqHbtS+gfzMJRag+eEyQADH1fP4I3YjB3mIJflhSpte9L71KA6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665417600"; 
   d="scan'208";a="328752048"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2022 09:09:09 +0800
IronPort-SDR: X9XBo/XDYCdLhM7H9looNCekrJam0iiOP5qcnH0F86laN+zogq8iW3X5Zpo0zzrSqUVwnImuYb
 ZOo5l4FYL5z0sFpEESW3NM0aYNXcLqIDTODX08qP9C9pO8nx7D2ODFVgMs7sCbTIxFQmfNfRV9
 LhiwmqMyIzzF+/3c89hAM1iSL0CQNJqs9ZrXlCfTFPY/R6CQyh+XhFbEj/9plbJ9qwKBMl4rnT
 T68TdOaILVMhuPsXyMf/UvBdCFEqWs6v+68vUWBZJgSQdvJ/YfUMKIN81Z8tCim1ozye20A4Yf
 dg0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 16:28:02 -0800
IronPort-SDR: a/vpPgXQN1CFib3b6RYk6G9Yd9N6gYCUly1a1C/luQUiPv/FDk5jR2fAN8VNnhlNznVWO7l/M3
 Fta5Etr4Rf72Q8RiQD+OxtiZ4ngcvTjGDEevRnU8ajtYuGttKljuLfFHycZ8K26SrPOIBWacH3
 ECGGZ95sYw28ea4utAZaz6kQ+yIKwxT+xpjllxNxJfIQIW75Nu/8/aQcIehpaskmCV/I54ufEp
 zg738BxnRJdgClLFlK8dFgKvXzKNAQBGDwiZ1Gfd/zDO3xWdUQ+lJvoICbgk9t49FPaE2VNlIc
 WpM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 17:09:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NDbC86LKRz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:09:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1668820148;
         x=1671412149; bh=gKgoktrAN057cqxOyJdMmYRPUXzTjJTZkfiT2avEmng=; b=
        uqDV/b/5DzM80mIqHnPt1Cp4dsLyF8LlLxdQaQqIyVzBKi42Hj7HtmU/GZGNU/Gu
        e0uYihjrQGJXHV/SrNIBNYTtl82rUnk7iqO+EjuKreLzXNChjM50qrAa2iYk30lF
        XXjX2pvl8z9QCwSl8ywuM4wGepO+8K/IcsU7E9qyRhN8UC1PP5sm8dopdUDBLLvN
        AvBY0RemeRjZWdl+k7P5Bl6mIg3Ky0CGFhR6UO5qGTc46faf5tz0sK+Ezg51g3EE
        NJLMo8129lTK3aBR+XldjaEMtHYYZ7Cw2FRk/bjXnFaaK3oUtUdSCKUKhIUihod/
        v9UZnF05evdI2gleAA9Atg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zTuG_9qfR8J1 for <linux-fsdevel@vger.kernel.org>;
        Fri, 18 Nov 2022 17:09:08 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NDbC80tBKz1RvLy;
        Fri, 18 Nov 2022 17:09:07 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.1-rc6
Date:   Sat, 19 Nov 2022 10:09:06 +0900
Message-Id: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
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

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625ab=
aa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-6.1-rc6

for you to fetch changes up to 61ba9e9712e187e019e6451bb9fc8eb24685fc50:

  zonefs: Remove to_attr() helper function (2022-11-16 16:08:31 +0900)

----------------------------------------------------------------
zonefs fixes for 6.1-rc6

 - Fix the IO error recovery path for failures happening in the last
   zone of device, and that zone is a "runt" zone (smaller than the
   other zone). The current code was failing to properly obtain a zone
   report in that case.

 - Remove the unused to_attr() function as it is unused, causing
   compilation warnings with clang.

----------------------------------------------------------------
Damien Le Moal (2):
      zonefs: fix zone report size in __zonefs_io_error()
      zonefs: Remove to_attr() helper function

 fs/zonefs/super.c | 37 +++++++++++++++++++++++++++----------
 fs/zonefs/sysfs.c |  5 -----
 2 files changed, 27 insertions(+), 15 deletions(-)
