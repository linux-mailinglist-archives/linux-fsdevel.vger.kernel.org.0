Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28FE986F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfHUWDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 18:03:13 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com ([77.238.178.146]:33321
        "EHLO sonic308-18.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbfHUWDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566424991; bh=as+yRgvr59Q4Mb1Ow5BUWgU6I3h8mr1OBmVUpM5VRtE=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=Zl4j/lISQARmPg+8JlHaIzDCuSFsNdiFqs4Pk0IFt6sBVxbfh+A1e0DvUaPJRGC8OMY5WGuCe98D921R9tKIdWWXshTtTFMgYUWDVOF5Y2lH618rg1jJ9R+1LX50imsoMzSO0HXN1wQQTTKn2963AtNZG1Y5py64MSPHp1gaDMhhBuCAr522h9ud/YsSVfeVfYbwVMbg+sOjIqf7nNrx/5NxTEr7MdwC4Yy4WFANZ/SEagd1xJMQLHz0SEOVG5L89q7fxKHZnL1zLc+7GOmAvqGQcAkXSVyNrpjThvhXpQIp0mgRG2zOujcV2mFGvS6xVQgXnMcYdLYcWqfNK29o+Q==
X-YMail-OSG: A.ECbDoVM1mH2SvniMQ8WTJAGNX41Ss04dcKYTDXD_NYt1M9pMP1QbuMG_TIxMA
 9UM9lQ.0F.BcV7NktkePrIPlYxoCxMLKUrnW_q4RqrVsULq5pQDvdpDy5W6JJpsjY4N3nuc6vX6J
 vg.PArYIC2udo_E7QOUfnZidKsEYhje4ZUVOQ_LwZjf1nqsdbEXUdUDqAeHz4S99A09JZ1MB02vH
 Pj5leyWB6lQ_OatmIAcdq4Tn6shv0ynP3SFBHBlua8wxB7SF2xsEoVOZo4hNdp2naQpQxNKUU1kC
 PJSkErf6laINDlQBxlPQQ7AUTOzSRm_1mCTiGEQe4LAZFhyohsJ4M2sQ8S596MwJsaD4WqOFB7EB
 MUZFDoATAUDBN.UlMeSk5SUrYesnyb6a7RMOUaghjJmhaCfHGqLabVVhbYrVWHNtGoPrTGzguKkg
 ap7WdvQLdNQxHsxPnkisKXhNwZhZ5WdDVOohitrkueCgGGjrv1Lr9VpxwsMl9jvx_NiVlx9PPErH
 NyKfAHp4QH_FSMMI6oNgB0bVlpC1gU..aoEKxUp2suiX.PskpVUItKpelvWAOQv6qe9RgDMauFgb
 ujAgegAyAlJjsr0yu9nmT6tva7C5lCvV4r6hS8Z64vKEJfgtLmfxKqw529bbrFm5DAXajpA.7IjX
 cmpxxpPD5ta62B2DQryxlulpOjuQVmko5_db8j3HrChaUT1UlV_8UgKfiHqFYLTgJskd7CRaBDmZ
 ulT0yiLDILnb55D_HUswlfHyXj3F_J_gpQVE92x80jKxu_iotv1XJcL19daxU2z.PKTO1VuAkLvc
 S3Pz_PVzNwWt_Jqlzx2cF9GpuqnrJcXujVSItmyU3X0YRdbvoAqwRCmiagTzTpGppDiVDqs4LFpC
 yGPMisnOnIrjHmODjJfQgRcZXyVDHUMmlumd9HSk9JbNR0rAGFzBwANV56DerpbSLkOvSGRMmZcu
 .wkQNNlbddSSut6_vM48tce6hKu4HJFlV.syvJw6YzDCJw4FXmSFeMZW0EgoYwVH_Lf1231zOoW9
 0ZSwxynFBLXRC6bpRydQ.C66DfDJDAgQIho3In_zo7qmEGcy0q5ofxu_jFBMgEUlpczwPiq1Sjdt
 38ci8aJxoHg6dwWlTTcFC2zimn79lN_4uCQJ6ml6RYFTKH256PCO0Q2E5QAU8DPIUeSbfF_J.w9y
 iCEfgfZlZrRymhxE1jRAFrLbpEq_7UdZ2lm7qdVPJAnrGoKFyg5P_NCUOw2DXiHy897xyd4fZQ1E
 3ajWf8suHEE6IkyEEm13nhbe8qjlIcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 22:03:11 +0000
Received: by smtp432.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 148febfba35ac7974540a5f89d49d2fa;
          Wed, 21 Aug 2019 22:03:10 +0000 (UTC)
Date:   Thu, 22 Aug 2019 06:03:03 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On Wed, Aug 21, 2019 at 11:37:30PM +0200, Richard Weinberger wrote:
> Gao Xiang,
> 
> On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
> <linux-erofs@lists.ozlabs.org> wrote:
> > > struct erofs_super_block has "checksum" and "features" fields,
> > > but they are not used in the source.
> > > What is the plan for these?
> >
> > Yes, both will be used laterly (features is used for compatible
> > features, we already have some incompatible features in 5.3).
> 
> Good. :-)
> I suggest to check the fields being 0 right now.
> Otherwise you are in danger that they get burned if an mkfs.erofs does not
> initialize the fields.

Sorry... I cannot get the point...

super block chksum could be a compatible feature right? which means
new kernel can support it (maybe we can add a warning if such image
doesn't have a chksum then when mounting) but old kernel doesn't
care it.

Or maybe you mean these reserved fields? I have no idea all other
filesystems check these fields to 0 or not... But I think it should
be used with some other flag is set rather than directly use, right?

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> //richard
