Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E688B884
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfHMM1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 08:27:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbfHMM1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DCMv0W040282
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 08:27:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubsw30mk9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 08:27:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 13 Aug 2019 13:27:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Aug 2019 13:27:25 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7DCRO2W51445988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 12:27:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BFC34C046;
        Tue, 13 Aug 2019 12:27:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6264C040;
        Tue, 13 Aug 2019 12:27:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 12:27:23 +0000 (GMT)
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
From:   RITESH HARJANI <riteshh@linux.ibm.com>
Date:   Tue, 13 Aug 2019 17:57:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190813111004.GA12682@poseidon.bobrowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081312-0008-0000-0000-000003088469
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081312-0009-0000-0000-00004A2696E0
Message-Id: <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/13/19 4:40 PM, Matthew Bobrowski wrote:
> On Mon, Aug 12, 2019 at 11:01:50PM +0530, RITESH HARJANI wrote:
>>> This patch series converts the ext4 direct IO code paths to make use of the
>>> iomap infrastructure and removes the old buffer_head direct-io based
>>> implementation. The result is that ext4 is converted to the newer framework
>>> and that it may _possibly_ gain a performance boost for O_SYNC | O_DIRECT IO.
>>>
>>> These changes have been tested using xfstests in both DAX and non-DAX modes
>>> using various configurations i.e. 4k, dioread_nolock, dax.
>> I had some minor review comments posted on Patch-4.
>> But the rest of the patch series looks good to me.
> Thanks for the review, much appreciated! Also, apologies about any
> delayed response to your queries, I predominantly do all this work in
> my personal time.
Np at all.

>
>> I will also do some basic testing of xfstests which I did for my patches and
>> will revert back.
> Sounds good!

I did not find any failure new failures in xfstests with 4K block size.
Neither in basic fio DIO/AIO testing. So my basic testing looks good
(these are mostly the tests which I was using for my debug/dev too)


>
>> One query, could you please help answering below for my understanding :-
>>
>> I was under the assumption that we need to maintain
>> ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) or
>> atomic_read(&EXT4_I(inode)->i_unwritten))
>> in case of non-AIO directIO or AIO directIO case as well (when we may
>> allocate unwritten extents),
>> to protect with some kind of race with other parts of code(maybe
>> truncate/bufferedIO/fallocate not sure?) which may call for
>> ext4_can_extents_be_merged()
>> to check if extents can be merged or not.
>>
>> Is it not the case?
>> Now that directIO code has no way of specifying that this inode has
>> unwritten extent, will it not race with any other path, where this info was
>> necessary (like
>> in above func ext4_can_extents_be_merged())?
> Ah yes, I was under the same assumption when reviewing the code
> initially and one of my first solutions was to also use this dynamic
> 'state' flag in the ->end_io() handler. But, I fell flat on my face as
> that deemed to be problematic... This is because there can be multiple
> direct IOs to unwritten extents against the same inode, so you cannot
> possibly get away with tracking them using this single inode flag. So,
> hence the reason why we drop using EXT4_STATE_DIO_UNWRITTEN and use
> IOMAP_DIO_UNWRITTEN instead in the ->end_io() handler, which tracks
> whether _this_ particular IO has an underlying unwritten extent.

Thanks for taking time to explain this.

Yes, I do understand that part - i.e. while preparing block mapping in 
->iomap_begin
we get to know(from ext4_map_blocks) whether this is an unwritten extent 
and we add the flag
IOMAP_DIO_UNWRITTEN to iomap. This is needed so that we can convert 
unwritten extents in ->end_io
before we update the inode size and mark the inode dirty - to avoid any 
race with other AIO DIO or bufferedIO.

But what I meant was this (I may be wrong here since I haven't really 
looked into it),
but for my understanding I would like to discuss this -

So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining 
on whether a newextent can be merged with ex1 in function
ext4_extents_can_be_merged. But now since we have removed that flag we 
have no way of knowing that whether
this inode has any unwritten extents or not from any DIO path.
What I meant is isn't this removal of setting/unsetting of 
flag(EXT4_STATE_DIO_UNWRITTEN)
changing the behavior of this func - ext4_extents_can_be_merged?

Also - could you please explain why this check returns 0 in the first 
place (line 1762 - 1766 below)?

1733 int
1734 ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent 
*ex1,
1735                                 struct ext4_extent *ex2)
<...>

1762         if (ext4_ext_is_unwritten(ex1) &&
1763             (ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) ||
1764              atomic_read(&EXT4_I(inode)->i_unwritten) ||
1765              (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)))
1766                 return 0;
<...>

Regards
Ritesh

