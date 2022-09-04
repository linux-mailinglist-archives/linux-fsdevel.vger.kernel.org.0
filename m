Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3855AC4CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiIDOeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIDOen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:34:43 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0533E0E6
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Sep 2022 07:34:41 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id n125so6636689vsc.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Sep 2022 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GGurWaCTFN9adyswZhDStpSneD/OUq9VaTY1eDbXKNQ=;
        b=mTKfMvSNacRc65Ermpn5aMDoKZnvQSr9Eo7bZTkK/OKEqjJs/7TyCYNp+jb/aWFHL/
         xIqzyRgnJ1SLLOUOYjvfkbE6BgwaV5ujpcAF+t+cDlEwrPbMhm57npJXxCkJ3mpCnTNg
         ywJhnweGpCkD0jEqKYYwl/EdJRsmAlbNdNngq14dkf9JsZNOn7gunWzkrJbCm6ULe9Pj
         664xU0XRRV65bOl7k067Qz5x6UwIHqS2Crcw0nZr9gJqyrvujeVKwrIi+sWJ5os4c/ae
         AcTEQ/n9u3PhTTInEZ+XzjJERnIGUwNms9uCu0f7OESvIl3msbcBuDE0EcdBNYQV2LKL
         Vx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GGurWaCTFN9adyswZhDStpSneD/OUq9VaTY1eDbXKNQ=;
        b=jaGuPDGU0KXPNG4E+EeIKr/BL+KTX1pACRUY03IzDyabbZareOHyGMOPi9toOb1vk6
         EcPDmd/E7eVZ763fgD2tN9nemhyg4971Fb572mQDMJbcfvplJo7UORfS59vbE9zUIkcv
         2dglRBggw07LLgv2u5JQOuAcGCLpW87hG9MQ2Efph7Y/Hr+rZG+REXG60p0JsQRkbvtu
         +lGfok0WXVmUvHD2wJhExzCXUlb5crQbnxn2lcq7qdb39FIv0+v9MqKfrt+pYBpuCoBd
         ObAliK3ZgWQpUIBCmMD06mlHucTCoJ4MYFekHK1BkYPQkbm4eQ7FWNKBQfgItSf1BIOL
         f61A==
X-Gm-Message-State: ACgBeo0aJNHgVssYEZYoVr1XUEIx/6DfODoJyxo+jkfd29U575MdGeAB
        jrJVq5wblwmTLjwFtT1oOqV7nzJ5M+IZtyYVUx0=
X-Google-Smtp-Source: AA6agR7xwA9Uy6d6UwkzladJ1RABSeVuiqqGrvmmdVb2GtjQGwpsNhN3s4X87GMT89EeS2m9apIgfElzw6bKyWik7Ks=
X-Received: by 2002:a67:c19d:0:b0:390:ecd8:4617 with SMTP id
 h29-20020a67c19d000000b00390ecd84617mr11097868vsj.36.1662302080933; Sun, 04
 Sep 2022 07:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhAw+mgY5MHJ3G-agK0AqxgXZjL5Zr97CeCRzDjjSTHr0w@mail.gmail.com>
 <CAOQ4uxieX+oJJV_NZt9cQVn=TTFbZdbpQq9kY0N64iy=JHMn6A@mail.gmail.com> <CAJ-MHhAdDVmOyGo8nu6RXv837yMvdRhfR+jdQJdAMD2sOsQMOw@mail.gmail.com>
In-Reply-To: <CAJ-MHhAdDVmOyGo8nu6RXv837yMvdRhfR+jdQJdAMD2sOsQMOw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 4 Sep 2022 17:34:29 +0300
Message-ID: <CAOQ4uxi2ndeMNYO9Oy6YmSX9jeUU5aKek02kwxWsfnb3BJpwGQ@mail.gmail.com>
Subject: Re: Fanotify events on the same file path
To:     Gal Rosen <gal.rosen@cybereason.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 4, 2022 at 5:10 PM Gal Rosen <gal.rosen@cybereason.com> wrote:
>
> Hi Amir,
>
> And what about other events like FAN_CLOSE_WRITE ?

Permission events (e.g. FAN_OPEN_PERM) are never merged in the kernel queue.
FAN_CLOSE_WRITE is an async event, so it MAY be merged with other async
events (such as FAN_OPEN or another FAN_CLOSE_WRITE) on the same
path/object, but:
1. You have no guarantee that the kernel will merge events
2. Kernel will only merge events if all other info except the event mask
    is identical.

So for example, the file was opened by two different threads,
event->pid would be different so the two events would not be
merged.

>
> So, if I understand correctly, it is my responsibility to verify for multiplications
> of file events for the same file path before calling to scan. right ?
>

Right.
Since your application has a queue of its own, you are responsible to
do that anyway, because once you read a FAN_CLOSE_WRITE
event from the kernel and place it in the application queue, the
kernel will surely generate another FAN_CLOSE_WRITE event on
the next file close.

Thanks,
Amir.
