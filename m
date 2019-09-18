Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC4B61A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfIRKqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 06:46:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45857 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRKqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:46:39 -0400
Received: by mail-ua1-f67.google.com with SMTP id j5so2152167uak.12;
        Wed, 18 Sep 2019 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrhjnjM/XptL/cFMvLE/Y5Ttnqqp6IMVWZhIN4+ypyQ=;
        b=PXCOCYZLhjJjZhE0mCL7O99pzsqv5a9ePHsS5rpMpNEI66tHMcwkt6QXk6xsoRFdnX
         5xGiHw/Gq49SKAqf4iYSz+w/1DwypCsVdYkNzpMGceTRdxpzhk8epbsMm5g8Vhp0qgu0
         f4Gfg4dN+IDjBLnrk813NbLfH/un016KuQeOfs3ol+qbLgNt9wD4UZ1k+ns6Rh8DfLUb
         COOV5Sjf5+a33CIabIm4SZZfN7T4C1VbzYvwPZneQLdUxApH1uUnjIyavc8Ok9YwDiWA
         KOLH2G1jDo+JzZD/gzTPSh9TrxVelvjKdbYIFktwsLhftDuNpYvSRZfS1Aq5BrYg856k
         BKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrhjnjM/XptL/cFMvLE/Y5Ttnqqp6IMVWZhIN4+ypyQ=;
        b=fhM8qQboz3zb5QCqFGkgtCht7BkqvzNwgeFs1GFconCcqMf+F2MaSVBN4najtQODjM
         HgcT4aXbY1/58Bv2uaIlOvuBtl/SmO5byw5kQZ8dxK0bMAdz3EHVhLkiNVkBNF4BBeO1
         A7nC50ScyFdj4isg+toMpHbxfdK0ca7sFMmJnpSDywm1scSlzYAiNCK30lBariGsp4GI
         x0zBN5QNjK5LrAwKWPsJjpFoaU7vA59iwGj4TbuhLzR/I/HP5gJKcQKmcc5ihS/IP1wX
         zPH+gMSUtvlLdAZkxFt05TH39ugMPPO67VqRWmZS8PWz4ekwPMkywj76XiPT6hul5oMf
         +AqQ==
X-Gm-Message-State: APjAAAWeCPOd8sw6zGMtQM+KX1vVn3YtvwrpSpbB812sFj7Gz0tqsGVP
        qES2D3A7yD3/7P/Qs3/kDK8ev6C11uu7xapy/tE=
X-Google-Smtp-Source: APXvYqwIg2lHMqtsEN5dzTh1ZkxryX4kas0pMBnOy6W/Vn/g0zZ7QGhTYumeAnuCciJllbWcyxE3Z6bF4YyOBG+Ro2A=
X-Received: by 2002:ab0:2808:: with SMTP id w8mr1785489uap.75.1568803597279;
 Wed, 18 Sep 2019 03:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190917054726.GA2058532@kroah.com> <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com> <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV> <20190918082658.GA1861850@kroah.com>
 <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
 <20190918092405.GC2959@kadam> <CAD14+f1yQWoZH4onJwbt1kezxyoHW147HA-1p+U0dVo3r=mqBw@mail.gmail.com>
 <20190918100803.GD2959@kadam>
In-Reply-To: <20190918100803.GD2959@kadam>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Wed, 18 Sep 2019 19:46:25 +0900
Message-ID: <CAD14+f1yT2_d8RP2a2NqAVYAkmB4ti6KjSsV2sM8SVCOQ_M=RQ@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 7:09 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Use Kconfig.

Not just that.
There are a lot of non-static functions that's not marked ex/sdfat-specific.
(which we would have to clean it up eventually)

Even with sdFAT base, there are some non-static functions named as exfat.

Figuring out a solution for this is pretty pointless imho when one of
the drivers will be dropped soon(ish) anyways.

Thanks.
