Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ACD1EB4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 07:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFBFAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 01:00:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgFBFAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:00:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0524Vffr130354;
        Tue, 2 Jun 2020 01:00:34 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dfmkgqdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 01:00:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052504Aj013149;
        Tue, 2 Jun 2020 05:00:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47warj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 05:00:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05250Uag13631834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 05:00:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BAF1A407C;
        Tue,  2 Jun 2020 05:00:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA74CA407B;
        Tue,  2 Jun 2020 05:00:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.137])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 05:00:25 +0000 (GMT)
Subject: Re: [RFC 16/16] ext4: Add process name and pid in ext4_msg()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
 <3d99e1291b3bc8f2a78467d11b1a7a31393180fc.1589086800.git.riteshh@linux.ibm.com>
 <20200521182650.GC2946569@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 2 Jun 2020 10:30:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200521182650.GC2946569@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200602050025.CA74CA407B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_04:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 cotscore=-2147483648 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020023
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ted,

Sorry about the long delay. Had taken some time off and was tinkering 
around with another hobby project.

On 5/21/20 11:56 PM, Theodore Y. Ts'o wrote:
> On Sun, May 10, 2020 at 11:54:56AM +0530, Ritesh Harjani wrote:
>> This adds process name and pid for ext4_msg().
>> I found this to be useful. For e.g. below print gives more
>> info about process name and pid.
>>
>> [ 7671.131912]  [mount/12543] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr
> 
> I'm not entirely sure about adding the command/pid at the beginning of
> the message.  The way we do this in ext4_warning and ext4_err is to
> print that information like this:
> 
> 		printk(KERN_CRIT
> 		       "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
> 		       sb->s_id, function, line, current->comm, &vaf);
> 
> ... and I wonder if it would make more sense to add something like to
> ext4_msg(), just out of consistency's sake.  Which of the debugging
> messages were you finding this to be most helpful?

Well earlier ext4_mb_show_ac() was using ext4_msg() function.
But I changed that to use mb_debug() msg in patch-14 of this series,
since mb_debug() is meant for those debug msgs.
So I am completely ok if we think this patch is unnecessary, that's also
why I kept this patch at the end of the series to check opinion of
others.

FWIW, the mballoc issue which I was seeing was mostly due to a multi-
threaded application. And without name/pid of the process/threads, it
was difficult to identify which debug msgs belonged to which threads.
For this reason I thought such info in ext4_msg() would also help in
future.


Thanks for taking both patch series!
-ritesh
