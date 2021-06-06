Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEE39D1FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFFWsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 18:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:48:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D73EC061767
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jun 2021 15:46:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i10so22991898lfj.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jun 2021 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XAmrqQtetCdv1FWiIQ6avH4N6kog0uzfOlUbx+cm4I=;
        b=Lz7Upx6XUMuJW+XLGSZogswa/KETZouaABh1tibWpMUD9XpdbA7tkyroipFnJcQCwr
         hSc8h+cSYX3kKRjuvTMivkaywluOPG8adH9/2RgODGBnxFMIWgZNKb86xRGbxKou0TOu
         Zszi4YN8hNOR3UKIBW9WBQaowozt7Ab7LPaiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XAmrqQtetCdv1FWiIQ6avH4N6kog0uzfOlUbx+cm4I=;
        b=hLS+cmajJw/a2aNjCjB63QGkXiSRTZLKcXPGDVfF4lYI0172Hz5ps+NWmrU+YAp9Dl
         54f0ITDyeAZnSLsCKjEwYGvGkuHP+KGhmEcX5za8EwnsQ/OquZXHAd5QXgzCq2auwyPJ
         oKwYvgZh4zAAmKvkzEAOvtLwN7Q5r9ooxBUw5DkNMi3YTJTlGalBf42PCZGJpLc90AWE
         qCQsIBPGBLB9ur+Sb9qCQ4lAkhSzP6VCZOAX0c9dKRfqNjlWCIHYL8Wq4DmZCI/s6evq
         bSbbYt/HetTcBzAMLq91COo/d6kKsZvn5JsH8+0U/AwQu/c9vbMAeLhKRLfa1iteuEdU
         cw7A==
X-Gm-Message-State: AOAM530K7xeQ8bdCSPXlABq7hcO0INRaxOvALbXEu65JQIx/rYlQpPX5
        rp/XUeJoihzGW/gXv2V5jBjRu/N9IWpxcoZC7ko=
X-Google-Smtp-Source: ABdhPJwPMeddyeJW+A9qR3xTgHdSP+1wHK0qFoF+Uv4OJKxZymV7pm6c2v9Mq6zcAHbHnQPsONEqnw==
X-Received: by 2002:a05:6512:6cc:: with SMTP id u12mr10027674lff.32.1623019614335;
        Sun, 06 Jun 2021 15:46:54 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id w15sm515757lfq.94.2021.06.06.15.46.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:46:53 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id v8so22961602lft.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jun 2021 15:46:53 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr9989167lfl.253.1623019612906;
 Sun, 06 Jun 2021 15:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk> <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 15:46:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
Message-ID: <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 6, 2021 at 3:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think iov_iter_init() would actually be better off just being
>
>         *i = (struct iov_iter) {
>                 .iter_type = uaccess_kernel() ? ITER_KVEC : ITER_IOVEC,
>                 .data_source = direction,
>                 .iov = iov,
>                 .nr_segs = nr_segs,
>                 .iov_offset = 0,
>                 .count = count
>         };
>
> with possibly a big comment about that ".opv = iov" thing being a
> union member assignment, and being either a iovec or a kvec.

I don't know what kind of mini-stroke I had, but ".opv" is obviously
supposed to be ".iov". Fingers just off by a small amount.

And yes, I realize that 'uaccess_kernel()' is hopefully always false
on any architectures we care about and so the compiler would just pick
one at compile time rather than actually having both those
initializers.

But I think that "the uaccess_kernel() KVEC case is legacy for
architectures that haven't converted to the new world order yet" thing
is just even more of an argument for not duplicating and writing the
code out in full on a source level (and making that normal case be
".iov = iov").

               Linus
