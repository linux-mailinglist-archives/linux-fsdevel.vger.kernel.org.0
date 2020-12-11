Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E32D74C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395022AbgLKLgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 06:36:03 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50483 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391856AbgLKLf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607686556; x=1639222556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LQmobsCngoUbpvuwFIP4z8Ink/Qm7Ggb8rdVGEwpAjE=;
  b=VSTqTWmnOuQQJZThTiV7j5t13f/tHpy/vxM5TyHTQFLEdAe3+qWQikOf
   m5f83/lnMssPjeHUovRrXWW+81hRVC/WiSPIMB35+13dMw7FDsLFu5HzP
   i0/UCbUTDm3RTBTqrmA3pqbJsH6hrKs8p/9xLgUbG6FFlvIe6BWE/WBIE
   cDDmIojqduNGUNnW3HLzpqgdn8th4IUsag5Srs6qFO4ulVEeJobIZHVIW
   VHqBzW4gohp+YlDnflipJWltvwbfZDGERHl44Z6H+/8XOeG9/Q4IsTcSm
   xXNv4ybQMIE0BNIfysEfmlh469h7Kyj1xmaWYCheERZ/JXYnXYbFQR9Bb
   g==;
IronPort-SDR: e9n2QwYvl6wIF7TsH6t+Q2jGNwdeyB9YuKqx/O9K6pBWnRql5HEbjsN+UwpYv+2SUS3J8dyPgl
 b4Bxati1Q/2mKj+j6IdKT+a+cI0HObLJRiTrdjg+9u4eXR5YY2gLBvo0WEyYNGRQwpUov2E0lK
 qYHjT5GmTug1ajHk3+vHYy8kRV20z2yQAJv203RZWKq9w+4/cvjHeKO8UrhNSL1Rf7k0YBWTbP
 7QNliwH4zdbD/qxELkRdGILTsBx8WOvLIlogtFLGM0fcMIo2qn/VQyA8wSGBieDbJ+4USehJOM
 Ac4=
X-IronPort-AV: E=Sophos;i="5.78,411,1599494400"; 
   d="scan'208";a="154983919"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 19:34:50 +0800
IronPort-SDR: /sc8ja0IocXxqB1t+oR+/1btz084eXVaaqHBD+a+A/M4y427y7SJAICfUqGfYrSSovI89XOrar
 UNatkA03lhSEdTVPFo8r0dqZL9jWHIjLvgNGef1NN+1xsnP6Ypk431lv3QAkwx+fjOh+md/ptM
 cfgVKwvD2004VDzRO2YKV8fqCq3j5REgUXsMFy5lm1mELKkPSoxFZ0QD6ZdiyaTUlWzChNW6xt
 GTlKMcAhyVnrSqBF6nuor8BzEC3DRe6WvkXQ05Ph2UYEOmBh/0o4XUFYTybGovk8LM/ZHwA6uw
 jKl5w2Qlw9u4DQ0o601D0RrS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 03:18:42 -0800
IronPort-SDR: hANuEweJTDN1oyh7IAhMONjRhASOg8buNgrGaJUiC9kbTwUESyv6Ch7Eed57vy+Pqr4vHcBAb6
 kKQwXpmPDa+ThQKYr8r0Y5Zj5x20yH9Ik4+lNWYM6E0DEbsYrtkK53/4xxVN79Mr5ngRiY87TG
 5WP/0GdyDe0+NIJBvuHoAfwN1m7TGdg7geoMX95lCX5fm/8nonORbu6OuBbd46g531mny6yJVb
 A7wOgCpyPlCGOnSQDYymtdvkXDT24gZdqVQUaDi2EihAkh4iuqU6M4kKvtMXqVH1Voxs/Lhgzv
 Euo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2020 03:34:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 5.10-rc7
Date:   Fri, 11 Dec 2020 20:34:49 +0900
Message-Id: <20201211113449.460981-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc7

for you to fetch changes up to 6bea0225a4bf14a58af71cb9677a756921469e46:

  zonefs: fix page reference and BIO leak (2020-12-10 15:14:19 +0900)

----------------------------------------------------------------
zonefs fixes for 5.10-rc7

A single patch in this pull request to fix a BIO and page reference
leak when writing sequential zone files.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: fix page reference and BIO leak

 fs/zonefs/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
