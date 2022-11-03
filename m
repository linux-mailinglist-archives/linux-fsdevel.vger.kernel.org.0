Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB4617898
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 09:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKCIWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCIWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:22:48 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D32563DB;
        Thu,  3 Nov 2022 01:22:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-367b8adf788so8683107b3.2;
        Thu, 03 Nov 2022 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k31/JdPcSTGlgXxdPCymVX3Z3kd21+ynCpK8jvceg8k=;
        b=KvJ0W7Jim/47zka46N2jPP8r/6sllGpFKNy6CYwjl3ZI4UeTW/MHutBy9uUyrLGATt
         mXRZ+jIQUGf2AIND25NDaMQ6NTYWaXf6nZ2K2j1uCHpZyr1HnlzqCNFseW1xOe7evKFX
         UlaeYJIhDWBDWOsh+IwzgGmze+STLnwLsYZTDPUIN60u57DySQdwy5IpibEIqPhMqrlV
         ynWkZ152LAaxm3FDKWfZ7ryJRjrc4vWUEuQGkZVHvbqBY34scl0JB42O6NNS7rUqHrsN
         mggp6hkZKhPxpOH91p7FV55uAaGZ8ZnNA+1RIJ1IVxm+8eF0tZ/CjP5hauy/yp/+G4Fs
         BO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k31/JdPcSTGlgXxdPCymVX3Z3kd21+ynCpK8jvceg8k=;
        b=uMxlnmcwBKkEH7OgCovHQqhBfhqDBczicsufxSuaQi2btKGoi2yV/vpNExqWMyjs4+
         sayhHGdPdOjEmwQ8BRi1w4ikifq9tx65HdGZgIO96mRVgRe+tRx50zydvdz4k+AsgtkM
         ZpupgOvlNHG+SEZAD1kn5J4i8lsGmtkAiNyJtMOmnnKW8PvR8vAoosi6+yvR8eKACKsJ
         gOWFikVyZ/uwGGLofzmCMs6LkBtQSLb5Xp4oS9D6xNEuGBLCDY16ZAeGQyQP7l4rP0VN
         SmWXJAQqzEs1wQKG+oxAXPx/huNOshId8f4a797klNrnaBuAI2imNzh0/VaFVsuTyDdi
         14xg==
X-Gm-Message-State: ACrzQf0goqr979vl19oR8TbNCCPY/Hdpew0+G4rbfVchRqV1WZakj8he
        xYLVFUZrKQEUvdkgTUAn7jCH2bn5grn6XhQomOU=
X-Google-Smtp-Source: AMsMyM7ijaR/YBS6NKQ5RNFjO8bIc+I0OIUQAi8zkD8rQZbmGuUUd4aNnLJTZfReNFDklE3GTmd6yAOlSDapmrcgxyw=
X-Received: by 2002:a0d:e68b:0:b0:36a:d1d:a7e0 with SMTP id
 p133-20020a0de68b000000b0036a0d1da7e0mr28197074ywe.493.1667463766704; Thu, 03
 Nov 2022 01:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com>
 <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com> <Y2MFe1pRdH35fxU8@bombadil.infradead.org>
In-Reply-To: <Y2MFe1pRdH35fxU8@bombadil.infradead.org>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Thu, 3 Nov 2022 09:22:35 +0100
Message-ID: <CABDcavbv5=54Hv4_TRgAiQK9fvXHbpy3O288Lc5pfO2Q+8Y=SA@mail.gmail.com>
Subject: Re: fs: layered device driver to write to evdev
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

El jue, 3 nov 2022 a las 1:04, Luis Chamberlain (<mcgrof@kernel.org>) escri=
bi=C3=B3:
>
> On Wed, Nov 02, 2022 at 02:14:24PM +0100, Guillermo Rodriguez Garcia wrot=
e:
> > I understand that device drivers should implement ->write_iter if they
> > need to be written from kernel space, but evdev does not support this.
> > What is the recommended way to have a layered device driver that can
> > talk to evdev ?
>
> Shouldn't just writing write_iter support make this work?

If I understand correctly, supporting both write and write_iter is not
allowed [1]:

"If a file has both the regular ->read/->write methods and the iter
variants those could have different semantics for messed up enough
drivers.  Also fails the kernel access to them in that case."

 [1]: https://lore.kernel.org/all/20200817073212.830069-3-hch@lst.de/

Thanks,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
