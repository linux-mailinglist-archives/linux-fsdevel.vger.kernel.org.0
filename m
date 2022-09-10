Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FD5B4A7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIJWQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 18:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIJWQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:16:01 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFBA3ECD1;
        Sat, 10 Sep 2022 15:15:59 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u189so5290499vsb.4;
        Sat, 10 Sep 2022 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=7hUru+PlDInxtqG3Y5efCjvFBL7ebsOi4D8gTUEf3PU=;
        b=oXSC9rp7UoPXirziWBG9OHwbqWQl2fwvGVEBzbpvwYXwxSoDuPwIfLO44Xp4dukwt5
         6RhxQ9VZRzKNMTiF5JmWlY8uyNQcrDWsWn1Qx+rEd5W+MfH+d99utPwSpgA9EvKB8pla
         bVBg7rKFJ3MLFDgxaNN2iiOeiEn5Sp4SiPgni4bGNuWllRRqTz5H1gCgysK+qUp7R5uZ
         1JJM4VhedyLEN+DfEjzPwYHoNBpoEDQ5512VBEPm7M6kKXNAL5q89IYh3L8Ivcp5V/mm
         7sye7vyUMVf8e8pGD1elx14HTASPS8sGUia7VRawjCvcHDiyf4vwz+fYAdAtxWdzLVcf
         H1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7hUru+PlDInxtqG3Y5efCjvFBL7ebsOi4D8gTUEf3PU=;
        b=4wZZ3Gqp/s34zEP/O63vYLjQHJ56ZIidnNnK3QbJQfu9gtT0ov8g80lMVCo4l/ox0J
         ylBnXZST/sa+NvdI8eqsclF6g2rB7ELCR4nVo341djT0vwfteRpsBHJesujELxxH3Dn9
         WLDO7mucPDxauHGTS6eLO4ZQB20pvbSKRAiXRvpZAq1GoJWLIgShlKrGug+M/GyVZ8AL
         zeVVazpKbSONGW+vrhaXlCSa/lV4obuTLuTGQVcY7YZ3mtMZ6vapILHP5RH8HJO000CL
         56eHK+hkieoiPNxl7fKOffTo6K9DpHc2OoJQfDNnBcGA/QOPGQ2deA+37j8HYavkbAs8
         dB5w==
X-Gm-Message-State: ACgBeo2SMcTBxN5OLs7P7qv0kkUHNxcFRvKeGf69WeWARl3VsKfrX0/s
        G6OKXp4rI18klVJ4yiA+EOMOp3g1hCaMNalIBZw=
X-Google-Smtp-Source: AA6agR4ZlMOXlDj/3qYf5c2nS0+QXSBmC5IDLcOuDDxrV9IFiWI01tE34LnpqRufqv3whC7l5y8MVmdqDokz1GAAAJ4=
X-Received: by 2002:a05:6102:23db:b0:38a:9132:e441 with SMTP id
 x27-20020a05610223db00b0038a9132e441mr7018721vsr.24.1662848159014; Sat, 10
 Sep 2022 15:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com> <YxsGIoFlKkpQdSDY@mit.edu> <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
In-Reply-To: <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
From:   battery dude <jyf007@gmail.com>
Date:   Sat, 10 Sep 2022 17:15:11 -0500
Message-ID: <CAMBbDaFsFFowLWeiqUg-2O6Px2GjvA6La3dwzomw7Ps_0s2enA@mail.gmail.com>
Subject: Re: Does NFS support Linux Capabilities
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://discourse.pi-hole.net/t/ftl-not-running-in-web-interface/10412?page=
=3D2
https://serverfault.com/questions/886804/non-root-user-needing-chown-capabi=
lity-on-nfs-client
other refer

Casey Schaufler <casey@schaufler-ca.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 10:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/9/2022 2:23 AM, Theodore Ts'o wrote:
> > On Thu, Sep 08, 2022 at 08:24:02PM +0000, Chuck Lever III wrote:
> >> I'm not sure how closely other implementations come to implementing
> >> POSIX.1e, but there are enough differences that interoperability
> >> could be a nightmare. ...
> > ...
> >> The NFSv4 WG could invent our own capabilities scheme, just as was
> >> done with NFSv4 ACLs. I'm not sure everyone would agree that effort
> >> was 100% successful.
> > Indeed, what the NFSv4 working group could do is to take a survey of
> > what capabilities are in use, and more importantly, how they are
> > defined, and create a superset of all of those capabilities and
> > publish it as an RFC.  The tricky bit might be there were multiple
> > versions of the Posix.1e that were published, and different Legacy
> > Unices shipped implementations conforming to different drafts of
> > Posix.1e as part of the ill-fated "C2 by '92" initiative.
> >
> > ...
> >
> > In any case, what this means is the exact details of what some
> > particular capability might control could differ from system to
> > system.  OTOH, I'm not sure how much that matters, since capability
> > masks are applied to binaries, and it's unlikely that it would matter
> > that a particular capabiity on an executable meant for Solaris 2.4SE
> > with C2 certification might be confusing to AIX 4.3.2 (released in
> > 1999; so much for C2 by '92) that supported Orange Book C2, since AIX
> > can't run Solaris binaries.  :-)
>
> Data General's UNIX system supported in excess of 330 capabilities.
> Linux is currently using 40. Linux has deviated substantially from
> the Withdrawn Draft, especially in the handling of effective capabilities=
.
> I believe that you could support POSIX capabilities or Linux capabilities=
,
> but an attempt to support both is impractical. Supporting any given
> UNIX implementation is possible, but once you get past the POSIX defined
> capabilities into the vendor specific ones interoperability ain't gonna
> happen.
>
> >> Given these enormous challenges, who would be willing to pay for
> >> standardization and implementation? I'm not saying it can't or
> >> shouldn't be done, just that it would be a mighty heavy lift.
> >> But maybe other folks on the Cc: list have ideas that could
> >> make this easier than I believe it to be.
> > .. and this is why the C2 by '92 initiative was doomed to failure,
> > and why Posix.1e never completed the standardization process.  :-)
>
> The POSIX.1e effort wasn't completed because vendors lost interest
> in the standards process and because they lost interest in the
> evaluated security process. That, and we'd made way too many trips
> to Poughkeepsie.
>
> > Honestly, capabilities are super coarse-grained, and I'm not sure they
> > are all that useful if we were create blank slate requirements for a
> > modern high-security system.  So I'm not convinced the costs are
> > sufficient to balance the benefits.
>
> Granularity was always a bone of contention in the working group.
> What's sad is that granularity wasn't the driving force behind capabiliti=
es.
> The important point was to separate privilege from UID 0. In the end
> I think we'd have been better off with one capability, CAP_PRIVILEGED,
> defined in the specification and a note saying that beyond that you were
> on your own.
>
> > If I was going to start from scratch, and if I only cared about Linux
> > systems that supported ext4 and/or f2fs, I'd design something where
> > executables would use fsverity, and then combine it with an eBPF MAC
> > policy[1] that would key off of some policy identifier embedded in the
> > PKCS7 signature block located in the executable's fsverity metadata.
> > (The fsverity signature would be applied by a secure build service, to
> > guarantee exact correspondence between the binary and a specific
> > version checked into source control, to protect against the insider
> > threat of an engineer sneaking some kind of un-peer-reviewed back door
> > into the binary.)  The policy identifier might be used to provide some
> > kind of MAC enforcement, perhaps using seccomp to enforce what system
> > calls and ioctls said executable would be allowed to execute, or some
> > other kind of MAC policy.
> >
> > [1] https://lwn.net/Articles/809645/
> >
> > Speaking totally hypothetically, of course.  A bunch of what I've
> > described above isn't upstream, or even implemented yet.  (Although if
> > someone's interest is piqued in implementing some of this, please
> > contact me off-line.)
> >
> >                                               - Ted
