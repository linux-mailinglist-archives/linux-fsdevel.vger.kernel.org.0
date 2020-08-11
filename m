Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D400E241868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgHKIpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 04:45:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48671 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgHKIpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597135535; x=1628671535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3QR/fZGXYtzOi7dYupt95OCb87b/iCpow+vQND0CFIg=;
  b=SPzg9BvyGUsA3BrwkHm8HpxMGCMTVaHP+5ou17OluHta4AsFcZjtdvZ4
   s05xo2mQRH4i281mW7r18kTCb0DHJ69kOpqnIVljzypkmxvk9wbNf3WOD
   kkgHBNRdhYjIxdatdaVJgePBNVO2DeHPygKLTKtA3OtXUf3SAxR7iLHtK
   AIuzhVPs/TES/l/nfMabOItkK3vCREyGce+W6sNywZGW5aJLT06EkruxQ
   Yw1Mzfp/CmzFwU4uZ3r4swv3NDIKGuipqtUhDmURthV/5qZhhrUyAQiIW
   xQ+1HlHHgvd7PKleKOpQ3OZMivssvXnB7rwANyweRDHiLB+VINRny2/la
   Q==;
IronPort-SDR: cNzn24BM6GNkKEktZhZCUrh8QDC9MfK1bQXNbWwzXV+cpDfPcFKNjBYEa9UraezuxngAh1ipDJ
 CG38jvsY4w3Ab5MQJa1cYo+CEBUlbr7y8L+OWqy4J78TzxZlN240WyTmVq3b7ZHqAeI1dTyMXL
 spPLhC9kRz/9/B7cD4EqXE6VeZfKzbCbufc3va2VZ6Rho/CD1Y2a16XSTmZuuwuxbqvufsSXi8
 7WSYmlARIB4DyD+h0IioZrU9YOThYhMs28yYW/WfW6MZCUspFmMaHhW9BDzyjrrTk4C27Fo7qq
 NKc=
X-IronPort-AV: E=Sophos;i="5.75,460,1589212800"; 
   d="scan'208";a="145882292"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 16:45:35 +0800
IronPort-SDR: XL6FEoxmGJh7c9ieZ7YabG5JBMZWzfvf4U4VBRik3Z1XPIhVaCVuPuVwLkBv5y7BKeN43dFttw
 dTWiTCta+b3A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 01:32:45 -0700
IronPort-SDR: YI5ZSe3fKDs83PxEqAfXOMxLMsuOTU4qQNF6pkPB2pQ6vEvZlBYtpBc3t/l662Uo2RnN0x9tHd
 8gHSI/LdPPXA==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2020 01:45:34 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for X.Y-rcZ
Date:   Tue, 11 Aug 2020 17:45:31 +0900
Message-Id: <20200811084531.677853-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 00e4db51259a5f936fec1424b884f029479d3981:

  Merge tag 'perf-tools-2020-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2020-08-10 19:21:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.9-rc1

for you to fetch changes up to 4c96870e58f8bce1c7eba5f92ec69089ae6798f4:

  zonefs: update documentation to reflect zone size vs capacity (2020-08-11 17:42:25 +0900)

----------------------------------------------------------------
zonefs changes for 5.9-rc1

A single change for this cycle adding support for zone capacities
smaller than the zone size, from Johannes.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Johannes Thumshirn (2):
      zonefs: add zone-capacity support
      zonefs: update documentation to reflect zone size vs capacity

 Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------
 fs/zonefs/super.c                    | 16 ++++++++++++----
 fs/zonefs/zonefs.h                   |  3 +++
 3 files changed, 27 insertions(+), 14 deletions(-)
