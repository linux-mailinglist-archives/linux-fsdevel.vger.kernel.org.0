Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106B716FF17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBZMeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:34:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgBZMeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:34:06 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QCUJJl066982
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 07:34:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydhhn3ksh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 07:34:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 12:34:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 12:34:01 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QCY0aM57344208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 12:34:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 266CF52051;
        Wed, 26 Feb 2020 12:34:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.58.45])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60F425204E;
        Wed, 26 Feb 2020 12:33:58 +0000 (GMT)
Subject: Re: [PATCHv3 1/6] ext4: Add IOMAP_F_MERGED for non-extent based
 mapping
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <25695b1a4bc3b5c3a2f513ecb612195aa7154975.1582702693.git.riteshh@linux.ibm.com>
 <20200226122655.GM10728@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 26 Feb 2020 18:03:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226122655.GM10728@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022612-0008-0000-0000-00000356974E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0009-0000-0000-00004A77B620
Message-Id: <20200226123358.60F425204E@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_04:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260093
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/26/20 5:56 PM, Jan Kara wrote:
> On Wed 26-02-20 15:27:03, Ritesh Harjani wrote:
>> IOMAP_F_MERGED needs to be set in case of non-extent based mapping.
>> This is needed in later patches for conversion of ext4_fiemap to use iomap.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ext4/inode.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d035acab5b2a..3b4230cf0bc2 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3335,6 +3335,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>>   	iomap->offset = (u64) map->m_lblk << blkbits;
>>   	iomap->length = (u64) map->m_len << blkbits;
>>   
>> +	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
>> +		!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>     ^^ we indent the second line of condition either like:
> 
> 	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
> 	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))

Yes, I too prefer it this way. Will fix it.

> 
> or like:
> 
> 	if ((map->m_flags & (EXT4_MAP_UNWRITTEN | EXT4_MAP_MAPPED)) &&
> 			!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> 
> But on at the same level as following code block because that's highly
> confusing at times...
> 
> Also EXT4_MAP_UNWRITTEN is never set for indirect block mapped files (that
> on disk format does not support unwritten extents).

Aah yes. Let me fix it.

> 
> 								Honza
> 
>> +		iomap->flags |= IOMAP_F_MERGED;
>> +
>>   	/*
>>   	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
>>   	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
>> -- 
>> 2.21.0
>>

