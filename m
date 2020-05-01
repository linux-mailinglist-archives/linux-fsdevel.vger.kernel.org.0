Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168601C20FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEAW5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:57:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAW5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:57:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041MY54x194461;
        Fri, 1 May 2020 18:57:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnba52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 18:57:02 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041Mv24u044483;
        Fri, 1 May 2020 18:57:02 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnba4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 18:57:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041MepIV013370;
        Fri, 1 May 2020 22:57:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu53v5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 22:57:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041Muwwv55574746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 22:56:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ACB2AE04D;
        Fri,  1 May 2020 22:56:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5C97AE045;
        Fri,  1 May 2020 22:56:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 22:56:55 +0000 (GMT)
Subject: Re: [PATCH 11/11] ext4: remove the access_ok() check in
 ext4_ioctl_get_es_cache
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-12-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:26:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501225655.D5C97AE045@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_16:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> access_ok just checks we are fed a proper user pointer.  We also do that
> in copy_to_user itself, so no need to do this early.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/ioctl.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 0746532ba463d..7fded54d2dba9 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -754,11 +754,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>   	fieinfo.fi_extents_start = ufiemap->fm_extents;
>   
> -	if (fiemap.fm_extent_count != 0 &&
> -	    !access_ok(fieinfo.fi_extents_start,
> -		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
> -		return -EFAULT;
> -
>   	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>   		filemap_write_and_wait(inode->i_mapping);
>   
> 
