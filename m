Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263EBCD3C9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfJFRSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 13:18:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44929 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJFRSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:18:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so11183951ljj.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqhtcbRfDvEQJJkAJFzv4RBTuiXKftvmCXLEi1f3srQ=;
        b=RFX9iEr5oOWgtzp3IBXT04OndQR1DU0EDSHmP2z8P81qc5WnlH3q3z+H6Fn+Q2bRDQ
         H0mj8t0g+mmdm8jwf4l9ysW9y9jx14fPTmNboT3xsSFw9Hg+XXFMXj7P26RjheVyaX4i
         ysqZhaJqY2V93IZXO8nKnxagXIV7guXuOEkKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqhtcbRfDvEQJJkAJFzv4RBTuiXKftvmCXLEi1f3srQ=;
        b=jydFp/i394OYU8F6+6N2lADHEoiZiCYIsd2BqofhsZs5g6f6JcY8dcKISGmdSC/tUs
         dUDLv2mOqrAYBfPUSMtxK+/XeYbCAOKuJSmirs8Xz6el2NgYs63cAlux0qk++FoOmwUF
         /fZGuNkDz8M1eUjcPj07LqS/vlPq9xloqs5G6hO4K8nP11N7a/X/uZfuMLvUU6LtMD4V
         Hp6HFERUuHEXnkwonwIzsea9Tf1KI5t9durOBc+8snShTxoUnAHErl7hSsoq7ms1GouE
         jWERQVehJIfUSDfEZtdirROHJp4MeqZEssgJqv4RLv1pJdp3tJCo53OSuGwmGNKrydeZ
         yr0A==
X-Gm-Message-State: APjAAAXWxS1n42lVd6kl9UTI6q+L+ni26Eujgu3GcuXATGS1Q8+8wJW+
        aSd4LtXe9Bke5rofuFS02j4zkH3UwVE=
X-Google-Smtp-Source: APXvYqy+NLaHkEZn5SkzcF++qMKJnqsq5Y+Lyf1p63BM482KgHW/slp3xU5XwVikF46stmCu2TA67w==
X-Received: by 2002:a2e:a17b:: with SMTP id u27mr15015994ljl.65.1570382310354;
        Sun, 06 Oct 2019 10:18:30 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f6sm2311495lfl.78.2019.10.06.10.18.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 10:18:27 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y127so7662605lfc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 10:18:27 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr14509292lfe.79.1570382307072;
 Sun, 06 Oct 2019 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org> <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu>
In-Reply-To: <20191006165436.GA29585@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 10:18:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
Message-ID: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Well, one thing we *can* do is if (a) if we can create a kselftest
> branch which we know is stable and won't change, and (b) we can get
> assurances that Linus *will* accept that branch during the next merge
> window, those subsystems which want to use kself test can simply pull
> it into their tree.

Yes.

At the same time, I don't think it needs to be even that fancy. Even
if it's not a stable branch that gets shared between different
developers, it would be good to just have people do a "let's try this"
throw-away branch to use the kunit functionality and verify that
"yeah, this is fairly convenient for ext4".

It doesn't have to be merged in that form, but just confirmation that
the infrastructure is helpful before it gets merged would be good.

               Linus
