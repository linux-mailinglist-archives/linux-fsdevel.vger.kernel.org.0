Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022AC2D9900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 14:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408005AbgLNNiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407978AbgLNNh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:37:59 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A885C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 05:37:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 22so5270322qkf.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+7H3maVZDtKyIACQSbJDNioWChdxXmoUpiLkKKG29bg=;
        b=tYvIPn/sCabmT4S6dXrNRgfqfOuzsNjdL+ZUDLeWb5WRiQT+HapuulzHv7JR3gvFop
         ytoDjfbIVUPpIo6kh8Q0+1hloTV8Q+MsBnzbFyqiV1OVcqlVL7LEmaiMm38PiNxaE+rh
         v2uyITjeFTRH25RTYjrzqAPfFMZaIpXM/Q7rSY2v1jxBqOKZNgPW0u0s2XsOP+ftuu6T
         oD2UEYWJiZVqNGD7KTQrW6fUMpxjhle4flL/bCVJfTujaIUrPhyQPXb4TKLqHdRFnASm
         AATQx8GsDTBbJTNOAQzdvT+zruS24bujWN17+91ZdAjiXC4CRxL91k1E4whGHkGoXHmh
         AgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+7H3maVZDtKyIACQSbJDNioWChdxXmoUpiLkKKG29bg=;
        b=ORfvt2daUCA5YTHFiqaKdm/5S5/P7tf4E4W7QuRFZy5igpZRsyyBfHpdJ9AJN7xfIN
         HJm34fhRT0IRD56EuzfY1hzMRZqMM0xRPm8RFBnrK0vkk9m1QQVfYD/tmGPoWt/q+IZm
         Vw3Z/Cr2/WEpHNM1tiKbhKWAiGogISZLfal4b6lIeVJJeCTQpxZeJ/V1NEFRnhm13Jr0
         lGPXB8kZS5wXizBpFxomC+WDAxpEiyHS55eJJrAq9rLQiFOCseQU2GEpCR54fbsmfHDt
         3b4nohVfUsYilkfcm9TyG/g1+5KtN79DJ851pZO8xhtgigSVmy07X0Fi8XJK4NeQ5xES
         fzjw==
X-Gm-Message-State: AOAM532EAcTXlxKTVH9d45MDY8p0kNhTUlyqV618r+qxyhi+No8eopWy
        r0N0dY9hBHyj+k64cMuD4mxpRQ==
X-Google-Smtp-Source: ABdhPJw9MQ0s6FRmy65sWeAfUDVHu+0oU2LDGGgBYdPqUDMN62S2tyDouTwS1g3kUtCb8C06YAp+PA==
X-Received: by 2002:a37:d2c7:: with SMTP id f190mr32750037qkj.128.1607953038121;
        Mon, 14 Dec 2020 05:37:18 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id x28sm14198318qtv.8.2020.12.14.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:37:16 -0800 (PST)
Date:   Mon, 14 Dec 2020 08:37:14 -0500
From:   Jeffrey Layton <jlayton@poochiereds.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 1/2] errseq: split the SEEN flag into two new flags
Message-ID: <20201214133714.GA13412@tleilax.poochiereds.net>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-2-jlayton@kernel.org>
 <87ft49jn37.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft49jn37.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:35:56AM +1100, NeilBrown wrote:
> On Sun, Dec 13 2020, Jeff Layton wrote:
> 
> > Overlayfs's volatile mounts want to be able to sample an error for
> > their own purposes, without preventing a later opener from potentially
> > seeing the error.
> >
> > The original reason for the SEEN flag was to make it so that we didn't
> > need to increment the counter if nothing had observed the latest value
> > and the error was the same. Eventually, a regression was reported in
> > the errseq_t conversion, and we fixed that by using the SEEN flag to
> > also mean that the error had been reported to userland at least once
> > somewhere.
> >
> > Those are two different states, however. If we instead take a second
> > flag bit from the counter, we can track these two things separately,
> > and accomodate the overlayfs volatile mount use-case.
> >
> > Add a new MUSTINC flag that indicates that the counter must be
> > incremented the next time an error is set, and rework the errseq
> > functions to set and clear that flag whenever the SEEN bit is set or
> > cleared.
> >
> > Test only for the MUSTINC bit when deciding whether to increment the
> > counter and only for the SEEN bit when deciding what to return in
> > errseq_sample.
> >
> > Add a new errseq_peek function to allow for the overlayfs use-case.
> > This just grabs the latest counter and sets the MUSTINC bit, leaving
> > the SEEN bit untouched.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/errseq.h |  2 ++
> >  lib/errseq.c           | 64 ++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 55 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> > index fc2777770768..6d4b9bc629ac 100644
> > --- a/include/linux/errseq.h
> > +++ b/include/linux/errseq.h
> > @@ -9,6 +9,8 @@ typedef u32	errseq_t;
> >  
> >  errseq_t errseq_set(errseq_t *eseq, int err);
> >  errseq_t errseq_sample(errseq_t *eseq);
> > +errseq_t errseq_peek(errseq_t *eseq);
> > +errseq_t errseq_sample_advance(errseq_t *eseq);
> >  int errseq_check(errseq_t *eseq, errseq_t since);
> >  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
> >  #endif
> > diff --git a/lib/errseq.c b/lib/errseq.c
> > index 81f9e33aa7e7..5cc830f0361b 100644
> > --- a/lib/errseq.c
> > +++ b/lib/errseq.c
> > @@ -38,8 +38,11 @@
> >  /* This bit is used as a flag to indicate whether the value has been seen */
> >  #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
> 
> Would this look nicer using the BIT() macro?
> 
>   #define ERRSEQ_SEEN		BIT(ERRSEQ_SHIFT)
> 
> >  
> > +/* This bit indicates that value must be incremented even when error is same */
> > +#define ERRSEQ_MUSTINC		(1 << (ERRSEQ_SHIFT + 1))
> 
>  #define ERRSEQ_MUSTINC		BIT(ERRSEQ_SHIFT+1)
> 
> or if you don't like the BIT macro (not everyone does), then maybe
> 
>  #define ERR_SEQ_MUSTINC	(ERRSEQ_SEEN << 1 )
> 
> ??
> 
> > +
> >  /* The lowest bit of the counter */
> > -#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
> > +#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 2))
> 
> Ditto.
> 

Yes, I can make that change. The BIT macro is much easier to read.

> >  
> >  /**
> >   * errseq_set - set a errseq_t for later reporting
> > @@ -77,11 +80,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
> >  	for (;;) {
> >  		errseq_t new;
> >  
> > -		/* Clear out error bits and set new error */
> > -		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
> > +		/* Clear out flag bits and set new error */
> > +		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN|ERRSEQ_MUSTINC)) | -err;
> 
> This is starting to look clumsy (or maybe, this already looked clumsy,
> but now that is hard to ignore).
> 
> 		new = (old & (ERRSEQ_CTR_INC - 1)) | -err
> 

I think you mean:

		new = (old & ~(ERRSEQ_CTR_INC - 1)) | -err;

Maybe I can add a new ERRSEQ_CTR_MASK value though which makes it more
evident.

> Also this assumes MAX_ERRNO is a mask, which it is .. today.
> 
> 	BUILD_BUG_ON(MAX_ERRNO & (MAX_ERRNO + 1));
> ??
> 

We already have this in errseq_set:

        BUILD_BUG_ON_NOT_POWER_OF_2(MAX_ERRNO + 1);

> >  
> > -		/* Only increment if someone has looked at it */
> > -		if (old & ERRSEQ_SEEN)
> > +		/* Only increment if we have to */
> > +		if (old & ERRSEQ_MUSTINC)
> >  			new += ERRSEQ_CTR_INC;
> >  
> >  		/* If there would be no change, then call it done */
> > @@ -122,14 +125,50 @@ EXPORT_SYMBOL(errseq_set);
> >  errseq_t errseq_sample(errseq_t *eseq)
> >  {
> >  	errseq_t old = READ_ONCE(*eseq);
> > +	errseq_t new = old;
> >  
> > -	/* If nobody has seen this error yet, then we can be the first. */
> > -	if (!(old & ERRSEQ_SEEN))
> > -		old = 0;
> > -	return old;
> > +	/*
> > +	 * For the common case of no errors ever having been set, we can skip
> > +	 * marking the SEEN|MUSTINC bits. Once an error has been set, the value
> > +	 * will never go back to zero.
> > +	 */
> > +	if (old != 0) {
> > +		new |= ERRSEQ_SEEN|ERRSEQ_MUSTINC;
> 
> You lose me here.  Why is ERRSEQ_SEEN being set, where it wasn't before?
> 
> The ERRSEQ_SEEN flag not means precisely "The error has been reported to
> userspace".
> This operations isn't used to report errors - that is errseq_check().
> 
> I'm not saying the code it wrong - I really cannot tell.
> I'm just saying that I cannot see why it might be right.
> 

I think you're right. We should not be setting SEEN here, but we do
need to set MUSTINC if it's not already set. I'll fix (and re-test).

Thanks for the review!

> 
> 
> 
> > +		if (old != new)
> > +			cmpxchg(eseq, old, new);
> > +		if (!(old & ERRSEQ_SEEN))
> > +			return 0;
> > +	}
> > +	return new;
> >  }
> >  EXPORT_SYMBOL(errseq_sample);
> >  
> > +/**
> > + * errseq_peek - Grab current errseq_t value, but don't mark it SEEN
> > + * @eseq: Pointer to errseq_t to be sampled.
> > + *
> > + * In some cases, we need to be able to sample the errseq_t, but we're not
> > + * in a situation where we can report the value to userland. Use this
> > + * function to do that. This ensures that later errors will be recorded,
> > + * and that any current errors are reported at least once.
> > + *
> > + * Context: Any context.
> > + * Return: The current errseq value.
> > + */
> > +errseq_t errseq_peek(errseq_t *eseq)
> > +{
> > +	errseq_t old = READ_ONCE(*eseq);
> > +	errseq_t new = old;
> > +
> > +	if (old != 0) {
> > +		new |= ERRSEQ_MUSTINC;
> > +		if (old != new)
> > +			cmpxchg(eseq, old, new);
> > +	}
> > +	return new;
> > +}
> > +EXPORT_SYMBOL(errseq_peek);
> > +
> >  /**
> >   * errseq_check() - Has an error occurred since a particular sample point?
> >   * @eseq: Pointer to errseq_t value to be checked.
> > @@ -143,7 +182,10 @@ EXPORT_SYMBOL(errseq_sample);
> >   */
> >  int errseq_check(errseq_t *eseq, errseq_t since)
> >  {
> > -	errseq_t cur = READ_ONCE(*eseq);
> > +	errseq_t cur = READ_ONCE(*eseq) & ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
> > +
> > +	/* Clear the flag bits for comparison */
> > +	since &= ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
> >  
> >  	if (likely(cur == since))
> >  		return 0;
> > @@ -195,7 +237,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
> >  		 * can advance "since" and return an error based on what we
> >  		 * have.
> >  		 */
> > -		new = old | ERRSEQ_SEEN;
> > +		new = old | ERRSEQ_SEEN | ERRSEQ_MUSTINC;
> >  		if (new != old)
> >  			cmpxchg(eseq, old, new);
> >  		*since = new;
> > -- 
> > 2.29.2


