Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA74DE1C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiCRT0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiCRT0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:26:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C1B30CAB0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 12:25:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id pv16so18981006ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXH9ELMuDY+iN+HFjZXoGFqlOaPPrjOGTbi3JNMxxVA=;
        b=AVhQunjEnglxMNGkZ1ERYHtyQHblgxV8GZOCiAQAeZLEeFQ2gTXP6yTA0fG2AKamls
         zRLXL+1ze6sD7aCthHCmdGBcTEBpeZHGP19fWFmWj3QRm4Ec8LapG9NigrYV8klby38u
         IPpvH0OOkM+dkHvOxrYmon+uvdEfwhxxt37o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXH9ELMuDY+iN+HFjZXoGFqlOaPPrjOGTbi3JNMxxVA=;
        b=2fC0cGh1UiP1ZlpwwW1goKNewcaftaRfWuT/LznDN2tuVAzUgpvaBGf96QjJqkU6Ym
         AKMjDSyzERf7dC711oi9lpxdHoo0bEHV/c58SRD+h/gYymmNKXk/QATTM+hI8KJCXxv3
         5KLNZLFy/pdULYnXWc8VHjULEK1DHWOJKDRBraRDnobhftKEdBdrsh8P1qEeERuWMJsz
         qwneDzlXoQmr3EXHQcTMRr4lgXrzsYqElfCxIycj1h/TAADzPspxx8ke+0D4xNQh5Yad
         f/F0OXo+qLlAG0PxVmjYnehVIvZOJEWX8O9rq7cOqtJLwx26uSapXQgQ5hK06GYqOMdh
         LO2w==
X-Gm-Message-State: AOAM533/6smq+EKc+KwbH4PfAI1T8e/rySloGpggKqsLSLxLeuRRtNtd
        cTaiR9HE8Gmix7dJwHRy8XGQ/frfVJ58ArbD2RDkAx0XYFJGnw==
X-Google-Smtp-Source: ABdhPJz+V9DZGjtY86DMYeyi3wTfGJ9WSF8zTZpI/KQBMaQZ5GADOS5tu4yWcHopXE3+Co3KTkyZHEqdfLmv5lcqISs=
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id
 l8-20020a170906794800b006da64ed178emr10705575ejo.523.1647631506866; Fri, 18
 Mar 2022 12:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com>
In-Reply-To: <20220318171405.2728855-1-cmllamas@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Mar 2022 20:24:55 +0100
Message-ID: <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
>
> Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> all the definitions in this header to use the correct type. Previous
> discussion of this topic can be found here:
>
>   https://lkml.org/lkml/2019/6/5/18

This is effectively a revert of these two commits:

4c82456eeb4d ("fuse: fix type definitions in uapi header")
7e98d53086d1 ("Synchronize fuse header with one used in library")

And so we've gone full circle and back to having to modify the header
to be usable in the cross platform library...

And also made lots of churn for what reason exactly?

Thanks,
Miklos
