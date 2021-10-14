Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE00842D008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJNBue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJNBud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:50:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62BC061746
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 18:48:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a73so4087431pge.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:user-agent:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=G1Xpwb6SXyk5zbi6Fvi2E0LkOB6JBHLvcrsIpB5EC3g=;
        b=PcrvY23euf8D5/i4CMCOuiPO8FAKwfmfwcpHZS1+juqDxXXuqna4otkgpmHvXR8Y+2
         R/KQ189IJNjEPWnDtRJ6vdS1hTwi5jzN8F4751Z5IyeJWMgInm4EHhoxDVSvZUKsV8hZ
         46bitD+AWsF3WigZlnAX0S+95uogXU83gnSxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=G1Xpwb6SXyk5zbi6Fvi2E0LkOB6JBHLvcrsIpB5EC3g=;
        b=eSap8R6+ocm/eM6bmoTrqKPr3JsdsG5/4rCt5mFkXo4v6Qf3gOViRQyFO9vuIy3Axi
         sDldRFHJYE5z7QjnGdJJBzL0l2LiCg4NQuLAfuftgzL4rCKCoz4Wya7T5OFd5sjKfe6h
         9SkxXeGBHFLBw8l0GJsKlxnfOr4ULMJ5krpmTyF6R5R3goc7yBGcGVmpYRjvgOM0DYxO
         uxR72ysT9DPqopMHQUiHjEbwGU/G9YDGclQkkj+0aosHnODE/4HvBaD6AFx5sn2zTyg+
         8h216cK4bkeplryy1vWzEp3uqHxtIaC/bXI1tvSiiONn19LMO9k6IsPmxjJUK2GCFsfh
         r0bQ==
X-Gm-Message-State: AOAM531BeKGfWTCV01A1vpqR6IlHyAsWDabMzpn9XxPWXwpg81lRwUaT
        8YzONMLuzeMjxiVKiQNhHNfqcQ==
X-Google-Smtp-Source: ABdhPJwMHQ3LniH7fm2Z/mg46eDU77wH2wgb9y+Wuze/dN/pJIVTQ8UH956qdAEsARS5UII7aAWIOw==
X-Received: by 2002:a05:6a00:a0a:b0:44c:52c9:bf25 with SMTP id p10-20020a056a000a0a00b0044c52c9bf25mr2513803pfh.24.1634176108743;
        Wed, 13 Oct 2021 18:48:28 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u24sm669808pfm.85.2021.10.13.18.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 18:48:28 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:48:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: The one and only "permission denied" in find /sys
User-Agent: K-9 Mail for Android
In-Reply-To: <cd81a57e-e2c1-03c5-d0da-f898babf92e7@landley.net>
References: <cd81a57e-e2c1-03c5-d0da-f898babf92e7@landley.net>
Message-ID: <7042EFC5-DA90-4B9A-951A-036889FD89CA@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On October 13, 2021 1:12:16 PM PDT, Rob Landley <rob@landley=2Enet> wrote:
>There is exactly one directory in the whole of sysfs that a normal user c=
an't
>read (at least on my stock devuan laptop):
>
>  $ find /sys -name potato
>  find: =E2=80=98/sys/fs/pstore=E2=80=99: Permission denied
>
>It's the "pstore" filesystem, it was explicitly broken by commit d7caa336=
87ce,
>and the commit seems to say this was to fix an issue that didn't exist ye=
t but
>might someday=2E

Right, so, the problem did certainly exist: there was a capability check f=
or opening the files, which made it difficult for pstore collector tools to=
 run with sane least privileges=2E Adjusting the root directory was the sim=
plest way to keep the files secure by default, and allow a system owner the=
 ability to delegate collector permissions to a user or group via just a ch=
mod on the root directory=2E

>Did whatever issue it was concerned about ever actually start happening? =
Why did
>you not change the permissions on the files _in_ the directory so they we=
ren't
>world readable instead? Should /dev/shm stop being world ls-able as well?

Making the per-file permissions configurable at runtime was more complex f=
or little additional gain=2E

/dev/shm has the benefit of having an existing permission model for each c=
reated file=2E

I wouldn't be opposed to a mount option to specify the default file owner/=
group, but it makes user space plumbing more difficult (i=2Ee=2E last I che=
cked, stuff like systemd tends to just mount kernel filesystems without opt=
ions)=2E

-Kees

--=20
Kees Cook
