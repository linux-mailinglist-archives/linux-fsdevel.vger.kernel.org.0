Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B435825A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHETe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 15:34:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51422 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:34:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so75862424wma.1;
        Mon, 05 Aug 2019 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FFXuFRa8iOJ18WlRqHjA8mIfxhC5O27ek028/P9Nj6g=;
        b=WsLcSMIgN5vkl1yy7iONJEshW98E90rrKMzbCSOKKh8JSFEixPuDVuMlstE6TxP4gN
         QUEP99WNKhoqQkTajWuH6ILafJrrHcjcurs34RhJ6qrpsq2910lEtDPjKRGwc6s1qdLg
         +msxnDNP23bk7n/QMR1WKv/nuDTY/coyNBqRBKPiiLQ6akDIqAvrPWT21N9Ge+ztY5l8
         Ng+29x+TRqdCet6LuAM7EtDTSuEPWS6BHbgiopiiHqIk2L0KP9o2EEnkInn8tt+smUDS
         pdslRN/wwRb2XmXyt3fHVbrpoGrGXkq9K7nfhuiYUTmph4efQkYxcMfWZ5H8PhLQq+IR
         ajjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FFXuFRa8iOJ18WlRqHjA8mIfxhC5O27ek028/P9Nj6g=;
        b=XHvuDy7ybpq9VHk30GePe4J8yyZOJJpEOf5eS7XJ05VFbPKkafWa+dBV5hW9lhxQR8
         HOFYJ5j+x+u/R63fuh/GXHUombXm23e8jG7nxnus3zVAFJ0PUNXGF9m9zwe87YgDun9u
         TWJH7cXXdYHcnFFb7bfwjuRe+TiR5ZkUWzjCyapghACIiI5/9N5A5xTb9x8W2cn1LT+c
         A0oK/lc7ljpZGgukbBeVmZ+Y0hewmC92aCIjCeqpTp5xJYgmiDM0TjWGpmrLYyK2DJQt
         Mpg4FOZAM27NVWd49AVlVsT9XB8LYtocYYkK+RNEBCug01wd86HLqdJSK5woH8cqdpFf
         /BIQ==
X-Gm-Message-State: APjAAAURFkrCglltW0SBNjJdaS215pFWUzjeeNnIg/D8w1evLfivyJQU
        R2MWzRnxdNeA1LOljbptD1JmysSlm4kF+wB/v/E=
X-Google-Smtp-Source: APXvYqzQwPdYG/05WIdvFe7B2TldXfshdQgaGz6CQHxHiMyKKy8UPn3A4735rs5uV/9BZt8J+BjS7BERTS3hlQfdMGY=
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr27979wma.36.1565033696014;
 Mon, 05 Aug 2019 12:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Aug 2019 21:34:44 +0200
Message-ID: <CA+icZUUBSnri4oCFoN+Bi_kJoDVYgwjbrBR7D+JAQVqC0AFYLQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] convert i915 to new mount API
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:05 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
>         Hello,
>
> Convert i915 to a new mount API and fix i915_gemfs_init() kernel Oops.
>
> It also appears that we need to EXPORTs put_filesystem(), so i915
> can properly put filesystem after it is done with kern_mount().
>
> v2:
> - export put_filesystem() [Chris]
> - always put_filesystem() in i915_gemfs_init() [Chris]
> - improve i915_gemfs_init() error message [Chris]
>
> Sergey Senozhatsky (3):
>   fs: export put_filesystem()
>   i915: convert to new mount API
>   i915: do not leak module ref counter
>

Fee free to add:

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

[1] https://lore.kernel.org/lkml/CA+icZUXh068m8UFeHDXCKDi0YfL2Z=WoONy7J7DJLqAT1CZ+rQ@mail.gmail.com/

>  drivers/gpu/drm/i915/gem/i915_gemfs.c | 33 +++++++++++++++++++--------
>  fs/filesystems.c                      |  1 +
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> --
> 2.22.0
>
