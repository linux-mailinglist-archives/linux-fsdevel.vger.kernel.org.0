Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82161C2139
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEAXW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:22:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgEAXW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:22:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041N2nbW102366;
        Fri, 1 May 2020 19:22:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mdyqkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:22:22 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041N3Zoa105538;
        Fri, 1 May 2020 19:22:21 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mdyqjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:22:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NIqsT007390;
        Fri, 1 May 2020 23:22:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7ytyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:22:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NMGg164094586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:22:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC21AAE04D;
        Fri,  1 May 2020 23:22:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D62C4AE053;
        Fri,  1 May 2020 23:22:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:22:14 +0000 (GMT)
Subject: Re: [PATCH 05/11] fs: mark __generic_block_fiemap static
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-6-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:52:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501232214.D62C4AE053@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_17:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> There is no caller left outside of ioctl.c.


Looks fine. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/ioctl.c         | 4 +---
>   include/linux/fs.h | 4 ----
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 282d45be6f453..f55f53c7824bb 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -299,8 +299,7 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
>    * If you use this function directly, you need to do your own locking. Use
>    * generic_block_fiemap if you want the locking done for you.
>    */
> -
> -int __generic_block_fiemap(struct inode *inode,
> +static int __generic_block_fiemap(struct inode *inode,
>   			   struct fiemap_extent_info *fieinfo, loff_t start,
>   			   loff_t len, get_block_t *get_block)
>   {
> @@ -445,7 +444,6 @@ int __generic_block_fiemap(struct inode *inode,
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(__generic_block_fiemap);
>   
>   /**
>    * generic_block_fiemap - FIEMAP for block based inodes
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f6f59b4f22a8..3104c6f7527b5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3299,10 +3299,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
>   extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
>   extern int vfs_readlink(struct dentry *, char __user *, int);
>   
> -extern int __generic_block_fiemap(struct inode *inode,
> -				  struct fiemap_extent_info *fieinfo,
> -				  loff_t start, loff_t len,
> -				  get_block_t *get_block);
>   extern int generic_block_fiemap(struct inode *inode,
>   				struct fiemap_extent_info *fieinfo, u64 start,
>   				u64 len, get_block_t *get_block);
> 
