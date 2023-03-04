Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1E6AAC79
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCDUmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 15:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDUmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:42:23 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C19813D66;
        Sat,  4 Mar 2023 12:42:22 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t22so4347613oiw.12;
        Sat, 04 Mar 2023 12:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677962542;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6A+lkGAA36imPClPUvyK1Oj/1mGA4QYHzNMLvCHSzGg=;
        b=hnkof/Ljt4H+uAYJCcodGlLzNPBBCka6TafMshG1e2mWJrikbr5sthB3jUMToe+1ry
         3zd4hKmTLO/zDXi8HGLosfYt+lXLItHICdWm3ZUBAjOhYjopkn7slegDQnokWt9rNksp
         CPbQG2hTbj46JXSg3uOyl7na33lY+LrGE8+ZTWLvYbuaG3DzPL3L5CtNvraPDIyVV1ff
         OCz6M1msYu7HQnUrX+ppDHsHA4WmHFZ2aoeZYcdgWWn/olDTxdUjh9u29f3fE2/nDg7x
         V/L4wrr2zxuFslu+0ES9qs+SMG9jw6P3Jtd/BEihqOpQ+Ay9SW5lzDFSR8cA4m5cGm0V
         M1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962542;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A+lkGAA36imPClPUvyK1Oj/1mGA4QYHzNMLvCHSzGg=;
        b=Si8QV0+YVGX3sFOmq9r7L1khItJ6H8LaEpCbWRPthSSEcfb5LFFQKsQBAQ8kUhiMIw
         aHpT2cKUCBuiE0+5yZaeKnTwQaDGBrD1+tPEQ1uUx6jr0vDsmHExD2vFff7Mqd0iqO4p
         eH6XUQUSI4H7IJhqMdCs29Chkm3d5nQvUX/pqgi5ES4U7oiKksMOsq1RPX6BBYCcZDaS
         xBOi+jWmH6C5k72LjqJlE7qDf+18qX3AQ2Fl9WJhckDuaxSPoi2Au9Wd0nFa5/vaa5ta
         p2CEyMENHO30WHzXYZbSIM1tS5QVXJ7awGSeQ6Ym+cOpvkMSgzoUEk/5C1CfM3QPDMVt
         gXwA==
X-Gm-Message-State: AO0yUKX9fwZGER9Y2fo2VunGnSk2yjDcCNj7hOjtDh7d8UapkT0MO83m
        PCbxZv2MxmgQ7A3XTeA0biq5B5jAYLzh01DGy4U=
X-Google-Smtp-Source: AK7set8Rs1QYDXu0qkMG7u5vSziTiaqw1wUpODsY7Tgu865vxSmEFsTOnPlibOeGKtkzYpujai68yHCJ+LlYmZIXeH8=
X-Received: by 2002:a05:6808:2098:b0:383:f981:b1e5 with SMTP id
 s24-20020a056808209800b00383f981b1e5mr4740995oiw.5.1677962541759; Sat, 04 Mar
 2023 12:42:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Sat, 4 Mar 2023
 12:42:21 -0800 (PST)
In-Reply-To: <ZAOnsOl+cXk9mTj5@ZenIV>
References: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com> <ZAOnsOl+cXk9mTj5@ZenIV>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 4 Mar 2023 21:42:21 +0100
Message-ID: <CAGudoHFf87OmvmS-wm92MyPC-3yyXMUw=-BTzSNmVLXrk55U5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Mar 03, 2023 at 09:39:11PM +0100, Mateusz Guzik wrote:
>
>> the allocation routine does not have any information about the size
>> available at compilation time, so has to resort to a memset call at
>> runtime. Instead, should this be:
>>
>> f = kmem_cache_alloc(...);
>> memset(f, 0, sizeof(*f));
>>
>> ... the compiler could in principle inititalize stuff as indicated by
>> code and emit zerofill for the rest. Interestingly, last I checked
>> neither clang nor gcc knew how to do it, they instead resort to a full
>> sized memset anyway, which is quite a bummer.
>
> For struct file I wouldn't expect a win from that, TBH.
>

That was mostly for illustrative purposes, but you are right -- turns
out the slab is 256 bytes in size per obj and only a small fraction of
it is inititalized in the allocation routine. Good candidate to always
punt to memset in the allocator as it happens now.

Bummer though, it is also one of the 2 most memset'ed during kernel
build. The other one allocated at the same rate is lsm_file_cache and
that's only 32 bytes in size, so it will get a win.

-- 
Mateusz Guzik <mjguzik gmail.com>
