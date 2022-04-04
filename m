Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC084F0DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 05:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbiDDDM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376978AbiDDDMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858472CE16;
        Sun,  3 Apr 2022 20:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC0BE61001;
        Mon,  4 Apr 2022 03:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DA2C34111;
        Mon,  4 Apr 2022 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649041859;
        bh=WnI3wJJrpF3J4fgQkw88XFffWu+S8qyrSAo4X5/dF0Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HUw26i7MdMdgoWEFHNvBZFE2ceBT6BU9p8GnN0cRseX8y0FuRfraODG8omFqQBN5U
         SaUCbZREmqM+fiWeA22cx2Ec95aPlaG42eJnipXcG5D3hYyGgLG4vy68jsg0mWQXtR
         BAJw07xio8A/+v+GF4p9tvsjuN/vgOuV8wHYgqEL07OR2Q6OykY9Vmrwy2gaS0EgYG
         My8lMHSKBWin2cgveX0jbMJZcn7sVG40xQBAaxbB0nQ7nf+PTfhEs9gGsRgZ264Ior
         KYgWzE1z78l+6esE2WZ5dHEtqbpwEWsQA9jLusOqDNzpBYZnrZYHFw4SMA5wHa5Tl0
         2m4s/t++IwoHg==
Received: by mail-wr1-f47.google.com with SMTP id w21so12472174wra.2;
        Sun, 03 Apr 2022 20:10:59 -0700 (PDT)
X-Gm-Message-State: AOAM531fduVBjsFrItfEzgLXuPhlqpOL7YrznOw2M7fJ1A0Fm+8BVH73
        0Zir4ukOrHUMhbZ5DbV2q3ZhqDqFN02vfz7fpvc=
X-Google-Smtp-Source: ABdhPJzBgFK/zNrvvxfmgebxuYtV+t3d0QoITB3yhHk4SiYCDLeM0rZdEKTqeElDWXPUWmCdK22mQ3XvuqG1Cdb/cHY=
X-Received: by 2002:a05:6000:1184:b0:203:ff46:1d72 with SMTP id
 g4-20020a056000118400b00203ff461d72mr15722276wrx.165.1649041857496; Sun, 03
 Apr 2022 20:10:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Sun, 3 Apr 2022 20:10:56
 -0700 (PDT)
In-Reply-To: <HK2PR04MB3891851AB34913F3CC2561F2811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891851AB34913F3CC2561F2811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 4 Apr 2022 12:10:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ztRK9bOo3dtEjx+3sZoFLpa2yfdCczND3bFvrQ=i9Nw@mail.gmail.com>
Message-ID: <CAKYAXd8ztRK9bOo3dtEjx+3sZoFLpa2yfdCczND3bFvrQ=i9Nw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix referencing wrong parent dir info after renaming
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-25 18:42 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> exfat_update_parent_info() is a workaround for the bug, but it only
> fixes the rename system call, not by fixing the root cause, the bug
> still causes other system calls to fail.
>
> In this patch series, the first patch fixes the bug by fixing the root
> cause. After it, exfat_update_parent_info() is no longer needed. So the
> second patch removes exfat_update_parent_info().
>
> Yuezhang Mo (2):
>   exfat: fix referencing wrong parent directory information after
>     renaming
>   exfat: remove exfat_update_parent_info()
>
>  fs/exfat/namei.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
Applied, Thanks for your patch!
>
> --
> 2.25.1
>
>
