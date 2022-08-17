Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96142597833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiHQUnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiHQUnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:43:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8C3A74CF;
        Wed, 17 Aug 2022 13:43:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r141so7950219iod.4;
        Wed, 17 Aug 2022 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=flLMMg4lOTziu7pnj4Cz7kZJFJokj6zHiYI6/zZRrzU=;
        b=UktBwupl2oAOo+aFSE09VhcRhVk896RgC8L7XC9KPp/PQ6q0btqYt6fEPAQDeETP2J
         RCFAzKrb84LlswloBcCT+T0GJ1Bbnrz1VuPnoJnrbhG+aP3vVp/LGpMHr1jLxd9WlDNQ
         Np8VkFiFKmz0iNh+UFprCMxsoR3GBAF7XxY2UL8kLvymz+dstqpFWTfm/LqzQVbm4AKZ
         6g66lD8Li9H5QMHUjNnF8R+Lm326raJ4NvaSnTM65sBpIL3IdZhM6N37VRZIrZsTf+5u
         bXvN/rBbS6oHislsHY4q/obX5Hw++iVyFjK2Ry0tJE6dMkPH0lBOXbnXabSwFmAjWnfl
         BIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=flLMMg4lOTziu7pnj4Cz7kZJFJokj6zHiYI6/zZRrzU=;
        b=PMOnXFZC5Yb7nBhOH/cJQPUZaY/N3VVEykxjfs83hijE1m2qNb7eINOFnhRZ5aOXLl
         kZtIV0u3x8Zq667su2fnBQid2JPCf6OWV9VijG355XgRUHLtv/IlrPiHqHLAmoD3wuoa
         PPSuxWqXc79aJ7n11RT1vLCe7KVXY+oL8waEcM3ZBbrtJslOa7LfygRBTsBz1+8780U5
         mXyfEinSWfORGyDH5YlkEDZnn5GamR5r/exfY/2Lm9GlCgsDlGBtpKrdOhAkNJtxWUDv
         aaNbzpUtve9HJdQfqAAkoPj0d+rTks5/INB81JrlPVAKt+K9402NIriTKXjJpRhNWn7L
         Kwug==
X-Gm-Message-State: ACgBeo0Z3ibqdFgm4WfmCx3b/Mo8h5SMfEyUqBkp8v7KGhNaGroqRvhJ
        4WPXWsaCqrNSNSXAyGU9vTxcYmXaGHZi9h33UdY=
X-Google-Smtp-Source: AA6agR49EF/XbMYGpebUExo2BR0Oz46oUhF4XphalGp81w0rra22T0ilBDpuxcmwUdmlTlMczJECsE6m1Tg1wbrxSIo=
X-Received: by 2002:a05:6638:2194:b0:342:7ed1:66f with SMTP id
 s20-20020a056638219400b003427ed1066fmr9226jaj.186.1660769027186; Wed, 17 Aug
 2022 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-28-ojeda@kernel.org>
 <202208171328.8C3541A@keescook>
In-Reply-To: <202208171328.8C3541A@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 22:43:35 +0200
Message-ID: <CANiq72ki+W_0EOUS3JR_EAFdqMdYHizguajDswmfMUwSC1QxaA@mail.gmail.com>
Subject: Re: [PATCH v9 27/27] MAINTAINERS: Rust
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks a lot for all the reviews Kees!

In case you are wondering, I removed your previous Review of this one
too since we got some new `R` lines. I guessed you would have been OK
either way given new names are trivial, but it did change a fair % of
the patch, so I played it safe... :-)

Cheers,
Miguel
