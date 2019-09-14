Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34648B292A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 02:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbfINAny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 20:43:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbfINAnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:43:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cqgx053730;
        Sat, 14 Sep 2019 00:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=/9lz0sqsErrNF84LRJY5KKsEVh0/tZO5PskEvqD/CgM=;
 b=E+taBmH2uqJEk9s62PWdBT1U7ewMHu5iYgkQGR2PcdpgSCz3vbVCZUcFMg05DzouioeB
 wJaoqG8zxPneIAExCaJvvzbhciU+fQBQQ55K56XIgaeQKlc9yplnSPQRnSPswtWTcMYy
 rRp8W7dZ9GyyLMbNP7/dvk/bfV/1gKvz5DCbHhlOXRRFCupKjXR0lTTEDDBGxBAjcQCY
 AQdlziSFLeE/vFRAN7dipjHCuCN3SXzn8iGGowwXE5QvQPXMsbjFvxOfg06LDbJMSBLG
 ViqGFnidT0rVkgLSYduzOwjDQFI0N82NR+AarFK3DsU81hJ06WnJk302Y9+oQaHocbEz Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uytd37kf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:43:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0hNKu181499;
        Sat, 14 Sep 2019 00:43:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v0nb111md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:43:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8E0gsv6010404;
        Sat, 14 Sep 2019 00:42:55 GMT
Received: from [192.168.1.9] (/67.1.21.243)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 17:42:54 -0700
From:   Allison Collins <allison.henderson@oracle.com>
Subject: Re: [PATCH 17/19] xfs: rename the whichfork variable in
 xfs_buffered_write_iomap_begin
To:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-18-hch@lst.de>
Message-ID: <bcee3337-2168-bb58-b22a-ec7e93f2d07e@oracle.com>
Date:   Fri, 13 Sep 2019 17:42:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909182722.16783-18-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks fine:
Reviewed-by: Allison Collins <allison.henderson@oracle.com>

On 9/9/19 11:27 AM, Christoph Hellwig wrote:
> Renaming whichfork to allocfork in xfs_buffered_write_iomap_begin makes
> the usage of this variable a little more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/xfs/xfs_iomap.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 6dd143374d75..0e575ca1e3fc 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -862,7 +862,7 @@ xfs_buffered_write_iomap_begin(
>   	struct xfs_iext_cursor	icur, ccur;
>   	xfs_fsblock_t		prealloc_blocks = 0;
>   	bool			eof = false, cow_eof = false, shared = false;
> -	int			whichfork = XFS_DATA_FORK;
> +	int			allocfork = XFS_DATA_FORK;
>   	int			error = 0;
>   
>   	/* we can't use delayed allocations when using extent size hints */
> @@ -959,7 +959,7 @@ xfs_buffered_write_iomap_begin(
>   		 * Fork all the shared blocks from our write offset until the
>   		 * end of the extent.
>   		 */
> -		whichfork = XFS_COW_FORK;
> +		allocfork = XFS_COW_FORK;
>   		end_fsb = imap.br_startoff + imap.br_blockcount;
>   	} else {
>   		/*
> @@ -975,7 +975,7 @@ xfs_buffered_write_iomap_begin(
>   		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>   
>   		if (xfs_is_always_cow_inode(ip))
> -			whichfork = XFS_COW_FORK;
> +			allocfork = XFS_COW_FORK;
>   	}
>   
>   	error = xfs_qm_dqattach_locked(ip, false);
> @@ -983,7 +983,7 @@ xfs_buffered_write_iomap_begin(
>   		goto out_unlock;
>   
>   	if (eof) {
> -		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
> +		prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork, offset,
>   				count, &icur);
>   		if (prealloc_blocks) {
>   			xfs_extlen_t	align;
> @@ -1006,11 +1006,11 @@ xfs_buffered_write_iomap_begin(
>   	}
>   
>   retry:
> -	error = xfs_bmapi_reserve_delalloc(ip, whichfork, offset_fsb,
> +	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
>   			end_fsb - offset_fsb, prealloc_blocks,
> -			whichfork == XFS_DATA_FORK ? &imap : &cmap,
> -			whichfork == XFS_DATA_FORK ? &icur : &ccur,
> -			whichfork == XFS_DATA_FORK ? eof : cow_eof);
> +			allocfork == XFS_DATA_FORK ? &imap : &cmap,
> +			allocfork == XFS_DATA_FORK ? &icur : &ccur,
> +			allocfork == XFS_DATA_FORK ? eof : cow_eof);
>   	switch (error) {
>   	case 0:
>   		break;
> @@ -1027,8 +1027,8 @@ xfs_buffered_write_iomap_begin(
>   		goto out_unlock;
>   	}
>   
> -	if (whichfork == XFS_COW_FORK) {
> -		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> +	if (allocfork == XFS_COW_FORK) {
> +		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
>   		goto found_cow;
>   	}
>   
> @@ -1037,7 +1037,7 @@ xfs_buffered_write_iomap_begin(
>   	 * them out if the write happens to fail.
>   	 */
>   	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> +	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
>   	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
>   
>   found_imap:
> 
