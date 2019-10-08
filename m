Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F22CF2BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfJHG2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 02:28:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44815 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfJHG2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:28:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so13096639otj.11;
        Mon, 07 Oct 2019 23:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYZSphNTeqhGx1wU9vMRSNJrOLEx7UXZMZ12vmh3wm8=;
        b=uj6SDTlK8cKX8nozCfpgsQeL+VRlbSl6Od3sF3Aj+tyeqechUXUmO63d5Rp72fhNtV
         GETjjUt2qNEFbpuLpS3YNf+Jtx850W0ozxRkEiRWwn+Gwi6vpAYVJqem+X/T77vv32O4
         GM+2DaHJauqFa9ZSK9nrlQ+rcMc3ZLok6zIjnHHPCv5dX0CAznswJRXlA90UiT/AJaqc
         /aXDgr+XkasW5FvqAFczNmD7jcERn+1t9dT8fT5xEFymlwhf4rvhPMyBHAClERPvX5ne
         p9CvNdM0tvulT6LsJdwZGhkjcKodS4B1yHbXuV0hwVYzPan2TXkWh2XvWOz+HSbo3NPz
         j7cg==
X-Gm-Message-State: APjAAAWxD3O8P5ZXTh+IgshMRfESYfaxCP/RX7R9oDt7f0fyjAIARvsB
        hcA/AkwHixt/CUp5KF8Ls4yR6hVY30XdLfM/BBU=
X-Google-Smtp-Source: APXvYqxVLswEPn/oyYvCjTJTFOl48PKBdRScaCvnZJwIslE71ycPY3pxxK8E0BKUHrdOdU1dlTpX+laB88khU1jtNvI=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr14677186oti.39.1570516115037;
 Mon, 07 Oct 2019 23:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
 <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
In-Reply-To: <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 08:28:23 +0200
Message-ID: <CAMuHMdXN5hL+BvnJDG86RnH4nv0yz+nxJ+Uc7-2V8jQ+dJ5tkA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Cree <mcree@orcon.net.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 8, 2019 at 1:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> m68k:
>
> c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'
>
> I don't know the status.

Fall-out from the (non)inline optimization.  Patch available:
https://lore.kernel.org/lkml/20190927094708.11563-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
