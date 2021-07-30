Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5339E3DB2C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhG3F2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhG3F2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:28:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50873C061765;
        Thu, 29 Jul 2021 22:28:17 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x7so4877297ilh.10;
        Thu, 29 Jul 2021 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BL70il6j4B/RKCGLXufodhVZi7V6X0RKO/zcq4BIb7o=;
        b=UmELttU7zjWxbEyOwswjsReYDqzKBVfmhteZYII00y+ViYN/5jETN0rzGmvYiVGdLS
         56EjiqzZZqXm77M0cXs+/MspcK0VJQHXNTFjqarF9k/Gixe+JNUORX/dnTVgjq32uw4U
         4wuMN+utJfrJyGqKUP4KLUKgFIBpn9bsNE9NO2Rz4E9qFhDR9O09+pYksi6fwgL7isY6
         6txmVqJJ3EfGkR/G9nqiTuH62YDCm1uyILDFIAtAb5sR5jIxOdJg2xd/RaXW43zFCag+
         LDRudEGrfr1WxkzxIDScqaCfQLfAwVzGZ6J1B81TJ+mglTz48VwbjTqcJXpHYImS+oO1
         z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BL70il6j4B/RKCGLXufodhVZi7V6X0RKO/zcq4BIb7o=;
        b=uPF8/HdaNUnlXYuyDtYcUCOkWfOT7IXczRVPhYm4BT7QH+xNv7OXbXZ7nNCJD8F6Pm
         H2cdH1s2d6B85f6kkr4KS1qjiIyhtcfWMzVHCk6Upl8jjxNogMdKrDa1ynY35BW2AZzR
         k93J1ow7ZzM05iu9xtaIeMQDkiCOqTb8yjLRWR82w1VpB8H80jkR/1L3FS1A3CtxsDfH
         HJbKw8O/9VjnT5t9uokkD0CwS9jdfCIj0LWq6NylwSqlQfVSm0KfWpcHAnIBtpaa9l/w
         klFrCeSgw4Fb+73TaWJZ+Yy+Vowg7amgfmnoTjkzZ9RrZS7MeNbjemE0YRs3A0d2cKfc
         EEOw==
X-Gm-Message-State: AOAM530q4PjomztDUx3hThkC0KQLu/wrpdLk1N+Pnv3D692aDH1hD/Ti
        16/0Bburlraz/zANNa0E92J7CsCS1aghIhdj5N8=
X-Google-Smtp-Source: ABdhPJy6CmNy0cYP+7xqjZt3gHAyv1wkwHzpaz1L/VnrtIWrkMtS7fXekRj3UlHoYTScCh+DjP4+H70fz2Lh3W1DcYU=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr265569ilh.137.1627622896751;
 Thu, 29 Jul 2021 22:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com> <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org> <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org> <162761259105.21659.4838403432058511846@noble.neil.brown.name>
In-Reply-To: <162761259105.21659.4838403432058511846@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jul 2021 08:28:05 +0300
Message-ID: <CAOQ4uxiZW6jXUb7iLhfaMJ-OS2PigL-dRrfQ5AB3QkLmoJu=jg@mail.gmail.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     NeilBrown <neilb@suse.de>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 5:41 AM NeilBrown <neilb@suse.de> wrote:
>
>
> I've been pondering all the excellent feedback, and what I have learnt
> from examining the code in btrfs, and I have developed a different
> perspective.
>
> Maybe "subvol" is a poor choice of name because it conjures up
> connections with the Volumes in LVM, and btrfs subvols are very different
> things.  Btrfs subvols are really just subtrees that can be treated as a
> unit for operations like "clone" or "destroy".
>
> As such, they don't really deserve separate st_dev numbers.
>
> Maybe the different st_dev numbers were introduced as a "cheap" way to
> extend to size of the inode-number space.  Like many "cheap" things, it
> has hidden costs.
>
> Maybe objects in different subvols should still be given different inode
> numbers.  This would be problematic on 32bit systems, but much less so on
> 64bit systems.
>
> The patch below, which is just a proof-of-concept, changes btrfs to
> report a uniform st_dev, and different (64bit) st_ino in different subvols.
>
> It has problems:
>  - it will break any 32bit readdir and 32bit stat.  I don't know how big
>    a problem that is these days (ino_t in the kernel is "unsigned long",
>    not "unsigned long long). That surprised me).
>  - It might break some user-space expectations.  One thing I have learnt
>    is not to make any assumption about what other people might expect.
>
> However, it would be quite easy to make this opt-in (or opt-out) with a
> mount option, so that people who need the current inode numbers and will
> accept the current breakage can keep working.
>
> I think this approach would be a net-win for NFS export, whether BTRFS
> supports it directly or not.  I might post a patch which modifies NFS to
> intuit improved inode numbers for btrfsdemostrates exports....
>
> So: how would this break your use-case??

The simple cases are find -xdev and du -x which expect the st_dev
change, but that can be excused if opting in to a unified st_dev namespace.

The harder problem is <st_dev;st_ino> collisions which are not even
that hard to hit with unlimited number of snapshots.
The 'diff' tool demonstrates the implications of <st_dev;st_ino>
collisions for different objects on userspace.
See xfstest overlay/049 for a demonstration.

The overlayfs xino feature made a similar change to overlayfs
<st_dev;st_ino> with one big difference - applications expect that
all objects in overlayfs mount will have the same st_dev.

Also, overlayfs has prior knowledge on the number of layers
so it is easier to parcel the ino namespace and avoid collisions.

Thanks,
Amir.
