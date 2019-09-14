Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80663B2926
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 02:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbfINAmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 20:42:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53618 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbfINAmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:42:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cc4v109001;
        Sat, 14 Sep 2019 00:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=MKvhh2dMQo17C4zP8JejHtFY8fVz0F7EkVCfipCt5TM=;
 b=ljhakvNbgjxtoUDoMpO2YE3y+Hf1xCLm2+BgkwFGiQddGjP3N0aAaf18vKW76KJEtR7g
 nBrNQ4lxZAiS3heZGr+kpkDDmeVNt1kEZfiqh2J0uIyiBj65NrVg2FzOIKRcK/83WcTL
 rzROfG+VymhAOzUqa8PdPiFvUGGMXwtZm3ZGHDixTRrVplF35Fe2KyQSQnxb947yu5SS
 333eVpq0UO9kwn1FJoYF6Uhb6Ngn9ai7XR5dQ77euDygd4jMuBWu4hFLKdUScefJ/hp0
 rlV2fKJSOThvnPtFQpRmkTNtbdMc8Blt2JxGDcYNFr67LVWxVbnPpwNzsvwpjX5AUVpL mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uytd3qgpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cOCJ174473;
        Sat, 14 Sep 2019 00:42:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0nb1114q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8E0g7M9025684;
        Sat, 14 Sep 2019 00:42:07 GMT
Received: from [192.168.1.9] (/67.1.21.243)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 17:42:07 -0700
From:   Allison Collins <allison.henderson@oracle.com>
Subject: Re: [PATCH 01/19] iomap: better document the IOMAP_F_* flags
To:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-2-hch@lst.de>
Message-ID: <3a7fd51f-65a4-0a5e-40d9-fc59e8f90342@oracle.com>
Date:   Fri, 13 Sep 2019 17:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909182722.16783-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me, I think the new comments are a lot more helpful
Reviewed-by: Allison Collins <allison.henderson@oracle.com>

On 9/9/19 11:27 AM, Christoph Hellwig wrote:
> The documentation for IOMAP_F_* is a bit disorganized, and doesn't
> mention the fact that most flags are set by the file system and consumed
> by the iomap core, while IOMAP_F_SIZE_CHANGED is set by the core and
> consumed by the file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/iomap.h | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e79af6b28410..8adcc8dd4498 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -30,21 +30,36 @@ struct vm_fault;
>   #define IOMAP_INLINE	0x05	/* data inline in the inode */
>   
>   /*
> - * Flags for all iomap mappings:
> + * Flags reported by the file system from iomap_begin:
> + *
> + * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
> + * zeroing for areas that no data is copied to.
>    *
>    * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
>    * written data and requires fdatasync to commit them to persistent storage.
> + *
> + * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
> + * unshared as part a write.
> + *
> + * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
> + * mappings.
> + *
> + * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
> + * buffer heads for this mapping.
>    */
> -#define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
> -#define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
> -#define IOMAP_F_BUFFER_HEAD	0x04	/* file system requires buffer heads */
> -#define IOMAP_F_SIZE_CHANGED	0x08	/* file size has changed */
> +#define IOMAP_F_NEW		0x01
> +#define IOMAP_F_DIRTY		0x02
> +#define IOMAP_F_SHARED		0x04
> +#define IOMAP_F_MERGED		0x08
> +#define IOMAP_F_BUFFER_HEAD	0x10
>   
>   /*
> - * Flags that only need to be reported for IOMAP_REPORT requests:
> + * Flags set by the core iomap code during operations:
> + *
> + * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> + * has changed as the result of this write operation.
>    */
> -#define IOMAP_F_MERGED		0x10	/* contains multiple blocks/extents */
> -#define IOMAP_F_SHARED		0x20	/* block shared with another file */
> +#define IOMAP_F_SIZE_CHANGED	0x100
>   
>   /*
>    * Flags from 0x1000 up are for file system specific usage:
> 
