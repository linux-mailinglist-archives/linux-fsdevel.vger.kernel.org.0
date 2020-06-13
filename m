Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4721F84E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFMTXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 15:23:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgFMTXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592076183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27T1DQs71CRwFTLizFiwEF+g4xuZMlaQho4z4MylCV8=;
        b=NOOdkJBwnk72krMKIuD1KnHPgK2Eqzn2revC8sIgShJN1p2iGPtuG7AgtbkiggHFNEc9qr
        /YA1KeHUuWc0v787/5XyeTQNl4lAIbvrujzjqwr23Njx1AdyD6cQ2pfYzwIZaHkIvYveyb
        K/qJT21HDAY6/DmgdQi5P0rYfirXxZs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-gf4utuowNn-VTxcXdrSi-Q-1; Sat, 13 Jun 2020 15:23:02 -0400
X-MC-Unique: gf4utuowNn-VTxcXdrSi-Q-1
Received: by mail-qv1-f72.google.com with SMTP id a8so9798095qvt.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27T1DQs71CRwFTLizFiwEF+g4xuZMlaQho4z4MylCV8=;
        b=IxK8aP5Q/YuZsgAALfyUyzSA/XgP278brVGiaYCOJpL+Dcvf3nOR5L7nUIPpXLkxmL
         9PcIBlq7hqlY++jzTWX/gOx8tJnygQfoXoP9KgYvMEdnaIqfsR4uXXSdPGCbhb6S3HM/
         TSUr/wT23wu2p3B2tXVv5ReCmu5mhb65tn5/MBQXnISft1ravRs1F3vcdxXOXHAiHY05
         FOi5nPkLKXNWsyEFKGopB1hIK5V6iyjb8SWpWLh+lTIRz5uDMaFFPbBP3euOLWHwOF/p
         zwp5X05ObuBYZiGaPbrGW6SdFrZMA/RR+CYIJb3ugdKXhyveyuC8Le3l712OHjrqHr+r
         WZuQ==
X-Gm-Message-State: AOAM531j9Nf2vDPGmO9BCKxdJoinNphxhGvGxZtrEXlBwBruvseMo11o
        qKcKBAB7spTJNP+4gxXlkIwrm6y4XhHv6zRYqM/mxMbtdUrpzE91R5NF1OjN64dsP5iAZVZHU4s
        cNhUDFBU4yzLSTJR/m1jb7CMKwLpU6CDp2lg0QsFGaA==
X-Received: by 2002:ad4:5885:: with SMTP id dz5mr18136134qvb.214.1592076181278;
        Sat, 13 Jun 2020 12:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2AyUSZIKPU+GPvC7qMnN6wFefeo/F6GR7zFPc56HC0zQeczkOAZb7SHVsNLhjHjXrltKCPwy8GjfH7OMAAl8=
X-Received: by 2002:ad4:5885:: with SMTP id dz5mr18136109qvb.214.1592076180987;
 Sat, 13 Jun 2020 12:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 13 Jun 2020 21:22:49 +0200
Message-ID: <CAOssrKe2hNU9OfMo5CWiq7L_Mmv_2OStYMgYgeo5yy6ppmhTrQ@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        dray@redhat.com, Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 13, 2020 at 3:05 PM David Howells <dhowells@redhat.com> wrote:

> > I'm so far just reading this thread and the arguments for users, and I
> > haven't yet looked at all the actual details in the pull request - but
> > last time I had objections to things it wasn't the code, it was the
> > lack of any use.
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

Well, I had some questions and comments for the mount notifications
last time around[1] and didn't yet get a reply.

And the fsinfo stuff is simply immature, please lets not merge it just
yet.  When we have some uses (most notably systemd) running on top of
the current fsinfo interface, we can sit down and discuss how the API
can be cleaned up.

BTW I had a similar experience with the fsconfig() merge, which was
pushed with some unpolished bits and where my comments were also
largely ignored.  So, before asking to pull, please at least *answer*
reviews.  You don't have to agree, but at least consider and think
about the comments.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com/

