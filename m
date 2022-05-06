Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABD51D317
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiEFIPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389855AbiEFIPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:15:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778467D30
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081112euoutp018226ff9c4f5fa980d4c32c77c795b42b~sdcnQk3_X2197721977euoutp01P
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220506081112euoutp018226ff9c4f5fa980d4c32c77c795b42b~sdcnQk3_X2197721977euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824673;
        bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmTePLGw4WStsyva52M2FKpil6omiccqCPYZ4GIQEsZ//VNJXoXEYLaOqeWV10nuU
         H1KB/2RLGV3AAL91mXIlKUu1yvrmAsSoKUK3i9resOCgmy5mYJoxFff3E0dVac7DiF
         zuJl0kHbOaDAUn2cOtbKeKzSTj1SPHrWhq/K78Zk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506081110eucas1p29f4ec4b6163302f91ffd1654e9132bc4~sdclV3MUy0616806168eucas1p2n;
        Fri,  6 May 2022 08:11:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.05.09887.E18D4726; Fri,  6
        May 2022 09:11:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff~sdck9wLVm1797017970eucas1p1B;
        Fri,  6 May 2022 08:11:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506081110eusmtrp222f0eafc663deb2c7f6b2252e5b9e61c~sdck8jKjJ2593625936eusmtrp2X;
        Fri,  6 May 2022 08:11:10 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-31-6274d81ece15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.F2.09522.E18D4726; Fri,  6
        May 2022 09:11:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081110eusmtip15b4e6a476e2eada8a56f7f54296837f1~sdckpd6-70578205782eusmtip1b;
        Fri,  6 May 2022 08:11:10 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 04/11] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Fri,  6 May 2022 10:10:58 +0200
Message-Id: <20220506081105.29134-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGee+9vf2IhUsx8I6KbE38A9AqCyHv3MJcYrYbF3XZ5sY+xBW5
        KwQorB8ONZlFEAU2Cjj5KCwwMq1QRylldYWiWGOBOQZrh2mZwxFoNqlUhmWTyGSUi5n//d5z
        nuc950kODxeZyFhejkLNKBWyPAkpIKzOpZ+2bfaoM3fYXCnI9IMTRyt2J4mMv+lIVDe/hKNa
        XQMXPRoZxVF/oImDxh4WY8g7YMOQva0WQ+3GGxiaMelx9PnAPIHaS6dwtDyVjKaCEwSqddwC
        yDeux1D/RBJyTV/kInv/MIHcvc0karng46LqskUceap9ANUMWjjowflSLur03yfQ0IR4Vxzt
        /uV1+vHQJZKuKQlw6dFJM0G7RzR0d0c5SX+tPYfTlm9O0H1eLUl/URIgadupOxz6/pVxkq7q
        6QC0qWecoC03j9PVFjPnDdH7gpeymLycI4xye9pHguzRuTGscCW8qNE7CbTAu6EC8HmQSoHX
        7ee5IRZRFwH0GndUAMEqBwH0BTtw9vEAwFOuL7lPHP7pWYJtGACsCbasq+4CWD+s41QAHo+k
        EmFxOTdU30hVAqi7c3rNjVMWDhz79uMQR1Hp8EabA4SYoLbAleILeIiF1Avwz7lJDjstHja6
        /lnz8qmd8OTZuySriYTDjTME+2c8LPmuaW0JSLUL4Omys+vm3bB6QIuzHAVnB3vWI2yCK7YW
        jOXj0Od5tG4uXd3UZiJDCSD1Iqz6MS+EOJUATb3bWfkr8O/Wa4BVhEPPXCS7QjistdbjbFkI
        z5SJWLUE2pZm1odC6D7ZTLBMw4WuK2Q1eE7/VBj9U2H0/89tBXgHiGE0qnw5o3pewXwqVcny
        VRqFXHq4IL8brN70zceDwe+BYfYvqQNgPOAAkIdLNgqj9OpMkTBLdvQYoyw4pNTkMSoHEPMI
        SYzwcE6XTETJZWoml2EKGeWTLsbjx2qxjF3vGqRZ0fHSpA/S2nTl5xaj34zYKmxXfCYVH3UG
        Ot17mH3Wd7wjEwcv31tIPwBeuy09sbnyKiqb69TVmypTwu7tHPRsoxPNL/fz+xr3120NuxY9
        vf/YkYjmQ6NXnTXZ3SXaZyczvGpRqsuYkBvm3lcnDiQdjH3vkp/j35Tx4YZke3hu+eKWhoaY
        fyeWL3cV/RppDBoc4z+n9jpbsd2jaU65/C1r3ZRZY5jXwczpRdycWMA8RCsHqnSxYqaG3BuH
        RpLyFUUx/E863TPP1F1veru471aL/fbynq/0fzhsCb/vDbcOtaf7o+J8EeLxwjOvauYWdJI+
        X31etLSwIZgqIVTZsuREXKmS/QdttR9ZQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xu7pyN0qSDC4flbRYf+oYs8X/PcfY
        LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
        0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
        T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
        snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
        p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXcf7tBaaC/3wVM2/eY2xgvMnTxcjJISFgIvH68SuWLkYuDiGBpYwSZ+/0skIkJCRu
        L2xihLCFJf5c62KDKHrOKHF0xWHmLkYODjYBLYnGTnaQuIjAVEaJS+tOgk1iFjjNKrF10wEm
        kG5hgTCJK28/gE1iEVCV+N+4jBnE5hWwlHjx9h7UNnmJmZe+s4PYnAJWEk2TX7KB2EJANfOX
        7GGFqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vO
        z93ECEwq24793LyDcd6rj3qHGJk4GA8xSnAwK4nwCs8qSRLiTUmsrEotyo8vKs1JLT7EaAp0
        90RmKdHkfGBayyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDr2
        PHHpwSvPW/YWXRGZuOLZruxaqZBKSXGJpry7BRmdi8/2sussnObANj3jmKR27dyYo2FW9nPe
        Kxg+83my3yj2QBCP6vKKh/cPLL50uD5ApnPz26VMv4IETk7lqhDRuXPzke68vn29jqsDmpyX
        h81emz/DqGrSjdu5T7rnaPXUmPuGLyjV1A4VPz1N5db6V1LpYV9yHRZWCLOtu17/10nBr97g
        zLnosx/e+bTL+LsdVXaNt01oaj/Z+D76WL6GhLrhPDf2V4H5jmKV99gNAydtWZhsdnHJoh5h
        7dYHL263X50gX3L35OwdMS6Cyfe+rkl3es9nxT01UfnC57jEt9zbeqQicg7bPU+w2b0oSoml
        OCPRUIu5qDgRABxkWpSzAwAA
X-CMS-MailID: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32d7bd7b1..967790f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

