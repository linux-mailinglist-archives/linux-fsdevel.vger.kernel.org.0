Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1772B7EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjFLGIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLGIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:08:51 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C3BE;
        Sun, 11 Jun 2023 23:08:50 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-789de11638fso1684356241.1;
        Sun, 11 Jun 2023 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686550129; x=1689142129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pXJQNJHnK2JGcladbSbhRHkw1El98GpnY35UtFaoK8=;
        b=WtJuItw7dSKc1j4n+QNef5JcJpJxyey2ejgTw9IXGsl57i+Tc3kF1t1VRnVGlHqqcZ
         Aj6A4Y7ETt2RhBq/40QKxGxqWk2/MiKT4z7cKbBX0BKSpj5X47LwRy98pLrWP5I95xr4
         Ej6Trb/7GtcLOHyhinhUTwCCnkvug3Nq8+SVeKUUBD1JR57Ly4C3+CEzS5Na9z5vL93n
         gYXVsnyHTk9ZEGQIeraCiTZjKgPmA7hOozmRBkRKMSDGPn9vGwYzC7kJtj8ElZwOuZ0a
         uxyUKuOajeBkw+RJY5VMRvGWqSeGyaFC+VR7tbFcwMkX/1m77Ego8aTjcUsRAe1id9zt
         By9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686550129; x=1689142129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pXJQNJHnK2JGcladbSbhRHkw1El98GpnY35UtFaoK8=;
        b=B3GpnyJplgCsl4ldoxTJC9Lgz+1KSQisqLNQPucf+b7psTeysSIx2gu9Cpcy8XK8gz
         hpOjuSqs7FrakR9TkZb1vaU0EF4vh3b7FqHxzHZDFBqnjIx5r6T8q1Pf4Zn+c9of2HeV
         vShAepzk9BNWCf65afoQMMGCuBiqoHRaKg2IaPpyemKnNKXdUTS7zaftErr0WthgbtsA
         Oe6IP8bq997sXEes9FTeX8LQJ4ksxv7JghrjGUyYNzCxYvwBE8D1dV7lkXfgOrM5HiZX
         6Bosszf1bEjEvVs7q1fbnbZAbRQmYD1jCuYdoFgrXP5LGSbHXdZt3WrKRrLFTBlLn125
         Yrig==
X-Gm-Message-State: AC+VfDx+aH+PJSBukz9BtnAgQ+n25f07xTeZgMZ/Yl99be5wK3VHDDci
        x29y1DbiopLVNtZS6VFe5JSO5+XiQDVwBBTvl8hMsdz3
X-Google-Smtp-Source: ACHHUZ4Dz/ExnZ718XFgcyllqKbYhmmBpLPdWz/5vlG4m3pY5kfNK6Cc1F0G1UoquGGErgzBg7qyKaWwMtUbjQXR09M=
X-Received: by 2002:a05:6102:303a:b0:434:3cf1:96e with SMTP id
 v26-20020a056102303a00b004343cf1096emr3728035vsa.1.1686550129052; Sun, 11 Jun
 2023 23:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <20230611132732.1502040-2-amir73il@gmail.com>
 <ZIaelQAs0EjPw4TR@infradead.org>
In-Reply-To: <ZIaelQAs0EjPw4TR@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:08:37 +0300
Message-ID: <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
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

On Mon, Jun 12, 2023 at 7:27=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 04:27:30PM +0300, Amir Goldstein wrote:
> > Rename the flag FMODE_NOACCOUNT that is used to mark internal files of
> > overlayfs and cachefiles to the more generic name FMODE_INTERNAL, which
> > also indicates that the file's f_path is possibly "fake".
>
> FMODE_INTERNAL is completely meaningless.  Plase come up with a name
> that actually explain what is special about these files.
>

Well, I am not sure if FMODE_FAKE_PATH in v3 is a better name,
because you did rightfully say that "fake path" is not that descriptive,
but I will think of a better way to describe "fake path" and match the
flag to the file container name.

Thanks,
Amir.
