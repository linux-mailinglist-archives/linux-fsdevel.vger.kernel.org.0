Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8909E69BEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfGOUAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 16:00:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732449AbfGOUAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FJw7A7065731
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 16:00:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trxbe4g1w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 16:00:31 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 15 Jul 2019 21:00:30 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 21:00:24 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FK0N5m46334460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 20:00:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC61C112065;
        Mon, 15 Jul 2019 20:00:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DBEF112069;
        Mon, 15 Jul 2019 20:00:14 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.238.93])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 20:00:13 +0000 (GMT)
References: <20190713044554.28719-1-bauerman@linux.ibm.com> <20190713044554.28719-2-bauerman@linux.ibm.com> <3dc137a99c73b1b6582fc854844a417e@linux.vnet.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     janani@linux.ibm.com
Cc:     x86@kernel.org, linux-s390@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Linuxppc-dev 
        <linuxppc-dev-bounces+janani=linux.ibm.com@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
In-reply-to: <3dc137a99c73b1b6582fc854844a417e@linux.vnet.ibm.com>
Date:   Mon, 15 Jul 2019 17:00:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071520-0060-0000-0000-0000035EAD79
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011434; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01232664; UDB=6.00649448; IPR=6.01013966;
 MB=3.00027729; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-15 20:00:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071520-0061-0000-0000-00004A26C337
Message-Id: <877e8jnk5a.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150227
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Janani,

Thanks for reviewing the patch.

janani <janani@linux.ibm.com> writes:

> On 2019-07-12 23:45, Thiago Jung Bauermann wrote:
>> powerpc is also going to use this feature, so put it in a generic location.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  arch/Kconfig      | 3 +++
>>  arch/s390/Kconfig | 3 ---
>>  arch/x86/Kconfig  | 4 +---
>>  3 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index c47b328eada0..4ef3499d4480 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -927,6 +927,9 @@ config LOCK_EVENT_COUNTS
>>  	  the chance of application behavior change because of timing
>>  	  differences. The counts are reported via debugfs.
>>
>> +config ARCH_HAS_MEM_ENCRYPT
>> +	bool
>> +
>>  source "kernel/gcov/Kconfig"
>>
>>  source "scripts/gcc-plugins/Kconfig"
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 5d8570ed6cab..f820e631bf89 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -1,7 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -config ARCH_HAS_MEM_ENCRYPT
>> -        def_bool y
>> -
>
>  Since you are removing the "def_bool y" when ARCH_HAS_MEM_ENCRYPT is moved to
> arch/Kconfig, does the s390/Kconfig need "select ARCH_HAS_MEM_ENCRYPT" added
> like you do for x86/Kconfig?

Indeed, I missed that. Thanks for spotting it!

>
>  - Janani
>
>>  config MMU
>>  	def_bool y
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c9f331bb538b..5d3295f2df94 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -68,6 +68,7 @@ config X86
>>  	select ARCH_HAS_FORTIFY_SOURCE
>>  	select ARCH_HAS_GCOV_PROFILE_ALL
>>  	select ARCH_HAS_KCOV			if X86_64
>> +	select ARCH_HAS_MEM_ENCRYPT
>>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>  	select ARCH_HAS_PMEM_API		if X86_64
>>  	select ARCH_HAS_PTE_SPECIAL
>> @@ -1520,9 +1521,6 @@ config X86_CPA_STATISTICS
>>  	  helps to determine the effectiveness of preserving large and huge
>>  	  page mappings when mapping protections are changed.
>>
>> -config ARCH_HAS_MEM_ENCRYPT
>> -	def_bool y
>> -
>>  config AMD_MEM_ENCRYPT
>>  	bool "AMD Secure Memory Encryption (SME) support"
>>  	depends on X86_64 && CPU_SUP_AMD


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

