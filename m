Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBDE180
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfD2Lm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 07:42:56 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38234 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfD2Lm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:42:56 -0400
Received: by mail-yw1-f65.google.com with SMTP id i66so3569785ywe.5;
        Mon, 29 Apr 2019 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzauFw6w0jze6Zvx9vbWzqf2lqom9V1OA6Wn+IY4d7Q=;
        b=dgfX/DB3PdboFrMNsjs01iBXLBRM2A0Iyc7upyXk5NsA/IMBwYX1omjAuNEpRUMgq2
         JABamiKitXksL8KQUUl78WCYnR3D0PIk9Bgb40s/Gq+MSms4ChNcSMB11pOvtBSrvz/S
         JWFQrwTN2RORgmTuA8DN05sXrQr2LPf+OUXuTVRIOXoMV8x56nvJ/vxayE3T21mRTU+B
         z5i6BVtT8V3cKBi9qCrOgh2hgUXLb+uE1gM5ICETWSZQ1nc8G6cbYtvgy6AAs3oHU0nO
         +b9yeq1un/ak8IaWVfPkgrPerzkp6C2cWMgtXYIUsBTm5GcIyXuoVM40nE6R5PbxzE01
         V0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzauFw6w0jze6Zvx9vbWzqf2lqom9V1OA6Wn+IY4d7Q=;
        b=CtdslLt0ZNrQ+Op7mrDks8w7trDXgpHc2k7iMsRYwGItxbxkkUUN6PQU1Y2QCm6GYh
         z+Zxhn6MuQAMU4Uuj+gyW8fj7k8HHzhD0W3B1MxOCE8H+hbe81ibr2yE7wMmMLIy9kFB
         zmyKRxg+4cq2KzqdGCpiv9TGlgpqn98Besu+bznIV1UfmpEWNZs1Sv4r2QTA/fr1lyQ4
         JxPUdFkEKprwZ+rNIHU9kMZ0R9cQgD/bGJ5SeNOOXu3lZle6FeA2WBiWNvYMrTjrFhw1
         YsNzaGWhnbIK3LQ9vC0h6xLUqI9fsoCJst1mwNxMUlwoRf+9pvmdquPSWFmA3XUC86gX
         bR6w==
X-Gm-Message-State: APjAAAXUEm62iWrpRPH5wct5qvvpY+u+hC4HgmmAxgY8JF6s55hbrPh3
        3yicMMEVAzw27qHO1j0QgfrRJb7MwLtTsQexScw=
X-Google-Smtp-Source: APXvYqzu0AEe+PuaZFACZgj15Xf/EZndsrVuIoaAss5XZYLk2avgfY0QbCAKwbPLd7cllSm6a5hE9GbsWTFZaSCn2N8=
X-Received: by 2002:a81:3bc5:: with SMTP id i188mr50893879ywa.404.1556538175054;
 Mon, 29 Apr 2019 04:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
 <379106947f859bdf5db4c6f9c4ab8c44f7423c08.camel@kernel.org>
 <CAOQ4uxgewN=j3ju5MSowEvwhK1HqKG3n1hBRUQTi1W5asaO1dQ@mail.gmail.com>
 <930108f76b89c93b2f1847003d9e060f09ba1a17.camel@kernel.org>
 <CAOQ4uxgQsRaEOxz1aYzP1_1fzRpQbOm2-wuzG=ABAphPB=7Mxg@mail.gmail.com>
 <20190426140023.GB25827@fieldses.org> <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
 <20190426145006.GD25827@fieldses.org> <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
 <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
 <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
 <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
 <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
 <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
 <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
 <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com> <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
In-Reply-To: <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 29 Apr 2019 07:42:43 -0400
Message-ID: <CAOQ4uxhkXt-71=CDwWEz0axqKi_TsEj3S_dgDhXkwNmG57T61Q@mail.gmail.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "pshilov@microsoft.com" <pshilov@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 8:57 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sun, 2019-04-28 at 18:33 -0400, Amir Goldstein wrote:
> > On Sun, Apr 28, 2019 at 6:08 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Sun, 2019-04-28 at 18:00 -0400, Amir Goldstein wrote:
> > > > On Sun, Apr 28, 2019 at 11:06 AM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > > On Sun, 2019-04-28 at 09:45 -0400, Amir Goldstein wrote:
> > > > > > On Sun, Apr 28, 2019 at 8:09 AM Jeff Layton <
> > > > > > jlayton@kernel.org>
> > > > > > wrote:
> > > > > > > On Sat, 2019-04-27 at 16:16 -0400, Amir Goldstein wrote:
> > > > > > > > [adding back samba/nfs and fsdevel]
> > > > > > > >
> > > > > > >
> > > > > > > cc'ing Pavel too -- he did a bunch of work in this area a
> > > > > > > few
> > > > > > > years
> > > > > > > ago.
> > > > > > >
> > > > > > > > On Fri, Apr 26, 2019 at 6:22 PM Jeff Layton <
> > > > > > > > jlayton@kernel.org>
> > > > > > > > wrote:
> > > > > > > > > On Fri, 2019-04-26 at 10:50 -0400, J. Bruce Fields
> > > > > > > > > wrote:
> > > > > > > > > > On Fri, Apr 26, 2019 at 04:11:00PM +0200, Amir
> > > > > > > > > > Goldstein
> > > > > > > > > > wrote:
> > > > > > > > > > > On Fri, Apr 26, 2019, 4:00 PM J. Bruce Fields <
> > > > > > > > > > > bfields@fieldses.org> wrote:
> > > > > > > > > > >
> > > > > > > > > That said, we could also look at a vfs-level mount
> > > > > > > > > option
> > > > > > > > > that
> > > > > > > > > would
> > > > > > > > > make the kernel enforce these for any opener. That
> > > > > > > > > could
> > > > > > > > > also
> > > > > > > > > be useful,
> > > > > > > > > and shouldn't be too hard to implement. Maybe even make
> > > > > > > > > it
> > > > > > > > > a
> > > > > > > > > vfsmount-
> > > > > > > > > level option (like -o ro is).
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yeh, I am humbly going to leave this struggle to someone
> > > > > > > > else.
> > > > > > > > Not important enough IMO and completely independent
> > > > > > > > effort to
> > > > > > > > the
> > > > > > > > advisory atomic open&lock API.
> > > > > > >
> > > > > > > Having the kernel allow setting deny modes on any open call
> > > > > > > is
> > > > > > > a
> > > > > > > non-
> > > > > > > starter, for the reasons Bruce outlined earlier. This
> > > > > > > _must_ be
> > > > > > > restricted in some fashion or we'll be opening up a
> > > > > > > ginormous
> > > > > > > DoS
> > > > > > > mechanism.
> > > > > > >
> > > > > > > My proposal was to make this only be enforced by
> > > > > > > applications
> > > > > > > that
> > > > > > > explicitly opt-in by setting O_SH*/O_EX* flags. It wouldn't
> > > > > > > be
> > > > > > > too
> > > > > > > difficult to also allow them to be enforced on a per-fs
> > > > > > > basis
> > > > > > > via
> > > > > > > mount
> > > > > > > option or something. Maybe we could expand the meaning of
> > > > > > > '-o
> > > > > > > mand'
> > > > > > > ?
> > > > > > >
> > > > > > > How would you propose that we restrict this?
> > > > > > >
> > > > > >
> > > > > > Our communication channel is broken.
> > > > > > I did not intend to propose any implicit locking.
> > > > > > If samba and nfsd can opt-in with O_SHARE flags, I do not
> > > > > > understand why a mount option is helpful for the cause of
> > > > > > samba/nfsd interop.
> > > > > >
> > > > > > If someone else is interested in samba/local interop than
> > > > > > yes, a mount option like suggested by Pavel could be a good
> > > > > > option,
> > > > > > but it is an orthogonal effort IMO.
> > > > >
> > > > > If an NFS client 'opts in' to set share deny, then that still
> > > > > makes
> > > > > it
> > > > > a non-optional lock for the other NFS clients, because all
> > > > > ordinary
> > > > > open() calls will be gated by the server whether or not their
> > > > > application specifies the O_SHARE flag. There is no flag in the
> > > > > NFS
> > > > > protocol that could tell the server to ignore deny modes.
> > > > >
> > > > > IOW: it would suffice for 1 client to use O_SHARE|O_DENY* to
> > > > > opt
> > > > > all
> > > > > the other clients in.
> > > > >
> > > >
> > > > Sorry for being thick, I don't understand if we are in agreement
> > > > or
> > > > not.
> > > >
> > > > My understanding is that the network file server implementations
> > > > (i.e. samba, knfds, Ganesha) will always use share/deny modes.
> > > > So for example nfs v3 opens will always use O_DENY_NONE
> > > > in order to have correct interop with samba and nfs v4.
> > > >
> > > > If I am misunderstanding something, please enlighten me.
> > > > If there is a reason why mount option is needed for the sole
> > > > purpose
> > > > of interop between network filesystem servers, please enlighten
> > > > me.
> > > >
> > > >
> > >
> > > Same difference. As long as nfsd and/or Ganesha are translating
> > > OPEN4_SHARE_ACCESS_READ and OPEN4_SHARE_ACCESS_WRITE into share
> > > access
> > > locks, then those will conflict with any deny locks set by whatever
> > > application that uses them.
> > >
> > > IOW: any open(O_RDONLY) and open(O_RDWR) will conflict with an
> > > O_DENY_READ that is set on the server, and any open(O_WRONLY) and
> > > open(O_RDWR) will conflict with an O_DENY_WRITE that is set on the
> > > server. There is no opt-out for NFS clients on this issue, because
> > > stateful NFSv4 opens MUST set one or more of
> > > OPEN4_SHARE_ACCESS_READ
> > > and OPEN4_SHARE_ACCESS_WRITE.
> > >
> >
> > Urgh! I *think* I understand the confusion.
> >
> > I believe Jeff was talking about implementing a mount option
> > similar to -o mand for local fs on the server.
> > With that mount option, *any* open() by any app of file from
> > that mount will use O_DENY_NONE to interop correctly with
> > network servers that explicitly opt-in for interop on share modes.
> > I agree its a nice feature that is easy to implement - not important
> > for first version IMO.
> >
> > I *think* you are talking on nfs client mount option for
> > opt-in/out of share modes? there was no such intention.
> >
>
> No. I'm saying that whether you intended to or not, you _are_
> implementing a mandatory lock over NFS. No talk about O_SHARE flags and
> it being an opt-in process for local applications changes the fact that
> non-local applications (i.e. the ones that count ) are being subjected
> to a mandatory lock with all the potential for denial of service that
> implies.
> So we need a mechanism beyond O_SHARE in order to ensure this system
> cannot be used on sensitive files that need to be accessible to all. It
> could be an export option, or a mount option, or it could be a more
> specific mechanism (e.g. the setgid with no execute mode bit as using
> in POSIX mandatory locks).
>

I see. Thanks for making that concern clear.

If server owner wishes to have samba/nfs interop obviously
server owner should configure both samba and nfs for interop.
nfs should thus have it configurable via export options IMO
and not via mount option (server's responsibility).

Preventing O_DENY_X on a certain file... hmm
We can do that but, if nfs protocol has O_DENY what's the
logic that we would want to override it?
What we need is a way to track, blame the resource holder and
release the resource administratively.

For that matter, assuming the nfsd and smbd (etc) can contain
their own fds without leaking them to other modules (minus bugs)
then provided with sufficient sysfs/procfs info (i.e. Bruce's new open
files tracking), admin should be able to kill the offending nfs/smb client
to release the hogged file.

I believe that is the Windows server solution to the DoS that is implied
from O_DENY.

Thanks,
Amir.
