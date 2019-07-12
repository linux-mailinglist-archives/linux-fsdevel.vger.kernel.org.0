Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEC67654
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGLV4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 17:56:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfGLV4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:56:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CLqfpX016894
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 17:56:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq0fw4nwq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 17:56:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 12 Jul 2019 22:56:02 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 22:55:57 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CLtupx10814168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 21:55:56 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95FB3AE062;
        Fri, 12 Jul 2019 21:55:56 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0522EAE05F;
        Fri, 12 Jul 2019 21:55:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.135.203])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 12 Jul 2019 21:55:51 +0000 (GMT)
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Lendacky\, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <20190712150912.3097215e.pasic@linux.ibm.com>
Date:   Fri, 12 Jul 2019 18:55:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071221-2213-0000-0000-000003ADCDAE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011417; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231280; UDB=6.00648610; IPR=6.01012564;
 MB=3.00027695; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 21:56:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071221-2214-0000-0000-00005F35B676
Message-Id: <87tvbqgboc.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120224
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


[ Cc'ing Tom Lendacky which I forgot to do earlier. Sorry about that. ]

Hello Halil,

Thanks for the quick review.

Halil Pasic <pasic@linux.ibm.com> writes:

> On Fri, 12 Jul 2019 02:36:31 -0300
> Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>
>> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
>> appear in generic kernel code because it forces non-x86 architectures to
>> define the sev_active() function, which doesn't make a lot of sense.
>
> sev_active() might be just bad (too specific) name for a general
> concept. s390 code defines it drives the right behavior in
> kernel/dma/direct.c (which uses it).

I thought about that but couldn't put my finger on a general concept.
Is it "guest with memory inaccessible to the host"?

Since your proposed definiton for force_dma_unencrypted() is simply to
make it equivalent to sev_active(), I thought it was more
straightforward to make each arch define force_dma_unencrypted()
directly.

Also, does sev_active() drive the right behavior for s390 in
elfcorehdr_read() as well?

>> To solve this problem, add an x86 elfcorehdr_read() function to override
>> the generic weak implementation. To do that, it's necessary to make
>> read_from_oldmem() public so that it can be used outside of vmcore.c.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/x86/kernel/crash_dump_64.c |  5 +++++
>>  fs/proc/vmcore.c                |  8 ++++----
>>  include/linux/crash_dump.h      | 14 ++++++++++++++
>>  include/linux/mem_encrypt.h     |  1 -
>>  4 files changed, 23 insertions(+), 5 deletions(-)
>
> Does not seem to apply to today's or yesterdays master.

It assumes the presence of the two patches I mentioned in the cover
letter. Only one of them is in master.

I hadn't realized the s390 virtio patches were on their way to upstream.
I was keeping an eye on the email thread but didn't see they were picked
up in the s390 pull request. I'll add a new patch to this series making
the corresponding changes to s390's <asm/mem_encrypt.h> as well.

--
Thiago Jung Bauermann
IBM Linux Technology Center

