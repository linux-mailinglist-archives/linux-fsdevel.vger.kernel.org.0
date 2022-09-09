Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053935B2DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 07:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIIFVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 01:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIFVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:21:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E910871E;
        Thu,  8 Sep 2022 22:20:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso438445wmq.1;
        Thu, 08 Sep 2022 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cSQ4+UnbkCFxaDoyGp968o38/aWImh1E+iqWIGwjYSQ=;
        b=dJ6Xpw7BMTki7FcbEf+mw/LkNEyh2YI4m9x9AfV4z1PzwnsrE0P60wtjYcwp31e7JX
         bSGywbZPwk777klHfqpXJz1PKLNfeSwhOILYoHxc7b7zgboGRsHRoZQ2JmGC3ddjsPrB
         OOcu6gl1p/q1GQKq2/wRdK6ZHwa7GlYoQ67j/7fY/NP/9JDoX6JDPgxr83Yo8wUi+DPn
         vp+a3LgPoprV9gUf+HIi9FFL7//55wbP8mx5zQUmUXeYHYQ7rsUI9wxc+W4khtR+jO04
         3lu9Z3qLfJ7dNBuqU8d2PQ6/iu3/TWDEeeVh6NTYcq2sDbuMcJSBrozq8SEVAxQkaCBq
         r0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cSQ4+UnbkCFxaDoyGp968o38/aWImh1E+iqWIGwjYSQ=;
        b=qDlrcBJKwyrKb60HItXVJjATJc7zWYsUTqd+EzNyTlAcoaPjKhekxQTpXV1glPlwro
         Gnl8H9nnzPNXAdHbLqu6S6ufjCItd+hL4W26GWTpJR+AEdtF3piMS6yUpGHSGQ2ckyDC
         RfRh8+knkqYPZ3Zw/4V3HPnUYBbZFDkhaWRVn6nnt6cweuuf/gkVKsG9QTUdpqbG2+zH
         IFSGLHag13ilnb2hBedeSBdEntAWt/n61ehZ0fC9Db4G4Gfmz2RqEU1P79Eu0uZMk4sm
         Fq176EuK/wD6nQv2ZIIiu3rHnyMfd4Tw4d8Hg6HC6Hus5A13hIWMPJgtaHt0nT1iwaxF
         9CZA==
X-Gm-Message-State: ACgBeo1vv6QvmDbq8R89C1ZATIE+oLgreT1as26Z4QZAfRkpfc9JZnwf
        KPPfYbe7twcJUO2J+tm882WQBZ5JmQ==
X-Google-Smtp-Source: AA6agR5YH2RUwqidv90/4ZoMLsgbx/beLcsi37C0isRw4dgaDT1Jbu8LuA3fapo3A0Ws1S6G4+zSPg==
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id n44-20020a05600c502c00b003a841e9cd32mr4174980wmr.177.1662700855002;
        Thu, 08 Sep 2022 22:20:55 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.190])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b002253af82fa7sm1198794wrm.9.2022.09.08.22.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:20:53 -0700 (PDT)
Date:   Fri, 9 Sep 2022 08:20:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jie2x Zhou <jie2x.zhou@intel.com>
Cc:     shuah@kernel.org, guozhengkui@vivo.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Philip Li <philip.li@intel.com>
Subject: Re: make run_tests -C proc: proc-pid-vm assertion failed.
Message-ID: <YxrNM3q2W8BARvj5@localhost.localdomain>
References: <20220909021916.43293-1-jie2x.zhou@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220909021916.43293-1-jie2x.zhou@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:19:16AM +0800, Jie2x Zhou wrote:
> hi,
> 
> The test error is caused by g_vsyscall set failed.


> Error output:
>  selftests: proc: proc-pid-vm
>  proc-pid-vm: proc-pid-vm.c:389: main: Assertion `rv == len' failed.
>  Aborted
> 
> g_vsyscall is set to 0.
> In proc-pid-vm.c:
> /*
>  * 0: vsyscall VMA doesn't exist        vsyscall=none
>  * 1: vsyscall VMA is r-xp              vsyscall=emulate
>  * 2: vsyscall VMA is --xp              vsyscall=xonly
>  */
> static int g_vsyscall;
> static const char *str_vsyscall;
> 
> static const char str_vsyscall_0[] = "";
> static const char str_vsyscall_1[] =
> "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
> static const char str_vsyscall_2[] =
> "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
> 
> The /proc/%u/maps output is:
> buf=100000000-100001000 r-xp 00000000 00:2d 2                                /tmp/#2 (deleted)
> ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
> 
> So the g_vsyscall should be 2 according to commentary(2: vsyscall VMA is --xp).
> Is it a bug?

Can't reproduce. Please, post "strace -f ./proc-pid-vm".
