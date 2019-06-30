Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23C05B254
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 01:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfF3XUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 19:20:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfF3XUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 19:20:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5UNJ10m071968;
        Sun, 30 Jun 2019 23:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=axz3J6ouM/L8KDPjpHjAo4EOHOdtx8sMNGt8BPk7VLA=;
 b=AILi/mCQjrO3G1EuhQO/OpdZWqYM3oXIyLFg1hjAAn1FYOkSqfTsF+WFZEBchFGoAL9X
 NLAofI/xksy1IZBKKlkyIRE51XOA0LMxBr38cYwhV6Eh79xK+5WF0wjqmUi8tbU6L2fA
 2nsU+UlryLYUxQhZOGUr/2iugtpTfFGFBRWzMvW1VhWBHU9s99ExjXXvV8r6+sGRQjsh
 gnB5tBR6Y6xeS128XHsYDhYh4osNm/X+IoWMAoMaeBS5R8TJme85T2wwayBAr/GPpoGm
 MJFSUgpKFWt4qOrzpTeNmhf+8189SZI7g6QMgWfuaVhzH+8PkREC4MhbXtnk2faNDMHR 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbam1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jun 2019 23:19:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5UNHuAv054192;
        Sun, 30 Jun 2019 23:19:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tebajwpse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jun 2019 23:19:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5UNJdJ5019635;
        Sun, 30 Jun 2019 23:19:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Jun 2019 16:19:39 -0700
Date:   Sun, 30 Jun 2019 16:19:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, gaoxiang25@huawei.com,
        chao@kernel.org
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
Message-ID: <20190630231932.GI1404256@magnolia>
References: <20190629073020.22759-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629073020.22759-1-yuchao0@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906300300
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906300301
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 03:30:20PM +0800, Chao Yu wrote:
> Some filesystems like erofs/reiserfs have the ability to pack tail
> data into metadata, however iomap framework can only support mapping
> inline data with IOMAP_INLINE type, it restricts that:
> - inline data should be locating at page #0.
> - inline size should equal to .i_size

Wouldn't it be easier simply to fix the meaning of IOMAP_INLINE so that
it can be used at something other than offset 0 and length == isize?
IOWs, make it mean "use the *inline_data pointer to read/write data
as a direct memory access"?

I also don't really like the idea of leaving the write paths
unimplemented in core code, though I suppose as an erofs developer
you're not likely to have a good means for testing... :/

/me starts wondering if a better solution would be to invent iomaptestfs
which exists solely to test all iomap code with as little other
intelligence as possible...

--D

> So we can not use IOMAP_INLINE to handle tail-packing case.
> 
> This patch introduces new mapping type IOMAP_TAIL to map tail-packed
> data for further use of erofs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/iomap.c            | 22 ++++++++++++++++++++++
>  include/linux/iomap.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 12654c2e78f8..ae7777ce77d0 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  	SetPageUptodate(page);
>  }
>  
> +static void
> +iomap_read_tail_data(struct inode *inode, struct page *page,
> +		struct iomap *iomap)
> +{
> +	size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
> +	void *addr;
> +
> +	if (PageUptodate(page))
> +		return;
> +
> +	addr = kmap_atomic(page);
> +	memcpy(addr, iomap->inline_data, size);
> +	memset(addr + size, 0, PAGE_SIZE - size);
> +	kunmap_atomic(addr);
> +	SetPageUptodate(page);
> +}
> +
>  static loff_t
>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
> @@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		return PAGE_SIZE;
>  	}
>  
> +	if (iomap->type == IOMAP_TAIL) {
> +		iomap_read_tail_data(inode, page, iomap);
> +		return PAGE_SIZE;
> +	}
> +
>  	/* zero post-eof blocks as the page may be mapped */
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2103b94cb1bf..7e1ee48e3db7 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -25,6 +25,7 @@ struct vm_fault;
>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> +#define IOMAP_TAIL	0x06	/* tail data packed in metdata */
>  
>  /*
>   * Flags for all iomap mappings:
> -- 
> 2.18.0.rc1
> 
