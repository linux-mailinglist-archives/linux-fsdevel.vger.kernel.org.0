Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0517469C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfGOUOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 16:14:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730916AbfGOUOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:14:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FKBtQT119765
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 16:14:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trxmdc9g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 16:14:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 15 Jul 2019 21:14:32 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 21:14:26 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FKEPpM48955724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 20:14:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 658A7AC065;
        Mon, 15 Jul 2019 20:14:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA00AC05B;
        Mon, 15 Jul 2019 20:14:13 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.238.93])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 20:14:13 +0000 (GMT)
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com> <87tvbqgboc.fsf@morokweng.localdomain> <20190715160317.7e3dfb33.pasic@linux.ibm.com> <20190715143039.GA6892@lst.de>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Lendacky\, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <20190715143039.GA6892@lst.de>
Date:   Mon, 15 Jul 2019 17:14:04 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071520-0072-0000-0000-00000449377D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011434; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01232669; UDB=6.00649450; IPR=6.01013970;
 MB=3.00027729; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-15 20:14:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071520-0073-0000-0000-00004CB9812D
Message-Id: <875zo3njhv.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150231
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph Hellwig <hch@lst.de> writes:

> On Mon, Jul 15, 2019 at 04:03:17PM +0200, Halil Pasic wrote:
>> > I thought about that but couldn't put my finger on a general concept.
>> > Is it "guest with memory inaccessible to the host"?
>> >
>>
>> Well, force_dma_unencrypted() is a much better name thatn sev_active():
>> s390 has no AMD SEV, that is sure, but for virtio to work we do need to
>> make our dma accessible to the hypervisor. Yes, your "guest with memory
>> inaccessible to the host" shows into the right direction IMHO.
>> Unfortunately I don't have too many cycles to spend on this right now.
>
> In x86 it means that we need to remove dma encryption using
> set_memory_decrypted before using it for DMA purposes.  In the SEV
> case that seems to be so that the hypervisor can access it, in the SME
> case that Tom just fixes it is because there is an encrypted bit set
> in the physical address, and if the device doesn't support a large
> enough DMA address the direct mapping code has to encrypt the pages
> used for the contigous allocation.
>
>> Being on cc for your patch made me realize that things got broken on
>> s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
>> to benefit from your cleanups. I think with your cleanups and that patch
>> of mine both sev_active() and sme_active() can be removed. Feel free to
>> do so. If not, I can attend to it as well.
>
> Yes, I think with the dma-mapping fix and this series sme_active and
> sev_active should be gone from common code.  We should also be able
> to remove the exports x86 has for them.
>
> I'll wait a few days and will then feed the dma-mapping fix to Linus,
> it might make sense to either rebase Thiagos series on top of the
> dma-mapping for-next branch, or wait a few days before reposting.

I'll rebase on top of dma-mapping/for-next and do the break up of patch
2 that you mentioned as well.

--
Thiago Jung Bauermann
IBM Linux Technology Center

