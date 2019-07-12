Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99B6671AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGLOwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 10:52:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbfGLOwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:52:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CEorJY087029
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 10:52:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpu39ksh2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 10:52:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 12 Jul 2019 15:52:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 15:51:57 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CEptPa46399566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 14:51:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72848A4062;
        Fri, 12 Jul 2019 14:51:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3367A405C;
        Fri, 12 Jul 2019 14:51:54 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 14:51:54 +0000 (GMT)
Date:   Fri, 12 Jul 2019 16:51:53 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org,
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
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
In-Reply-To: <20190712140812.GA29628@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
        <20190712053631.9814-4-bauerman@linux.ibm.com>
        <20190712150912.3097215e.pasic@linux.ibm.com>
        <20190712140812.GA29628@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071214-4275-0000-0000-0000034C810B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071214-4276-0000-0000-0000385C8C00
Message-Id: <20190712165153.78d49095.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120161
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Jul 2019 16:08:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jul 12, 2019 at 03:09:12PM +0200, Halil Pasic wrote:
> > This is the implementation for the guys that don't
> > have ARCH_HAS_MEM_ENCRYPT.
> > 
> > Means sev_active() may not be used in such code after this
> > patch. What about 
> > 
> > static inline bool force_dma_unencrypted(void)
> > {
> >         return sev_active();
> > }
> > 
> > in kernel/dma/direct.c?
> 
> FYI, I have this pending in the dma-mapping tree:
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/e67a5ed1f86f4370991c601f2fcad9ebf9e1eebb

Thank you very much! I will have another look, but it seems to me,
without further measures taken, this would break protected virtualization
support on s390. The effect of the che for s390 is that
force_dma_unencrypted() will always return false instead calling into
the platform code like it did before the patch, right?

Should I send a  Fixes: e67a5ed1f86f "dma-direct: Force unencrypted DMA
under SME for certain DMA masks" (Tom Lendacky, 2019-07-10) patch that
rectifies things for s390 or how do we want handle this?

Regards,
Halil

