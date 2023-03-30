Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24B76CF8E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 03:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjC3Byp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 21:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC3Byj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:54:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFC3A8C
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680141268; x=1711677268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A67xdRQ/FSkMuyi9sJbZ2HeCh1QyoYTiBnCvGtZTBW4=;
  b=cKuQLywDPcuOrWNIgfY5ChFL/QHLRjjHMBBE8jw55juAscgSo2oYouZ+
   nv1GuoOGpRw1vuoiPby++mbNm3be5FRM5sO8Wy8ElyaYlELTUJrQ9uu1E
   u8uPSvzMWKCdhnhfPURikWFTrY7X8zt18oM+Jv9PRsbJqofmQnm5rYHHW
   GmMD1ep24Y/8R5+FbjRp7qMYoEgq0FSBXPAr95PJnILP9m2g41kmW+Ukj
   nz5FzYmjoRcWi+pJAoiYMuqqi8ZG6IiNqXkNWJxRN43FIwrHuWkrwf9TR
   qD64uBtTw3s3pd3/SC25HcgwAD0Z7ZYKHB8+lJaHZjN5EfM82AbBnsnai
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="338912433"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 09:54:27 +0800
IronPort-SDR: XDyznzo8Mq/PBXgGeKqvxcrxFVBm/Wt+cvqbhCgP2q6QmXWewZxClXhYzLRob+uoDccCV4Q+Rs
 ERR5/kkWHZjEOvuc5qJ7IMrHdjAdiz4luoUlfTu8REPNcY5YtXYKqYfzIZ0IYUBu9CuBG9AmfC
 SGc5WBNQoBzhCAKUbvHtKRpZzhCpMal9EVKEM19pMTX7yxI60EMNbXxsaflIPABkuq+XnS5Mmx
 kkXUPTTTmPPePRwv2agADnqa7XUUWa/YjYuuVuzOkNrxMsdZaWIt1EwjFsXVHLVnYcE0+6YmfY
 PP0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:10:36 -0700
IronPort-SDR: ZD/omlxQCzZprGt735CIsv141eAnPGNPA2uYA2YX3lBRv/zh4UBPXmAGbSGTnTMOlmhsuVhMwb
 Q78cO/g/g7U18yPixJZuvBNT9JbIkxYhQLBpR2Z3umuwi6B/taCNdCviuyq8eWNtsf/mJu/tsd
 fwItq16INylE2sIbmCVAEhtawAjOLI5vAaJmol5JYOkuR9Fk1yingOYRV0iDUpZJMuVPhxjZG/
 VEWAW8rXr5UfVFKQq02Ou4cmULR0IrPsWRdRhaaDrwv932AuqHuJU6rplnxtA4wUahAbAly4fK
 3AU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:54:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn60z2Xwjz1RtVq
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680141266; x=1682733267; bh=A67xdRQ/FSkMuyi9sJ
        bZ2HeCh1QyoYTiBnCvGtZTBW4=; b=nUbU+AYorSEzo+FUpZcfo9tsOea+bQQDm4
        uzYlk8Fz4+C0vFhEHdcF5ss+6xS2pVB3u29aNTbA5xDo3JW9Xa1q0GL5rF9rKBq9
        obZn3bKm4drGHcZ/UWUscYslvQ9ITISwgYhpwuMyZUjGBTUv8kYK42B/DTg9hTSW
        snRNn6b4vmLKMYfUaD7aZ+0o4zfDsSO+Jk3/dIIjIxUERG7rB7VRKGLNQ+Wc/5ol
        DRa+ZvDI2/qyD6tRy8M6i5j7wbwT9Neoxq1wXlFhK/EOcC+ufdhwR3u84/wmZjE8
        MdkGgM6/mLEDMWZhsVuCjAzgnjaRws0pRgmyiVu4BrAPgtZ1OVkg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yUEnIdCx2dTB for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 18:54:26 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn60y1Vhwz1RtVn;
        Wed, 29 Mar 2023 18:54:26 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/2] zonefs: Always invalidate last cached page on append write
Date:   Thu, 30 Mar 2023 10:54:22 +0900
Message-Id: <20230330015423.2170293-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
References: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a direct append write is executed, the append offset may correspond
to the last page of a sequential file inode which might have been cached
already by buffered reads, page faults with mmap-read or non-direct
readahead. To ensure that the on-disk and cached data is consistant for
such last cached page, make sure to always invalidate it in
zonefs_file_dio_append(). If the invalidation fails, return -EBUSY to
userspace to differentiate from IO errors.

This invalidation will always be a no-op when the FS block size (device
zone write granularity) is equal to the page size (e.g. 4K).

Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 617e4f9db42e..c6ab2732955e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -382,6 +382,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)
 	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct block_device *bdev =3D inode->i_sb->s_bdev;
 	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
+	pgoff_t start, end;
 	struct bio *bio;
 	ssize_t size =3D 0;
 	int nr_pages;
@@ -390,6 +391,19 @@ static ssize_t zonefs_file_dio_append(struct kiocb *=
iocb, struct iov_iter *from)
 	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
=20
+	/*
+	 * If the inode block size (zone write granularity) is smaller than the
+	 * page size, we may be appending data belonging to the last page of th=
e
+	 * inode straddling inode->i_size, with that page already cached due to
+	 * a buffered read or readahead. So make sure to invalidate that page.
+	 * This will always be a no-op for the case where the block size is
+	 * equal to the page size.
+	 */
+	start =3D iocb->ki_pos >> PAGE_SHIFT;
+	end =3D (iocb->ki_pos + iov_iter_count(from) - 1) >> PAGE_SHIFT;
+	if (invalidate_inode_pages2_range(inode->i_mapping, start, end))
+		return -EBUSY;
+
 	nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
 	if (!nr_pages)
 		return 0;
--=20
2.39.2

