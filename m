Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060CB68F81C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBHTc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 14:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjBHTc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:32:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C345F48
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 11:32:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so13343096pgr.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulrUQLJUP9RxcM6ZD9CxmoB1+p/LmgjBqM64v5ROwNg=;
        b=Y/wZleiJgYDPwrKFBcrlT6u/1xcORwHwg87WEGQkc0RtFFNVVqtz+yNTJEUllPEFc0
         +bXL1ZBGllwAn5k5jAHnZzdVPjsI3nfCU7FOGg7doqM90u8cZwVlNEiKkD/oLtjyRAas
         xcclPYcRcRNy0VMcz8uuQEFaJ9CREVxPaU9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulrUQLJUP9RxcM6ZD9CxmoB1+p/LmgjBqM64v5ROwNg=;
        b=kHc+j4cs7OkFr7uuspAgcxu0LASzrzwmB9HbgDUPcY3yHG8+I10Awtbx4DtEtSB4NQ
         MmPorZp/1xq3oIV+BD4Zkj+bWtWVr7KOwOVRmzQ+NqJfMUHDBs2hn/GJNnfOJKmiUr3F
         baJfXfJsM8F+wHh8G9MS91JchSAsL0VKz1wQLh667i3QehcW33T3owMEfCRCxL0f1x9x
         E3EiFMGuDxNkZVfKi4p4lDDwCBpc32XKLbz6t3oOY/hBiMNLeQOYHJhL+51NHTOsQ+Zz
         WT9oF1VMDqjmAYjTQElmF2P0yLz8L6TOuvhgMSXhDIPt/gnpGki/zEwddHzbGbGhpG21
         /clw==
X-Gm-Message-State: AO0yUKUjdzfOEoRKuyq48LfCXJr8f0VqAjIaeh82K30Ma8f0KaFFqGRR
        /fMZJ0TdznSohTDSuOgBgD5nFA==
X-Google-Smtp-Source: AK7set+P7rm+dGDTETrU2yzMMvUtrqjrfbTlBVXOCaBnQQFdsubS7A0XGoLGi5keRbMZOiZCbhxF5Q==
X-Received: by 2002:a62:1b8a:0:b0:592:de72:4750 with SMTP id b132-20020a621b8a000000b00592de724750mr6518043pfb.23.1675884744778;
        Wed, 08 Feb 2023 11:32:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t2-20020a056a0021c200b0058173c4b3d1sm11604471pfj.80.2023.02.08.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:32:24 -0800 (PST)
Message-ID: <63e3f8c8.050a0220.c0b3f.434b@mx.google.com>
X-Google-Original-Message-ID: <202302081129.@keescook>
Date:   Wed, 8 Feb 2023 11:32:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     concord@gentoo.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
 <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
 <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

*thread necromancy*

On Tue, Apr 05, 2022 at 06:09:03PM +0200, Mickaël Salaün wrote:
> 
> On 05/04/2022 01:26, Linus Torvalds wrote:
> > On Mon, Apr 4, 2022 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:
> 
> [...]
> 
> > 
> > > I think this already exists as AT_EACCESS? It was added with
> > > faccessat2() itself, if I'm reading the history correctly.
> > 
> > Yeah, I noticed myself, I just hadn't looked (and I don't do enough
> > user-space programming to be aware of if that way).
> 
> I think AT_EACCESS should be usable with the new EXECVE_OK too.
> 
> 
> > 
> > > >      (a) "what about suid bits that user space cannot react to"
> > > 
> > > What do you mean here? Do you mean setid bits on the file itself?
> > 
> > Right.
> > 
> > Maybe we don't care.
> 
> I think we don't. I think the only corner case that could be different is
> for files that are executable, SUID and non-readable. In this case it
> wouldn't matter because userspace could not read the file, which is required
> for interpretation/execution. Anyway, S[GU]ID bits in scripts are just
> ignored by execve and we want to follow the same semantic.

Hi Mickaël,

Is there a new version of this being worked on? It would be really nice
to have the O_MAYEXEC/faccessat2() visibility for script execution control
in userspace. It seems like it would be mainly a respin of an earlier
version of this series before trusted_for() was proposed.

-Kees

-- 
Kees Cook
