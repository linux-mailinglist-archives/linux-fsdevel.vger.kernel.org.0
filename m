Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3CA6A88BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCBSwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCBSv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:51:59 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17624C85;
        Thu,  2 Mar 2023 10:51:56 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bh20so14334994oib.9;
        Thu, 02 Mar 2023 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677783116;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4miANRftKXvw3pXYRIpYFtXe5ceS+myUMxfIqC9f6g=;
        b=eNTLwlcwVO9qt7WefOE/XSaVIJNFp3TkE3k79MaNYDmvuzhbrXB1q7do4Bwg4uyf//
         HpuBJwSTrpJUE1IWFrIM/cAQQnspE7NJH8t/uARIWuCNC1z+kyd2/C5gDB0cNVprK77k
         PkBZfGkNZFXL04GJ1qnNvAPo+NaINpS+y0yodzxbUVGKpY/pLEE/6pR1OnmDtsQNBCMk
         P6jzmTJxsjtugzXKq7zeUTWCg49fmIkciZLhrdRlZ+j4+25o2YFaGMS9FOl1yWi1dd0X
         1ByeOBMmrdHUK1A03dQ+ZFEpQU1nvIGo34NZDAgGRU/9ej7S4R2sRyRXuf1Bc7lh5ezZ
         63Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783116;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4miANRftKXvw3pXYRIpYFtXe5ceS+myUMxfIqC9f6g=;
        b=rzUZFdN5SKbH/67HOw2xj+Ha2DU/R25mJcQN8nq4sSeMtrkP0TFNjNRJMRPnLAfPk5
         YhRTe05VMBNvNSQb6wDYyqqIo3YIvdiuqtZxbvUwM2eE60Z2fNmL7eErf2TIJLQAjEhJ
         l4QhlOmSzY0Lao30v2WDEIubu2o695KLcwZa+g8qZ6vh7FX2itpNZsX5UpdvDp39CGIR
         ipSBK8PYoU8kTcs7/YdMmLf5oIKXu/FnE+pVDEIUlEM+S8A/z+nsTq9cK3eqVPQppiHR
         8Kt5Vozc2vDNXJgh27Kr6wzm+cat0y5VzRfRwr7IFi+hZAndLdxbuagsck1qwGN2IEhX
         saHQ==
X-Gm-Message-State: AO0yUKXau+Ggucz4wKQn5HLs1YKvbfvtmF71aYy6tZSvt3ceAxj3KFgD
        Qm2IshrMxNfV8kOfNJrGo54dfyydvuMweRVg6T0=
X-Google-Smtp-Source: AK7set8etazuQfWIK1AczOuew0I3NCmGN8J9YEHY9RTCA/pE6sM0ooCMbqPCnY41ITM7XwmeL6pSLFygSIv5F50p5Sk=
X-Received: by 2002:a05:6808:d3:b0:378:74af:45ef with SMTP id
 t19-20020a05680800d300b0037874af45efmr3358790oic.11.1677783116012; Thu, 02
 Mar 2023 10:51:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4304:0:b0:4c1:4768:8c59 with HTTP; Thu, 2 Mar 2023
 10:51:55 -0800 (PST)
In-Reply-To: <ZADuWxU963sInrj/@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <ZADuWxU963sInrj/@ZenIV>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 2 Mar 2023 19:51:55 +0100
Message-ID: <CAGudoHFUkchB93rvOSFgBxkLJWT59hyGs==uTcvtO3pKyekxvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On 3/2/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Mar 02, 2023 at 07:22:17PM +0100, Mateusz Guzik wrote:
>
>> Ops, I meant "names_cache", here:
>> 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
>> 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
>>
>> it is fs/dcache.c and I brainfarted into the above.
>
> So you mean __getname() stuff?
>

yes. do some lookups in a loop on a kernel built with
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y (there may be a runtime switch for
it?) and  you will see memset using most time in perf top

-- 
Mateusz Guzik <mjguzik gmail.com>
