Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122A43BAF68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGDW4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDW4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:56:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5EC061762
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 15:53:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p21so7301527lfj.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDM4UIZ790n+ppfiycyw7+PHwfmRhuVZBOQnWXK0gRI=;
        b=H7WvdvevCm0cGmGJA9aPF6RMGQiFgDi5yd5uh3Pks/+TNEJ7O1vhOWAhm4nYRDgd3C
         +Hoq74/tki4Zh8QMlUvZEbZs5sSI/vm1gNgjkjOCSrCG1jB3Dt/dL6xqCxo6XEH4s3Lg
         YZLhI/kKu+ovHr6TBNJ4aNEZlqXTpetGfA/Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDM4UIZ790n+ppfiycyw7+PHwfmRhuVZBOQnWXK0gRI=;
        b=MrcjkAwFiZq+QS9yJQScjlk3JPqfSqoh+pTSD1Og37VmX1LnOctDQoKGF1hX2qnEW/
         N8jroRJk8cZqhMpB/8IG9dyinSFRDNwdBeRJ0LOMctGfj/jajsTik2jq94RdBZh8KIS+
         O1HO3rcUPxrgsFPbgiHyuNRqnJoEoTMYHPPqCm44wW8ZZ5K2plb7TEwmiYNHTLKqPlw9
         mcHCR/nf+u+ykRa3aR+55JiNop8ruq9VDmPAQYbr0jXOC021PxLlEiLsILizMw1u2lmh
         tGEwFA+N28muMSIcDx9KS/yJCLiFo0hblI7ayFukzXQCFWD+PC+jnBj4Tioj5mTqVvDa
         dmKg==
X-Gm-Message-State: AOAM533OYsmd0x+K+gujIODhH+XCbA6EojlYw6kE3dCQJISlpMJMp0sK
        QLk8gH305cv2L6dFsvcLbcKVXdXilcXW7e75
X-Google-Smtp-Source: ABdhPJxOHw+Ry6y6bH4uyWu5DT055LV7O/qvIIEq64Fs65g6ZbXOT4Oz2YvpZ6+4z+n/lnsOyQVefA==
X-Received: by 2002:a05:6512:2034:: with SMTP id s20mr4106433lfs.259.1625439207262;
        Sun, 04 Jul 2021 15:53:27 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r15sm904404lfr.245.2021.07.04.15.53.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 15:53:26 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id f30so29064318lfj.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 15:53:25 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr8027515lfb.40.1625439205690;
 Sun, 04 Jul 2021 15:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net> <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
 <YOI6cES6C0vTS/DU@casper.infradead.org>
In-Reply-To: <YOI6cES6C0vTS/DU@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 15:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
Message-ID: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 4, 2021 at 3:47 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> We could slip:
>
> #ifndef uaccess_user
> #define uaccess_user() !uaccess_kernel()
> #endif
>
> into asm-generic, switch the test over and then make it arm/m68k's
> problem to define uaccess_user() to true?

Yeah, except at this point I suspect I'll just remove that WARN_ON_ONCE().

I liked it as long as it wasn't giving these false positives. It's
conceptually the right thing to do, but it's also the case that only
CONFIG_SET_FS architectures can trigger it, and none of them get any
real testing or matter much any more.

All the truly relevant architectures have been converted away from set_fs().

And it's actually fairly hard to get this wrong even if you do have
CONFIG_SET_FS - because no generic code does set_fs() any more, so you
*really* have to screw up the few cases where you do it in your own
architecture code.

If it had been easy to fix I'd have kept it, but this amount of pain
isn't worth it - I just don't want to add extra code for architectures
that do things wrong and don't really matter any more.

             Linus
