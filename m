Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C254C17553D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 09:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCBIKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 03:10:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgCBIKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:10:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02289SGq038487
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 03:10:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbeec48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 03:10:17 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 2 Mar 2020 08:10:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 08:10:10 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0228A9M757344066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 08:10:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E485DA4055;
        Mon,  2 Mar 2020 08:10:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B710A4070;
        Mon,  2 Mar 2020 08:10:07 +0000 (GMT)
Received: from [9.199.158.200] (unknown [9.199.158.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 08:10:07 +0000 (GMT)
Subject: Re: [PATCHv5 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        david@fromorbit.com
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
 <20200228153650.GG29971@bombadil.infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 2 Mar 2020 13:40:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200228153650.GG29971@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030208-0028-0000-0000-000003DFD14E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030208-0029-0000-0000-000024A4F937
Message-Id: <20200302081007.8B710A4070@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_02:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020063
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/28/20 9:06 PM, Matthew Wilcox wrote:
> On Fri, Feb 28, 2020 at 02:56:59PM +0530, Ritesh Harjani wrote:
>> Currently FIEMAP_EXTENT_LAST is not working consistently across
>> different filesystem's fiemap implementations. So add more information
>> about how else this flag could set in other implementation.
>>
>> Also in general, user should not completely rely on this flag as
>> such since it could return false value for e.g.
>> when there is a delalloc extent which might get converted during
>> writeback, immediately after the fiemap calls return.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   Documentation/filesystems/fiemap.txt | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
>> index f6d9c99103a4..fedfa9b9dde5 100644
>> --- a/Documentation/filesystems/fiemap.txt
>> +++ b/Documentation/filesystems/fiemap.txt
>> @@ -71,8 +71,7 @@ allocated is less than would be required to map the requested range,
>>   the maximum number of extents that can be mapped in the fm_extent[]
>>   array will be returned and fm_mapped_extents will be equal to
>>   fm_extent_count. In that case, the last extent in the array will not
>> -complete the requested range and will not have the FIEMAP_EXTENT_LAST
>> -flag set (see the next section on extent flags).
>> +complete the requested range.
> 
> This sentence still seems like it should be true.  If the filesystem knows
> there are more extents to come, it will definitely not set the LAST flag.
> 

sure.

>> @@ -96,7 +95,7 @@ block size of the file system.  With the exception of extents flagged as
>>   FIEMAP_EXTENT_MERGED, adjacent extents will not be merged.
>>   
>>   The fe_flags field contains flags which describe the extent returned.
>> -A special flag, FIEMAP_EXTENT_LAST is always set on the last extent in
>> +A special flag, FIEMAP_EXTENT_LAST *may be* set on the last extent in
>>   the file so that the process making fiemap calls can determine when no
>>   more extents are available, without having to call the ioctl again.
> 
> I'm not sure I'd highlight 'may be' here.

Sure.

> 
>> @@ -115,8 +114,9 @@ data. Note that the opposite is not true - it would be valid for
>>   FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
>>   
>>   * FIEMAP_EXTENT_LAST
>> -This is the last extent in the file. A mapping attempt past this
>> -extent will return nothing.
>> +This is generally the last extent in the file. A mapping attempt past this
>> +extent may return nothing. In some implementations this flag is also set on
>> +the last dataset queried by the user (via fiemap->fm_length).
> 
> The word 'dataset' is used nowhere else in this document.  How about
> 
> "Some filesystems set this flag to indicate this extent is the last one in
> the range queried by the user"

Sure.

Thanks for the review.
Will make the suggested changes and send a v6.

-ritesh

