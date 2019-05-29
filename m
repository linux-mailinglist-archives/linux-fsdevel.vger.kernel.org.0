Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A42D522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 07:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2FjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 01:39:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45716 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfE2FjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 01:39:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id e128so327076ybc.12;
        Tue, 28 May 2019 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXawYOoYL3iVXFsDCoGpoazEsaewREIFtZ87X0NznBo=;
        b=UOFBRy2khHWgEKicbD1a2E+aZAQGkNify5UGBgYZa3y+sdQzXJ3Yyi0HX5hO4Da8PQ
         2APyB3WrMNTWjkYSDhODjmiUNivOY8ESI5ydrxy4WLkFlIjpbpE0YPS1xUYgn+8tg+Tz
         +3cZtZRoTU9CwJ2Vt4N2xIpXHAqBvj8F9UDfT3DD+Fk6fX4xIvKyIco2JcWai3rc2nGp
         poXBKSbQ4oJ8FsFlGv5Pv+xScvrn6QEJEAcQHlmV0Y0bIqmpZw8nOHRf2SG+GoFkotNf
         RjpVGrsOGEXAnFqIgIiOlqEF0rhZ3D1gIMnocfEDPk0lW6h/lNhrAuBBRKBQhHMuv9Wu
         T1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXawYOoYL3iVXFsDCoGpoazEsaewREIFtZ87X0NznBo=;
        b=dusDDpiTB6sQOPQ0jg8S/K3C/7NAVnJkBdx0ygZmMiSIVkkMPvSME6E4bxMtCFS9ir
         J3UT8/4cSf1WnIIOl1BFEqHfUGlTX4oDmTkO42RyJ+TFrFpu4tzyFeNMA4Sv+C53aL2w
         CLEomFpU5gSTKQrrSC5+jmrT9n43EFC9X6F6YlivO9Ts6Dknc2W9KhpfzFQ7EG5mL0yX
         DOMBlD43sWEkhTDBktjGCIMP3x1jGX9081oxjl8catjNAXwsh8I30tGsKr4chIx87Jz8
         VkHBTX/+k7UBdJOd/k0/iFOfabpaLbxqokIBz/hQ6qwDbbKpRsouDUgSQ5rkAJkygTF0
         Q8Cg==
X-Gm-Message-State: APjAAAWog2cToNaA899H1orSWdBiCyq1IkLPGsfQqXaAIfOG9SRgXg3a
        19rzQkeNLfzDg8yuVCrY50NvOIl2gQuM/B3DIoY=
X-Google-Smtp-Source: APXvYqxedQWc5ndnnoOxgtJO+TWkV1HPjz/HUq1qcE4fouHr3mtFf6yvJ3r27cgAVJe+Bai7FhvdiKsNYVjx8IGuwXs=
X-Received: by 2002:a25:d946:: with SMTP id q67mr3637755ybg.126.1559108340796;
 Tue, 28 May 2019 22:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190527172655.9287-1-amir73il@gmail.com> <20190528202659.GA12412@mit.edu>
In-Reply-To: <20190528202659.GA12412@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 08:38:49 +0300
Message-ID: <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 11:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, May 27, 2019 at 08:26:55PM +0300, Amir Goldstein wrote:
> >
> > Following our discussions on LSF/MM and beyond [1][2], here is
> > an RFC documentation patch.
> >
> > Ted, I know we discussed limiting the API for linking an O_TMPFILE
> > to avert the hardlinks issue, but I decided it would be better to
> > document the hardlinks non-guaranty instead. This will allow me to
> > replicate the same semantics and documentation to renameat(2).
> > Let me know how that works out for you.
> >
> > I also decided to try out two separate flags for data and metadata.
> > I do not find any of those flags very useful without the other, but
> > documenting them seprately was easier, because of the fsync/fdatasync
> > reference.  In the end, we are trying to solve a social engineering
> > problem, so this is the least confusing way I could think of to describe
> > the new API.
>
> The way you have stated thigs is very confusing, and prone to be
> misunderstood.  I think it would be helpful to state things in the
> positive, instead of the negative.
>
> Let's review what you had wanted:
>
>         *If* the filename is visible in the directory after the crash,
>         *then* all of the metadata/data that had been written to the file
>         before the linkat(2) would be visible.
>
>         HOWEVER, you did not want to necessarily force an fsync(2) in
>         order to provide that guarantee.  That is, the filename would
>         not necessarily be guaranteed to be visible after a crash when
>         linkat(2) returns, but if the existence of the filename is
>         persisted, then the data would be too.
>
>         Also, at least initially we talked about this only making
>         sense for O_TMPFILE file desacriptors.  I believe you were
>         trying to generalize things so it wouldn't necessarily have to
>         be a file created using O_TMPFILE.  Is that correct?

That is correct. I felt we were limiting ourselves only to avert the
hardlinks issue, so decided its better to explain that "nlink is not
part of the inode metadata" that this guarantee refers to.
I would be happy to get your feedback about the hardlink disclaimer
since you brought up the concern. It the disclaimer enough?
Not needed at all?

>
> So instead of saying "A filesystem that accepts this flag will
> guaranty, that old inode data will not be exposed in the new linked
> name."  It's much clearer to state this in the affirmative:
>
>         A filesystem which accepts this flag will guarantee that if
>         the new pathname exists after a crash, all of the data written
>         to the file at the time of the linkat(2) call will be visible.
>

Sounds good to me. I will take a swing at another patch.

Thanks for the review!
Amir.
