Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269B24A7AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 22:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbiBBVup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 16:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBBVuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:50:44 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488DC061714;
        Wed,  2 Feb 2022 13:50:44 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id u76so1774727uau.3;
        Wed, 02 Feb 2022 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ig4LWCuwtDBy+V/6OWWfEZL0sxJpRVJolebrZo8kkkg=;
        b=al6Y4nEGOP+r/VkRFgTfNO9SFIhYI84YlDo94LWAwGulCZTkVwgGDgfxTfI/yDYuSI
         MXuCJgACyOuS8p3+DfN8HJAXERGIJXs/ugI+/sg7EKTqtUp/NHRyIHoAoojoowXws1HJ
         HaYGkgN/F4gaCj6BaWyhPnS60YML8zsIKS9cw0vN5z7Ho7fo3CUsKZa+OgVXBmPJxj6L
         JQlfIjvGAIGyhB938eamo5/Ijp/cdL59axyq9T3cSk5ufbZ6RNM+Az0z8DCMiY7t+pDf
         Xkb+I1WYIj3lOe/AG2em/JXr83LRFjPcF6ZQAVEf84veS9cz47Fe/c+qgvJPhj9FX29M
         biCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ig4LWCuwtDBy+V/6OWWfEZL0sxJpRVJolebrZo8kkkg=;
        b=41wrOMOBnwSWpPV9Th7V7JNaVghkHTT6SChLkTIOotPQMiEkWt+9ckdneetVQLIfOw
         iYyTwo4xJpjgh6ehsXaLWb1B0ATfixspvqeaFf5MfoVW1qNk32NClSY/7dbjECWuFzTB
         lP0dAnEaxNJKEmJED6+DUcRlYGf2+aMzW4+kwaBUemkx7RK0/p33WkajR731eDXxVGII
         2WJKPVtWUEgq9RVpt/lqReaqoGLaigQ1ZWfwJh7s+Bd1GT1P7quCY8I2idSwwjvfCx92
         hhqi/0Qm+7vuCY3gEdZEDthxqhuxIbLcwyA2AtSKGy+KrOxfKIjuc+JLWxZFVvky+O+3
         Mqog==
X-Gm-Message-State: AOAM530IIdV4yBiWcwvo/fZRJU6M8qcSpC6FfDj20WeutqxwP320SSfK
        CmuGic/dh156uiAqgd12aV0GklmcAEbiJsj7saYX9FZc5JMFlE4lfPU=
X-Google-Smtp-Source: ABdhPJwYkUCndjFkZvxZQzAs0H2wdlk30CR3os9kZR/g6J5vR5SfB/G1hs7wS9BryBZkh8xzk/HnRCJIl8bIih3X1Gs=
X-Received: by 2002:a67:c907:: with SMTP id w7mr12613827vsk.60.1643838643524;
 Wed, 02 Feb 2022 13:50:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org>
In-Reply-To: <YfrX1BVIlIwiVYzs@casper.infradead.org>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 2 Feb 2022 23:50:32 +0200
Message-ID: <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     BTRFS <linux-btrfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tre=C5=A1d., 2022. g. 2. febr., plkst. 21:13 =E2=80=94 lietot=C4=81js Matth=
ew Wilcox
(<willy@infradead.org>) rakst=C4=ABja:
>
> On Wed, Feb 02, 2022 at 07:15:14PM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > I have a corrupted file on BTRFS which has CoW disabled thus no
> > checksum. Trying to read this file causes the process to get stuck
> > forever. It doesn't return EIO.
> >
> > How can I find out why it gets stuck?
>
> > $ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
> > folio_wait_bit_common (mm/filemap.c:1314)
> > filemap_get_pages (mm/filemap.c:2622)
> > filemap_read (mm/filemap.c:2676)
> > new_sync_read (fs/read_write.c:401 (discriminator 1))
>
> folio_wait_bit_common() is where it waits for the page to be unlocked.
> Probably the problem is that btrfs isn't unlocking the page on
> seeing the error, so you don't get the -EIO returned?


Yeah, but how to find where that happens.
Anyway by pure luck I found memcpy that wrote outside of allocated
memory and fixing that solved this issue but I still don't know how to
debug this properly.
