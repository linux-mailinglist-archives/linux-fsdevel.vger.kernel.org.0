Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7C5FF0BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJNPAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJNPAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3EACF70;
        Fri, 14 Oct 2022 08:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF69061B76;
        Fri, 14 Oct 2022 15:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A24C43142;
        Fri, 14 Oct 2022 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665759634;
        bh=OxW0KzawkZ2Ykmwi2XDi++58/gYDRqGQfyaXHw6Or/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZZel9hHTO+Trp5+FM0vtTfCzmIECDglx6ThzKolEuu9TtDIwBd69tuyuXHhMaCEtY
         bRCmE7KcWt37g5a5uaK96DEzrRVgHAKjbRgj/CuUfr/x9szlImbHW3vxR4d/g00TcR
         v+3pHd38foq/+c57gJkDmEcOyLUtwesNQV3AIf9vEdWux4O6ns5hObJRzX+RwyfyzU
         +0Lw7YeXXvWVJY6FzJxc8tjHdE0FugpeomHUP74Iv777Hg8kVSQ3IOecv2WupsBZMI
         FtjdqJF4R0TUQmqAWdNTfwDiPZDq1nVB3tJms3qunwf3F8NpKWt/NoXbB+tOThpnuT
         HXUB7jdMMkoyA==
Received: by mail-lf1-f46.google.com with SMTP id b1so7615237lfs.7;
        Fri, 14 Oct 2022 08:00:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf01eoqzsrJ4RtzIoxnhCSATtOcjcQsLbViu5f8534dI0khM7vi+
        iHH8SnVdX+j5t8CdH72m3gCPdsDtYq+QZ0fcz8w=
X-Google-Smtp-Source: AMsMyM7JNwHFcEqmmO2qOEXoQqP5NFQXr7qlaf9afUajpTsJJ9l6zymlYfZZv6RkGuSq2R5t34cBRuArycH/55jvODE=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr1797311lfb.122.1665759632164; Fri, 14
 Oct 2022 08:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210648.137452-1-gpiccoli@igalia.com> <20221013210648.137452-4-gpiccoli@igalia.com>
 <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com> <1c6a9461-0d3d-a049-0165-0d5c95aa9405@igalia.com>
In-Reply-To: <1c6a9461-0d3d-a049-0165-0d5c95aa9405@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 17:00:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLULYfA6UGwvH7NY5A5E6YaC4s8G+qU12MgChB1_5DKQ@mail.gmail.com>
Message-ID: <CAMj1kXGLULYfA6UGwvH7NY5A5E6YaC4s8G+qU12MgChB1_5DKQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Oct 2022 at 16:58, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 14/10/2022 11:46, Ard Biesheuvel wrote:
> > [...]
> >>         for (;;) {
> >> -               varname_size = EFIVARS_DATA_SIZE_MAX;
> >> +               varname_size = record_size;
> >>
> >
> > I don't think we need this - this is the size of the variable name not
> > the variable itself.
> >
>
> Ugh, my bad. Do you want to stick with 1024 then?

Yes let's keep this at 1024
