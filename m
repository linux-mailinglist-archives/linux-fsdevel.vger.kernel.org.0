Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4B798484
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjIHJCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHJCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:02:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B341BC8;
        Fri,  8 Sep 2023 02:02:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FA3C433C9;
        Fri,  8 Sep 2023 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694163739;
        bh=rRKEvIB0lVb2uGUWPoA0+XeAQvNtg/fARJrpqhmZI3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bOXNj24SHdKL79z6qfM1jz0YMFFEnZqcAWfQGXW2LdIVaQDbeY0DQhD5/JprtiyDj
         5D1k99+9Ug9dFN3lpUVgUMFb+noK4GaCPvJKFCJwg7T2e2+JUsNC8ryA59UAI/MjA+
         nhZly7RSUCbgUDXu5rbOkRxYN7fIeaweU9f951Eubr4hYUupmCp3r0d0X0xr56GoG7
         TSWC4FWPFYAvPS4fSD21+7m/TJTDKv1lgcMSbfjITw67g2TtEjYcmoKItUG7Y97Hw0
         VZNeNKEm7ZluvzqobouSn1v3ioXDS3dPfdRUJCnjtDuu6e2FCsvfTpz6bPkSMQxquU
         qkfRaTdEcE2/w==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99c4923195dso225185366b.2;
        Fri, 08 Sep 2023 02:02:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYmmn3N0eJ86RY5UVSHuEGe+d4IgMAB/ImN5j7vzi/Vz9f9yFn
        iUsjCB6DYZbEYE+aeyfhtgSAlHG1MfyORDaVyE4=
X-Google-Smtp-Source: AGHT+IHIxkho9CXfRVQdHREUP1Ny9xnSRZ4p9AxmPd+t8Z6hWpbhNEsJKkVWz7HAOHHA2nwechuLx9pmYabZgwNqZ0U=
X-Received: by 2002:a17:906:18aa:b0:9a1:c42e:5e5e with SMTP id
 c10-20020a17090618aa00b009a1c42e5e5emr1264248ejf.42.1694163717201; Fri, 08
 Sep 2023 02:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
 <20230906-jag-sysctl_remove_empty_elem_arch-v1-8-3935d4854248@samsung.com>
In-Reply-To: <20230906-jag-sysctl_remove_empty_elem_arch-v1-8-3935d4854248@samsung.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 8 Sep 2023 17:01:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFrd4zs_8vv5-n5p_+GYxnTJcRBtYDJaMZQQMOVKKOTw@mail.gmail.com>
Message-ID: <CAJF2gTRFrd4zs_8vv5-n5p_+GYxnTJcRBtYDJaMZQQMOVKKOTw@mail.gmail.com>
Subject: Re: [PATCH 8/8] c-sky: rm sentinel element from ctl_talbe array
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Sep 6, 2023 at 6:04=E2=80=AFPM Joel Granados via B4 Relay
<devnull+j.granados.samsung.com@kernel.org> wrote:
>
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> Remove sentinel from alignment_tbl ctl_table array.
>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  arch/csky/abiv1/alignment.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> index b60259daed1b..0d75ce7b0328 100644
> --- a/arch/csky/abiv1/alignment.c
> +++ b/arch/csky/abiv1/alignment.c
> @@ -328,8 +328,7 @@ static struct ctl_table alignment_tbl[5] =3D {
>                 .maxlen =3D sizeof(align_usr_count),
>                 .mode =3D 0666,
>                 .proc_handler =3D &proc_dointvec
> -       },
> -       {}
> +       }
>  };
>
>  static int __init csky_alignment_init(void)
>
> --
> 2.30.2
>


--=20
Best Regards
 Guo Ren
