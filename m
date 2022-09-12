Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C515B5DE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiILQKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILQKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:10:01 -0400
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55390B1D7;
        Mon, 12 Sep 2022 09:09:57 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-02.nifty.com with ESMTP id 28CG8dqx012454;
        Tue, 13 Sep 2022 01:08:39 +0900
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28CG87Iq006993;
        Tue, 13 Sep 2022 01:08:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28CG87Iq006993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662998888;
        bh=IfNmxP6k1oqV2drLrO4bvEnKkISFBkkx4i6qssF6TQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZI82hvA4n4nRGjLPAwZYrHzUZHkMEczkgAXKkuc0ZMULdK5670uBlnbYKQK25KHXG
         U+1oVmcnpwtfjIs+kEl3BrnyMELYNlDPuUj6+HN3SbIePRkOT+8Wo5FkxRS/LhxhBo
         6J/3VCHDmAlbIEgjl0FLF99HIqH4LY4QIrVQDOHLFqHerxO0IhUnCpDzA2ACs0dia8
         LEmNAqveIS8ng47Cjn2Zv16rSdPohwdL2CUyTlNDDxIFr9m83Bg9ffl391200BVptr
         AE0g7CHbENsYqMD2CX816t0AiSc6eMT0vEYwfXlbQExCfhxyODNf8KB4BOL3APPde6
         lHNloJlgB8hFw==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1274ec87ad5so24727860fac.0;
        Mon, 12 Sep 2022 09:08:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ZGkHdZwxN/7eJYUwsJ7W+mQyR3gBgiCEmhFaDfW4dxUFgdcPF
        oOI9MYFZl5RIvqwxX4wcOiX05tfwbRhFaS4+rdw=
X-Google-Smtp-Source: AA6agR7gBVHo+KvJjAu4Yr81Xj56NCGfGowjIM+55nLaZ9HKtuVtohFkXX2hZqwbf5LJi9W/QtaxvPPk+HJCL2HB1xw=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr3116730oie.287.1662998886400; Mon, 12
 Sep 2022 09:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-24-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-24-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Sep 2022 01:07:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=JfmrnGAUNXm_4RTz0fOhzfYC=htZ-VuEx=HAJPNtmw@mail.gmail.com>
Message-ID: <CAK7LNAQ=JfmrnGAUNXm_4RTz0fOhzfYC=htZ-VuEx=HAJPNtmw@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 6, 2022 at 12:44 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Having most of the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer and a few other bits.
>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Douglas Su <d0u9.su@outlook.com>
> Signed-off-by: Douglas Su <d0u9.su@outlook.com>
> Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Co-developed-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Co-developed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  .gitignore                     |   2 +
>  Makefile                       | 172 ++++++++++++++-
>  arch/Kconfig                   |   6 +
>  include/linux/compiler_types.h |   6 +-
>  init/Kconfig                   |  46 +++-
>  kernel/configs/rust.config     |   1 +
>  lib/Kconfig.debug              |  34 +++
>  rust/.gitignore                |   8 +
>  rust/Makefile                  | 381 +++++++++++++++++++++++++++++++++
>  rust/bindgen_parameters        |  21 ++
>  scripts/Kconfig.include        |   6 +-
>  scripts/Makefile               |   3 +
>  scripts/Makefile.build         |  60 ++++++
>  scripts/Makefile.debug         |  10 +
>  scripts/Makefile.host          |  34 ++-
>  scripts/Makefile.lib           |  12 ++
>  scripts/Makefile.modfinal      |   8 +-
>  scripts/cc-version.sh          |  12 +-
>  scripts/kconfig/confdata.c     |  75 +++++++
>  scripts/min-tool-version.sh    |   6 +
>  20 files changed, 877 insertions(+), 26 deletions(-)
>  create mode 100644 kernel/configs/rust.config
>  create mode 100644 rust/.gitignore
>  create mode 100644 rust/Makefile
>  create mode 100644 rust/bindgen_parameters
>
> diff --git a/.gitignore b/.gitignore
> index 97e085d613a2..5da004814678 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -37,6 +37,8 @@
>  *.o
>  *.o.*
>  *.patch
> +*.rmeta
> +*.rsi
>  *.s
>  *.so
>  *.so.dbg
> diff --git a/Makefile b/Makefile
> index df92892325ae..a105cb893b4c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -120,6 +120,15 @@ endif
>
>  export KBUILD_CHECKSRC
>
> +# Enable "clippy" (a linter) as part of the Rust compilation.
> +#
> +# Use 'make CLIPPY=3D1' to enable it.
> +ifeq ("$(origin CLIPPY)", "command line")
> +  KBUILD_CLIPPY :=3D $(CLIPPY)
> +endif
> +
> +export KBUILD_CLIPPY
> +
>  # Use make M=3Ddir or set the environment variable KBUILD_EXTMOD to spec=
ify the
>  # directory of external module to build. Setting M=3D takes precedence.
>  ifeq ("$(origin M)", "command line")
> @@ -267,14 +276,14 @@ no-dot-config-targets :=3D $(clean-targets) \
>                          cscope gtags TAGS tags help% %docs check% coccic=
heck \
>                          $(version_h) headers headers_% archheaders archs=
cripts \
>                          %asm-generic kernelversion %src-pkg dt_binding_c=
heck \
> -                        outputmakefile
> +                        outputmakefile rustavailable rustfmt rustfmtchec=
k
>  # Installation targets should not require compiler. Unfortunately, vdso_=
install
>  # is an exception where build artifacts may be updated. This must be fix=
ed.
>  no-compiler-targets :=3D $(no-dot-config-targets) install dtbs_install \
>                         headers_install modules_install kernelrelease ima=
ge_name
>  no-sync-config-targets :=3D $(no-dot-config-targets) %install kernelrele=
ase \
>                           image_name
> -single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtyp=
es %/
> +single-targets :=3D %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.=
symtypes %/
>
>  config-build   :=3D
>  mixed-build    :=3D
> @@ -436,6 +445,7 @@ else
>  HOSTCC =3D gcc
>  HOSTCXX        =3D g++
>  endif
> +HOSTRUSTC =3D rustc
>  HOSTPKG_CONFIG =3D pkg-config
>
>  KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototype=
s \
> @@ -444,8 +454,26 @@ KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototype=
s -Wstrict-prototypes \
>  KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
>  KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
>
> +# These flags apply to all Rust code in the tree, including the kernel a=
nd
> +# host programs.
> +export rust_common_flags :=3D --edition=3D2021 \
> +                           -Zbinary_dep_depinfo=3Dy \




Let me ask a question about the host_rust rule.



If I directly run the build command from the command line,
I get an error, like follows:


$ rustc --edition=3D2021 -Zbinary_dep_depinfo=3Dy -Dunsafe_op_in_unsafe_fn
-Drust_2018_idioms -Dunreachable_pub -Dnon_ascii_idents -Wmissing_docs
-Drustdoc::missing_crate_level_docs -Dclippy::correctness
-Dclippy::style -Dclippy::suspicious -Dclippy::complexity
-Dclippy::perf -Dclippy::let_unit_value -Dclippy::mut_mut
-Dclippy::needless_bitwise_bool -Dclippy::needless_continue
-Wclippy::dbg_macro -O -Cstrip=3Ddebuginfo -Zallow-features=3D
--emit=3Ddep-info,link --out-dir=3Dscripts/
../scripts/generate_rust_target.rs
error: the option `Z` is only accepted on the nightly compiler



This is the same command recorded as in
scripts/.generate_rust_target.cmd



Why no error when it is invoked from Makefile?


I have not figured out where this difference comes from.








--=20
Best Regards
Masahiro Yamada
