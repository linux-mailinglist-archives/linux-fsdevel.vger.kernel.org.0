Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C31272C16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgIUQ1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgIUQ1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:27:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70384C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so14709455lfb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8LK5dloOXhiAuv1jzPTpg6aj5g8mwVrNmUPAV9ogWY=;
        b=RFMB/gNwPwfIqudW3R4jXCFsXqrNlGTxVuJ7YvVxCKzq5Y/YUC/Ma6uY7s95wRftZ1
         7s8sQIj4iiCqfqYdGopoS/gZplkdWgCmkY2aCa/c5cevLuamU4HpSU0quOZvV2Xv5EaL
         vunDI/0xHWZgKhUbEF4U4wC7LUJxngCiHSvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8LK5dloOXhiAuv1jzPTpg6aj5g8mwVrNmUPAV9ogWY=;
        b=GyXClOM5cwREL5gbtHU44vAASbvbINYhopLOuYSL+YMLVuPF/STQN5b8LR/xqenCa7
         BtdNnOuZA9ShykDoBZaJnrl4XARoYpHAC2o0FhTDOuW9uX5pp9RgPNRve2d/H12OhOXZ
         AP4La4XrWHNNN579V59KeVJ9r02bTnL0piPiSLry4WGyAhOU2D+iDDPb2WaF3sRyqBxw
         EnBYcAsHIQGlKlkmfNE99tvII62YpZDgc/ycYGA3LPAUE5uKDfkpGroo/+QycoQEus82
         jZoRDottdqMEy3dmCHOHbTY12HKiqgS3fwmZtU6+xklxljXgBQDaURPM8oimSrQ4HmaK
         a5dQ==
X-Gm-Message-State: AOAM531PEnhEJHwdE/FS6JZK4NLoT8Fg8RS62OVHOuVrJA+VhqUcHZxp
        U8QGbOzCNHTLpLAAOmjfc3wOg9Lcnqn6WA==
X-Google-Smtp-Source: ABdhPJzwfEYgfq+lfMfXC0jHzWM6nZpyO5rSxooFYwWyMJVNjGxFlRjswPJW0gBvu3dc+/na6RPJEw==
X-Received: by 2002:ac2:5463:: with SMTP id e3mr235202lfn.474.1600705626561;
        Mon, 21 Sep 2020 09:27:06 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w4sm2661891lff.231.2020.09.21.09.27.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:27:06 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d15so14697438lfq.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:06 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr149175ljh.70.1600705241845;
 Mon, 21 Sep 2020 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200623052059.1893966-1-david@fromorbit.com> <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz> <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils> <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils> <20200921082600.GO12131@dread.disaster.area>
 <20200921091143.GB5862@quack2.suse.cz>
In-Reply-To: <20200921091143.GB5862@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 09:20:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
Message-ID: <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around filemap_map_pages())
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Hugh Dickins <hughd@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 2:11 AM Jan Kara <jack@suse.cz> wrote:
>
> Except that on truncate, we have to unmap these
> anonymous pages in private file mappings as well...

I'm actually not 100% sure we strictly would need to care.

Once we've faulted in a private file mapping page, that page is
"ours". That's kind of what MAP_PRIVATE means.

If we haven't written to it, we do keep things coherent with the file,
but that's actually not required by POSIX afaik - it's a QoI issue,
and a lot of (bad) Unixes didn't do it at all.

So as long as truncate _clears_ the pages it truncates, I think we'd
actually be ok.

The SIGBUS is supposed to happen, but that's really only relevant for
the _first_ access. Once we've accessed the page, and have it mapped,
the private part really means that there are no guarantees it stays
coherent.

In particular, obviously if we've written to a page, we've lost the
association with the original file entirely. And I'm pretty sure that
a private mapping is allowed to act as if it was a private copy
without that association in the first place.

That said, this _is_ a QoI thing, and in Linux we've generally tried
quite hard to stay as coherent as possible even with private mappings.

In fact, before we had real shared file mappings (in a distant past,
long long ago), we allowed read-only shared mappings because we
internally turned them into read-only private mappings and our private
mappings were coherent.

And those "fake" read-only shared mappings actually were much better
than some other platforms "real" shared mappings (*cough*hpux*cough*)
and actually worked with things that mixed "write()" and "mmap()" and
expected coherency.

Admittedly the only case I'm aware of that did that was nntpd or
something like that. Exactly because a lot of Unixes were *not*
coherent (either because they had actual hardware cache coherency
issues, or because their VM was not set up for it).

                 Linus
