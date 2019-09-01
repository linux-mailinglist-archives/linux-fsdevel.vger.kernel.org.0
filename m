Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA66A46FB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 05:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfIAD0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 23:26:14 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com ([77.238.179.146]:33473
        "EHLO sonic304-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728589AbfIAD0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567308371; bh=3X2f9zs5GoXqXZm5o2SXF6TFWr2jmxRBZChGynN2BZc=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=GTycHylHBAXMTQpnu4dWFdjA0ut9ctneGRmHJ1FPniUgZQ59vE9dKJlFKkjUkfda42wrD3nmkx0pLGuQzw4bMna87Nni8h5FnHu1/Ckr+u/ySjKb7rLDapaUCxTjtfhI0yYuqLe8rEdwJyAbi699Ud3M2WqyTf/EpinnUmMoLLv4f27FrD9XrG5eGV0lyV5GxhnpOBfBJ7I5r1ccYDm1dZ5NWcICr1hMm+cYP3QwhIc6BBymn7mRjKa8y5CueiBRL8kw16ubbfTyYfHesN709RxuFO/k8kEWqkIs02zWSDnWfC24N6oXmdhK/ImPw4lKfjdfik+rdF3xchn6LABe0w==
X-YMail-OSG: GTeh2YMVM1n5yD.ak5OmbVFFHnlwMILK6igcPhx1U_Eo0A_T5HSPqcOOTIF.81e
 IhgktODjKH.fA8S5yBMfL_.GLUSGVLzlhLgSKzZg1qShGjRUGZSDJCwCn7szoQBilGvGXc7LcHxb
 GAldLG.h942mu4tow44xfNHdBM7xkZXlVItcrF.CbUlmyw0.NNjnlCSRSg5Ygqzv0o5z20EnxLsY
 l00.xyJRJMoKYKkUKM6ttYzYYgeUQPXGHroFqDi_2XJrJVvXoYwNB6SUWWtdsDojBNXxrzlrGWwn
 32YIEOWPFZflUG2q7aNwAixjwn0RB4P0iKKv3ZbuehQMe25Ap2toLDaHxRGXY249RZePMEzub7hf
 Uh6W5DKFZv2pfXJyvAZ.eqUi4F4_uGvsauTEvFFlby.L63N9vR6HsuuT7EqBBwu_OP0OT.drMW8R
 _.0DlicJ44mYbgrmvyqYADl1Nf4qRlnnontrcB_zzm2nMt.G2kyghN7UY7Tjy3F3un8bSCG72uSW
 4ZBzY4uQ1dgcVfIWGONzy9FYmo9lXdGCxO36X0TmD1VfUzlmGWi0VWQk63YsmQbq56Qr9pfYhYYS
 9B.VMJVj9hnAkbAQLKmg825kRXbp70gXq1yS96h7a27jP_Dpxi_EfQqF0GLXidFFKgpgx5pBAJAy
 qwd1IkpewHC88EWqZwQo0Q5nr.bG4xah1SQnB__Z7KNKZhxgVWsrzoxpl8lM4LghvTKWtCXLVbod
 xYl2sXQ82v0DGF1kgYxCDhFkRdTECPi2TSS.qp2NgZ43G3O5vUKA0h27SyXR6NEBrtlUlZZvnYeE
 5d3NlvG9xgNscloeAxiRye7dVNuzprZtEaNuOjLzJM_CDvt3Zpue4TAsKDhlVP.sP5BH1xTQJNMA
 7kt7gcEDhRO8DaFEGiFDityueupedSIHFcN__koDZvYGTGWLxksHI8RGimIRK7Pl.LMbesQGM56P
 0xYXKYiqLikluaQf9CDQVIBb8d_zZC_3oTBrOApVmJAWetB7grk5tX9VG8Dc8FPZ2ec.AbVt.QC_
 WBLPvMb0JTs5zm0Ve5f42_ll0xF0z0rDoLv7n7oP0YYIKYjKLc94ruLCeLxYNGLKP5t70PZdyQIT
 r4xz3C8zyNCq3dtTLqZ.hmXkdta5adiUKAtBN5Cmkwb3htpQLVnA3irCQNasSpP8zqK6iDCN7dO3
 cq1lBf1xOm6hJmVxHOrm6JHfn_BbnwIwbV2.2Q_m1s0KyIJ2ibO7yxzwbgiLieRFVUunk7N855Yf
 E5kgsXeeZQ4weDYC5v5XuzGtXJL_1iA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Sep 2019 03:26:11 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8e7cd5b2d147bd51f8bfb889d9d01e6d;
          Sun, 01 Sep 2019 03:26:10 +0000 (UTC)
Date:   Sun, 1 Sep 2019 11:26:02 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190901032556.GA10186@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
 <20190901013715.GA8243@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190901030514.GC1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901030514.GC1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Sun, Sep 01, 2019 at 04:05:14AM +0100, Al Viro wrote:
> On Sun, Sep 01, 2019 at 09:37:19AM +0800, Gao Xiang wrote:
> 
> > fs/orangefs/file.c
> >  19 static int flush_racache(struct inode *inode)
> 
> Just why the hell would _that_ one be a problem?  It's static in
> file; it can't pollute the namespace even if linked into the
> kernel.
> 
> Folks, let's keep at least some degree of sanity - this is sinking
> to the level of certain killfile denizens...

Thanks for your kind reply. I think in the same way.
And Christoph did many great suggestions for erofs, thanks him
for erofs, and I'm already fixed most of them, and some
suggestions I have no idea to do....
  1) add "erofs_" to all functions [1] [2];
  2) avoid sb_bread and use read_mapping_page, actually
      read_mapping_page will call block_read_full_page and
      buffer_heads still there;

and I don't know what erofs "rapidly turning" means, all great
suggestions I can fix them all, I have no idea it's a bad thing.

[1] https://lore.kernel.org/linux-fsdevel/20190830163910.GB29603@infradead.org/
[2] https://lore.kernel.org/linux-fsdevel/20190831064853.GA162401@architecture4/

Thanks,
Gao Xiang

