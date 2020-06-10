Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813B71F4B30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 04:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgFJCGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 22:06:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbgFJCGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:06:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A22RwB157293;
        Tue, 9 Jun 2020 22:06:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31j4unst99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 22:06:17 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A22f5j158369;
        Tue, 9 Jun 2020 22:06:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31j4unst8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 22:06:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A25MMP023550;
        Wed, 10 Jun 2020 02:06:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7xvcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 02:06:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A26Cq111338212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 02:06:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DEE611C04C;
        Wed, 10 Jun 2020 02:06:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB3211C066;
        Wed, 10 Jun 2020 02:06:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jun 2020 02:06:10 +0000 (GMT)
Subject: Re: [PATCHv2 1/1] ext4: mballoc: Use this_cpu_read instead of
 this_cpu_ptr
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
References: <20200609123716.16888-1-hdanton@sina.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 10 Jun 2020 07:36:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609123716.16888-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200610020610.AEB3211C066@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_14:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 cotscore=-2147483648 mlxlogscore=999 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/9/20 6:07 PM, Hillf Danton wrote:
> 
> On Tue, 9 Jun 2020 18:53:23 +0800 Ritesh Harjani wrote:
>>
>> Simplify reading a seq variable by directly using this_cpu_read API
>> instead of doing this_cpu_ptr and then dereferencing it.
> 
> Two of the quick questions
> 1) Why can blocks discarded in a ext4 FS help allocators in another?

I am not sure if I understand your Q correctly. But here is a brief 
about the patchset. If there were PA blocks just or about to be 
discarded by another thread, then the current thread who is doing block 
allocation should not fail with ENOSPC error instead should be able to 
allocate those blocks from another thread. The concept is better 
explained in the commit msgs, if more details are required.
Without this patchset (in some heavy multi-threaded use case) allocation 
was failing when the overall filesystem space available was more then 50%.

> 
> 2) Why is a percpu seqcount prefered over what <linux/seqlock.h>
> can offer?
> 

Since this could be a multi-threaded use case, per cpu variable helps in 
avoid cache line bouncing problem, which could happen when the same 
variable is updated by multiple threads on different cpus.

-ritesh
