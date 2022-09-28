Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133F35EE0B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiI1PkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiI1PkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:40:06 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902336CF65;
        Wed, 28 Sep 2022 08:40:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1231622wmq.1;
        Wed, 28 Sep 2022 08:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HSBLIy2wOhHMm573WWPq9D1e9V4c0tZPrxVrvT9NSSE=;
        b=IvUBwufrzJozmf5CVsD4L74Hj5QVaHocrxSpCxtIPubwMT+iAFTq3i6/kSwFg5mXfO
         ZRx09QukJYLUlUR2bu05p4SxeydhGlk+3E3AijV0ESAqaxjOb4rrywfP0F1yUFWFLXnu
         LKP9sMx3hYNdbDMK/mCTaGoAWoqKysneM9EX4t4YDvI10fyBrAljNlx+6asNtJpYZMy3
         b+MfNuYp5O1k4wjHr3IX5dqWGTrqwy0o+AbafhNvz+yO/+LOMZGmOn8YWDtcBoXCO8e5
         5LpJEA16Zc7C73U4LXr685p0O4gy7SgJtCTO5Dr9kAX7QhyH+K61Ocqk1P6pHrHgMeY+
         Jx1w==
X-Gm-Message-State: ACrzQf0DOKFJwKMHEYxjqE/5CLbXRlrLJWWfsQA3AWTwgQCn5vu19oEx
        7K2yNvlv1o/o1J1fbaUOaAuk0YJukGA=
X-Google-Smtp-Source: AMsMyM6Nti507HecckDJdH/30Vu0j/BfTGxBT7cEv75He4SA260GFty47XQmD/b/IgslxSb9dS8tGw==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id n20-20020a05600c501400b003b5088958a5mr7340624wmr.140.1664379604198;
        Wed, 28 Sep 2022 08:40:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003b339438733sm2210557wmb.19.2022.09.28.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:40:03 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:40:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v10 00/27] Rust support
Message-ID: <YzRq0Xz6yW+iwPaO@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <YzRjEc9zQbHeWPFL@liuwe-devbox-debian-v2>
 <CANiq72kq4RR4suFjGUZeg6ua8X=KU5aBPKPgjRH29hOVmDiNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kq4RR4suFjGUZeg6ua8X=KU5aBPKPgjRH29hOVmDiNLQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:34:39PM +0200, Miguel Ojeda wrote:
> On Wed, Sep 28, 2022 at 5:07 PM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > I cannot find this patch in my inbox. That's probably filtered out by
> > the mailing list since it is too big.
> 
> The patch reached lore in case you want to double-check:
> 
>     https://lore.kernel.org/lkml/20220927131518.30000-8-ojeda@kernel.org/
> 

I eyeballed it. Looks like it is the same one on GitHub.
