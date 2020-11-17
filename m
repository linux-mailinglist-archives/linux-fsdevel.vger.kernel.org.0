Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E352B726F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKQXaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 18:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKQXaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:30:18 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A84C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 15:30:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so230765lfa.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 15:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=HeuQ3NoSPHMV5vKQqErsUpbPU0jCzVO1YYw049IBFq1aeufNNpzqJb5qaTS2ZHfFe+
         WcUWdn6RMYtlbpqWvhE+FKQgR+SjxTvXaBlD3AxqZuA+NUcWqZcWsAHAfKnyuWsrg+Kw
         I+44mfRUd+9oWmJWHMV2sPLHW/pUwKHciZkoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=ZoL84W7iRP778cSKR+N2HYgJ8PWGOshJClz0d6VTAZl4GNpu9bB1W5rXZO5mm3M2xi
         r6RCF2lXDR8rLU4kzUF7Cp8I1DjcM9tyiDUTrhuFydKuZBmdwHLl/zxZCky01AqGGAhm
         ZslPWV46mbSLFokZAd6sQnEsQ3GckWckKiOKID+uDQqYgILI3yZYRcJVfG+y8l7M5RYd
         1WbOQs8TquKlVix6WByoT8UChl9P8m6rNydFSfmefGfwVCuecby4CsNE4b1Cor2famcD
         PYyjZNzGALIlNnVJGcis6rPBRECFtrXlZP0RBogjmitX4jqflPM6kGAYaabIjzmHKz2N
         pu/A==
X-Gm-Message-State: AOAM530FqNgOaSK64QCfVtmuhgYZhZk6V0RZpcQob3jRgqhugahGeoq1
        Dzk3h0U/K9m6kt8kr7HTeIDAmh1g9mVHyQ==
X-Google-Smtp-Source: ABdhPJybMLKvI5fcDaA+WyfJK+JSa/FLcJgIOGq5jP9sgmSybfYKr+XkR8XuUa1QmzptZzZK2nxivw==
X-Received: by 2002:a19:2291:: with SMTP id i139mr2854183lfi.592.1605655816688;
        Tue, 17 Nov 2020 15:30:16 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r141sm3327364lff.55.2020.11.17.15.30.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:30:11 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id s9so233141ljo.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 15:30:11 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr2679618lji.314.1605655810863;
 Tue, 17 Nov 2020 15:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com> <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
In-Reply-To: <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:29:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> I really wish it wasn't needed.

Seriously, I get the feeling that IMA is completely mis-designed, and
is doing actively bad things.

Who uses this "feature", and who cares? Because I would suggest you
just change the policy and be done with it.

            Linus
