Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6241315A1AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgBLHVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31626 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgBLHU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492102; x=1613028102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bC1YuEFrwP0s9alZ6tyPjEsEGuzZXo4rtDBMqWXlLkU=;
  b=cBAolUIw0VAfnXzPCKS5OrAVeuLjgtPccj0TxZ4oCZT5ZnPXOw2cPV4J
   uo6Q0GtakG3uDasJllUbqBRyRFZM01YjRAuY3yR6b8tVfIBZbj2j0tYuX
   L/8oBHEBL8NFYKyq2eSHy72TP6g2Ub7m/EamNgqj+BqJU/bL819E0DQyz
   6nwZf56+ObB5H03gR7rPc9yjPjznvQg4gh2UPBptFS1dNlyk8y6W2SUJo
   KYA+xjbwiY4G/rG4iIUOmIuMj9jCN4NR7+tDMe/nlmdsgp/01zSkHphQu
   2Ga3jwn0+xIECwBYqjsYKUhbFYnG1cbsq9i6QzhNd+NaY9aHQOLEfE6JQ
   g==;
IronPort-SDR: MhY7xNFawjNUVs43l6VeOKCay/5JOcE3uJqb0TQ5t6QnIYXYM6U7GOqleFIpS0EQqu0OSa8fov
 fyXAy280WTEmhPPC4cvGCG/Y+TK2tSV60ZzGy3uPJWW6PUzp6vmqXRJAJ2cEaJiD/eRRc8PYOZ
 hVzlnI/nsvldFyg5qRIz0b9R8xWFysVLHtxSDNYcWIw/hZpVndL3QIiByKw73ZYMZVSbd6QkjI
 tG7l/Wf4SF16rAHirxaIDX1Ew/ze+xkt8Id32ubP9BVCH8BywXfu0MzaAPEIXT2Sx221aGG0vD
 iT0=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448888"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:42 +0800
IronPort-SDR: mj0l6Y5ZNkO/1ikVBDroW8dwzTAtiSqFKFd9nkCbml4GeLRzJBUcHle2ITePRIlV7Aktwt0R5Y
 2VoOl42xqLspy0NukhGBoQK2JJeTJr/I7cuWJxq9IABgN5KllMIknE4IKIfnlVzH6R49lnD1RP
 Q7vWIDdALfA7mO9WX+dKZZF/axwivp77qCa2RRvWLAf9l5SNBFTOA+3x2iDA/lXGhlhRQE9ZvA
 3XGEKXpi+CvigO/GFT3m8gZPhypcsCqPXU52ufGTDGXmSPPnzDJNn6E1oJLvQeq6pXhqbOH+PB
 95vCxckAygViYe4ph811Eh0Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:47 -0800
IronPort-SDR: aJXUn/usGgeUj0zO2RU586+3NNWl2XiHmoCviv8I60vq9POlNk3u4AtwW2K3ng9/B7fLuoM1g7
 zcuMkbdqcJ3vpu8mGWTN5Sej/GnUDgpsYTtkNpv4oZPDhQyLWKait1jahnkKV8pMsnCxnMVeJB
 jhdkz+d5bnJ7OxgEyxuomcYT11zot85zUBETyCK10qisGfkpgNqRh9mGYLdYlSuguP+pMLC9/0
 i9Milh8NI/U1qq729qFaT2E2l39S+YfsUbkkHU5FVxD/5zD3JtCc/3RxweVgjNN/NqcSxtmwHy
 eCk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:20:56 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 01/21] btrfs: change type of full_search to bool
Date:   Wed, 12 Feb 2020 16:20:28 +0900
Message-Id: <20200212072048.629856-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the "full_search" variable defined in find_free_extent() is bool, but
the full_search argument of find_free_extent_update_loop() is defined as
int. Let's trivially fix the argument type.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..227d4d628b90 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3672,7 +3672,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_free_cluster *last_ptr,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					int full_search, bool use_cluster)
+					bool full_search, bool use_cluster)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	int ret;
-- 
2.25.0

