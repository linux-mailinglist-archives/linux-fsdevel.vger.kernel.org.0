Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA43155889B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiFWTXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiFWTWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:22:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911F766B3;
        Thu, 23 Jun 2022 11:29:36 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NI4QUo031134;
        Thu, 23 Jun 2022 18:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=41BPo+whxaghuCkgvaKgW8YwNyHKz3jy5mISTK8L0/w=;
 b=ZNiquCoovNJouo8oFYdlDmb0EfxWMBDDXdTtwQREW/G06gGZzez0neqO9ND9+PIqAzen
 7i2Tagsen87uVPTGfVqut1LdfFkHW4txN8mS2dr2owS2JjiW0/zrOQ0lI0Rn04+9TQbp
 AOZI+qC8IXXp1rDsWWkpBk6Iy7aO++0ihZ/uVbddoGA6BRZdIbCNPT33eP16/o+gfcJp
 SqaN0/GprQ5+L/f7v1itBUxQ9bpX3wDlrebKeMxlBM4GZQdpDOo3si5CWX5kPQUeoyu1
 xLLUCAShO8PXkEbjzGxQ1f+5DPJKBTXHr9sQucOqD/rHriKfFA34rWojMcZEycwq8Lx+ Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvw4h8qsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 18:29:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25NIILrE013084;
        Thu, 23 Jun 2022 18:29:19 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvw4h8qry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 18:29:19 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NIKQer022803;
        Thu, 23 Jun 2022 18:29:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3guk92p4ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 18:29:18 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NITIbD6751036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 18:29:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0E9AC05B;
        Thu, 23 Jun 2022 18:29:17 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A810CAC05F;
        Thu, 23 Jun 2022 18:29:14 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.98.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 18:29:14 +0000 (GMT)
Message-ID: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From:   Eric Farman <farman@linux.ibm.com>
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Date:   Thu, 23 Jun 2022 14:29:13 -0400
In-Reply-To: <20220610195830.3574005-12-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
         <20220610195830.3574005-12-kbusch@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fj-OPI6d8hylGrKU8aSR2HKyYGONU-th
X-Proofpoint-GUID: B26JaMnGrmnTYyG8GbNKjwvtdiIDxuKs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_07,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the address alignment requirements from the block_device for
> direct
> io instead of requiring addresses be aligned to the block size.

Hi Keith,

Our s390 PV guests recently started failing to boot from a -next host,
and git blame brought me here.

As near as I have been able to tell, we start tripping up on this code
from patch 9 [1] that gets invoked with this patch:

>	for (k = 0; k < i->nr_segs; k++, skip = 0) {
>		size_t len = i->iov[k].iov_len - skip;
>
>		if (len > size)
>			len = size;
>		if (len & len_mask)
>			return false;

The iovec we're failing on has two segments, one with a len of x200
(and base of x...000) and another with a len of xe00 (and a base of
x...200), while len_mask is of course xfff.

So before I go any further on what we might have broken, do you happen
to have any suggestions what might be going on here, or something I
should try?

Thanks,
Eric

[1] https://lore.kernel.org/r/20220610195830.3574005-9-kbusch@fb.com/

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 370c3241618a..5d098adba443 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct
> iomap_iter *iter,
>  	struct inode *inode = iter->inode;
>  	unsigned int blkbits =
> blksize_bits(bdev_logical_block_size(iomap->bdev));
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	unsigned int align = iov_iter_alignment(dio->submit.iter);
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	unsigned int bio_opf;
> @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct
> iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length | align) & ((1 << blkbits) - 1))
> +	if ((pos | length) & ((1 << blkbits) - 1) ||
> +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
>  	if (iomap->type == IOMAP_UNWRITTEN) {

