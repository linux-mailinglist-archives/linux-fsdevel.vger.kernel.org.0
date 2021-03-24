Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB3347467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhCXJS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCXJSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:18:47 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0FC061763;
        Wed, 24 Mar 2021 02:18:47 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u10so20717839ilb.0;
        Wed, 24 Mar 2021 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ea0wa+AeEgKbajSjsXW1Pi4L4ffJrxHBBTBKejewzzc=;
        b=UowolewkgSb17KtEg6UAlA8lK4Vdl3rQt1xr2MJ+7gwQFAkeHd+weex7zCVe8hT50z
         oAZ5+eCdTr7uwvHCjz/RmvFnqEZ8x3czPYYqD/cLJ/EqqbCDpoXR7U4CIFIznoXTM1R5
         VSbAuYWDpCqcg3wkZaLX/sr9tKE7c6GUI8aQ+qXKOrDXdaxmP3Dsr69U1aiEV7Chz2C/
         zIPjioAQ6vInMpne+jTy6fKOJiWTTSNZKq31YYMvTEDQbzpN4VzoQvIBRRWr5maqah4m
         CvFUpdW0cZoIsmmV+K/iGeE8FOvRMb9qnSTl/YtIwkS8xbIEgwC7qSoqyAdQZtKME0QN
         i15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea0wa+AeEgKbajSjsXW1Pi4L4ffJrxHBBTBKejewzzc=;
        b=f8+5FeNK8lysy3Xq8ozIjRYAzkd+pWUNe7zRpihEpcnDtAHpNHiBQXKSKNBZ1kpomf
         nSk/Z1dkfd++N0CnRMblPmIdLHNjq7uPuBY8zmuGpHtxQuZfePMzZtwMyzxYIjrTw2xz
         BDLdkxup7PNvKxEc+onRVAR4tbZUTYJw3Z4vWPnGg18LQwplKseM6xA5w8eFPYaZQKCp
         w12qUJsYAcN1EMXf8WaFwlJVHAystJ16IsCwij1ChQIqA4YPsQZ5CzFpA0RzZAkXw5bG
         UqncSGQGe4zTlmJ7WUTJaZsQpcfBG/cbpnOUkLr4VrMh0N0AuK/iAYTz486JWnrXnj4k
         XWWw==
X-Gm-Message-State: AOAM533u+UbREqadS2qW1uR8zIKYPfovuRsZgnGiyFldkE7FyI8sTR85
        paTjA5E4w2zwkuAbWWWWjEwWyMNn7mqfrRVdod0Xig+d
X-Google-Smtp-Source: ABdhPJyrmiR6vV8/MRTqoZtYyJJgTJwbApiSdgMVXeJJOK+f+HEHNHMAddDnLZC4oG8C5T94uB/vTTkrXnSfZzPSFBI=
X-Received: by 2002:a92:50b:: with SMTP id q11mr1928221ile.250.1616577527245;
 Wed, 24 Mar 2021 02:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area> <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area> <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
 <20210324074318.GA2646094@infradead.org>
In-Reply-To: <20210324074318.GA2646094@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 11:18:36 +0200
Message-ID: <CAOQ4uxgOi9hxDaL7Rk8OU3O-S+YuvDZPtpN7PggXfL=COyrc0Q@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 9:43 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Mar 24, 2021 at 08:53:25AM +0200, Amir Goldstein wrote:
> > > This also means that userspace can be entirely filesystem agnostic
> > > and it doesn't need to rely on parsing proc files to translate
> > > ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
> > > stable enough that it doesn't get the destination wrong.  It also
> > > means that fanotify UAPI probably no longer needs to supply a
> > > f_fsid with the filehandle because it is built into the
> > > filehandle....
> > >
> >
> > That is one option. Let's call it the "bullet proof" option.
> >
> > Another option, let's call it the "pragmatic" options, is that you accept
> > that my patch shouldn't break anything and agree to apply it.
>
> Your patch may very well break something.  Most Linux file systems do
> store the dev_t in the fsid and userspace may for whatever silly
> reasons depend on it.
>

I acknowledge that.
I do not claim that my change carries zero risk of breakage.
However, if such userspace dependency exists, it would break on ext4,
btrfs, ocsf2, ceph and many more fs, so it would have to be a
dependency that is tightly coupled with a specific fs.
The probability of that is rather low IMO.

I propose an opt-in mount option "-o fixed_fsid" for this behavior to make
everyone sleep better.

> Also trying to use the fsid for anything persistent is plain stupid,
> 64-bits are not enough entropy for such an identifier.  You at least
> need a 128-bit UUID-like identifier for that.
>

That's a strong claim to make without providing statistical analysis
and the description of the use case.

The requirement is for a unique identifier of a mounted fs within a
single system.

> So I think this whole discussion is going in the wrong direction.
> Is exposing a stable file system identifier useful?  Yes, for many
> reasons.  Is repurposing the fsid for that a good idea?  Hell no.

Again. Strong reaction not backed up by equally strong technical
arguments.

I am not at all opposed to a new API for stable FS_HANDLE, but no,
I am not going to offer writing this new API myself at this point.

Applications that use statfs() to identify a filesystem may very well
already exist in the wild, so the fixed_fsid discussion is independent
of the new API.

Considering the fact that many relevant filesystems do provide a stable
f_fsid and considering the fact that a blockdev number of devices that
are instantiated at boot time are often practically stable, the users of
those applications could be unaware of the instability of f_fsid or maybe
they can live with it.

I find it hard to argue with the "all-or-nothing" attitude in the reaction
to my proposed change.

What I propose is an opt-in mount option "-o fixed_fsid".

IMO, NACKing this proposal is not going to improve anything for
anyone, but I don't know what more to say.

Thanks,
Amir.
