Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB06CE6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGRNBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 09:01:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbfGRNBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:01:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ICvhC9108417
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 09:01:34 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttqje4k14-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 09:01:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 14:01:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 14:01:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ID1O1I46399696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 13:01:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CC511C04C;
        Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B18911C04A;
        Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.219])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Date:   Thu, 18 Jul 2019 15:01:23 +0200
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
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-Reply-To: <20190718084456.GE24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
        <20190718032858.28744-7-bauerman@linux.ibm.com>
        <20190718084456.GE24562@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071813-0028-0000-0000-00000385B410
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071813-0029-0000-0000-00002445DDD0
Message-Id: <20190718150123.4230a00c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Jul 2019 10:44:56 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > -/* are we a protected virtualization guest? */
> > -bool sev_active(void)
> > -{
> > -	return is_prot_virt_guest();
> > -}
> > -
> >  bool force_dma_unencrypted(struct device *dev)
> >  {
> > -	return sev_active();
> > +	return is_prot_virt_guest();
> >  }
> 
> Do we want to keep the comment for force_dma_unencrypted?

Yes we do. With the comment transferred:

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

