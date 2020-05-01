Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E91C2133
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEAXWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:22:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgEAXWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:22:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041N2nsj102358;
        Fri, 1 May 2020 19:21:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mdyqan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:21:53 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041NJXVs034846;
        Fri, 1 May 2020 19:21:53 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mdyqa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:21:53 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NHtxn028586;
        Fri, 1 May 2020 23:21:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5wj0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:21:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NLm2T63570224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:21:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF19AAE055;
        Fri,  1 May 2020 23:21:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C39AE045;
        Fri,  1 May 2020 23:21:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:21:46 +0000 (GMT)
Subject: Re: [PATCH 04/11] ext4: remove the call to fiemap_check_flags in
 ext4_fiemap
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-5-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:51:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501232146.C7C39AE045@d06av26.portsmouth.uk.ibm.com>
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
> iomap_fiemap already calls fiemap_check_flags first thing, so this
> additional check is redundant.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Looks fine. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/extents.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d2a2a3ba5c44a..a41ae7c510170 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4866,9 +4866,6 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>   	}
>   
> -	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
> -		return -EBADR;
> -
>   	/*
>   	 * For bitmap files the maximum size limit could be smaller than
>   	 * s_maxbytes, so check len here manually instead of just relying on the
> 
