Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A93E24C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbhHFIIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhHFIIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:08:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07729C061798;
        Fri,  6 Aug 2021 01:08:36 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c3so7961632ilh.3;
        Fri, 06 Aug 2021 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2iJjJFlry6ovGIgHXp8jdUKenmn9J5pRKg6h9IJBLE=;
        b=QppjZKuw1aICGs/ZKOPmXanV4OJyMgg6oZLmrMF5DHQMbge1xiVbFCfktXZddUZV/N
         UCxGvWkL+cEVux4C4+jPiyB5jvHCNoOmOSOBlHZO3u8pcGDHLH3g/6kZbGboouH1o7/I
         kqd/49zQexQmjrAzZG4VBgYNjJAw8yDoAMcTskZwYA+LQsmDnmMQ1zWhXjce5HTtvL4M
         1sjsnwp/rWwZPa3hnAXVU9REf5VZ92laZ5yjesP+8FwK+Gbejl49dhAYGl6zkwOBIspG
         tUp+szq/hMUsPq4D3iyZmH9Z5eO7LJHYxNTAi9ATdGVYeXHnzn0UULeY1xfA6aFZFDid
         C4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2iJjJFlry6ovGIgHXp8jdUKenmn9J5pRKg6h9IJBLE=;
        b=gMz/1ggry7smRb2uLeXvKrroY/soEx9XsHUxnYZ7WII+MP5otNkJP0z/gj8MScfdrL
         Qm0MO5uEDIm3fkweQgnKaazEI/7xXoT4cKbsw/gK3WMDo/75OulS51cM4cQQkf7GdZmg
         vgACAZER+ZEv5TUEyUOdHoW8jzGy6QUnxu5WoMN78NgJzKR3nKwzwPikQcQMwcNcVugi
         EtDKnIlLwuKhvxkYtdqBqqbIH9UTPxiRT2rIjvg1ZL3/eD9lI+PnPlITJponS9ICBnaZ
         uaDPMpMhPcY59jrQrQGcrltH5vcZBFbY69vzv50Dr2LjBwvfmVsSNBqzJ/XtpmUEWXyJ
         c+aQ==
X-Gm-Message-State: AOAM532umVd+Pz5EobUCeCRmVerWaet3xZjydMtGwvDF8pRSdkU1aEBQ
        pcbFyJnDGI9nYJanrS88oMCce8LkiS0fysuM1c8=
X-Google-Smtp-Source: ABdhPJzHyXbHZoWrAqDqGnDAlixxnNs6YfY//vUKy+VouysXVfonSE5WTUmijueoWBlEVcU9fTr14Si/Wox+e69rSeY=
X-Received: by 2002:a92:c94f:: with SMTP id i15mr21326ilq.72.1628237315091;
 Fri, 06 Aug 2021 01:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
 <162751852209.21659.13294658501847453542@noble.neil.brown.name>
 <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com> <CAJfpeguoMjCvLpKHgtQmNFk4UsHdyLsWK4bvsv6YJ52uZ=+9gg@mail.gmail.com>
In-Reply-To: <CAJfpeguoMjCvLpKHgtQmNFk4UsHdyLsWK4bvsv6YJ52uZ=+9gg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 Aug 2021 11:08:23 +0300
Message-ID: <CAOQ4uxiAcqXYNhG9ZGU4=7oY9idEwa9FND-VVdLgGO2RoXr6qg@mail.gmail.com>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 6, 2021 at 10:52 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 29 Jul 2021 at 07:27, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Given that today, subvolume mounts (or any mounts) on the lower layer
> > are not followed by overlayfs, I don't really see the difference
> > if mounts are created manually or automatically.
> > Miklos?
>
> Never tried overlay on btrfs.  Subvolumes AFAIK do not use submounts
> currently, they are a sort of hack where the st_dev changes when
> crossing the subvolume boundary, but there's no sign of them in
> /proc/mounts (there's no d_automount in btrfs).

That's what Niel's patch 11/11 is proposing to add and that's the reason
he was asking if this is going to break overlayfs over btrfs.

My question was, regardless of btrfs, can ovl_lookup() treat automount
dentries gracefully as empty dirs or just read them as is, instead of
returning EREMOTE on lookup?

The rationale is that we use a private mount and we are not following
across mounts from layers anyway, so what do we care about
auto or manual mounts?

Thanks,
Amir.
