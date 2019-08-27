Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE59E7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfH0MWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 08:22:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41310 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfH0MWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:22:02 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so45744635ioj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOPd5XCgXy2+S/HOEhe/AbwhZFgb/NCnMmHVmWZ9n/8=;
        b=I46V+ou5V4hHWnDItnnvqjB+gCXL4kLiCUAZqUtVLAEXu+8G5fOsrklMhEWjYcbJOB
         27SsLVe62YYWccWKh2GrIzzKbXOrrQp35u4NgCCYY9U8bp6JWd6RDc980q/vVknkTz0A
         Sq6sKtesc3vdPE/a1BGJE0Lit4NbK8YFBvcjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOPd5XCgXy2+S/HOEhe/AbwhZFgb/NCnMmHVmWZ9n/8=;
        b=qOul61VADIbSzqAkkpy5WEDMt3PcSsvChC4Nw0Ct4iJamSZ/berFxnxrraPnWdEren
         5BoxpSd9t8aKoiztFj3yZyy8Fifcv4/ygXy182ExHY2uYS0J6qunKzD7in39PQMYRnDj
         cE2OhrKtpmOO0NyPWg/l03LAjCHF2Q+y7PsbHGjThCQoG7HegHwqFbb0oEcjbuNz7iSD
         IjIuXbubqxpOMyhF3Lmc8sFTIwIU0/z6k3sQobrm7Cl3clIzDGgmlyFOXKuyaQPvSGW7
         MA4ir7dS6rnfGo7gG1C6QZhrHgzHQKJElAVM8ep4Isl3hOEIgzg9I58Pi5ImRsWGLHtQ
         Qw3Q==
X-Gm-Message-State: APjAAAU+/lm6iPL0Nxd9wv9P2lHdTPyyxTiSAzUNbpHEtE8AON6IpBI/
        nwLmWQOesrT2bLpU9dgSkUektlsi09S4w7Wab44SWA==
X-Google-Smtp-Source: APXvYqzdO7khz/lQ7E41XNHmVf548e2uq3f63Tds7aCm6H0xbHbUl65agjxGBymMxkQplDqMmciNl0UPoo2J6FMQ+ow=
X-Received: by 2002:a5e:da48:: with SMTP id o8mr3955838iop.252.1566908521634;
 Tue, 27 Aug 2019 05:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190826024838.GN1131@ZenIV.linux.org.uk> <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org> <20190826192819.GO1131@ZenIV.linux.org.uk>
 <20190827085144.GA31244@miu.piliscsaba.redhat.com> <20190827115808.GQ1131@ZenIV.linux.org.uk>
In-Reply-To: <20190827115808.GQ1131@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Aug 2019 14:21:50 +0200
Message-ID: <CAJfpegvvi0XLhtB3JxyVfzSG4T8A0k+CZ6=8EMUDsgWcwZkvyg@mail.gmail.com>
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 27, 2019 at 10:51:44AM +0200, Miklos Szeredi wrote:
>
> > How about something like this:
> >
> > #if BITS_PER_LONG == 32
> > #define F_COUNT_SHORTTERM ((1UL << 24) + 1)
> > #else
> > #define F_COUNT_SHORTTERM ((1UL << 48) + 1)
> > #endif
> >
> > static inline void get_file_shortterm(struct file *f)
> > {
> >       atomic_long_add(F_COUNT_SHORTTERM, &f->f_count);
> > }
> >
> > static inline void put_file_shortterm(struct file *f)
> > {
> >       fput_many(f, F_COUNT_SHORTTERM);
> > }
> >
> > static inline bool file_is_last_longterm(struct file *f)
> > {
> >       return atomic_long_read(&f->f_count) % F_COUNT_SHORTTERM == 1;
> > }
>
> So 256 threads boinking on the same fdinfo at the same time
> and struct file can be freed right under them?

Nope, 256 threads booking short term refs will result in f_count = 256
(note the +1 in .F_COUNT_SHORTTERM).  Which can result in false
negative returned by file_is_last_longterm() but no false freeing.

>  Or a bit over
> million of dup(), then forking 15 more children, for that matter...

Can give false positive for file_is_last_longterm() but no false freeing.

255 short term refs + ~16M long term refs together can result in false
freeing, true.

>
> Seriously, it might be OK on 64bit (with something like "no more
> than one reference held by a thread", otherwise you'll run
> into overflows even there - 65536 of your shortterm references
> aren't that much).  On 32bit it's a non-starter - too easy to
> overflow.

No, 64bit would be impossible to overflow.  But if we have to special
case 32bit then it's not worth it...

Thanks,
Miklos
