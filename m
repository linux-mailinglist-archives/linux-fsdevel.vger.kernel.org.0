Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF00347A01D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhLSJ7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Dec 2021 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhLSJ7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Dec 2021 04:59:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9932C061574;
        Sun, 19 Dec 2021 01:59:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gj24so6507308pjb.0;
        Sun, 19 Dec 2021 01:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dG68qbbN9Wct+UUNDOZqFZ/544NhXHzV1/15tPR+FZQ=;
        b=qxHxo7P4Hmn3Co0lx+drz0KAQB5rS9kl7ZYFcZdRRbb7g8xE1kzNS9GNUyxxCrMfQT
         RfAJN7vWYS9skka5kzDB1Rk7Gqe+jr7H7ZR4rCq/iR+ldQ+zl0mhhqv5TJNPGxfrRFup
         VJIghQje4LiOG7OwXFupSwLFgvyJcmRjHr5QJnyogq9MtAhlEcNzqC+YKsVkw7lirTfN
         sryZgZcqIQjPiWa+p0CLYu3O/jGddC88jYvKOATqcgJMdsv/mwwY1LpZIPhNB1OWkZh6
         f1tP3fFcrEzCu8G/Id+li3Q7c0//Ank/PSro7DjAkv/7Er1Q8IW0Oc7NlqTRQoC9YKL6
         bA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dG68qbbN9Wct+UUNDOZqFZ/544NhXHzV1/15tPR+FZQ=;
        b=QVUYrwd9bvSQ63Ke2hmBcTPBAKII75ghBMYb2a/mfo4Qt3gAJd9TlSZLGwfYUalIkb
         81zH7YvS3896f5Di0KfCg37lazSxO217WfLyGsEZXtDVzMPxxhPXHkzGlOt5xrn7ejyk
         T9AjsmVqIfQhC76YbShYVWSuj/dHtZu2OFjb+JbEjExjQe7fZRCZmBZalI2zb7syhN5N
         oBuvC6+7oQ3pzbxN1NMnv4wR24kaZyqk7eDGVoEGGjmV+HZqiUksQhrW0tJ5AYsCZsHp
         V/fvs4S0v8kZe7rarAu0jr7BNQultJrcqklrwycb+u6iWxHuETQcttawpmLvTot8BbBV
         L9fQ==
X-Gm-Message-State: AOAM532YTl0Ula1wzvw7VzaNV5rl3J9r7ggC5WuLCDAijcvml1UGLl31
        y1SUOn4Ig4NHt0R/u1e178c=
X-Google-Smtp-Source: ABdhPJwzUCgNcdoLqJpWlON/LozZCUZMCGAOfGDxUBk0PHq7KdOUOS95eg7rsJ8IVKUG17BiUM2tnQ==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr13879309pjb.190.1639907947026;
        Sun, 19 Dec 2021 01:59:07 -0800 (PST)
Received: from smtpclient.apple ([123.114.22.133])
        by smtp.gmail.com with ESMTPSA id lb12sm1924537pjb.27.2021.12.19.01.59.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Dec 2021 01:59:06 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4 00/17] Optimize list lru memory consumption
From:   xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
In-Reply-To: <YbyM17OMHlEmLfhH@casper.infradead.org>
Date:   Sun, 19 Dec 2021 17:58:55 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, guro@fb.com, shy828301@gmail.com,
        alexs@kernel.org, richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AF1C950-FA7A-4D70-9E92-72C7BE32293A@gmail.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <745ddcd6-77e3-22e0-1f8e-e6b05c644eb4@gmail.com>
 <YbyM17OMHlEmLfhH@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 2021=E5=B9=B412=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=889:12=EF=BC=8CMatth=
ew Wilcox <willy@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Dec 17, 2021 at 06:05:00PM +0800, xiaoqiang zhao wrote:
>>=20
>>=20
>> =E5=9C=A8 2021/12/14 0:53, Muchun Song =E5=86=99=E9=81=93:
>>> This series is based on Linux 5.16-rc3.
>>>=20
>>> In our server, we found a suspected memory leak problem. The =
kmalloc-32
>>> consumes more than 6GB of memory. Other kmem_caches consume less =
than 2GB
>>> memory.
>>>=20
>>> After our in-depth analysis, the memory consumption of kmalloc-32 =
slab
>>> cache is the cause of list_lru_one allocation.
>>=20
>> IIUC, you mean: "the memory consumption of kmalloc-32 slab cache is
>> caused by list_lru_one allocation"
>>=20
>=20
> Please trim the unnecessary parts.  You quoted almost 200 extra lines
> after this that I (and everybody else reading) have to look through
> to see if you said anything else.

Sorry for the inconvenience, WILL do next time ;-)=
