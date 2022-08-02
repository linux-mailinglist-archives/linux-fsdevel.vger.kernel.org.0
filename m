Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F113587E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiHBORI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiHBORH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:17:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67001D0E9;
        Tue,  2 Aug 2022 07:17:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id c185so10723396iof.7;
        Tue, 02 Aug 2022 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzbPWwhcEKIUb5XmuwsXZk0WHu1HAmpGHak33W/hz4Y=;
        b=SY+mGld3c8Zk5Jxf7IddnvW31p46/D08XTmBEhxsrkVs4fSRF9TXUtbmjH5o29Gxrt
         bM66MbluvwjQq1o0MRDc/b6vnsKl1e+6ofpDuhtDNVKZb08z8wTfrEPdcJSCiW6ofXiB
         qEuAm4F+ALOKrC2llY5tCHy3VoSjYivoxA06GuVSAfECweP/3IaLqi3p3FY6ucuhokla
         K4mOlgf3XQjAXVMtSZachXXq7XaOA4DS7qtJwOaRv8mXGyQ+Z+gZE4oZIhwUV0zcSiun
         FkleluOQc7MJ6OTzXCqMZT9Pusj5PuHsJNZDnH4IvH4LGi5U09DMZvSX2vIPTdKNG3zj
         mTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzbPWwhcEKIUb5XmuwsXZk0WHu1HAmpGHak33W/hz4Y=;
        b=4QHRhzQlUIMfz5uWEjgBSqrAksiIxpP3EGJq00/PdqKM8flBjQNXrDXLDLrH84enxr
         d4I60Ahml3f0xw/wBDBpCpl3qKTsnuUVokq/d7CfUOEILszbtx0agfBvj5zCv/AXdaba
         Pl9khhd+FdMI7Dm8Gx3Vms+ehgLwINcZh2Ai11ktMfWqx5PZ8DvkiWAB4Qj1D67a1hv+
         c6FCjXXH0OEs1opGbIqfzCC0oqEA4NIVgh9JXRm9Jy8/UlmzK2hMrRIeNLz0+WYsJQp+
         7kLQlFp5wZWLWyEycLKM+Hm5FZSMvmY41S4F6hgPWkMyITjl+KEBDGcakIPKTMn6P4Ra
         Evlg==
X-Gm-Message-State: AJIora/qreJcgYlD2Wp1FAjJp2p5E1qSZWEJrL4DmxTXa87AvMnQ4I9k
        ss96/2IqXzVloH+seNKAFAPiTWNRVcMfFmD70kI=
X-Google-Smtp-Source: AGRyM1uIEC0PcctxDbe0s059lTbpgzq5joEE1C4fgSlA6DPH4iRSwaj5/x2NpdBckrK5+ERUo19alicmxyTxfHdCTU8=
X-Received: by 2002:a05:6638:25cb:b0:341:6546:1534 with SMTP id
 u11-20020a05663825cb00b0034165461534mr8193243jat.308.1659449825119; Tue, 02
 Aug 2022 07:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com> <YukrFS9NIMSP/I/Q@infradead.org>
In-Reply-To: <YukrFS9NIMSP/I/Q@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 16:16:53 +0200
Message-ID: <CANiq72=rRxQf+CLhDBpR7YFYkjSFKQoik082q5_bgh_AMCb3rQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/31] Rust support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Tue, Aug 2, 2022 at 3:48 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> handwaiving and pointing to git trees is not how Linux development
> works.  Please make sure all the patches go to the relevant lists
> and maintainers first, and actually do have ACKs.

Which hand-waving? In fact, we were requested to do it like this.

As for the Cc's, if any ML wants to be Cc'd for an abstraction we
create, even if no C code is modified on their side, I am more than
happy to Cc them. I can even do that by default, but not everyone may
want to hear about the Rust side just yet, so I have not been doing it
so far.

Cheers,
Miguel
