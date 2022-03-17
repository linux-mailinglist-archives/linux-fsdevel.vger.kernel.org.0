Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DC4DBC71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 02:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiCQB27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358361AbiCQB2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F01EAC4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h1so4799726edj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4X0ye1R7E6Vo4MC211w7WY9WZ/7Q3fReVh7P7560P4k=;
        b=N6ZSZ8Ph7eiABP1o37mkgHP4+uGIu3jgQrZXh7Dn9e5IGu/P6kRi7fDu4PFGzCtzXg
         7zifTba4yE9Izmqbyi3AYxurV58PJXmLY5kSX/AQUsIRqVcF1lWX8S4NEo5Z7QK4fAug
         RJ4gkUZkhGUv7QknDlQMmYE2Nt7YTQ4dSOvFw3DXnZMVQkss8ktiMIY1W4ogMpRrwNrt
         Mx4ABIkIBlCcbp9CskTBPsj/Db367CPv/Dnpkt74J7CJ+CEYz2Q39MOKZ+38Knd+C5bv
         mcZpt/tTaMBgDruAnR6EHaKx7AvoIOGm/8O2tBUCk7+X5BwpRpLzxTV8NdrqoD+5FTR2
         fd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4X0ye1R7E6Vo4MC211w7WY9WZ/7Q3fReVh7P7560P4k=;
        b=JnaoOPiB8zg+QPmKVamBi9YmiBgTWd+ADroZMYZKlgu2hYxmKF2akTeqxSW/lYT7V6
         r+s5aTRcmPnAehLaj3OpAZ8yM4NqQgFD4pZecZk/xhnt5AJQkcK64LIX3UEDGxAh+lQ+
         v1lJyaRin250pwOG7pQ53k/ROOXYeXtZO45qTeQx6D0dceC4ZSKooDnUD8tXa2EX0WBS
         TmVCC3qoKbwx585ML2gBDA0zH0nokwlOZfozDPoM4Kflwa0iN5fINLaosIGvETxbNcab
         +iDz1dxnohxsWbrbAnriajwPI0PT4yGNCQtxamA/KyHNyPtzxMHEewBavSXVZD9y1dwF
         mTcw==
X-Gm-Message-State: AOAM530PzOFxJ/P3EyEJ9u2zD06qcmG4rDPIAIwyOYfrmEwPPBRvSAz9
        TB31iczccb35/f+scv2TyN8fx4/Dy7oGrEARRoI9
X-Google-Smtp-Source: ABdhPJwqC8RXOESLQdvVVq8pj/tOvJDSwoQ3b6OA2k0xBWNAZNnTD01ZmDN947akS0a+aBmeO35Kg5c2elFuOM7OO7g=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr2085214edc.232.1647480433254; Wed, 16
 Mar 2022 18:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-10-mic@digikod.net>
In-Reply-To: <20220221212522.320243-10-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:27:02 -0400
Message-ID: <CAHC9VhSmz1ga5NTu=vG3+Z+gxD8C+-W+k5UweUROe2p4BfjSTg@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] landlock: Document LANDLOCK_ACCESS_FS_REFER and
 ABI versioning
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Add LANDLOCK_ACCESS_FS_REFER in the example and properly check to only
> use it if the current kernel support it thanks to the Landlock ABI
> version.
>
> Move the file renaming and linking limitation to a new "Previous
> limitations" section.
>
> Improve documentation about the backward and forward compatibility,
> including the rational for ruleset's handled_access_fs.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-10-mic@digikod.net
> ---
>  Documentation/userspace-api/landlock.rst | 124 +++++++++++++++++++----
>  1 file changed, 104 insertions(+), 20 deletions(-)

Thanks for remembering to update the docs :)  I made a few phrasing
suggestions below, but otherwise it looks good to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index f35552ff19ba..97db09d36a5c 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -281,6 +347,24 @@ Memory usage
>  Kernel memory allocated to create rulesets is accounted and can be restr=
icted
>  by the Documentation/admin-guide/cgroup-v1/memory.rst.
>
> +Previous limitations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +File renaming and linking (ABI 1)
> +---------------------------------
> +
> +Because Landlock targets unprivileged access controls, it is needed to p=
roperly
                                                          ^^^^^
                                           "... controls, it needs to ..."

> +handle composition of rules.  Such property also implies rules nesting.
> +Properly handling multiple layers of ruleset, each one of them able to r=
estrict
                                        ^^^^^^^
                                      "rulesets,"

> +access to files, also implies to inherit the ruleset restrictions from a=
 parent
                                 ^^^^^^^^^^
                    "... implies inheritance of the ..."

> +to its hierarchy.  Because files are identified and restricted by their
> +hierarchy, moving or linking a file from one directory to another implie=
s to
> +propagate the hierarchy constraints.

"... one directory to another implies propagation of the hierarchy constrai=
nts."

> +                                     To protect against privilege escala=
tions

> +through renaming or linking, and for the sake of simplicity, Landlock pr=
eviously
> +limited linking and renaming to the same directory.  Starting with the L=
andlock
> +ABI version 2, it is now possible to securely control renaming and linki=
ng
> +thanks to the new `LANDLOCK_ACCESS_FS_REFER` access right.

--
paul-moore.com
