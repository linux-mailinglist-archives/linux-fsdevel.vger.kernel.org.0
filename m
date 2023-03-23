Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565556C6545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCWKiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWKiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:38:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632E366B6
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679567733; x=1711103733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UeFnFT5eZAkLWphTFp0Isqc3nAnjGp5MshA8/NnQxUk=;
  b=RMCsQ/TMvgaiySv4KgJ8QG6IdzaBAyXwj64a0tq6esdnvSDyPVWNBgbB
   3lkcq88brrmg5+aSDKRGOUd9jqZ+UDQ/BAjZvtrfc3RayGBHb5wjqUReR
   H5HTSdln3dbNBjJvmqXhQFfqjtDCzyXSq1gPByOfuHxFPu3b1PBhF9Q52
   45to3HAznsyCLgPeISr5KrhFr0cpLt8vqbfE1n14hb/vpp5PF0jTHyXL3
   ARAsQ+MHxzPGEBAqgIBwsldEOFChsH5j5iXIdR2ccDIjBCIL9NDeEa1Fa
   GlUW0zHxqb3+KXx6e9R8HKAg/e0PodbBYROHmy+6QzrYrZnEBoIxThpFo
   w==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330738397"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 18:35:32 +0800
IronPort-SDR: DmrMSxlDQcGM4H/Ist+BT+MHSfLz3bVQIEFDoknc7J37RfDc9EXHuay7NJ5vwnB+ygIa7zd57y
 deNGUhwe3qhVNNIfwTOGmwj1Ium6uRHnBG65H3TgLg6wvhkcS/YeJ6F47LbN54EijjFvDt1JM5
 EibMFiYMHwkFD4vYVk34ySfxOoh4xk0RNXUbZmXkmKuVNOhW8PlBV7DxZaR10iEkYoJ3JccUzA
 dzCF64fr5H3YYlxMBNSQ2MQNhsOqrUOhGb7V5ied1khsr9dW/IQpltHPeEOd8HXKlrs3IK+KEV
 xFA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 02:46:08 -0700
IronPort-SDR: ZQMZTzW2tMI52NKzBXW50tSJxRocZaQfa4797N2J6uCljm+4yTUn5F0paIJrHtb6UNlf60sFId
 hRZgVNb0BLQ2K8AHgvHJ2JQ6RUfCZJMJ6+lTw6C4/4n2Tas5FnZM2nOKEvWlYEeuiMfSwq+8GN
 onRIVs7rJPbVi1QvzVr5O2/4rCGHbY+UItOacCJsNRylxfPjwUcQIV3LGNlxut7zfvcbiPN8bj
 BS6LSFUBh8qkyR+yvngHecTFYaw8goSgf3S7f9NxsuXmqWvrobGJrBir8DuwH6boHrmlPCzdiq
 NPc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 03:35:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pj1vS2Mvxz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:35:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679567732;
         x=1682159733; bh=UeFnFT5eZAkLWphTFp0Isqc3nAnjGp5MshA8/NnQxUk=; b=
        LUME3KhMaBMaHNtx2tC/PyzDpib1nqeyHw9sdTnnTQrYf9lb77EGChpHHWd6HBJZ
        EUu/L1JLIDMUGHDltS1nM4pt8MhM1+Ft463JA8Wc0RIwjJbcpSem1ZauDRuGenzP
        x0qf6sIJoViCyGuIrIgbAmONmahAvu7Km5C+1Ix3n/gBqrJN/mo958aFlTNhxeB6
        BRpxoou7YWlwJcdJglsFSAUVLgMmXPmQAHoZbqwhuq28WngRKhFurdqFLhObI90f
        +49APf7GHA+zm5SlsdDQ8HK9n+mlBeD8FFRdruCFSdUfB9dPAPIyf9UbvRLPj5a2
        CWhQjZsi5NbjEbnYyr4djg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z2lI3eikpSnE for <linux-fsdevel@vger.kernel.org>;
        Thu, 23 Mar 2023 03:35:32 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pj1vR3vbfz1RtVm;
        Thu, 23 Mar 2023 03:35:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.3-rc4
Date:   Thu, 23 Mar 2023 19:35:30 +0900
Message-Id: <20230323103530.365717-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da=
65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-6.3-rc4

for you to fetch changes up to 88b170088ad2c3e27086fe35769aa49f8a512564:

  zonefs: Fix error message in zonefs_file_dio_append() (2023-03-21 06:36=
:43 +0900)

----------------------------------------------------------------
zonefs fixes for 6.3-rc4

 * Silence a false positive smatch warning about an uninitialized
   variable.

 * Fix an error message to provide more useful information about invalid
   zone append write results.

----------------------------------------------------------------
Damien Le Moal (2):
      zonefs: Prevent uninitialized symbol 'size' warning
      zonefs: Fix error message in zonefs_file_dio_append()

 fs/zonefs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
