Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87A4439EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfFMPRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:17:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55380 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbfFMNWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:22:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so10179881wmj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wuAK6EQ80PyDNnpIyEX4qP2XC/coEnhgovta7yfYWxY=;
        b=JMQ0l3NrX2S5rxk2gqdSAV86GVbkXTUcGPYAfocG6ziyl8sqM3X+SMNxQgaJ7/z2U5
         HJ4eyfVwdzmcB0Zb1Y1LC+S5FHiMrDv9M1bCkfwvadnhM5bHTiVz3TpWvQc0LwHv14Bg
         EaXkN7lOTGprcoVn6/xbN8yMBrS2n60nsukmJN/V6yw78xXOI/PjvhfZRKH6E0vgUR91
         feM1JDdZdSetkpv4okXsDVJL2RxQkpL5Frr7VMsmNVAfI3iJCf5GlflsDSQv+1i5VPXO
         4SvN2fm0I6lD8JtK5KrWSuUpCZ4R1A0ZwKaMBsKzvg9ZqXYmaPdBL3YqRQwlfvRmO3Sa
         Q9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wuAK6EQ80PyDNnpIyEX4qP2XC/coEnhgovta7yfYWxY=;
        b=IjUJOESWuWe8k3BDx3wY8euqKyVx5Be0NGPgD+0pZwhubh0cEPLQEgjfSlK57d43ke
         r3uoj7lNvcdUuXeuuKDkIbl2nSF4TuVTt7ts3O2i58sCBbmHT7zq52QoPegAcSj5FCyu
         WPL//FxxfPf/SIbhqdZ51pJnpx4lGrYwdpbrA67SPJBDTeBeDTNKZaeua0rOWARC1Fj7
         l6ip/i0Klwt0hguBw+Sg3x5y+JNbHpQ0/Qc/sWLkHAipugz24D8Ht7PLZlexH/xp+Oel
         ADRUSargXGxT6YDcLyokQ12utmxfxPWj+M0sPyFdDL1g04g3YqPbVFfTG+v8HoUTlov+
         iqmw==
X-Gm-Message-State: APjAAAV3DvJOVOtsvKRmV9wER9gq1A+J4GsaSpC9J8FXygsTbTdldyKc
        Wy4644qePeaR+IPJOQvwt7gGRA==
X-Google-Smtp-Source: APXvYqwuKiRsCndV/u776Jp+G0a5brq9AKUHpU7KLSBoUmn9cPWSRkTi7WUGMxVnxHSrjc8P5HbdIg==
X-Received: by 2002:a1c:f519:: with SMTP id t25mr3944137wmh.58.1560432173272;
        Thu, 13 Jun 2019 06:22:53 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f3sm2842924wre.93.2019.06.13.06.22.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:22:52 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:22:51 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
Message-ID: <20190613132250.u65yawzvf4voifea@brauner.io>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
 <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > The commit changes the internal logic to lock mounts when propagating
> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> > to fail at:
> 
> You mean 'do_move_mount()'.
> 
> > if (old->mnt.mnt_flags & MNT_LOCKED)
> >         goto out;
> >
> > If that's indeed the case we should either revert this commit (reverts
> > cleanly, just tested it) or find a fix.
> 
> Hmm.. I'm not entirely sure of the logic here, and just looking at
> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
> cross-userns copies") doesn't make me go "Ahh" either.
> 
> Al? My gut feel is that we need to just revert, since this was in 5.1
> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
> don't be silly, this is easily fixed with this one-liner".

David and I have been staring at that code today for a while together.
I think I made some sense of it.
One thing we weren't absolutely sure is if the old MS_MOVE behavior was
intentional or a bug. If it is a bug we have a problem since we quite
heavily rely on this...

So this whole cross-user+mnt namespace propagation mechanism comes with
a big hammer that Eric indeed did introduce a while back which is
MNT_LOCKED (cf. [1] for the relevant commit).

Afaict, MNT_LOCKED is (among other cases) supposed to prevent a user+mnt
namespace pair to get access to a mount that is hidden underneath an
additional mount. Consider the following scenario:

sudo mount -t tmpfs tmpfs /mnt
sudo mount --make-rshared /mnt
sudo mount -t tmpfs tmpfs /mnt
sudo mount --make-rshared /mnt
unshare -U -m --map-root --propagation=unchanged

umount /mnt
# or
mount --move -mnt /opt

The last umount/MS_MOVE is supposed to fail since the mount is locked
with MNT_LOCKED since umounting or MS_MOVing the mount would reveal the
underlying mount which I didn't have access to prior to the creation of
my user+mnt namespace pair.
(Whether or not this is a reasonable security mechanism is a separate
discussion.)

But now consider the case where from the ancestor user+mnt namespace
pair I do:

# propagate the mount to the user+mount namespace pair                 
sudo mount -t tmpfs tmpfs /mnt
# switch to the child user+mnt namespace pair
umount /mnt
# or
mount --move /mnt /opt

That umount/MS_MOVE should work since that mount was propagated to the
unprivileged task after the user+mnt namespace pair was created.
Also, because I already had access to the underlying mount in the first
place and second because this is literally the only way - we know of -
to inject a mount cross mount namespaces and this is a must have feature
that quite a lot of users rely on.

Christian

[1]: git show 5ff9d8a65ce80efb509ce4e8051394e9ed2cd942
