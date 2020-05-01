Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5071C2145
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgEAXeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:34:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:34:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041NWHO2129058;
        Fri, 1 May 2020 19:34:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r84mxyv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:34:08 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041NWPoj129257;
        Fri, 1 May 2020 19:34:08 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r84mxyun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:34:08 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NU8SH012721;
        Fri, 1 May 2020 23:34:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu53vsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:34:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NWt5Z52560270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:32:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DE48AE053;
        Fri,  1 May 2020 23:34:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5101BAE045;
        Fri,  1 May 2020 23:34:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:34:02 +0000 (GMT)
Subject: Re: [PATCH 07/11] iomap: fix the iomap_fiemap prototype
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-8-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 05:04:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501233402.5101BAE045@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_17:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> iomap_fiemap should take u64 start and len arguments, just like the
> ->fiemap prototype.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

hmm.. I guess,
it's only ->fiemap ops in inode_operations which has
start and len arguments as u64.

While such other ops in struct file_operations have the
arguments of type loff_t. (e.g. ->fallocate, -->llseek etc).

But sure to match the ->fiemap prototype, this patch looks ok to me.

Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/iomap/fiemap.c     | 2 +-
>   include/linux/iomap.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index fca3dfb9d964a..dd04e4added15 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -66,7 +66,7 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>   }
>   
>   int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> -		loff_t start, loff_t len, const struct iomap_ops *ops)
> +		u64 start, u64 len, const struct iomap_ops *ops)
>   {
>   	struct fiemap_ctx ctx;
>   	loff_t ret;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0db..63db02528b702 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,7 +178,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>   vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>   			const struct iomap_ops *ops);
>   int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		loff_t start, loff_t len, const struct iomap_ops *ops);
> +		u64 start, u64 len, const struct iomap_ops *ops);
>   loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
>   		const struct iomap_ops *ops);
>   loff_t iomap_seek_data(struct inode *inode, loff_t offset,
> 
