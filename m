Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0261C4088B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhIMKFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhIMKFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:05:33 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C49C061574;
        Mon, 13 Sep 2021 03:04:17 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l10so9410200ilh.8;
        Mon, 13 Sep 2021 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHsA16MmTwJ7m8LQOCBFaJxQ81vKONAL+/tGmbsbP/M=;
        b=E1Y5AC0mIBlR3kybukkKzCWOhn6aIaU0tuU21P/lDrkFMHKuxdzbPn4E7dpGtvvE++
         9+MPyhBzlK/IqBtF5auZUF/CfVUDIIBrdnTyzfVm8tHepA1o3ahoOusVIrjGERnvVv89
         jF/x0ouN4WOgxJBOxfcrJWQ7DHp7L51rqgqbcLC/BRgo3LI+hYGcEtY5J9opmPY9fmIl
         BjVStfB/R7ET91nGx+McauU/rgh3TOLgUVbHdvA4S5soo9H61ZA8ouHEdDeKhsuBl7s/
         nQGjTkJhL6bwbjiqwGIFekoYYTIUBpCHkAq54ZbMyCvCxizRBPFCHfkhzidrpm9sUGwx
         fXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHsA16MmTwJ7m8LQOCBFaJxQ81vKONAL+/tGmbsbP/M=;
        b=mhGlDH76G0Z6BWXDvQWw3WCzWzVTmxmgsywpmW+Y6z5Y6PVFtsMmOo0yMmUnRP8FhR
         11PY1gRJJ4WgQ1Xv1JJ5cqSDXQq+B0AFOGmZcTvYShFmLOm/EE2xic90VQ65ofhY/mTN
         VzBIZfM85g1CKyuj+vaNVKPsIOBjlIDZ92HPD2eJGQHUQbveun7oOLdfQmfayKlHrwJE
         wHVobn7y1BddAFB8EpeTumsTlcUnYloxqisxD6XJpv1ivRGWkUUSTfPccuvN8eZW9aF1
         e1HR603QXFaSrUD8KGqxoy3b0LB3Eb4MkTmZZlnw7aMeefrNz+yE1/QZ3/UzhPM0nd0P
         kLUQ==
X-Gm-Message-State: AOAM532qrQy1vMeIZM7/s0VXQCM8UZnvFyDAmraZvWbqdZscEDAWGd4W
        5zsQgp6rHZrWGC0qtpUz0fUjMqE/JKB1Pqj/rHOSUZO5TlQ=
X-Google-Smtp-Source: ABdhPJzDhZnYts4gI+yufZYntrp4BiNejANLyhp1t/ab9PPH4aumC02SHCzYWJB+5WQJfEL7TzQtPKokSZbQOGMdDaw=
X-Received: by 2002:a92:d752:: with SMTP id e18mr7725996ilq.254.1631527457350;
 Mon, 13 Sep 2021 03:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org> <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org> <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org> <20210901152251.GA6533@fieldses.org>
 <163055605714.24419.381470460827658370@noble.neil.brown.name>
 <20210905160719.GA20887@fieldses.org> <163089177281.15583.1479086104083425773@noble.neil.brown.name>
 <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com> <163149382437.8417.3479990258042844514@noble.neil.brown.name>
In-Reply-To: <163149382437.8417.3479990258042844514@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Sep 2021 13:04:05 +0300
Message-ID: <CAOQ4uxgFf5c0to7f4cT9c9JwWisYRf-kxiZS4BuyXaQV=bLbJg@mail.gmail.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I do have one general question about the expected behavior -
> > In his comment to the LWN article [2], Josef writes:
> >
> > "The st_dev thing is unfortunate, but again is the result of a lack of
> > interfaces.
> >  Very early on we had problems with rsync wandering into snapshots and
> >  copying loads of stuff. Find as well would get tripped up.
> >  The way these tools figure out if they've wandered into another file system
> >  is if the st_dev is different..."
> >
> > If your plan goes through to export the main btrfs filesystem and
> > subvolumes as a uniform st_dev namespace to the NFS client,
> > what's to stop those old issues from remerging on NFS exported btrfs?
>
> That comment from Josef was interesting.... It doesn't align with
> Commit 3394e1607eaf ("Btrfs: Give each subvol and snapshot their own anonymous devid")
> when Chris Mason introduced the per-subvol device number with the
> justification that:
>     Each subvolume has its own private inode number space, and so we need
>     to fill in different device numbers for each subvolume to avoid confusing
>     applications.
>
> But I understand that history can be messy and maybe there were several
> justifications of which Josef remembers one and Chris reported
> another.
>

I don't see a contradiction between the two reasons.
Reporting two different objects with the same st_ino;st_dev is a problem
and so is rsync wandering into subvolumes is another problem.

Separate st_dev solves the first problem and leaves the behavior
or rsync in the hands of the user (i.e. rsync --one-file-system).

> If rsync did, in fact, wander into subvols and didn't get put off by the
> duplicate inode numbers (like 'find' does), then it would still do that
> when accessing btrfs over NFS.  This has always been the case.  Chris'
> "fix" only affected local access, it didn't change NFS access at all.
>

Right, so the right fix IMO would be to provide similar semantics
to the NFS client, like your first patch set tried to do.

> >
> > IOW, the user experience you are trying to solve is inability of 'find'
> > to traverse the unified btrfs namespace, but Josef's comment indicates
> > that some users were explicitly unhappy from 'find' trying to traverse
> > into subvolumes to begin with.
>
> I believe that even 12 years ago, find would have complained if it saw a
> directory with the same inode as an ancestor.  Chris's fix wouldn't
> prevent find from entering in that case, because it wouldn't enter
> anyway.
>
> >
> > So is there really a globally expected user experience?
>
> No.  Everybody wants what they want.  There is some overlap, not no
> guarantees.  That is the unavoidable consequence of ignoring standards
> when implementing functionality.
>
> > If not, then I really don't see how an nfs export option can be avoided.
>
> And I really don't see how an nfs export option would help...  Different
> people within and organisation and using the same export might have
> different expectations.

That's true.
But if admin decides to export a specific btrfs mount as a non-unified
filesystem, then NFS clients can decide whether ot not to auto-mount the
exported subvolumes and different users on the client machine can decide
if they want to rsync or rsync --one-file-system, just as they would with
local btrfs.

And maybe I am wrong, but I don't see how the decision on whether to
export a non-unified btrfs can be made a btrfs option or a nfsd global
option, that's why I ended up with export option.

Thanks,
Amir.
