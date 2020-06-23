Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24262204ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgFWKIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgFWKIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:08:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48393C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 03:08:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i74so18367180oib.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3hW7WRp42UpwG72NKBm3smYKhFioVF4VBZeKMtkEJc=;
        b=LrzaNYo+jZEMYGt3waUChB440CSSUC6u4cZavtcKxx/K6dN6SwbrIG9FQITGb7LZNm
         ZWEnKN54ER3iffAr5QHqeF9Fa1i3EL2CfDaiL7Y1LTe9pjwiS3QN14PmKFwuSsx1vzua
         HG2ZpKYq9CzQ46VREeQkFviUIY2dGv3ZIWo9EbMQkPayU5FTHz/tNKRvtmC9e0axLYug
         JrdvD7ZFkeJBLy1q2djxnhnE+dNqVueebhU469LTsYhLULakSL3Ek8MhFIeanQt1MLpw
         Qy9fr8Uv2onoHSbnMX+FOpIiClzKc4vRijjM0aTRrn+BHQvgCXE9XKqwjLbXDn1CJ3WC
         UXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3hW7WRp42UpwG72NKBm3smYKhFioVF4VBZeKMtkEJc=;
        b=gm9VLCLqq9z5SelcYcUYpIeAMbc04WoBtZrYRcsKDRISJshWq5pjHkMal0NhUhYbHU
         /4g03lkcuUqAIeAWodkLFcFpu99tJd/jUaVerIlEzagAtjI8JwZQzVzUCXGmAAHNMoUb
         Agka2dY+mDI/y1IRUIDaJJVoAOI3f2wvHa9cfiJrU7vsj94RA0pKjfXAmkQLYhCC1pPQ
         LdUZoc9NmrVurMGXdRoSaq3YurZ6a4XNqvLsE1BV65rtZjiZsGNV5HGWpm5xB5hUNSkh
         PqHwQGiCDNrd31tBYHWMRiug8wtFpvkX+W1ZEVwg7ZhEaNmAkr/I0sihbEkbjdjGOloN
         hOIQ==
X-Gm-Message-State: AOAM5325DsA34VkO90vi3Nd44xbnw/0Q/Ry9T2l5hAn7VXr6kyt/iSo5
        0myfdRUWmp+2wmCpLEeIl261Rv0e9J+BRjHRwcVHwA==
X-Google-Smtp-Source: ABdhPJwxczce5QAXUzhylJSFNZPf8ftcpea7bapk2/tAqf92ArOw2sPuS7vZvF3Bc1+6aTPr1i3IoMPhAwn5WsRMdJE=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr15615242oia.163.1592906927646;
 Tue, 23 Jun 2020 03:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
In-Reply-To: <20200529072017.2906-1-linus.walleij@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 23 Jun 2020 11:08:36 +0100
Message-ID: <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 May 2020 at 08:22, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.

I somewhat belatedly got round to updating my QEMU patch
that uses this new fcntl() flag to fix the bug. Sorry for
the delay getting round to this. You can find the QEMU patch here:
https://patchew.org/QEMU/20200623100101.6041-1-peter.maydell@linaro.org/
(it's an RFC because obviously we won't put it into QEMU until
the kernel side has gone upstream and the API is final.)

What's the next step for moving this forward?

thanks
-- PMM
