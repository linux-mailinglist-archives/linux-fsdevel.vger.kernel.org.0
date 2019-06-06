Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECF37D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFFTqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 15:46:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42927 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfFFTqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:46:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so4113152qtk.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qajFXRwDSumJ1VBt1nbVb8YwByztvxS980sXRo7osmo=;
        b=eoZ3O1RetGytNaHJt1/lQ055Dyp4yKlZbucZb+BvUi5davTaqNwzsojRJaEX3o7YBt
         pW3kUz6Q6eZ28rLtA9Jjv3JM9Jbd8rpL+tsDn7iM2UqXOLGkn166O+4yvLdC3Kj1J1Kw
         EN/awr72rkEt7yQR+AiRXrTbLCAXuw/PReh8Jee8gULLsUma+/gjV4ptkpnFqaWY9ScQ
         pfzfEEURVPjfvQ17a2N2djx/e2F+JgvAKdq7T0ZC0+SYGMwKMi53TV6yqzPwuSf8v+9u
         LYyAO6rl9kNxn5WFf8W3yFzNwERteSui2pJz14BOr2RQ5bfl/hj47SMCT66KbVbY4Rcp
         hJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qajFXRwDSumJ1VBt1nbVb8YwByztvxS980sXRo7osmo=;
        b=cPacYYoEn+YOpWig16bVOYZn3fmoNzHJ4VWn3wuo/cu+L5PP9U83QivM/05eAY4UwC
         dddxlHIhMCEQeC9WLrYpX1fRr4xwW7Oip5FTTYx1fMCQlPxl0Kc0tGNHIl617EGjbQ4y
         9MkpUiQmBqlwydB/2yZPANKBShF81wxoP4/uJAu264gWuRWENc+qtKU0BFlrzAoSJ6hg
         zlthoVttWyVJOY9UpXscfr/rOu6Sn/CGOUEcJ8u1KheMvKaPHmObRVFoj9ZO/QF2Ppu5
         e0t9aFQ4yFZ0RTmfadpwLNOrEIq/uvCyCQxDjAZslUoIUmTjaEeQfX24FMfJWH6FpVdn
         5OKA==
X-Gm-Message-State: APjAAAXDkO3to+eHelIHVa/xfKa4XeK3oklGOmUcCDebAYxFb+cig+oo
        OLZ6AbLe3pvSapKn8tzFVTqMog==
X-Google-Smtp-Source: APXvYqzAxBsAbtmAf/N2gWiDpLiwySAazMdlavwrTbL7etxy94AKJa3CMpYnlx0qPyIVzWATublI1w==
X-Received: by 2002:a0c:d0b6:: with SMTP id z51mr27514879qvg.3.1559850413173;
        Thu, 06 Jun 2019 12:46:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t197sm1407918qke.2.2019.06.06.12.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 12:46:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYyLc-0007zs-5h; Thu, 06 Jun 2019 16:46:52 -0300
Date:   Thu, 6 Jun 2019 16:46:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190606194652.GI17373@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <c559c2ce-50dc-d143-5741-fe3d21d0305c@nvidia.com>
 <20190606171158.GB11374@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606171158.GB11374@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:11:58AM -0700, Ira Weiny wrote:

> 2) This is a bit more subtle and something I almost delayed sending these out
>    for.  Currently the implementation of a lease break actually removes the
>    lease from the file.  I did not want this to happen and I was thinking of
>    delaying this patch set to implement something which keeps the lease around
>    but I figured I should get something out for comments.  Jan has proposed
>    something along these lines and I agree with him so I'm going to ask you to
>    read my response to him about the details.
>
> 
>    Anyway so the key here is that currently an app needs the SIGIO to retake
>    the lease if they want to map the file again or in parts based on usage.
>    For example, they may only want to map some of the file for when they are
>    using it and then map another part later.  Without the SIGIO they would lose
>    their lease or would have to just take the lease for each GUP pin (which
>    adds overhead).  Like I said I did not like this but I left it to get
>    something which works out.

So to be clear.. 

Even though the lease is broken the GUP remains, the pages remain
pined, and truncate/etc continues to fail? 

I like Jan's take on this actually.. see other email.

Jason
