Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10253320E59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 23:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhBUWre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 17:47:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63688 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhBUWre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613947653; x=1645483653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DKxbyBQeBayu0rlHAkZivg4VEy0WRojRA2hx5nvm/ok=;
  b=qHg7hBk09Kr+XVRrVhfDwVKJb6cx1nCEoZsw8/8wPhTjhcecJXjWIDCk
   h/2Yth5QOTWtWxN0ScCAJR1sg9dYCyvorLfgyaPHn+VX0Pi5FdSdoiQzP
   o4jhi14Kaey/MnRlVeJzr4oZ/6qrFqt8UvwXr3RVKk4FtsKyem5dRiy41
   nQ8wXViHTXojNN004QaUizG/CHoKhMBCGFENPRx3gO6eNXpC5sPL2GWlX
   g4VNQBNLpOIRYxVApmytSKujO4w7xAcw8WH1SKdqibwg7DdTO2fiLoqF5
   Q58D0ldjbI7VBdiDkCDhXuoTfdvruTxnHFAuOaiG0NftDiqLM5RxO45vU
   A==;
IronPort-SDR: aSc1/mKWDc/m1P8IecmjeL+gTdIqA6OiACBxLDfPvCGDmT1JTKfyraTK7iaBtAdxnmKQAnFxVa
 N1jWGaovCEkQqfFMB8WjvKQl/QwsOfiAmKhkLJ3gyIp5RD54kMdmiXg4LdFV4nCXHdu03aanZD
 XlmgsaLjzKKD6gqlD2HR/8yb39nFrIs8WBgD3G9JcqL7E1jvjHYEqS1bikB2te0auNHAQ86dNz
 CzP8WqU8z+PmP2dj5hA62pV5MN9EMWhZg2PFuFxKvKHmgm7hDWCB/9zPotZFsXxMgzoaIe061L
 BqA=
X-IronPort-AV: E=Sophos;i="5.81,195,1610380800"; 
   d="scan'208";a="160445298"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 06:46:27 +0800
IronPort-SDR: naraTMr3QhOKey2/8P5bqWnkgexkTHKi3ITTcyTTEBzfb4L0pJJ9JA0D/yAwfdeCvr2c2ShjfX
 FXZyllpmCj0hXCK3Qt6+hzJony8OxOmy1tgrn4Zy5Vt8A7pTqmQsjtyhD7RbX5noyxwDss+OfL
 qqLjkAwishKlVUDXxPOEeUGkl8BxigALh3Himzn79LHyuWEEDlsMB4hWH6/kp5ZanEcMdQJCsW
 9H/PMcO8mw2XgA5831RkBgLJSFdezraXT2oOOmeeFdnSJA68dQReO/QMunQUOK5BnXoBDgGpzt
 z7u9EVmpcHMiV4xuBb3KDBK2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 14:27:59 -0800
IronPort-SDR: neUE2hs1iDnkwvR4dJoQ46obM90QjSI3JTc7DJonR+FP3yTotjn3S1gSh3P6l+5+065ZN1d4kH
 3tatCK188vYqZVdpr64SSnZdPhbgjAUp8dZcZlap+MwOPcKEixcNE3e3Gckr5AVEP/axoqHaen
 XNFrCjDVGD5J2wAaU4byBNlGoo8qcMQsmBlGhvJA80boBFLFoWl3zxgtXHmvAQnnor8JC32Jro
 RPAKq/4YFZugrrF5UgmmS8uWzl2AsN/BZ7eZ3fW7ll3kNlQFQ/tR3jxroElxlXMda8DNDFFf3E
 XKs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Feb 2021 14:46:27 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 5.12-rc1
Date:   Mon, 22 Feb 2021 07:46:26 +0900
Message-Id: <20210221224626.392359-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc1

for you to fetch changes up to 059c01039c0185dbee7ed080f1f2bd22cb1e4dab:

  zonefs: Fix file size of zones in full condition (2021-02-18 08:36:40 +0900)

----------------------------------------------------------------
zonefs changes for 5.12-rc1

Two patches in this pull request:
* A fix that did not make it in time for 5.11, to correct the file size
  initialization of full sequential zone, from Shin'ichiro
* Add file operation tracepoints to help with debugging, from Johannes

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Johannes Thumshirn (1):
      zonefs: add tracepoints for file operations

Shin'ichiro Kawasaki (1):
      zonefs: Fix file size of zones in full condition

 fs/zonefs/Makefile |   2 ++
 fs/zonefs/super.c  |  10 ++++++
 fs/zonefs/trace.h  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 fs/zonefs/trace.h
