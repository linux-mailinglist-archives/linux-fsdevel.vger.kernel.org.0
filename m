Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A862FB416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbhASFYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40885 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BdkhQGouvUAsTue8hQMttohkdblbLZM4YtE7j1r1v9I=;
  b=nXDc6rBpYYh3KgicBrsz+4B1yGfZwfu7pi+SGuFr0oyMk5tKUc9fEDIR
   G9kyrbRswQfZWyJ5KWLJNQAIGhRPG31KLzn5O0f8U9MZaSyFqNuKu9Uph
   lvJ+lRjaiAzfVmrD6hbtKA6ijgFY/pWAgvuZfbdRHNsyRTJsKTiulIiB8
   bmsQNv/gdKF1HfhxYXqsgzGvbXz1cBbiDTkPQa6svGINma2bE0skIZd3C
   EeEfqB0T3/11mKtv8jQD5GDWglkem0pYH4owjeQDtaLo2HQm7MNGe6ZhF
   mAGq9IaYl5O0dVmO2LMsydXadIKRP52XnHBuvQqGN5K6E8Y/GNlJErhsy
   Q==;
IronPort-SDR: DsAUJ8KGpBuWdH1KM2dnlSssxJPv3hVDssM8H1NyIbuPkOwpDo2qZXipnbXvwhPgOJt1WUbzhn
 wJcv8DiTmKp0ohDo9JHLCZKv5BbZwjB97XFGCkPRsh4aK2DWbJ/av/J7BAScV8gP3q5tNMUxE1
 ul2adS1FNcTikw5HLBP3Adw5jgfiqHr11teqV+nAilAu/sFZqSLh0GF/ijXzNPorJibMgIkoPL
 Qckwvcz6ATTbSrCCBzD6TJ3NUdiHdR19hj3RsYwck4pY/J9++44qPpiT3rsgG/IZUKDTQTCODM
 JDs=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758529"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:26 +0800
IronPort-SDR: Z7Qz8Lpdh2IaPyi7eFhDozHQYRGLcjl5HQvxJIvHANhGeE0Xtu6AkL7GVsPHS4MmNp1KZFBRik
 Efl/BZErOJ3nrCMkFNeIh0tEuvASTJWMmWOSgUUAm4AXbIZgKnLdkTF8NBJ1hxF5cMrEn7oBC+
 pqVwCYY4pAkh0CHA9rCMP5/AfeCj8A4L2igxEUx4g8F8nCsU3t8Xq7HkPR1bq6Wmx3w+eH9iwg
 VOsHRm91dUEUvtBdbtIDFWCM+QISHmGLYhPTGjYMXfvWqK6o8l/mOEhdO+9O7hCBccDmxpAN1A
 iq5hPOhpni2VsDE3owZdyKUb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:50:01 -0800
IronPort-SDR: RfcxC1FWYGpS0fNCrOs8BtNtAvGS3Soo9XuKQebXkTCgbWAqTp1EKLrasZ0evXuMWoITBnHtNY
 2oxDBYpgHVdIOlbC//vNMX0StFZhGCaZIsKA9cFY7fNqh1OY5fcl3ycEabv+HgHkEc/CXDDC1y
 fzmKDnwNyp8ppyfiLjfpBXI3+rhzN33czQz3Cn2qnuTvExV9IqScOwNt057FA/Z+bR+5w8O/JO
 uiXUS8DdnaYj0tdtbLaCu8GXso9K+bCVoTPbDi0BV1XABhEY6VgIhePNhopNBAIoFyoLyU4M28
 AtU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:26 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 07/37] gfs2: use bio_init_fields in meta_io
Date:   Mon, 18 Jan 2021 21:06:01 -0800
Message-Id: <20210119050631.57073-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/gfs2/meta_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 2db573e31f78..822489b10aec 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -217,8 +217,8 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 		struct bio *bio;
 
 		bio = bio_alloc(GFP_NOIO, num);
-		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-		bio_set_dev(bio, bh->b_bdev);
+		bio_init_fields(bio, bh->b_bdev, bh->b_blocknr * (bh->b_size >> 9), NULL,
+				gfs2_meta_read_endio, 0, 0);
 		while (num > 0) {
 			bh = *bhs;
 			if (!bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh))) {
@@ -228,7 +228,6 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 			bhs++;
 			num--;
 		}
-		bio->bi_end_io = gfs2_meta_read_endio;
 		bio_set_op_attrs(bio, op, op_flags);
 		submit_bio(bio);
 	}
-- 
2.22.1

