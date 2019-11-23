Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBB107E43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfKWLvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Nov 2019 06:51:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbfKWLvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Nov 2019 06:51:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xANBpf3l092580
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2019 06:51:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf265tr11-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2019 06:51:54 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sat, 23 Nov 2019 11:51:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Nov 2019 11:51:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xANBpnYK58458236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Nov 2019 11:51:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A23F5204F;
        Sat, 23 Nov 2019 11:51:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.55.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BC07652050;
        Sat, 23 Nov 2019 11:51:47 +0000 (GMT)
Subject: Re: [RFCv3 2/4] ext4: Add ext4_ilock & ext4_iunlock API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-3-riteshh@linux.ibm.com>
 <20191120112339.GB30486@bobrowski>
 <20191120121831.9639B42047@d06av24.portsmouth.uk.ibm.com>
 <20191120163500.GT20752@bombadil.infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 23 Nov 2019 17:21:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191120163500.GT20752@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112311-0008-0000-0000-0000033682B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112311-0009-0000-0000-00004A55B2F5
Message-Id: <20191123115147.BC07652050@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_02:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=734
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911230098
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/20/19 10:05 PM, Matthew Wilcox wrote:
> On Wed, Nov 20, 2019 at 05:48:30PM +0530, Ritesh Harjani wrote:
>> Not against your suggestion here.
>> But in kernel I do see a preference towards object followed by a verb.
>> At least in vfs I see functions like inode_lock()/unlock().
>>
>> Plus I would not deny that this naming is also inspired from
>> xfs_ilock()/iunlock API names.
> 
> I see those names as being "classical Unix" heritage (eh, maybe SysV).
> 
>> hmm, it was increasing the name of the macro if I do it that way.
>> But that's ok. Is below macro name better?
>>
>> #define EXT4_INODE_IOLOCK_EXCL		(1 << 0)
>> #define EXT4_INODE_IOLOCK_SHARED	(1 << 1)
> 
> In particular, Linux tends to prefer read/write instead of
> shared/exclusive terminology.  rwlocks, rwsems, rcu_read_lock, seqlocks.
> shared/exclusive is used by file locks.  And XFS ;-)
> 
> I agree with Jan; just leave them opencoded.

Sure.

> 
> Probably worth adding inode_lock_downgrade() to fs.h instead of
> accessing i_rwsem directly.
> 

Yup, make sense. but since this series is independent of that change,
let me add that as a separate patch after this series.


Thanks for the review!!
-ritesh

