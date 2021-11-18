Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBDE456444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 21:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhKRUgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 15:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhKRUgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:36:09 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE87C06173E;
        Thu, 18 Nov 2021 12:33:09 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h23so7878400ila.4;
        Thu, 18 Nov 2021 12:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyTlozApB7Cn3WYv2QGUQ2usO+JOsj2om14zfMsi/V0=;
        b=KIZmhLUJnxlibQakZ4sSihWlExAMKhdgIeUyFgE16sOKh3ZmI9K3yNz4RFeTY02ZMw
         6elMv2plzKFkmTkbNvSHtsV3M8zszL7SHYt4LEIrNzVhhvXh97oLwa1I/J8Udf1QrcPX
         nyqAZxA/hOMfTAvSyZ7lo8G5pTXBkQVUc/wLwpHSo5HlMzGlLTdIYYPaI90lgZ0kMH+0
         1ilefnLO43msnpRwRaFCNpIOUzFEiss8WzdfHgYlUIenCOMxEP+PRJ7vjM+Y1NMb8mtG
         WiXWZVJkBkWmuNZyRqkFmsjwlIbyJ71ASY2+BTuA8Zp2UyytvQCuL+7zAFVTC460Tf3G
         T+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyTlozApB7Cn3WYv2QGUQ2usO+JOsj2om14zfMsi/V0=;
        b=xoOjyS94QHixzUB8/OdelPL/T3UQCZccsl1Gzfw/5bpgZWs3JuEAAGLB+k26gRmnkB
         MrbJoiU3+zCgXi3oaofWN0OlGZLlAcHNYSU6+x7VCXsRCc2GTC5PVylL/fi6MK0V1ILk
         vS/6BvpsA+1c9ovglPbSU9I2G4iU5OTrS8dAk8I9s+f0TW4GUQhxUSWa88vI9EdBRdLQ
         cVhqkF+PT8WLUHPGh4j+N4iNawIMY7XT35hqe7AZoM8vPsk4ok66ryvgh4U9zWyG0v66
         zsBEAZFps6X+f/kExwPW07iAO4lCFIKwnii6upidxp1SG7JMh7KPUbmgNF8IOIzcyMGC
         WmdQ==
X-Gm-Message-State: AOAM533yUl+8mjgYNEEtPYtimp+H+LANvgnnGE2iiObXNzU+QoNqewXc
        Lh2VR9la04q29q+iGTPU27OgG3f4eg5QhJA4RQU=
X-Google-Smtp-Source: ABdhPJwiVmhqZn50FP2evjzUqOYGkWeTTM9jGCAYdFOl5EjJ3oPfcfpC2lCnXXhJxXe4tmsTnpo2D4rvFwlT5ouu/Ak=
X-Received: by 2002:a92:cf0d:: with SMTP id c13mr147792ilo.319.1637267588832;
 Thu, 18 Nov 2021 12:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <CA+FmFJBDwt52Z-dVGfuUcnRMiMtGPhK4cCQJ=J_fg0r3x-b6ng@mail.gmail.com>
 <CAOQ4uxjTRfwGrXuWjACZyEQTozxUHTabJsN7yH5wCJcAapm-6g@mail.gmail.com> <CA+FmFJB1MwPVeuTJ=MJxH7AV+T-3EiHZvXTzhrQBX0=EJKqC-Q@mail.gmail.com>
In-Reply-To: <CA+FmFJB1MwPVeuTJ=MJxH7AV+T-3EiHZvXTzhrQBX0=EJKqC-Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Nov 2021 22:32:57 +0200
Message-ID: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     David Anderson <dvander@google.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > It is something that is not at all easy to fix.
> > In the example above, instead of checking permissions against the
> > overlay inode (on "incoming" readdir) will need to check permissions of every
> > accessing user against all layers, before allowing access to the merged
> > directory content (which is cached).
> > A lot more work - and this is just for this one example.
>
> I see your point. If we could implement that, behind a mount flag, would that be
> an acceptable solution?
>

As I wrote, this is one specific problem that I identified.
If you propose a different behavior base on mount flag you should
be able to argue that is cannot be exploited to circumvent security
access policies, by peaking into cached copies of objects that the user
has no access to, or by any other way.

I have no idea how to implement what you want and prove that
it is safe.
Maybe if you explained the use case in greater details with some
examples someone could help you reach a possible solution.

Thanks,
Amir.
