Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62A2B36D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKOQ5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 11:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgKOQ5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:57:05 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D884C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:05 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so21434749lfe.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=GKe8HtSGVpql7itwBeLIkBdzeQTDlLA/NMjuNvTbYEKWXB7yyVUDwFWl9MTbBscdEJ
         hObKcjWJK90+BTLO+zgzmCcH+qCmtS9aZD909pSoyW/0/+CSK0ggGgVgQQGW5k7uiBQQ
         9/PazKzHsYQiacJMrzhtp0dCF64qWviUt14wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=C+MZTUXJUfOyoBcVRiGBJTKdxQ1mzYIiXM7QxCYj2iA9rcWbrBZ3vshRBJvcN3SP4r
         4/uwtAsyeU/V4tBGIzIfZruZ1ZVPEws8uOinPqPJy5IrcrzT2O9iKZTKgUeNor/6Jr9J
         IGPbnPip13clhKD5I75e2QVP6kzQYsqk42daNQ9jy83LVeudAdetsdy/WvWB0wlhbcnM
         v46MwpDIz3f8wbdK8HIHi9Gykj3Jb/qLANYRq20ZIlQHzTxq7a/MFHAEXSin+vA/FhTi
         2jhO/fhZFJEGfTBMQpNdY4wG0agPDsK2sIzMkim99R+jSApk5JjYBYpaI9yW+pnJdd2/
         Cw1A==
X-Gm-Message-State: AOAM532muoa+T3TotYf6YFBG2y0R2dyS9julPxmPSHXUgduVak/xpQ9D
        Lw3DdIB5juvgf4P/aE03vLK9gmzLmPW4rw==
X-Google-Smtp-Source: ABdhPJypeQD4QH9rROfEOleIGF+3S26geBUMpVWNXQx1uLYiIaltDg1ZVVK9O4cexU20XxyvK8yQXg==
X-Received: by 2002:a19:f207:: with SMTP id q7mr3942912lfh.588.1605459423151;
        Sun, 15 Nov 2020 08:57:03 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o17sm331869lfi.85.2020.11.15.08.57.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 08:57:01 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id w142so21425278lff.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 08:57:00 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr4592052lfd.603.1605459420530;
 Sun, 15 Nov 2020 08:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201111222116.GA919131@ZenIV.linux.org.uk> <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk> <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk> <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk> <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201115155355.GR3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 08:56:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
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

On Sun, Nov 15, 2020 at 7:54 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, I think I understand what's going on.  Could you check if
> reverting the variant in -next and applying the following instead
> fixes what you are seeing?

Side note: if this ends up working, can you add a lot of comments
about this thing (both in the code and the commit message)? It
confused both Christoph and me, and clearly you were stumped too.
That's not a great sign.

                  Linus
