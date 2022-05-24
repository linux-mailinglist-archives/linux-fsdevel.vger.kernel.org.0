Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA943532502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiEXINE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiEXINB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 04:13:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602477B9E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653379977; x=1684915977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UqHU6qXq3ZfqN8fsZ7FO5ASWCCqyv9BgBHH+Rs+FyGQ=;
  b=Mivw5b7B9kAcXChfuy52tG4A0fCk372hwA75e8b64heTRAYW5V+qb765
   rFDXSn+dSBsGNatHmEap1NhFMUfwdt0LTPljV9xmg1vqA6SnYMrXwKwLi
   4bVwk07NHFrTmosmfL6jLKFh/6qAR70SanyUwWLKK6Fqohl4mKHXo3DDN
   2x48snnSh1GXYWgpMQs5nOZKJN3xUBV2yN67kZUWMz0Pjyh58RJPGas8R
   vFPe994zW7UHUb2D1ygHCA1xlEBsEx5PuJ+XRCbuRQMS/9/g1grgMeBkg
   grTphAlKHqNYd2LzJ1CGpnUIMLTFmuCr1wqP3DYoj2In7rHoESsK2bKXX
   A==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647273600"; 
   d="scan'208";a="305488245"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2022 16:12:56 +0800
IronPort-SDR: 7YMN77vmlqJSFOYz/mGUzUglZZK3Xl6khtF+UMjOPR+TiuLbbhbkNalQ8RbOZKwZDnjThVDmx7
 IKgWzqqkQXG50iPA+68wsrC+ygw7OQfUVAnWt7I/enXtvKsL3Nqe8iSNTuRczPu7VotkNjMKDq
 inKlpsErOKjCx36AhtCISqQwrbuwPOOz0/kEpSHmd65uOvb6youeOkIKvcDF/eo0T6CzfSLVLm
 mgepe2Odz001jcAkGuyJQYBmgSHp1zQWOxrHdvLJSBZYRoDGzqTTIQ5GfUOLvIJ5bUdF8j94++
 rKR0WYdnBvNvJcJ9t8jNW+Bs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2022 00:36:53 -0700
IronPort-SDR: 0CCPA62E7Je9NqzD0a1nz92xhcvBMISX6QitAobyGyDek33c+8/jcaAGpjEqSGLaXhxKKxHgYq
 /1zDWCsI7vqbxNEwEpY1s7GdVwIv4M/GpILnjg7NQ6w6dgVy4E67r6hCFHwN3/K/zTz/xkpSQr
 rI5NcnQfR0bthy38+Ql3qlRi4McMHgOAZwpVQA6kcUu9lltsDdp9UAgA1vOt2aZpD1Hm7avYNk
 5+lSgK9AOkSI0UfK03PHclC/xxiVrMyd3BVrMl9y/pmAPEzY7a9YHry7M2H+L6NSAbmyH1hJLQ
 sck=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2022 01:12:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L6n4l6ZMXz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 01:12:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1653379975;
         x=1655971976; bh=UqHU6qXq3ZfqN8fsZ7FO5ASWCCqyv9BgBHH+Rs+FyGQ=; b=
        t57q+MYWTPIpRCij68MGqbWWK86emB7vVMHLh6ItAm++aWhY7cNn7vApi2rd9i1k
        HDB7xF0rTfhdexC7NzMrnJbW6b/7+dw/l+FR87wnHTgKjGmQthnzwaux6lR5cYKl
        3RP62p1VgPr3LWh76p4eftv2oBM26YbLVqr1PUPRsLbyAoVWDpQhis0d5mPCkj/e
        3EuZKGTQId8bPN5Ld7wP4OZ71KFQZuz4ulzqqJW4Lt4mTXgfdB+tr2BQY2tMYgHP
        ORPE1t/fVh2wTLcmMBy44h2C7znVghsGiOYzwOaonZjiull3EQCRPBBMQYOmQfnp
        OeNwGRG065DiMDyKWrt1CA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Q11WPdS8r0i for <linux-fsdevel@vger.kernel.org>;
        Tue, 24 May 2022 01:12:55 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L6n4l17qSz1Rvlc;
        Tue, 24 May 2022 01:12:55 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.19-rc1-fix
Date:   Tue, 24 May 2022 17:12:53 +0900
Message-Id: <20220524081253.989166-1-damien.lemoal@opensource.wdc.com>
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

The following changes since commit 143a6252e1b8ab424b4b293512a97cca7295c1=
82:

  Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel=
/git/arm64/linux (2022-05-23 21:06:11 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-5.19-rc1-fix

for you to fetch changes up to 14bdb047a54d7a44af8633848ad097bbaf1b2cb6:

  zonefs: Fix zonefs_init_file_inode() return value (2022-05-24 17:06:45 =
+0900)

----------------------------------------------------------------
zonefs fix for 5.19-rc1

A single patch to fix zonefs_init_file_inode() return value.

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: Fix zonefs_init_file_inode() return value

 fs/zonefs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
