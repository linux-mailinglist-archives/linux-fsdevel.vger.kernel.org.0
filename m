Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DCB4AC200
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358167AbiBGOx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392416AbiBGOac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:32 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA32C0401C9
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:28 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220207142251epoutp01d6200c9cfc489132cd941fbcf32695d0~Rhv_MIo9O2820228202epoutp01h
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220207142251epoutp01d6200c9cfc489132cd941fbcf32695d0~Rhv_MIo9O2820228202epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243771;
        bh=KkCjgJ4LgLo+f/FVH53mNh1CtYI5pOktWJbRwNjsgfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6Esxr663dtxl1QG6hCP2TdFpHRBtgLM2rj9FJ86kdlWXEC87Tf0jbAN+994wsa8U
         MltexE5ghWM1psp8yTZA4LY7oFw5KWd+KQjNCk2VcoWeE86ZZZKiH8lvwz8cYDZo57
         cG9a1aZy8GChPfI77+cdiZd1MdbVNSlvMZLu3faw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220207142250epcas5p4999570d794b5c37c2511d86d0a8b25df~Rhv9YRMKu1958019580epcas5p4U;
        Mon,  7 Feb 2022 14:22:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JspJQ29FSz4x9Pp; Mon,  7 Feb
        2022 14:22:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.1E.46822.98A21026; Mon,  7 Feb 2022 23:19:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220207141913epcas5p4d41cb549b7cca1ede5c7a66bbd110da0~RhszrWbt50551405514epcas5p4J;
        Mon,  7 Feb 2022 14:19:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207141913epsmtrp1cc5b40109b36029682070c02e37408e3~RhszqCwHg0764707647epsmtrp1v;
        Mon,  7 Feb 2022 14:19:13 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-38-62012a897b1f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.F3.29871.16A21026; Mon,  7 Feb 2022 23:19:13 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141909epsmtip1bc539555b1896682773c3413941c3e13~Rhsvud4bv0563905639epsmtip1K;
        Mon,  7 Feb 2022 14:19:09 +0000 (GMT)
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
Subject: [PATCH v2 02/10] block: Introduce queue limits for copy-offload
 support
Date:   Mon,  7 Feb 2022 19:43:40 +0530
Message-Id: <20220207141348.4235-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH87u3vbdAwAuC/mTKmgJugCDlUX8wEDfJdqdmIyPRZH8M7uBa
        GNB2vcWp0whWVN6vgQgE0KlEMIq8FcoQh4SHG4bXYAgiEAYEUNywjLqOUtj873tOPuf3Pef8
        cgS4VRVpK4iUqViljIkWEaa82odOTq6JzuBr9/qOXahx8BUflT9NJ1Dui2UcLTwY56Os9DwS
        9UxYIM18AR91a+MxNF6px1Dj1SwM3SxvxdBU6Y8AJXZ2Y0g3Jkat+jkCZbX0A6QZckGNmnYe
        Kr4xSaLkgXoCNc1qcFTa9g+GMi/2YeiXfB2BaleKcfRwpI+HynUIzWrbCZSQskyimZ++2mdH
        9/QepDPV8yStLhnm0T2PY+nKskSCrrp2hs7+rRTQDYNxBH22qxWn8xb/JOiBrjqMTlXPE/TL
        ySEeXTuWStILTX0EnVZdBoKsv4zyi2CZcFYpZGVh8vBImdRfdDA4ZH+It8Rd7Cr2QXtEQhkT
        w/qLAg8FuX4cGb26KZHwGBMdu5oKYjhOtHuvn1Ieq2KFEXJO5S9iFeHRCi+FG8fEcLEyqZuM
        VfmK3d09vFfB0KiI5ql0UqHZdTzlQjMvDvQ7JgETAaS8YGvJOJkETAVWVAOA5x6N4MZgEcC4
        tibMQFlRSwDeO2+zUaFVN/CMkAbAR4NPgBFKwOBopSAJCAQE5QI79QJD2praCnXdtcDA41Qh
        H8YvT/MMzGbqC1izcMrA8ChHWKQpJA3anPKBN+KyCaOXPbwy9oBv0CaUL1zS5fKMjCVsvzyx
        pnHqXaiuKVhrGlIjJjAj6RxmLA6Edf0r63oznGmrJo3aFk6nnyeNBckAartGMWOQB6A6Q71u
        HQCfNL7BDJ3ilBO8c3+3Mb0D5nTcxozOFjB1ZWLdwBzWF21oe3jrTsn6M9tg/+v4dU3D8vwE
        YNxcL4D6i+lYBhDmvzVR/lsT5f9vXQLwMrCNVXAxUpbzVnjI2O/+++UweUwlWLse5wP1YOzZ
        C7cWgAlAC4ACXGRtvj1Zz1iZhzMnTrJKeYgyNprlWoD36sozcVubMPnq+clUIWIvH3cviUTi
        5eMpEYu2mndKKxgrSsqo2CiWVbDKjTpMYGIbhyWvkO0/z037KDj94ZJ9k+GpKXOPmzvcauXM
        vZmQgNM2Z3YG2HlqAppS9nxmVlNQv2J9bEY3/sPS5Rau88R7p5/v+NBe1JJY5cduaRgquvtB
        Tr0ue0lbNwD4gSNuB9hFp78q+nP4Lkdi3il61Zab0DHbk2QRWnDTXNjrkFBtudOholcY5MGD
        M78jTc1SYsdh6dTw07/zXwYXm4y5zf66/fnJ4S2bLnx/Km1QItDfvX4r+P3b2emmufj+zx3H
        N3V4fPvJMzu4nBr1zSGkd41VHc8L3uuwcEmj4LTWvpmh968dHb36WmT2aYGn5ZGjfoXX7eVm
        yR/5d16ZtpAGpA0vnn1D/hF2ScTjIhixM67kmH8B8VJersYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSnG6iFmOSwYL30hZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9c/TrJZtPb8ZLd4tT/OQc7j8hVvj4nN79g9mhfcYfG4
        fLbUY9OqTjaPzUvqPSbfWM7osftmA5tH05mjzB4zPn1h87h+ZjuTR2/zOzaPj09vsXhse9jL
        7vF+31U2j74tqxgDRKK4bFJSczLLUov07RK4Mg4872cv2KtT0dN+gKWB8ZpqFyMnh4SAicSP
        5t0sXYxcHEICuxkl9m0/wgqRkJRY9vcIM4QtLLHy33N2iKJmJomPz24BJTg42AS0JU7/5wCp
        EREQl/hzYRsjSA2zwCFWiX/n3oA1CwsESDQdPghmswioSszbO4cdxOYVsJRY1jCZDWKBssTC
        hwfBFnMKWEl8+zMN6qIGRomGcytYIRoEJU7OfMICYjMLyEs0b53NPIFRYBaS1CwkqQWMTKsY
        JVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLTg5bmDsbtqz7oHWJk4mA8xCjBwawkwivT
        /T9RiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZwRslX
        t5fPeBdUy1+yW8GVm3nXqZ2zvVRZ78//dt314i1GLhYX9aAKhyd5m1982CW9+Omr9FXP7k22
        NzvDW8g8b0vIn/Jaxc6Tj57sltq0KO8Er0DH/c8M39aKeU+zPaz44f7x74VcIhWbbOvm12wK
        9zjC82xG4NbWGsW15n+YGU5t8Nqe1Bmy41e1U1C5i+PDLo7PYYw6hxszlCZN0TB/l3TK9Gmi
        3qlrlsUammqHQgp0vuW6Bj7U8fh1R2HuaxMmUZVG3ttqj+pfXjon83cuj8L1Sak5Asbnt21Y
        ErB82b+c8PBJ6YbfF85Q9t/MzM638cge4VnyPmF75zwNS3vGul80RNIz7WHGLQbDq2xKLMUZ
        iYZazEXFiQB+t+O8fgMAAA==
X-CMS-MailID: 20220207141913epcas5p4d41cb549b7cca1ede5c7a66bbd110da0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141913epcas5p4d41cb549b7cca1ede5c7a66bbd110da0
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141913epcas5p4d41cb549b7cca1ede5c7a66bbd110da0@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add device limits as sysfs entries,
        - copy_offload (READ_WRITE)
        - max_copy_sectors (READ_ONLY)
        - max_copy_ranges_sectors (READ_ONLY)
        - max_copy_nr_ranges (READ_ONLY)

copy_offload(= 0), is disabled by default. This needs to be enabled if
copy-offload needs to be used.
max_copy_sectors = 0, indicates the device doesn't support native copy.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-settings.c   |  4 ++++
 block/blk-sysfs.c      | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 12 ++++++++++
 3 files changed, 67 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b880c70e22e4..818454552cf8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -57,6 +57,10 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
+	lim->copy_offload = 0;
+	lim->max_copy_sectors = 0;
+	lim->max_copy_nr_ranges = 0;
+	lim->max_copy_range_sectors = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f..dc68ae6b55c9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -171,6 +171,48 @@ static ssize_t queue_discard_granularity_show(struct request_queue *q, char *pag
 	return queue_var_show(q->limits.discard_granularity, page);
 }
 
+static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.copy_offload, page);
+}
+
+static ssize_t queue_copy_offload_store(struct request_queue *q,
+				       const char *page, size_t count)
+{
+	unsigned long copy_offload;
+	ssize_t ret = queue_var_store(&copy_offload, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_offload && q->limits.max_copy_sectors == 0)
+		return -EINVAL;
+
+	if (copy_offload)
+		q->limits.copy_offload = BLK_COPY_OFFLOAD;
+	else
+		q->limits.copy_offload = 0;
+
+	return ret;
+}
+
+static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.max_copy_sectors, page);
+}
+
+static ssize_t queue_max_copy_range_sectors_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_range_sectors, page);
+}
+
+static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_nr_ranges, page);
+}
+
 static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
 {
 
@@ -597,6 +639,11 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -643,6 +690,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_offload_entry.attr,
+	&queue_max_copy_sectors_entry.attr,
+	&queue_max_copy_range_sectors_entry.attr,
+	&queue_max_copy_nr_ranges_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index efed3820cbf7..f63ae50f1de3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -51,6 +51,12 @@ extern struct class block_class;
 /* Doing classic polling */
 #define BLK_MQ_POLL_CLASSIC -1
 
+/* Define copy offload options */
+enum blk_copy {
+	BLK_COPY_EMULATE = 0,
+	BLK_COPY_OFFLOAD,
+};
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -253,6 +259,10 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
+	unsigned int            copy_offload;
+	unsigned int            max_copy_sectors;
+	unsigned short          max_copy_range_sectors;
+	unsigned short          max_copy_nr_ranges;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -562,6 +572,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_COPY		30	/* supports copy offload */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -585,6 +596,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
-- 
2.30.0-rc0

