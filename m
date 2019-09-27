Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804B9C02B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfI0JvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 05:51:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0JvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:51:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so2012133wrs.0;
        Fri, 27 Sep 2019 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UT/s5ekZUcI22BnYTDuzvND6A8rlWJDoVeIOvbjDvw=;
        b=XPXusTm85TcNc9mu9fufA2enGUz2JdExJ09NQmjHesOAdgAdhWFtyXegLLJMSujYCq
         3fPO1n5J5F9lM1c8Pe/lgk1Wru1BpRPjpFP2OztIgoZYyKGaOS1sgyGhDtsHhJrxaSiV
         JbJvn2awcubv/FRjSyge5MhK0FWTseR+ibqvYfAxzRA3CogQZ9+ZYz7ScwgsQ4Dga+RP
         2NzYQUo8o78zTOg7Vl9GNe1dQ2zGorPAG9wxDVRGZpXSgSWZvHwy9BxWl6ESJJlBayH9
         YYW+rPvQgLiV+f2lOHV3tiN8/QcHE8jjEmsr4Y2KYBwKlSqxc0EZOzrf6tFtKA90paJE
         xaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UT/s5ekZUcI22BnYTDuzvND6A8rlWJDoVeIOvbjDvw=;
        b=K74PiWfl7U1mOAjz6bt96cHD4jR8GM/vWpZwLJm9eCJAr02Jtd3LlPBgkqONK4971S
         7T3ArVhCfHLOnLcE6YjbmQ9C+hIgzTBjynanFmiELk6q0ZJVRdohEitajnpvtpi9DpI2
         Ai6KD316xtLFemHBfAKnjWCNkclT7uztMoWvyjDwpODfOW0aGoBlmtdUlDh5pzZq0JEK
         FohIuZVdhNCZv4/JMsNxzjhkVZdzSuEo+9xy/8xBPZEMvVmS4jZGw5WqrlTHdQQO9P2L
         719eqdl8fHWOPNyzjpAztFFs8uJOtk4h+t9MoYUydbgU5tHHE9uur65FtHmKmdtP5ZtR
         jpZg==
X-Gm-Message-State: APjAAAUdTQ/+6+XiACqiwrocQcUc9ZANrupmnCg6Syr7MAgKNo/KsZP7
        pBkvX7lm8LIJH9kqV89/w0SRmhe2+dKi11Ia
X-Google-Smtp-Source: APXvYqwVFTdaDUALLlk3yIGvLfT4qxhFwB9ABXK3vJAqv/7eqGKtqHEgzm7Z+gX6/nKq4kFzilQA+g==
X-Received: by 2002:a5d:55d0:: with SMTP id i16mr2178637wrw.108.1569577874943;
        Fri, 27 Sep 2019 02:51:14 -0700 (PDT)
Received: from andrea (userh626.uk.uudial.com. [194.69.102.253])
        by smtp.gmail.com with ESMTPSA id c18sm2892255wrn.45.2019.09.27.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:51:14 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:51:07 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190927095107.GA13098@andrea>
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923144931.GC2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:49:31PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 19, 2019 at 02:59:06PM +0100, David Howells wrote:
> 
> > But I don't agree with this.  You're missing half the barriers.  There should
> > be *four* barriers.  The document mandates only 3 barriers, and uses
> > READ_ONCE() where the fourth should be, i.e.:
> > 
> >    thread #1            thread #2
> > 
> >                         smp_load_acquire(head)
> >                         ... read data from queue ..
> >                         smp_store_release(tail)
> > 
> >    READ_ONCE(tail)
> >    ... add data to queue ..
> >    smp_store_release(head)
> > 
> 
> Notably your READ_ONCE() pseudo code is lacking a conditional;
> kernel/events/ring_buffer.c writes it like so:
> 
>  *   kernel                             user
>  *
>  *   if (LOAD ->data_tail) {            LOAD ->data_head
>  *                      (A)             smp_rmb()       (C)
>  *      STORE $data                     LOAD $data
>  *      smp_wmb()       (B)             smp_mb()        (D)
>  *      STORE ->data_head               STORE ->data_tail
>  *   }
>  *
>  * Where A pairs with D, and B pairs with C.
>  *
>  * In our case (A) is a control dependency that separates the load of
>  * the ->data_tail and the stores of $data. In case ->data_tail
>  * indicates there is no room in the buffer to store $data we do not.

To elaborate on this, dependencies are tricky...  ;-)

For the record, the LKMM doesn't currently model "order" derived from
control dependencies to a _plain_ access (even if the plain access is
a write): in particular, the following is racy (as far as the current
LKMM is concerned):

C rb

{ }

P0(int *tail, int *data, int *head)
{
	if (READ_ONCE(*tail)) {
		*data = 1;
		smp_wmb();
		WRITE_ONCE(*head, 1);
	}
}

P1(int *tail, int *data, int *head)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*head);
	smp_rmb();
	r1 = *data;
	smp_mb();
	WRITE_ONCE(*tail, 1);
}

Replacing the plain "*data = 1" with "WRITE_ONCE(*data, 1)" (or doing
s/READ_ONCE(*tail)/smp_load_acquire(tail)) suffices to avoid the race.
Maybe I'm short of imagination this morning...  but I can't currently
see how the compiler could "break" the above scenario.

I also didn't spend much time thinking about it.  memory-barriers.txt
has a section "CONTROL DEPENDENCIES" dedicated to "alerting developers
using control dependencies for ordering".  That's quite a long section
(and probably still incomplete); the last paragraph summarizes:  ;-)

(*) Compilers do not understand control dependencies.  It is therefore
    your job to ensure that they do not break your code.

  Andrea


>  *
>  * D needs to be a full barrier since it separates the data READ
>  * from the tail WRITE.
>  *
>  * For B a WMB is sufficient since it separates two WRITEs, and for C
>  * an RMB is sufficient since it separates two READs.
> 
> Where 'kernel' is the producer and 'user' is the consumer. This was
> written before load-acquire and store-release came about (I _think_),
> and I've so far resisted updating B to store-release because smp_wmb()
> is actually cheaper than store-release on a number of architectures
> (notably ARM).
> 
> C ought to be a load-aquire, and D really should be a store-release, but
> I don't think the perf userspace has that (or uses C11).
