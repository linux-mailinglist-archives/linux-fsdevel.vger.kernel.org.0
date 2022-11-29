Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37D63C148
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiK2Nl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 08:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiK2NlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:41:24 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E263BAF
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 05:41:20 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221129134118epoutp02e72007a17fb903fa6d47eaf5340b5621~sEe6zbicX3040830408epoutp02A
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 13:41:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221129134118epoutp02e72007a17fb903fa6d47eaf5340b5621~sEe6zbicX3040830408epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669729278;
        bh=X5OnDciPSZQk1Z/2km1aTjbpWH+LZ/crdX8oTsDacms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SuYHPhdthcFgWv+MafMtVvu2E3qGHWgsCTM6VVUbqF3onO/KsGgK4LPIOhNzlGWIs
         rz3acLdb35U60eS6cqb4PPxs0zMIX1hWvPo02Qbc4uF/Mdr0V+Wyw44XXddyQpqQ25
         PbynUUoKSWZAxVnRY5Fl3cYyHeZHOKdqV8M6utEQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221129134117epcas5p49d2c31b7fada494b47a151672882a3e5~sEe6ERRMM2755627556epcas5p4C;
        Tue, 29 Nov 2022 13:41:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NM3QN2LG2z4x9Pt; Tue, 29 Nov
        2022 13:41:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.7F.56352.CFB06836; Tue, 29 Nov 2022 22:41:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221129123359epcas5p314d2c089a6aa763ccea46c0b00248df0~sDkIy03Ke0656306563epcas5p3X;
        Tue, 29 Nov 2022 12:33:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221129123359epsmtrp263056ca81427e9c9cd88fe7a32ba2bd6~sDkIx04C30752207522epsmtrp2u;
        Tue, 29 Nov 2022 12:33:59 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-56-63860bfc5112
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.4B.18644.73CF5836; Tue, 29 Nov 2022 21:33:59 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221129123354epsmtip1c1d8b91aaaafde5cd5a70f43306db8f6~sDkEQU7-K2443424434epsmtip10;
        Tue, 29 Nov 2022 12:33:54 +0000 (GMT)
Date:   Tue, 29 Nov 2022 17:52:32 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        naohiro.aota@wdc.com, jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Message-ID: <20221129122232.GC16802@test-zns>
MIME-Version: 1.0
In-Reply-To: <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc99rXwva7g3FXdENeE4nMLCFFh4GdFPHHoNtOJNlQzLsygtl
        lLbrD0EXImjZEAUEIUJZkB/yw+LEIZMKFEk3V8EQIAxUpgOFapz87oxMBdbydNt/n/u953vO
        PffkcFG3PI4HN0mhpdUKiZzAXFmXfvbx8X++4lupwP6QRzZ2/4qSh08soGTDnXyMfNbTi5Lm
        qTI2eavzMkKebbiKkG2Vswh5dWkSI+/+NcwiCy1DgLQNGhDSPOxHtpu7WORA6/cYebrWxiEL
        rBfZpGk8E5D2Gj2HPP9omkVeG15H9i5Y2e+soQwjPRh12XCHQ/X+8SOLGujRUU3Goxh18cwh
        qu1WBkblHplyBGSNsKnpjkGMyms2Asre9Ab1XecxhGoan0Ri+LHJYTJakkCrvWiFVJmQpEgM
        J6L2xO+MFwcLhP7CUDKE8FJIUuhwYld0jH9EktzROuG1XyLXOaQYiUZDbNkWplbqtLSXTKnR
        hhO0KkGuEqkCNJIUjU6RGKCgtVuFAkGg2BG4L1mWmZ3DVhn2ptWVnWZngLz3c4ALF+IiWHay
        BHWyG94GYE3fmznA1cFzAJbOl2DMwQ6gtaaFlQO4y46Kjh2M3grgWFMfhzncB7Ako5LtTMXC
        N8LbI51spwHD/eD1Ja5TXo2L4eTxLJYzHsVvo7DYUsNxXqzCo+DA4YZl5uH+sMJWjTH8Kuwq
        HWc52QWPgGPV5cu6O74Bdl6yIs5EEK9zgY+GZthMP7tg30Q+yvAq+Ke1mcOwB7RPmTGGU+HZ
        onqMMesBNNwwAOZiO8zqdpq5jufJYKE5lpFfh8Xd5xEnozgf5j4bRxidB03lL3kDPNdY8SL/
        Wjj0JPMFU3DkdxNgfsiEwPn7D7ATwNPwv+YM/5UzLJd4G1a0zWGMvA7WLXIZ9IGNrVsqANsI
        1tIqTUoirRGrghR06r/zlipTmsDyYvhGmcC90ZkAC0C4wAIgFyVW82Y/yZK68RIkBw7SamW8
        WienNRYgdsyqAPVwlyodm6XQxgtFoQJRcHCwKDQoWEi8xqsu8ZW64YkSLZ1M0ypa/dKHcF08
        MpD0jYN84/xPrh/PJB4aqQo8nqD3fs/e367df0X2kTZMemCiyFN/wX4B0fKzLbbt9aO1BV8F
        hRndZ+bqtSHJnLQ963mPI5I1tvDyNJDOD21R/xCYm93fs691PmqlfP1i9RO/Mz66h3ubUaLK
        c0IQ+OVNa8un3gtx2bv15p33uvIz5f47IpDImC8mNn0YW0UTa971vRY6nXpq6kj0yqc1K+o3
        h9z8zVqXjtY+FvS/JboRXYgXFOmub5pt4+nHSuvgfGRkpfbc5s9MoP0V8ZBtmyiq9C6evhXz
        Hh16zhYJweIH37id3H205enXD7injN1LHVK6WIZc+UX0edzBv+PQ8KpjfIKlkUmEvqhaI/kH
        E8VYo6EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfVDLcRzHfX+/3377rbvlp8K35jrmOt26IgvfOw9HlB/yeMd5OJfd/C7S
        k2156DoyQkVCuJZjRGl1xRLpSSZb5TJM3RrJVHbFsObpTismTv+97v30+eND4V5PCT9qZ4KC
        lSVI4oSkB3HnodA/eM5gunTGhz4KlbfocaTMceGopPMUiX62GnFU9zGfgzoa7mGouOQRhmqu
        ODD0aNhOIusXC4HO6NoB6m1TYajOEoRq65oJZKq+SKLLhb1cdNpQwUFVPYcAcl4/wkVl7z8R
        qMkiQEaXgbNwAqPqaiWZe6pOLmN8fYtgTK3JjFaTQTIV1w4yNR1pJHPy8MffgfQuDvOpvo1k
        sm9rAOPU+jPHGrIwRttjx9Z4bvaYt52N27mHlU1fsM1jh9n2jEyybNx37sITMg3YlmQCioJ0
        GFTXh2cCD8qLrgJQP5DLyQS837ovLHQ14iPsDYuHbNyRUA+AfSYH5jYIOgC+6mrguIdIOgg+
        Hqbcsg89C9pPpBNuxunXOOwf4LnZm14BTcoSrpv5dDBU9xaQfw9jsL36JjFijIPNeT1/yyJo
        HurD3Ps4LYBFQ3/2eXQk7C64RLp5PD0VNtwxYDlgnGpUWzWqrfrfVgNcA3zZJHl8TLw8NGlm
        Ars3RC6JlycnxIRIE+O14M/TRaIqUKv5HKIDGAV0AFK40IfvWJcu9eJvl+xPYWWJ0bLkOFau
        AwKKEE7kP81sjvaiYyQKdhfLJrGyfy5G8fzSMH2sMzY2QnHGuenDjRfijEHfoLKAyVJNXv27
        86uP9Ioajze/8Pe3fj/a8tMhDiy1j11rE2qz34S/f5APG2/Sw8tDy1aaF4sppWJGnFKMm6L0
        bwVLdfucrh96dViK9LO57mzpofUGi6K207s8oL3NvGyreBGfful7zugnH3zOunK/2QUC5aKr
        iYFH281GvnX4WKpnS/eUqr6oRpU6rNI6JSgrr7+AHDvp6/2m1Gnfois2B4vmRNqqFzu2TI0I
        DkgVdC+btatSz0ux3oWq1k2ranbPmz9mpefu4/qr4ZURWP+GnCafUx30wF0d78GrtaKiMPXt
        FsvhA49nG7ILvojmcoSEfIckVITL5JJfi0aQkWMDAAA=
X-CMS-MailID: 20221129123359epcas5p314d2c089a6aa763ccea46c0b00248df0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d462_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
        <20221123055827.26996-11-nj.shetty@samsung.com>
        <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
        <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d462_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Nov 24, 2022 at 10:47:55AM +0900, Damien Le Moal wrote:
> On 11/24/22 10:32, Damien Le Moal wrote:
> > On 11/23/22 14:58, Nitesh Shetty wrote:
> >> copy_file_range is implemented using copy offload,
> >> copy offloading to device is always enabled.
> >> To disable copy offloading mount with "no_copy_offload" mount option.
> > 
> > And were is the code that handle this option ?
> > 
> >> At present copy offload is only used, if the source and destination files
> >> are on same block device, otherwise copy file range is completed by
> >> generic copy file range.
> >>
> >> copy file range implemented as following:
> >> 	- write pending writes on the src and dest files
> >> 	- drop page cache for dest file if its conv zone
> >> 	- copy the range using offload
> >> 	- update dest file info
> >>
> >> For all failure cases we fallback to generic file copy range
> > 
> > For all cases ? That would be weird. What would be the point of trying to
> > copy again if e.g. the dest zone has gone offline or read only ?
> > 
> >> At present this implementation does not support conv aggregation
> > 
> > Please check this commit message overall: the grammar and punctuation
> > could really be improved.
> > 
> >>
> >> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> >> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> >> ---
> >>  fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 179 insertions(+)
> >>
> >> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> >> index abc9a85106f2..15613433d4ae 100644
> >> --- a/fs/zonefs/super.c
> >> +++ b/fs/zonefs/super.c
> >> @@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
> >>  	return 0;
> >>  }
> >>  
> >> +static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
> >> +		struct inode *dst_inode, loff_t src_off, loff_t dst_off,
> >> +		size_t *len)
> >> +{
> >> +	loff_t size, endoff;
> >> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> >> +
> >> +	inode_lock(src_inode);
> >> +	size = i_size_read(src_inode);
> >> +	inode_unlock(src_inode);
> >> +	/* Don't copy beyond source file EOF. */
> >> +	if (src_off < size) {
> >> +		if (src_off + *len > size)
> >> +			*len = (size - (src_off + *len));
> >> +	} else
> >> +		*len = 0;
> > 
> > Missing curly brackets for the else.
> > 
> >> +
> >> +	mutex_lock(&dst_zi->i_truncate_mutex);
> >> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
> >> +		if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
> >> +			*len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
> >> +
> >> +		if (dst_off != dst_zi->i_wpoffset)
> >> +			goto err;
> >> +	}
> >> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> >> +
> >> +	endoff = dst_off + *len;
> >> +	inode_lock(dst_inode);
> >> +	if (endoff > dst_zi->i_max_size ||
> >> +			inode_newsize_ok(dst_inode, endoff)) {
> >> +		inode_unlock(dst_inode);
> >> +		goto err;
> > 
> > And here truncate mutex is not locked, but goto err will unlock it. This
> > is broken...
> > 
> >> +	}
> >> +	inode_unlock(dst_inode);
> > 
> > ...The locking is completely broken in this function anyway. You take the
> > lock, look at something, then release the lock. Then what if a write or a
> > trunctate comes in when the inode is not locked ? This is completely
> > broken. The inode should be locked with no dio pending when this function
> > is called. This is only to check if everything is ok. This has no business
> > playing with the inode and truncate locks.
> > 
> >> +
> >> +	return 0;
> >> +err:
> >> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
> >> +		loff_t src_off, struct zonefs_inode_info *dst_zi,
> >> +		loff_t dst_off, size_t len)
> >> +{
> >> +	struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
> >> +	struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
> >> +	struct range_entry *rlist = NULL;
> >> +	int ret = len;
> >> +
> >> +	rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);
> > 
> > GFP_NOIO ?
> > 
> >> +	if (!rlist)
> >> +		return -ENOMEM;
> >> +
> >> +	rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
> >> +	rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
> >> +	rlist[0].len = len;
> >> +	rlist[0].comp_len = 0;
> >> +	ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
> >> +			GFP_KERNEL);
> >> +	if (rlist[0].comp_len > 0)
> >> +		ret = rlist[0].comp_len;
> >> +	kfree(rlist);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +/* Returns length of possible copy, else returns error */
> >> +static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
> >> +					struct file *dst_file, loff_t dst_off,
> >> +					size_t *len, unsigned int flags)
> >> +{
> >> +	struct inode *src_inode = file_inode(src_file);
> >> +	struct inode *dst_inode = file_inode(dst_file);
> >> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> >> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> >> +	ssize_t ret;
> >> +
> >> +	if (src_inode->i_sb != dst_inode->i_sb)
> >> +		return -EXDEV;
> >> +
> >> +	/* Start by sync'ing the source and destination files for conv zones */
> >> +	if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> >> +		ret = file_write_and_wait_range(src_file, src_off,
> >> +				(src_off + *len));
> >> +		if (ret < 0)
> >> +			goto io_error;
> >> +	}
> >> +	inode_dio_wait(src_inode);
> > 
> > That is not a "check". So having this in a function called
> > zonefs_copy_file_checks() is a little strange.
> > 
> >> +
> >> +	/* Start by sync'ing the source and destination files ifor conv zones */
> > 
> > Same comment repeated, with typos.
> > 
> >> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> >> +		ret = file_write_and_wait_range(dst_file, dst_off,
> >> +				(dst_off + *len));
> >> +		if (ret < 0)
> >> +			goto io_error;
> >> +	}
> >> +	inode_dio_wait(dst_inode);
> >> +
> >> +	/* Drop dst file cached pages for a conv zone*/
> >> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> >> +		ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
> >> +				dst_off >> PAGE_SHIFT,
> >> +				(dst_off + *len) >> PAGE_SHIFT);
> >> +		if (ret < 0)
> >> +			goto io_error;
> >> +	}
> >> +
> >> +	ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
> >> +			dst_off, len);
> >> +	if (ret < 0)
> > 
> > if (ret)
> > 
> >> +		return ret;
> >> +
> >> +	return *len;
> >> +
> >> +io_error:
> >> +	zonefs_io_error(dst_inode, true);
> >> +	return ret;
> >> +}
> >> +
> >> +static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
> >> +		struct file *dst_file, loff_t dst_off,
> >> +		size_t len, unsigned int flags)
> >> +{
> >> +	struct inode *src_inode = file_inode(src_file);
> >> +	struct inode *dst_inode = file_inode(dst_file);
> >> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> >> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> >> +	ssize_t ret = 0, bytes;
> >> +
> >> +	inode_lock(src_inode);
> >> +	inode_lock(dst_inode);
> > 
> > So you did zonefs_copy_file_checks() outside of these locks, which mean
> > that everything about the source and destination files may have changed.
> > This does not work.
> 
> I forgot to mention that locking 2 inodes blindly like this can leads to
> deadlocks if another process tries a copy range from dst to src at the
> same time (lock order is reversed and so can deadlock).
> 
> > 
> >> +	bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
> >> +	if (bytes < 0)
> >> +		goto unlock_exit;
> >> +
> >> +	ret += bytes;
> >> +
> >> +	file_update_time(dst_file);
> >> +	mutex_lock(&dst_zi->i_truncate_mutex);
> >> +	zonefs_update_stats(dst_inode, dst_off + bytes);
> >> +	zonefs_i_size_write(dst_inode, dst_off + bytes);
> >> +	dst_zi->i_wpoffset += bytes;
> > 
> > This is wierd. iszie for dst will be dst_zi->i_wpoffset. So please do:
> > 
> > 	dst_zi->i_wpoffset += bytes;
> > 	zonefs_i_size_write(dst_inode, dst_zi->i_wpoffset);
> > 
> >> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> > 
> > And you are not taking care of the accounting for active zones here. If
> > the copy made the dst zone full, it is not active anymore. You need to
> > call zonefs_account_active();
> > 
> >> +	/* if we still have some bytes left, do splice copy */
> >> +	if (bytes && (bytes < len)) {
> >> +		bytes = do_splice_direct(src_file, &src_off, dst_file,
> >> +					 &dst_off, len, flags);
> > 
> > No way.
> > 
> >> +		if (bytes > 0)
> >> +			ret += bytes;
> >> +	}
> >> +unlock_exit:
> >> +	if (ret < 0)
> >> +		zonefs_io_error(dst_inode, true);
> > 
> > How can you be sure that you even did an IO when you get an error ?
> > zonefs_issue_copy() may have failed on its kmalloc() and no IO was done.
> > 
> >> +	inode_unlock(src_inode);
> >> +	inode_unlock(dst_inode);
> >> +	return ret;
> >> +}
> >> +
> >> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> >> +				      struct file *dst_file, loff_t dst_off,
> >> +				      size_t len, unsigned int flags)
> >> +{
> >> +	ssize_t ret = -EIO;
> > 
> > This does not need to be initialized.
> > 
> >> +
> >> +	ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
> >> +				     &len, flags);
> > 
> > These checks need to be done for the generic implementation too, no ? Why
> > would checking this automatically trigger the offload ? What if the device
> > does not support offloading ?
> > 
> >> +	if (ret > 0)
> >> +		ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
> >> +				     len, flags);
> > 
> > return here, then no need for the else. But see above. This seems all
> > broken to me.
> > 
> >> +	else if (ret < 0 && ret == -EXDEV)
> >> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
> >> +					      dst_off, len, flags);
> >> +	return ret;
> >> +}
> >> +
> >>  static const struct file_operations zonefs_file_operations = {
> >>  	.open		= zonefs_file_open,
> >>  	.release	= zonefs_file_release,
> >> @@ -1234,6 +1411,7 @@ static const struct file_operations zonefs_file_operations = {
> >>  	.splice_read	= generic_file_splice_read,
> >>  	.splice_write	= iter_file_splice_write,
> >>  	.iopoll		= iocb_bio_iopoll,
> >> +	.copy_file_range = zonefs_copy_file_range,
> >>  };
> >>  
> >>  static struct kmem_cache *zonefs_inode_cachep;
> >> @@ -1804,6 +1982,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> >>  	atomic_set(&sbi->s_active_seq_files, 0);
> >>  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
> >>  
> >> +	/* set copy support by default */
> > 
> > What is this comment supposed to be for ?
> > 
> >>  	ret = zonefs_read_super(sb);
> >>  	if (ret)
> >>  		return ret;
> > 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 

Acked. I do see a gap in current zonefs cfr implementation. I will drop this
implementation for next version. Once we finalize on block copy offload
implementation, will re-pick this and send with above reviews fixed.

Thank you,
Nitesh

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d462_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d462_--
