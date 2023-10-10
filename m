Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E517BF550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346715AbjJJIJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 04:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbjJJIJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:09:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FFA9;
        Tue, 10 Oct 2023 01:09:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3231d67aff2so5342062f8f.0;
        Tue, 10 Oct 2023 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696925381; x=1697530181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2azF7zm4Mhr5NwG6r3HDA9vngFIjth6N0Ggs9+6rTn4=;
        b=hTF8QvVXKUs5IzIRkiyoUPTNVdxOCvCRRcSIY4GhjEzipCiRNKRW25l97nYPNO7DDX
         PMufv3VfZDKqd0U7YufFc774ykcWkjWUu4Um8FgvjQV3FgVXDsuNZTrhO4ZoMnzq477X
         a0CPLE65FrcvdFsZdamVJdGx6xtRUw4FRN420ApTZLIk8eGbL+7ZNmfR8/UYQaYAjFE/
         f8DzJpydAWknr6no08F5cFWiDs9I+y6Sy86OqPTtNvJTohAVIorV3qLDkNdVdsAaLbDZ
         bjXfLlB8q3bNm8JMZ59CbtH9kYQrwxH+HE4Nopu4cyFuhr67bWXBJTcQkaY/FrOnx1BK
         SJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925381; x=1697530181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2azF7zm4Mhr5NwG6r3HDA9vngFIjth6N0Ggs9+6rTn4=;
        b=YKgBx20z0Rv9jwfXZy+NdwkkLBQ/w/w42f+h9Rr4luoKGpThfBplIslV/Lg7hkQBx1
         HwTDLZwJptzoOUk9TBXiWqtrvEuqv+cDdumuX06eEwHtpAEOQt7F38HGPxGd0EFHwKDh
         mF63RMb5ANQU54b4YZCfrVdG+A7UomhG9RMgIgOsNquYE73yXkNK/vOAFHF29FwGZi/L
         J8jLUt3g9HKmlMY0k2mvwSdDqBeGfmLY1YNvSQR6Se70nv283rMxlnoT+7Qvulv4F4dE
         vI1Ypo4jSWGwIY1Cb2WM8Ic+zXrW8ay61m88Ov+MSK27jhM5OIehlbqcFMTdU90Jg5TT
         f7cw==
X-Gm-Message-State: AOJu0Yw0vYPsxnX3O5Gnb8faPm2Z7E/dTFtS/wk9NoPgCQGBdkpqIYTb
        0vc2e1LMa8h/PwHntgPy5as=
X-Google-Smtp-Source: AGHT+IG6VwM2KXiA4ZAsOynkqmRS7yBU4HFnoi3MB2x7d8DDYSXZH70BA72oaO4faVDjxmOYeHgx/Q==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id w8-20020a5d4b48000000b003197a917107mr13885939wrs.48.1696925381015;
        Tue, 10 Oct 2023 01:09:41 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm12035907wru.72.2023.10.10.01.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:09:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 10:09:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [NAK] Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Message-ID: <ZSUGwr5S5Nflbiay@gmail.com>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
 <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
 <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
 <11d39248-31fc-c625-7c06-341f0146bd67@redhat.com>
 <20230802214211.y3x3swic4jbphmtg@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802214211.y3x3swic4jbphmtg@moria.home.lan>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Aug 02, 2023 at 05:09:13PM -0400, Waiman Long wrote:
> > On 8/2/23 16:44, Kent Overstreet wrote:
> > > On Wed, Aug 02, 2023 at 04:16:12PM -0400, Waiman Long wrote:
> > > > On 7/12/23 17:11, Kent Overstreet wrote:
> > > > > These are used by bcachefs's six locks.
> > > > > 
> > > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > Cc: Waiman Long <longman@redhat.com>
> > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > ---
> > > > >    kernel/locking/osq_lock.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > > > index d5610ad52b..b752ec5cc6 100644
> > > > > --- a/kernel/locking/osq_lock.c
> > > > > +++ b/kernel/locking/osq_lock.c
> > > > > @@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> > > > >    	return false;
> > > > >    }
> > > > > +EXPORT_SYMBOL_GPL(osq_lock);
> > > > >    void osq_unlock(struct optimistic_spin_queue *lock)
> > > > >    {
> > > > > @@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
> > > > >    	if (next)
> > > > >    		WRITE_ONCE(next->locked, 1);
> > > > >    }
> > > > > +EXPORT_SYMBOL_GPL(osq_unlock);
> > > > Have you considered extending the current rw_semaphore to support a SIX lock
> > > > semantics? There are a number of instances in the kernel that a up_read() is
> > > > followed by a down_write(). Basically, the code try to upgrade the lock from
> > > > read to write. I have been thinking about adding a upgrade_read() API to do
> > > > that. However, the concern that I had was that another writer may come in
> > > > and make modification before the reader can be upgraded to have exclusive
> > > > write access and will make the task to repeat what has been done in the read
> > > > lock part. By adding a read with intent to upgrade to write, we can have
> > > > that guarantee.
> > > It's been discussed, Linus had the same thought.
> > > 
> > > But it'd be a massive change to the rw semaphore code; this "read with
> > > intent" really is a third lock state which needs all the same
> > > lock/trylock/unlock paths, and with the way rw semaphore has separate
> > > entry points for read and write it'd be a _ton_ of new code. It really
> > > touches everything - waitlist handling included.
> > 
> > Yes, it is a major change, but I had done that before and it is certainly
> > doable. There are spare bits in the low byte of rwsem->count that can be
> > used as an intent bit. We also need to add a new rwsem_wake_type for that
> > for waitlist handling.
> > 
> > 
> > > 
> > > And six locks have several other features that bcachefs needs, and other
> > > users may also end up wanting, that rw semaphores don't have; the two
> > > main features being a percpu read lock mode and support for an external
> > > cycle detector (which requires exposing lock waitlists, with some
> > > guarantees about how those waitlists are used).
> > 
> > Can you provide more information about those features?
> > 
> > > 
> > > > With that said, I would prefer to keep osq_{lock/unlock} for internal use by
> > > > some higher level locking primitives - mutex, rwsem and rt_mutex.
> > > Yeah, I'm aware, but it seems like exposing osq_(lock|unlock) is the
> > > most palatable solution for now. Long term, I'd like to get six locks
> > > promoted to kernel/locking.
> > 
> > Your SIX overlaps with rwsem in term of features. So we will have to somehow
> > merge them instead of having 2 APIs with somewhat similar functionality.
> 
> Waiman, if you think you can add all the features of six locks to rwsem,
> knock yourself out - but right now this is a vaporware idea for you, not
> something I can seriously entertain. I'm looking to merge bcachefs next
> cycle, not sit around and bikeshed for the next six months.

That's an entirely inappropriate response to valid review feedback.

Not having two overlapping locking facilities is not 'bikeshedding' at all ...

> If you start making a serious effort on adding those features to rwsem
> I'll start walking you through everything six locks has, but right now
> this is a major digression on a patch that just exports two symbols.

In Linux the burden of work is on people submitting new code, not on 
reviewers. The rule is that you should not reinvent the wheel in new
features - extend existing locking facilities please.

Waiman gave you some pointers as to how to extend rwsems.

Meanwhile, NAK on the export of osq_(lock|unlock):

    NAKed-by: Ingo Molnar <mingo@kernel.org>

Ie. NAK on this commit in linux-next:

    97da2065b7cb ("locking/osq: Export osq_(lock|unlock)")

This is an internal function of Linux locking subsystem we would not like to
expose or export.

This commit was applied without an Ack or Reviewed-by by a locking subsystem
maintainer or reviewer (which Waiman Long is).

Thanks,

	Ingo
