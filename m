Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C57CA081
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfJCOk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 10:40:57 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com ([98.137.69.204]:42005
        "EHLO sonic312-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730134AbfJCOk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1570113655; bh=XH+kkcZacDLyMt//7aPVeZ/RoAwlnvE5gDCu5nQvVyU=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=tug04+yNVYvcTNcf6/BMloUpe5zpy+A168yqZIoZ9e+oVRRaoaVKQqLU1Erwiqb5APIscD+ZRiXBE+AVapeem2Imp4W4xEqfKHEtz/iZC1jUbGIWqJqy6VHt1Yvmr80CfyjHtDwcb2t7o3eHOqYN3w6H9eHQjLfTKC2K+aUB6AL/SU5gbGrd56rnn6JRzjKVnSHMCrl4DtmkkXCbgQAGAUryrhZW2AJ3OaFf1jSiGdjPC3meauPCBW1efZh/6s77cuCxDIT6ZJEevFmJ4dL65bbixc7P4KLwjpnlUGDFTxEvjq819TQBWx12fzigXigvUHIk6ZGDKk0+v+MVuGbbPg==
X-YMail-OSG: DWxdwR4VM1laI_T7nnMyT6T4RY4Mj0UrmF1wpwElB0BN2SSzSpB1sYZGRZnJN2c
 YM_ax138Y_IIgz915r9.RzQ1y2dvGaDZ.I_gGZCb08C9XKiewFI_iPFh1WtgmdnjIcMoUi02Idk2
 DRMOglBwrZhxZsC8jxIlY5O2IDZgtmKMQQyoL7sXpChjW8PwZH_yThj7XDFQN2.0efFr5Vr7W5gl
 KgBNZ56OY7e2ayKGtWHLSJuffpqALOJ0SibjfoF6Cj86so3yfJ1xffGDKtA9gCyDJrNCmpvpXaJT
 3s6H8H.FDeSt8f.dajG8U9w8mkvK_uwGA700_MfepZ.eRn4BZkXCD2MIm2XVpyZffxBkCYj_bfaq
 AJr0FmFEBc5KBH8vDe1bTn.iW7lGJty6N9zM4WrjdfmXq9WbpQH1Y_HpU_rvon.9o37q0DB4EfO7
 X8YwkzQeRDxniL2y4KEOPLINvgoAywA1aMy6IGrBe_L_S7STFB3hOggFtvrHXYd4VmdmSyYt4y8n
 T_hOAHdttrpjYLJu8CSUUHWTHmm1HeP.HhJYmLTx2DUup7QDWrN427wKOF6Q3z1ilsb3GXgkZ7kH
 f_th6gwH7_c9E3jZLKiqKTwOwti61rjRlPFeyBO.YnN2kJVqP6354o_bce2WT345VgL6QLW56SkO
 pWv6QQMCFdVkpkVlK63ePK.ets2cjnnsImmt.kSFcJQJ7YTXKRQ.2RIRy0LZVXs2scO1lf4Nd4E4
 4qlqvwpe5mUYv2Tut1QvrvjE92WN753LY7U22zNgaEadHp9DZ0fuRk.usP2lDsJtP._QNGKbp2dZ
 HajiktEa6nR_OISchFSdnckPDz1mRlhWtRMtkCmm2lW7cGuiPgRq0v6qxKdPNeH5jWuaJ6crS0pk
 ChYVnj25iYKo5FQe.ye8MH.j475fQ86jhb.8BqGQbEZmbcdQXLfqc2ZWR2sWwUvmDGRFb_rV8qDV
 zclZ16mBOzwtYO7_UStIpowX6HH23HgkiF1I110gCdM05zUbteogqlanAbeUq6rfmUh0lRKYJlD_
 AfgPv1P2O4hrxin1qNgpT2I0r646hqrsvQikXGLE6YcR2Bv8b5D.OmQrJ1yW11MziClDCXtFOs5t
 umMP2j7d2zqJDXHGmW.Xi1aXACBI3oVtiel0h0koL1sJ64E4fVlP.u74aAc9FPqNLfl88OFnzQEM
 fyq6bbPG_AuNL624eUw16gXbfzx3jTHSPF665UHHlC7kGmTN.L.hEhwCnJz0phGlrU5R6zqzkbKU
 Ar4bDAGOdnTySFwz9SHHXj7pwoRc1mMsG8r8pBfLMuzY7X5qohfa5yxFUhqtrlh69RAVEE4xQ8tE
 0iNbzBLd9_pk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 3 Oct 2019 14:40:55 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d6c8f9c467bddad41b91e82a5a197155;
          Thu, 03 Oct 2019 14:40:53 +0000 (UTC)
Date:   Thu, 3 Oct 2019 22:40:46 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chris Mason <clm@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Message-ID: <20191003144041.GA2012@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191003015247.GI13108@magnolia>
 <20191003064022.GX16973@dread.disaster.area>
 <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
 <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chris,

On Thu, Oct 03, 2019 at 02:01:13PM +0000, Chris Mason wrote:
> 
> 
> On 3 Oct 2019, at 4:41, Gao Xiang wrote:
> 
> > Hi,
> >
> > On Thu, Oct 03, 2019 at 04:40:22PM +1000, Dave Chinner wrote:
> >> [cc linux-fsdevel, linux-block, tejun ]
> >>
> >> On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
> >>> Hi everyone,
> >>>
> >>> Does anyone /else/ see this crash in generic/299 on a V4 filesystem 
> >>> (tho
> >>> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop 
> >>> up
> >>> on generic/299 though only 80% of the time.
> >>>
> >
> > Just a quick glance, I guess there could is a race between (complete 
> > guess):
> >
> >
> >  160 static void finish_writeback_work(struct bdi_writeback *wb,
> >  161                                   struct wb_writeback_work *work)
> >  162 {
> >  163         struct wb_completion *done = work->done;
> >  164
> >  165         if (work->auto_free)
> >  166                 kfree(work);
> >  167         if (done && atomic_dec_and_test(&done->cnt))
> >
> >  ^^^ here
> >
> >  168                 wake_up_all(done->waitq);
> >  169 }
> >
> > since new wake_up_all(done->waitq); is completely on-stack,
> >  	if (done && atomic_dec_and_test(&done->cnt))
> > -		wake_up_all(&wb->bdi->wb_waitq);
> > +		wake_up_all(done->waitq);
> >  }
> >
> > which could cause use after free if on-stack wb_completion is gone...
> > (however previous wb->bdi is solid since it is not on-stack)
> >
> > see generic on-stack completion which takes a wait_queue spin_lock 
> > between
> > test and wake_up...
> >
> > If I am wrong, ignore me, hmm...
> 
> It's a good guess ;)  Jens should have this queued up already:
> 
> https://lkml.org/lkml/2019/9/23/972

Oh, I didn't notice that, it's great to be already resolved. :)

It was not fully guess though, we once had a some similar
pattern at the very early stage last year (a given IO balance
counter, wait_queue. but completion is too heavy), which resolved
in commit 848bd9acdcd0 last year. Therefore I'm experienced
with such cases.

Just saw mailing list regularly and be of some help here...
Sorry about the noise...

Thanks,
Gao Xiang

> 
> -chris
