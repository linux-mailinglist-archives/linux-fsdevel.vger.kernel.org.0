Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161372B2E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFKQzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKQzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:55:52 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46CEE5F;
        Sun, 11 Jun 2023 09:55:50 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-43c8e0a92f0so2454156137.0;
        Sun, 11 Jun 2023 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686502550; x=1689094550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8LmTVJ+bTl+wECCQyq58BZ5ni57U+99jTa9q4j3vIg=;
        b=ZvZZbcGcpUBWypC6+IXMMlbwhrbyTuJjfOIo19MnpW9AFAIaCTOkQd7YvjIHgmLtd7
         LKvoCfXb/yWYOxSH6ekobQcYVH5uUpo3hxrtvLr0oICXWxZdh3FQODCpbJTczNJEjqfZ
         A7QXtuL3PMMZc54GyrINyfzlD9v8eb/Ao3fRLm1d1hOwuv1kuIJvazZtELmPCmRQwMH1
         lZuqTjE+rVBiveqgl4ICuPYsdvThTYIMmAnS+IAhNrYWlMWln17HW9t9CoqhM+B6EnDe
         Aq3+1y+ARvtYSWAOsZK9tItmJ28vrTMtPvbkkqb19x4ItCh4Q0M4v0Qeu+ZyyfMZ2ZzE
         KExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686502550; x=1689094550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8LmTVJ+bTl+wECCQyq58BZ5ni57U+99jTa9q4j3vIg=;
        b=SAtQv11mdFS1rVU+DEePcIgVREv/AQCv7bWBelK//skFLGZnQN+KK6jW6JY8+k4Ame
         +oHfr3APlNOu+BKyt3yC3eX/lcfTLUi8ev352jGJx+uzKosY13ofITwPSOiSji9/FD9i
         EiKDUjrC9C5U1jwttYwkuiZ045AHsXbo3MLF7vfbWMyLQjWzBvF/nxMukqCr1qPJ2NCp
         cZpyESYjbQnjR6htPCl3H9jcRb/rOV67vt6nE83MjDaBw+vjyuOWZHe5C685abci81m1
         WKcDZmV8FmP5kYI9VG+UgCHLb+TAy87cc+T9CDbgclh/Ds1qRAzHDvHvN5B1nf6sxx93
         mWzQ==
X-Gm-Message-State: AC+VfDwWTvSi0qQHsdS7tTqp2wsn1ITXwLWXoKOD3berDY0ZPRWAXoq2
        AS89pWO2L5WyXu4NrFipTPOESTPv/6ThHUgfCkc=
X-Google-Smtp-Source: ACHHUZ4HtidM0eh5S/1T/GE7wJ1u7Y+KFNAElAxyWrenbrgjnAPlOUnxxsjDA+rmUNzgo2cxMNNbLvWvcAK8HiGp8eY=
X-Received: by 2002:a05:6102:2435:b0:439:3e26:990e with SMTP id
 l21-20020a056102243500b004393e26990emr2828005vsi.6.1686502549680; Sun, 11 Jun
 2023 09:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
In-Reply-To: <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Jun 2023 19:55:38 +0300
Message-ID: <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 5:23=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 11 Jun 2023 at 15:27, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Miklos,
> >
> > The first solution that we discussed for removing FMODE_NONOTIFY
> > from overlayfs real files using file_fake container got complicated.
> >
> > This alternative solution is less intrusive to vfs and all the vfs
> > code should remian unaffected expect for the special fsnotify case
> > that we want to fix.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v1:
> > - Drop the file_fake container
>
> Why?

See my question on v1.
The fake file objects are used both as vm_file and in read/write iter
how do we know which path to use in low level functions?

If we allocate file_fake container and still store the fake path
in f_path, then we have no need to store also the real path
because ovl knows how to get from fake path to real path.

This is what v2 does.

What am I missing?

Thanks,
Amir.
