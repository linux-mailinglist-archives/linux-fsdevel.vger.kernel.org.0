Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62499D991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD1WeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 18:34:05 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40108 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfD1WeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:34:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id q17so3155672ybg.7;
        Sun, 28 Apr 2019 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSbh5orQAOFlLCo4wlBuHnUgLykOnfmt1aJCPAp9m00=;
        b=fQFRy18f1VB/uXlU7I0pAMelkAfXuxItxT6MURFdCgvIe1xEpN1oyHkilGID/duvgp
         3vspSWnKdEedAVb4wezUxa7/VekRzVDG6SqyecILPqWAZDhMum7gc4uAD4rwv66HRjNu
         wJ/lLS4YBwB6PeMU8i0KHV1uSkWruCYL95PhVgJLgrj7oWOovtKRUwslQaizYVOXJivY
         DT1jnNApxKxAkm5cnxrOyQzp5IXXF+hQr274DfaxDdFMPTZe7KZiliXUyIQ0BBDkkr4B
         yoxm6ia0PekoKqwd93mh5Kr7OM3NVsKlfg53sGH9/k22CnVuANMbkQCq0BqzLy1ch1rg
         0nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSbh5orQAOFlLCo4wlBuHnUgLykOnfmt1aJCPAp9m00=;
        b=FUnhBvZLroil/TZTed3WN7umrs+gfDJ4RvreExb00IUbv9TWdyotcewn+IWbd/gn5s
         KZd9f0WJikSP749n0JKMsrOwJi1rv8mRKyDNTNwMOkTAqUY1Td4lFAgBlXAQgRhFThEo
         pMgoALO9rEaDGJf6EIoPUPrpSR/RBobxXsi5AAqEJOwSnsJx1s2bq7T6KtCARMJe0xB3
         oUyXS1qOR40JTeKbYBqRo9chxLY3affN84OhqUZlGE60gaqiaVNWLdHH3VQcGR7U+jmQ
         wBjHLSQ7Vstd2JVRBhdErRxToHuWVzqV4DgktkimzC1awgw3kfuhj//HHlc2S4fpWvhW
         5m8w==
X-Gm-Message-State: APjAAAUF4YIRSMVIr36dSS5uMQ+GPC9tZnwW9NgbPGh215q5ZeuJiJR0
        oC2m9UfUH2sLdWxaWm3+oMjMdJGwQ71m75kMqD1iRwdcbvE=
X-Google-Smtp-Source: APXvYqyM1ImM7vHnV+T+6uuqe5TpK/blaQmuyE14vME947Lf0I+KXiFAXTNQPr/COlodqE46tSxRO7X1hwrwzueoGjk=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr50431547ybc.507.1556490843819;
 Sun, 28 Apr 2019 15:34:03 -0700 (PDT)
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
 <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com> <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
In-Reply-To: <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Apr 2019 18:33:52 -0400
Message-ID: <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "pshilov@microsoft.com" <pshilov@microsoft.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 6:08 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sun, 2019-04-28 at 18:00 -0400, Amir Goldstein wrote:
> > On Sun, Apr 28, 2019 at 11:06 AM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > > On Sun, 2019-04-28 at 09:45 -0400, Amir Goldstein wrote:
> > > > On Sun, Apr 28, 2019 at 8:09 AM Jeff Layton <jlayton@kernel.org>
> > > > wrote:
> > > > > On Sat, 2019-04-27 at 16:16 -0400, Amir Goldstein wrote:
> > > > > > [adding back samba/nfs and fsdevel]
> > > > > >
> > > > >
> > > > > cc'ing Pavel too -- he did a bunch of work in this area a few
> > > > > years
> > > > > ago.
> > > > >
> > > > > > On Fri, Apr 26, 2019 at 6:22 PM Jeff Layton <
> > > > > > jlayton@kernel.org>
> > > > > > wrote:
> > > > > > > On Fri, 2019-04-26 at 10:50 -0400, J. Bruce Fields wrote:
> > > > > > > > On Fri, Apr 26, 2019 at 04:11:00PM +0200, Amir Goldstein
> > > > > > > > wrote:
> > > > > > > > > On Fri, Apr 26, 2019, 4:00 PM J. Bruce Fields <
> > > > > > > > > bfields@fieldses.org> wrote:
> > > > > > > > >
> > > > > > > That said, we could also look at a vfs-level mount option
> > > > > > > that
> > > > > > > would
> > > > > > > make the kernel enforce these for any opener. That could
> > > > > > > also
> > > > > > > be useful,
> > > > > > > and shouldn't be too hard to implement. Maybe even make it
> > > > > > > a
> > > > > > > vfsmount-
> > > > > > > level option (like -o ro is).
> > > > > > >
> > > > > >
> > > > > > Yeh, I am humbly going to leave this struggle to someone
> > > > > > else.
> > > > > > Not important enough IMO and completely independent effort to
> > > > > > the
> > > > > > advisory atomic open&lock API.
> > > > >
> > > > > Having the kernel allow setting deny modes on any open call is
> > > > > a
> > > > > non-
> > > > > starter, for the reasons Bruce outlined earlier. This _must_ be
> > > > > restricted in some fashion or we'll be opening up a ginormous
> > > > > DoS
> > > > > mechanism.
> > > > >
> > > > > My proposal was to make this only be enforced by applications
> > > > > that
> > > > > explicitly opt-in by setting O_SH*/O_EX* flags. It wouldn't be
> > > > > too
> > > > > difficult to also allow them to be enforced on a per-fs basis
> > > > > via
> > > > > mount
> > > > > option or something. Maybe we could expand the meaning of '-o
> > > > > mand'
> > > > > ?
> > > > >
> > > > > How would you propose that we restrict this?
> > > > >
> > > >
> > > > Our communication channel is broken.
> > > > I did not intend to propose any implicit locking.
> > > > If samba and nfsd can opt-in with O_SHARE flags, I do not
> > > > understand why a mount option is helpful for the cause of
> > > > samba/nfsd interop.
> > > >
> > > > If someone else is interested in samba/local interop than
> > > > yes, a mount option like suggested by Pavel could be a good
> > > > option,
> > > > but it is an orthogonal effort IMO.
> > >
> > > If an NFS client 'opts in' to set share deny, then that still makes
> > > it
> > > a non-optional lock for the other NFS clients, because all ordinary
> > > open() calls will be gated by the server whether or not their
> > > application specifies the O_SHARE flag. There is no flag in the NFS
> > > protocol that could tell the server to ignore deny modes.
> > >
> > > IOW: it would suffice for 1 client to use O_SHARE|O_DENY* to opt
> > > all
> > > the other clients in.
> > >
> >
> > Sorry for being thick, I don't understand if we are in agreement or
> > not.
> >
> > My understanding is that the network file server implementations
> > (i.e. samba, knfds, Ganesha) will always use share/deny modes.
> > So for example nfs v3 opens will always use O_DENY_NONE
> > in order to have correct interop with samba and nfs v4.
> >
> > If I am misunderstanding something, please enlighten me.
> > If there is a reason why mount option is needed for the sole purpose
> > of interop between network filesystem servers, please enlighten me.
> >
> >
>
> Same difference. As long as nfsd and/or Ganesha are translating
> OPEN4_SHARE_ACCESS_READ and OPEN4_SHARE_ACCESS_WRITE into share access
> locks, then those will conflict with any deny locks set by whatever
> application that uses them.
>
> IOW: any open(O_RDONLY) and open(O_RDWR) will conflict with an
> O_DENY_READ that is set on the server, and any open(O_WRONLY) and
> open(O_RDWR) will conflict with an O_DENY_WRITE that is set on the
> server. There is no opt-out for NFS clients on this issue, because
> stateful NFSv4 opens MUST set one or more of OPEN4_SHARE_ACCESS_READ
> and OPEN4_SHARE_ACCESS_WRITE.
>

Urgh! I *think* I understand the confusion.

I believe Jeff was talking about implementing a mount option
similar to -o mand for local fs on the server.
With that mount option, *any* open() by any app of file from
that mount will use O_DENY_NONE to interop correctly with
network servers that explicitly opt-in for interop on share modes.
I agree its a nice feature that is easy to implement - not important
for first version IMO.

I *think* you are talking on nfs client mount option for
opt-in/out of share modes? there was no such intention.

Thanks,
Amir.
