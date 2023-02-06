Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7E68BE65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBFNhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 08:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBFNho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:37:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AF40C5;
        Mon,  6 Feb 2023 05:37:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8801843wms.4;
        Mon, 06 Feb 2023 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtK8lF6MCOaS/ib0UuQzzKTe2nEq5CKGERbXbVra/oc=;
        b=UjmmeR5KWDm6CcgY6kipRMuL9ZYkzlfB97msM82Pe4GISbKW2IVY9wvGbtdJhb4VD/
         syzaLHV7Ek1sGVLY1vU5ioDg9dBdNTN1/hobxh83s5KwM+l+//dkLTkOZm7ZU/AiTMZ9
         JKXoSIVFZOc5UtmJI7PfN06V1GRo1SvGVbWqv+H+qqboxPvC+C71PIjOFwwtimMLFxRG
         TpCbZIQ+cLzvU0zhsuFNSHyAfPCvxQrzjyViF/OGUO6mDxgSENfIi/lOBE1w69p+L0zZ
         DKdDWJ8uW1LrYm4guh29Oa0l2dvPn2Ct3teyurK+8FYjaFfUCuw3NlARYfAllTGuTm2i
         mVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtK8lF6MCOaS/ib0UuQzzKTe2nEq5CKGERbXbVra/oc=;
        b=HKQBMCqU3YwY8bW7ZSk0vO9gLn/l2dfkM2HsFajBhmx6avgTqafGL6GnhBQVsGXK8j
         hqeW7uhX2qYcAApCidb3k/y/ngM22Z547rsMeXrmlnvPahRzqTQzm8i1QN1wuMBLJEck
         ezrE/5wZDP1cUxWCt3r8X1il1hH3I9ZfTDhLNimSqvIFJkQs8CDqnv6MO+U9/LZAXH+X
         FIeR2j9XJASL5Hb3O0WqIVVv49NBlvtJ3x3eKvyA5wNiwQ7IYnvMXe3EPOVV+AEliYNA
         zIwMCst1wHh1aXtOlbeoVU5zvgPT65HMVSVaM+yAYJUhQncjbpQ5LBQb9imHtjY9XgN2
         j+Mg==
X-Gm-Message-State: AO0yUKVxZUIQefb/L8Jx/6RHocynNAlVZ4XC24xwmYojvRnmH669/f/l
        Q1tMCjTlN4dnMzZQWnaNzkVUmIZVSBYXpPFZJWU=
X-Google-Smtp-Source: AK7set9yjLCi6LS32UtkqwUd45F1wNsNY8ZPtU2mX3Rol2LREzaowUWQV3I0wWKKYamifbFHdduQjseQF6lcRBZVL50=
X-Received: by 2002:a05:600c:354b:b0:3e0:c45:3456 with SMTP id
 i11-20020a05600c354b00b003e00c453456mr53427wmq.44.1675690661795; Mon, 06 Feb
 2023 05:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <2302787.WOG5zRkYfl@silver> <CAFkjPT=nxuG5rSuJ1seFV9eWvWNkyzw2f45yWqyEQV3+M91MPg@mail.gmail.com>
 <1959073.LTPWMqHWT2@silver>
In-Reply-To: <1959073.LTPWMqHWT2@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Mon, 6 Feb 2023 07:37:30 -0600
Message-ID: <CAFkjPTnDfEX4KrTtztcA=eOif6X05r=QAJrfp1wegn=xsgK6nQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 7:20 AM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> Okay, that's surprising to me indeed. My expecation was that "loose" would
> still retain its previous behaviour, i.e. loose consistency cache but without
> any readahead or writeback. I already wondered about the transitivity you used
> in code for cache selection with direct `<=` comparison of user's cache
> option.
>
> Having said that, I wonder whether it would make sense to handle these as
> options independent of each other (e.g. cache=loose,readahead), but not sure,
> maybe it would overcomplicate things unnecessarily.
>

That's fair and I've considered it, but was waiting until I get to the
dir cache changes to figure out which way I wanted to go.  I imagine
the way that would play out is there are three types of caching
(readahead, writeback, dir) with writeback inclusive of readahead
still though.  Then there would be three cache policies (tight,
temporal, loose) and finally there'd be a seperate option for fscache
(open question as to whether or not fscache with < dir makes sense..I
think probably not).

> > I've a design for a "tight" cache, which will also not be
> > as performant as loose but will add consistent dir-caching on top of
> > readahead and writeback -- once we've properly vetted that it should
> > likely be the default cache option and any fscache should be built on
> > top of it.  I was also thinking of augmenting "tight" and "loose" with
> > a "temporal" cache that works more like NFS and bounds consistency to
> > a particular time quanta.  Loose was always a bit of a "hack" for some
> > particular use cases and has always been a bit problematic in my mind.
>
> Or we could add notifications on file changes from server side, because that's
> what this is actually about, right?
>

Yeah, that's always an option, but would be tricky to work out the 9p
model for this as model is explicitly RPC so we'd have to post a read
for file changes.  We had the same discussion for locks and decided to
keep it simple for now.  I'm not opposed to exploring this, but we'd
want to keep it as a invalidate log with a single open posted read --
could use a synthetic or something similar to the Tauth messages to
have that.  That's gonna go on the end-of-the-backlog for
consideration, but happy to review if someone else wants to go after
it.

> > So, to make sure we are on the same page, was your performance
> > uplifts/penalties versus cache=none or versus legacy cache=loose?
>
> I have not tested cache=none at all, because in the scenario of 9p being a
> root fs, you need at least cache=mmap, otherwise you won't even be able to
> boot a minimum system.
>

Yeah, understood -- mmap ~= writeback so the writeback issues would
persist there.  FWIW, I continue to see no problems with cache=none,
but that makes sense as all the changes are in the cache code.  Will
keep crunching on getting this fixed.

> I compared:
>
>   * master(cache=loose) vs. this(cache=loose)
>
>   * master(cache=loose) vs. this(cache=readahead)
>
>   * master(cache=loose) vs. this(cache=writeback)
>
> > The 10x perf improvement in the patch series was in streaming reads over
> > cache=none.
>
> OK, that's an important information to mention in the first place. Because
> when say you measured a performance plus of x times, I would assume you
> compared it to at least a somewhat similar setup. I mean cache=loose was
> always much faster than cache=none before.
>

Sorry that I didn't make that more clear.  The original motivation for
the patch series was the cpu project that Ron and I have been
collaborating on and cache==loose was problematic for that use case so
we wanted something that approached the performance of cache==loose
but with tighter consistency (in particular the ability to actually do
read-ahead with open-to-close consistency).  As you pointed out
though, there was a 5% improvement in loose (probably due to reduction
of messages associated with management of the writeback_fid).  In any
case, the hope is to make cache=mmap (and eventually cache=tight) the
default cache mode versus cache=none -- but have to get this stable
first.

As I said, the dir-cache changes in the WIP patch series are expected
to benefit loose a bit more (particularly around the dir-read pain
points) and I spotted several cases where loose appears to be
re-requesting files it already has in cache -- so there may be more to
it.  But that being said, I don't expected to get 10x out of those
changes (although depends on the types of operations being performed).
Will know better when I get further along.

         -eric
