Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2E4A7E65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiBCDkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 22:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiBCDkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:40:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EBC061714;
        Wed,  2 Feb 2022 19:40:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z4so3221308lft.3;
        Wed, 02 Feb 2022 19:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyEDTT7UWcx0aQYR+EyAeRErzTRFuEJTWicokIyg/X8=;
        b=Cp35ItJkrFPCC1+ZfrNG4XN0hg6G4Yoy2CzfSRy2FWJCu4ia08qfUbOlOIeGcSjDK5
         yVYxu3JN/E8ii1sk5h/UmG3QBO085GTVOSo6/DdsGFUwfV0KpwW4Gz8jTQsDVfSIRP7A
         ClHkgzujvx8Gsi9gIufTJA9oaCJJafzXlHOkWX8L8PE2dwpNi6WRoO9fNiJRKoMssL35
         pJqvekbdwqSOkUfPGsu07XLlvEDoeNyuLMZTexRwkfUHKX64IVjLsu/BWWQG4bDHnjhP
         QLxwOaDWplkfF1MbfLZAxJlfeYWictcUCYDrgmug8bjBMXQNSHp6gVQKiX6eqoaCx8Xh
         Z3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyEDTT7UWcx0aQYR+EyAeRErzTRFuEJTWicokIyg/X8=;
        b=0aYJfSvMTbex6Q1bTvlJB+cHGbr8ijNltl1y8zIRl9bX42Tub7mIhaoSd4hW7z0O+/
         WMJKgtShGhdLH1RIByh8WGJPtsgQiCxFeME0LewQkZeGpBkeKXIOiz2/1F5mdsXRZ++1
         rUF7amC65kWivFtiy1wmIGTddCkCAG9NVLnqKEJomMeIsdWyvFiV5D6QuebGvhkZl0il
         r7ujmZaGNyxhFrAn6Zi3D8ONZL6vW/wLpWeWO689f1O8VHibt3HcqasXsSKk/h53fae1
         B+ZRSc+UbQcTO+sE9g+c6M0DH2xZJJRF+WF60+z/wVRLcpJqvHcELuDGOqvU3n+Rdz36
         J7Cg==
X-Gm-Message-State: AOAM531g+xBcA6ZwhuhD7bJSptxgctDfV29m9hH5B6eygp0e/ETeO+ky
        Z3ztbeuyEf+8mXuqIxzJYR+y/3CMTpQbdawJUFgcUa2R
X-Google-Smtp-Source: ABdhPJzPg+zSnT0SKrtipmoLp2+mt0UbTrXwpd0OYsdp8nW2Rksld9GezBee71wcQB0o2Ra72WaOst/UsAeYF0J+Cn8=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr24353648lfc.667.1643859649878;
 Wed, 02 Feb 2022 19:40:49 -0800 (PST)
MIME-Version: 1.0
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de> <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
In-Reply-To: <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 2 Feb 2022 21:40:39 -0600
Message-ID: <CAH2r5msVxenATfo+7iu7kjsQXXXT0dq2jp2JSxrY5Qm2PEde5w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel consumers
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an interesting question - and got me thinking about whether
also could be helpful to the critical question we have been asked
about multiple times for SMB, about how to get QUIC in the kernel (see
the various Storage Developer Conference presentations etc), while
putting as much as possible of the session establishment in userspace
accessed via upcalls.

I don't mind discussing this in detail at LSF (or at SambaXP a few
weeks after LSF), and since there are some SMB servers that support
QUIC already we could probably do at least some prototyping if there
is overlap between these two efforts.

On Wed, Feb 2, 2022 at 10:04 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> [ ... adding NFS and CIFS ... ]
>
> > On Feb 2, 2022, at 9:12 AM, Hannes Reinecke <hare@suse.de> wrote:
> >
> > Hi all,
> >
> > nvme-over-tcp has the option to utilize TLS for encrypted traffic, but due to the internal design of the nvme-over-fabrics stack we cannot initiate the TLS connection from userspace (as the current in-kernel TLS implementation is designed).
> >
> > This leaves us with two options:
> > 1) Put TLS handshake into the kernel (which will be quite some
> >  discussion as it's arguably a userspace configuration)
> > 2) Pass an in-kernel socket to userspace and have a userspace
> >  application to run the TLS handshake.
> >
> > None of these options are quiet clear cut, as we will be have to put
> > quite some complexity into the kernel to do full TLS handshake (if we
> > were to go with option 1) or will have to design a mechanism to pass
> > an in-kernel socket to userspace as we don't do that currently (if we were going with option 2).
> >
> > We have been discussing some ideas on how to implement option 2 (together with Chuck Lever and the NFS crowd), but so far haven't been able to come up with a decent design.
> >
> > So I would like to discuss with interested parties on how TLS handshake could be facilitated, and what would be the best design options here.
>
> IMO we are a bit farther along than Hannes suggests, and I had
> the impression that we have already agreed on a "decent design"
> (see Ben Coddington's earlier post).
>
> We currently have several prototypes we can discuss, and there
> are some important issues on the table.
>
> First, from the start we have recognized that we have a range
> of potential in-kernel TLS consumers. To name a few: NVMe/TLS,
> RPC-with-TLS (for in-transit NFS encryption), CIFS/SMB, and,
> when it arrives, the QUICv1 transport. We don't intend to
> build something that works for only one of these, thus it
> will not be based on existing security infrastructure like
> rpc.gssd.
>
> Second, we believe in-kernel consumers will hitch onto the
> existing kTLS infrastructure to handle payload encryption and
> decryption. This transparently enables both software-based
> and offload, and in the latter case, we hope for quite
> reasonable performance.
>
> As Hannes said, the missing piece is support for the TLS
> handshake protocol to boot strap each TLS session.
>
> The security community has demanded that we stick with user
> space handshake implementations because they view the TLS
> handshake as complex and a broad attack surface. I question
> those assumptions, but even so...
>
> We will need to have in-kernel handshake to support NFSROOT
> and NVMe/TLS with a root filesystem, which are requirements
> for the storage community.
>
> We have an in-kernel prototype based on Tempesta's TLSv1.2
> offload in the works. See the "topic-rpc-with-tls" branch:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> We also have three promising user space upcall implementations
> that are helping us with architectural choices. The main issue
> here is how to set the correct peer authentication parameters
> for each handshake. As Ben said, key rings can play a critical
> part (as might netlink, but perhaps that can be avoided). We
> are sensitive to containerization requirements as well.
>
> One (not-yet-working) user space prototype is published in
> the "topic-rpc-with-tls-upcall" branch in the repo above.
>
>
> > The proposed configd would be an option, but then we don't have that, either :-)
> >
> > Required attendees:
> >
> > Chuck Lever
> > James Bottomley
> > Sagi Grimberg
> > Keith Busch
> > Christoph Hellwig
> > David Howells
>
> Anyone from the CIFS team? Enzo? How about Dave Miller?
>
> Actually I think we need to have security and network folks
> at the table. LSF/MM might not be the right venue for a
> full-scale discussion of alternatives. We have been waiting
> for an opportunity to bring this to a broad community event
> such as Plumbers but the pandemic has interfered.
>
> However, I am happy to discuss alternative upcall mechanisms,
> new requirements, and anything related to securing an
> in-kernel handshake against remote attack.
>
> --
> Chuck Lever
>
>
>


-- 
Thanks,

Steve
