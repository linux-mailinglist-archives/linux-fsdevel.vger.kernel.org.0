Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B559F133D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 09:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgAHIid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 03:38:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgAHIid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:38:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0088bSEK053024
        for <linux-fsdevel@vger.kernel.org>; Wed, 8 Jan 2020 03:38:31 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8wh9c44-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 03:38:31 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 8 Jan 2020 08:38:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Jan 2020 08:38:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0088cRrR27132064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 08:38:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E47D342045;
        Wed,  8 Jan 2020 08:38:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6644642041;
        Wed,  8 Jan 2020 08:38:27 +0000 (GMT)
Received: from [9.199.159.43] (unknown [9.199.159.43])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 08:38:27 +0000 (GMT)
Subject: Re: [RESEND PATCH 0/1] Use inode_lock/unlock class of provided APIs
 in filesystems
To:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200101105248.25304-1-riteshh@linux.ibm.com>
 <CAOg9mSR17qRJ4VM5=1jndRwHw2Gcz8txgU9+-9GPFOfR34q7OA@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jan 2020 14:08:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOg9mSR17qRJ4VM5=1jndRwHw2Gcz8txgU9+-9GPFOfR34q7OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010808-0016-0000-0000-000002DB6934
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010808-0017-0000-0000-0000333DE31B
Message-Id: <20200108083827.6644642041@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001080074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/3/20 2:31 AM, Mike Marshall wrote:
> Ritesh -
> 
> I just loaded your patch on top of 5.5-rc4 and it looks fine to me
> and xfstests :-) ... I pointed ftrace at the orangefs function you
> modified while xfstests was running, and it got called about a
> jillion times...

Thanks Mike for testing this. Shall I add your Tested-by?

-ritesh


> 
> -Mike
> 
> On Wed, Jan 1, 2020 at 5:53 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>>
>> Al, any comments?
>> Resending this after adding Reviewed-by/Acked-by tags.
>>
>>
>>  From previous version:-
>> Matthew Wilcox in [1] suggested that it will be a good idea
>> to define some missing API instead of directly using i_rwsem in
>> filesystems drivers for lock/unlock/downgrade purposes.
>>
>> This patch does that work. No functionality change in this patch.
>>
>> After this there are only lockdep class of APIs at certain places
>> in filesystems which are directly using i_rwsem and second is XFS,
>> but it seems to be anyway defining it's own xfs_ilock/iunlock set
>> of APIs and 'iolock' naming convention for this lock.
>>
>> [1]: https://www.spinics.net/lists/linux-ext4/msg68689.html
>>
>> Ritesh Harjani (1):
>>    fs: Use inode_lock/unlock class of provided APIs in filesystems
>>
>>   fs/btrfs/delayed-inode.c |  2 +-
>>   fs/btrfs/ioctl.c         |  4 ++--
>>   fs/ceph/io.c             | 24 ++++++++++++------------
>>   fs/nfs/io.c              | 24 ++++++++++++------------
>>   fs/orangefs/file.c       |  4 ++--
>>   fs/overlayfs/readdir.c   |  2 +-
>>   fs/readdir.c             |  4 ++--
>>   include/linux/fs.h       | 21 +++++++++++++++++++++
>>   8 files changed, 53 insertions(+), 32 deletions(-)
>>
>> --
>> 2.21.0
>>

