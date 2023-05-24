Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B680710027
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 23:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEXVn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEXVn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 17:43:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2FFC
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:43:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so2869a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684964634; x=1687556634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cOVTbGx45JvQe7bISLPr9dxfTGNroVmeLZqE3iaMIHE=;
        b=kgvdR8dsXFc7L6OewJXKnWm7UljoC+7BF9kyTeeSAYcFUwAZwaPTybTncucn9F/g/S
         pz47HB4iGqTKXa9DrD4tQz6tTQp7GSaQ7XrfTY+44J2/oFPvWZ/GhfgCs3d2HhVZu2JN
         vw0PJIY3AFUGcaLUZspnCl1p9uLYasXydLqp/iU9onG/xEqCrq5+KKKRMyl1qUgUyr5o
         0H3m3WPYLf4fZR4ynHqhQaKm+Xq6ejWJODzgGHL+2mV+saWzbAafuaRIb1ulvxf1+D8X
         5bMPIlwsB0J/IrY+djx9swJIDkJpQKjoX07OymbZCpWUT7WM233lTZ3PhzPE1o2kA95B
         V0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684964634; x=1687556634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOVTbGx45JvQe7bISLPr9dxfTGNroVmeLZqE3iaMIHE=;
        b=FAtuUm8ZiKBlPlr0GFkiymokdzKHZvyZbmeEaX1vGJ10TW35InhK8eQUfisytnmvdN
         xziMBGxWRIy3x8/1LqsBTrqrJKoXSTqUBGcN4h39Y58DnSeHW1ApkK8hEbDphye3kmLj
         GnwxLL2JvNZzZlXlHO6ZliFri3Al4DXFogwC81nN6jhe7DPoIzk+mXpzhibCrGTm3BqC
         NFIJWh1D1SFOY9e/N1v3iM/bmJhWANW1HaWtnQtoNrAqfwcztROLVXONfmfMNvlNa6xu
         N204gVza8rP7FawJmGwJ0WY6Irgi47ssRqUZOs19YmeIShh2uLxUBec7TPpSS3cHofeU
         lA7A==
X-Gm-Message-State: AC+VfDxsLEK10HowIlKnWEWf2oqFan+gs4cSsuQbrqQsd1M1TifegUlc
        y5QJQm1xJFqHnOCNO2KMSrhfpJqDNIJTss9Q+JmpVw==
X-Google-Smtp-Source: ACHHUZ5/wDbK7kIVQj6FIKSO8KY2BmJ8WZmL8dnGx2kkxVh+2/BWmwqPsgMw2hdMTdjNWBcwNXyLmVVS2P/GMOCCh1Q=
X-Received: by 2002:a50:9e2a:0:b0:507:6632:bbbf with SMTP id
 z39-20020a509e2a000000b005076632bbbfmr42200ede.6.1684964633887; Wed, 24 May
 2023 14:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
In-Reply-To: <20230510.c667268d844f@gnoack.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 24 May 2023 14:43:18 -0700
Message-ID: <CALmYWFv4f=YsRFHvj4LTog4GY9NmfSOE6hZnJNOpCzPM-5G06g@mail.gmail.com>
Subject: Re: [RFC 0/4] Landlock: ioctl support
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the late reply.
>
> (Looking in the direction of Jeff Xu, who has inquired about Landlock
> for Chromium in the past -- do you happen to know in which ways you'd
> want to restrict ioctls, if you have that need? :))
>

Regarding this patch, here is some feedback from ChromeOS:
 - In the short term: we are looking to integrate Landlock into our
sandboxer, so the ability to restrict to a specific device is huge.
- Fundamentally though, in the effort of bringing process expected
behaviour closest to allowed behaviour, the ability to speak of
ioctl() path access in Landlock would be huge -- at least we can
continue to enumerate in policy what processes are allowed to do, even
if we still lack the ability to restrict individual ioctl commands for
a specific device node.

Regarding medium term:
My thoughts are, from software architecture point of view, it would be
nice to think in planes: i.e. Data plane / Control plane/ Signaling
Plane/Normal User Plane/Privileged User Plane. Let the application
define its planes, and assign operations to them. Landlock provides
data structure and syscall to construct the planes.

However, one thing I'm not sure is the third arg from ioctl:
int ioctl(int fd, unsigned long request, ...);
Is it possible for the driver to use the same request id, then put
whatever into the third arg ? how to deal with that effectively ?

For real world user cases, Dmitry Torokhov (added to list) can help.

PS: There is also lwn article about SELinux implementation of ioctl: [1]
[1] https://lwn.net/Articles/428140/

Thanks!
-Jeff Xu
