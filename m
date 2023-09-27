Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092BC7B0E07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjI0VaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjI0VaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:30:12 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FF11D;
        Wed, 27 Sep 2023 14:30:10 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57bbb38d5d4so3812508eaf.2;
        Wed, 27 Sep 2023 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850210; x=1696455010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJzpV19NBkkTGsjOq0krdPXI3rlCskOpfXrdIvSHv5k=;
        b=KTEabMJK7jeMqBvfU/pY1MmF/DIRq+x2uLkncaCDJuWMV9SeOycuKmd2GV7yNuot69
         38NL3D8tDJorqsEvAJykZafv7hRnYPUknCx579tRHcpDtVgCTTT944oDYHUjYO43W2FB
         F0edPuk1A24e61hOccl9Pi6HtcaUmobbFzFhC5giW68FlcCt3REROyNykzKxohoftVGW
         7V8MNhRXFcMzhJ/fWzHsF+KSRcEfYtLUPyETuJus5Jnok41pQa5wTRU55JUvMhjQjG99
         dCtNKceeohp73veFMPKh9S4rg+OYx42QqmZ5OiIAfsUPyTRmpWtynsZF6ZCNSohMRM8u
         Akag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850210; x=1696455010;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJzpV19NBkkTGsjOq0krdPXI3rlCskOpfXrdIvSHv5k=;
        b=Fc1hV9qTm1mgDxjXYmh0FBcJtnbF/2sDVzO8E/CZ5pRKS5cLexpPC2tntZ0yEuJyoS
         Qs33LXnnulRtCbbKi/M5o3Lu7v/VdsikCk4FdoA0tHCM60kRv5T2qoiWioMr0NG+USgx
         CKujgKVGLV/rArldwWXVk2WaPqqHIitOPy0MmXyh6GJ5SQZgeTAr8mJJszyZpkkQLKvc
         kQr0+luuk2f5OgrjKEMOQhuGAqS23s+JCmxp3OjeY9aU9MOFDuT2gM/jvNuZOUsxial7
         Ox1uE3VLRl8dfpu8rfepLVTlCNzX5wjWRQ7Gnsg955i/9eRSz0ZeMwufcfl2UphteufC
         v8OQ==
X-Gm-Message-State: AOJu0Yxn1mJb6BwNmHczvQq4wIN6VCwSiNBPM4C6/AFEnRTNiILR+syc
        xRD0XZT4JiiKJiksIkPnSH2NehTrXOWvDeOfAE8=
X-Google-Smtp-Source: AGHT+IGRFhOxDbPcgYlubdvnJ9picJg2eO2JEuLck5Q9B2jKHaoABtTzSlU69aMx/kEbQyCgGQAPNhrMkDECYIihrEY=
X-Received: by 2002:a4a:2a58:0:b0:57b:5e98:f733 with SMTP id
 x24-20020a4a2a58000000b0057b5e98f733mr3291680oox.3.1695850210025; Wed, 27 Sep
 2023 14:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1b45:b0:4f0:1250:dd51 with HTTP; Wed, 27 Sep 2023
 14:30:09 -0700 (PDT)
In-Reply-To: <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com> <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 27 Sep 2023 23:30:09 +0200
Message-ID: <CAGudoHHcSR=xUQ6XjC4b9UiDQC1ZLSU_Pon5O_er8mQbFpU6-g@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 27 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> I think you attached the wrong file, it has next to no changes and in
>> particular nothing for fd lookup.
>
> The fd lookup is already safe.
>
> It already does the whole "double-check the file pointer after doing
> the increment" for other reasons - namely the whole "oh, the file
> table can be re-allocated under us" thing.
>
> So the fd lookup needs rcu, but it does all the checks to make it all
> work with SLAB_TYPESAFE_BY_RCU.
>

Indeed, nice.

Sorry, I discounted the patch after not seeing anything for fd and
file_free_rcu still being there. Looked like a WIP.

I'm going to give it a spin tomorrow along with some benching.

-- 
Mateusz Guzik <mjguzik gmail.com>
