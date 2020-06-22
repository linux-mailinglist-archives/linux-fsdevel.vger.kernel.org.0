Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB7203E53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgFVRst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgFVRss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:48:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0552C061573;
        Mon, 22 Jun 2020 10:48:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so2419188qtr.9;
        Mon, 22 Jun 2020 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zz2d7iJ3NwSu2E/XoT3Xn56CBZyHHLfswhOCBJmBdrE=;
        b=ETnjGl3qDhRrVDClBj2NSJfweTbL2NDdD1MEU+xv69obilnDdQfWyceVLkqgCZLpWf
         q7tn6oOks08DQhsP6CFXouUZ4AHslswN2wwzmX3IhjczxV+Aib6GdkjmHNreF5VHVy1d
         HXBnRorul4AUJTUvTJAG0ubQBSb/O3nMDCt3kgWAKrDDgTkO0gf1FHnzFuhbrlZQzSwL
         58oiiqqiDifJGT5+YFOCnMV1FUE+sfn1h/jr0hP9iZJ65BVmZzYAViL55EB/meCB+7V9
         MiEmyeayF7/5P6by0vaXcwrQ274Im85PM9HscGRo44BO/VHEKky8H9KMAqi7aJJ/7AiE
         RDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zz2d7iJ3NwSu2E/XoT3Xn56CBZyHHLfswhOCBJmBdrE=;
        b=dMOwQtE04dOltYtEAGa3RN273vlr1Fi/Q6diz6VmCo84TGDVbTX6K3WDrZE1EkeQF9
         2zBttvTTRsc1TYoarOXCL6gyJeoWNpvMOv7fil3P0/qnyt7uXGNLkyG6pyyfprK/ZXv1
         Bo51KQl7Obg1QhRLwv9/Hc9G41AYErCqWo9gC7G9/MAhcfrz0Y6JVdXZejJ/oYcqyrxp
         MWCipN4UNsgQ0b7jZgg3FNA6D/PrN2ADjMl+1ZQFAH+eZKX8jN0cLh7jnFYpQJ9rOXYw
         vnWZeivxGDlS4+TCbKjpQnFF+j9xXAHCbnaOvrlbpYY2HObRcBNPQtjdv/on9EHRU+da
         hk8w==
X-Gm-Message-State: AOAM532+SqzQyjk7ADt0krd2sGqxIbmioTdQCvEvo116/dKWxhm3EkxW
        M7cDe8TPmwa3bkj1GoPnvAo=
X-Google-Smtp-Source: ABdhPJwJGd5blfrA0ijj0HL23K9O7SFQg5SC/KD4zcSDDomdxnJx0fH3LfuBQyFjWdjurKfckSSDOg==
X-Received: by 2002:aed:2359:: with SMTP id i25mr17459184qtc.194.1592848127683;
        Mon, 22 Jun 2020 10:48:47 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id a25sm4819864qtk.40.2020.06.22.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:48:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:48:45 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200622174845.GB13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Ian.

On Sun, Jun 21, 2020 at 12:55:33PM +0800, Ian Kent wrote:
> > > They are used for hotplugging and partitioning memory. The size of
> > > the
> > > segments (and thus the number of them) is dictated by the
> > > underlying
> > > hardware.
> > 
> > This sounds so bad. There gotta be a better interface for that,
> > right?
> 
> I'm still struggling a bit to grasp what your getting at but ...

I was more trying to say that the sysfs device interface with per-object
directory isn't the right interface for this sort of usage at all. Are these
even real hardware pieces which can be plugged in and out? While being a
discrete piece of hardware isn't a requirement to be a device model device,
the whole thing is designed with such use cases on mind. It definitely isn't
the right design for representing six digit number of logical entities.

It should be obvious that representing each consecutive memory range with a
separate directory entry is far from an optimal way of representing
something like this. It's outright silly.

> Maybe your talking about the underlying notifications system where
> a notification is sent for every event.
> 
> There's nothing new about that problem and it's becoming increasingly
> clear that existing kernel notification sub-systems don't scale well.
> 
> Mount handling is a current example which is one of the areas David
> Howells is trying to improve and that's taken years now to get as
> far as it has.

There sure are scalability issues everywhere that needs to be improved but
there also are cases where the issue is the approach itself rather than
scalability and I'm wondering whether this is the latter.

Thanks.

-- 
tejun
