Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4B915A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHRIpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 04:45:43 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147]:33062
        "EHLO sonic301-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbfHRIpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566117941; bh=U8+VQlxBUgWnoM/I+xVbuaXKkxs6yTI0ZywaCHT91wQ=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=M0TR0d7fH7+wgv0LnSYGhuOrHKfGjOQx7n0R4fEY11sADUXzesRYRc1+u04CmYyqu2WRlDqMabmeIN6DEya0vTLed49IrZipUJOLDjcFQkKumlSYlQCy4di5I5QPoVwY8b5S+TWwNoVvRLcwL8DRf3ZJd0uyBMxyqXViQxqSVcxITem8VC40KTaus5zhR8CFh0H2zEbsz0EwVG7OCQv6ks6B9qoTD6KSYlcfTSditi2X7aSRQM7oWcrTqrg33rafcsU3+QLqMA3tDOoTnthmWGvdJQitWJ78uF6JnNpQJYHO5n8V20Gdpcf+TJQQsy2NXXsiccFhxcmFkt6LJpRzqA==
X-YMail-OSG: efZZ9FMVM1m.GtSPoalf4IvRpF36iTHGi2hNN9ZzEPgu2Sbkj8JraAameZUvrB0
 Tm9Pk8KD1sfUYzw5gJm6.l8Us6mkfVj35P9F52n3cIUdf3LJy1dryt_c.wjgPfcQLiK3R0UZGd5N
 Ky1fuIQtznRkZuAhSxD5RoHjvsoVGBC0DRP2HrgZyXEAk0lZW8cQ9.UeCQXVlbHKH9UKZlhbOd9n
 sICgg6JVdTKKajIBATnYV.kfo1PXcl2elG2KEQ583VuQSNwejE2MKqoeVzzZaHQ7ml32trY6uif0
 wxN3CCWDScqq16CbvpytMG9KqUhEGqOBSmXazXkSNTtxwFLmQYErIbZKEz4FeQiDwstZbts57.W2
 PWou0BEWyo4e8oxdOvk17NdANU5_5OStvYGo1S4ufsUy4J92iM42mOLjbfUSGIG70gTufb8N1tkZ
 QsriuZemtEJafBIAhjEODJWEQlfDkDGOS0kFzoKYo5miy9Mgl9BDmRUSx9ozeSDIdoF46MDgadhB
 VxufLY76y5LbXXkT_2_rLrccNumA0hm.2KZW9r6LvhjnkJ0Mm5fDbjj_AxOkKy5zgVnMjK95eJIG
 3SSwFp6dPDY1l1EK_XMxX7ax4St7GhNPYjWKULao3VzFlafAEyPNsds4cZ.abCvb6GtGn7rPOjIX
 .2WhWMhThkchR3JnurCUSDX7wUpPp5j20LcRBhnNee_WwZKexA54E1hLJ5VIN292.rENsF_FK0VQ
 Vtn8SENNPHYeLn4HpG9CFUwBehTJN.VDU53F49EjyDxBA7.eqmhEVuu8.5zsrxTKOWin6cvesJuN
 2gNYJPbBDGyjO3uYd.b3aBWxqUXYq2xI4Bctn5Slef0JUyyjUpczjbfaF.UJRW0qdFzLFtXEFoyD
 p5ZOYtK5Og6uqsTVd_B.xpLK0J56uGv8ZAKeUntsTLH5SBFt2URMPbGoIQPLN.fztahf.s65AVcM
 BLN3Qrstum6sHHuBr4QjowVdbQJ7y0yHLxJVnTJEODm_olmIS6wJgNiGQ_nQmJLumRGNib3B3NqP
 hiG577EJlQomKG6S2WJ5FK1jN1tDwUPIGE9NFSbYyMp4M_PelQd1PxaaHYvUeLhOraSxUVfXSYyY
 6z72p8OjS.cgZVxZsDxkK8UG961df1uDTqeG6rIEsdo0CeRcReJQljOSHRZ_rm9zREWz5wKfLOws
 fA5wDsCBqNZnWkoPRp9Ah7xcMQxeP8bo2S9rLTVJBlkqvSjChaXLyi.A7FqlF9liXh1ObALSq_BY
 s5fpoZq2IYxLEGSg0bNkgbo3MebhHys7nTofo
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 08:45:41 +0000
Received: by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7f42aa3751c9ef91b2ab4c4b10094af7;
          Sun, 18 Aug 2019 08:45:41 +0000 (UTC)
Date:   Sun, 18 Aug 2019 16:45:25 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 10:16:50AM +0200, Richard Weinberger wrote:
> ----- Urspr?ngliche Mail -----
> >> While digging a little into the code I noticed that you have very few
> >> checks of the on-disk data.
> >> For example ->u.i_blkaddr. I gave it a try and created a
> >> malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
> >> to loop forever around erofs_read_raw_page().
> > 
> > I don't fuzz all the on-disk fields for EROFS, I will do later..
> > You can see many in-kernel filesystems are still hardening the related
> > stuff. Anyway, I will dig into this field you mentioned recently, but
> > I think it can be fixed easily later.
> 
> This is no excuse to redo all these bugs. :-)

I agree with you, but what can we do now is trying our best to fuzz
all the fields.

So, what is your opinion about EROFS?

> 
> I know that many in-kernel filesystems trust the disk ultimately, this is a
> problem and huge attack vector.

I EROFS already has many error handing paths to recover corrupted images,
and your discovery is a bug out of one error handing path miswritten by me.
I cannot make a guarantee that all the new things (every new kernel version
will introduce new feature / new code) are bug-free since I am not a machine
or code parser.

My answer about this EROFS will be more stable with our development, we have
a dedicated team with paid job, and since we currently use EROFS on the top of
dm-verity for current Android, which will keep us from corrupted images.
But yes, we will focus on fuzzing all the images for generic usages,
and we will backport all these patches to old stable versions.

Thanks,
Gao Xiang

> 
> Thanks,
> //richard
