Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907423C755
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHEIBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHEIA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:00:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDADC061757
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2020 01:00:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so18099870edv.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIQ0uWOdJ++JxFUQ1HmZt5yCmSysMlWXqs04qnIH2t8=;
        b=JovMMmze/ttNrmY/DnMqXihEEGGKa1uofyYf/oxNV+TQQ3LTkh7OFwnGTAZBtxLtN7
         Fqtd03a+AYZjCg4MXAQq4qkV8JK1Zn4i7HA8oyPn2uEnw5ialjz4BT2tZqSfpNJMETkT
         WOt0pIcGbePrTBjouZ25xUAWlLwbmu6AqBFVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIQ0uWOdJ++JxFUQ1HmZt5yCmSysMlWXqs04qnIH2t8=;
        b=lAKkaVEO7LJY6iSnCSFOKtf08wNfF7IsOnD5VS2tkg6pu7Wa7y1l4zGT4NAFO569SG
         bibhFGq98OWm/MhW1bL3+4FtwqS8FpdApwtwiM9Z65ah9nxGK4+n2p/G8kNYUf8o0mg3
         dsI+mTKElWp7PTK44vgQQ71BOOFXwMsAnPaFxSOZDnn/KGiKGxMyeW8nPCytb5NJUE9I
         kTBkqjBP2sLPgGoBip/qTxafgrMLbUz8T1Iu1UrFamndmy/vNO8Fe2MR+74UOYYYAkcK
         3jUwx/sb4fQ/0Pw1xdMqNcViMZnM2e8BMGMNQJvt0E4iuXKzem5o4t6gWFEhsFcPdLpk
         Hxyg==
X-Gm-Message-State: AOAM531l2T/H+9TBdQNGXXGaVzUz+mPUbH+79t4UxD+/FwGuOtsWIWKZ
        meL7vP8UorkrgFZ9B6zj6bJAerhIHH/adk348XEWAw==
X-Google-Smtp-Source: ABdhPJzVZYXjEjW7cAtLmzaSw4Xs0qoUixG31YHsCBZaYZ//RRu9nnPEXdKwKct7yCvGc0tKDbvT1z98gPurWd/4pPA=
X-Received: by 2002:a05:6402:1bc5:: with SMTP id ch5mr1589677edb.364.1596614457770;
 Wed, 05 Aug 2020 01:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <dd1a41a129cd6e8d13525a14807e6dc65b52e0bf.camel@themaw.net>
In-Reply-To: <dd1a41a129cd6e8d13525a14807e6dc65b52e0bf.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 10:00:46 +0200
Message-ID: <CAJfpegvQdCr+u51_xkpbS7eMZyNqtnk_tdK1KVhsiCuiFWWJJw@mail.gmail.com>
Subject: Re: [GIT PULL] Filesystem Information
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 5, 2020 at 3:33 AM Ian Kent <raven@themaw.net> wrote:
>

> On Tue, 2020-08-04 at 16:36 +0200, Miklos Szeredi wrote:
> > And notice how similar the above interface is to getxattr(), or the
> > proposed readfile().  Where has the "everything is  a file"
> > philosophy
> > gone?
>
> Maybe, but that philosophy (in a roundabout way) is what's resulted
> in some of the problems we now have. Granted it's blind application
> of that philosophy rather than the philosophy itself but that is
> what happens.

Agree.   What people don't seem to realize, even though there are
blindingly obvious examples, that binary interfaces like the proposed
fsinfo(2) syscall can also result in a multitude of problems at the
same time as solving some others.

There's no magic solution in API design,  it's not balck and white.
We just need to strive for a good enough solution.  The problem seems
to be that trying to discuss the merits of other approaches seems to
hit a brick wall.  We just see repeated pull requests from David,
without any real discussion of the proposed alternatives.

>
> I get that your comments are driven by the way that philosophy should
> be applied which is more of a "if it works best doing it that way then
> do it that way, and that's usually a file".
>
> In this case there is a logical division of various types of file
> system information and the underlying suggestion is maybe it's time
> to move away from the "everything is a file" hard and fast rule,
> and get rid of some of the problems that have resulted from it.
>
> The notifications is an example, yes, the delivery mechanism is
> a "file" but the design of the queueing mechanism makes a lot of
> sense for the throughput that's going to be needed as time marches
> on. Then there's different sub-systems each with unique information
> that needs to be deliverable some other way because delivering "all"
> the information via the notification would be just plain wrong so
> a multi-faceted information delivery mechanism makes the most
> sense to allow specific targeted retrieval of individual items of
> information.
>
> But that also supposes your at least open to the idea that "maybe
> not everything should be a file".

Sure.  I've learned pragmatism, although idealist at heart.  And I'm
not saying all API's from David are shit.  statx(2) is doing fine.
It's a simple binary interface that does its job well.   Compare the
header files for statx and fsinfo, though, and maybe you'll see what
I'm getting at...

Thanks,
Miklos
