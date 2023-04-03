Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E743F6D4EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjDCRQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDCRQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:16:08 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15182737
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 10:16:07 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id ay14so21384190uab.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680542167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk92FRUf43Wcnx3l86UbDA2AnvysV8XDwy6uhSZU4Ks=;
        b=TGHrdMvKgvrKvDnwYsxEqdGraV6xAfDcbneUa569OTKUBN1Xa/GxkSSqByukXsKbMq
         0Um/boEs5drKh/L4a1fqx7O54Uz1DevKfk+ACKfIVVeKSoOxclPIaK2xB4aiU2tHmGi7
         OyQ6AbMQKMie4r6AAvzv/WG57YcnbD3w9ZULTyw2mT5zbdkQi0FpOUqkmpbZBqVnsvF4
         hhLwg5wjYa+7WV68sCtZHvvL6n9/DAnyiIVFNgpIMsl1MBPPlvNgygA6pba3nOk+RgU0
         G6UYTAZ2lRwqjHCe3Kk7RmG73uJmlk+mmha4amQgTLePZ8vddhhllFCe746iXxtnp5/y
         uXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk92FRUf43Wcnx3l86UbDA2AnvysV8XDwy6uhSZU4Ks=;
        b=sc2Dwkx8zWUL6zZJsL4vtVfmwbUVerK9tL1gkEOv8WU4ZPkuOO43faNg5hV6UFJeSb
         16L2AEslRWUhu9Y2ScJnxPx3TIkwuO+8xolzKbi/Sni3/vJcbMgTJ2F5oJws6WM7hDX/
         g2a0q+orTjFRnd+PEcQjHh7fHZKD32dGzHd/bGazVWJjUDHswvQBvi4ghOw60QVr+qAU
         BU+G2ssA4fEKEr6zCJRKvwa1Zbyyi1aWAVG3OuPaQN4SQNY6r7sPhI5XfZDcyMR4jT6P
         hjOBpkdUATvXK0aygdJXtv19qL/eUjT/hsad9KKTpa7yqfU73adIIKqOw3/q69tM06yW
         dD7g==
X-Gm-Message-State: AAQBX9dxMjehol8z7cgJlQcER6eWQHEmabM7baSICiqB+H6vfZQATkOh
        k2vS+a1BtUsW/kzd5tIoHdYOQMBKAn3uLsicmcKm7szW
X-Google-Smtp-Source: AKy350ary9UOFwxolUEbZcHAwbhYbpMCadkMayZ2Jp8cp3KpowV035qq+CepjXEoBzXc4CsmLlOmCdO22tCg42VNeiY=
X-Received: by 2002:a1f:acc9:0:b0:433:7ae0:6045 with SMTP id
 v192-20020a1facc9000000b004337ae06045mr173678vke.0.1680542166733; Mon, 03 Apr
 2023 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230322062519.409752-1-cccheng@synology.com> <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com> <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
In-Reply-To: <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Apr 2023 20:15:55 +0300
Message-ID: <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
Subject: Re: [PATCH] splice: report related fsnotify events
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 3, 2023 at 8:03=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/3/23 11:00?AM, Amir Goldstein wrote:
> > On Wed, Mar 22, 2023 at 9:08?AM Amir Goldstein <amir73il@gmail.com> wro=
te:
> >>
> >> On Wed, Mar 22, 2023 at 8:51?AM Chung-Chiang Cheng <cccheng@synology.c=
om> wrote:
> >>>
> >>> The fsnotify ACCESS and MODIFY event are missing when manipulating a =
file
> >>> with splice(2).
> >>>
> >
> > Jens, Jan,
> >
> > FYI, I've audited aio routines and found that
> > fsnotify_access()/modify() are also missing in aio_complete_rw()
> > and in io_complete_rw_iopoll() (io_req_io_end() should be called?).
> >
> > I am not using/testing aio/io_uring usually, so I wasn't planning on se=
nding
> > a patch any time soon. I'll get to it someday.
> > Just wanted to bring this to public attention in case someone is
> > interested in testing/fixing.
>
> aio has never done fsnotify, but I think that's probably an oversight.

I know. and I am not keen either on fixing something that nobody
complained about.

> io_uring does do it for non-polled IO, I don't think there's much point
> in adding it to IOPOLL however. Not really seeing any use cases where
> that would make sense.
>

Users subscribe to fsnotify because they want to be notified of changes/
access to a file.
Why do you think that polled IO should be exempt?

Again, not keep on fixing something nobody complained about.
I'm asking out of curiosity.

Thanks,
Amir.
