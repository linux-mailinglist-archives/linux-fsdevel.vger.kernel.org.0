Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4834797A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Dec 2021 00:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhLQXtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 18:49:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20058 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLQXtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639784950; x=1671320950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4FUivl/lVgkRyzhvno9AHlLyPIZu4up2HJm/qGT0DUs=;
  b=Gyi6yM3oLa1BkGSZyonTXci0q6IR3tQ/vP6ohnZEBHBSb+4N5xLbmUiB
   2wc5cmOW5Qk2bc0OHh4fFPijt+DHRbeOMxo4GlP51xdcyOgX/JEknXzPU
   A8AjMSUvHAZtNhHoeX6LPRIbV8oTwDtybURVVaorw1rKEe5GBWaFF3Qe0
   kbmnNP5Y/EUrE3WpcmQWypKPvJwUic6l/p0zgEC6rlYIqTAyGv0M8IuRh
   GZ5urWqpMzYQdiV48to9AMG6H2gtvbAe007D32EFhwLljNCJVggmPrys5
   yrNjxcjytMOqYg05D+Y97sKWOkTZQhz4OfNiQwytCuIwYLENYRIXu8hp2
   g==;
X-IronPort-AV: E=Sophos;i="5.88,215,1635177600"; 
   d="scan'208";a="188542658"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2021 07:49:10 +0800
IronPort-SDR: 0ktUQA7jtN4HibAAmZTF70UFXCs0zfohdrefLfMcnKxsN8c3VYPyQsO9Lwdft799eGeD/c0c06
 hdlxe/c/d2pPJawnBaXdSGhCxibAICS7hurJC7Z7b/OEfwd/+n8sNVSRdiDagN/mKJaxU9ekV7
 2FuGVdLreyXND9AoizCgDugBWibPICihanzTUj1+4jUslpD0sXbWddKsI0yNJjLLSU86Y6KtGf
 qCNVncOe3M8Ol0z0CqXM96tpJFsyLjbuSjliiQrW6LXsaMCtalhOjjxbdzJjpup/luSkcQkYxR
 qIZ1mMI+Z2jaQVKHdgGM6jMB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:23:31 -0800
IronPort-SDR: lsq+5i0WBnHIIqjfDRl8c/h3jOqlrdFT0bqeOqZGe6o9/+47qHOYpFC7wKnT8pdgDAD+O+vX/Z
 KIwGj4MUSlFk1VxxNZLx3JZNl5E2zLBWh3Y8GFQts7StlHegFwCnNCNTuJ8AzFFF/LBGj+rHPs
 oY+bJRh7aAefz4x1KIWGtB1rRSaL2ZoShC3QSZIz9op3a8eFSdIb+l7f/cWefJkeOMXmBFE+j9
 sWqh/6rSR/EiWpQfxJULEQocqCKfZzZPOnRT7G9VsUoaMNWKFp6vk4igmNyb4IIweQDiaIIKGj
 hxY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:49:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JG5Kz181Lz1Rvlf
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 15:49:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1639784950;
         x=1642376951; bh=4FUivl/lVgkRyzhvno9AHlLyPIZu4up2HJm/qGT0DUs=; b=
        OB293gpfyQ3KfECBl6yrqtAk6k8dQRP1UTDYpITh8Gicz9ZokWSFjAAJBbKpqLsQ
        lKE2m5NPf2wi4ePKWxwvna/8tNksuL11KcjYLeWcfUMNczryXA49SRF/OdkTRW9Y
        iTYjHdSZ8slNocMp3ZYPLVTnEnRLqnjq3PHmdk3DRjl3sqLpdLuchv5wM9o+3Uj2
        AJdxM29GrZy7Jjv4TnHJujiyYNfdl7GyJhwgmXxxjwJPI2ZVtID8Acl+b5XqPi9y
        pZ2GwlISOQBdfYllg1z+1wQYfr26xm9hlTeZUxdABNrI9s0AEck41o2HTkwd4rKz
        EHYWpQi0dgIEDe4NGFRFzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wljlvmA3iH4l for <linux-fsdevel@vger.kernel.org>;
        Fri, 17 Dec 2021 15:49:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JG5Kx6sXhz1RtVG;
        Fri, 17 Dec 2021 15:49:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.16-rc6
Date:   Sat, 18 Dec 2021 08:49:07 +0900
Message-Id: <20211217234907.303996-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Linus,

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e203=
9c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.g=
it/ tags/zonefs-5.16-rc6

for you to fetch changes up to bce472f90952cc8be03dded25c4aa109d27e5924:

  MAITAINERS: Change zonefs maintainer email address (2021-12-17 16:56:49=
 +0900)

----------------------------------------------------------------
zonefs fixes for 5.16-rc6

One fix and one trivial update for rc6:
* Add MODULE_ALIAS_FS to get automatic module loading on mount (from
  Naohiro)
* Update Damien's email address in the MAINTAINERS file (from me).

----------------------------------------------------------------
Damien Le Moal (1):
      MAITAINERS: Change zonefs maintainer email address

Naohiro Aota (1):
      zonefs: add MODULE_ALIAS_FS

 MAINTAINERS       | 2 +-
 fs/zonefs/super.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
