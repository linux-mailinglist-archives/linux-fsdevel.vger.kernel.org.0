Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66F76E82B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfGSPrU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 11:47:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727876AbfGSPrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:47:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JFkkmS088176
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 11:47:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tuf10w6nb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 11:47:19 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 19 Jul 2019 16:47:18 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 16:47:12 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6JFlBQD50725154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 15:47:11 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8EBAAE05C;
        Fri, 19 Jul 2019 15:47:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ABCAAE05F;
        Fri, 19 Jul 2019 15:47:07 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.190.209])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Jul 2019 15:47:07 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-6-bauerman@linux.ibm.com> <4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com> <c85ae8ff-3b7b-88bf-6b6a-c41b159c9cc2@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     lijiang <lijiang@redhat.com>
Cc:     "Lendacky\, Thomas" <Thomas.Lendacky@amd.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "iommu\@lists.linux-foundation.org" 
        <iommu@lists.linux-foundation.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390\@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <c85ae8ff-3b7b-88bf-6b6a-c41b159c9cc2@redhat.com>
Date:   Fri, 19 Jul 2019 12:47:03 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19071915-0072-0000-0000-0000044B1EEB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011457; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234458; UDB=6.00650541; IPR=6.01015790;
 MB=3.00027801; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-19 15:47:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071915-0073-0000-0000-00004CBB738B
Message-Id: <87h87igh6w.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190172
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Lianbo,

lijiang <lijiang@redhat.com> writes:

> 在 2019年07月19日 01:47, Lendacky, Thomas 写道:
>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
>>> appear in generic kernel code because it forces non-x86 architectures to
>>> define the sev_active() function, which doesn't make a lot of sense.
>>>
>>> To solve this problem, add an x86 elfcorehdr_read() function to override
>>> the generic weak implementation. To do that, it's necessary to make
>>> read_from_oldmem() public so that it can be used outside of vmcore.c.
>>>
>>> Also, remove the export for sev_active() since it's only used in files that
>>> won't be built as modules.
>>>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> 
>> Adding Lianbo and Baoquan, who recently worked on this, for their review.
>> 
>
> This change looks good to me.
>
> Reviewed-by: Lianbo Jiang <lijiang@redhat.com>

Thanks for your review!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

