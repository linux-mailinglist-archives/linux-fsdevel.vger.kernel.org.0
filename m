Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738807918D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjIDNmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjIDNmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:42:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797EE5C
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 06:41:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so22251981fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693834889; x=1694439689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAJUIwPM1rvlXz60vlIlQgJNhFzjNtGgsFNDmIdxJVU=;
        b=UsbHzfxphZ42y4j79sMONQYJdplOvfg8cLLn6y52jpFASDXM5whXavJFfkCnlNI9eV
         pDez5FLO+X5RzCOKjPts7CJGPy5IY7JDVUP/F6mLYYa8sWnZ2mSCHFJZyGfdGD3JRNZ7
         sSt2zr/GljBxRIZB+V9XIYUY4Hvzwdyn6DBYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834889; x=1694439689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAJUIwPM1rvlXz60vlIlQgJNhFzjNtGgsFNDmIdxJVU=;
        b=LwmrP9n4C8GssD13+ncT2DzBbN4muMmj5ZgxfTuMukbj7wlJqjK/sWKGSHNESehfHV
         kKkY1mqVIXmBKFepQmzqaQw4L9fRM+lliQLG/IXsqNEUTq+EEvhr2S9a51c9K7ol3gbU
         WbCAs81Xm6JDUxu+jdOeiuAl6naLLwFaK4mn0v+dHcR2LMLD+3WRCiRbOaFSJRAgN7Io
         forwSGAzZSKZlC7WyGRMVDOCf0T1b6zChFyhLf15p9HFbIIiu8sTZKP3BDuovFFsTOLv
         vPya8/JJY8pG4eMhdAZC8vrzbOrYvvFk/SjuIbZnp2JLlfHA4TMWWeUuSp54iCzIsTDC
         iGbQ==
X-Gm-Message-State: AOJu0YyEdO+N+esHazf4d6wl0uPFt6QUOwqv6qaoHbIxSG5ttPGjdZBO
        YfEjPWI4EBuPbgFBqPMWnlt7m1GogiYRqNcI9IjTDA==
X-Google-Smtp-Source: AGHT+IHH7XHW70WFG+Esr+exgEcYvZlsLAxJeLF2g4s6FLthKfUvKfSYuwWzbPp22gWUPdh8Ws9f/vGfVIbVhoOUYZ0=
X-Received: by 2002:a2e:9914:0:b0:2b6:c886:681 with SMTP id
 v20-20020a2e9914000000b002b6c8860681mr6100756lji.6.1693834888969; Mon, 04 Sep
 2023 06:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230904133321.104584-1-git@andred.net>
In-Reply-To: <20230904133321.104584-1-git@andred.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 4 Sep 2023 15:41:17 +0200
Message-ID: <CAJfpegtSEjO9yi6ccG1KNi+C73xFuECnpo1DQsD9E5QhttwoRA@mail.gmail.com>
Subject: Re: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Sept 2023 at 15:34, Andr=C3=A9 Draszik <git@andred.net> wrote:
>
> From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
>
> This patch breaks all existing userspace by requiring updates as
> mentioned in the commit message, which is not allowed.

It might break something, but you need to tell us what that is, please.

Thanks,
Miklos
