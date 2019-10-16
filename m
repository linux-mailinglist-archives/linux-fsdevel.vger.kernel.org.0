Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84D5D91C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405262AbfJPM7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:59:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728110AbfJPM7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:59:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GCxFNf071417
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 08:59:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vp1hmn2kp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 08:59:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 13:58:39 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 13:58:37 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9GCwaI843450390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 12:58:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A156A405F;
        Wed, 16 Oct 2019 12:58:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79334A405B;
        Wed, 16 Oct 2019 12:58:33 +0000 (GMT)
Received: from [9.199.158.105] (unknown [9.199.158.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 12:58:33 +0000 (GMT)
Subject: Re: [RFC 2/2] ext4: Move ext4_fiemap to iomap infrastructure
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        tytso@mit.edu, mbobrowski@mbobrowski.org,
        linux-fsdevel@vger.kernel.org
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
 <20190820130634.25954-3-riteshh@linux.ibm.com>
 <20191016084611.GB30337@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 16 Oct 2019 18:28:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191016084611.GB30337@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101612-4275-0000-0000-000003729A6E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101612-4276-0000-0000-00003885AFF8
Message-Id: <20191016125833.79334A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/16/19 2:16 PM, Jan Kara wrote:
> On Tue 20-08-19 18:36:34, Ritesh Harjani wrote:
>> This moves ext4_fiemap to use iomap infrastructure.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Thanks for the patch. I like how it removes lots of code :) The patch looks
> good to me, just two small comments below. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Sure, thanks. It's been some quite some time.
Let me rebase these patches on latest upstream kernel.

> 
>> +static int ext4_xattr_iomap_fiemap(struct inode *inode, struct iomap *iomap)
>>   {
>> -	__u64 physical = 0;
>> -	__u64 length;
>> -	__u32 flags = FIEMAP_EXTENT_LAST;
>> +	u64 physical = 0;
>> +	u64 length;
>>   	int blockbits = inode->i_sb->s_blocksize_bits;
>> -	int error = 0;
>> +	int ret = 0;
>>   
>>   	/* in-inode? */
>>   	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>>   		struct ext4_iloc iloc;
>> -		int offset;	/* offset of xattr in inode */
>> +		int offset;     /* offset of xattr in inode */
>>   
>> -		error = ext4_get_inode_loc(inode, &iloc);
>> -		if (error)
>> -			return error;
>> +		ret = ext4_get_inode_loc(inode, &iloc);
>> +		if (ret)
>> +			goto out;
>>   		physical = (__u64)iloc.bh->b_blocknr << blockbits;
>>   		offset = EXT4_GOOD_OLD_INODE_SIZE +
>>   				EXT4_I(inode)->i_extra_isize;
> 
> Hum, I see you've just copied this from the old code but this actually
> won't give full information for FIEMAP of inode with extended attribute
> inodes. 

Could you please elaborate on above? I am anyway taking a look at it in
parallel. I can provide that as a separate patch, if required.


> Not something you need to fix for your patch but I wanted to
> mention this so that it doesn't get lost.

Sure :)

> 
>>   		physical += offset;
>>   		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
>> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>>   		brelse(iloc.bh);
>>   	} else { /* external block */
>>   		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>>   		length = inode->i_sb->s_blocksize;
>>   	}
>>   
>> -	if (physical)
>> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
>> -						length, flags);
>> -	return (error < 0 ? error : 0);
>> +	iomap->addr = physical;
>> +	iomap->offset = 0;
>> +	iomap->length = length;
>> +	iomap->type = IOMAP_INLINE;
>> +	iomap->flags = 0;
>> +out:
>> +	return ret;
>>   }
> 
> ...
> 
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d6a34214e9df..92705e99e07c 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3581,15 +3581,24 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>>   		iomap->addr = IOMAP_NULL_ADDR;
>>   	} else {
>> -		if (map.m_flags & EXT4_MAP_MAPPED) {
>> -			iomap->type = IOMAP_MAPPED;
>> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>> +		/*
>> +		 * There can be a case where map.m_flags may
>> +		 * have both EXT4_MAP_UNWRITTEN & EXT4_MAP_MERGED
>> +		 * set. This is when we do fallocate first and
>> +		 * then try to write to that area, then it may have
>> +		 * both flags set. So check for unwritten first.
>> +		 */
>> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>>   			iomap->type = IOMAP_UNWRITTEN;
>> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
>> +			iomap->type = IOMAP_MAPPED;
> 
> This should be already part of Matthew's series so once you rebase on top
> of it, you can just drop this hunk.

Sure, will do.

-riteshh


