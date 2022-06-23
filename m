Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79F558BD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiFWXmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFWXlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:41:36 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF13B545;
        Thu, 23 Jun 2022 16:41:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5BE433200910;
        Thu, 23 Jun 2022 19:41:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Jun 2022 19:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1656027679; x=1656114079; bh=GGGcHpjYU8
        f0oqCF9sTkuf/ZNvqfHIvVbvWd6LyG0bU=; b=QC4ROALRMM2EBGXv7ovtZ3EwII
        lxK/2BAQH/nSlfXBmGb3YW54L+MUgvM289M+JDp4EqC6NEwfksKU1v9Dta7C7CVI
        DmHGZ73IT1dQJ2EgE0hB7CQ+aHN10pW98U+Xv+bJ8ldZbRz98sBdjdila12KU6ea
        gLoYs8sBRO9H3WlfGzZ757Fr7hKyBl8ILNosnEUSVVl52cOWnonH3j7C+WfzITdi
        xTTyeMNZ3DSAuX17+TuUEfehqT8LB3RtrzdB/rkTAc7Be2ZrJ9GTIn197C8vZsTA
        NDvGgMUVzgnyU1nwLUCbFRuIclY9G0gytC5IiNBg7qeqo3DsUsiSRCdeZC+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656027679; x=1656114079; bh=GGGcHpjYU8f0oqCF9sTkuf/ZNvqf
        HIvVbvWd6LyG0bU=; b=ju+sjPJq3VdZMwnNCAggcJkQuMnuIIZWCBng6LL/bbyX
        N8ZDxvx579+FAUhbzxnsIllQ64aPZ3SucFdempLTdwqY7P3MfrBBRk2ECZsiL+YO
        sopGkx0gt1JsXo3GYL0WYV0q0XbOk2rceo/XvSN/uz6XrGtasnpuzPxI6gh/6WLk
        qkwPlThQN/eyTgaNGVoGbBz6WCLPZ+xffGtPTm3JuIhwodtfXCMc6zwFGWJxeSkj
        4TZkb3MPULBdRgS/5YZMYpBwtENZA19wDICAhZnHrn6rvhMg1FMwlmFWZ2UOlFGz
        SAsJacJe6m4MSfjWVvCvCCh5yTTLKGZBcZax0Zzjqg==
X-ME-Sender: <xms:H_q0YoqgWPM5NHLe2HqbQU0xOkKLKnWIzTJTG4_ntCcMSp19SAwTkg>
    <xme:H_q0YupyJjC-V7IT09SslqwRntvB_5Lfr9aMCD8g5lykBhdS3JuW34ksAL_cKfZZQ
    eGjO1NULiYnvQAKcpU>
X-ME-Received: <xmr:H_q0YtOBtd4kbEaoRcPBm2IzhoNZg660TYMJSSYaWAHhk3suOMhnZsKZTkaWbQ1bI27NUaDG0X087nN8p0hmF0YZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepjeeiiedtkeegvefhfeehgfdvheejgedugeduledtvdejveeijefhvedv
    kefftdehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:H_q0Yv5EU9Pj_nxA8ky_APk25sQZBQ9temOOon0czX2hOcAyzQHVZQ>
    <xmx:H_q0Yn5Y3OST6SxxHAQkO1GB_X5ZS0G64KxYHhDkBrw9YVS4mfxnGw>
    <xmx:H_q0Yvh9YcJ_oWzKZ_F6LteKwvBwJtyK7aoUik8-XKTN5lgICeOJrw>
    <xmx:H_q0YtQFJrwB3Gdx8OIa8-QaQjOiEQ_GSxnsfD67v8AaAlUsgdrflA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 19:41:18 -0400 (EDT)
Date:   Thu, 23 Jun 2022 17:41:17 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <YrT6Hdqp36HLK9PJ@netflix>
References: <YrShFXRLtRt6T/j+@risky>
 <YrThSLvG8JSLHG4j@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrThSLvG8JSLHG4j@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:55:20PM -0400, Vivek Goyal wrote:
> So in this case single process is client as well as server. IOW, one
> thread is fuse server servicing fuse requests and other thread is fuse
> client accessing fuse filesystem?

Yes. Probably an abuse of the API and something people Should Not Do,
but as you say the kernel still shouldn't lock up like this.

> > since the thread has a copy of
> > the fd table with an fd pointing to the same fuse device, the reference
> > count isn't decremented to zero in fuse_dev_release(), and the task hangs
> > forever.
> 
> So why did fuse server thread stop responding to fuse messages. Why
> did it not complete flush.

In this particular case I think it's because the application crashed
for unrelated reasons and tried to exit the pidns, hitting this
problem.

> BTW, unkillable wait happens on ly fc->no_interrupt = 1. And this seems
> to be set only if server probably some previous interrupt request
> returned -ENOSYS.
> 
> fuse_dev_do_write() {
>                 else if (oh.error == -ENOSYS)
>                         fc->no_interrupt = 1;
> }
> 
> So a simple workaround might be for server to implement support for
> interrupting requests.

Yes, but that is the libfuse default IIUC.

> Having said that, this does sounds like a problem and probably should
> be fixed at kernel level.
> 
> > 
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 0e537e580dc1..c604dfcaec26 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -297,7 +297,6 @@ void fuse_request_end(struct fuse_req *req)
> >  		spin_unlock(&fiq->lock);
> >  	}
> >  	WARN_ON(test_bit(FR_PENDING, &req->flags));
> > -	WARN_ON(test_bit(FR_SENT, &req->flags));
> >  	if (test_bit(FR_BACKGROUND, &req->flags)) {
> >  		spin_lock(&fc->bg_lock);
> >  		clear_bit(FR_BACKGROUND, &req->flags);
> > @@ -381,30 +380,33 @@ static void request_wait_answer(struct fuse_req *req)
> >  			queue_interrupt(req);
> >  	}
> >  
> > -	if (!test_bit(FR_FORCE, &req->flags)) {
> > -		/* Only fatal signals may interrupt this */
> > -		err = wait_event_killable(req->waitq,
> > -					test_bit(FR_FINISHED, &req->flags));
> > -		if (!err)
> > -			return;
> > +	/* Only fatal signals may interrupt this */
> > +	err = wait_event_killable(req->waitq,
> > +				test_bit(FR_FINISHED, &req->flags));
> 
> Trying to do a fatal signal killable wait sounds reasonable. But I am
> not sure about the history.
> 
> - Why FORCE requests can't do killable wait.
> - Why flush needs to have FORCE flag set.

args->force implies a few other things besides this killable wait in
fuse_simple_request(), most notably:

req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);

and

__set_bit(FR_WAITING, &req->flags);

seems like it probably can be invoked from some non-user/atomic
context somehow?

> > +	if (!err)
> > +		return;
> >  
> > -		spin_lock(&fiq->lock);
> > -		/* Request is not yet in userspace, bail out */
> > -		if (test_bit(FR_PENDING, &req->flags)) {
> > -			list_del(&req->list);
> > -			spin_unlock(&fiq->lock);
> > -			__fuse_put_request(req);
> > -			req->out.h.error = -EINTR;
> > -			return;
> > -		}
> > +	spin_lock(&fiq->lock);
> > +	/* Request is not yet in userspace, bail out */
> > +	if (test_bit(FR_PENDING, &req->flags)) {
> > +		list_del(&req->list);
> >  		spin_unlock(&fiq->lock);
> > +		__fuse_put_request(req);
> > +		req->out.h.error = -EINTR;
> > +		return;
> >  	}
> > +	spin_unlock(&fiq->lock);
> >  
> >  	/*
> > -	 * Either request is already in userspace, or it was forced.
> > -	 * Wait it out.
> > +	 * Womp womp. We sent a request to userspace and now we're getting
> > +	 * killed.
> >  	 */
> > -	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> > +	set_bit(FR_INTERRUPTED, &req->flags);
> > +	/* matches barrier in fuse_dev_do_read() */
> > +	smp_mb__after_atomic();
> > +	/* request *must* be FR_SENT here, because we ignored FR_PENDING before */
> > +	WARN_ON(!test_bit(FR_SENT, &req->flags));
> > +	queue_interrupt(req);
> >  }
> >  
> >  static void __fuse_request_send(struct fuse_req *req)
> > 
> > avaialble as a full patch here:
> > https://github.com/tych0/linux/commit/81b9ff4c8c1af24f6544945da808dbf69a1293f7
> > 
> > but now things are even weirder. Tasks are stuck at the killable wait, but with
> > a SIGKILL pending for the thread group.
> 
> That's strange. No idea what's going on.

Thanks for taking a look. This is where it falls apart for me. In
principle the patch seems simple, but this sleeping behavior is beyond
my understanding.

Tycho
