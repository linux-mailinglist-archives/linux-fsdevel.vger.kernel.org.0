Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA02D34C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgLHVCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 16:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgLHVCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:02:35 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD023C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 13:01:54 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so157128lfm.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=ROtEO+OVS9RfjVYt13rb9bXwl6vWUQ0uLL0X6wygCiWrpFFIQVJPjqgKkj1v7UrNXO
         KDiY9qw9NYnKeQXvq82LKIFRDtuWh/xJCBAirqtHokmUbbpCucKnihw7UAohXOfdUzST
         R/beNSF/szQK06awRivcQ/EdxP5ry8GrnSbts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=UKAo1A+Iv3FRUmUYxLM6f/b9ujw0yb4FVF6TaMRyz/FZdPaAIgD4ae9J6M26DdOGQN
         51myqWinUGr2JoBhib8w1N+urBFxDM17CZ00YyRLd9k6l8iZsh//PIH8vZZTboi7Yuzf
         dMQyO6198zuiZz9/ajLN4fO9Xjg6P8QdCjCzvbVYu0s+ll8+tQW3E2RGDIC1lCRLlNf5
         mj9S6625ZP/hOdFjNeYavF4X28uvWjXxeuNJ26AWdTXniXgrJSVrQLHwSX1UjPG6BABc
         qZmkq6zQYxsifKg3xdOsNvRqH2zBBDyLdKGRCI950UN7WteivPb82Q6ZuEDEjMCduqeJ
         ffyw==
X-Gm-Message-State: AOAM530H5I11eg8ox1vkjGHIZ3PxT1N2jhBTPgJ/5v34Dk2VONUfAb/g
        VUfXwGZ3Ck0BVaEIsnuyPfMtfoPw/jF80w==
X-Google-Smtp-Source: ABdhPJyi8ILLoGAfnj/lu0WzEM3BSyqLqAgRNOvzslStGjmyao+PlVMPd0KQGAc9x4WpZXjHvnJQhA==
X-Received: by 2002:a19:8c0f:: with SMTP id o15mr6748440lfd.126.1607461312861;
        Tue, 08 Dec 2020 13:01:52 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s22sm3332910lfi.187.2020.12.08.13.01.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:01:49 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l11so257580lfg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 13:01:48 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr11218462lfb.421.1607461308477;
 Tue, 08 Dec 2020 13:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de> <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk> <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
 <20201208205321.GI3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208205321.GI3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 13:01:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 12:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  I've got
> fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
> and
> fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
> in "to apply" pile; if that's what you are talking about,

Yup, those were the ones.

> I don't
> think they are anywhere critical enough for 5.10-final, but I might
> be missing something...

No, I agree, no hurry with them. I just wanted to make sure you're
aware of them.

                 Linus
