Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88D6729B16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjFINKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFINKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:10:10 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D330E4;
        Fri,  9 Jun 2023 06:10:08 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-783f17f0a00so677026241.2;
        Fri, 09 Jun 2023 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686316207; x=1688908207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmde1pLQrUFHwxH8GArzxr7nArrRokC/6tMbTNZ4vYA=;
        b=PrPiRxaFrijUaQBfhWQB6UWFzKXRTh8e8GTEAZaCCPhL8ffZCSTEXTmARL0iZV4QyD
         6eaUFJtpaSSryO3r5tJ692Vim9a2rM9ZWPhku3/Msb6tuSEgqOZCunRQDrI8hBYM65zP
         oz93dhHdb9oMPZrn9DDcFJPksViNkdQp3JK9V/SU/XLuQwl84qSHWCUj5vDDnQgtfFYE
         3UUlScGvETd1iwzA50fI7xzDVS4L/lPJuNy7lENCRR6+J3XPvCE9+129oFtJmuxHlpPC
         B2qtdH3DNVtJw5sGpyrmfPrsA7UFxTyshSVkUwOpwD2Qe8d9reGBMM1jiwVHn5rnkO8b
         lmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316207; x=1688908207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmde1pLQrUFHwxH8GArzxr7nArrRokC/6tMbTNZ4vYA=;
        b=S/GfQI0Gqy+y2VUzkssCJs42pgC50VUgQ4nchOjKeJovO7vzo+8nUY7mps56DKzpEf
         ct8Pd91Lo6JZK876nzc2VNa8qOXdgdA+GRN4MiymgTOUlEQ31IR+Nbg0LNWmvs1YQBJT
         zWrbte9w3DXL9eYXp7BYWKpbP0FWjTSYBx5nfJoWmyLB6eqIEObS3eXpBi67Tldwm4Sh
         hfp9eDfBytYHuqyn4FMYr36g/W9afc2VLzdQda55hmAjfdTE93MPSGTComv1aRW1X6cf
         biB0GfI0Buv/bPUGgxDuY/ivhj2lta5bVFhw4BU+aNkycsaOcHnYUdqmaFhqGmnPuvpB
         dLtA==
X-Gm-Message-State: AC+VfDwlQZYjQiv1eoN0eqZtnksKPfrP2fikfeJS5WrLGHJXQADbQPK9
        dsXVTrIpPf9otytlKQC482c0o6Lz4FjeubaXtV4=
X-Google-Smtp-Source: ACHHUZ5shVe8IGXgEE23N53BY9COrpJ5Gm7B62kRYf8XFOw/RwopS+nLAzZtLZzffCZXrmVWuiwSHNpg7AoTM2BlVcI=
X-Received: by 2002:a67:f95a:0:b0:43b:1e61:2207 with SMTP id
 u26-20020a67f95a000000b0043b1e612207mr876314vsq.21.1686316207465; Fri, 09 Jun
 2023 06:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-2-amir73il@gmail.com>
 <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner> <CAOQ4uxgR5z3yGqJ7jna=r45_Gru5LePU57XG++Ew_9pGWKcwCQ@mail.gmail.com>
 <20230609-fakten-bildt-4bda22b203f8@brauner> <CAOQ4uxgfvXdkWWLnz=5s6JxP2L50JOsZv63f0P9-KhuHtCEaCQ@mail.gmail.com>
 <20230609-konform-datteln-52f405ce6411@brauner> <20230609-woran-halstuch-b1b82b2a0ee7@brauner>
In-Reply-To: <20230609-woran-halstuch-b1b82b2a0ee7@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 16:09:56 +0300
Message-ID: <CAOQ4uxgnKDemEN2HHZsDdm8v3ut9UKY9+pZj5SHd=NzXdGVmGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: use fake_file container for internal files with
 fake f_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>
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

On Fri, Jun 9, 2023 at 4:00=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 09, 2023 at 02:54:32PM +0200, Christian Brauner wrote:
[...]
>
> Uh, I misread as that's only used in cachefiles and in overlayfs so it's
> probably fine. I thought this was the generic version. Though it might
> still be preferable to keep FMODE_NOACCOUNT and FMODE_FAKE_PATH distinct
> since there's really no reason why tmpfiles should partake in the fake
> path stuff...

The reason is (wait for it) no more available bits in f_flags.
Yeh, there is one place left in 0x4000000, but I didn't want to
waste it given that FMODE_NOACCOUNT and FMODE_FAKE_PATH
use cases are pretty close.

BTW, you reminded me that I forgot to CC dhowells (add now).

Thanks,
Amir.
