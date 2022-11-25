Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E8638483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 08:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKYHiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 02:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYHiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:38:13 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D9275E5;
        Thu, 24 Nov 2022 23:38:11 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oyTHl-0003Az-TW; Fri, 25 Nov 2022 08:38:09 +0100
Message-ID: <687f308d-b221-9c2d-24c1-6a4417d27843@leemhuis.info>
Date:   Fri, 25 Nov 2022 08:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=5d_Bug=c2=a0216738_-_Addi?=
 =?UTF-8?Q?ng_O=5fAPPEND_to_O=5fRDWR_with_fcntl=28fd=2c_F=5fSETFL=29_does_no?=
 =?UTF-8?Q?t_work_on_overlayfs?=
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-unionfs@vger.kernel.org
References: <2505800d-8625-dab0-576a-3a0221954ba3@leemhuis.info>
 <Y3+jz5CVA9S+h2+b@ZenIV>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y3+jz5CVA9S+h2+b@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669361891;6b96b55d;
X-HE-SMSGID: 1oyTHl-0003Az-TW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.11.22 18:03, Al Viro wrote:
> On Thu, Nov 24, 2022 at 04:47:56PM +0100, Thorsten Leemhuis wrote:
> [...]

Al: thx for fixing this!

> I could pick it in vfs.git #fixes, or Miklos could put it through his tree.
> Miklos, which way would you prefer that to go?
>
> [PATCH] update ->f_iocb_flags when ovl_change_flags() modifies ->f_flags
> 
> ovl_change_flags() is an open-coded variant of fs/fcntl.c:setfl() and it got
> missed by 164f4064ca81e "keep iocb_flags() result cached in struct file";
> the same change applies there.
> 
> Reported-by: Pierre Labastie <pierre.labastie@neuf.fr>

Miklos, if you pick this up, could you for the sake of future code
archeologists please add this here:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216738

tia! To explain: Linus[1] and others considered proper link tags in
cases like this important, as they allow anyone to look into the
backstory weeks or years from now. That why they should be placed here,
as outlined by the documentation[2]. I care personally, because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)
