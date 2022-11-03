Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2D61895F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 21:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKCUJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiKCUIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:08:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611F240B6;
        Thu,  3 Nov 2022 13:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3CE5B82A0C;
        Thu,  3 Nov 2022 20:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2E4C43470;
        Thu,  3 Nov 2022 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667505988;
        bh=aQc0ltm9i79K48wYxyYSqtW3BHtN1jgvUXlb9ICcslA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pm+x7YvLJ9ocxE6+8wtecuGSXz2Ama5noVK3lnM0V0bYcxVNxNghJBFt6Eh6b3eMz
         AijT08GwXe8BgUtV+V6AZVfxzZgwj1BMI4kt8qKig3bXhz8e7h/aOfzYY4IREnz8Bg
         S0Ju2cRDM5hH3GdfCMa53ae490hPHeDLgaScxBsrHK2COglNOXc3869sBoqbC5fogV
         lskxkenq9Lr17At7pKIMOTOS2AeX/Z+3sbpkVFcYwDbTqXn5ZGJy6gBu6SOhp5XkAv
         5+jCCJnE7wKlA+3hWarj5X1Jk8j2GLrpQsqqEBaPDAixnF6SkdpBF7WwkZuZqtvDIL
         lLa6npJ8rfTVg==
Received: by mail-lj1-f170.google.com with SMTP id u2so3608854ljl.3;
        Thu, 03 Nov 2022 13:06:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf3VUhdUP1Hagr3ljZdeu6p+3h3azdwiKml6Yhb08BGGFk216TkK
        lkEVr0i2+LCMXm6F4JDifjLgR+tiwaccbkPAOqg=
X-Google-Smtp-Source: AMsMyM4Yj0jeFfoCqF1M9bL6KQAXXQQnFYf3U2XJpoZXg8pIpmggWrlUxIrgyVOiFwJ6h5Lw2/5LnuFjXlUMwQtE6Vs=
X-Received: by 2002:a2e:5c82:0:b0:26c:4311:9b84 with SMTP id
 q124-20020a2e5c82000000b0026c43119b84mr5804536ljb.152.1667505986582; Thu, 03
 Nov 2022 13:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221101184808.80747-1-gpiccoli@igalia.com> <CAMj1kXH5B0Op7Aab45x_tdkM1YsoSJ9euNqLMzeJg4uK++ojJQ@mail.gmail.com>
 <aac42f75-413b-c247-1a35-5d140ef38ff8@igalia.com>
In-Reply-To: <aac42f75-413b-c247-1a35-5d140ef38ff8@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Nov 2022 21:06:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-JUmeCS0627day7NDc5DbigqSRfug8xNx=u5k3sZhxg@mail.gmail.com>
Message-ID: <CAMj1kXH-JUmeCS0627day7NDc5DbigqSRfug8xNx=u5k3sZhxg@mail.gmail.com>
Subject: Re: [PATCH V3] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Nov 2022 at 19:38, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 03/11/2022 14:04, Ard Biesheuvel wrote:
> > [...]
> > Thanks, I'll queue this up for v6.2
>
> Thanks a lot for all the discussions Ard, it was very informative =)

My pleasure
