Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081A4AC1EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387731AbiBGOxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392406AbiBGOa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:28 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 06:30:27 PST
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDCC0401C1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:27 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220207142300epoutp02270bc846e0e67b6e0678d0c58f3dceed~RhwHIlNCY0484404844epoutp02r
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220207142300epoutp02270bc846e0e67b6e0678d0c58f3dceed~RhwHIlNCY0484404844epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243780;
        bh=51gb+KAkLLOCceSRSpV3/Ck//gOGhaJ89fv7rx6B14I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uinqM7iymHOzanQRuHFR8/QIXHADtnzXUyQ3wc4cu1GmRMLibfLESFSr/O7B8jdpk
         JDY4Kj4O6YWaNCVzToCCx0umj+ew8m7j2NItZHWg5FZCh84aRLjtPL5lrlWbuPFVbg
         feuT5V/NzysLf7LbUCvSD9CJnkPrV4AvGfMnHxEw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220207142259epcas5p4a54c85eb6a5b263a7605f6232654a6db~RhwFw67Mf1944419444epcas5p4S;
        Mon,  7 Feb 2022 14:22:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JspJX4Mknz4x9Pr; Mon,  7 Feb
        2022 14:22:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.2E.46822.F8A21026; Mon,  7 Feb 2022 23:20:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220207141924epcas5p26ad9cf5de732224f408aded12ed0a577~Rhs_OEOEH3248332483epcas5p2V;
        Mon,  7 Feb 2022 14:19:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207141924epsmtrp2a557190332f6fece38e0a61005523cd6~Rhs_M6Kdm0696106961epsmtrp2T;
        Mon,  7 Feb 2022 14:19:24 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-49-62012a8fdc8f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.43.08738.C6A21026; Mon,  7 Feb 2022 23:19:24 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141920epsmtip1a7ccbdb905ddb0402a8d97a28a9ac832~Rhs6Z13Yd0564005640epsmtip1J;
        Mon,  7 Feb 2022 14:19:20 +0000 (GMT)
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
        nj.shetty@samsung.com
Subject: [PATCH v2 04/10] block: Introduce a new ioctl for copy
Date:   Mon,  7 Feb 2022 19:43:42 +0530
Message-Id: <20220207141348.4235-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfyycdxzH832eu+ceVvLs6HzJbLdTW1Dctce+p1Ua0jypbZFuaZZmYQ/3
        DOHO5Y61XcToaVe/lbTT6+Jom8mYVv04WkeLoYrN5rfVVBAJSnGM0dpxZ+t/r8+P9/f9/Xy+
        +ZI4v5LnRMYoEliVgokTEtYcfaubm2eeO4gQ/VaMI8PICheVj+US6NqLDRwtNk9yUX5uIQ/1
        TdmixoUbXNS7noqhyaptDBlu5mPop/I2DM2U3gIovasXQ1sTYtS2/ZxA+S2DADWOeiBDYycH
        6X6c5qHMoXoCNc014qi04xWGrlwewNCv2i0C6Td1OGr9a4CDyrcQupi1wUOzD8MCnem+/hD6
        imaBR2uKn3Lovp5EuqosnaCrb39LFwyXArphJIWgL3S34XThspGgh7rrMDpbs0DQS9OjHFo/
        kc2jF5sGCDqnpgyE2p+JPRrNMjJWJWAVkfGyGEWUvzDk0/CgcB9fkdhTLEUfCgUKRs76C4M/
        CvU8ERNnWpJQ8DUTl2hKhTJqtdD72FFVfGICK4iOVyf4C1mlLE4pUXqpGbk6URHlpWAT/MQi
        0SEfU+OXsdELFQZM2Q3P9egy8RSgs88AViSkJLAqPQdkAGuSTzUAOLs+ipuDZQD1m608c7AC
        4PpENb4nqU0b55oLDwC8M5qxW+BTFzGoeR6UAUiSoDxg1za5k7anHOBWr37XAqdWOHBwSMvb
        KdhRAbD9XhmxwxzKFWYtp3F22IaSQuMjo8XMBZZMNHN32Iryg2tb1yw9b8LO61O7jFPvQk3t
        jd1rQ2rUCv653Y2ZxcGw8N4zwsx2cLajhmdmJ7iy0EiYBZmm0brHMXNQCKAmT2NRBMDfDS+x
        nXFwyg3efeBtTjvDq0/uYGZnW5i9OWUxs4H1RXvsAn++W2w5xhEO/p1qYRo2ZbVaFtwP4NPF
        TiIPCLSvTaR9bSLt/9bFAC8DjqxSLY9i1T7KQwr27H/vHBkvrwK7X8f9ZD2YePbCqwVgJGgB
        kMSF9jZvZ24zfBsZc/4bVhUfrkqMY9UtwMe08iu40/7IeNPfUySEiyVSkcTX11ciPewrFjrY
        dEVVMnwqiklgY1lWyar2dBhp5ZSCBa0GLBtfiub/qKi/XXJcah/UEnSgn7t0wufx6bB9/5Ah
        q5cuf1ISNt+cROjOiAUbh5tfXU8SlK2G5Z41pEkXI3oeOVp3HRn0Sr7k8dbBC4HvyDqvSj1n
        aG5DlleMMWmQM+j91VpiRpsNeswtIEvr/KqHC0Sz7Xz52sf3i6zn3tinDXxSwJ39bv6HBavA
        +/JfrPRDQ8UPI0bGIiNcbWOcrU9NcmrOL7rzXdMi3hsZrw8/UtkxbLeUsTpTkup1cnmuYppP
        1gVLKr84/f7wQT+P/TJjrZ3LpO25me9DtBu1x52Sw491kDm6z4qMdiF0bnKoR9rNsZQPPl+/
        5eAzckrWjjMzB4QcdTQjdsdVauZfcJk/YcMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSnG6OFmOSwZo1BhZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9aen+wWr/bHOch6XL7i7TGx+R27R/OCOywel8+Wemxa
        1cnmsXlJvcfkG8sZPXbfbGDzaDpzlNljxqcvbB7Xz2xn8uhtfsfm8fHpLRaPbQ972T3e77vK
        5tG3ZRVjgEgUl01Kak5mWWqRvl0CV8a7tXuYCs5IVJyd383cwDhfpIuRk0NCwERia8t91i5G
        Lg4hgR2MEs/bu9khEpISy/4eYYawhSVW/nsOFhcSaGaSOHVSp4uRg4NNQFvi9H8OkLCIgLjE
        nwvbGEHmMAtMZ5VoOHWZCSQhLGAvcWzjKjYQm0VAVaLnUwsLiM0rYCnx5cAXqPnKEgsfHmQF
        sTkFrCS+/ZnGAnFQA6NEw7kVrBANghInZz4Ba2YWkJdo3jqbeQKjwCwkqVlIUgsYmVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSnBC2tHYx7Vn3QO8TIxMF4iFGCg1lJhFem+3+i
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxCO59dctb8
        f/N7q7Bdk+m3NVvTdu+o93Sa8e3ceYUu/6znW9K2MTenP7EVEPBfbzH7gPvNL3vLpPQ+aTCb
        PHE5F6kVLix98I3T2YpdZ2ovyDw+GVRXN8VfyrMiZP/sLuvS7OLEAwuTDF90rfczNlv+S2XZ
        jSvms3NcTNg8xQU0TjCvXn/b8Whs19P5q1/k8Dpt+K+0ufhPp3+/Z82j5iLZHQ9/GhyuPmK9
        MN7VMdWk4mNPZNTpYIe+U5kuggc+WiQ0P/xRLWdy+eyJSAenM067SnmjNTf5hT1lEtpTOPnq
        JHfRWu/rApdVrjrx9Ew66+W8+sT6tWfvFr0v/z65YE1K2empryuvBlUYK1nanFJiKc5INNRi
        LipOBABRSx0eeAMAAA==
X-CMS-MailID: 20220207141924epcas5p26ad9cf5de732224f408aded12ed0a577
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141924epcas5p26ad9cf5de732224f408aded12ed0a577
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141924epcas5p26ad9cf5de732224f408aded12ed0a577@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
to one or more destination in a device. COPY ioctl accepts a 'copy_range'
structure that contains no of range, a reserved field , followed by an
array of ranges. Each source range is represented by 'range_entry' that
contains source start offset, destination start offset and length of
source ranges (in bytes)

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/ioctl.c           | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  9 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..d77f6143287e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -124,6 +124,41 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	struct copy_range crange, *ranges;
+	size_t payload_size = 0;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >= MAX_COPY_NR_RANGE))
+		return -EINVAL;
+
+	payload_size = (crange.nr_range * sizeof(struct range_entry)) + sizeof(crange);
+
+	ranges = kmalloc(payload_size, GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	if (copy_from_user(ranges, (void __user *)arg, payload_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list, bdev, GFP_KERNEL, 0);
+	if (copy_to_user((void __user *)arg, ranges, payload_size))
+		ret = -EFAULT;
+out:
+	kfree(ranges);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -455,6 +490,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKSECDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg,
 				BLKDEV_DISCARD_SECURE);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 55bca8f6e8ed..190911ea4311 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -78,6 +78,14 @@ struct range_entry {
 	__u64 comp_len;
 };
 
+struct copy_range {
+	__u64 nr_range;
+	__u64 reserved;
+
+	/* Range_list always must be at the end */
+	struct range_entry range_list[];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -199,6 +207,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.30.0-rc0

