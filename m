Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288CF1B8248
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 00:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDXW7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 18:59:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgDXW7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:59:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OMcR9B037035;
        Fri, 24 Apr 2020 18:54:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30kpq4tdb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 18:54:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03OMjp95017314;
        Fri, 24 Apr 2020 22:54:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 30fs65hjqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 22:54:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03OMrJBv63046068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 22:53:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51CA64C046;
        Fri, 24 Apr 2020 22:54:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6521D4C040;
        Fri, 24 Apr 2020 22:54:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.185.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Apr 2020 22:54:25 +0000 (GMT)
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 25 Apr 2020 04:24:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200424191739.GA217280@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_13:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240169
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/25/20 12:47 AM, Eric Biggers wrote:
> On Fri, Apr 24, 2020 at 12:52:17PM +0530, Ritesh Harjani wrote:
>> We better warn the fibmap user and not return a truncated and therefore
>> an incorrect block map address if the bmap() returned block address
>> is greater than INT_MAX (since user supplied integer pointer).
>>
>> It's better to WARN all user of ioctl_fibmap() and return a proper error
>> code rather than silently letting a FS corruption happen if the user tries
>> to fiddle around with the returned block map address.
>>
>> We fix this by returning an error code of -ERANGE and returning 0 as the
>> block mapping address in case if it is > INT_MAX.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ioctl.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index f1d93263186c..3489f3a12c1d 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -71,6 +71,11 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>>   	block = ur_block;
>>   	error = bmap(inode, &block);
>>   
>> +	if (block > INT_MAX) {
>> +		error = -ERANGE;
>> +		WARN(1, "would truncate fibmap result\n");
>> +	}
>> +
> 
> WARN() is only for kernel bugs.  This case would be a userspace bug, not a
> kernel bug, right?  If so, it should use pr_warn(), not WARN().

Ok, I see.
Let me replace WARN() with below pr_warn() line then. If no objections,
then will send this in a v2 with both patches combined as Darrick
suggested. - (with Reviewed-by tags of Jan & Christoph).

pr_warn("fibmap: this would truncate fibmap result\n");


> 
> - Eric
> 
