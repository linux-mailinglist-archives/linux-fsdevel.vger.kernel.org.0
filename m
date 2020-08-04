Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5C23BFA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 21:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHDTSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 15:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHDTSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:18:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B161C061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 12:18:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l4so43628144ejd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iECZKbCttisI32R5vOBuQe0LHnglBF7s4axnvjSdNlk=;
        b=nQ4grv0/FGhjcX/X9Q+kj/w809eT436vH2U+X4EgTlnaRGNA7g8vikX3m+zfSmYRaT
         i6cmBUlwtVL6LQdpbpBz3ozbnlKtLwkowabhGu0920duv5F6NKDItb0IoNMhvkRdBd2i
         gIIVodOYdnVzl0Ma8TCtUfhW97EQEZHXDBBfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iECZKbCttisI32R5vOBuQe0LHnglBF7s4axnvjSdNlk=;
        b=Fi7z16JI3GqIdBgsIGfAwRNrWRtVxH+D0qFDJn7AEi567/TdBDeYnGp/Zq50NxOcCQ
         ZFQzlqoCJxGRlMDzXQd4YegClNAWqUD5diqa57pANOExKKo7QApYI8LNlDU4TCC1h7sF
         9AuOL5XYMWABYIFBFkb9fRK2hI65hfmq7rV+Zi8rbmi/dtMv6QFgYusaMbqePpVaDGFM
         vK/cSmxkO4pkueCUjxUMxOqc8CmZD4ZvMCJQ5ejOKEI1F507KOMEQSgltOiKojHA9pSC
         FycjWYNET0h55PKBASMeArWwwj403WJAWgAGfETSXgQsRouVoW4JbD2LvOfmtz3JFOgH
         1xlg==
X-Gm-Message-State: AOAM532FvSP7XermLaqRINuvwFAelS6HMzIi7iZ6fwyXqbI3UgEY2Cu6
        iNuKhKM2/W8TzOH5UJ3DBWTBMbqJlTMBSHFEoYNP8g==
X-Google-Smtp-Source: ABdhPJxzCVu2FMIuLxYbxYX+UMEg7zT277U5zuZN2lWf6qdwT1ZHQkTlmDhsVnKdcF178T6jfpPcrpCd3ySV7qJkuu8=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr20883333ejt.320.1596568729975;
 Tue, 04 Aug 2020 12:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <1596555579.10158.23.camel@HansenPartnership.com>
In-Reply-To: <1596555579.10158.23.camel@HansenPartnership.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 21:18:38 +0200
Message-ID: <CAJfpegtbX4DZcEuyF1oBatP__jRc_=HFmcJE8XUHjy1rwtqdOg@mail.gmail.com>
Subject: Re: [PATCH 00/18] VFS: Filesystem information [ver #21]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-ext4@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 4, 2020 at 5:40 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2020-08-03 at 14:36 +0100, David Howells wrote:
> > Here's a set of patches that adds a system call, fsinfo(), that
> > allows information about the VFS, mount topology, superblock and
> > files to be retrieved.
> >
> > The patchset is based on top of the notifications patchset and allows
> > event counters implemented in the latter to be retrieved to allow
> > overruns to be efficiently managed.
>
> Could I repeat the question I asked about six months back that never
> got answered:
>
> https://lore.kernel.org/linux-api/1582316494.3376.45.camel@HansenPartnership.com/
>
> It sort of petered out into a long winding thread about why not use
> sysfs instead, which really doesn't look like a good idea to me.
>
> I'll repeat the information for those who want to quote it easily on
> reply without having to use a web interface:
>
> ---
> Could I make a suggestion about how this should be done in a way that
> doesn't actually require the fsinfo syscall at all: it could just be
> done with fsconfig.  The idea is based on something I've wanted to do
> for configfd but couldn't because otherwise it wouldn't substitute for
> fsconfig, but Christian made me think it was actually essential to the
> ability of the seccomp and other verifier tools in the critique of
> configfd and I belive the same critique applies here.
>
> Instead of making fsconfig functionally configure ... as in you pass
> the attribute name, type and parameters down into the fs specific
> handler and the handler does a string match and then verifies the
> parameters and then acts on them, make it table configured, so what
> each fstype does is register a table of attributes which can be got and
> optionally set (with each attribute having a get and optional set
> function).  We'd have multiple tables per fstype, so the generic VFS
> can register a table of attributes it understands for every fstype
> (things like name, uuid and the like) and then each fs type would
> register a table of fs specific attributes following the same pattern.
> The system would examine the fs specific table before the generic one,
> allowing overrides.  fsconfig would have the ability to both get and
> set attributes, permitting retrieval as well as setting (which is how I
> get rid of the fsinfo syscall), we'd have a global parameter, which
> would retrieve the entire table by name and type so the whole thing is
> introspectable because the upper layer knows a-priori all the
> attributes which can be set for a given fs type and what type they are
> (so we can make more of the parsing generic).  Any attribute which
> doesn't have a set routine would be read only and all attributes would
> have to have a get routine meaning everything is queryable.

fsconfig(2) takes an fd referring to an fs_context, that in turn
refers to a super_block.

So using fsconfig() for retrieving super_block attributes would be
fine (modulo value being const, and lack of buffer size).

But what about mount attributes?

I don't buy the argument that an API needs to be designed around the
requirements of seccomp and the like.  It should be the other way
round.  In that, I think your configfd idea was fine, and would answer
the above question.

Thanks,
Miklos
