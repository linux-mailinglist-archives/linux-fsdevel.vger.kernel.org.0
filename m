Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F799292098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 01:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgJRXZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 19:25:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 19:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603063545; x=1634599545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H6asmM8JYhgL6UaF7hfRcpwBuIRRhagpY+9joP8wiqs=;
  b=BFnt5BtE4nwaU+no+PKRmgoV/kDe0Rev9/Uat/fXsh/LNT0KkNkxM1f+
   zS7/+Xrlz01/JkiYO74sfpjavfp3w2LGpbHVYCG/lPgU+87NS9loZSbGZ
   JNOdGZCdq2q/WYlZYuQZFvDeXgzUSRAmb/Raos3lslfbbUUQQUohtsebe
   2JbH30QEOyHdrO0e4GaHImb6haEU1Ki2LeBKRL4p1yzcB5fmd87AaAomD
   5dkr+Ap3yPbyeoQnPJLyrvMwYo126dFzXVzHZXAOr/6JKFquJwrkUtGeY
   M0+SLlrQ7P3bdN15bIrolOz6iHCiaUExqsZXiOdGctbqmgZmxjBB4sGND
   Q==;
IronPort-SDR: GnfmA9VSNrNMy6+i7IfUP55sVAVvLXlh/QqWhRP/bOiESMRNyfAixbcuLyD4kFhadgT0h0fefG
 H1wMzfUelx55iZhCVRjVcGYN6hmSa/MQQeFLqBLG97dZ/19HRoZjwqd6ltuMgeXE7gV0zDrxJD
 +d5Wlf7Q29QoJbN5OW52K0G9ZVWWDnbDBeSYoMyPsYSs3wm4xjSiOiG1tUWlzAXrTXxXzm+D34
 re288/8Bg1EuaajVpDWEPbWz17Ku9/0wkYJFnBA6H4pwUJ3bAPF9h14tYsqaG7XlADAFlZoQFK
 ByU=
X-IronPort-AV: E=Sophos;i="5.77,392,1596470400"; 
   d="scan'208";a="151501958"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 07:25:44 +0800
IronPort-SDR: 6pxabt4dsuJmNS2z2t48prK5wCL1FdhEuSDtY2y+cBCGTET3F14HtfP/7gsxADt/SpCFifM6eY
 LBIISnndD34DsepDcfLFnihi7R233nLz/OAt82wIbVa360wMMlP5RFAfb0ui7wOOBq2p7aQ9QG
 AkHd3/2tkGwiKxXtnBs5lJ7ZPBmJdMmYSiQE8eGSnmZfAfNmpr4f6Jm863kqZaRgrWVHgf0tob
 jiPM3qBXHs74bIgLBiNui1GWUFjCvB0oBP3b6hkfjLao4Ne+O99SKdABObNP2HusVCm4J171ar
 GhxkH8YeCAp/Ut/6k86omiPW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 16:12:11 -0700
IronPort-SDR: HsGjKWryK700DA6+Vp2eQAR4zSELsrV6eG9xd6ViEJt14mv0ndu8lCi1wa3V9pfUvhZw/q4AT8
 eKl1JNsQmcKp3UfwxmyvG7+L7r24BDv4uYEt4GNLcW6eoeNIdff4ER87MIZ+xEMLBudsQE7R3B
 mrxWRuUwUZevXYFzri2b5fyzDlPX4iTSahi8pNM1qSGk4wbjd0HGT98fmfKgCrA/tidQaiF1IP
 6jaFRT81o/TzTFOwwuM5fJ7h3bBksfLJ27MwN+eSCky8G8hLvmEtZXt6cwUEcZSPXJeh9Swpqj
 xQk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 16:25:43 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 5.10-rc1
Date:   Mon, 19 Oct 2020 08:25:41 +0900
Message-Id: <20201018232541.87913-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc1

for you to fetch changes up to 48bfd5c6fac10e10b7066bf4aeb919ed9a4e87d3:

  zonefs: document the explicit-open mount option (2020-09-15 18:32:58 +0900)

----------------------------------------------------------------
zonefs changes for 5.10

This pull request introduces the following changes to zonefs:

* Add the "explicit-open" mount option to automatically issue a
  REQ_OP_ZONE_OPEN command to the device whenever a sequential zone file
  is open for writing for the first time. This avoids "insufficient zone
  resources" errors for write operations on some drives with limited
  zone resources or on ZNS drives with a limited number of active zones.
  From Johannes.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Johannes Thumshirn (4):
      zonefs: introduce helper for zone management
      zonefs: provide no-lock zonefs_io_error variant
      zonefs: open/close zone on file open/close
      zonefs: document the explicit-open mount option

 Documentation/filesystems/zonefs.rst |  15 +++
 fs/zonefs/super.c                    | 221 ++++++++++++++++++++++++++++++++---
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 233 insertions(+), 13 deletions(-)
