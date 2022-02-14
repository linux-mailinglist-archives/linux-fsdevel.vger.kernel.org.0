Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C24B44B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiBNIph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:45:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiBNIpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:45:32 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 00:45:24 PST
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A015046E;
        Mon, 14 Feb 2022 00:45:24 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220214083521epoutp025ba97d9fe8a39ef44d248309d2a63c94~TmhkvZKHH1820318203epoutp021;
        Mon, 14 Feb 2022 08:35:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220214083521epoutp025ba97d9fe8a39ef44d248309d2a63c94~TmhkvZKHH1820318203epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827721;
        bh=vIdJ/mHzkG/ncG862yZ99yroqi17ftw/JCJp3El+0s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgUd0kBcEvXAr4+t8qpQSXf8ReGsnJEkNHnrLWYpWUqaCa1dIMoo92p5nVwekEybG
         ervYHZqlxUjr8jvkMNqC1NsZJyICI2j0AQG01aY683eNgH4oz+vz5yLSMx1myTC9Qe
         DXILqW+EJAA4CUa8116+Ufaao1i2v9k6q63fWaJM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220214083521epcas5p3faa13564d4db2b93ad37de4a2fde889d~TmhkZ4JD40865408654epcas5p3Q;
        Mon, 14 Feb 2022 08:35:21 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JxyG94kpTz4x9QG; Mon, 14 Feb
        2022 08:35:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.16.05590.1441A026; Mon, 14 Feb 2022 17:35:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9~TmH6th4YZ3176231762epcas5p1S;
        Mon, 14 Feb 2022 08:05:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214080558epsmtrp2c5a3f5d650b84129c4a6aabcc9512707~TmH6q_H_O2569425694epsmtrp2M;
        Mon, 14 Feb 2022 08:05:58 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-f1-620a1441c60b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.C1.29871.66D0A026; Mon, 14 Feb 2022 17:05:58 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080553epsmtip2d84b9b4e078e403260c79d7d89473125~TmH2M4tpN2253222532epsmtip2t;
        Mon, 14 Feb 2022 08:05:53 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] block: make bio_map_kern() non static
Date:   Mon, 14 Feb 2022 13:29:51 +0530
Message-Id: <20220214080002.18381-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOuff2tqAlV1A5sGzWEkQkfHSWelAQtxlzM0RBzLYYBS9wBQb9
        WEsViW7FThe+FHBjUA0iigQ0giiOIcWCYYYPUVPpBhuCWiaxEURBcPIxysXNf8/7nOd5n/O+
        J0eAO3fx3QVJilRWrWBSxKQjcf2Wt7fvJ0sdYwNMVhGqbv8NR409r3joYt8JEhW+eIOjkeYn
        PFRwooiPzFYnZBw+xUP3JjMw9KR2FkONZQUYqrzYiqGnFecAunF2FEOZHfcwNPVIglpnn5Oo
        oMUC0GC3AUPGXh/UaGwjkLnhNInOXBjko+zf60nUZDPiqOL2DIa6DFMkqrdmAHT97Rkc3XrY
        TaDLthEC2SbbSHTsyjhAR3Pe8NHd6du8TR60+UEYbei/Q9L5+mE+/auhj0/ffXiFoPWlfxG0
        +Y6Wrq3KJOmr57+jT/5RAegbPTqSPtLZitNFL8dIOlc/TNKjg70EPdLUTUYs35UcnMgy8axa
        xCrilPFJioQQcVhUzGcxgbIAia8kCK0TixSMnA0Rb94a4bslKWVuiWLRfiZFO0dFMBqN2H9j
        sFqpTWVFiUpNaoiYVcWnqKQqPw0j12gVCX4KNnW9JCDg48A54d7kxOc9RTxV3uK0oqZsTAdy
        HLOAgwBSUnhcdx63Y2fqBoD5XVuzgOMcfglg/c0igiteA5g1NcTPAoJ5R2GuF8cbAXz55xCP
        cx/FYEOv0q4hKR/YMSuw00spAlZOTMz3wakSPqxrs/HtBy5UKOw8aZpPJihPOPrcQtqxkFoP
        R55OAO52HvDso+b5/g7UBmiyVeCcZglsK7YSdoxTK6C+7hRuD4DUMUf4z7NCnDNvhjebDQvY
        BT67fY3PYXf4athIcoZsACc7+zGuKAJQn6cnOVUovN84jdnHwSlvWN3gz9Efwp/aL2NcshPM
        fWvFOF4I60veYQ94qbp0oY0btExkLGAaNvRPLKz0OIA2wzSRB0SG9yYyvDeR4f/oUoBXATdW
        pZEnsJpA1VoFe+C/V45TymvB/MdaE1YPHg+88GsBmAC0ACjAxUuF0XccYp2F8czBdFatjFFr
        U1hNCwicW3k+7r4sTjn3MxWpMRJpUIBUJpNJg9bKJGJXYXtCDeNMJTCpbDLLqlj1Ox8mcHDX
        YfJ9MNqysytz2+uomeBX+dF/twnLPhqNHMqb4Zn1Xoqu3SmqQxti08J7TW4hP+yr+DQ8Mm1F
        50RGybeZw1VST9H2hi8+4P3sZOm96Htgj1oQtsTV33db9umsGnlnR3mUeYd2XVj6+K7PQ7I9
        Q/sre5Lc0woYL9OsbFNd8jdSn4GvL11ycXXSjfw49njPor3Du/mtZdcekEd3rk5f5LY/2Vps
        Ta9p6zZPrxo9N1RVz3+0oxys1g0eGXtR++XKqhrH5gbhV6b26T45fnCWWTxYPjU+ELVsyz3R
        3u1BvjWrLuvDc7ot9xOW/0KXPzFHHi7229h6yGvl1dmRSg+Z+PAF18bvpzska8WEJpGRrMHV
        GuZf/OP5VOEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhJXjeNlyvJ4FafksX6U8eYLfbc/Mxq
        sfpuP5vFtA8/mS3eH3zMajGpfwa7xeUnfBZ7381mtbjwo5HJ4vGm/0wWexZNYrJYufook8Xz
        5YsZLXYv/Mhk0Xn6ApPFn4eGFkf/v2WzmHToGqPF06uzmCz23tK22LP3JIvF5V1z2CzmL3vK
        btF9fQebxb7Xe5ktlh//x2RxbtYfNosdTxoZLbb9ns9scfjeVRaLda/fs1i8/nGSzaJt41dG
        i9aen+wW5/8eZ3VQ9rh8xdtj1v2zbB4Tm9+xe+ycdZfd4/y9jSwezQvusHhcPlvqsWlVJ5vH
        5iX1HpNvLGf02H2zgc2j6cxRZo8Zn76wefQ2v2Pz+Pj0FovH+31X2QLEorhsUlJzMstSi/Tt
        Ergy3t6cwVowgadixr5upgbGHq4uRg4OCQETiWm96l2MXBxCArsZJf717WbpYuQEiktKLPt7
        hBnCFpZY+e85O0RRM5PE5I5jzCDNbALaEqf/c4DUiAiwSKz8/p0FpIZZ4AS7xPmWQ+wgCWEB
        e4kzkw+ADWIRUJX4+PYaG4jNK2Al8f75d0aIBcoSCx8eZAWxOQWsJQ68Xg5WLwRUM+MqxBxe
        AUGJkzOfgB3HLCAv0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQITihamjsYt6/6oHeIkYmD8RCjBAezkghv3FnOJCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY2nac05xrOOOM0YoDzzrm9l1w4CpIPpEW7B9U
        8+r47F8J+3McLi49qdy4ZFud6epX+x7qvDO8JhPknaa9M6Fg8olO2e8fmphFwjaFC1Z9Upr1
        e/9Wz/VPwyoNrPc1+hl+07k/z2p1pAqTU5rBSyWhrvnWXe6vxBVcX8hvKft/kyPl8f9WmfNM
        ce2t2rXmjaIrtn47+HT7zsprIt6q9bnFbPvPOvp1H6tj1hTY2PizZXW+HMt+x/WVaS6lPyt3
        R5+eU743t3BpQUL8olLx6wuebP2RPeXvrRz+WTzf8lUXqivv1/6iInnUdDoj3+vmSy9nMzCu
        rd6n/sE7rshMaE37uunTF5t98F14PXHv5KXlSizFGYmGWsxFxYkAWynKtZcDAAA=
X-CMS-MailID: 20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SelvaKumar S <selvakuma.s1@samsung.com>

Make bio_map_kern() non static

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-map.c        | 2 +-
 include/linux/blkdev.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..c110205df0d5 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -336,7 +336,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
+struct bio *bio_map_kern(struct request_queue *q, void *data,
 		unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a450..efed3820cbf7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1106,6 +1106,8 @@ extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.30.0-rc0

