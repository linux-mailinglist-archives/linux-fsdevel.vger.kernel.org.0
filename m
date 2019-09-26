Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EADBF8D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfIZSHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 14:07:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34764 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfIZSHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:07:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id h73so24826ywa.1;
        Thu, 26 Sep 2019 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9m+nbdrnuzIY8RdTnjng+ADoFa6AiieChTxE8L3fAO4=;
        b=Yr21GQW2sPifrxNyEdZWLPApb9f4Ta2qIpdtwUI7g0zZkn/2C5u8h64I83GmBqj7yj
         64Bto8ppTvm8YR0NPv2RjF2CLimqjBOmUc1vNb4zBUIHMItC9P7skyupVQ0FSS3vGKCC
         KGzGv+NrBsYNtLJ6FOyp6Ialk0/9Dmh9XdehVVRq1EqPDwHf8Ktn/wnhNqlYePjKD+eV
         pqk493ft5RBhUbgKbartACtY5cIwPSzQvv6PNKDCeOTes1MFWGnJb1xzcCMYyr/WJA6Z
         2ET0tv9jBUVSMtzyZdrJHPzWiVpMrP5anLLzh2o88LO5r+oZJ3cgyXreeOJ2w4SywwKm
         BwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9m+nbdrnuzIY8RdTnjng+ADoFa6AiieChTxE8L3fAO4=;
        b=P8YVjhmyZm3YcX9KLRTylRrg9m3/h5lqjoPMzc4gorfrzynGQQ3sEWXyrLi4T3aGZb
         FmqZjzf9Y5oDrVdJC1TP5GWO591QqxhYAPeJGQGIKdSZy/IQ5A2eZYjxVguJcIr5369S
         fLnFDTFIw/vgK6EY2MZp9OGkv8FvuFk7kBqxn659o4bVhEdnCc2vOnD5GLRJKvodr9kh
         KDBAti/CJRTcw/9bv7aA7t+9rhW2v1EUmOO6YjFcZoP+NDS29eCLX7Hp1UAaTysJ1p8y
         B02bROddkpjHM8Uvai08mx4lGvyh+BUTFB4fj/sMtdxw9RIPTMmnb61fWK+Xqpe8LYSE
         6SWg==
X-Gm-Message-State: APjAAAUWejhe/Q2/GBNfLgMbUYbFkhGQYi5AAUHU5hw6pE4lG4Q0lWeR
        mIsG4KxPfpaQcHL030RyklZG4mV4GZ2xDRjACK9QkZwi
X-Google-Smtp-Source: APXvYqzLBlCTzINCjYW+UL6VL2Djnn03Z/ZniDZBc7ep02rLJLQd7z8sr30Pfv59xe0ACSSfwu6I7YJDGHTcoU9AmjE=
X-Received: by 2002:a81:7743:: with SMTP id s64mr3570104ywc.183.1569521238956;
 Thu, 26 Sep 2019 11:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510> <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
 <20190926175700.GA12619@x230>
In-Reply-To: <20190926175700.GA12619@x230>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Sep 2019 21:07:07 +0300
Message-ID: <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
To:     Petr Vorel <pvorel@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 8:57 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
>
> > Started to return EXDEV?? quite the opposite.
> > But LTP tests where already adapted to that behavior AFAICT:
> > 15cac7b46 syscalls/copy_file_range01: add cross-device test
> I'm talking about copy_file_range02 (15cac7b46 changes copy_file_range01).
>
> Anyway, the problem which I want to fix is a backward compatibility for v5.2 and
> older to fix errors like this:
>
> copy_file_range02.c:102: INFO: Test #7: overlaping range
> copy_file_range02.c:134: FAIL: copy_file_range returned wrong value: 16
> copy_file_range02.c:102: INFO: Test #8: block device
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
> copy_file_range02.c:102: INFO: Test #9: char device
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
> ...
> copy_file_range02.c:102: INFO: Test #11: max length lenght
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL (22)
> copy_file_range02.c:102: INFO: Test #12: max file size
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EFBIG, but got: EINVAL (22)
>
> LTP hasn't defined yet any policy about changing errnos,
> as it's probably best to check whether change was intentional
> (like your obvious fixes) or not.
>

IIUC, copy_file_range02 was written after v5.3 changes to verify that
copy_file_range
stays unbroken.
As such, I would suggest that you check if kernel supports cross-fs copy, like
copy_file_range01 does and if it doesn't, skip the test entirely.
If some one ever backports cross-fs copy to any distro stable kernel, then one
would better also backkport all of those API fixes, otherwise test will fail.

Thanks,
Amir.
