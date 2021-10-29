Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A085F440134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2RZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJ2RZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:25:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C3C061570;
        Fri, 29 Oct 2021 10:23:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u21so22370460lff.8;
        Fri, 29 Oct 2021 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtICLvOv8UaC285aDmyhMlK7DAYybzG+Y+RAGwhmM18=;
        b=gYuFZcrJIhGRvYmSW8nQ+XPuTgZps4MjJQh4pG0VrVIpuc7q5pXe920s8duO2rYy34
         GcpJg5tl7YZ2YudjJgX5pXy4J6vUf4/CcuTmSiAztjQNk4VsU2x4xsMCSN0ghDJb55t6
         fHI/Ii4Be2J6au1p4YPsGKKd3tDJ4j3xZPA7oWk/eLKWzvdsN7pYxGy7VGwr6GZQzbGZ
         30Z0yiGYVIFJQL6Eg8xzyACurG2sdamkqo0oWVz0lLSeeFRvIIVczK64xr9ILG6NNi89
         3cgehjevCtUE8Y8Dw7UKEGiKFkeIoSkqWPtHXvjefYXAuSV+ihkytBSTHPJSDiC362QR
         JQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtICLvOv8UaC285aDmyhMlK7DAYybzG+Y+RAGwhmM18=;
        b=ZPbVswE1JPwTfKEVx4LUpXNJhrD/atpdU2eJBdf7RH14c9LacMUZ7ZCY/Yv4w2Yipz
         kRqd2gzVZhciny94EqfFH60TimeD4gfi0hUQ9bLA7hslKAmR2b6Z93i4HeVjNCVrgoru
         MrX/lbhnHdoPeRKnhXerd9tH+B9uahQickqXl+dqB5TnCh/ZcVEsV1kQlihfL8XlpsqW
         rSwAk/CZ9AobqkZkXUYeXb4mwuxtuINm8T0wEwNuqGEugDfeIaFOhCwCzDc02XHAwGEr
         +q384Cr+vmHavzlqGn+Q+yGl+lKvwTUFJs5q83924pmyU/F47e4RaS+8XtsGBIabosM9
         MjPA==
X-Gm-Message-State: AOAM5317EuH1UEBO0RIzVYyI3IiSufBjo/kNuH49pNv2Ff5tQ5JotLgE
        bcoy/HSMr1QZh0K7cFamy/I=
X-Google-Smtp-Source: ABdhPJwdOMwxkjcWALwL5I2JMfEx0RECCkgsie7pTY3b2aQ4SHUsBKVPJVZZKx8zMYENaRsy2OSMUw==
X-Received: by 2002:ac2:5444:: with SMTP id d4mr12051574lfn.559.1635528189684;
        Fri, 29 Oct 2021 10:23:09 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m4sm656638lfu.107.2021.10.29.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:23:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 29 Oct 2021 19:23:07 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211029172307.GA2944@pc638.lan>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
 <20211026193315.GA1860@pc638.lan>
 <20211027175550.GA1776@pc638.lan>
 <YXupZjQgLAi6ClRi@dhcp22.suse.cz>
 <CA+KHdyX_0B-hM8m0eZBetcdBC9X3ddnA4dMyZvA2_xCjJJeJCA@mail.gmail.com>
 <YXwI7+1bQNECvBz4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXwI7+1bQNECvBz4@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Fri 29-10-21 16:05:32, Uladzislau Rezki wrote:
> [...]
> > > OK, this looks easier from the code reading but isn't it quite wasteful
> > > to throw all the pages backing the area (all of them allocated as
> > > __GFP_NOFAIL) just to then fail to allocate few page tables pages and
> > > drop all of that on the floor (this will happen in __vunmap AFAICS).
> > >
> > > I mean I do not care all that strongly but it seems to me that more
> > > changes would need to be done here and optimizations can be done on top.
> > >
> > > Is this something you feel strongly about?
> > >
> > Will try to provide some motivations :)
> > 
> > It depends on how to look at it. My view is as follows a more simple code
> > is preferred. It is not considered as a hot path and it is rather a corner
> > case to me.
> 
> Yes, we are definitely talking about corner cases here. Even GFP_KERNEL
> allocations usually do not fail.
> 
> > I think "unwinding" has some advantage. At least one motivation
> > is to release a memory(on failure) before a delay that will prevent holding
> > of extra memory in case of __GFP_NOFAIL infinitelly does not succeed, i.e.
> > if a process stuck due to __GFP_NOFAIL it does not "hold" an extra memory
> > forever.
> 
> Well, I suspect this is something that we can disagree on and both of us
> would be kinda right. I would see it as throwing baby out with the
> bathwater. The vast majority of the memory will be in the area pages and
> sacrificing that just to allocate few page tables or whatever that might
> fail in that code path is just a lot of cycles wasted.
>
We are not talking about performance, no sense to measure cycles here :)

> 
> So unless you really feel strongly about this then I would stick with
> this approach.
>
I have raised one concern. The memory resource is shared between all
process in case of __GFP_NOFAIL it might be that we never return back
to user in that scenario i prefer to release hold memory for other
needs instead of keeping it for nothing.

If you think it is not a problem, then i do not have much to say.

--
Vlad Rezki
