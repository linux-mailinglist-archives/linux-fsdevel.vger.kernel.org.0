Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435C1B9541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgD0DA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 23:00:29 -0400
Received: from sonic309-49.consmr.mail.ne1.yahoo.com ([66.163.184.175]:40718
        "EHLO sonic309-49.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbgD0DA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1587956427; bh=yMtBR0rm2a1xYW8LqyJyGdANirdUSCJfFg7gnN6WtO0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=i3WibM9NgUesbBthFewLOkZuDpFKqDGNjF18vk9spN975ysCcL/YzlvyNXPwbmuR2J2XiHp0kvnmrGqvu7+YAa+7bU6Ub3r81NR06ImhNIOmafctTbHJdZkIbkDOPyYMd2gAOgmJSdHzMZzH6h5S0XIoa8IDA8QL9RnoFZL0V9qAo6J642m9bLadTS5sQ/BpYM/oSSuhpHA5cBx8pjzyu4wMaoimSdN7mYow8GJq0eLX2tQlKdrPqGSDvGoy+2MGkwFRBJvBWrg2GK//tcp+VhHHUnJ0LWzLV0jTKpyYPQRr+YNxdc+q/8BLerOwqkHYRScjiQNjmmeEQxeBpnoMuw==
X-YMail-OSG: .gqvD30VM1n0mnRHSW5S0XixLLCBKdoDUGQVg0kmQjQN61NM7mSNUaVYh53fTrZ
 KUhm19yhEB1tWWLYrJCdknvFxJdpgEEAhYBzyzbdFQIY672s4vvG04I4cglbsGOMzyN8Lp__9RXO
 3IyG8907H768v2qQAc3rq6Ik5hweJ943UI7onfngOQyde1B._8ns5auyYyAQmGpWTgEROW004aHu
 7JjM6WnQTa4HOFh9Ihvp3cbHRoqBMmxddIn1R8MwCusPM_BjOWOIEiyiXHO9i6uQiD12OUk4etyF
 xj._CfP5S5YAlfwdCJlATx7SsGmq4uonpClqJCPIhPjiuSXSadKpe01H8Lmvd0ajfuSQLRkW6dgY
 khbcFCypSc1irFks7AkT0FCvMt3.lx1WgkN9u3qLUAVpExWZJPmtpobus878spudm9nFRue4eU0O
 Lsenp_qnXWzzNBwk9b2B1.4bNlZiUQTlWTFSRWqRdjAlrlBHvypyc7raQw8YJTlgbkiUG25bJAIr
 XKi2GUsmxZ.pMZa46USWIA8XoS8BIi6lrvoXSt.UcySagn0594nF9TR98nWqhsSJ0fvJBUkwdr1_
 6eE5j_w4TKIB5Y8BZ2ddqy.DAGWflIdDUsZTbHNtOmiN4CfofP8Z0VWvh8cxBtfecZunAnEu37fh
 lmQBF19erE8ltU2XGKtFXXadAEhjeAmWrs3pk2Y9neiFZZwj1_.T2lRTstcRn5Ylcrwlo46UZ1wj
 fGWqODJrJwQ8rfLm6n1Dn9Um1qDfj3Yfrdu1oeJjUox_eX8vR23sD4d1ScWA4XTTfAh844uMWLC8
 vBxnDEhHRcrp6Wf432Jv9r.l6DX4Unmd.RAoQ5UXWrqnAoKyoIsX9mpiuLMVqmE2A2r0PYGgU8fN
 oY_BvSkqfXC0w4yM8Da1ksUaQNnr6xxlsirgm9wSvw371O_Epx8r30iirfjSAdjkzH2O8R2Pr7XS
 _NBIZ9GHXaTInDjJcZOWxpaQ2Qs7b0._FlUc5g0PexGOg6Si3SWDKyHrNnsijQcgQ4xK6liJUBUK
 U1Oc2ofAHdxMWnNhKUfEv.tKu2t1EnNLlm.w4kO29pKYncfMVHRpvM.teaQ3AL15o.QaZEsDbx9o
 dOpfh3x6kUJ0_ht4RX7cVxOXOWkGjY_QUKsfz76QVLXJ4IfX3Ne5gYkm6tLYppJRvWImnEF6wJtn
 NxxHGJnAqmvUrCb8b41UnqAQeqSGoUHnT.QU65ibXGEq3Rzhg6ryYGFosa9_btbpwmrStpfOvQ5U
 MxV0lufRxqI6zAyk_PNJKzWzyjDvyB1ENhNIOJFRGmTUr6BrJhB6wQlDSopJI_cnDtiI3AZBp4eD
 zy10YvbLAhHwEFZry.gvbdCIW4_rCFHbvvImcy9mrNZUyZK1fGyJXkxSweGiDpuRwZUvNlkNsa5u
 FiU0AXSJkyOr7XsfZzKWWvhIBhQsN3bfUfMOpSG79fqnDuq5xcaawRMBaZOo2OCBkMKUbwh1HN_N
 WHa8v4PiPls5Pz2FAeNBj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2020 03:00:27 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e9d3497fa89bdec9eee2b7b512753607;
          Mon, 27 Apr 2020 02:58:10 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:58:02 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Message-ID: <20200427025752.GA3979@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426222455.GB2005@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
> On Sun, Apr 26, 2020 at 11:49:24PM +0200, Guoqing Jiang wrote:
> > Since the new pair function is introduced, we can call them to clean the
> > code in orangefs.
> > 
> > Cc: Mike Marshall <hubcap@omnibond.com>
> > Cc: Martin Brandenburg <martin@omnibond.com>
> > Cc: devel@lists.orangefs.org
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > ---
> >  fs/orangefs/inode.c | 24 ++++++------------------
> >  1 file changed, 6 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > index 12ae630fbed7..893099d36e20 100644
> > --- a/fs/orangefs/inode.c
> > +++ b/fs/orangefs/inode.c
> > @@ -64,9 +64,7 @@ static int orangefs_writepage_locked(struct page *page,
> >  	}
> >  	if (wr) {
> >  		kfree(wr);
> > -		set_page_private(page, 0);
> > -		ClearPagePrivate(page);
> > -		put_page(page);
> > +		clear_fs_page_private(page);
> 
> THis is a pre-existing potential use-after-free vector. The wr
> pointer held in the page->private needs to be cleared from the page
> before it is freed.

I'm not familar with orangefs. In my opinion, generally all temporary
page->private access (r/w) should be properly protected by some locks,
most of time I think it could be at least page lock since .migratepage,
.invalidatepage, .releasepage, .. (such paths) are already called with
page locked (honestly I'm interested in this topic, please correct me
if I'm wrong).

I agree that the suggested modification is more clear and easy to read.

Thanks,
Gao Xiang


