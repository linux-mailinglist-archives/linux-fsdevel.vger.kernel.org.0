Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1D242D62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLQdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHLQdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:33:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68119C061383;
        Wed, 12 Aug 2020 09:33:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so2622923qkn.4;
        Wed, 12 Aug 2020 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pyg5JoU3Fv3hJ1Z98ffv3KXTpLWCtFk1r43AMQgVAmY=;
        b=J3O0jz2WYkxvyYsCWwzt/EjFmc7Vp7j7amRkVhcJadyj7A+YTd/IloXL79833ZxyvI
         3cQ9mWke53sf18ebRgc91M9g1+Q2Q2svRXdqjTzCCkeijCeEVaMqbNV7OFcW5niSyLMC
         1nfKnufXtPeRYYJ1/CPA2X1Q6HlJWJoVLrWm5g2sXbiZRFvHcYpXPfNSXS7d+QgMb7ig
         10Iv2/J0WoGtk3e4n2kqPTnw2cw4Be4cCKn1w6xz9GJSme3OQ8Itvc58dIusp6TIMayy
         3OPv/ZLWQ3uZd2zZacds74DjBp0wXhwHnguFelP+YsJJ2qnR1sSZDpBEolZyqsA3+juJ
         kTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pyg5JoU3Fv3hJ1Z98ffv3KXTpLWCtFk1r43AMQgVAmY=;
        b=Djmx/T6my4vq1CSr/QZSwp3OvgNmd1vsBROkDq3brshr6U96V2KpJxTn2vjT75UXQI
         l9bb1XGQYUE7PNFjQuzu/uNO3/dCQ3kWHrfG2IEYZARZlT1wTg2HU88FAE5o5YQIqZ9A
         frjScRMXGnJN39nJAR2UM3kLwhCmw2qF9T0G4DUUGVVzp836NPUVp71urOO+lgYeFKTe
         0/3cDYyHj16N098rSKnkgLZWVQwsxZnAgIT5Aa/QPTjqpFUMxj4szE1KveqT/Kud6uI3
         UbjkfTWEyBu72e7iJ5NLWAhbbIRlBcHamJK+0VXRxYWYJO9FW1ypcEjrN/MIlZf7jU6y
         JBww==
X-Gm-Message-State: AOAM530fbT6engO3fEXnCSAtYtJrqULCXEdfsz6fpi7RuSYVD0AloH5B
        e4picTEBT3lttajYX1pb4A==
X-Google-Smtp-Source: ABdhPJxgMqoHuBHR0sLoharq5kTnq4koFN9MBVRkMZpK4OQe0AF8osIodMChLpYNWfA8EzIpQ6flfg==
X-Received: by 2002:a05:620a:48c:: with SMTP id 12mr791183qkr.452.1597249998577;
        Wed, 12 Aug 2020 09:33:18 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id m30sm3254831qtm.46.2020.08.12.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:33:17 -0700 (PDT)
Date:   Wed, 12 Aug 2020 12:33:15 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812163315.GA888969@PWN>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
 <20200812081852.GA851575@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812081852.GA851575@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:18:52AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 12, 2020 at 03:13:06AM -0400, Peilin Ye wrote:
> > On Wed, Aug 12, 2020 at 09:08:27AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 12, 2020 at 02:55:56AM -0400, Peilin Ye wrote:
> > > > Prevent hfs_find_init() from dereferencing `tree` as NULL.
> > > > 
> > > > Reported-and-tested-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
> > > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > > ---
> > > >  fs/hfs/bfind.c     | 3 +++
> > > >  fs/hfsplus/bfind.c | 3 +++
> > > >  2 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> > > > index 4af318fbda77..880b7ea2c0fc 100644
> > > > --- a/fs/hfs/bfind.c
> > > > +++ b/fs/hfs/bfind.c
> > > > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> > > >  {
> > > >  	void *ptr;
> > > >  
> > > > +	if (!tree)
> > > > +		return -EINVAL;
> > > > +
> > > >  	fd->tree = tree;
> > > >  	fd->bnode = NULL;
> > > >  	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > > > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > > > index ca2ba8c9f82e..85bef3e44d7a 100644
> > > > --- a/fs/hfsplus/bfind.c
> > > > +++ b/fs/hfsplus/bfind.c
> > > > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> > > >  {
> > > >  	void *ptr;
> > > >  
> > > > +	if (!tree)
> > > > +		return -EINVAL;
> > > > +
> > > 
> > > How can tree ever be NULL in these calls?  Shouldn't that be fixed as
> > > the root problem here?
> > 
> > I see, I will try to figure out what is going on with the reproducer.
> 
> That's good to figure out.  Note, your patch might be the correct thing
> to do, as that might be an allowed way to call the function.  But in
> looking at all the callers, they seem to think they have a valid pointer
> at the moment, so perhaps if this check is added, some other root
> problem is papered over to be only found later on?

That's right - Yesterday I noticed that this function has a number of
callers who don't check `tree` at all, so I thought maybe we just add
the check here...Turned out to be quite the opposite.

Thank you,
Peilin Ye
