Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920591B9571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 05:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD0D3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 23:29:18 -0400
Received: from sonic313-37.consmr.mail.ne1.yahoo.com ([66.163.185.60]:42020
        "EHLO sonic313-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgD0D3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1587958157; bh=fBhj+yMtSXhLRWwVoGYBEXNcTaurApay4phzJ8rOga8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=qQfAAzeTeLJ3Yjlhvo/0vE3rAX9JSumjgEWoG3c7Af/Jl+lGIa22xGhSUmIBP18mg3t063d43Ydkyg+lYayEBFOgZGJc388G9nPsancLCgXm/rZhA6X26uqgMAGQ7OsDWkwQcRFY0Zlk4S+t+TZiapMRfEYRCWM74IcAZjD3M5TNMNM7QqDkieUHSZkGETDE1ZuLqYXdseBWQl8zRIDpUa49ijiiv7m2xOe6xmI8gmjLrSr9FaU6NK/QWBNU927Z8yIwONGG48xMD9cucc1sDIGrh3H4zzIjL2GD5TpgRSLQajgP0Jd1Xc/ekB7lcHFCLHxCQfsGRBqFAsCrZWPskQ==
X-YMail-OSG: E245pgkVM1khELj54mMYuRRyAeClM1oHznCQbQIYKWcbwprhLWR9DWb4OaTuULS
 U_qAzhKFL8HQfqvVAaOtpMfKGQ7W.kfmnRlcceBNYB3MxfiQRbXCxpZzGmFEE6dyXadLOkB92i7r
 _QSWMxBcYE69qt14gsUnvOS_vjkk.jfS_wHllSMBao.btozjrAx6sdfcbLD6znrpM1Ebntu58iZC
 H4g1afdG40IWTLPI2rCUhma47dA2YNVKa6op0EQdxL9.muM9ugeNTScQfKCTTQo_At9u.IKTVhzS
 4B4tmYAShNonFWoOBJhqMaODxM_Gy04kTSVr0iW094AFDcxzQVOpamoCLwoMMUb7ftKHfGHWzXeQ
 tXKqL9iqSEBQBCD4Vr_V6XXQorxEXhqgay7Hi7ecScPPnYLPgmP8dVynZk2BLETTFGKqEiM5aqpt
 5OCHnDZwgdwFXMNrf6RYpKr4vwW2l0MhL9ZATdYQL9bcm6gWa__1xbqs0VK5ESvVAADXRay7PxSo
 1Jxfejg4Y8haorBuAWYNNR_oFLH0oxFT224GzWIWqj2WGQ_yOomjcG83oUUcaGJs4NsNDT.V8hx6
 h5w_SdHTdb1f1dINXKEloVYtaeR56CHfjemNaKwefF.rUNsXg4MT1GzpD3oia2NZvbPghi67ZJU9
 goIf2CmksUU1OlSp2mAIgR8m2CE85D8ZfpoliFJjB.qrEXB16cV0XIqC496SY3XB6ytb_BbK8fTj
 Y.yxY9I40LkFXpxng3fwJ37dINln1IDKSE1nuDaEvEgShfIEYGUPlqvko802bFUsoKsM5InyHOrV
 fGZMK7XLZ_4.IyQl6b1JV1XMA9qsXLQr9b9jBgFvlGUmowiuXZWKknXVeCvUvpxc_SOF7ItO6zPb
 ZUmyV3d8phYDqy_3tmjIZpyXO_phhRp59KVMRlOid6LRL.8B0BL5goeCb09jFMLU961BY44DfpWO
 0d0hYxiUD0jJEmcshFsL3r9qKKYyWJU_BYKZzSObktVrJ4NXbXRJuC2rcT1h9C1U3o5d53bEWqPD
 zaerVRrOWLHX5I2gZHsmBHDByeTrc_xp8.eKDt9.sKqLp2Bs1X_8my8pcY3P9ZqmT.djgVkdTClO
 5aeF1lhqTJ2NpfBgSqH61X5rncM_ShSr1s9I97g1gav.9lLlFXlXWKDLrS4r6V_PDo0ybreTrFUc
 ZUMRkjrTHNf.nRcqoxpWJOhiiqx8.BWaBKppUv4yDEfuccAP01ql8TJ0gAYrBhRraJaYL3hu6Ysj
 wkVgHjApfpAIkRLJ0CevDuJz6YtNrJNx597oUlhXMoJ_qJXlmcZ8P6mUq3APXfh4lxrMC9HSmON5
 OgLkrUXApyHEhQ_QKtJNawgBO68VsX0v9OXDDf5gQikIomEIORLdAmN0GE3x4.wTRuMD9AptMBIX
 2PSQmIUTqPdo1GdlBLLDQhJuT0dfjNzrucE.I4tzENUhXK1Q7KWEKxCq7p99yio2uM4lSbNoIW3i
 fqcNubWi6OW6I9w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2020 03:29:17 +0000
Received: by smtp407.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 34eeef3cf0e0df32ce64dc001080fa95;
          Mon, 27 Apr 2020 03:27:15 +0000 (UTC)
Date:   Mon, 27 Apr 2020 11:27:07 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Message-ID: <20200427032658.GA4754@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
 <20200427025752.GA3979@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427025752.GA3979@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:58:02AM +0800, Gao Xiang wrote:
> On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
> > On Sun, Apr 26, 2020 at 11:49:24PM +0200, Guoqing Jiang wrote:
> > > Since the new pair function is introduced, we can call them to clean the
> > > code in orangefs.
> > > 
> > > Cc: Mike Marshall <hubcap@omnibond.com>
> > > Cc: Martin Brandenburg <martin@omnibond.com>
> > > Cc: devel@lists.orangefs.org
> > > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > ---
> > >  fs/orangefs/inode.c | 24 ++++++------------------
> > >  1 file changed, 6 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > > index 12ae630fbed7..893099d36e20 100644
> > > --- a/fs/orangefs/inode.c
> > > +++ b/fs/orangefs/inode.c
> > > @@ -64,9 +64,7 @@ static int orangefs_writepage_locked(struct page *page,
> > >  	}
> > >  	if (wr) {
> > >  		kfree(wr);
> > > -		set_page_private(page, 0);
> > > -		ClearPagePrivate(page);
> > > -		put_page(page);
> > > +		clear_fs_page_private(page);
> > 
> > THis is a pre-existing potential use-after-free vector. The wr
> > pointer held in the page->private needs to be cleared from the page
> > before it is freed.
> 
> I'm not familar with orangefs. In my opinion, generally all temporary
> page->private access (r/w) should be properly protected by some locks,

... page->private pointers (there may be some other uses rather than
as references). sorry about that...

> most of time I think it could be at least page lock since .migratepage,
> .invalidatepage, .releasepage, .. (such paths) are already called with
> page locked (honestly I'm interested in this topic, please correct me
> if I'm wrong).
> 
> I agree that the suggested modification is more clear and easy to read.
> 
> Thanks,
> Gao Xiang
> 
> 
