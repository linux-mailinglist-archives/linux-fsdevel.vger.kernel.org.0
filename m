Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8A31F2F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 00:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBRXVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 18:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRXVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:21:54 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2170C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 15:21:13 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r75so3919060oie.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEIVc+vQWriCkNYhFpstAFofB52ZFALeJcABj2wsqhc=;
        b=jDt5GopaK8zN5wP04scD4w78fTJ48VcmEfXVLKOfcbNh/1CjTeq9BqmsTJPIxnICoY
         gNYiT3wvvye3MuNpdHVWx1MOx0tO/P1WnbcPnH7jV2/V4wHcLZ4OT+7Gsc7eLH8/jdlY
         edvzQs1v9s+PY5jjEJwVNSLCjXeszcc7tHWWTkzgNGYj0XXcZ0J7yDUfjYatTbXTvWNP
         pk+eZITrLwb64iSXeLlDUBZ6CFsgdia8mL7aX4SRFKcBwvlIyYJxoEwVjQ/XvMPpD2Ey
         OaqD0Ef4eos9r1rw1VNYcbPNkdax2DcBzncBOQaT+N0jZ39XJdM0o8AdtcwfBDTjwESl
         wWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEIVc+vQWriCkNYhFpstAFofB52ZFALeJcABj2wsqhc=;
        b=V7wDuSravhj0qsJ2mQvVt/0f0A77r/4lMEwGKzQWbIhDK285ubdp6knEheddMeeSH6
         ZpN0su6Tjyr53z26yqFL1zggNKh4tmyq+8nb9dsnd1HDViTDD4qGqajmBS4jpBv66GXb
         fZNLePYbc3wpvq2l9et9UYjJI6VqMZaf0Jog44RPnewZtWgOZoZOzdPweFs+lJC+X45e
         kvQnRAhB7SuNS0C/RzYOCuJCgzFI41bX47RE33BgXoKHizDjm/LuMB3JBMp9ZY72C9bA
         WAPh2EDQPqwbFt/UF7KuKA2q9AzhPUBDqDq+2LBMXk4Cn48Rwg0cv0z0kh4WL8TXbyqu
         znVw==
X-Gm-Message-State: AOAM533ORqH2ZC1lrQR4tCbDRKCJ63Jjsex4ZJr8B4ZYFd1se7RpIw+9
        lilc6knGKkE8A4MXF6cucWqOE7GFJIKhamuaZ+TV0g==
X-Google-Smtp-Source: ABdhPJxN9UNunrU4U+YuaCFkAnkHUg/NsTcyax5MKcFTm4nUwI4VguyHgN7bNe58SAv47zPW5k+w3Zw4C8RjDu9HenQ=
X-Received: by 2002:aca:ad0d:: with SMTP id w13mr2851317oie.84.1613690473045;
 Thu, 18 Feb 2021 15:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20210203090745.4103054-2-drosen@google.com> <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
 <YBrP4NXAsvveIpwA@mit.edu> <YCMZSjgUDtxaVem3@mit.edu> <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu> <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
 <YC0/ZsQbKntSpl97@mit.edu> <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
In-Reply-To: <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 18 Feb 2021 15:21:01 -0800
Message-ID: <CA+PiJmReVX_YXZF1JrfXmothFX7q3iihm2qHyEOGEoYFyrrE5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 2:48 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Feb 17, 2021, at 9:08 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Tue, Feb 16, 2021 at 08:01:11PM -0800, Daniel Rosenberg wrote:
> >> I'm not sure what the conflict is, at least format-wise. Naturally,
> >> there would need to be some work to reconcile the two patches, but my
> >> patch only alters the format for directories which are encrypted and
> >> casefolded, which always must have the additional hash field. In the
> >> case of dirdata along with encryption and casefolding, couldn't we
> >> have the dirdata simply follow after the existing data? Since we
> >> always already know the length, it'd be unambiguous where that would
> >> start. Casefolding can only be altered on an empty directory, and you
> >> can only enable encryption for an empty directory, so I'm not too
> >> concerned there. I feel like having it swapping between the different
> >> methods makes it more prone to bugs, although it would be doable. I've
> >> started rebasing the dirdata patch on my end to see how easy it is to
> >> mix the two. At a glance, they touch a lot of the same areas in
> >> similar ways, so it shouldn't be too hard. It's more of a question of
> >> which way we want to resolve that, and which patch goes first.
> >>
> >> I've been trying to figure out how many devices in the field are using
> >> casefolded encryption, but haven't found out yet. The code is
> >> definitely available though, so I would not be surprised if it's being
> >> used, or is about to be.
> >
> > The problem is in how the space after the filename in a directory is
> > encoded.  The dirdata format is (mildly) expandable, supporting up to
> > 4 different metadata chunks after the filename, using a very
> > compatctly encoded TLV (or moral equivalent) scheme.  For directory
> > inodes that have both the encyption and compression flags set, we have
> > a single blob which gets used as the IV for the crypto.
> >
> > So it's the difference between a simple blob that is only used for one
> > thing in this particular case, and something which is the moral
> > equivalent of simple ASN.1 or protobuf encoding.
> >
> > Currently, datadata has defined uses for 2 of the 4 "chunks", which is
> > used in Lustre servers.  The proposal which Andreas has suggested is
> > if the dirdata feature is supported, then the 3rd dirdata chunk would
> > be used for the case where we currently used by the
> > encrypted-casefolded extension, and the 4th would get reserved for a
> > to-be-defined extension mechanism.
> >
> > If there ext4 encrypted/casefold is not yet in use, and we can get the
> > changes out to all potential users before they release products out
> > into the field, then one approach would be to only support
> > encrypted/casefold when dirdata is also enabled.
> >
> > If ext4 encrypted/casefold is in use, my suggestion is that we support
> > both encrypted/casefold && !dirdata as you have currently implemented
> > it, and encrypted/casefold && dirdata as Andreas has proposed.
> >
> > IIRC, supporting that Andreas's scheme essentially means that we use
> > the top four bits in the rec_len field to indicate which chunks are
> > present, and then for each chunk which is present, there is a 1 byte
> > length followed by payload.  So that means in the case where it's
> > encrypted/casefold && dirdata, the required storage of the directory
> > entry would take one additional byte, plus setting a bit indicating
> > that the encrypted/casefold dirdata chunk was present.
>
> I think your email already covers pretty much all of the points.
>
> One small difference between current "raw" encrypted/casefold hash vs.
> dirdata is that the former is 4-byte aligned within the dirent, while
> dirdata is packed.  So in 3/4 cases dirdata would take the same amount
> of space (the 1-byte length would use one of the 1-3 bytes of padding
> vs. the raw format), since the next dirent needs to be aligned anyway.
>
> The other implication here is that the 8-byte hash may need to be
> copied out of the dirent into a local variable before use, due to
> alignment issues, but I'm not sure if that is actually needed or not.
>
> > So, no, they aren't incompatible ultimatly, but it might require a
> > tiny bit more work to integrate the combined support for dirdata plus
> > encrypted/casefold.  One way we can do this, if we have to support the
> > current encrypted/casefold format because it's out there in deployed
> > implementations already, is to integrate encrypted/casefold &&
> > !dirdata first upstream, and then when we integrate dirdata into
> > upstream, we'll have to add support for the encrypted/casefold &&
> > dirdata case.  This means that we'll have two variants of the on-disk
> > format to test and support, but I don't think it's the going to be
> > that difficult.
>
> It would be possible to detect if the encrypted/casefold+dirdata
> variant is in use, because the dirdata variant would have the 0x40
> bit set in the file_type byte.  It isn't possible to positively
> identify the "raw" non-dirdata variant, but the assumption would be
> if (rec_len >= round_up(name_len, 4) + 8) in an encrypted+casefold
> directory that the "raw" hash must be present in the dirent.
>
> Cheers, Andreas
>
>
>
>
>

So sounds like we're going with the combined version. Andreas, do you
have any suggestions for changes to the casefolding patch to ease the
eventual merging with dirdata? A bunch of the changes are already
pretty similar, so some of it is just calling essentially the same
functions different things.
-Daniel
