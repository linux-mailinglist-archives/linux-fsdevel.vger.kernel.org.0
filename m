Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5ED40A61F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhINFrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 01:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhINFrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:47:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A86C061574;
        Mon, 13 Sep 2021 22:46:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n24so15403245ion.10;
        Mon, 13 Sep 2021 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVSny6KH6JkwDTAYbHKx/8krurin4WSwpy6Q6/kcRHQ=;
        b=YrbtXbmwTebK5EauqHlTZHCbwA16tasC4e13jFud9uWMTl2WhwizXOANNG1EVxzSna
         AD+tPbgbBCkVkQX8WaRNdc1P0oB+tIDXwbXTTLj2K4fvXkvjwBifkyshJDGJRHxj3XXw
         5iBermetCk9Ssffee3VB/pnAK3GkOtTc1WT+dEoH+k+T03RIzjePjTn1FfK84e2iT0t1
         A8epZJm4xjhnbhuZpga7+fdtCFSJG/hbn8C0oCI1mxBbuubZ/+LgEVETfCGkVcyA8Paq
         R2+SJyPkg9fqSrWL5tSyNoT7wab5fjv4ItB0RJJpSmNykQs0qFMVGfmJialSAu/49Vx6
         uJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVSny6KH6JkwDTAYbHKx/8krurin4WSwpy6Q6/kcRHQ=;
        b=V+o8u3CReGM+0/LWBMCep4FM7Bx+SBaPwKCHhyviB6nGDjIs8Dpg7EJN2IZJL/TDaA
         76N8E+9n1ZArFTRuCFKxSM9MAdYOurEz1OfCCy2IhhjqRF5o38R9jTRniA32KzCoYvzG
         5oQ3653uwhvqcUs33Zq+cGta36HSyoWUsu37X0UAZdD5pV8jQyqMev1aaJ5fW/uUQydD
         HRpAoR8sUuYxuZ85xpUBMp+I2RtF4OiiSlZLwPnSuRFb6UUMgy0Ak4p4Owt1NpElxCHL
         i007cS5zzyTzQNGGzCycr5wGEOLJYs9mUvxVdL71Q/lLD3R7Ymrqw13hkz5rRjh1AlMm
         9aHw==
X-Gm-Message-State: AOAM532OxxERqZq2TybVTVC+cuwxRfalkyRPqoXZ/vWpkpWz6VfSpco0
        MOLrvjUg27dKvsb6x+/GV9QfVP9G9sncT7UO9sAZj812h38=
X-Google-Smtp-Source: ABdhPJx4rm0zvKWH/6mUluEvjy3FATUOc2NKbWU9DeGqYjW26ZNmJRSAzUCsUNhn2TG2Q7a1bqNmZA3J5tdUnDMGYq4=
X-Received: by 2002:a6b:610e:: with SMTP id v14mr11890067iob.70.1631598361241;
 Mon, 13 Sep 2021 22:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org> <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org> <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org> <20210901152251.GA6533@fieldses.org>
 <163055605714.24419.381470460827658370@noble.neil.brown.name>
 <20210905160719.GA20887@fieldses.org> <163089177281.15583.1479086104083425773@noble.neil.brown.name>
 <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>
 <163149382437.8417.3479990258042844514@noble.neil.brown.name>
 <CAOQ4uxgFf5c0to7f4cT9c9JwWisYRf-kxiZS4BuyXaQV=bLbJg@mail.gmail.com> <163157398661.3992.2107487416802405356@noble.neil.brown.name>
In-Reply-To: <163157398661.3992.2107487416802405356@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Sep 2021 08:45:50 +0300
Message-ID: <CAOQ4uxiCbppj0QApyxbqmGPwQy+bb4588KMu+uPZaFTGwAdMag@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 1:59 AM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 13 Sep 2021, Amir Goldstein wrote:
> >
> > Right, so the right fix IMO would be to provide similar semantics
> > to the NFS client, like your first patch set tried to do.
> >
>
> Like every other approach, this sounds good and sensible ...  until
> you examine the details.
>
> For NFSv3 (RFC1813) this would be a protocol violation.
> Section 3.3.3 (LOOKUP) says:
>   A server will not allow a LOOKUP operation to cross a mountpoint to
>   the root of a different filesystem, even if the filesystem is
>   exported.
>
> The filesystem is represented by the fsid, so this implies that the fsid
> of an object reported by LOOKUP must be the same as the fsid of the
> directory used in the LOOKUP.
>
> Linux NFS does allow this restriction to be bypassed with the "crossmnt"
> export option.  Maybe if crossmnt were given it would be defensible to
> change the fsid - if crossmnt is not given, we leave the current
> behaviour.  Note that this is a hack and while it is extremely useful,
> it does not produce a seemly experience.  You can get exactly the same
> problems with "find" - just not as uniformly (mounting with "-o noac"
> makes them uniform).
>

I don't understand why we would need to talk about NFSv3.
This btrfs export issue has been with us for a while.
I see no reason to address it for old protocols if we can address
it with a new protocol with better support for the concept of fsid hierarchy.

> For NFSv4, we need to provide a "mounted-on" fileid for any mountpoint.
> btrfs doesn't have a mounted-on fileid that can be used.  We can fake
> something that might work reasonably well - but it would be fake.  (but
> then ... btrfs already provided bogus information in getdents when there
> is a subvol root in the directory).
>

That seems easy to solve by passing some flag to ->encode_fh()
or if the behavior is persistent in btrfs by some mkfs/module/mount option
then btrfs_encode_fh() will always encode the subvol root inode as
resident of the parent tree-id, because nfsd anyway does not ->encode_fh()
for export roots, right?

> But these are relatively minor.  The bigger problem is /proc/mounts.  If
> btrfs maintainers were willing to have every active subvolume appear in
> /proc/mounts, then I would be happy to fiddle the NFS fsid and allow
> every active NFS/btrfs subvolume to appear in /proc/mounts on the NFS
> client.  But they aren't.  So I am not.
>

I don't understand why you need to tie the two together.
I would suggest:
1. Export different fsid's per subvols to NFSv4 based on statx()
exported tree-id
2. NFS client side uses user configuration to determine which subvols
to auto-mount
3. [optional] Provide a way to configure btrfs using mkfs/module/mount option
    to behave locally the same as the NFS client, which will allow
user configuration
    to determine with subvols to auto-mount locally

I admit that my understanding of the full picture is limited, but I don't
understand why #3 is a strict dependency for #1 and #2.

> > > And I really don't see how an nfs export option would help...  Different
> > > people within and organisation and using the same export might have
> > > different expectations.
> >
> > That's true.
> > But if admin decides to export a specific btrfs mount as a non-unified
> > filesystem, then NFS clients can decide whether ot not to auto-mount the
> > exported subvolumes and different users on the client machine can decide
> > if they want to rsync or rsync --one-file-system, just as they would with
> > local btrfs.
> >
> > And maybe I am wrong, but I don't see how the decision on whether to
> > export a non-unified btrfs can be made a btrfs option or a nfsd global
> > option, that's why I ended up with export option.
>
> Just because a btrfs option and global nfsd option are bad, that doesn't
> mean an export option must be good.  It needs to be presented and
> defended on its own merits.
>
> My current opinion (and I must admit I am feeling rather jaded about the
> whole thing), is that while btrfs is a very interesting and valuable
> experiment in fs design, it contains core mistakes that cannot be
> incrementally fixed.  It should be marked as legacy with all current
> behaviour declared as intentional and not subject to change.  This would
> make way for a new "betrfs" which was designed based on all that we have
> learned.  It would use the same code base, but present a more coherent
> interface.  Exactly what that interface would be has yet to be decided,
> but we would not be bound to maintain anything just because btrfs
> supports it.
>

There is no need for a new driver name (like ext3=>ext4)
Both ext4 and xfs have features that can be determined in mkfs time.
This user experience change does not involve on-disk format changes,
so it is a much easier case, because at least technically, there is nothing
preventing an administrator from turning the user experience feature
on and off with proper care of the consequences.

Which brings me to another point.
This discussion presents several technical challenges and you have
been very creative in presenting technical solutions, but I think that
the nature of the problem is more on the administrative side.

I see this as an unfortunate flaw in our design process, when
filesystem developers have long discussions about issues where
some of the material stakeholders (i.e. administrators) are not in the loop.
But I do not have very good ideas on how to address this flaw.

Thanks,
Amir.
