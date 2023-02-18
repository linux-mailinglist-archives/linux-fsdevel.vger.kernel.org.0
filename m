Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B669BE01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Feb 2023 00:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBRXwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 18:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRXwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:52:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B7149BC;
        Sat, 18 Feb 2023 15:52:29 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o5so1336149wri.6;
        Sat, 18 Feb 2023 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IurkXbKU0Uh98z15pjTpabseFIcGPSYDg4/lF+reuT8=;
        b=YpVpz5quK/a/7tlf5VJ5LyciKVDsd1Ti5rU6fYEcWynldxAGJOALY8HKG3yuZsVG93
         7sBeOCfsSKZfyghJCDzalxWBKuimOXRxb6t42o43EjRdgCJZWBZarPIahPzXEnBoyCPG
         1bXDLI7bn4V5a+bvNob/U88FUWgTfNJa1FhioateqoAPcfvfc6SwDsrBwawX3mMA19d5
         N8A/s+yCkyBpSuw768NJcc/XLlmONEFle1cuVn3nrtUr6kpO2QPZgLLfjuY8pMwl9nMu
         G79aEGf/LZ6BLlfxT9fumix7aHHNpbhpgUYN1IQSCEUAmdwdPyi7dGCE7lQolDTmTBgT
         VtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IurkXbKU0Uh98z15pjTpabseFIcGPSYDg4/lF+reuT8=;
        b=u/YXv2yWMKotoAzlu66OJ9lChaihfpCO7ZmRefzK20eK5/C8bl3Bak52iA4te22Cn5
         7UxQkyn89Ohrr8wcujf6CF5AOb0HWt87bhRUCtBFuVdZnxbOnkaeBhrW9bsn3aDm+8ap
         rFYUB7ogW5mw7zMvsZO/Yjx/WYC1sU7VG/VxVfi9gSkpDsfgoDIn04EOHx4sCkK7aY6x
         LjoKogD4HvsKmxm5X8v/SDe5df7dFWVcL/m0TDiQIYkUtwZ8LU9elFGYGdZuaIPOtoXx
         YqhdPgrGesXXGgaG5EFnO7J1tFBzLWjRbm7hdBJZEQ1iblev6EUYNybeqMriXauVEoh/
         c6fw==
X-Gm-Message-State: AO0yUKVvVThIi99FPHNew4cLMSegmtPo1zEdIGLRPopS3D+0Q18W5A5+
        KKOZ9e5hHKNxOzeBwZWqtEoLMJEg3Oqwj9eYALs=
X-Google-Smtp-Source: AK7set/QUBNYJTCrFvPrvhPkeriY10NgFjgJ/EyfJdnqvzsBmCnhzu5m6ImJ2NA+FxPAHvt39xWFfobvOrt+gn978L4=
X-Received: by 2002:a5d:6e8a:0:b0:2c5:50db:e9fc with SMTP id
 k10-20020a5d6e8a000000b002c550dbe9fcmr63254wrz.674.1676764347865; Sat, 18 Feb
 2023 15:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-11-ericvh@kernel.org>
 <Y/Ch8o/6HVS8Iyeh@codewreck.org> <1983433.kCcYWV5373@silver>
 <CAFkjPT=xhEEedeYcyn1FFcngqOJf_+8ynz4zeLbsXPOGoY6aqw@mail.gmail.com> <Y/FiBbMQcEblQ/XR@codewreck.org>
In-Reply-To: <Y/FiBbMQcEblQ/XR@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 18 Feb 2023 17:52:15 -0600
Message-ID: <CAFkjPTk5GYk4mDR2+OcU1qsaW8Z7c-H8PQpJ0NrfgZRkx-4udA@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
To:     asmadeus@codewreck.org
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
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

On Sat, Feb 18, 2023 at 5:41 PM <asmadeus@codewreck.org> wrote:
>
> For clarity though I'd use writeback in the documentation, and keep mmap
> as a legacy mapping just for mount opts parsing; the behaviour is
> slightly different than it used to be (normal read/writes were sync) so
> it's good to be clear about that.
>

Yeah, that was my intent in the current form -- although it did occur to me
that at some point we might want something subtly different for mmap,
however, I couldn't ever work out in my head if there would be any way to
be consistent if we had mmap but no transient caching -- I guess one form
would be to only cache/buffer while file is mmapped which we should be
able to track and in that way it could be distinct from the others.

>
> Separating the two makes sense implementation-wise as well, I like this
> idea.
> What would the difference be between file_cache=writeback and loose?
> Do you plan some form of revalidation with writeback, e.g. using qid
> version that loose wouldn't do? (sorry if it's already done, I don't
> recall seeing that)
>

It would mostly have to do with when we validate the cache.  Loose
essentially means NEVER validate the cache and assume the cache
is always correct.  But in the file_cache= case we would only do it
for file contents
and not directory.

> fscache is currently a cache option but it's pretty much unrelated, we
> can have it as a separate option and alias cache=fscache to
> `file_cache=writeback(loose),dir_cache=loose,fscache=on`
> but on its own it ought to work with any level of file_cache and no
> dir_cache...
> The test matrix will be fun, though :|
>

Yeah - feels like fscache should just be seperate, but then it can follow
the consistency policies of file and/or dir as to when to revalidate with
server.

Test matrix is already a nightmare :). Right now I have a simple one
with multiple fstabs for various options (which I feed in with cpu), but
I'm gonna add this into my python notebook script so I can explore
all options (and all config options for 9p in the kernel configs) -- but
probably keep a smoke test "quick" regression as well.

> > It struck me as well with xattr enabled we may want to have separate
> > caches for xattr caching since it generates a load of traffic with
> > security on.
>
> xattr caching currently isn't done at all afaik, and it'd definitely
> make sense with any kind of dir_cache... That'd likely halve the
> requests for some find-like workloads.
> Probably another new option as well..

Yeah, I was going to tackle this after the dir cache stuff is fixed up.

      -eric
