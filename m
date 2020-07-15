Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0360220BA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgGOLRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgGOLRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:17:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67EC08C5DD
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 04:17:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so1787312ejx.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d36YHplCMirbgD4jsm9iiSsScUQBT0kq02wpatVLBW4=;
        b=owYkw9H+jixtnqPVsHambBg2CPYzVapNmjmalnWHAUj6CqyQ1RFUpmMrP07n76fkj7
         NS8NLR5H1OFkXBqkfn8SY8ugzdg0o/CHt0EIs+hJnDpVYpzc74f9QGO5rOh+JiCOmh8d
         KiLeMxC9pf6ll2qSQwcf3gJk/dJix9+95GYtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d36YHplCMirbgD4jsm9iiSsScUQBT0kq02wpatVLBW4=;
        b=AvgeE1sWaajndgtbHMsEZevixJL2MFLRBHhC3/opmQDkSpty1qeOaJ84a/mD2PauPs
         UOxwzgYo/SInxnyR14/e7xrUP4hdMOKof3/FctoZLUcTBEkNq04kBdnpfMqHUWcC5ZRW
         vyZO1XUo2Sm+Pxe5Lx+8juTr6YjC/Y51N/K+TH8BPFgebya5mgNrpaJ9TRZwyNtGjXiT
         rhZOLVFDXgb5KqlhS8wD86duGliseLBnufGepH73rozFN3Wl04gNzOKlhe4w8W1lte53
         XbgI9Xob2Q1vmu17QjBByq3wa1jM7LyraJy5NEXWJRqqOK5jsC94GvhpizH/z2NjYiIb
         FXSg==
X-Gm-Message-State: AOAM5317XKPHS3wfjlnv4m965j0G694UB4b2U67ByVqKQVWFk8KhIjEu
        lpA9aC12zyfpZGSJZuVBLmR36wJQQBsmv1mvqJKxig==
X-Google-Smtp-Source: ABdhPJyXSSd4bLurpX7NDuOxlnBU83e5FmXysyseSL84xDfKaag97WmFFsMQICL9c5g504AEcCVDu+1+ti+ViVw8zoc=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr8513898ejg.320.1594811864449;
 Wed, 15 Jul 2020 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705115021.GA1227929@kroah.com> <20200714065110.GA8047@amd>
 <CAJfpegu8AXZWQh3W39PriqxVna+t3D2pz23t_4xEVxGcNf1AUA@mail.gmail.com>
 <4e92b851-ce9a-e2f6-3f9a-a4d47219d320@gmail.com> <CAJfpegvroouw5ndHv+395w5PP1c+pUyp=-T8qhhvSnFbhbRehg@mail.gmail.com>
 <7584d754-2044-a892-cf29-65259b9c4eb1@gmail.com> <CAJfpegvkw5Exptz=gY5bRy2U8GjvTo+muBHsgdF_PA5=hyhmSA@mail.gmail.com>
 <b3adac43-f4ec-7820-1297-59eee206f308@gmail.com> <df17d629-59ea-3262-fae4-28c05e5c9294@gmail.com>
In-Reply-To: <df17d629-59ea-3262-fae4-28c05e5c9294@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 13:17:33 +0200
Message-ID: <CAJfpegsQZh5_bxgeeMmJEdXBh+Hx9cTScYh09V0uL1vJ9Cn1xQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>, Greg KH <gregkh@linuxfoundation.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>, shuah@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:02 AM Pavel Begunkov <asml.silence@gmail.com> wrote:

> I think, if you're going to push this idea, we should start a new thread
> CC'ing strace devs.

Makes sense.   I've pruned the Cc list, so here's the link for reference:

https://lore.kernel.org/linux-fsdevel/CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com/T/#u

Thanks,
Miklos
