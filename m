Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517755F3F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiF2DTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiF2DTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:19:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA136159;
        Tue, 28 Jun 2022 20:18:55 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T3DafE008652;
        Wed, 29 Jun 2022 03:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=od5MFZxEfwYEj4PLpFvbO/tj5BemYL4/bN3mvOWbo6w=;
 b=UmhUuvxQTsvGGNhNYpPwaqdbIQKOxF66FOaMdt6tVv6h6Z568SuPDVA6iwSY3fgCsW5q
 kKiWkNQ6tM+gWa5vWxF0OPksCFZG5f1uwewm4HFAOfsb3SohuGlkUkVBXCcBRpG2XAYX
 C0sDawltvSmPtMdDnRitw7argrr0sR1DPSms3aCJmFtQxRsNeGwJOGmpM0xMrHH5DyfW
 yw79435oOR+O9bOECBovaCykKoxtmhNYbxlboh2ZiuJW3thDrOFu7BTjCOFw7BbM2lQN
 zJt4HzdwVgKkzndzsyzxo6n4TyldfYoE2dOACtioQGzAptc2CXNKOOvI6NWORrVN45OJ BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0en282wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 03:18:41 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25T3Er48015431;
        Wed, 29 Jun 2022 03:18:40 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0en282wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 03:18:40 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25T2p6Eg023703;
        Wed, 29 Jun 2022 03:18:39 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3gwt09cb0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 03:18:39 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25T3IcRa11600306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 03:18:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DBEAC059;
        Wed, 29 Jun 2022 03:18:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDFAAC05B;
        Wed, 29 Jun 2022 03:18:35 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.163.2.135])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jun 2022 03:18:35 +0000 (GMT)
Message-ID: <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From:   Eric Farman <farman@linux.ibm.com>
To:     Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Date:   Tue, 28 Jun 2022 23:18:34 -0400
In-Reply-To: <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
         <20220610195830.3574005-12-kbusch@fb.com>
         <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
         <YrS2HLsYOe7vnbPG@kbusch-mbp> <YrS6/chZXbHsrAS8@kbusch-mbp>
         <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
         <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
         <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
         <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
         <20220628110024.01fcf84f.pasic@linux.ibm.com>
         <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nDBxkpzP375Uv3nW7kdxyuRz0REl5oyg
X-Proofpoint-GUID: HQTmH9Dzn0xZt9_WfWNXAAmKQGrbWDd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290010
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-06-28 at 11:20 -0400, Eric Farman wrote:
> On Tue, 2022-06-28 at 11:00 +0200, Halil Pasic wrote:
> > On Mon, 27 Jun 2022 09:36:56 -0600
> > Keith Busch <kbusch@kernel.org> wrote:
> > 
> > > On Mon, Jun 27, 2022 at 11:21:20AM -0400, Eric Farman wrote:
> > > > Apologies, it took me an extra day to get back to this, but it
> > > > is
> > > > indeed this pass through that's causing our boot failures. I
> > > > note
> > > > that
> > > > the old code (in iomap_dio_bio_iter), did:
> > > > 
> > > >         if ((pos | length | align) & ((1 << blkbits) - 1))
> > > >                 return -EINVAL;
> > > > 
> > > > With blkbits equal to 12, the resulting mask was 0x0fff against
> > > > an
> > > > align value (from iov_iter_alignment) of x200 kicks us out.
> > > > 
> > > > The new code (in iov_iter_aligned_iovec), meanwhile, compares
> > > > this:
> > > > 
> > > >                 if ((unsigned long)(i->iov[k].iov_base + skip)
> > > > &
> > > > addr_mask)
> > > >                         return false;
> > > > 
> > > > iov_base (and the output of the old iov_iter_aligned_iovec()
> > > > routine)
> > > > is x200, but since addr_mask is x1ff this check provides a
> > > > different
> > > > response than it used to.
> > > > 
> > > > To check this, I changed the comparator to len_mask (almost
> > > > certainly
> > > > not the right answer since addr_mask is then unused, but it was
> > > > good
> > > > for a quick test), and our PV guests are able to boot again
> > > > with
> > > > -next
> > > > running in the host.  
> > > 
> > > This raises more questions for me. It sounds like your process
> > > used
> > > to get an
> > > EINVAL error, and it wants to continue getting an EINVAL error
> > > instead of
> > > letting the direct-io request proceed. Is that correct? 

Sort of. In the working case, I see a set of iovecs come through with
different counts:

base	count
0000	0001
0000	0200
0000	0400
0000	0800
0000	1000
0001	1000
0200	1000 << Change occurs here
0400	1000
0800	1000
1000	1000

EINVAL was being returned for any of these iovecs except the page-
aligned ones. Once the x200 request returns 0, the remainder of the
above list was skipped and the requests continue elsewhere on the file.

Still not sure how our request is getting us into this process. We're
simply asking to read a single block, but that's somewhere within an
image file.

> > 
> > Is my understanding as well. But I'm not familiar enough with the
> > code to
> > tell where and how that -EINVAL gets handled.
> > 
> > BTW let me just point out that the bounce buffering via swiotlb
> > needed
> > for PV is not unlikely to mess up the alignment of things. But I'm
> > not
> > sure if that is relevant here.

It's true that PV guests were the first to trip over this, but I've
since been able to reproduce this with a normal guest. So long as the
image file is connected with cache.direct=true, it's unbootable. That
should absolve the swiotlb bits from being at fault here.

> > 
> > Regards,
> > Halil
> > 
> > > If so, could you
> > > provide more details on what issue occurs with dispatching this
> > > request?
> 
> This error occurs reading the initial boot record for a guest,
> stating
> QEMU was unable to read block zero from the device. The code that
> complains doesn't appear to have anything that says "oh, got EINVAL,
> try it this other way" but I haven't chased down if/where something
> in
> between is expecting that and handling it in some unique way. I
> -think-
>  I have an easier reproducer now, so maybe I'd be able to get a
> better
> answer to this question.
> 
> > > If you really need to restrict address' alignment to the
> > > storage's
> > > logical
> > > block size, I think your storage driver needs to set the
> > > dma_alignment queue
> > > limit to that value.
> 
> It's possible that there's a problem in the virtio stack here, but
> the
> failing configuration is a qcow image on the host rootfs

(on an ext4 filesystem)

> , so it's not
> using any distinct driver. The bdev request queue that ends up being
> used is the same allocated out of blk_alloc_queue, so changing
> dma_alignment there wouldn't work.

