Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0436269B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhDPRVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhDPRVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:21:42 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A4C061574;
        Fri, 16 Apr 2021 10:21:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o10so30906820ybb.10;
        Fri, 16 Apr 2021 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WF3sSavyL+cfz2JZUH7lkHKm10q746QRg9Iuzin7JZo=;
        b=h9C5mE6doFD5pdhyg8czFs1I3i/xXvVEtdWZnNXLO5+oR2u2qazaCwDL0LkFAA158F
         qz5UtCfmYVsKembJ4L5U6zPNnakZwFNyJfN7FAF4Kxot9IQ/WVAxER3TGyTdfVTxzQvC
         uCsRXzwVckHj8lk/axfGS4h5hIKKdK0p9UnX6PTMzkcWvQL2TIrGcXrKBbMv1Bo1fh7X
         GqfhR3KAZ11sGWkrJKSou726OQ1JxHLl52ijXyiCWMehgJvpKuP0s71OY4S0yQD0K5Nt
         BcALCXY/j5G+jWOZz/lpQLBL9ChbZXHHcJQwKSeWq2RjF25nu7x1JzenI1e/T/c0vQPz
         4kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WF3sSavyL+cfz2JZUH7lkHKm10q746QRg9Iuzin7JZo=;
        b=ezxulafjze0JA2ZLYIq5tuPLEdIeCo6Zcw53Xfd9l5LiPVEJPxdCnxpn1as78A9Rz6
         XmQceU6dX/D9rp/iVhcBr/e7CTETy/duKQP9M8GnMDLrOkHtSnifEMTvGI0Ncy/5bakx
         9MCFH91Hfz8ARRi4MUlw/HchU1WW2gXvh+77+KInFhLmGd6/ewTaT4LE0cZQEwhiy6A9
         CAg74Gdy5XcrCCQJ1iArk2Xba9tmUBjgQ3IueMFYW7SON2yuPth5BXnhUWjJn9EOpcwS
         vX1etm2CXPpMjoMo6o3AHWmgL5+d/77mghzF47u3AnQZoS2Pd2SXsZDk6JY3CN4jsyCG
         mCpg==
X-Gm-Message-State: AOAM530GMAkJN3oW6d3M+CFbDsfFSKF+Qhnakv8qmXT0VXe7T9v8BPoi
        lhSpe1muCtk8WSOonnb0vLkcadEwg8YgFw8FFQ4=
X-Google-Smtp-Source: ABdhPJyNBPyGIa65lH+SQj/B+50R7Q0d8jA8G6G8FeRhLRC2l5lUrubuk4Bu/vI4ioaKycQ6Y6L35AgxtZi9GH8Iw3c=
X-Received: by 2002:a25:3c01:: with SMTP id j1mr268320yba.176.1618593676373;
 Fri, 16 Apr 2021 10:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1408071538-14354-1-git-send-email-mcgrof@do-not-panic.com>
 <20140815092950.GZ18016@ZenIV.linux.org.uk> <c3b0feac-327c-15db-02c1-4a25639540e4@suse.com>
 <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
 <e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com> <20210415182909.GK4332@42.do-not-panic.com>
In-Reply-To: <20210415182909.GK4332@42.do-not-panic.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 16 Apr 2021 13:20:40 -0400
Message-ID: <CAEg-Je8UCV6kFdXJoyH3B78sraYCXscTmQQiPHjkPvzt5g1Wpw@mail.gmail.com>
Subject: Re: [RFC v3 0/2] vfs / btrfs: add support for ustat()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Apr 15, 2021 at 02:17:58PM -0400, Josef Bacik wrote:
> > There's a lot of larger things that need to
> > be addressed in general to support the volume approach inside file syst=
ems
> > that is going to require a lot of work inside of VFS.  If you feel like
> > tackling that work and then wiring up btrfs by all means have at it, bu=
t I'm
> > not seeing a urgent need to address this.  Thanks,
>
> That's precisely what I what I want to hear me about. Things like this.
> Would btrfs be the ony user of volumes inside filesystem? Jeff had
> mentioned before this could also allow namespaces per volumes, and this
> might be a desirable feature.
>
> What else?

Wouldn't this be useful for union filesystems like OverlayFS? Or other
filesystems that support nested filesystems like bcachefs?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
