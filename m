Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B533B54A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jun 2021 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhF0Sbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhF0Sbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 14:31:49 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2F1C061574;
        Sun, 27 Jun 2021 11:29:23 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v3-20020a4ac9030000b029024c9d0bff49so191035ooq.0;
        Sun, 27 Jun 2021 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+z4qkVkifTb0Z2Fw0OduCD9k1E+MgQUYF/WWXgsuTw=;
        b=uL7OKanIVKL7ppTZGqcwmPDmBXQ+Nxi+L132xY2K7ThGyNV39mFY8n7rekVwU4uA0B
         TWWijxnmvB0euSuw32huegRqkIBHBfLPPuy3HdxuUJOZSBerKuhihbM1UN+48zQ7Sodb
         5ciWhWmTgNdRa5ZMDVF+w7h/K8l/NCZR/iSwFbfnq/wyc0niJnMAGXiAzAlNUjnW1tDz
         FKFpuJlPriSvCC04LnSG+OWuDlVshf0tTtAJwZps4NFYUvD8FLqYB+0HZevwy/tuJQa1
         itzZ3+Td+yQ3f/1QFFhGOCYIh7FAwOvJum7V+izkmz2vvJHR2Wz9LSQEXy4cvl8pNpVu
         ThMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+z4qkVkifTb0Z2Fw0OduCD9k1E+MgQUYF/WWXgsuTw=;
        b=WVPDYzg8Cd2rLwMV+b81sU79+9sPfZxUB0y3IeTXC8Slc2iS87kYJ0lVxSB+h24hU4
         HnhNGiY41otumb1JygeY9gsRv/eIvwjpVcI69VCWNfbtakbM3s/OHoENtDizUjlzfQv+
         Z5decVwVrywE1Osg6dnJ+0ERlnqlbrPD/eP52XVFU3YVIx2tF3ps7LBStSdaykinvpGn
         FxXuPTMSnGyH8ptuaAJ7OpvYwlVQ/Me2/IkKFMitEP5hvv3bjBI+wEr0yNAgZW6BOgRA
         HPUByno1keHa64BV873/qbxdO2LUq2wRJXZq8XdQxM6iTePnZH88BTUNmUYfGYzFZtfE
         xnpQ==
X-Gm-Message-State: AOAM531ZoTKBOEqBcwwrCTlkn1TbqRDQKgSmQ6xkJAaW2/KWR8K19+r9
        fFZMmkQhAKHc9C2cN3DZGFyZG9dezdsJ4RPWYXw=
X-Google-Smtp-Source: ABdhPJzazxCs92rqGAer6fdtZqhbLUP05TPMWhrAmtWQstXFQdy0ixcwi5fvjdhLAyNrQ8N7bXapWEqOPO8mVcpvrT0=
X-Received: by 2002:a4a:ae4b:: with SMTP id a11mr16609024oon.48.1624818563070;
 Sun, 27 Jun 2021 11:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiZL4wXc__+Zx+m7TMjUjNq10tykHow3R9AvCknSNR6bQ@mail.gmail.com>
 <CAOuPNLhoLBwksNt+tJ2=hZr-TGHZgEiu7dgk66BUsraGA16Juw@mail.gmail.com>
 <CAFLxGvw1UoC3whDoQ5w6zfDNe=cLYi278y6vvSadQhOV9MGvTA@mail.gmail.com> <CAOuPNLj4ktYYieOqxd1EGUWt0DZamwQik_jg6cj2ZyqRaL9Amw@mail.gmail.com>
In-Reply-To: <CAOuPNLj4ktYYieOqxd1EGUWt0DZamwQik_jg6cj2ZyqRaL9Amw@mail.gmail.com>
From:   Steve deRosier <derosier@gmail.com>
Date:   Sun, 27 Jun 2021 11:28:47 -0700
Message-ID: <CALLGbRKs0hRLpRFz1mUJyKZan7Lf0eGAArJbBpXwFu2TQzcmWQ@mail.gmail.com>
Subject: Re: Query: UBIFS: How to detect empty volumes
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 27, 2021 at 6:52 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> But, it might be possible that some developer may miss/skip this
> firmware copying part, thus

This is your root problem.

If your build system requires any "magic incantations" such that it is
even possible that a developer can miss a step and result in this
situation, you *must* solve this problem.  I don't know what you're
doing, but honestly, this shouldn't be much more than adding a line or
two into a Makefile or build.sh script.  Fix this first.

I'm not saying it's a bad thing for your on-target flashing system to
sanity check the images, but that will never fix a broken process. Fix
the broken process.

- Steve
