Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5495EE099
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiI1Pf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiI1Pe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:34:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536186173D;
        Wed, 28 Sep 2022 08:34:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id p10so411476iln.4;
        Wed, 28 Sep 2022 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7YMjbZ8J9tKgbU3lbB83+uhwQsHK55CjtoPPW43rcIs=;
        b=nNT6rlWUMZ0SnuEJDO14/3j3UbMTHEOYduj5E8ktaj4JO5Au5p8UggQZHYBM9s9GmC
         GPGoE10f0NsbRaD8tGugG3Lmnv8e6efNy4SAUsYAbFSGgKbXZJyRtmVuHhdsxWMtqSD6
         vFSZofQPWLVPySDWnU8vboBghzU4R82yvZwVX+nt+bSgQu9XrHFq1XEg0frnQPHw24Qs
         6FqPWpmk+NR10+DJu4YQN2hMVRaZ8hreQw/xR/1stVJHdElbahdC1o6/9sFtOYcZ3HFm
         ifyZxxNjnmLwvBXNDiqWHI8yYwuyMoklS7kVWGY+9QXmwsiKmJ1LncnkVZBxYd/l892C
         B+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7YMjbZ8J9tKgbU3lbB83+uhwQsHK55CjtoPPW43rcIs=;
        b=3Z6RzOgmGaTIkGMHvLSO0ktNHpp/qTVs5MssMbAB1bAgqOQ5iWfQu/bXSXeDNqCw2p
         eIuLgqiz6EbgM4U+X0DoV+qdOWX+f6QLxPGwbu+69hhhMkxL2SH9WEn3W64LlPhfFfAC
         IMB9bobyB7NliHzfhDMAWNbaG2j2kBk4t7fXbkzj/Tp+qUOuRGF97Xw+15pIjaFP+reg
         j2S9eN8a8w68wJaBWSDahsOPyfPCSm1SNIZj8xJLT4fgqyx+B4pgp5gy4WxeVa7hj3CC
         g2rwQkeiy+6kpIbFpsRmiFQfmVhP83eND0nlNGb2vSUuM7sX24VzRl1+fiPAqa7Pye7P
         ZiSQ==
X-Gm-Message-State: ACrzQf3wPZ04zxaGdMv/qXq9PR3zQH1aRb4Cw/XgIkh2UwQIANmJVKSZ
        /kRB8iy+7lYFQxlf3allFQsVFv+nzf2u4OwXvZfh817CSjA=
X-Google-Smtp-Source: AMsMyM5GmHEAKGvxhjbyKefQqMoHqYHsCmV0gzis+S9H+0AZni9Jyq1QNEECB5Z8RI13e4VdJP112o1DTRnVZBgEd6U=
X-Received: by 2002:a92:c569:0:b0:2f5:927d:b61a with SMTP id
 b9-20020a92c569000000b002f5927db61amr15812068ilj.151.1664379290391; Wed, 28
 Sep 2022 08:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <YzRjEc9zQbHeWPFL@liuwe-devbox-debian-v2>
In-Reply-To: <YzRjEc9zQbHeWPFL@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 17:34:39 +0200
Message-ID: <CANiq72kq4RR4suFjGUZeg6ua8X=KU5aBPKPgjRH29hOVmDiNLQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/27] Rust support
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        live-patching@vger.kernel.org
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

On Wed, Sep 28, 2022 at 5:07 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> I cannot find this patch in my inbox. That's probably filtered out by
> the mailing list since it is too big.

The patch reached lore in case you want to double-check:

    https://lore.kernel.org/lkml/20220927131518.30000-8-ojeda@kernel.org/

I am Cc'ing patches@lists.linux.dev as suggested by Konstantin to
reduce the chance of problems, though I wouldn't expect to have issues
now since it is fairly smaller than v8 where we hit the issue.

Cheers,
Miguel
