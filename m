Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE461668FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 08:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAMH4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 02:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjAMHz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:55:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9528A;
        Thu, 12 Jan 2023 23:55:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78847B82097;
        Fri, 13 Jan 2023 07:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F6DC433EF;
        Fri, 13 Jan 2023 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673596555;
        bh=k+JG6cQhINTeraKycNX3AkA5hLXrGXirTSDubaW7RNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f61ARbFwfAK87XLX3bLLADXyMKwh/q9KK7NSFMIdjboOltYG7sbrBsrHM8gsQcq8d
         LuU8CeF7rfmQjvQQRK8g+CHrznSyDxa4gL2K0JJHzlWBX/N/IXeQFaIizRFty9e60O
         dRCMsXyj6AVGFD+t2S7qofJYHOIXryBp95fB2eXYtnyUpfrtvy+kY5k3yvk+yRTU/r
         +hpyg0V5p38xu4kBs0ccBCsu7ZNAT/wJoY1bpKy/Op89Vm9RIOda20LGNkIgO5NAx4
         hRFg2xUWCL+NKqgf0ZUrZWp63Evo4RxeDzuJEMKbl6+g4WubbvNuP8iFaO1Z0TbLZc
         QDuXydqasubaA==
Received: by mail-lj1-f176.google.com with SMTP id n5so21164902ljc.9;
        Thu, 12 Jan 2023 23:55:55 -0800 (PST)
X-Gm-Message-State: AFqh2kp+V5WnUg5Q+nTUj9L4ZcdkCgtm24fe4kAPsdY/R5RUZAGBxN/F
        xk4TK6OMp9VN0n/fWVrnfP3V/kx8NdNqeuajl6w=
X-Google-Smtp-Source: AMrXdXvPBDKnkGS46Fnum+sBY6tUC4r2g2BIXBTSIujXdCK7arMiBySaB6Urx5uBQUaWUUyEymbKDknr+1U3RdEBQGg=
X-Received: by 2002:a2e:a901:0:b0:27f:ef88:3ecb with SMTP id
 j1-20020a2ea901000000b0027fef883ecbmr1881053ljq.189.1673596553124; Thu, 12
 Jan 2023 23:55:53 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Jan 2023 08:55:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
Message-ID: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
Subject: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 13 Jan 2023 at 01:31, Luck, Tony <tony.luck@intel.com> wrote:
>
> > Yeah, if it was ia64-only, it's a non-issue these days. It's dead and
> > in pure maintenance mode from a kernel perspective (if even that).
>
> There's not much "simultaneous" in the SMT on ia64. One thread in a
> spin loop will hog the core until the h/w switches to the other thread some
> number of cycles (hundreds, thousands? I really can remember). So I
> was pretty generous with dropping cpu_relax() into any kind of spin loop.
>
> Is it time yet for:
>
> $ git rm -r arch/ia64
>

Hi Tony,

Can I take that as an ack on [0]? The EFI subsystem has evolved
substantially over the years, and there is really no way to do any
IA64 testing beyond build testing, so from that perspective, dropping
it entirely would be welcomed.

Thanks,
Ard.



[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64
