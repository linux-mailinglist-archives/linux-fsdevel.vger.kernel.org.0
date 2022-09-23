Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85D55E7D66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWOmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWOmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:42:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42664C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 07:42:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e24-20020a05683013d800b0065be336b8feso148810otq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HO2AvJTBi2QfRYWbbvhuQ6oKeOfsWSwPhLgWOk8zYZY=;
        b=NHXgpkbklpQY1dujkTxtgfpxjRfII6eFpWmZSiA94BsmX9afxqU758gbbWdD1qv4DZ
         JoTmy1STKapeGJaAgqqjvA+xpmdZWFxiMRR3inRInB+3S7y8k9Cs6sQzjVaNL0b3Fn1H
         PStOgZVxWclUZJQHy8i0NeYGisONz5lsSzTX8eVG2s5pGmMVrnRKNJbfHyeE5teKHP45
         WJvJnzu3R1+twTmRMEHTMm+QNhtaQrSTgjISgkdk+uPageY2jCkJPpMh8O/cK+mHXBNC
         lHemW5id3LXX/oEy5gYDrOhXB4BryhiqdHQ1zof+3HYEO5MojDCqpnl/MRHH9B9V7kPe
         DQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HO2AvJTBi2QfRYWbbvhuQ6oKeOfsWSwPhLgWOk8zYZY=;
        b=ZO1JUOqPZGaepVuFWhWlCGEhAZy2eTuKc8HajQM4QlTbvy0a5tGTbIH4XXtgSefWe4
         c5ItAmYGBW7Egi1E/NoJcIPkwL8MGYu0qZVPPTT4yvRxwkSRoO+7HtlJZmExeuq8rM6+
         J39J258XeU7yBI401cPR1Jssak8zz8Zuoe6MfMnLD/d1oEvKbfyktTTXV89N/kOsPqYQ
         YUPEDw6ATj71vLv9USFqbw9Uqrz/1RnDsB1RBTZJnf0CMTOk6sM3qWadEC+B7tDCB0qn
         o5oMPcLhQakRz36wLkB1BQFab6Pf6ZvZgzkEX0NQHmNXLkHZkhJgcz1gga0715HQFI4O
         WjOQ==
X-Gm-Message-State: ACrzQf0pV0S0fFX0IyVldAppLGD9QtSlCMHEusYBA2keFGfq5aF4g3d3
        JfCglojJlvOylJDKK7KkmHI6wujPndvDXHBtXNx/
X-Google-Smtp-Source: AMsMyM7D3kMRKr/61cWceGGLPP8+nkrbp44T14E6MBNWlxKrHZ7Y8XAD0aPfsm+uqT+6w6wN/CfDBmHsj4twkIhQwhQ=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr4096556otl.34.1663944132441; Fri, 23
 Sep 2022 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com> <20220923084539.vazq4eiceovoclcf@wittgenstein>
In-Reply-To: <20220923084539.vazq4eiceovoclcf@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 10:42:01 -0400
Message-ID: <CAHC9VhRroVU6vOoNtpdRYXVkjJZZ+nwXC5sObGoPDw0d4Z1UBw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 4:46 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Sep 22, 2022 at 10:57:38AM -0700, Linus Torvalds wrote:
> > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > > Could we please see the entire patch set on the LSM list?
> >
> > While I don't think that's necessarily wrong, I would like to point
> > out that the gitweb interface actually does make it fairly easy to
> > just see the whole patch-set.
> >
> > IOW, that
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> >
> > that Christian pointed to is not a horrible way to see it all. Go to
> > the top-most commit, and it's easy to follow the parent links.
> >
> > It's a bit more work to see them in another order, but I find the
> > easiest way is actually to just follow the parent links to get the
> > overview of what is going on (reading just the commit messages), and
> > then after that you "reverse course" and use the browser back button
> > to just go the other way while looking at the details of the patches.
> >
> > And I suspect a lot of people are happier *without* large patch-sets
> > being posted to the mailing lists when most patches aren't necessarily
> > at all relevant to that mailing list except as context.
>
> The problem is also that it's impossible to please both parties here.

Oh the trials and tribulations of Linux Kernel development! ;)

I'm joking, but I do understand the difficulty of pleasing a large
group of people with very different desires.

> A good portion of people doesn't like being flooded with patches they
> don't really care about and the other portion gets worked up when they
> only see a single patch.

You are obviously never going to be able to make everyone happy, and
everyone with a solution to share obviously has some bias (I'm
definitely including myself in this statement), but I tend to fall
back on the idea that upstream kernel development has always required
those involved to deal with a large amount of email, so sending a full
patchset is not new.

> So honestly I just always make a judgement call based on the series. But
> b4 makes it so so easy to just retrieve the whole series. So even if I
> only receive a single patch and am curious then I just use b4.

As I mentioned previously in this thread, the issue is more on the
reply side.  Reading from lore or b4 isn't terrible for me, but
replying is a pain for me and my mail setup.

> I've even got it integrated into mutt directly:

I'm glad it works for you.  Although I would like to take this
opportunity to remind anyone still following this tangent that not
everyone uses mutt, some of us* really dislike it, but due to the
magic of email we are still able to participate with other mail
clients, services, and tools.

* I'm using "us" somewhat liberally here, I have no data to back up my
claims.  However, I'm fully prepared to accept the idea that I'm the
only person out of the thousands of kernel devs who dislikes mutt.
Bring it on haters, just know that you're all wrong ;)

-- 
paul-moore.com
