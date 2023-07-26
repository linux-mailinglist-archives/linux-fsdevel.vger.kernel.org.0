Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EF7642B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 01:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGZXrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 19:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGZXrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:47:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57812BF;
        Wed, 26 Jul 2023 16:47:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58459a6f42cso3877927b3.2;
        Wed, 26 Jul 2023 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690415271; x=1691020071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSj579UEHOTLxAoowRqvJsUTOQYIQrtDrZClJxox6OU=;
        b=R6sNVC+TTGCjJRW0Ih7LK/VG4X2yBvUysLh4Nf2k0wBPQzeee4Q09pq3U0Etsk4gim
         ZxOLoy1NsoKyQ2b+r68QcfKkpMOTer5ZgVwoLLKx2dmBYRiT5ttGbKleuQEK0HaNl6Ps
         pbtkn2v1fo3wUzBH61Hi6JJkahgYMrbvJVNLKSKrDHPG8qSKsHVY0z2JXblmkyDdQkzr
         yUQ79ZxpMf3rR0CVXi0qEBz0FFUVmeTdRxOn1AwPyh9d/257cpXfxcZgS7Z0O81Xb7QE
         He7anbcksAX8PMcLbccLAyD8bi4/YxkiflLAfg9h6UBcTTFs7ogNbbiN9KXnRDtsMbuT
         i8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690415271; x=1691020071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSj579UEHOTLxAoowRqvJsUTOQYIQrtDrZClJxox6OU=;
        b=gCr8DwQWEmR8HJ4QARHTTtXKSqO9kWX3uSohengrTkimlXE9MMufiFf2YEl9qHniBZ
         q0eKyIk+mrCDwzfdta5+UzSrRIak2t6Pf6XahEKMvnFhKYraxYmJqgw7kxbupg3v2BTc
         46OhNnNBzLbnTJ0E6N557eWuJEB4M+2O65hLBSQBKDK1BPAZnFyJsgsgYWYe4Bt+2rbz
         sgmCQr1x4CwOgIakuJOG5poKWPvNYbaEv3DxES35kwDeYBnWCkKH4S0bm3pAWxw0K0MF
         boUH2/0wafSNJ8l/ug2UYJ/VuozLIl4rVnNVC2CfAOu059Jw5Jn1+UmvRVTSVpTLlI3D
         FMSg==
X-Gm-Message-State: ABy/qLY1mhMfWlINZAr2V5Xac5JkX3Tgyn0h9HPlZsvzLhxlOEEIAW0s
        C8zoeF1rffEVtNCL8PwZpIErgWjgtP01zPeNoVI=
X-Google-Smtp-Source: APBJJlFFCpTFDAjga9FJjYZxTm2toNbn47AgMiyGDenCaSYZW/+aMaz5h/M/uw0OE7Rs6UotCaXxpvD9k8CTeAI5QZA=
X-Received: by 2002:a0d:dd03:0:b0:577:2cac:cd4b with SMTP id
 g3-20020a0ddd03000000b005772caccd4bmr3699450ywe.7.1690415271492; Wed, 26 Jul
 2023 16:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-11-amiculas@cisco.com>
 <CALNs47ss3kV3mTx4ksYTWaHWdRG48=97DTi3OEnPom2nFcYhHw@mail.gmail.com>
In-Reply-To: <CALNs47ss3kV3mTx4ksYTWaHWdRG48=97DTi3OEnPom2nFcYhHw@mail.gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 26 Jul 2023 20:47:41 -0300
Message-ID: <CANeycqqTdL9vr=JF+Fij5EY0TW_+_FY1p2qGdvGhYcyH9=9J9w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] rust: puzzlefs: add oci_root_dir and
 image_manifest filesystem parameters
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com
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

On Wed, 26 Jul 2023 at 18:08, Trevor Gross <tmgross@umich.edu> wrote:
>
> On Wed, Jul 26, 2023 at 12:55=E2=80=AFPM Ariel Miculas <amiculas@cisco.co=
m> wrote:
> >
> > These parameters are passed when mounting puzzlefs using '-o' option of
> > mount:
> > -o oci_root_dir=3D"/path/to/oci/dir"
> > -o image_manifest=3D"root_hash_of_image_manifest"
> >
> > For a particular manifest in the manifests array in index.json (located
> > in the oci_root_dir), the root hash of the image manifest is found in
> > the digest field.
> >
> > It would be nicer if we could pass the tag, but we don't support json
> > deserialization.
> >
> > Example of mount:
> > mount -t puzzlefs -o oci_root_dir=3D"/home/puzzlefs_oci" -o \
> > image_manifest=3D"2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297b=
cffdcae901b" \
> > none /mnt
> >
> > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> > ---
> >  samples/rust/puzzlefs.rs | 63 ++++++++++++++++++++++++++--------------
> >  1 file changed, 41 insertions(+), 22 deletions(-)
> >
> > diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
> > index dad7ecc76eca..4e9a8aedf0c1 100644
> > --- a/samples/rust/puzzlefs.rs
> > +++ b/samples/rust/puzzlefs.rs
> > @@ -7,6 +7,7 @@
> >  use kernel::{
> >      c_str, file, fs,
> >      io_buffer::IoBufferWriter,
> > +    str::CString,
> >      sync::{Arc, ArcBorrow},
> >  };
> >
> > @@ -31,27 +32,29 @@ struct PuzzlefsInfo {
> >      puzzlefs: Arc<PuzzleFS>,
> >  }
> >
> > +#[derive(Default)]
> > +struct PuzzleFsParams {
> > +    oci_root_dir: Option<CString>,
> > +    image_manifest: Option<CString>,
> > +}
> > +
> >  #[vtable]
> >  impl fs::Context<Self> for PuzzleFsModule {
> > -    type Data =3D ();
> > -
> > -    kernel::define_fs_params! {(),
> > -        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(=
()) } },
> > -        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n=
"); Ok(()) } },
> > -        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(=
()) } },
> > -        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(())=
 } },
> > -        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n"=
); Ok(()) } },
> > -        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n"=
); Ok(()) } },
> > -        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(())=
 } },
> > -        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(())=
 } },
> > -        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n"=
); Ok(()) } },
> > -        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
> > -            pr_info!("enum passed-in: {v}\n"); Ok(()) }
> > -        },
> > +    type Data =3D Box<PuzzleFsParams>;
> > +
> > +    kernel::define_fs_params! {Box<PuzzleFsParams>,
> > +        {string, "oci_root_dir", |s, v| {
> > +                                      s.oci_root_dir =3D Some(CString:=
:try_from_fmt(format_args!("{v}"))?);
> > +                                      Ok(())
> > +                                  }},
> > +        {string, "image_manifest", |s, v| {
> > +                                      s.image_manifest =3D Some(CStrin=
g::try_from_fmt(format_args!("{v}"))?);
> > +                                      Ok(())
> > +                                  }},
> >      }
> >
> > -    fn try_new() -> Result {
> > -        Ok(())
> > +    fn try_new() -> Result<Self::Data> {
> > +        Ok(Box::try_new(PuzzleFsParams::default())?)
> >      }
> >  }
> >
> > @@ -136,11 +139,27 @@ impl fs::Type for PuzzleFsModule {
> >      const FLAGS: i32 =3D fs::flags::USERNS_MOUNT;
> >      const DCACHE_BASED: bool =3D true;
> >
> > -    fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Resul=
t<&fs::SuperBlock<Self>> {
> > -        let puzzlefs =3D PuzzleFS::open(
> > -            c_str!("/home/puzzlefs_oci"),
> > -            c_str!("2d6602d678140540dc7e96de652a76a8b16e8aca190bae1412=
97bcffdcae901b"),
> > -        );
> > +    fn fill_super(
> > +        data: Box<PuzzleFsParams>,
> > +        sb: fs::NewSuperBlock<'_, Self>,
> > +    ) -> Result<&fs::SuperBlock<Self>> {
> > +        let oci_root_dir =3D match data.oci_root_dir {
> > +            Some(val) =3D> val,
> > +            None =3D> {
> > +                pr_err!("missing oci_root_dir parameter!\n");
> > +                return Err(ENOTSUPP);
> > +            }
> > +        };
> > +
> > +        let image_manifest =3D match data.image_manifest {
> > +            Some(val) =3D> val,
> > +            None =3D> {
> > +                pr_err!("missing image_manifest parameter!\n");
> > +                return Err(ENOTSUPP);
> > +            }
> > +        };
> > +
>
> The guard syntax (available since 1.65) can make these kinds of match sta=
tements
> cleaner:

This is unstable though.

We try to stay away from unstable features unless we really need them,
which I feel is not the case here.

>     let Some(oci_root_dir) =3D data.oci_root_dir else {
>         pr_err!("missing oci_root_dir parameter!\n");
>         return Err(ENOTSUPP);
>     }
>
>     let Some(image_manifest) ...
>
> > +        let puzzlefs =3D PuzzleFS::open(&oci_root_dir, &image_manifest=
);
> >
> >          if let Err(ref e) =3D puzzlefs {
> >              pr_info!("error opening puzzlefs {e}\n");
> > --
> > 2.41.0
> >
> >
