Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B944A58BB89
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiHGPMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHGPMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:12:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D66380;
        Sun,  7 Aug 2022 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659885113;
        bh=A11bNpBA3/cowX4o1+e+twknnCZZvuX0J6fpcjIBQLo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cfhgfC0xXY7hMun2DEHOLcLTzB+K+AtBSZ/euu0OIGLYzKseZj5AuZRp/WUKCWDUN
         mav5cgb7QXJnNNYAXr6/bAmEvVImsZGmM3Dx2RPP9jbGaXGKBLfd1e4WkEve1HzzL4
         0B8Yq9EJ0/WxgBQa4yIZ/8vYvTSOuPvq7AWbwN3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.146.22]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1nmBbI0Vo5-00hLGD; Sun, 07
 Aug 2022 17:11:53 +0200
Message-ID: <16c2a025-0295-4b45-daa5-aae1ca7fefc9@gmx.de>
Date:   Sun, 7 Aug 2022 17:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] proc: Add get_task_cmdline_kernel() function
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20220801152016.36498-2-deller@gmx.de>
 <202208072219.zrLROtui-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202208072219.zrLROtui-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QUNoXCDz8SHSFzuPasLDc9Q2EdFXCHoxpiyYAgIfPBfOR5oYoui
 AV/561SjmS5SfPzDjoTe6EVVV40GkLpohs2a1LV0c0LiYNsZ7mG12ZPDxaPN/Oix5edli3i
 3rXru7X6r1Iqkwi63hSwgg7OCZJm+ujxUPoe4tf5Z/Em/h7ITKn+aQc4Rbnj8D3ncQmy3i0
 qMw3ejGpmPartBhA0Hc3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6IIX8zzv6DU=:Z8wJXja0Hx9SbyFVm+CVHE
 +L+NNIV2AqOepaj7g3ZImQ8Y6dxffhaRb983P7UtTI2y9cIxmYADgxhR+KIZ1RPGzgkdQeGgD
 Cip2xJ/hRYaZL8T3Xyg0isu8Hvs/zcu8W+lwqavxexlu0D/2Bs1zqouA2nA7/l9EspQKa7YMM
 qa2psgLZ3ZsYpTabi37CiKjzM/LbjOBT+Cx69VwMIJyPhpje+0YNLxm6YMd6YWQTXCdI7bpOs
 pWD9sD32MmzSiGkr0SZFfDy8aIpqXZ750afUZ7FGTaiyW8Hpz+vdFPyEn4+iEJZDCK5LIlvJ4
 zCfBLH9xDbdg70Do/gx539sELb/e9GCWfpS1SdS5nRX1u8gQVsJkmti06ykLClejtOyb73wNv
 m5yqMnDIJtQIhNJbheU8tSCciSvXa3K2kRCUyKvsxYEPkBF0Xv3xjK4cFvqotZvdR1TAQVPVs
 uyAIR14p5O1UVp8QzNewpoiMIvMk4X0eTI20w5u3MMdvMbl4kwFFln3E4+qWc1owPgO75Vhlg
 WrCVhr94f84VjK+EbRSU10yU6t9WoJJCS59FUaJ+wXMtkV70jaEsHS41Rq05KHgIUS5TxGVfL
 pBdmKGJyR3jm67CItujxWvn3mInE5LX754UumnCqe4Y0Uwad/hf5IMOspmKWN0imkT+4h9gvR
 /fKhL5tNl//sSGL5N/xA8PE9/q7zfMelSironC9gHvcuzhR2EUcN32MoBwk9LEgjRaUc1kipL
 Zxyc7QED8Y83mu8RmOnsQXRf5SssHjaRHF+BrE9SVzjIKgE/SIODW68helOviu+VHPbJNDuNC
 to/657k0WFBZw7ZIILQgfRDaakWIaWhwndgzr5gEG6ie84mD3GsIuilbQUWeev8YTMdUTNvIQ
 QnqGVIyO9Wpz3V2K+Kb9f8QiQHTKKc5+7h/+ABAgCIh5PLSXzfm481i3gJBH7msxMuU2b2WEP
 T9x7Kf77lkPOeXIqrL0otBjpKa+p3e/5/2333seF9DSFHmzUF8Mzf2nBGjA40u0aA1isGE8A6
 tjYaZBCkOWtc4hgdE2Qkdz5rNPKQbCF/PK5/Zz+gD4lTAofiJSF7gQC1ByKReT99SbgGkW39F
 0kMSszF2tYlatzAi3S2omMdZv5QnD5C1p6d
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/7/22 16:28, kernel test robot wrote:
> Hi Helge,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/x86/mm]
> [also build test WARNING on linus/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> [...]
>    include/linux/proc_fs.h:222:72: warning: omitting the parameter name =
in a function definition is a C2x extension [-Wc2x-extensions]
>    static inline void get_task_cmdline_kernel(struct task_struct *, char=
 *, size_t) { }
>                                                                         =
  ^
Will fix.

Thanks!
Helge
