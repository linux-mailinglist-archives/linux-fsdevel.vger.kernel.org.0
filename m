Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3157A5F75BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJGJL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 05:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJGJL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:11:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CDC822D;
        Fri,  7 Oct 2022 02:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BF31B8207A;
        Fri,  7 Oct 2022 09:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9EDC43140;
        Fri,  7 Oct 2022 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665133881;
        bh=hctYxLWeuqSzdPP/7joJ9SzZ8vpMri5p/6oyxbXDIVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qEXPWSIdibTfm78StME14Spr/MrmgzVhP6bWo1p9GPuav6TJHtgqKTZoUWk+YGKIk
         gGsJiKVjKQJ5/JdMyI3O+6DUCoPQ51uCnboKg9+u0PjybSiJxXFCiRdnf/huJdNrD8
         O4pXEo6CX4KYa+e4Mf8yawvpjS6LrrpIENhoNswYygGHCvp9/Zl7kkcmR2yq9MnMPJ
         oyNH4D5AZpkj9KADllSItYR/jGnMYf2T0zTkfpwC2SQFt0lNd8TMwsQV3TokxHM2/8
         wP2RYW/CYSb3Fq7JQAZT0MLUDuPlMG0UjPfPi0Zw33mkdXIyzqRwnZkpQwFJd4Qw3D
         8404c45YkMMcw==
Received: by mail-lj1-f174.google.com with SMTP id by36so5000686ljb.4;
        Fri, 07 Oct 2022 02:11:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Nk1gIDpQdzZb2XAI2Y9wB+WUPud53dobpsL6Juf6K2P3Mz+rW
        6Bpi6yUijSzYCD81d8bzDB/jfcy/KU7ekG9UJ1E=
X-Google-Smtp-Source: AMsMyM4x11I0YK50cjnoScwsaM7U+tTFvF0AqagiyQ7KO3Pp3xcJfy9W9AAdkB4DbJdTuIFZryg0CBS2dge96iAXwz8=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr1387247lji.291.1665133879880; Fri, 07
 Oct 2022 02:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook>
In-Reply-To: <202210061614.8AA746094A@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 11:11:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
Message-ID: <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Oct 2022 at 01:16, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 06, 2022 at 07:42:12PM -0300, Guilherme G. Piccoli wrote:
> > By default, the efi-pstore backend hardcode the UEFI variable size
> > as 1024 bytes. That's not a big deal, but at the same time having
> > no way to change that in the kernel is a bit bummer for specialized
> > users - there is not such a limit in the UEFI specification.
>
> It seems to have been added in commit
> e0d59733f6b1 ("efivars, efi-pstore: Hold off deletion of sysfs entry until the scan is completed")
>

Yeah fortunately that kludge is gone now.

> But I see no mention of why it was introduced or how it was chosen.
>

There is some cargo cult from prehistoric EFI times going on here, it
seems. Or maybe just misinterpretation of the maximum size for the
variable *name* vs the variable itself.

> I remember hearing some horror stories from Matthew Garrett about older
> EFI implementations bricking themselves when they stored large
> variables, or something like that, but I don't know if that's meaningful
> here at all.
>

This was related to filling up the variable store to the point where
SetVariable() calls in the firmware itself would start failing,
bricking the system in the process.

The efivars layer below efi-pstore will take care of this, by ensuring
upfront that sufficient space is available.

> I think it'd be great to make it configurable! Ard, do you have any
> sense of what the max/min, etc, should be here?
>

Given that dbx on an arbitrary EFI system with secure boot enabled is
already almost 4k, that seems like a reasonable default. As for the
upper bound, there is no way to know what weird firmware bugs you
might tickle by choosing highly unusual values here.

If you need to store lots of data, you might want to look at [0] for
some work done in the past on using capsule update for preserving data
across a reboot. In the general case, this is not as useful, as the
capsule is only delivered to the firmware after invoking the
ResetSystem() EFI runtime service (as opposed to SetVariable() calls
taking effect immediately). However, if you need to capture large
amounts of data, and can tolerate the uncertainty involved in the
capsule approach, it might be a reasonable option.

[0] https://lore.kernel.org/all/20200312011335.70750-1-qiuxu.zhuo@intel.com/
