Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC57E30A39F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhBAIyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:54:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59406 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBAIy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612169668; x=1643705668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7dGYzeLWW4wl8EYqV0toxgCzcdURANZDs1hKBF78b0=;
  b=U0kxzg4dQk3nyyAEBGGdT/3bc5WbVa37A2c6K4nUeDjGCynjQd9o5gBt
   W9Fea1ia8hhhv13HUwcgbiI8zupTVMVTWxKaXY63E/OCLGfWr3glQ9B2W
   SU+CU8D0aapu2a45kM3RABO/WR4H7TrLWBhdxlrArFkq2I6plwmChhd5A
   kWg2qwIc05V19uO//7fqA1Jh7tSY7Sq/IV9c3Imh9lHXKlPA083B+sGoN
   Rle5aIfAfRafe6DraNlNVQuJXW3LgAg79bf5NJCnoiORjAVPhNZWDWn9p
   a357j2qSP9LBDT2elvmJdF32ezluACqnfMIx8JFLcfJ5JrIii+JSNLppx
   A==;
IronPort-SDR: kBP7i78lc9yIUy+dQqLG42RuPt2QMZ3UtsifgqZlJahAabarN2ejTb0omn81BhSzeqz9fM9l7N
 rWQYj4IumQZFf/x/9fYb3rzvKTp/8VrxVGphLRLFue481hg9A4S0kpc/vAYsLpw/IGiFiokcPF
 W1xfCqRLebzK3kooxe7lGn0gS30jX2hGuuye7ok3v0U6AOiHcMJnrd9xBfXcr00NhV7CPM28pm
 p7nV1Xx7P2X5K2jT/A7q6nyY5Dn0aqGow8iqJgI34Vb0DrfaXJnAG1JjT+LWl2XfDvIoVS11Yf
 /ls=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="158797708"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 16:52:23 +0800
IronPort-SDR: bxvQg72kNKDjMKOhHWLOFeKLmqTrpnC5B/qQG+ocslNTlFGBnCQWWby8v6xbq4bUqAVhc5ffHO
 LJ3Fx4j34tpQem+8s5bkvrC3dxM7TH7lUyOeEK/CLCIzHQt91urjEInwjiLbQrfD8XkNWe5OWv
 oVOz0A5qVWlWjdopnOvQ9xBn0lc9Xt4hjoCw87VYX1kmE5Uv+844vZeRhem02IW06G6npv4D01
 eX5Axx68plIjtoEd+p+Ka254yr7OpLxuL56fy0yNLc0OjaAp5dpC3r0WGp46D/4OuczvsEWmPZ
 zrWXAoyA4A/08zUt0Jd7/odO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:36:34 -0800
IronPort-SDR: 7/8Y5EVz2Hr+tlGAWztCNwWy9+oLVrlOVgQzPbA/GUGvThihy13LqGfdn+F/2r15eZZsQwWtel
 Pzwew2Qrr0DEmorIw5Dn9Sjer32063yA5ZrQ7afyEZShXzB2ZrjKHQ2T3I0wXQlPMioOuMTh3M
 I24j2pzc5vPfkVY8OkQl82nf7vz8/xYNY8Fb6ZJxKAZiBdD7NyEup/XJhmIjaoZSNyyYIZ8h4+
 sd3ZVwT1Xh4tTLu/BpfkHy/nxxapUIpySz96K1admvSPo8CPubqY0wvJclWgcZBLkH7TWn+Gqm
 a9s=
WDCIronportException: Internal
Received: from 7459l3apk6t.hitachigst.global (HELO naota-xeon.wdc.com) ([10.84.71.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Feb 2021 00:52:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH for-next 3/3] btrfs: fix a typo in comment
Date:   Mon,  1 Feb 2021 17:52:04 +0900
Message-Id: <20210201085204.700090-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201085204.700090-1-naohiro.aota@wdc.com>
References: <20210201085204.700090-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes: 9e802babe329 ("btrfs: allow zoned mode on non-zoned block devices")
Reported-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 362df27040ff..746066d2fd3c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -490,7 +490,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 		model = bdev_zoned_model(device->bdev);
 		/*
-		 * A Host-Managed zoned device msut be used as a zoned
+		 * A Host-Managed zoned device must be used as a zoned
 		 * device. A Host-Aware zoned device and a non-zoned devices
 		 * can be treated as a zoned device, if ZONED flag is
 		 * enabled in the superblock.
-- 
2.30.0

