Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C24AC204
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387280AbiBGOxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390953AbiBGOcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:32:09 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036DC0401C2
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:32:08 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220207142247epoutp030f349686d3070eecfbd57bc64c78635c~Rhv61ZdZP0920109201epoutp03b
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220207142247epoutp030f349686d3070eecfbd57bc64c78635c~Rhv61ZdZP0920109201epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243767;
        bh=vIdJ/mHzkG/ncG862yZ99yroqi17ftw/JCJp3El+0s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+Bkr0ykcL55HmHQHedG7Uc8As/vmq9Hm9WV/ao94xzrlakauoFOPt66qtTwi8fim
         tqqnb5dGBLCSPSTkDrgcHEvl5r+tgTjAL6vbFVIgMLYS0psQtYjZE9If3NZJjN/7rv
         d4P/lHz4C6rHPfuXWdSJmmQOKq4YL6vEqSBaIc4Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220207142246epcas5p3d1e902b8f18dde09cfab0780f0a9a413~Rhv6J9Buf1616716167epcas5p3k;
        Mon,  7 Feb 2022 14:22:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JspJL2Cvhz4x9Pw; Mon,  7 Feb
        2022 14:22:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.5F.06423.23B21026; Mon,  7 Feb 2022 23:22:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220207141908epcas5p4f270c89fc32434ea8b525fa973098231~Rhsuv2ZRv3069230692epcas5p4c;
        Mon,  7 Feb 2022 14:19:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207141908epsmtrp1bc38ae71f57bbe6e5ae06984b9b559c1~RhsuuVp2C0764707647epsmtrp1u;
        Mon,  7 Feb 2022 14:19:08 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-2c-62012b3288e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.33.08738.C5A21026; Mon,  7 Feb 2022 23:19:08 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141904epsmtip18597f2262c82f183ea500a689687c70d~Rhsq5dSBw0282502825epsmtip1l;
        Mon,  7 Feb 2022 14:19:04 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH v2 01/10] block: make bio_map_kern() non static
Date:   Mon,  7 Feb 2022 19:43:39 +0530
Message-Id: <20220207141348.4235-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRzu3Lt7dxcDr4DDESFxLQyJxyqsB5UUtbypDBSjmc1IV7jCBuwu
        u4umTgnsgAISj+IpK1giystEoBUXTIiYDXB4iIiDDwJzgAEBkQCRjeVC+d/3fef7Pc/8+Lh5
        Gc+aL5GqGIWUDhUSJpzKOgcHp/WO4LDr+I8CpOt6wUVFD5MIlD4yhaPnt3u5KDUpk4fa+8xQ
        9fA5LmqZjMJQb5kBQ7qfUjF0pageQ88KfgYorrEFQzM9IlRvGCJQau09gKofOCJdtZ6Dci89
        5aGETi2BagarcVTQMIuhlDMdGLqTPUOgyle5OKp71MFBRTMIDU7qCRRzdoqHBm4d2vYO1X53
        D5WiHuZR6rxuDtXeHEGVFcYR1PWLp6gf7hcA6mZXJEFFN9XjVObYOEF1Nv2KUYnqYYIaffqA
        Q1X2JPKo5zUdBPV9eSHwtTwYsiWYoQMZhR0jDZAFSqRBnsI9fv47/N3FriInkQfaKLST0mGM
        p3DnXl+njyWhc5sS2h2lQyPmJF9aqRS6fLhFIYtQMXbBMqXKU8jIA0PlbnJnJR2mjJAGOUsZ
        1SaRq+t69znjVyHBQ12ZXHny299k1iRgkeCsSTzg8yHpBtPyl8QDE745eRPAjM5WjCVjALaU
        X+Ow5AWAaaOjnMWIulac1asA1GUZeCyJwWB+dRNuNBGkI2w08OOBgG9JWsGZlkpg9OBkDhdG
        TfVzjA8W5FZYdKOEa8Qc8j04lRGPG7Ep6QGvxRQBI4bkGnih5/a8R0BughMz6RzWswzqs/rm
        MU6uguqKczjrfySAWaWQbXQnLOngsrIFHGgo57HYGvYnxc73DMkEACebHmMsyQRQnawmWNdW
        2Kp7jRkT4aQDvFrlwsq2MO3PUoytawYTX/VhrG4KtecX8RpYfDVvIc0KeO+fqAVMwfjKvxc2
        dxfAjit/8JKBXfYb82S/MU/2/6XzAF4IVjByZVgQo3SXi6TMsf8+OUAWVgbmj2fdJ1rw8MmI
        cy3A+KAWQD4utDS1STDQ5qaB9PETjELmr4gIZZS1wH1u4Sm49fIA2dz1SVX+IjcPVzexWOzm
        sUEsElqZNgb9QpuTQbSKCWEYOaNYjMP4AutIzFsc7od/eXyz34BLxsW9Mh+JInD3xom1tnUT
        RwSaz8IrmNdmKVaH35cs1dZrT+jS/hp8EiSY1ibEmNe1eRlo4MP5rVCwLM5iYOQo83m6TRbW
        /S13dFozK3qrO/b8KY0mOrZdkqCNOl07prPZnzXdsbpx6fCuffKwnE7HofpDfZutxZeSnfrt
        1Sn633u91bsazvS91H/h1TYekFt1h7tqJjdyeb2utcKl5Lsc/Q6c+/Vs8actBw5c3l5tf1Lj
        z4uOdyihtq0suqCyPNlM7vbx1qwMd342e7rdol2wunfDB4ZCrxvR+/Y7F/s03z9y8OWxx++2
        6dZe/2jJZaXtbGmn7Ja9KF8u5CiDadE6XKGk/wUZlf3sxQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7bCSnG6MFmOSwZ1//BZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9c/TrJZtPb8ZLd4tT/OQc7j8hVvj4nN79g9mhfcYfG4
        fLbUY9OqTjaPzUvqPSbfWM7osftmA5tH05mjzB4zPn1h87h+ZjuTR2/zOzaPj09vsXhse9jL
        7vF+31U2j74tqxgDRKK4bFJSczLLUov07RK4Mt7enMFaMIGnYsa+bqYGxh6uLkYODgkBE4nD
        F5m7GLk4hAR2MEos3LeZrYuREyguKbHs7xFmCFtYYuW/5+wQRc1MEidabzOBNLMJaEuc/s8B
        UiMiIC7x58I2RpAaZoFDrBL/zr0BaxYWsJdYvXMtK4jNIqAq8XN6F1icV8BSYmPrakaIBcoS
        Cx8eBKvhFLCS+PZnGgvEsgZGiYZzK1ghGgQlTs58wgJiMwvISzRvnc08gVFgFpLULCSpBYxM
        qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgpODltYOxj2rPugdYmTiYDzEKMHBrCTC
        K9P9P1GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpg1z
        jCynvph8R/OR3GK+F9Gn/VRS/IMks1btO786TtuHrTb4x+eH/nNnn1pqFV0nKpt8z7k49IQv
        h8cheRG3SPn1DW7NJ+ZzKXYmrjv9/eWb2/6512/HHjmlrqyyVfpN+reD1dbRU7SctleGW4cf
        yQ6+unXn7XM9zzxai47bO8UtT2/iCKm/myj4L8P0aUbQKd+n86qOPXq269vsqQaB7xy3N+6+
        d0DheoXq3SsCS9t41KftzuO+ultB7c/SGXN+iU55sDf2tZzy/wu/+hV3t/F2BcRfnjPvyPcg
        Bc9Qdb9+hmW7p6oGddU15/2M1Dn549EJiRSjN00/1QpPsahcC9h7XmUtk4GDn+h8w9Ctckos
        xRmJhlrMRcWJADEwHpZ9AwAA
X-CMS-MailID: 20220207141908epcas5p4f270c89fc32434ea8b525fa973098231
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141908epcas5p4f270c89fc32434ea8b525fa973098231
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141908epcas5p4f270c89fc32434ea8b525fa973098231@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

