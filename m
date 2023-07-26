Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC87640ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 23:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGZVJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGZVI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:08:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46B1BE8
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:08:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99313a34b2dso20012966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1690405732; x=1691010532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjkLXak8d+/QRW6V4ufp25mmvem0zi/hCFrifSGngFs=;
        b=ZuSNoM2neGgmzJ1HDcF0VbUgodiwml7GqlGB44XNU8z5ksD6ZgMFqxzRPQ/SOCjj4c
         ARW7u1YMSMc1qazZhCR8R7yOPL7bOd/vH43fz1I2RCkJzEm95afcsIadPOIYU/QIdQfr
         Tla/Ks/rrhbE94krRIMf/jrGJbH3Ww5d5rLLy+EQ0WGCoRgWGznST2uHoLjGiMp0uocQ
         QnXb6vmTvRegB76hyRWSgc14aNXqn1Uv+hBAIt4puE5lpAIwJqRZnKIM5UAazLI20hLC
         JdpL4f5XboVywAr0dntT3KVk9t04zLbwt77q8P8VWPJ+RN7t4OjXlNEadTBgDe8q8XG/
         9gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405732; x=1691010532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjkLXak8d+/QRW6V4ufp25mmvem0zi/hCFrifSGngFs=;
        b=AOJhU6OnU3nKwK7yho3sJ2616U7UqpdcE/e40Sd0BydUjF2E7PQP2h+s5dLhVKD57+
         MrEFi3w5WD3i1MPsvsnwc49YmPSjgmI5MFcVZNt/9Yq7U6t2xQ+5CXGRjDzFPphMaK2o
         O2AgRTzVqQ4vQk0gstFtV+JCTQ3gFMNrIyGV68bmDL9Y9DYzz+advT55Xgr1zYbaHZRS
         OaHw7ZXmoQMe5d2xdoinvvbarbMVEOs9ujt5v6II966LYaKCA9Wtp3aDHbZM/8jqH0is
         23xt4hGs3f3Pt5lq7VFSVjqB8oenRnPX8UoYCgK8XqdsskIN/t69luYNGNeJjMWI5s57
         oTSw==
X-Gm-Message-State: ABy/qLZDWWB/mPw8ao7Txpg75QTCD5UXETN3HWJM9udVIsfPl9SJHlJd
        MQI9h5QnXBVlbmb0oh++qO1t4CV+iTmWcfhEkD07aw==
X-Google-Smtp-Source: APBJJlFQX7UzDW/k/kYtWDvZK568AeNZukeBl2pXtyjIMni9uWicDax9fIk3Xw0AO67YAsFOv9YnJHcBKz+EEJqcJyI=
X-Received: by 2002:a17:906:7391:b0:994:54af:e282 with SMTP id
 f17-20020a170906739100b0099454afe282mr213636ejl.10.1690405732051; Wed, 26 Jul
 2023 14:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-11-amiculas@cisco.com>
In-Reply-To: <20230726164535.230515-11-amiculas@cisco.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Wed, 26 Jul 2023 17:08:40 -0400
Message-ID: <CALNs47ss3kV3mTx4ksYTWaHWdRG48=97DTi3OEnPom2nFcYhHw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] rust: puzzlefs: add oci_root_dir and
 image_manifest filesystem parameters
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.pizza,
        brauner@kernel.org, viro@zeniv.linux.org.uk, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:55=E2=80=AFPM Ariel Miculas <amiculas@cisco.com>=
 wrote:
>
> These parameters are passed when mounting puzzlefs using '-o' option of
> mount:
> -o oci_root_dir=3D"/path/to/oci/dir"
> -o image_manifest=3D"root_hash_of_image_manifest"
>
> For a particular manifest in the manifests array in index.json (located
> in the oci_root_dir), the root hash of the image manifest is found in
> the digest field.
>
> It would be nicer if we could pass the tag, but we don't support json
> deserialization.
>
> Example of mount:
> mount -t puzzlefs -o oci_root_dir=3D"/home/puzzlefs_oci" -o \
> image_manifest=3D"2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcf=
fdcae901b" \
> none /mnt
>
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> ---
>  samples/rust/puzzlefs.rs | 63 ++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 22 deletions(-)
>
> diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
> index dad7ecc76eca..4e9a8aedf0c1 100644
> --- a/samples/rust/puzzlefs.rs
> +++ b/samples/rust/puzzlefs.rs
> @@ -7,6 +7,7 @@
>  use kernel::{
>      c_str, file, fs,
>      io_buffer::IoBufferWriter,
> +    str::CString,
>      sync::{Arc, ArcBorrow},
>  };
>
> @@ -31,27 +32,29 @@ struct PuzzlefsInfo {
>      puzzlefs: Arc<PuzzleFS>,
>  }
>
> +#[derive(Default)]
> +struct PuzzleFsParams {
> +    oci_root_dir: Option<CString>,
> +    image_manifest: Option<CString>,
> +}
> +
>  #[vtable]
>  impl fs::Context<Self> for PuzzleFsModule {
> -    type Data =3D ();
> -
> -    kernel::define_fs_params! {(),
> -        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(()=
) } },
> -        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n")=
; Ok(()) } },
> -        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(()=
) } },
> -        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(()) }=
 },
> -        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n");=
 Ok(()) } },
> -        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n");=
 Ok(()) } },
> -        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(()) }=
 },
> -        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(()) }=
 },
> -        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n");=
 Ok(()) } },
> -        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
> -            pr_info!("enum passed-in: {v}\n"); Ok(()) }
> -        },
> +    type Data =3D Box<PuzzleFsParams>;
> +
> +    kernel::define_fs_params! {Box<PuzzleFsParams>,
> +        {string, "oci_root_dir", |s, v| {
> +                                      s.oci_root_dir =3D Some(CString::t=
ry_from_fmt(format_args!("{v}"))?);
> +                                      Ok(())
> +                                  }},
> +        {string, "image_manifest", |s, v| {
> +                                      s.image_manifest =3D Some(CString:=
:try_from_fmt(format_args!("{v}"))?);
> +                                      Ok(())
> +                                  }},
>      }
>
> -    fn try_new() -> Result {
> -        Ok(())
> +    fn try_new() -> Result<Self::Data> {
> +        Ok(Box::try_new(PuzzleFsParams::default())?)
>      }
>  }
>
> @@ -136,11 +139,27 @@ impl fs::Type for PuzzleFsModule {
>      const FLAGS: i32 =3D fs::flags::USERNS_MOUNT;
>      const DCACHE_BASED: bool =3D true;
>
> -    fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<=
&fs::SuperBlock<Self>> {
> -        let puzzlefs =3D PuzzleFS::open(
> -            c_str!("/home/puzzlefs_oci"),
> -            c_str!("2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297=
bcffdcae901b"),
> -        );
> +    fn fill_super(
> +        data: Box<PuzzleFsParams>,
> +        sb: fs::NewSuperBlock<'_, Self>,
> +    ) -> Result<&fs::SuperBlock<Self>> {
> +        let oci_root_dir =3D match data.oci_root_dir {
> +            Some(val) =3D> val,
> +            None =3D> {
> +                pr_err!("missing oci_root_dir parameter!\n");
> +                return Err(ENOTSUPP);
> +            }
> +        };
> +
> +        let image_manifest =3D match data.image_manifest {
> +            Some(val) =3D> val,
> +            None =3D> {
> +                pr_err!("missing image_manifest parameter!\n");
> +                return Err(ENOTSUPP);
> +            }
> +        };
> +

The guard syntax (available since 1.65) can make these kinds of match state=
ments
cleaner:

    let Some(oci_root_dir) =3D data.oci_root_dir else {
        pr_err!("missing oci_root_dir parameter!\n");
        return Err(ENOTSUPP);
    }

    let Some(image_manifest) ...

> +        let puzzlefs =3D PuzzleFS::open(&oci_root_dir, &image_manifest);
>
>          if let Err(ref e) =3D puzzlefs {
>              pr_info!("error opening puzzlefs {e}\n");
> --
> 2.41.0
>
>
