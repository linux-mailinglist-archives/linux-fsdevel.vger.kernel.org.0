Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7153C990
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiFCLts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbiFCLtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:49:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCC39BB7
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654256985; x=1685792985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nhu5NysG9JPBaxpdwYr2yXgINht9A1r4WJbvYD23+E=;
  b=GiolUfmqlKfI7x62knTx3Qag2vnUX560coyx27/OUNvwhujIWRrUL1Xf
   5UaRJKIfFlwVFesgd8L90/WI5Q4cBJy11B+SIsF8zS91zeNCzqJ9ugmXv
   gru79FZm405ycN2nOYG+vt9HSg9buwZ3izG/V3NjljXzvWLzLeNVAKn7c
   0OleHJjfCyDgtJZkmZs6MGK2P1tWFbPGRm8nCCnrGsuNW1CyisX4ssj6G
   MxOqdUzFdzX6vIF4UsqYoWEJ6FltE20/wFq2gfkafCzquIQdSpshejBVp
   H/CLb+lM/+0AxC5HGvXGaul1WXLkrhp0LmVjs682dYc5wL5CDHYsohQJG
   g==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="306454537"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 19:49:44 +0800
IronPort-SDR: BNja+oBTKaDcrqXkkOGyYMjbkaUHzSB2f2Ba8xgr9DJP2Yg+OtDV6nK+wYR78LQD6RHhHgcshp
 j9jCdcVt+O0xOS2dqGF15kgl8IrEEMOGu2DUEysODD3HJNzABSiVNYS2szL1/FJ2dfAKMYHX2x
 1BbKpp6tmyabGeDTOWzsFJXM5maR1svGzaOFLTO+W35vPy/WIbVcxsqel8Tsy3s+2MZX1X1FF5
 8eaTJMSYPR/Z2kV4SBUHH3odIhmBrihGh5k8eWNWnbDhJjcHLsHsnc2NutGh4auQyJ++EThrr7
 MhVNVsEMHhEGe+KNL51xJKWj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:08:48 -0700
IronPort-SDR: jdJZo8qD1vBeX9noSxcCnJ/FZW6j1kjonUthjmWwm0gc+UQTEmIzzdmiZj8iQ0HF1rnfTVulGe
 WoFQa0qG/8JX3+UT+/nJ8+3uIt8ZIuQB3aAYvJMO5kFD1915GlmP/fhsMq8SPKpceyJez6x4ku
 zvdfvUizr9+8Leuad2cSvkkAqRQNihSSH7Bznj2T6S5O6wZWi9bPCPg1dN6jlpIs0zpYKdcupz
 pu5ApKkk1xxH+HhdbJmpFnyB/Noj2xCAVupI+B5rKorl7Z0uaLzESRzaDUEXGdmRsw3aQOWnt+
 s+k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:49:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LF1QJ0bKqz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654256983; x=1656848984; bh=9nhu5NysG9JPBaxpdw
        Yr2yXgINht9A1r4WJbvYD23+E=; b=jCYLnkGkuhne/HX74rz2WSqMTU5xMgRkGJ
        nURkjoW888MhQTWoAZLfHtltnFAfNzSU/t3uKrwl+BvYDstt+Z40US+UwTwXoyYz
        Q5/Ft3eDLaxIYLwpwS+5qO5er+kjouitEAzJzRTZUrcQCcIx/uYBHmq/7X/aCO6c
        GoA02Jfxl927JkIYgVQ63xHm3HTlQyoUjGtq6GN5hXWm9E9N1bXxO6QT6qXUABmW
        ZgQBwPHKTmraj6MA9QuNBgi89N+Lv7DAxgwCmxW05jaxYWSkPlPkIFECJACTC4DU
        cWrSPBtZEtEw4vxjhNCQKWq5dmOOOPt15cQdOCGWbS2ndxGEhhww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MaQ5gM0fZEiV for <linux-fsdevel@vger.kernel.org>;
        Fri,  3 Jun 2022 04:49:43 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LF1QH22BLz1Rvlx;
        Fri,  3 Jun 2022 04:49:43 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] zonefs: fix zonefs_iomap_begin() for reads
Date:   Fri,  3 Jun 2022 20:49:39 +0900
Message-Id: <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
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

If a read operation (e.g. a readahead) is issued to a sequential zone
file with an offset exactly equal to the current file size, the iomap
type will be set to IOMAP_UNWRITTEN, which will prevent an IO, but the
iomap length is always calculated as 0. This causes a WARN_ON() in
iomap_iter():

[17309.548939] WARNING: CPU: 3 PID: 2137 at fs/iomap/iter.c:34 iomap_iter=
+0x9cf/0xe80
[...]
[17309.650907] RIP: 0010:iomap_iter+0x9cf/0xe80
[...]
[17309.754560] Call Trace:
[17309.757078]  <TASK>
[17309.759240]  ? lock_is_held_type+0xd8/0x130
[17309.763531]  iomap_readahead+0x1a8/0x870
[17309.767550]  ? iomap_read_folio+0x4c0/0x4c0
[17309.771817]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[17309.778848]  ? lock_release+0x370/0x750
[17309.784462]  ? folio_add_lru+0x217/0x3f0
[17309.790220]  ? reacquire_held_locks+0x4e0/0x4e0
[17309.796543]  read_pages+0x17d/0xb60
[17309.801854]  ? folio_add_lru+0x238/0x3f0
[17309.807573]  ? readahead_expand+0x5f0/0x5f0
[17309.813554]  ? policy_node+0xb5/0x140
[17309.819018]  page_cache_ra_unbounded+0x27d/0x450
[17309.825439]  filemap_get_pages+0x500/0x1450
[17309.831444]  ? filemap_add_folio+0x140/0x140
[17309.837519]  ? lock_is_held_type+0xd8/0x130
[17309.843509]  filemap_read+0x28c/0x9f0
[17309.848953]  ? zonefs_file_read_iter+0x1ea/0x4d0 [zonefs]
[17309.856162]  ? trace_contention_end+0xd6/0x130
[17309.862416]  ? __mutex_lock+0x221/0x1480
[17309.868151]  ? zonefs_file_read_iter+0x166/0x4d0 [zonefs]
[17309.875364]  ? filemap_get_pages+0x1450/0x1450
[17309.881647]  ? __mutex_unlock_slowpath+0x15e/0x620
[17309.888248]  ? wait_for_completion_io_timeout+0x20/0x20
[17309.895231]  ? lock_is_held_type+0xd8/0x130
[17309.901115]  ? lock_is_held_type+0xd8/0x130
[17309.906934]  zonefs_file_read_iter+0x356/0x4d0 [zonefs]
[17309.913750]  new_sync_read+0x2d8/0x520
[17309.919035]  ? __x64_sys_lseek+0x1d0/0x1d0

Furthermore, this causes iomap_readahead() to loop forever as
iomap_readahead_iter() always return 0, making no progress.

Fix this by avoiding that the iomap length be calculated as 0 by not
modifying the original length argument passed to zonefs_iomap_begin().

Reported-by: Jorgen Hansen <Jorgen.Hansen@wdc.com>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 123464d2145a..64f4ceb6f579 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -144,7 +144,7 @@ static int zonefs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
 		iomap->type =3D IOMAP_MAPPED;
 	if (flags & IOMAP_WRITE)
 		length =3D zi->i_max_size - offset;
-	else
+	else if (offset < isize)
 		length =3D min(length, isize - offset);
 	mutex_unlock(&zi->i_truncate_mutex);
=20
--=20
2.36.1

