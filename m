Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A351B788
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 07:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiEEFpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEEFpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 01:45:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC4344C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 22:41:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so2496852qkp.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgl6bcxvrsduHKWNrBmYp9ujocqY0BkxsLS42bSwT88=;
        b=ezs2aUapfA/1lZc+Tuj5z9bCCQVPc+NhRchZ1uL0FI4FOgeNs0uckQUUaq+BCK8mqL
         c/Nrwt0BEtQBnRJ1teqcx1Yepe/77D/UDRrlbuGJObDUew65Cnw8peT4SBADQ3RLqRww
         7e12ZqNh9xt+4Km3re0Sd7/3lk5bXnYYnE1AgxcST1eplY7WaZPKpZ2ImcGORPV39YFQ
         TxIScCQ6XPh8MdvyU0f+7ZRGbJ1ES0qTynQpPmhe3fikFHRztE6vENiDR5KwXty99jPv
         SIekYXzD5LWCRtZPTKDt8wigAsWzvtjvEHbR2PfwnE4X7IZtjf5jMRj9QX89K8vBHhz1
         xHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgl6bcxvrsduHKWNrBmYp9ujocqY0BkxsLS42bSwT88=;
        b=yPsoIPuN16boEb3m2JTDq/xrTBGoEB2zhj6THF1ae8OcIvQEl96tRORllE+VJEABl0
         7cXS2hSMubGdbXHPj3Xs8Hcgou87iclwJHL/1xIPHt0i2QWtchdgpVbMPJmgm9TghG1m
         jm+O6MJEJVVfLSOTRz65Ad8bYJfc/xUBRh7yGIiTXH4b2v8Ul6yk3qAQzyzXJzjgW63N
         Lf/+JsnCByaI75Nw8z/C1Y7R+TvABiFtG5gavJKRntk7g45GlXjq+gSlaEt2zQUVJsKC
         t2xX4mXxaOAg7AOUUS2VqOieHUd+OcOm29JE2oYe4/Oh0sFDnae7Uqg+G2afYdel4ioc
         HPuA==
X-Gm-Message-State: AOAM530PI9TfKp4ZLVyCk7ohwSDfoAR1Z50GiCBlw8YwXqC2Di4mX/gN
        eLook0l2YnaF2OZJoH/aG5neZ80xYnF9d2Rd8q4=
X-Google-Smtp-Source: ABdhPJyBWOtfPLGxEGVMAaMKko4kuKy+jAX9if9W7XS4QdlV93FAIs1E+CSdEouLA+Fkv+U0cV+x36zdUWP+mTQWimg=
X-Received: by 2002:a37:9cd8:0:b0:69f:b618:c7ab with SMTP id
 f207-20020a379cd8000000b0069fb618c7abmr18792102qke.722.1651729280569; Wed, 04
 May 2022 22:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvq2yNtuFWOYWJ-QNGCXFni_SfunQLEQzrErNpjZ0Tk-w@mail.gmail.com>
In-Reply-To: <CAJfpegvq2yNtuFWOYWJ-QNGCXFni_SfunQLEQzrErNpjZ0Tk-w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 May 2022 08:41:09 +0300
Message-ID: <CAOQ4uxjqu4Ca1LTr2d5wB791Hd2FitOUyXdMQa95O2ttEjW-Gw@mail.gmail.com>
Subject: Re: adding mount notification to fanotify?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>
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

On Thu, May 5, 2022 at 7:28 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Here's David's patch, which introduces new infrastructure for this purpose:
>
> https://lore.kernel.org/all/158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk/
>
> I'm wondering if this could be added to fsnotify/fanotify instead?

I suppose we could.
Speaking of David's patch, I think that getting fanotify events via watch_queue
instead of read() could also be a nice improvement.

>
> After all, the events are very similar, except it's changes to the
> mount tree, not the dentry tree that need to be reported.
>

There is already one precedent to event on mount tree change in fsnotify -
inotify IN_UNMOUNT

Thanks,
Amir.
