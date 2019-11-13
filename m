Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF34DFBA0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMUiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 15:38:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44183 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:38:50 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so4073877ioo.11;
        Wed, 13 Nov 2019 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxcRlNzcBiAlNudn6kLat8m1vGtNWaR0Jl7FMyM2EN0=;
        b=umNxMXgm8tIXimc6Ozqie+Gdq82fKd0dw3loWE9SmGvZAEvk9fJbiRnYW0NFTikUTG
         AOjEZDGuo6/TiRCPGgN68PH+TcYITjdsx3AcWZn/LTfuYDGh47Dlm2+jNYfaOHz1B+rn
         lh+5DE24bJugrp5ewgePSfZ2sFYuUCjLtxeJHa9LmOFcHA0/FvWGTw5rPGKb6YRTOiNT
         6F6uV/lMfmyuYvJ0HkxxSGTZfT4TADggleQ578z3uQzjueYa2Y9mRQ+pzkA4N2QCvCT1
         0JXRsA3pCFDDhBzpFcxtVHFmHbHddlGxGyo//LyBa6rA3QYAa49hiNhO/Ef7HakKmvBC
         tReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxcRlNzcBiAlNudn6kLat8m1vGtNWaR0Jl7FMyM2EN0=;
        b=GVHMqLJrSVzpKfc5cIimfhn6FdoCqjiUev6OHGhNRDyYJ2liZrfgBWhSTTpOKQ6L7C
         ge2I+rdDeBh3vJNOeeXBeGlr63W4UkqPYp31IFgf1zTSIr1Ug45oQXB6xJodCbphxDRr
         0zPUZFYpaYSz3QPk4COTq7BvEViH2JTqYf5r+rhaO9TwGdhprrXpm2ovHbqmGFQ99pc7
         kycInqWYStqb2pRZTpoksXPHnHKuFpYzguWku1MIInmc3JRywx6jxgdNTYPclzuBbYsu
         Y+lcnJZ8z25FBNuyTKlQUz41jnY9bZ3albhtJoa0mMjaUVg+Uzg+uu3LV7OEc1GP9g+i
         dSdw==
X-Gm-Message-State: APjAAAVlQ+Q5uh3WwbVzNLqepXtvf8wYW3jR10CNrL7p482V2I+C+FoY
        LDItD01V/SeqjNY+lM3yZn580+NeCjuqtRxfUXiTVuQU
X-Google-Smtp-Source: APXvYqxRL9CM16SQPo7Zeq+ZHRXSjENb/hONgI8YRT826tl7bxT8C4vPD8W2YsYzu1nrCI82QHmInaBKQRJzcwW/y60=
X-Received: by 2002:a5d:8789:: with SMTP id f9mr5317745ion.237.1573677528331;
 Wed, 13 Nov 2019 12:38:48 -0800 (PST)
MIME-Version: 1.0
References: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
 <f34aaf61-955a-7867-ef93-f22d3d8732c3@cogentembedded.com>
In-Reply-To: <f34aaf61-955a-7867-ef93-f22d3d8732c3@cogentembedded.com>
From:   Han Xu <xhnjupt@gmail.com>
Date:   Wed, 13 Nov 2019 14:38:37 -0600
Message-ID: <CA+EcR22=7F7X-9qYXb94dAp6w0_3FoKJPMRhFht+VWgKonoing@mail.gmail.com>
Subject: Re: [PATCH] jffs2: Fix mounting under new mount API
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tested the JFFS2 on 5.4 kernel as the instruction said, still got some
errors, any ideas?

Without the patch,

root@imx8mmevk:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00400000 00020000 "mtdram test device"
mtd1: 04000000 00020000 "5d120000.spi"
root@imx8mmevk:~# mtd_debug info /dev/mtd0
mtd.type = MTD_RAM
mtd.flags = MTD_CAP_RAM
mtd.size = 4194304 (4M)
mtd.erasesize = 131072 (128K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

root@imx8mmevk:~# flash_erase /dev/mtd0 0 0
Erasing 128 Kibyte @ 3e0000 -- 100 % complete
root@imx8mmevk:~# mount -t jffs2 /dev/mtdblock0 test_dir/
mount: /home/root/test_dir: wrong fs type, bad option, bad superblock
on /dev/mtdblock0, missing codepage or helper program, or other error.

With the patch,

root@imx8mmevk:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00400000 00020000 "mtdram test device"
mtd1: 04000000 00020000 "5d120000.spi"
root@imx8mmevk:~# mtd_debug info /dev/mtd0
mtd.type = MTD_RAM
mtd.flags = MTD_CAP_RAM
mtd.size = 4194304 (4M)
mtd.erasesize = 131072 (128K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

root@imx8mmevk:~# flash_erase /dev/mtd0 0 0
Erasing 128 Kibyte @ 3e0000 -- 100 % complete
root@imx8mmevk:~# mount -t jffs2 /dev/mtdblock0 test_dir/
root@imx8mmevk:~# mount
/dev/mtdblock0 on /home/root/test_dir type jffs2 (rw,relatime)

BUT, it's not writable.

root@imx8mmevk:~# cp test_file test_dir/
cp: error writing 'test_dir/test_file': Invalid argument

root@imx8mmevk:~# dd if=/dev/urandom of=test_dir/test_file bs=1k count=1
dd: error writing 'test_dir/test_file': Invalid argument
1+0 records in
0+0 records out
0 bytes copied, 0.000855156 s, 0.0 kB/s


On Fri, Sep 27, 2019 at 3:38 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 26.09.2019 17:21, David Howells wrote:
>
> > The mounting of jffs2 is broken due to the changes from the new mount API
> > because it specifies a "source" operation, but then doesn't actually
> > process it.  But because it specified it, it doesn't return -ENOPARAM and
>
>     What specified what? Too many "it"'s to figure that out. :-)
>
> > the caller doesn't process it either and the source gets lost.
> >
> > Fix this by simply removing the source parameter from jffs2 and letting the
> > VFS deal with it in the default manner.
> >
> > To test it, enable CONFIG_MTD_MTDRAM and allow the default size and erase
> > block size parameters, then try and mount the /dev/mtdblock<N> file that
> > that creates as jffs2.  No need to initialise it.
>
>     One "that" should be enough. :-)
>
> > Fixes: ec10a24f10c8 ("vfs: Convert jffs2 to use the new mount API")
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: David Woodhouse <dwmw2@infradead.org>
> > cc: Richard Weinberger <richard@nod.at>
> > cc: linux-mtd@lists.infradead.org
> [...]
>
> MBR, Sergei
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Sincerely,

Han XU
