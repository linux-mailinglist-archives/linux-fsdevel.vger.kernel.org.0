Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B26171049
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgB0F1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:27:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgB0F1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:27:37 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R5P96E017811
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:27:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqbtey93-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:27:37 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 05:27:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 05:27:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R5RUAm35258614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 05:27:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8267342041;
        Thu, 27 Feb 2020 05:27:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4F194203F;
        Thu, 27 Feb 2020 05:27:28 +0000 (GMT)
Received: from [9.199.158.169] (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 05:27:28 +0000 (GMT)
Subject: Re: [PATCHv3 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
 <20200226161150.GA8036@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 27 Feb 2020 10:57:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226161150.GA8036@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022705-4275-0000-0000-000003A5DBF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022705-4276-0000-0000-000038BA1094
Message-Id: <20200227052728.A4F194203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002270039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/26/20 9:41 PM, Darrick J. Wong wrote:
> On Wed, Feb 26, 2020 at 03:27:06PM +0530, Ritesh Harjani wrote:
>> For indirect block mapping if the i_block > max supported block in inode
>> then ext4_ind_map_blocks may return a -EIO error. But in case of fiemap
>> this could be a valid query to ext4_map_blocks.
>> So in case if !create then return 0. This also makes ext4_warning to
>> ext4_debug in ext4_block_to_path() for the same reason.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ext4/indirect.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>> index 3a4ab70fe9e0..e1ab495dd900 100644
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -102,7 +102,11 @@ static int ext4_block_to_path(struct inode *inode,
>>   		offsets[n++] = i_block & (ptrs - 1);
>>   		final = ptrs;
>>   	} else {
>> -		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
>> +		/*
>> +		 * It's not yet an error to just query beyond max
>> +		 * block in inode. Fiemap callers may do so.
>> +		 */
>> +		ext4_debug("block %lu > max in inode %lu",
>>   			     i_block + direct_blocks +
>>   			     indirect_blocks + double_blocks, inode->i_ino);
> 
> Does that mean fiemap callers can spamflood dmesg with this message just
> by setting the query start range to a huge value?

Not in the old implementation. But This could happen with indirect
block mapping with new implementation in iomap (as there is no check in 
place before calling ext4_map_blocks()).
Previously __generic_block_fiemap() used to not query beyond
i_size_read(), so we were safe there.

So yes now as Jan also suggested, will add a check in place in
ext4_iomap_begin_report() itself, so that this flooding wont happen.


Thanks for the review!!

-ritesh

> 
> --D
> 
>>   	}
>> @@ -537,8 +541,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>   	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
>>   				   &blocks_to_boundary);
>>   
>> -	if (depth == 0)
>> +	if (depth == 0) {
>> +		if (!(flags & EXT4_GET_BLOCKS_CREATE))
>> +			err = 0;
>>   		goto out;
>> +	}
>>   
>>   	partial = ext4_get_branch(inode, depth, offsets, chain, &err);
>>   
>> -- 
>> 2.21.0
>>

