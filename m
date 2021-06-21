Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533793AE538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUItR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUItQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:49:16 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C59C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:47:01 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id o198so1718279vkc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXtdpap2XWVQM3NEM8tHgG7IZgx4gfDzJ3mSSoym7bQ=;
        b=hQnIxvAO+GKOw5DtQZRyn+Ht3RUiPiiUOc1AEuz4qtakU0ufowvZk69wobzde8tdu5
         dus5DWnhFKzZS7vlwyU6eqSvLLxil8zxsfTp2E3RgbxDdL6R4kLwzXE6mdccdtu8Jffu
         NS+ObbYojD8PrU+HsVCoZt8VTFQesY0GbloQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXtdpap2XWVQM3NEM8tHgG7IZgx4gfDzJ3mSSoym7bQ=;
        b=i6O/+lmc5kPoZg0OVlRSbqgwx1OELJNshubCdp438dVSXkdLRHdU3tEM8nRRkrYsYM
         6nkzOFNbYj6FOl25AxITWrK+WwkAqKIMq1LK94icHZ7IS87dFstfA+fEBwg2C3qObUhc
         h+r7p43hLEN/x8V2SBN9j5VANvr4s06fiwNKQltHanap5xi8KQUf0I1KWLhnZtwb6065
         70Bb94k4wc/dPdIRhaTumGdjxvYBr+1cyu/PQbA52A+48PgIU5bqhKEnsRchLZViolW8
         ex4R/mDgBSIO1dQ7Vc6evAw9TqzQsalJsjGCZvmbwTXe5L46I/TgtWxZAeQf+4GkBoWl
         dDCA==
X-Gm-Message-State: AOAM532PsuFYXMjyZCeX7X3vs8TK23m6OS7j24n4ixSWvw7IeK6+qtmw
        /iXnUoN5fbKaqYhZaOn664DA0IgCY57qH3n549HFpxX23cMc1Q==
X-Google-Smtp-Source: ABdhPJwl4UkjpqNWthBeTMv582+Ok4ondhv7QW6U8UxWLSXdoFi3E/5c/bQdoRsRfek0HDgKz3lwTrf9YFBlSzfXnD8=
X-Received: by 2002:ac5:c5c9:: with SMTP id g9mr4609680vkl.11.1624265220845;
 Mon, 21 Jun 2021 01:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210523065152.29632-1-yuehaibing@huawei.com>
In-Reply-To: <20210523065152.29632-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:46:49 +0200
Message-ID: <CAJfpegvE8hFMyMuc8TmhojYihknmH+xuB0=3vAGHsakSavtm6A@mail.gmail.com>
Subject: Re: [PATCH -next] cuse: use DEVICE_ATTR_*() macros
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 23 May 2021 at 08:52, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Sorry, I don't see really see the cleanup value of this patch.

Thanks,
Miklos
