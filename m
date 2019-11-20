Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF61039E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 13:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfKTMSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 07:18:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728611AbfKTMSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:18:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKCCiH7120078
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 07:18:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf5qpqed-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 07:18:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 20 Nov 2019 12:18:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 12:18:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAKCIXK333292484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 12:18:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E407542041;
        Wed, 20 Nov 2019 12:18:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9639B42047;
        Wed, 20 Nov 2019 12:18:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.63.56])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 12:18:31 +0000 (GMT)
Subject: Re: [RFCv3 2/4] ext4: Add ext4_ilock & ext4_iunlock API
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-3-riteshh@linux.ibm.com>
 <20191120112339.GB30486@bobrowski>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 20 Nov 2019 17:48:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191120112339.GB30486@bobrowski>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112012-0012-0000-0000-00000369C9F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112012-0013-0000-0000-000021A5594E
Message-Id: <20191120121831.9639B42047@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

Thanks for the review.

On 11/20/19 4:53 PM, Matthew Bobrowski wrote:
> On Wed, Nov 20, 2019 at 10:30:22AM +0530, Ritesh Harjani wrote:
>> This adds ext4_ilock/iunlock types of APIs.
>> This is the preparation APIs to make shared
>> locking/unlocking & restarting with exclusive
>> locking/unlocking easier in next patch.
> 
> *scratches head*
> 
> A nit, but what's with the changelog wrapping at like ~40 characters?

Yup will fix that next time. Thanks.

> 
>> +#define EXT4_IOLOCK_EXCL	(1 << 0)
>> +#define EXT4_IOLOCK_SHARED	(1 << 1)
>>
>> +static inline void ext4_ilock(struct inode *inode, unsigned int iolock)
>> +{
>> +	if (iolock == EXT4_IOLOCK_EXCL)
>> +		inode_lock(inode);
>> +	else
>> +		inode_lock_shared(inode);
>> +}
>> +
>> +static inline void ext4_iunlock(struct inode *inode, unsigned int iolock)
>> +{
>> +	if (iolock == EXT4_IOLOCK_EXCL)
>> +		inode_unlock(inode);
>> +	else
>> +		inode_unlock_shared(inode);
>> +}
>> +
>> +static inline int ext4_ilock_nowait(struct inode *inode, unsigned int iolock)
>> +{
>> +	if (iolock == EXT4_IOLOCK_EXCL)
>> +		return inode_trylock(inode);
>> +	else
>> +		return inode_trylock_shared(inode);
>> +}
> 
> Is it really necessary for all these helpers to actually have the
> 'else' statement? Could we not just return/set whatever takes the
> 'else' branch directly from the end of these functions? I think it
> would be cleaner that way.

Sure np.

> 
> /me doesn't really like the naming of these functions either.

:) difference of opinion.

> 
> What's people's opinion on changing these for example:
>     - ext4_inode_lock()
>     - ext4_inode_unlock()
> 

ext4_ilock/iunlock sounds better to me as it is short too.
But if others have also have a strong opinion towards
ext4_inode_lock/unlock() - I am ok with that.


> Or, better yet, is there any reason why we've never actually
> considered naming such functions to have the verb precede the actual
> object that we're performing the operation on? In my opinion, it
> totally makes way more sense from a code readability standpoint and
> overall intent of the function. For example:
>     - ext4_lock_inode()
>     - ext4_unlock_inode()

Not against your suggestion here.
But in kernel I do see a preference towards object followed by a verb.
At least in vfs I see functions like inode_lock()/unlock().

Plus I would not deny that this naming is also inspired from
xfs_ilock()/iunlock API names.

> 
>> +static inline void ext4_ilock_demote(struct inode *inode, unsigned int iolock)
>> +{
>> +	BUG_ON(iolock != EXT4_IOLOCK_EXCL);
>> +	downgrade_write(&inode->i_rwsem);
>> +}
>> +
> 
> Same principle would also apply here.
> 
> On an ending note, I'm not really sure that I like the name of these
> macros. Like, for example, expand the macro 'EXT4_IOLOCK_EXCL' into
> plain english words as if you were reading it. This would translate to
> something like 'EXT4 INPUT/OUPUT LOCK EXCLUSIVE' or 'EXT4 IO LOCK
> EXCLUSIVE'. Just flipping the words around make a significant
> improvement for overall readability i.e. 'EXT4_EXCL_IOLOCK', which
> would expand out to 'EXT4 EXCLUSIVE IO LOCK'. Speaking of, is there

Ditto. Unless you and others have a strong objection, I would rather
keep this as is :)


> any reason why we don't mention 'INODE' here seeing as though that's
> the object we're actually protecting by taking one of these locking
> mechanisms?

hmm, it was increasing the name of the macro if I do it that way.
But that's ok. Is below macro name better?

#define EXT4_INODE_IOLOCK_EXCL		(1 << 0)
#define EXT4_INODE_IOLOCK_SHARED	(1 << 1)


Thanks for the review!!
-ritesh

