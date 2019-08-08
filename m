Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C260585E58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfHHJbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbfHHJbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256680; x=1596792680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+q9uysGobuJDzywTc2ewr95QDB6LcwNJCL8Gp3Ba0w=;
  b=JbJhBWfr8hd4pSyX0UYUrwGJIsiI48rYSVGLzI7vBN4xOmUGDkNFV+/4
   LLMrl5r6eegs7fJRoNXFMF3/31EoXTYUC1jLgao8fDsT6kXkXoMpvyJ+X
   vSIS7AlezcNLm0hO1NMXG81nq//WFN3E1xbk0v/xRXGr7tArtlELldasQ
   1EQy1pAkLnLkWrfkHwiplneFoX8Eml7APbtZHsl0dOLYIPTLJksI6/gJw
   5iQC4r155MWtztjAPCp/4AQuUJnqnI30O5u3+ALRLjJQVrh3CHXT18dK5
   K3nTfvzX3D4TtLBsHuyG/ceU7eMs/jQ702dhnOvqbwH7VIaESjsmtwM7g
   g==;
IronPort-SDR: Ct/G8J/b1UilGsRUKvQx5HGONY58052lAZX8j5TE6LgCaVxT5+X137tLKykl7eixDKeQgqaSeo
 8PwCA2eS3TocM768EOcCYY0PThY9PgiZ9aDvwPDrewoKN3hOcfSC+g70Ed2oCdri9CLvkZff2T
 llDd7gRPs7LJNlphkpiYwMzMakNVweIO61KWqFAikCkFDFAe5TYCJCCGuJ1hWSxVwGKEd3Axo/
 gC/Xg9qfkBkASwoIK8nQmIlxmJjwUUnkDxwkRfowM2JMh7h3LXtDJv4aQX+MdaOTuGP4UHvhRv
 xI8=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363305"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:20 +0800
IronPort-SDR: 3gt2ev8PzMoxWeXvtIQHDMHR9Ix+QSauqcSNfE1vdIEDyblWmPp5VZrVjX6aSc6OkOq+uWepdW
 U2AQU8QuwMDgTQPSkUSXcRK9QC628JwII1GuEYswjb8KNkcEV9fyZFTyIgWqHfGhrYpr9BKKLS
 zgtIBwmGJ2iB+vbJYCa5dpdtS6z3bvY4wScTJXL7vjJVkafHZi8vM2AbgWLfTRrbUmOiYFLGfQ
 nsMHpIXF0lOjKMWeQ4+ZrWAgJGtLnXzLN6A5aGLbLm+snVswuZWAMdv6b251P6RWJ736jOuFVD
 EwvmMKP936HNatizaKRMqwEz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:04 -0700
IronPort-SDR: xX2J41Lsh3rGBMRJCkY9hyBDSAQ7sIAKt3MjxI+cdMlZiBcMxfE0A3N3eqYwaSD9IKEsrx5lI4
 Ju8sddG6vgS5MiYJbzsiq7HlxJhkQpB5RzgUj4s9cPbzOvSgCc6UHap1x4TmvvKNpnstd96AlB
 cd3Ig5ORFEO5+lpgmy1fr7d3otaO2kaZjwttz58XkC123qnsmHvtVn8+GewekL9cP3l4Xld2fr
 LJxlK3jw9ifrxVvXsz398NLIRvYjP1v2+CrxBq/v0t9monCSj5WH+W2qw26KHaLbbLraK74f+j
 gps=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 04/27] btrfs: disallow RAID5/6 in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:15 +0900
Message-Id: <20190808093038.4163421-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Supporting the RAID5/6 profile in HMZONED mode is not trivial. For example,
non-full stripe writes will cause overwriting parity blocks. When we do a
non-full stripe write, it writes to the parity block with the data at that
moment. Then, another write to the stripes will try to overwrite the parity
block with new parity value. However, sequential zones do not allow such
parity overwriting.

Furthermore, using RAID5/6 on SMR drives, which usually have a huge
capacity, incur large overhead of rebuild. Such overhead can lead to
higher volume failure rate (e.g. additional drive failure during
rebuild) because of the increased rebuild time.

Thus, let's disable RAID5/6 profile in HMZONED mode for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 512674d8f488..641c83f6ea73 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -222,6 +222,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	/* RAID56 is not allowed */
+	if (btrfs_fs_incompat(fs_info, RAID56)) {
+		btrfs_err(fs_info, "HMZONED mode does not support RAID56");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
 out:
-- 
2.22.0

