Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A1241C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgHKOgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgHKOgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:36:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725BC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:36:44 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v22so9257112edy.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqdx28YA3pNP6REzIkc0gA+th2RV2sA+pXLZKVTobEc=;
        b=Q1ksszNnkE3uXErudLxD5Slds/9xC2LepwVHl/yg53pTvHQKvRVeVoUg19cu3r8O/d
         2j5OwMLDoAG2lTQ7vwNNjuRby0rp1tOy3R428/P7KvCr+CqmNv4b9Nxng7AZH6DqOvtU
         tf6V8M7ABdiI9pdl+NAAhtTZ4ax+VPsqyGlKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqdx28YA3pNP6REzIkc0gA+th2RV2sA+pXLZKVTobEc=;
        b=skUfcpuxsokPzYX03WKvYvBYXelUAx3FywCnpBrWX3f/Kq6v7UgPE8KrIYcw33VQQS
         LTBwId1PfKI5LWozWAIxPHQOuxLRAvcOXHWB2zcEq/y9D50gSgNYv0DcFHgPnAYngJf4
         rJof4sPukp8e9tTANQ6kDQm+8wqyymO0LJT2QRwQ/9sQ5aI0eepaUzXXrwQ+tweU/t5q
         +XWe6CFHvCYRWlAl+tNxbxcWBu/q0273gMrLuqYsEZoEtkCCQHnRQYETx1J4aXRfQV5+
         BluKj44ltSBFDRk5ch9t/JG5t0zWFE2Vb7PBzrFRzFRTiScq/BYmnhek0U9oLCuNTfMr
         L/pw==
X-Gm-Message-State: AOAM531RqwkD2vxOkSbv+4E2vUmlFxmkRGA2wObqysZSMPAFlQ0T8Jwo
        bEvSD43VrPAAZBHG7/hQtD1XnZfX8wjLDzVnykFxQA==
X-Google-Smtp-Source: ABdhPJxfnGcG5XR0N3VewKejZMDihZQ7PMSWe3JlRhAnp2pRLAKcLCy/qRsSkNN9jcnRpbbl6pgbPRQzUP2hwNpB62Q=
X-Received: by 2002:aa7:d688:: with SMTP id d8mr26760651edr.168.1597156603660;
 Tue, 11 Aug 2020 07:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <20200811140833.GH1236603@ZenIV.linux.org.uk>
 <CAJfpegsNj55pTXe97qE_i-=zFwca1=2W_NqFdn=rHqc_AJjr8Q@mail.gmail.com> <20200811143107.GI1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811143107.GI1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 16:36:32 +0200
Message-ID: <CAJfpegvAVOYg03q7n24d6faX33rd16WWi5+LLDdfwj_gRYaJLQ@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 4:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 04:22:19PM +0200, Miklos Szeredi wrote:
> > On Tue, Aug 11, 2020 at 4:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 03:54:19PM +0200, Miklos Szeredi wrote:
> > > > On Wed, Aug 05, 2020 at 10:24:23AM +0200, Miklos Szeredi wrote:
> > > > > On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > > I think we already lost that with the xattr API, that should have been
> > > > > > done in a way that fits this philosophy.  But given that we  have "/"
> > > > > > as the only special purpose char in filenames, and even repetitions
> > > > > > are allowed, it's hard to think of a good way to do that.  Pity.
> > > > >
> > > > > One way this could be solved is to allow opting into an alternative
> > > > > path resolution mode.
> > > > >
> > > > > E.g.
> > > > >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> > > >
> > > > Proof of concept patch and test program below.
> > > >
> > > > Opted for triple slash in the hope that just maybe we could add a global
> > > > /proc/sys/fs/resolve_alt knob to optionally turn on alternative (non-POSIX) path
> > > > resolution without breaking too many things.  Will try that later...
> > > >
> > > > Comments?
> > >
> > > Hell, NO.  This is unspeakably tasteless.  And full of lovely corner cases wrt
> > > symlink bodies, etc.
> >
> > It's disabled inside symlink body resolution.
> >
> > Rules are simple:
> >
> >  - strip off trailing part after first instance of ///
> >  - perform path lookup as normal
> >  - resolve meta path after /// on result of normal lookup
>
> ... and interpolation of relative symlink body into the pathname does change
> behaviour now, *including* the cases when said symlink body does not contain
> that triple-X^Hslash garbage.  Wonderful...

Can you please explain?

Thanks,
Miklos
