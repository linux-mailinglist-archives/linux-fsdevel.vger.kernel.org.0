Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22AE5B4FA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIKP3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIKP3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:29:53 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BADE8A
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 08:29:51 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a129so6629137vsc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Sip1N7sBVgjH7aQa6zCQmu8DVGoH5SR+pE5504d9peo=;
        b=B01fuTpstdA2eEEOXe2l5AdJcllTLaFbbk03reVeucvS+XY8rbMwEqy8MWdcuKECOm
         GaqafM0jxGecj+FI6MIHKVbVChoGOdBi7ASseF89dS+ds2v5h99ni7KjZjAGsAwVfEfv
         yf+Kv7b9Bps+XTGPFhGQU2jK4GdCjNuZ4g1pWUuhD+UU5Ru4cfOxjfz/9VKVxlmOIkxz
         8cUkaFjApr77+vXmoee4hl6pv6xi6OwY+FkHPKKci7LQqRodgBk7vyK13X3T3wOb3sj6
         v7HoRv00u1UHauPjWQJbdi8dkUEda8DZGy2kquFnw24S3oL82YKJ0rf7uaypWKs/tiZ8
         ODJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Sip1N7sBVgjH7aQa6zCQmu8DVGoH5SR+pE5504d9peo=;
        b=P27Ip8zk0kJdbqDaneiiaMbaL7RpZJ4t2IJay+SoMpU7UDZsEYIEO54Gf9KT5Jt9hP
         XHPZmoSKQjJatzUGfq1rnWTOeCg87f0/7Nse07MHTi82kbe27Vn1CQKWOMO4K4j3FmRV
         pLYRsb2zy6z5R6mBKAblueeNWTfAAPqFWVugfLKnkom678i2l3xKhNIpUVEDWTOy1mnt
         pc1+8aImyTEvMm2q483IUbnWXfp4kNOitd4+fcny3Sib3KAgTTPNTfpxn1MzRDXMmuEA
         BR9xm9JJl8zkes89L8ozl4CV47mNlIaC9f550LRIs97jR+jIiSj72bhiNcJYVEu24m9v
         siKQ==
X-Gm-Message-State: ACgBeo3J1hNt8yVAmImrH5R+E5ChCgm8HsgkrG7oZgkH6Cqx3r5fkRCF
        Y9LU8r8DzvNopFrQB6rCfmp96TUj8WxLGj4wIYg=
X-Google-Smtp-Source: AA6agR48UatlhryuPTVSPozpAFoi+Y/0LCVR6ZktYmbeOVuG6mhq1t9YKZr//0zC4daM53haVazi2Jj8CVAnDQmTjWs=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr7708162vsh.3.1662910190940; Sun, 11 Sep
 2022 08:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com> <52a25e2e-8756-b9a9-db7e-61807933a395@fastmail.fm>
In-Reply-To: <52a25e2e-8756-b9a9-db7e-61807933a395@fastmail.fm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Sep 2022 18:29:39 +0300
Message-ID: <CAOQ4uxiffF6FKs_My0qxgCnPeeXKSpvzp0-iyjxno=H=Hrn-3g@mail.gmail.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file handles)
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
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

On Sun, Sep 11, 2022 at 6:16 PM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 9/11/22 12:14, Amir Goldstein wrote:
> > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >>
> >> One proposal was to add  LOOKUP_HANDLE operation that is similar to
> >> LOOKUP except it takes a {variable length handle, name} as input and
> >> returns a variable length handle *and* a u64 node_id that can be used
> >> normally for all other operations.
> >>
> >> The advantage of such a scheme for virtio-fs (and possibly other fuse
> >> based fs) would be that userspace need not keep a refcounted object
> >> around until the kernel sends a FORGET, but can prune its node ID
> >> based cache at any time.   If that happens and a request from the
> >> client (kernel) comes in with a stale node ID, the server will return
> >> -ESTALE and the client can ask for a new node ID with a special
> >> lookup_handle(fh, NULL).
> >>
> >> Disadvantages being:
> >>
> >>   - cost of generating a file handle on all lookups
> >>   - cost of storing file handle in kernel icache
> >>
> >> I don't think either of those are problematic in the virtiofs case.
> >> The cost of having to keep fds open while the client has them in its
> >> cache is much higher.
> >>
> >
> > I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> > implementation of persistent file handles for FUSE.
> >
> > The purpose is "proper" NFS export support for FUSE.
> > "proper" being survives server restart.
>
> Wouldn't fuse just need to get struct export_operations additions to
> encode and decode handles?
>

FUSE already implements those, but not in a "proper" way, because
there is nothing guaranteeing the persistence of the FUSE file handles.

As a result, when exporting some FUSE fs to NFS and the server is
restarted, NFS client may read a file A and get the content of file B,
because after server restart, FUSE file B got the node id that file A
had before restart.

This is not a hypothetical use case, I have seen this happen.

> >
> > I realize there is an ongoing effort to use file handles in the virtiofsd
> > instead of open fds and that LOOKUP_HANDLE could assist in that
> > effort, but that is an added benefit.
> >
> > I have a C++ implementation [1] which sort of supports persistent
> > file handles, but not in a generic manner.
>
> How does this interact with exportfs?
>

It makes use of internal fs knowledge to encode/decode ext4/xfs
file handles into the 64bit FUSE node id.

This sort of works, but it is not generic.

Thanks,
Amir.
