Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B243DB2FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhG3FyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbhG3FyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:54:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08DC061765;
        Thu, 29 Jul 2021 22:54:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 185so10059749iou.10;
        Thu, 29 Jul 2021 22:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q4qU9xSHNkjJ5OcNfnUzZC+k2SqdMvWGQ3cVqENWg+M=;
        b=dO3wljk1s++Hf22rkfvSx9ZYE3MN5Mtcv4n3lgqTL7F0VSjqGTyHJQVTz2Ele7pWsS
         /xftWTyy1oW1IRm1g9YLcSLJ0j7tykIlayIiE/zwuVmL2IuNLGJQIs9bh9f/MkF2/vYr
         fRppSpNOsy35LQk5QAUNLqE2IF88t8PBPX6S7pYBrOpZRO0+2bClNAIKNBgSf5GZ/Ob8
         yc0+X8UXICo2wMfJIf4Rwvo8xVIH5cKJeXLStSQj/nl19ygreqlIxucRkBaPN60iVwJl
         vQg6OSNFs4URjeHJHDqLlORtrBKw4UHOOy5fOIFZqatfan70rhMU8IUHShs0CIHSjvYW
         PSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q4qU9xSHNkjJ5OcNfnUzZC+k2SqdMvWGQ3cVqENWg+M=;
        b=TyqAG4bzL6TpBPNZmCB5kNIiwT+hV+QynD/WSXcvMimqRjjubTAVfZQ5FQhCZ1EwYV
         76UNFqyxvbVX9awDl8QX6vqJUjX2/jLJqRH0V4JiyrySN1EcJZ9GCF4Y/TOefP828zhq
         gMNZZByBUt8xhc+5YCc6dXjVLiVwcYRe/oABS+48HVLbUuSChsiG2aE7fvvhL9zvM75+
         kHJ1Awi43grbPJAhSBGRV0tzop4bwm2bmKiSV4jzT5yjYgMZAYIeC9MtXrZ1t5uTvhJP
         ZmQg2x5q2AaP+xt98vunl3aFt3LBGTl35zNWRG+8tpg7xXgxjDUy2XHhFyMexDJ6G555
         xv0A==
X-Gm-Message-State: AOAM533I2PZ+21/DpNV8s8AFmu3SCNeQVZIYgbsiMx6Nkujk1KfBlFW2
        wyyyDRhXUKNHqsLkkPsG+d+52Bq/ME7GCtIJ4QI=
X-Google-Smtp-Source: ABdhPJwt5bqFq+eUjmoToEspcOh42SUfLj9pABKR9lO+IYUqEDQInu+MroEUZgZxkM85JA9C4RsO5T1ce0ik2ptnyso=
X-Received: by 2002:a02:908a:: with SMTP id x10mr774688jaf.30.1627624447209;
 Thu, 29 Jul 2021 22:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com> <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org> <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org> <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com> <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
In-Reply-To: <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jul 2021 08:53:56 +0300
Message-ID: <CAOQ4uxjFkvj9eqhNANEeYm22nqf=-wiCCMeZAgY55WQ0Fij-aw@mail.gmail.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     NeilBrown <neilb@suse.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 8:33 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/7/30 =E4=B8=8B=E5=8D=881:25, Qu Wenruo wrote:
> >
> >
> > On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
> >>
> >> I've been pondering all the excellent feedback, and what I have learnt
> >> from examining the code in btrfs, and I have developed a different
> >> perspective.
> >
> > Great! Some new developers into the btrfs realm!
> >
> >>
> >> Maybe "subvol" is a poor choice of name because it conjures up
> >> connections with the Volumes in LVM, and btrfs subvols are very differ=
ent
> >> things.  Btrfs subvols are really just subtrees that can be treated as=
 a
> >> unit for operations like "clone" or "destroy".
> >>
> >> As such, they don't really deserve separate st_dev numbers.
> >>
> >> Maybe the different st_dev numbers were introduced as a "cheap" way to
> >> extend to size of the inode-number space.  Like many "cheap" things, i=
t
> >> has hidden costs.
>
> Forgot another problem already caused by this st_dev method.
>
> Since btrfs uses st_dev to distinguish them its inode name space, and
> st_dev is allocated using anonymous bdev, and the anonymous bdev poor
> has limited size (much smaller than btrfs subvolume id name space), it's
> already causing problems like we can't allocate enough anonymous bdev
> for each subvolume, and failed to create subvolume/snapshot.
>

How about creating a major dev for btrfs subvolumes to start with.
Then at least there is a possibility for administrative reservation of
st_dev values for subvols that need persistent <st_dev;st_ino>

By default subvols get assigned a minor dynamically as today
and with opt-in (e.g. for small short lived btrfs filesystems), the
unified st_dev approach can be used, possibly by providing
an upper limit to the inode numbers on the filesystem, similar to
xfs -o inode32 mount option.

Thanks,
Amir.
