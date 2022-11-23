Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73063502F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiKWGO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiKWGOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:14:08 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E0F3906
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:55 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221123061354epoutp03157544e75adcf12f9d9ea437b46b9b1b~qIgkHfEXm0929309293epoutp03u
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221123061354epoutp03157544e75adcf12f9d9ea437b46b9b1b~qIgkHfEXm0929309293epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184034;
        bh=qjxOVyivyB+vJwGT4+o1dKgihFCPZHtfk9wQXF66Pqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1/XHFPyj7Mz683nijLGtrG4B8aKdg0pLUYEQ0kCnp2OrnUQcnpOscgWlfVwAt9Rp
         wIX6XYOku5f0ple/ScbYqIynD6x15hKmJK8DpFyexkX0OL3Vvc4mrTQ5dmtYZaNKvj
         YLRh/WI2qXZ7Q4aTeIQ34vxLp/gte8bkkAek8y7E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221123061353epcas5p27e513557cf50a9c47223485ae09172b8~qIgjaHlxZ2317523175epcas5p22;
        Wed, 23 Nov 2022 06:13:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NH9mv2cxKz4x9Q7; Wed, 23 Nov
        2022 06:13:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.37.56352.F1ABD736; Wed, 23 Nov 2022 15:13:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c~qIdzuCqgV3021930219epcas5p2C;
        Wed, 23 Nov 2022 06:10:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123061044epsmtrp15492e9b07b3038a45061cbc65c0dbdf3~qIdzjunIb1974919749epsmtrp1Q;
        Wed, 23 Nov 2022 06:10:44 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-42-637dba1f2329
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.2B.14392.469BD736; Wed, 23 Nov 2022 15:10:44 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061041epsmtip1e464d5d909ca389f1c8af953c5b59cb4~qIdwm1Hr_1981819818epsmtip1k;
        Wed, 23 Nov 2022 06:10:41 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Date:   Wed, 23 Nov 2022 11:28:27 +0530
Message-Id: <20221123055827.26996-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupil+LIzCtJLcpLzFFi42LZdlhTU1d+V22ywZMz3BbrTx1jtmia8JfZ
        YvXdfjaL32fPM1vsfTeb1eLmgZ1MFitXH2Wy2L3wI5PF0f9v2SwefrnFYjHp0DVGi6dXZzFZ
        7L2lbbFn70kWi8u75rBZzF/2lN1i4vHNrBY7njQyWmz7PZ/Z4vPSFnaLda/fs1icuCVtcf7v
        cVYHcY9Z98+yeeycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHr3N74AKWu+zerzfd5XN
        o2/LKkaPz5vkPNoPdDN5bHrylimALyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
        wlxJIS8xN9VWycUnQNctMwfofyWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmB
        XnFibnFpXrpeXmqJlaGBgZEpUGFCdkb34bSCqRYVm3ZMZW5gfKDbxcjJISFgInF34w2WLkYu
        DiGB3YwSO69+YIdwPjFKtB+YD+V8Y5T48eUTE0zL4t7VzBCJvYwSk99Ph3JamST+P30EVMXB
        wSagLXH6PwdIXESgj0miY/cBsCJmgdlMEm+X/WEHGSUs4C7xbv5ZZhCbRUBV4lx7GyuIzStg
        LfGs9zcryCAJAX2J/vuCIGFOoPCZi7uYIEoEJU7OfMICYjMLyEs0b50NNl9CYD6nxI2jK5kh
        TnWRmDt1OSOELSzx6vgWdghbSuJlfxuUXS6xcsoKNojmFkaJWddnQTXYS7Se6mcGOYJZQFNi
        /S59iLCsxNRT65ggFvNJ9P5+Ag0WXokd82BsZYk16xewQdiSEte+N0LZHhL3b+9ghIRWH6PE
        tivz2CcwKsxC8tAsJA/NQli9gJF5FaNkakFxbnpqsWmBcV5qOTyak/NzNzGCM4WW9w7GRw8+
        6B1iZOJgPMQowcGsJMJb71mTLMSbklhZlVqUH19UmpNafIjRFBjgE5mlRJPzgbkqryTe0MTS
        wMTMzMzE0tjMUEmcd/EMrWQhgfTEktTs1NSC1CKYPiYOTqkGpqcXMn4X8j3Nva9TL7u8Sv7U
        g7PiorPE5aPtNt7JXOXA8085gCkw+7acXfXLiuNafGZGk7Ytv5P8sUljg5++fWDvwoDP/m90
        omOvzc71Z/j4/b+OasIVEe+37e/D+S8mBK6bWrlUoOGC+eG6zQJ9Ksczr4cks+cYT/5+zSkx
        Zvfpf3qfNkQq2yXmlL9uOhNyPmLd8gOn3rg+Y/N3yuoKDRb7ujhspoXYxStR/iXLRHMFZNcJ
        qkhduvnwWfakm7VsyY+OzWWS4e5m2PjgfcrrVw6yDZdCflxb4W389iP3+ztBDRpPX4p7Rcn9
        u33v9A+7bbtPiE/xlNU6Yn5HrMX65akNYWxJGyo8ul0fls8+ocRSnJFoqMVcVJwIALa80fqd
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnG7Kztpkg/sTJSzWnzrGbNE04S+z
        xeq7/WwWv8+eZ7bY+242q8XNAzuZLFauPspksXvhRyaLo//fslk8/HKLxWLSoWuMFk+vzmKy
        2HtL22LP3pMsFpd3zWGzmL/sKbvFxOObWS12PGlktNj2ez6zxeelLewW616/Z7E4cUva4vzf
        46wO4h6z7p9l89g56y67x/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPHqb3wEVtN5n9Xi/7yqb
        R9+WVYwenzfJebQf6Gby2PTkLVMAXxSXTUpqTmZZapG+XQJXRvfhtIKpFhWbdkxlbmB8oNvF
        yMkhIWAisbh3NXMXIxeHkMBuRolpvV+YIBKSEsv+HmGGsIUlVv57zg5R1Mwksfb0DaAEBweb
        gLbE6f8cIHERgQVMEpfvvQKbxCywlEli9pW7bCDdwgLuEu/mnwWbxCKgKnGuvY0VxOYVsJZ4
        1vubFWSQhIC+RP99QZAwJ1D4zMVdTCBhIQEriT3LdCCqBSVOznzCAmIzC8hLNG+dzTyBUWAW
        ktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCo1hLcwfj9lUf9A4xMnEw
        HmKU4GBWEuGt96xJFuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyW
        iYNTqoHJ5H+Qu8iciXkLnzP3HF6ucs/lXvsVmdBFxz7szDnfxOd+4LoQm6Xk91j/U+uOe77d
        sjtu092GLf9fqj4TFuNondC00b3jXew2xpeSnU0/L4sECVa/DWUQlviWH1Lfvimn7km/0Uy1
        uqRfN626rdt14s01Hf/8vv2HYcs2U1u3j8sZn1q9eX45MOtNyl2N50ff7JO7bxSc8/+Gk5yG
        lWi0yRwFOXfnDxqtv5bE+dn92fFzttjHY0sq3uoGbDvzOulhgfZPF9noH7rHZ7rVnlGL3/bg
        vcIm3gkBj5+UJltu4i27VCsqVpYxkeXTh73hr3la57zSty47fC903X31bxb6Hx/qSNn8mV3e
        ZPJui2GFEktxRqKhFnNRcSIAruvDJlEDAAA=
X-CMS-MailID: 20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_file_range is implemented using copy offload,
copy offloading to device is always enabled.
To disable copy offloading mount with "no_copy_offload" mount option.
At present copy offload is only used, if the source and destination files
are on same block device, otherwise copy file range is completed by
generic copy file range.

copy file range implemented as following:
	- write pending writes on the src and dest files
	- drop page cache for dest file if its conv zone
	- copy the range using offload
	- update dest file info

For all failure cases we fallback to generic file copy range
At present this implementation does not support conv aggregation

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index abc9a85106f2..15613433d4ae 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
+		struct inode *dst_inode, loff_t src_off, loff_t dst_off,
+		size_t *len)
+{
+	loff_t size, endoff;
+	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
+
+	inode_lock(src_inode);
+	size = i_size_read(src_inode);
+	inode_unlock(src_inode);
+	/* Don't copy beyond source file EOF. */
+	if (src_off < size) {
+		if (src_off + *len > size)
+			*len = (size - (src_off + *len));
+	} else
+		*len = 0;
+
+	mutex_lock(&dst_zi->i_truncate_mutex);
+	if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
+			*len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
+
+		if (dst_off != dst_zi->i_wpoffset)
+			goto err;
+	}
+	mutex_unlock(&dst_zi->i_truncate_mutex);
+
+	endoff = dst_off + *len;
+	inode_lock(dst_inode);
+	if (endoff > dst_zi->i_max_size ||
+			inode_newsize_ok(dst_inode, endoff)) {
+		inode_unlock(dst_inode);
+		goto err;
+	}
+	inode_unlock(dst_inode);
+
+	return 0;
+err:
+	mutex_unlock(&dst_zi->i_truncate_mutex);
+	return -EINVAL;
+}
+
+static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
+		loff_t src_off, struct zonefs_inode_info *dst_zi,
+		loff_t dst_off, size_t len)
+{
+	struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
+	struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
+	struct range_entry *rlist = NULL;
+	int ret = len;
+
+	rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);
+	if (!rlist)
+		return -ENOMEM;
+
+	rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
+	rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
+	rlist[0].len = len;
+	rlist[0].comp_len = 0;
+	ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
+			GFP_KERNEL);
+	if (rlist[0].comp_len > 0)
+		ret = rlist[0].comp_len;
+	kfree(rlist);
+
+	return ret;
+}
+
+/* Returns length of possible copy, else returns error */
+static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
+					struct file *dst_file, loff_t dst_off,
+					size_t *len, unsigned int flags)
+{
+	struct inode *src_inode = file_inode(src_file);
+	struct inode *dst_inode = file_inode(dst_file);
+	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
+	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
+	ssize_t ret;
+
+	if (src_inode->i_sb != dst_inode->i_sb)
+		return -EXDEV;
+
+	/* Start by sync'ing the source and destination files for conv zones */
+	if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
+		ret = file_write_and_wait_range(src_file, src_off,
+				(src_off + *len));
+		if (ret < 0)
+			goto io_error;
+	}
+	inode_dio_wait(src_inode);
+
+	/* Start by sync'ing the source and destination files ifor conv zones */
+	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
+		ret = file_write_and_wait_range(dst_file, dst_off,
+				(dst_off + *len));
+		if (ret < 0)
+			goto io_error;
+	}
+	inode_dio_wait(dst_inode);
+
+	/* Drop dst file cached pages for a conv zone*/
+	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
+		ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
+				dst_off >> PAGE_SHIFT,
+				(dst_off + *len) >> PAGE_SHIFT);
+		if (ret < 0)
+			goto io_error;
+	}
+
+	ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
+			dst_off, len);
+	if (ret < 0)
+		return ret;
+
+	return *len;
+
+io_error:
+	zonefs_io_error(dst_inode, true);
+	return ret;
+}
+
+static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
+		struct file *dst_file, loff_t dst_off,
+		size_t len, unsigned int flags)
+{
+	struct inode *src_inode = file_inode(src_file);
+	struct inode *dst_inode = file_inode(dst_file);
+	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
+	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
+	ssize_t ret = 0, bytes;
+
+	inode_lock(src_inode);
+	inode_lock(dst_inode);
+	bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
+	if (bytes < 0)
+		goto unlock_exit;
+
+	ret += bytes;
+
+	file_update_time(dst_file);
+	mutex_lock(&dst_zi->i_truncate_mutex);
+	zonefs_update_stats(dst_inode, dst_off + bytes);
+	zonefs_i_size_write(dst_inode, dst_off + bytes);
+	dst_zi->i_wpoffset += bytes;
+	mutex_unlock(&dst_zi->i_truncate_mutex);
+	/* if we still have some bytes left, do splice copy */
+	if (bytes && (bytes < len)) {
+		bytes = do_splice_direct(src_file, &src_off, dst_file,
+					 &dst_off, len, flags);
+		if (bytes > 0)
+			ret += bytes;
+	}
+unlock_exit:
+	if (ret < 0)
+		zonefs_io_error(dst_inode, true);
+	inode_unlock(src_inode);
+	inode_unlock(dst_inode);
+	return ret;
+}
+
+static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
+				      struct file *dst_file, loff_t dst_off,
+				      size_t len, unsigned int flags)
+{
+	ssize_t ret = -EIO;
+
+	ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
+				     &len, flags);
+	if (ret > 0)
+		ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
+				     len, flags);
+	else if (ret < 0 && ret == -EXDEV)
+		ret = generic_copy_file_range(src_file, src_off, dst_file,
+					      dst_off, len, flags);
+	return ret;
+}
+
 static const struct file_operations zonefs_file_operations = {
 	.open		= zonefs_file_open,
 	.release	= zonefs_file_release,
@@ -1234,6 +1411,7 @@ static const struct file_operations zonefs_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
+	.copy_file_range = zonefs_copy_file_range,
 };
 
 static struct kmem_cache *zonefs_inode_cachep;
@@ -1804,6 +1982,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	atomic_set(&sbi->s_active_seq_files, 0);
 	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
 
+	/* set copy support by default */
 	ret = zonefs_read_super(sb);
 	if (ret)
 		return ret;
-- 
2.35.1.500.gb896f729e2

