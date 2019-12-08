Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09409116022
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 03:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHCEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 21:04:51 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45004 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLHCEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 21:04:50 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so9626082iln.11;
        Sat, 07 Dec 2019 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LlH2dOvK572wA3LQlWdBWmF+HbKqL28TX4vGxdhU3M=;
        b=E6sKswWCRmwzB1ja7v0ZhAn/Pzx7BxO0A1a6mOe0pQ+MRMusVf05gs+HkKOr2fXQy8
         qmPhHq0yZgocSYAc2bCQMStIjpa3XJo5xFgxeJ9JT3tuEnSSRpl1JYS/SrNRpYp49r8/
         Ud/aQfRCKCbQNg5dsowMM83O0z4fExWLvr205hj7wkLk0s9gHi4XboILqK9qyYYV7A4G
         HaHRo8HICOaCb9yT/cYxrJ621WxxW8rl/dDH7LcHSSAo8i44krDFhiI6ENoj42sQFcOn
         1VusDJ2diU7CBgp5vGNP94Ny67lCloeyKh2xdLC9rBSfsyuONAp0KpKYt2krEcQvHpst
         xUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LlH2dOvK572wA3LQlWdBWmF+HbKqL28TX4vGxdhU3M=;
        b=XKzl2YyuVzOKNXiN6X1igFhZjXv/aGwe7+bj6kA7HqFZw9hG3Ae5wkCsLi18Fu8Sfi
         YlmXASCAg8ENggPFzBn3uHKemGNVM5Wf8ZqVqyieb55bexxTh+3ga3TRLnUoIVtuH/TK
         l9b0F6TcK6sQdY3WeZ/F4+ddh3Cqmv7vFCBmoT7THrS8DArxtK0SjSEjLzLbMnrVvEUC
         CsRq/5jy6kBtqSKCxuZZimiwCUllXPl8qGeUisZ2svU2PhBTlNwrvQVg4pfaBQyQbdq1
         RLlQhM08N0yobeR1CrxayAU2FpH5jH5AtEo1mB/d366eIV6XzJJr78Ci4e8yuId1SdJx
         K2Xw==
X-Gm-Message-State: APjAAAXxPNZMBgehtJDTOdYrrE/f7hTlm/TMUMPI57y6vAjTB7RE7gam
        CS4nqccB4ApigluoPvbDvUdfttE4WFLDWva7dfBvlg==
X-Google-Smtp-Source: APXvYqxQ2oG2vjuo8AK3+bG8dvsCZ3h1Au02b8ccHDneQPnxpoRRip3/l9rzYpqI73WldLOEI9jiFuZod1sLiddxGzQ=
X-Received: by 2002:a92:c8d1:: with SMTP id c17mr21496674ilq.153.1575770689687;
 Sat, 07 Dec 2019 18:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20191203051945.9440-1-deepa.kernel@gmail.com> <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
 <20191207060201.GN4203@ZenIV.linux.org.uk>
In-Reply-To: <20191207060201.GN4203@ZenIV.linux.org.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 7 Dec 2019 18:04:38 -0800
Message-ID: <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jeff Layton <jlayton@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 10:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Dec 05, 2019 at 06:43:26PM -0800, Deepa Dinamani wrote:
> > On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > This series aims at deleting timespec64_trunc().
> > > There is a new api: timestamp_truncate() that is the
> > > replacement api. The api additionally does a limits
> > > check on the filesystem timestamps.
> >
> > Al/Andrew, can one of you help merge these patches?
>
> Looks sane.  Could you check if #misc.timestamp looks sane to you?

Yes, that looks sane to me.

> One thing that leaves me scratching head is kernfs - surely we
> are _not_ limited by any external layouts there, so why do we
> need to bother with truncation?

I think I was more pedantic then, and was explicitly truncating times
before assignment to inode timestamps. But, Arnd has since coached me
that we should not introduce things to safe guard against all
possibilities, but only what is needed currently. So this kernfs
truncate is redundant, given the limits and the granularity match vfs
timestamp representation limits.

-Deepa
