Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95A5B5B63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiILNjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiILNjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:39:02 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D9167DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:39:00 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id h5so4242355vkc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YDwDdSwdNGFKRgt1aPrDxjf/RRxJtphuf6R9FrOmGek=;
        b=fVhc4f3pFwiBWZjteNN/fE5ftqMMTcxLGnLCqRe34bBovjX5hqP0iMpW3USTrNHPmz
         HjUnaO+FpgqW97X81xN5OxRUnzpoAg6TTDFeP+UZ/QBPLYRBQgt6Ygl6ET0TPhTLcPSg
         h37ET/ZzV4ThXoeM2ezJY+drIqbOxNaCoFXue5qv/d4lggKs6GA8UriVdfZwnJ2FLz9n
         AtNVaaDe9PDgJwYBn2ZQeer7gYLRlU5e2gRzh5bc3XzJs3PRMFzEEY8fvpY8XW3T0m0y
         OqmNrv92t51ENDia+lAPbwcHzmljImUmndVO0r3zoClPCDdychinb8RYgP2nhSrk7mlh
         E8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YDwDdSwdNGFKRgt1aPrDxjf/RRxJtphuf6R9FrOmGek=;
        b=HNqWyRApBFBdTe8oj3tAE5X0Q7fcrkCJbF4gWbYW54tToM5um0SUr9FDv4xsAMTYQN
         p2Ooi9OkEBUarBba3bbWWfQsQ2WuCm6jM8JepZOHaPknVN8bYldyFSKFGBEtWJnotEAp
         SzFsXQ1Ab49QLnc2lCviwFN4/qCrmVZL+bM7Kp11dKBGdutCorQXifuuvqhEx9nNjoAF
         aJimCLcpg4Tgg5wK1inOrOfACOmfriLisFtAge/J7v535VpKrPiwViFL305RfN+GB0QJ
         inWi6RdFc2i17kD2gDjVVqeyg1PhNrQLHC/AvbiANGh6Kyh6jbCOWi4kRTHkIfvj8sz0
         cN8Q==
X-Gm-Message-State: ACgBeo15GqbWCFkSZO1TZKmqO4JpbtYMo9gCPjeIFSuJUKbA6ytlQY8v
        sY0mH7ib6cOb+OzEG8McqK4GC17rqmM10FaA9Pc=
X-Google-Smtp-Source: AA6agR40jGNXLFQ96qn8nSVeK49c0k8i9QriwVlFcimd1r20HZm4hSMXBSxeb/guB7SV1cjH9YIecGeU0F1Ekrtu6bQ=
X-Received: by 2002:a1f:984a:0:b0:3a1:ccba:1d7 with SMTP id
 a71-20020a1f984a000000b003a1ccba01d7mr6283738vke.11.1662989939868; Mon, 12
 Sep 2022 06:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com> <Yx8xEhxrF5eFCwJR@redhat.com>
In-Reply-To: <Yx8xEhxrF5eFCwJR@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 16:38:48 +0300
Message-ID: <CAOQ4uxikeG5Ys4Hm2nr7CuJ7cDpNmOP-PRKjezi-DTwDUP42kw@mail.gmail.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file handles)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 4:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sun, Sep 11, 2022 at 01:14:49PM +0300, Amir Goldstein wrote:
> > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > LOOKUP except it takes a {variable length handle, name} as input and
> > > returns a variable length handle *and* a u64 node_id that can be used
> > > normally for all other operations.
> > >
> > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > based fs) would be that userspace need not keep a refcounted object
> > > around until the kernel sends a FORGET, but can prune its node ID
> > > based cache at any time.   If that happens and a request from the
> > > client (kernel) comes in with a stale node ID, the server will return
> > > -ESTALE and the client can ask for a new node ID with a special
> > > lookup_handle(fh, NULL).
> > >
> > > Disadvantages being:
> > >
> > >  - cost of generating a file handle on all lookups
> > >  - cost of storing file handle in kernel icache
> > >
> > > I don't think either of those are problematic in the virtiofs case.
> > > The cost of having to keep fds open while the client has them in its
> > > cache is much higher.
> > >
> >
> > I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> > implementation of persistent file handles for FUSE.
>
> Hi Amir,
>
> I was going throug the proposal above for LOOKUP_HANDLE and I was
> wondering how nodeid reuse is handled.

LOOKUP_HANDLE extends the 64bit node id to be variable size id.
A server that declares support for LOOKUP_HANDLE must never
reuse a handle.

That's the basic idea. Just as a filesystem that declares to support
exportfs must never reuse a file handle.

> IOW, if server decides to drop
> nodeid from its cache and reuse it for some other file, how will we
> differentiate between two. Some sort of generation id encoded in
> nodeid?
>

That's usually the way that file handles are implemented in
local fs. The inode number is the internal lookup index and the
generation part is advanced on reuse.

But for passthrough fs like virtiofsd, the LOOKUP_HANDLE will
just use the native fs file handles, so virtiofsd can evict the inodes
entry from its cache completely, not only close the open fds.

That is what my libfuse_passthough POC does.

Thanks,
Amir.
