Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9344A399B14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCG7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 02:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCG7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:59:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F265AC06174A;
        Wed,  2 Jun 2021 23:57:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x9so4583884ilp.4;
        Wed, 02 Jun 2021 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNhL/pCq/YfCQK2j2fUpAq1gpLmTFSOWf12RosUThJ4=;
        b=j+TWFj9YDJWmJ6pah4ZDuXT4p37G/KxRcVzkwlXlGZcgHTgRPWSJ6XvHB7r0p47oUd
         sAQUWE98CXCGCDh+iQ6lFibUAY63LDSrr1Tw0I/XtaEsPHmQXyPj5ZiygW/qjd4FVRVL
         BHMztfQkmBBQB7Knb132Ue5aRwW/KQtn4UUS94ECdypz7lNet2s7akalRYbAoQigMYle
         SwfFd2wvrlvNEuNpChd26R3rOO4wPTHhcgi5cLeyOBL03mzdaUVp5g6nQdCD7IXRXpFZ
         /7rmaT4rbnh9g1hsQyDRtmLXATmuOpUt/k7i4t1jEzeMFI7hDp7buwC9/eEAbsMds5Il
         Xfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNhL/pCq/YfCQK2j2fUpAq1gpLmTFSOWf12RosUThJ4=;
        b=PEBf0HaEjBz5ydw2Z2JTPDZyb/Uxr9/EDo4yeQVrBHUaZ9hIXIpOrDv1agtPl3oXB9
         nNxa+Pk3zgKR3tAzX3ZhYT9Kb1v2FmxF6Pyhl400x9lKzCcbRXIyS3nrs9VA8v5BEx57
         YTnw0v8oHaGG4ovHSe7lB1LHhAut/IlQKEDnV7Uqi3D0ncb9WmQhc34h0yyBIztXroqS
         FhjPW8jd3DtDvU4Xjavs1Bcf8OvVvwZODhtUYBpfBm+ZeR0INB1/vc+BLd9wxdIi41a4
         J+8PwQN0dddi/nixhlbcbQ6rFZlJcDm/9CzOAQzeOGDHsvSRaEKuFO4Z9aCwLWq8re03
         dtzQ==
X-Gm-Message-State: AOAM530dxL/i+9uh576OFiZAgv0D8dowDf6do51nEUD9IX1YhZm9zSxs
        D7sGKtMPP4AIArs9oxC5b7jHuvDSBF2rL11OP4Y=
X-Google-Smtp-Source: ABdhPJzXdb7acv90///XjJCxH53FWwGHNU3BDyM0pIsZ6uB6sIZu+hcQtp9BLkNDr3TgAYiGohV66F2WlnWuN5vwtG0=
X-Received: by 2002:a05:6e02:1352:: with SMTP id k18mr5295294ilr.275.1622703447242;
 Wed, 02 Jun 2021 23:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210603015314.GA21290@xsang-OptiPlex-9020>
In-Reply-To: <20210603015314.GA21290@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Jun 2021 09:57:15 +0300
Message-ID: <CAOQ4uxjdtfriARxh_CiTxFi8=T6j065HtbJGnuAas7oyPNADKg@mail.gmail.com>
Subject: Re: [fanotify] a8b98c808e: stress-ng.fanotify.ops_per_sec 32.2% improvement
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 3, 2021 at 4:36 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed a 32.2% improvement of stress-ng.fanotify.ops_per_sec due to commit:
>
>
> commit: a8b98c808eab3ec8f1b5a64be967b0f4af4cae43 ("fanotify: fix permission model of unprivileged group")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
>

I guess now we know what caused the reported regression:
https://lore.kernel.org/lkml/20210511124632.GL24154@quack2.suse.cz/

I didn't know that capable() is so significant.

FWIW, here is a link to the test code:
https://github.com/ColinIanKing/stress-ng/blob/master/stress-fanotify.c#L474

It creates events in a loop by child process while the parent process
reads the generated events in a loop (on two different fanotify groups).

Thanks,
Amir.
