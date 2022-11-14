Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8286282CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiKNOid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 09:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiKNOi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:38:29 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6652BF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 06:38:27 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso6731642otr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tiAlNaz5lTJwnYCelBGX08b8+sUElNWbgFxFjc6KPlw=;
        b=x8KFv1A5lU7NRkxneKmqgLZcmC4tP4chHibNMKrrnlaINMGlFlP/5dK/1GsN9zT010
         +RKef96BhSFt30UprdR+ytvPxv1ACCGP5mOFANPLRtpJQNq8W1QANv/65bJd9PQqfqOi
         3yjODOq8gB7np91YFIga17VbO299DdJ0Yyl5+Ij3ALoSNhrANJvaZ4isLw7VHy8JgYeA
         sc890Ejp0Krg6+mNMddUV+BBoQZUXojDSvJBEeNry+sE/L68nIpxsXcMnUiaHu9DQc3R
         IxSn3VDjToVI/ep2OeBOIKrHX4b7veXiOczxA3pK9cZukTrRJN3gY2sIByHtHn715nOp
         ydxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiAlNaz5lTJwnYCelBGX08b8+sUElNWbgFxFjc6KPlw=;
        b=Lm8eAo2JfqRFYu5mKg67zsi0ZcNzP4u0hgDzpjRZIRFJARALo7iYbkpFKGvEQwaPno
         o6nDzCkf+Eu8Mi5dvQw+0f/fxSbWVQ/klkDQQ/VPgpujKJTfhgopLnCK58Tok1WP/Vx/
         d7yVbWl3Vro5wkOepDx1yIwhNdkgHWQ48TCwfuU/I8tntj1kB7FzRkoAFCIAZpdLMfbm
         dXx1sDw3oZQoXbhgAn5UsHUuJVRgrPzeQnNvAA4bLjDN9kzwBjO0/7eSh/BrjS1oWPV6
         nx1DzT1XXNNv4oEljTDrPdK8HX8ODVMQ/n0ZxoUmVXoGU44yIHZR6GzdSfPQUhjr+eOq
         E2HA==
X-Gm-Message-State: ANoB5pmyE3w4r5Cm3V1MEid9DdWF/v5+4FKvcKCUxm+Nuj9bmtRcmP/G
        zvgir9LsM0fiMRi991NySyeGwD0ffcGjAnqbqo7o2Q==
X-Google-Smtp-Source: AA0mqf7uZJKdD5qLhn0hnWez9AuzG4xyabmQImeUbZvRjgumYkGgUyiSl1nVAzcmR+SwE2CbdKSe9HeH7b74FjrPIQ0=
X-Received: by 2002:a05:6830:6486:b0:66d:65a5:b0b3 with SMTP id
 ck6-20020a056830648600b0066d65a5b0b3mr5854433otb.170.1668436707187; Mon, 14
 Nov 2022 06:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20221103170210.464155-1-peter.griffin@linaro.org> <CAJfpeguUEb++huEOdtVMgC2hbqh4f5+7iOomJ=fin-RE=pu8jQ@mail.gmail.com>
In-Reply-To: <CAJfpeguUEb++huEOdtVMgC2hbqh4f5+7iOomJ=fin-RE=pu8jQ@mail.gmail.com>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Mon, 14 Nov 2022 14:38:15 +0000
Message-ID: <CADrjBPotAaBMpPjaVZ_aXQMt-RF6wiYpeYZT=5dZS_E=vGv2eg@mail.gmail.com>
Subject: Re: [PATCH] vfs: vfs_tmpfile: ensure O_EXCL flag is enforced
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Peter Griffin <gpeter@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

On Thu, 3 Nov 2022 at 19:12, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 3 Nov 2022 at 18:04, Peter Griffin <peter.griffin@linaro.org> wrote:
> >
> > If O_EXCL is *not* specified, then linkat() can be
> > used to link the temporary file into the filesystem.
> > If O_EXCL is specified then linkat() should fail (-1).
> >
> > After commit 863f144f12ad ("vfs: open inside ->tmpfile()")
> > the O_EXCL flag is no longer honored by the vfs layer for
> > tmpfile, which means the file can be linked even if O_EXCL
> > flag is specified, which is a change in behaviour for
> > userspace!
> >
> > The open flags was previously passed as a parameter, so it
> > was uneffected by the changes to file->f_flags caused by
> > finish_open(). This patch fixes the issue by storing
> > file->f_flags in a local variable so the O_EXCL test
> > logic is restored.
> >
> > This regression was detected by Android CTS Bionic fcntl()
> > tests running on android-mainline [1].
> >
> > [1] https://android.googlesource.com/platform/bionic/+/
> >     refs/heads/master/tests/fcntl_test.cpp#352
>
> Looks good.
>
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>

As this patch now has an Acked-by the original author of the
commit that reworked the tmpfile vfs logic and introduced the
regression. Can you pick up this commit and send it onto Linus
for inclusion into the next v6.1-rc release?

Note, it fixes a regression for userspace introduced in this merge
window so I was hoping to get the fix into the next -rc so that the
v6.1 release does not contain this bug.

Many thanks,

Peter
