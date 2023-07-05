Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90E7491A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGEXUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGEXTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:19:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211BE57;
        Wed,  5 Jul 2023 16:19:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so195411fa.2;
        Wed, 05 Jul 2023 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688599185; x=1691191185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvm/ESewbN0H2Rkg9On6IkqD7SWtNhnTUlvYjg/d9JA=;
        b=EpWCN8W4J50qBjCe+S5pn8rLfU8N4Q9dKL7hcLdv2Oop977UZ/lxeB6T7Ca353XM11
         KJX642s07IuUTRuI2Z6HfR0QbL7oGglA/ArgPy1abSeukJE+Xd3oSn1M8wEgELxuc+4M
         ViJSgVJgXDRUJwgVpfM/WohX+q74u7XH7+qcxI3EVzncb6ybA5oN5N9Upci+4uQ/Nrao
         hbjDzPoioYji7M88qwpwjVi01xg+sbikS11yWad7o4ALW3s21MdHFA7pYz5EWhD9bZxC
         n3dWTvPKTCm9UiPMRt9jHBX6Gn8Hlh7xkaGKEhScIZpAHmThFoGSrS8IhLeNLAmqyGL/
         B+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688599185; x=1691191185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qvm/ESewbN0H2Rkg9On6IkqD7SWtNhnTUlvYjg/d9JA=;
        b=XBDi8m+O4a/Q6rVtgY2O2d+zoDj/MHLWxpyxrjZ9TL1L23Y+PRrkiuWYaCRCW43kwK
         obQoMmZAo/AYDPYb9j71uNnqIX3aWsv5L1lJjCEFvqJCOya5RBoXQIA8ZzMmOpYxMxJz
         7BYQioEFTpUOKfCp9/EeaBOnJXEfmdt/PiXvlpGb82h5ird3c4aooNXoLmV+/SrUUCmE
         obgT8Z1L7sphiFJ231dH7DwZVuQPiahwifEGIlVnjVMAzeNdfiCZi2z1PiJ/W+hE+VPX
         lbpHsD/2MLbBtDchTioFpBZQu93UI8AotKpBgMb2QqEmn4JZR7vM5Jrbs40XQtrV2daA
         QAMw==
X-Gm-Message-State: ABy/qLYC3GuZxHYquPhHse5Cl2pjzM/9vFq5NJNPStE57IGU92SQ/9eD
        dxf47mBFwxRhC3I5dVTC6kOETkOo0ShC+5+ke6w=
X-Google-Smtp-Source: APBJJlELm51lB9I+2X7mnELiIo/3gyycTB0nOTJa7gdmrmQA0kycn716CHsgpSj/cHth9HPURMsqR6Dsm4KUn5EZang=
X-Received: by 2002:a2e:9104:0:b0:2b6:f85a:20b0 with SMTP id
 m4-20020a2e9104000000b002b6f85a20b0mr111615ljg.16.1688599184905; Wed, 05 Jul
 2023 16:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230609125023.399942-1-jlayton@kernel.org> <20230609125023.399942-8-jlayton@kernel.org>
 <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com>
 <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
 <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com> <9711e5f19dd2c040b4105147129a8db0aaf94b53.camel@kernel.org>
In-Reply-To: <9711e5f19dd2c040b4105147129a8db0aaf94b53.camel@kernel.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 6 Jul 2023 01:19:33 +0200
Message-ID: <CAHpGcMJriZRgwHL1yVJG9KkSwoDs9knnNRhakYN3GiuXPRkYOA@mail.gmail.com>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is updated
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 5. Juli 2023 um 23:51 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> On Wed, 2023-07-05 at 22:25 +0200, Andreas Gruenbacher wrote:
> > On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > > > Jeff,
> > > >
> > > > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/gfs2/quota.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > > > index 1ed17226d9ed..6d283e071b90 100644
> > > > > --- a/fs/gfs2/quota.c
> > > > > +++ b/fs/gfs2/quota.c
> > > > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inod=
e *ip, loff_t loc,
> > > > >                 size =3D loc + sizeof(struct gfs2_quota);
> > > > >                 if (size > inode->i_size)
> > > > >                         i_size_write(inode, size);
> > > > > -               inode->i_mtime =3D inode->i_atime =3D current_tim=
e(inode);
> > > > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ct=
ime =3D current_time(inode);
> > > >
> > > > I don't think we need to worry about the ctime of the quota inode a=
s
> > > > that inode is internal to the filesystem only.
> > > >
> > >
> > > Thanks Andreas.  I'll plan to drop this patch from the series for now=
.
> > >
> > > Does updating the mtime and atime here serve any purpose, or should
> > > those also be removed? If you plan to keep the a/mtime updates then I=
'd
> > > still suggest updating the ctime for consistency's sake. It shouldn't
> > > cost anything extra to do so since you're dirtying the inode below
> > > anyway.
> >
> > Yes, good point actually, we should keep things consistent for simplici=
ty.
> >
> > Would you add this back in if you do another posting?
> >
>
> I just re-posted the other patches in this as part of the ctime accessor
> conversion. If I post again though, I can resurrect the gfs2 patch. If
> not, we can do a follow-on fix later.

Sure, not a big deal.

> Since we're discussing it, it may be more correct to remove the atime
> update there. gfs2_adjust_quota sounds like a "modify" operation, not a
> "read", so I don't see a reason to update the atime.
>
> In general, the only time you only want to set the atime, ctime and
> mtime in lockstep is when the inode is brand new.

Yes, that makes sense, too.

Thanks,
Andreas
