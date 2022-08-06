Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0B58B538
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbiHFLXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbiHFLXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:23:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CE6320;
        Sat,  6 Aug 2022 04:23:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b12so2477932ils.9;
        Sat, 06 Aug 2022 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um1v1FrSCBFvVj7vNPvt2QZzZCYl4QtDmBW6UESDgwA=;
        b=QUa+QsnYh9cvzUYscq18TKSV3NJAdEQI9JP5mrkTCnTyNNiLCNWs4wUNegk2+bavFF
         sramTVQ/jBd9lIjNZ/K0LctPG+/50shDCsbEUDQFjVuxBI6zbiGxH0Bg5jQQjKOeGCHt
         vQ7QB0ZAngzih8tY3Sv9JIIS3K+gSEdgwjnPtrWMuPZYpc3Qy0HGzrSP6gcRG5P6tlFk
         Gbocjr9mZaYsVuSVrK77WgNt+jyrIb1k85dBHQMvu7A7ZUSIrvm0yorv0/2Hx8h9sHfl
         MNGFsq9UtdOK7lByFvZidEJVdx3OscdAypKgKIwYO42ynokMUusVLPzhkV6BwyMoR/4f
         AbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um1v1FrSCBFvVj7vNPvt2QZzZCYl4QtDmBW6UESDgwA=;
        b=gj6t53vKCrVOJw1UAY8rlz5GZsddgsOMzw+bKtNy8gCN4kBSVs18INHzSmeerkQFBU
         Evki7XwXv3Ot3juoh+30+WPn9v1rga9mzufxr2PJkZzvVj8wQBDeuH1HQfL83+8zDlD5
         XzVAhnDvm07C74zkfQ/+PXVK4jWo49ImoCkbyHWDZ2Q7IhEM4DVFWg80qxONNjdHsLA/
         fhikdZmcwB/YPtLnPy9qWvDfwHlzweBLDwTWi2yxAkm24aEEjhh4PU9r+U+veLfBKtWb
         +8G3MA13+hgDpgr/gG76pqrxfhOhaS+SFp5rNt7x2amRs1mMV3zchO6xYfCpCNAp/jr4
         q/Xg==
X-Gm-Message-State: ACgBeo32OUnpVNwmFzYhq0qE09/Wa+9SslcWVk32wma0nem82ryWR5Kf
        8javjhAwWdE+j5A3IyE6rezEeXCXSgcCqVmFFyI=
X-Google-Smtp-Source: AA6agR7qEC8iU/WaGU3JQe5au0X+zcl2gDqnJ72SDHmcqd6eC86RlGuRDU4TMA1Juf98d4Nn/szP9GBxXNRIAhTu/Yg=
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id
 m3-20020a056e021c2300b002dce4978b12mr4884021ilh.151.1659784984174; Sat, 06
 Aug 2022 04:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
In-Reply-To: <Yu5Bex9zU6KJpcEm@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Aug 2022 13:22:52 +0200
Message-ID: <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, torvalds@linux-foundation.org,
        viktor@v-gar.de, wedsonaf@google.com,
        Andreas Hindborg <andreas.hindborg@wdc.com>
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

On Sat, Aug 6, 2022 at 12:25 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> I sense possible problems here. It's common for a kernel code to pass
> flags during memory allocations.

Yes, of course. We will support this, but how exactly it will look
like, to what extent upstream Rust's `alloc` could support our use
cases, etc. has been on discussion for a long time.

For instance, see https://github.com/Rust-for-Linux/linux/pull/815 for
a potential extension trait approach with no allocator carried on the
type that Andreas wrote after a discussion in the last informal call:

    let a = Box::try_new_atomic(101)?;

Cheers,
Miguel
