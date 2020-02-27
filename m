Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01EB17108E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgB0Fid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:38:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgB0Fid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:38:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R5KG4c031110
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:38:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqfvfje7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:38:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 05:38:29 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 05:38:26 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R5cPQo61276334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 05:38:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F8242047;
        Thu, 27 Feb 2020 05:38:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F4B34203F;
        Thu, 27 Feb 2020 05:38:23 +0000 (GMT)
Received: from [9.199.158.169] (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 05:38:23 +0000 (GMT)
Subject: Re: [PATCHv3 5/6] ext4: Move ext4_fiemap to use iomap framework.
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <31caeb6a880e3070ace5dfcb0623fc06f751b443.1582702694.git.riteshh@linux.ibm.com>
 <20200226132720.GQ10728@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 27 Feb 2020 11:08:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226132720.GQ10728@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022705-4275-0000-0000-000003A5DC7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022705-4276-0000-0000-000038BA115F
Message-Id: <20200227053823.3F4B34203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=704 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/26/20 6:57 PM, Jan Kara wrote:
> On Wed 26-02-20 15:27:07, Ritesh Harjani wrote:
>> This patch moves ext4_fiemap to use iomap framework.
>> For xattr a new 'ext4_iomap_xattr_ops' is added.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> ...
> 
>> -static int ext4_xattr_fiemap(struct inode *inode,
>> -				struct fiemap_extent_info *fieinfo)
>> +static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>>   {
>>   	__u64 physical = 0;
>>   	__u64 length;
>> -	__u32 flags = FIEMAP_EXTENT_LAST;
>>   	int blockbits = inode->i_sb->s_blocksize_bits;
>>   	int error = 0;
>> +	u16 iomap_type;
>>   
>>   	/* in-inode? */
>>   	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>> @@ -5130,40 +4928,44 @@ static int ext4_xattr_fiemap(struct inode *inode,
>>   				EXT4_I(inode)->i_extra_isize;
>>   		physical += offset;
>>   		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
>> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>>   		brelse(iloc.bh);
>> +		iomap_type = IOMAP_INLINE;
>>   	} else { /* external block */
>>   		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>>   		length = inode->i_sb->s_blocksize;
>> +		iomap_type = IOMAP_MAPPED;
>>   	}
> 
> If i_file_acl is 0 (i.e., no external xattr block), then I think returned
> iomap should be different...

Yes, my bad. Let me fix this please.


> 
>> +static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
>> +				  loff_t length, unsigned flags,
>> +				  struct iomap *iomap, struct iomap *srcmap)
>>   {
>> -	ext4_lblk_t start_blk;
>> -	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
>> +	int error;
>>   
>> -	int error = 0;
>> -
>> -	if (ext4_has_inline_data(inode)) {
>> -		int has_inline = 1;
>> +	error = ext4_iomap_xattr_fiemap(inode, iomap);
>> +	if (error == 0 && (offset >= iomap->length))
>> +		error = -ENOENT;
> 
> Is ENOENT really correct here? It seems strange to me...
> 

Yes, -ENOENT means that there is no mapping beyond this and so iomap
core will stop querying further in iomap_fiemap.
I see that we do the same in case of inline mapping too in
ext4_iomap_begin_report().

-ritesh

