Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D44602174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJRCwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRCww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:52:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB60857F9;
        Mon, 17 Oct 2022 19:52:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o12so11994284lfq.9;
        Mon, 17 Oct 2022 19:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9M6zSM2YI+mr2xkSzd7bZIJc0rGYX5w30o9ggxyac70=;
        b=micluZpS+rdPpy7sIsZANMa5tslB3dvnpJSnGFkT30l3hPlHqlrFHzChtx8nL/fxAh
         TUO4BaMZWLOLtX+nf74D6X+wS+lOeqEi2JOhi1afjhzIkzoz2H6XJp0vO7p9Dzh68rEk
         PXNVStgIhbyo/4qKT1BJuzIfbYhfjKXHLUs6KHHXvEkNRTzti5VgLsHM3EM6bq6Hchh1
         2rgSg+wh0Ev+eUIGmBwam1La5dSTilfH3cUddU0RhYDovEhs43vNzqIGVDY/Fy5Pjaw1
         7iTP/KavCCsdSYNxPQwgSUFBqHCQ7PRR0vmHRvjRJ1BM191hObqGkQQGQqS1pJa2yN2n
         1sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9M6zSM2YI+mr2xkSzd7bZIJc0rGYX5w30o9ggxyac70=;
        b=4jQihP+P/P/ArfPIxruSFDmlcmhWu5fU6OVXnY1EzgbRglSI9CQx3uVl7o7b03CD+f
         wHMyLZI+Dyp0bjeLmtm+JuT53t0ht7apaTCtnUyZNzHEY6q0sQY6ORX9o/DTQnmha/+/
         4KVrGQPxDQpfbm36Cm3+i0aVt5JsHgWZDwyZBa3/BJZy+b3blrwI6g9T+k/5gbg4qh1G
         rfKvC/252H14rLgRMe30mE0GMgumuUB5dG+/9LL4x+KDDa/jZwQf9Vxv78OY8VPoaP4O
         wSgHFeLzDdQJfDT50YdGLhixHAHfj6OHZE5v59Qsc0VRGEH2hV4DPbdfMrVPeqhlWwLq
         fwOw==
X-Gm-Message-State: ACrzQf0Y+9Ms3SkUvGWTs+Ax5ba3Krs3tjKYjJ4xDHlMdbWMBYxe9n9y
        xKxkI0FgbgUPgJaV2gEVM5NbStVzfYYJDHDPIXQ=
X-Google-Smtp-Source: AMsMyM57cwzckKxi0qqdRvUuUq1kK1M5roDiPHZ0/++9LYQbPOmDIfnGPngZDvxbepfRUyjgpxvLn8wXUyzhmmps/zY=
X-Received: by 2002:a05:6512:12c5:b0:4a2:6c32:5c5e with SMTP id
 p5-20020a05651212c500b004a26c325c5emr211949lfg.464.1666061568857; Mon, 17 Oct
 2022 19:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
In-Reply-To: <Y017BeC64GDb3Kg7@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 18 Oct 2022 10:52:19 +0800
Message-ID: <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 11:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 17, 2022 at 01:34:13PM +0800, Zhaoyang Huang wrote:
> > On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > > suggest skip this page to break the live lock as a workaround.
> > >
> > > No, the underlying bug should be fixed.
>
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Understand. IMHO, find_get_entry actruely works as an open API dealing
with different kinds of address_spaces page cache, which requires high
robustness to deal with any corner cases. Take the current problem as
example, the inode with fault page(refcount=0) could remain on the
sb's list without live lock problem.
>
> > OK, could I move the xas like below?
> >
> > +     if (!folio_try_get_rcu(folio)) {
> > +             xas_next_offset(xas);
> >               goto reset;
> > +     }
