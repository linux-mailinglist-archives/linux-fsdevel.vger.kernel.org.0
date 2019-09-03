Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86550A7741
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 00:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfICWsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 18:48:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45274 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICWsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:48:08 -0400
Received: by mail-io1-f68.google.com with SMTP id f12so22301081iog.12;
        Tue, 03 Sep 2019 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+0ODIduqf/tig5TqOM+YYbA2pYXGKyyZMpPjI/CsX8=;
        b=J0XNMsKqjAhcQwLt76rnH8en27O9JMnuKV7ZBTjpCzepEvmogt9TmOjqRlunlJTEvA
         c+kq4qKWV/V524gOdnZFpjgCnt0LcQ2NL70JRUKYqmcFHeSS18g7rtpTtTxYD8VOU4P1
         JRAbwIsZQRth7gFv1DnvUaDRrX6o3tyqpqZ0DgYUq2ETaPj/YB0ykk8k0coxttXBZpNc
         ZqSa+gx/yLUrEgBOgAImPkWHky5HJrpkDnBAiomnVVudaoFshDxwHUHX3O+kXg4bHT0z
         aBoxmGDtdFv7sxBfiPCAp9YSZCXsU7k1bzlZV8osegPJZsMUTEhLm0H2IUlAioUYtauI
         pOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+0ODIduqf/tig5TqOM+YYbA2pYXGKyyZMpPjI/CsX8=;
        b=pqBjSfvM5gtRdCxS7Kgf+NtsEDeSAf8HkJfpWtPNKr7HCQMmw0xpSVlRVQstvRNnN+
         QlHSdwL6klcwzKS4pIG7mSjZkqeh+5T5xLMPeUWIXiyvTglxVWmLVSDB3reJkTy1BCGB
         bTB5bJxPz1ASDgi1+dbuvPbt9oCPpthi1EI1NNhpgpIEG7ZJpIFgz6cIXIQYcWrFNWO0
         Pd1UEtWZ3SkzXK572YYdtWzB+eRWpvhtvJgfT/wY9OTESXTdv5+NzKkZjrrSzUSh6YeO
         1gfQGKJeO32+qs0YPZjN0Fn+wJtpZ2IMULWm+tXvnkwhp6zZ4GmpTGYW9A159Zjpy/QS
         fLDg==
X-Gm-Message-State: APjAAAXfHF67c3HB/mvwlV3Y4DEn5ZeMZwG4XgUcGEJWvb5yXc0FV4Ep
        XMI7qlm/+aZbCzEXSYx6cdsJsyTjbN0JQrZ/r7k=
X-Google-Smtp-Source: APXvYqxL7i4UeofXXJaH/gf00fdwKKSPYQoL60LkhxA+rTFqNotrqukDI/d4cZTKeFr27MjQ1rT6YHRuwhb24v4vQ04=
X-Received: by 2002:a6b:400f:: with SMTP id k15mr2827489ioa.153.1567550887031;
 Tue, 03 Sep 2019 15:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu> <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com> <20190903223815.GH2899@mit.edu>
In-Reply-To: <20190903223815.GH2899@mit.edu>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Sep 2019 15:47:54 -0700
Message-ID: <CABeXuvp2F4cr_77UJDYVfQ=gD8QXn+t4X3Qxs6YbyMXYJYO7mg@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 9e3ae3be3de9..5a971d1b6d5e 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -835,7 +835,9 @@ do {
> >                                  \
> >                 }
> >          \
> >         else    {\
> >                 (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
> > (inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
> > -               ext4_warning_inode(inode, "inode does not support
> > timestamps beyond 2038"); \
> > +               if (((inode)->xtime.tv_sec != (raw_inode)->xtime) &&     \
> > +                   ((inode)->i_sb->s_time_max > S32_MAX))
> >          \
> > +                       ext4_warning_inode(inode, "inode does not
> > support timestamps beyond 2038"); \
> >         } \
> >  } while (0)
>
> Sure, that's much less objectionable.

The reason it was warning for every update was because of the
ratelimiting. I think ratelimiting is not working well here. I will
check that part.

-Deepa
