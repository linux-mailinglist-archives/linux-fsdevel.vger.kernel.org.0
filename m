Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE26E826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfGSPqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 11:46:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728502AbfGSPqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:46:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JFhG2O005944
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 11:46:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tufc8maed-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 11:46:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 19 Jul 2019 16:46:01 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 16:45:57 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6JFjuRL50725240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 15:45:56 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12A23AC059;
        Fri, 19 Jul 2019 15:45:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF03DAC05B;
        Fri, 19 Jul 2019 15:45:52 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.190.209])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Jul 2019 15:45:52 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com> <87a7db3z68.fsf@morokweng.localdomain> <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     "Lendacky\, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "iommu\@lists.linux-foundation.org" 
        <iommu@lists.linux-foundation.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390\@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
In-reply-to: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
Date:   Fri, 19 Jul 2019 12:45:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071915-0052-0000-0000-000003E33307
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011457; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234458; UDB=6.00650541; IPR=6.01015790;
 MB=3.00027801; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-19 15:46:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071915-0053-0000-0000-000061C30B65
Message-Id: <87imrygh90.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190171
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 7/18/19 2:44 PM, Thiago Jung Bauermann wrote:
>> 
>> Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:
>> 
>>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>>> Hello,
>>>>
>>>> This version is mostly about splitting up patch 2/3 into three separate
>>>> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
>>>> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
>>>> Janani and removal of sme_active and sev_active symbol exports as suggested
>>>> by Christoph Hellwig.
>>>>
>>>> These patches are applied on top of today's dma-mapping/for-next.
>>>>
>>>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>>>> been build tested.
>>>
>>> I'll try and get this tested quickly to be sure everything works for SME
>>> and SEV.
>
> Built and tested both SME and SEV and everything appears to be working
> well (not extensive testing, but should be good enough).

Great news. Thanks for testing!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

