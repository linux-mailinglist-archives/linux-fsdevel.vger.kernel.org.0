Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48AE4DD8AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 12:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiCRLGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 07:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiCRLGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:06:23 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D623AF3A4B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 04:05:03 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so9686222oos.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqI4qr2RIuecj0D6NrrwPhV6OscupBLFqxtr225URlk=;
        b=O8w3Tx+ZhPP04f+0VXNbAtK7tut9Em/y6b0XPKfT3TExczdrVkaySClXphpDJjswFG
         18AxBMs1GkvtVKjjnj0Rsc3D981jJYMpfdN8Sv23YaRAsrgP9r2/8N1OF3YQlY2ToI/q
         Br0EhP9EHjLtVekf2sRBtVd7nc2GCVyO7lQFiY2ktKVWJAjE+x/fJnRSGZdeyeOAc/O0
         kbqxr7YQO400NDTjwkOyw4JfK0aPYb8oqxZZI70eXScDAIQbSIhuSykxtkpN7xIKTKbv
         GgZbjJWKjybMsUYo1+1MXn5zpRWqeqJYHGAqIF2IuRfbcUTH39IHNM6T8tdZs2aIFygR
         djLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqI4qr2RIuecj0D6NrrwPhV6OscupBLFqxtr225URlk=;
        b=a3PGSnvPtF2SDYSq4H+z/sUEc3CoyeCsxFf+fgk2dvbGI7M3knmzWyKilEP3zuuNfj
         W2GdL//qiw+zwE7FXJDAN/n8mWAV2jty3eLc/LeLXYSjqvOklb4Lee4/Y+dXSEkjPKgL
         tm4IrGRxihNqGpZjwqnlDQ90R2w7MmauhhWqKgRTyyI6odmmh/NARNWA3FWvQbkf11HR
         HIzDHkpNuroEv1mIeHVfcDWMnpPnHm+j3pmPU05FWLxb0wQS1eBm7rcYU5vKdUhnNhZ9
         yrIpinoYmLQMCWB+HgdMK2JMVVT6IyH136HhcInIFj2U/JtJcYC/zaBy8YKcIYb+uC8z
         qI0Q==
X-Gm-Message-State: AOAM532YUfR5b5Jfx1QcG20OoEqMWQDx6VlgikYLo8NuswMQXe/z2adj
        nT8gYIrT1sFjicZ5zhdJ8rp9GmbbO2SbrX1rJmPEJGUhrZI=
X-Google-Smtp-Source: ABdhPJzgQM0Ew7XCG0FxUimvZ93O5P5P0tCeoI32mGXx6HUzcKowKz6WUARxN6vnDGSh8etkzMJWAvz85FxawjcIRfs=
X-Received: by 2002:a05:6870:7393:b0:dd:9a31:96d1 with SMTP id
 z19-20020a056870739300b000dd9a3196d1mr5915855oam.98.1647601502862; Fri, 18
 Mar 2022 04:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com> <20220318103219.j744o5g5bmsneihz@quack3.lan>
In-Reply-To: <20220318103219.j744o5g5bmsneihz@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Mar 2022 13:04:51 +0200
Message-ID: <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

> > The problem that I was trying to avoid with FAN_MARK_VOLATILE is similar
> > to an existing UAPI problem with FAN_MARK_IGNORED_SURV_MODIFY -
> > This flag can only be set and not cleared and when set it affects all the events
> > set in the mask prior to that time, leading to unpredictable results.
> >
> > Let's say a user sets FAN_CLOSE in ignored mask without _SURV_MODIFY
> > and later sets FAN_OPEN  in ignored mask with _SURV_MODIFY.
> > Does the ignored mask now include FAN_CLOSE? That depends
> > whether or not FAN_MODIFY event took place between the two calls.
>
> Yeah, but with FAN_MARK_VOLATILE the problem also goes the other way
> around. If I set FAN_MARK_VOLATILE on some inode and later add something to
> a normal mask, I might be rightfully surprised when the mark gets evicted
> and thus I will not get events I'm expecting. Granted the application would
> be stepping on its own toes because marks are "merged" only for the same
> notification group but still it could be surprising and avoiding such
> mishaps would probably involve extra tracking on the application side.
>
> The problem essentially lies in mixing mark "flags" (ONDIR, ON_CHILD,
> VOLATILE, SURV_MODIFY) with mark mask. Mark operations with identical set
> of flags can be merged without troubles but once flags are different
> results of the merge are always "interesting". So far the consequences were
> mostly benign (getting more events than the application may have expected)
> but with FAN_MARK_VOLATILE we can also start loosing events and that is
> more serious.
>
> So far my thinking is that we either follow the path of possibly generating
> more events than necessary (i.e., any merge of two masks that do not both
> have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE) or we rework the
> whole mark API (and implementation!) to completely avoid these strange
> effects of flag merging. I don't like FAN_MARK_CREATE much because IMO it
> solves only half of the problem - when new mark with a flag wants to merge
> with an existing mark, but does not solve the other half when some other
> mark wants to merge to a mark with a flag. Thoughts?
>

Yes. Just one thought.
My applications never needed to change the mark mask after it was
set and I don't really see a huge use case for changing the mask
once it was set (besides removing the entire mark).

So instead of FAN_MARK_CREATE, we may try to see if FAN_MARK_CONST
results in something that is useful and not too complicated to implement
and document.

IMO using a "const" initialization for the "volatile" mark is not such a big
limitation and should not cripple the feature.

Thoughts?

Thanks,
Amir.
