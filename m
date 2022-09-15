Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9525B93B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 06:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIOEiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 00:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOEiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:38:13 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400129082A;
        Wed, 14 Sep 2022 21:38:12 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28F4bdIQ010245;
        Thu, 15 Sep 2022 13:37:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28F4bdIQ010245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663216660;
        bh=DTM4YhijXyqcWbuvEdtEKpJz/qh9PvPxWAryO5oWxio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ON3vNImgG/4YQMlg4PnTOgCrUDwC19e8KSxLihceviJOQd7o4BE4dML/KgP3ThV5o
         CkvL6z97u0Dmyt+uBXA8hAJwSif4vh/SY8Yaqe6L0PsQRtFEKtgex9cnp/GIbdYxU6
         dBpLVB4jnfvh3Xu7N4KMQ1d3HvJnPIqEwxLw+Sl9F1UpJon1OsrkNwPhwW/U87nb3C
         54vjRH8N33825QGNH0fVlunDMyFic2b/HgPMPBTJH64EyEyTe4bhWXFWmw/K7PeDCs
         gvHOU/oJe/1tnp843XFUltfU+0iWr6W2xNcEwM2LuS4l25xpDtGpaJXJWXKNwOzM7s
         KH5nmcrw/AZAw==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127d10b4f19so45771848fac.9;
        Wed, 14 Sep 2022 21:37:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo3979GuUQQEwjnV3pUUbAPDAWQmsPGUc41OPgClGs/Rjq7YCPba
        a5BX7AC0dTTUIC9zyiU5Pd99pTDd2vFantrC+Tc=
X-Google-Smtp-Source: AA6agR7b9TaS7ATuSBZ6wotnPypejf9sn5hN1J5SWKFwwD+u8ZLZcO5EGyIde2NLPjFovv7glVrxVbUZ7xcWaPi8Uh8=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr4235164oab.287.1663216658927; Wed, 14
 Sep 2022 21:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220908113449.259942-1-fe@dev.tdt.de> <CAK7LNAT3cyv07p7AZ54D=HOZRZ7-zLgMM+YPNLzcPidpDvXZgA@mail.gmail.com>
 <c8577c14a1663cbdea70534c086c247c@dev.tdt.de>
In-Reply-To: <c8577c14a1663cbdea70534c086c247c@dev.tdt.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 15 Sep 2022 13:37:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfQodG3tSYBs7ZAzsbkdwDS0=g=e8qJStfBi3BGut7Fw@mail.gmail.com>
Message-ID: <CAK7LNARfQodG3tSYBs7ZAzsbkdwDS0=g=e8qJStfBi3BGut7Fw@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: add compile time info
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Eckert.Florian@googlemail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 6:42 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> Hello Masahiro,
>
> thanks for your feedback.
>
> > https://patchwork.kernel.org/project/linux-kbuild/patch/20220828024003.28873-6-masahiroy@kernel.org/
> > lands, nobody cannot reference KBUILD_BUILD_TIMESTAMP,
> > then this whack-a-mole game will end.
>
> I was not aware of that problem. Thanks for the link.
>
> I understood that this is a bad idea to create the timestamp for proc
> like this!
> But how does it look in principle to offer the build timestamp in proc
> for reading?
> You have only made your point about creating the timestamp but not about
> reading it out via the proc directory.
>
> So far the timestamp is only readable as a string via dmesg.


init/version.c is the only file that can depend on the output of
the 'date' command.


You can follow what 'linux_proc_banner' does.

Define it in init/version.c, and declare it somewhere in a header file.





> Best regards
>
> Florian



-- 
Best Regards
Masahiro Yamada
