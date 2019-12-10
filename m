Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75757119F61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 00:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLJX1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 18:27:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJX1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:27:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so22046895wrq.0;
        Tue, 10 Dec 2019 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxkeZ4mYHV1Efx0eTIxyKSIJuDm6NlhmYQEvvwWfjTM=;
        b=qJPO5yNNFbfflnYIAWu1hS8nATPbH+TmqomNqLEa5gLu7OZSF8V3KyuU3MiGzDZEgL
         9n4AQD+8SraPxNIo/8r6U/JiJ2PRXxbIl0dGOQJXym7iij/ySYbL7OuTyB6lMTEzf7xA
         1yREADbdTz3tMrylfed9XPCvWLt89pzNtkpZoRKoN2aIxilPK1v9O4RepZrDOfG9we8u
         DYxVetXaXuKuYryyd+YQmbl/0zCAjaxMYng2YHHkTiOPqXuqFukkOTYTdFd549azwW5n
         wKtOKoiF+aYENVi/X+jaiKvrMiV6addY0CtSBsAr41f8blwTfU91zUIS9/wJG7wMSB9c
         9DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxkeZ4mYHV1Efx0eTIxyKSIJuDm6NlhmYQEvvwWfjTM=;
        b=Raa/EBO3zKqE/wBsWYgOLA8hirJS3h1lQEoO98eW1ddkioZP98s6ub8rR/syeiPkZT
         9/nXYivGTeLS3PFAoWn7GrAwdIS2kjU5bDEbH97/jI9VcJJQgbdGPyI7vPYJgYKvC3e6
         uWJhbk+25Le6G19osS8ApV38lt4L0GzReXzTmFTJdwzGQmCWwGWgemxkOakSddQALV64
         RsM//AKTKm0oDWvoPQu2GXBKLUEp7wtWe6f70hWb6QZ9/6AAnRld1C31tKM9kC5AmGt5
         C+TZRcifQnLmRt1efEFIphiki9lIkO/6SfPO9kyNi/b3EFCMZbBcU0WwI2jXZkICf02w
         ChNQ==
X-Gm-Message-State: APjAAAVXoWvWn5N6QdDetfVw3HdiKdaBnCnk0peY9A2R2BCm3lDpoVyP
        GCwSsnpxgVEEaC2d0x+9rGk=
X-Google-Smtp-Source: APXvYqx945N65yOzTC2qg/WHSEfPHmAy+RFoK1/kHXjO7Iqk93T1bul5FCz/zVBxwjQD1l9dhg1SAw==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr101597wrm.284.1576020418512;
        Tue, 10 Dec 2019 15:26:58 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b17sm88329wrx.15.2019.12.10.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:26:58 -0800 (PST)
Date:   Wed, 11 Dec 2019 00:26:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        will@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] Revert "locking/mutex: Complain upon mutex API misuse in
 IRQ contexts"
Message-ID: <20191210232655.GA80975@gmail.com>
References: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
 <20191210220523.28540-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210220523.28540-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Davidlohr Bueso <dave@stgolabs.net> wrote:

> This ended up causing some noise in places such as rxrpc running in softirq.
> 
> The warning is misleading in this case as the mutex trylock and unlock
> operations are done within the same context; and therefore we need not
> worry about the PI-boosting issues that comes along with no single-owner
> lock guarantees.
> 
> While we don't want to support this in mutexes, there is no way out of
> this yet; so lets get rid of the WARNs for now, as it is only fair to
> code that has historically relied on non-preemptible softirq guarantees.
> In addition, changing the lock type is also unviable: exclusive rwsems
> have the same issue (just not the WARN_ON) and counting semaphores
> would introduce a performance hit as mutexes are a lot more optimized.
> 
> This reverts commit 5d4ebaa87329ef226e74e52c80ac1c62e4948987.

Not sure where that SHA1 came from (it's not in Linus's tree), the right 
one is:

    a0855d24fc22: ("locking/mutex: Complain upon mutex API misuse in IRQ contexts")

I've fixed the changelog accordingly.

Thanks,

	Ingo
