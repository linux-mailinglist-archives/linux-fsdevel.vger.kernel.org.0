Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7522BF71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGXHga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 03:36:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1853 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXHg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595576189; x=1627112189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66T8pEMA0kxz+y3CwfHQsabnKSI7pZJxAM+SdkjBCxs=;
  b=BSIWxtvLfvs4OoeZhGnjodiWdkzncOAxNb5fWz8QGtnzZ3sdmKUx9Gcp
   P1vMzlBkv380m9p4wjxhlqRhdzFtaZ55VE7EbyYBlls2fXZtLnkWfjzTB
   v4KXtOIEERYTHEseBkMf5VA6oHnQ3FpX3Rmr+XZd1glxQ9A4GQLAes2K3
   yBujx5WCiaIoNhoBcpUIcfGqpCqoK6/wsE/ASPi0XuxCAxX//l+nY9GkN
   9vq3hY3yAetD+HgDq2/48lerPwvaAOXQ5P5m3FAt/NHlUnhqXl1QRrjIn
   lKkTJb1jycOaaj5buG1iWZZoFNqqq8pYYOzHCQozLIRXmWMFLsvlUfF4e
   Q==;
IronPort-SDR: 8jgn9K8DjeU113L66qCVMJhcjfQC17aUOoEcr8RZsO5h6ngsy8AolaLp/T4bQBmRhiO/1PfoF2
 0OYFbiK0dtQ/oUX2P5DvyZMZ9WHr6+I7T0XtzjIK7KsaI3GOK2wU7JJgJ0QiJ/vdnHd/aBY3y2
 0Q69Loj1iHjOrDYLJ+nNli0qK7XA0FeqdnqfJYO6L66HMSCcP2dkoz6Ehbf335o86oKtqfkhjy
 pzhoaCpvG8A11eS9h273s9lNCXeGxVwnTX5zuKvsI6xXtVRiyIzRzZI3dDDsNxi/OiQAybgS1i
 TzM=
X-IronPort-AV: E=Sophos;i="5.75,389,1589212800"; 
   d="scan'208";a="252583848"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 15:36:29 +0800
IronPort-SDR: H6w86DYJn2EddNqMtiz/f9Fh3SJTfAV1qlS+zp3w7siyMrGWX8UxqqAoYh92UzEvpr+VV3juUP
 HsQAtLdI4NgMdeajI/KuH5y+D1umLgy64=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 00:24:07 -0700
IronPort-SDR: XoqyNkZA3f8HO34aqTrNXeMwap+l+Ze9N7eNoMumqK6hC22K3i+rNcgoFt9lW006V81YdNDP5i
 sYNov+aLy7mA==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2020 00:36:28 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for X.Y-rcZ
Date:   Fri, 24 Jul 2020 16:36:26 +0900
Message-Id: <20200724073626.333882-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 5714ee50bb4375bd586858ad800b1d9772847452:

  copy_xstate_to_kernel: Fix typo which caused GDB regression (2020-07-19 17:09:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.8-rc7

for you to fetch changes up to 89ee72376be23a1029a0c65eff8838c262b01d65:

  zonefs: count pages after truncating the iterator (2020-07-20 17:59:31 +0900)

----------------------------------------------------------------
zonefs fixes for 5.8-rc7

Two fixes, the first one to remove compilation warnings and the second
to avoid potentially inefficient allocation of BIOs for direct writes
into sequential zones.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: Fix compilation warning

Johannes Thumshirn (1):
      zonefs: count pages after truncating the iterator

 fs/zonefs/super.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
