Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668EF2AE275
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 23:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgKJWFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 17:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJWFI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:05:08 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CADC20781;
        Tue, 10 Nov 2020 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605045907;
        bh=Stu7i3M2Uo/SVlEhubU3bTNk3+qQQdYLDn9PbBcZ4nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pzT5MuHjkkk4McY6OXWRKsF27xpJmbWgFhclhRXLzcRm7baEOhuWUexxfoDAM5K3i
         UijgZ/GN47tIPkBxilk3C+MU0OuhYIbFuVSG3ja8Zdls87qfC6rUwXGUuxYYi6fKX9
         0EFlEv7teFKMMObsgZpxtjnYVUw5/N1twgn324XM=
Date:   Tue, 10 Nov 2020 14:05:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Soheil Hassas Yeganeh <soheil@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
Message-Id: <20201110140506.528d8eeb4eb62f26dfdb1c71@linux-foundation.org>
In-Reply-To: <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
        <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
        <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 7 Nov 2020 23:45:30 -0500 Soheil Hassas Yeganeh <soheil@google.com> wrote:

> On Sat, Nov 7, 2020 at 8:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri,  6 Nov 2020 18:16:27 -0500 Soheil Hassas Yeganeh <soheil.kdev@gmail.com> wrote:
> >
> > > From: Soheil Hassas Yeganeh <soheil@google.com>
> > >
> > > This patch series is a follow up based on the suggestions and feedback by Linus:
> > > https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com
> >
> > Al Viro has been playing in here as well - see the below, from
> > linux-next.
> >
> > I think I'll leave it to you folks to sort this out, please.
> 
> Thank you Andrew for pointing that out!  Sorry that I didn't notice Al
> Viro's nice clean ups.
> 
> The changes are all orthogonal and apply cleanly except "epoll: pull
> fatal signal checks into ep_send_events()".   The conflict is trivial
> and the following patch should cleanly apply to linux-next/master (I
> didn't move the initialization of `res = 0` after the new branch to
> keep it simple).
> 
> FWIW, I also stress-tested the patch series applied on top of
> linux-next/master for a couple of hours.
> 
> Could you please let me know whether I should send a V2 of the patch
> series for linux-next? Thanks!

That worked, thanks.  I'll include all this in the next drop for
linux-next.

