Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE236D531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfGRTpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 15:45:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404101AbfGRTp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IJi7IK092753;
        Thu, 18 Jul 2019 15:44:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttxs8rye1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 15:44:58 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6IJinwF099302;
        Thu, 18 Jul 2019 15:44:57 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttxs8ryc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 15:44:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6IJhquN009613;
        Thu, 18 Jul 2019 19:44:56 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 2trtmrj0u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 19:44:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IJis3C60424544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 19:44:54 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B66BE056;
        Thu, 18 Jul 2019 19:44:54 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1210BE051;
        Thu, 18 Jul 2019 19:44:49 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 19:44:49 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
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
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
In-reply-to: <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
Date:   Thu, 18 Jul 2019 16:44:47 -0300
Message-ID: <87a7db3z68.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180202
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>> Hello,
>> 
>> This version is mostly about splitting up patch 2/3 into three separate
>> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
>> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
>> Janani and removal of sme_active and sev_active symbol exports as suggested
>> by Christoph Hellwig.
>> 
>> These patches are applied on top of today's dma-mapping/for-next.
>> 
>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>> been build tested.
>
> I'll try and get this tested quickly to be sure everything works for SME
> and SEV.

Thanks! And thanks for reviewing the patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
