Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9840D3DD193
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHBHyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhHBHyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:54:43 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63901C06175F;
        Mon,  2 Aug 2021 00:54:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m13so19239908iol.7;
        Mon, 02 Aug 2021 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4tzaH3/gD+poZSRashpKx7FCmEj3oM3eazYbyK6Vm4=;
        b=DOxBJkxgJ9MItuMFlgbzw2w+b/IXf2nIgFoM+cnZY9KP4gnM9CqZYv9PIGkOWc94il
         gUyuEoEoBXZrw3+B0LP2s/xbb4g1IJ6bMEr+ujcZFkp65CNCAm9YWJ79Depum7pNKplu
         vDukTVOYk3jnqEJhCtIAk+/X0e5w4p7yAWp2NCmk3NJy6IL+JU3dFGoaekX7+b/qyeKM
         CP5YS1TDRXf40M2dvJQV49py5ppJwdcxXp2OeY6ONnTFU013e0oDFLSk0Jwx8KIFqiI6
         sNwATnqNWnuQzZwh2lAalDqB+43V5zjUidKbJGea+6/+dAzNNfo75u/vOu7ozsoCeVsm
         9XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4tzaH3/gD+poZSRashpKx7FCmEj3oM3eazYbyK6Vm4=;
        b=hKoUu+KFZ7o4RJ+9vWRXWwQI6ec3jt8hHwFDBLjnwBUIhvm41tpjW7xlSVsapyP9h9
         jXIo1K28KzqGRbaABv52iTJKHgGIN4xdcXsJrCxg+X5RUz2qCBKh8rQV1OEr8m9KDL00
         okDFW5LuIHyO2BQM3P5N3+69bi7BPYUudhZFt3J9Q5cXDsGzsQkN1Q4Ieszod7nevSQg
         XuQfxsL8rKFlUeW4MZoqmITtI7X8o69XSvk3eXszMvc8xLh3RIX9rneJJgRdP3kl1gUB
         z2H4Ja+oXkblMZePnbV0Hx+oHV0IHJY93JfTuIm1WGi72pdQpsZ9ZcUNx03mHf/awOti
         95rw==
X-Gm-Message-State: AOAM530Lw9ZY2h3SGJecgCjCmqHhh5tOE7rVBHA0qfanO6bw+uw54VXD
        4itx1Yjf9pQljx7kk2e+Az5KT38hpGws45r+gaw=
X-Google-Smtp-Source: ABdhPJy4+LOMBS/lDu11VVVILUbclLMZXoWzUcc2SKs/9PZsqDyau4bV1IibKhkxuKby6RXmH/CGXPrU9w5R5OCyYiQ=
X-Received: by 2002:a05:6638:3292:: with SMTP id f18mr14038913jav.120.1627890873838;
 Mon, 02 Aug 2021 00:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk> <162788285645.32159.12666247391785546590@noble.neil.brown.name>
In-Reply-To: <162788285645.32159.12666247391785546590@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Aug 2021 10:54:22 +0300
Message-ID: <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 02 Aug 2021, Al Viro wrote:
> > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> >
> > > It think we need to bite-the-bullet and decide that 64bits is not
> > > enough, and in fact no number of bits will ever be enough.  overlayfs
> > > makes this clear.
> >
> > Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
> > early...
> >
> > > So I think we need to strongly encourage user-space to start using
> > > name_to_handle_at() whenever there is a need to test if two things are
> > > the same.
> >
> > ... and forgetting the inconvenient facts, such as that two different
> > fhandles may correspond to the same object.
>
> Can they?  They certainly can if the "connectable" flag is passed.
> name_to_handle_at() cannot set that flag.
> nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
> perfect.  However it is the best that can be done over NFS.
>
> Or is there some other situation where two different filehandles can be
> reported for the same inode?
>
> Do you have a better suggestion?
>

Neil,

I think the plan of "changing the world" is not very realistic.
Sure, *some* tools can be changed, but all of them?

I went back to read your initial cover letter to understand the
problem and what I mostly found there was that the view of
/proc/x/mountinfo was hiding information that is important for
some tools to understand what is going on with btrfs subvols.

Well I am not a UNIX history expert, but I suppose that
/proc/PID/mountinfo was created because /proc/mounts and
/proc/PID/mounts no longer provided tool with all the information
about Linux mounts.

Maybe it's time for a new interface to query the more advanced
sb/mount topology? fsinfo() maybe? With mount2 compatible API for
traversing mounts that is not limited to reporting all entries inside
a single page. I suppose we could go for some hierarchical view
under /proc/PID/mounttree. I don't know - new API is hard.

In any case, instead of changing st_dev and st_ino or changing the
world to work with file handles, why not add inode generation (and
maybe subvol id) to statx().
filesystem that care enough will provide this information and tools that
care enough will use it.

Thanks,
Amir.
