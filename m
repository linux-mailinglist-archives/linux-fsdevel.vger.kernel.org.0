Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A37FBF458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfIZNtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 09:49:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46819 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:49:11 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so6566719ioo.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtl2zyxtlXZuy7RvH3QWuxbUWBhaFjPFStjZLvJQGrk=;
        b=DknNLd45XASfoxO4Ux1JkUwRyOD9cDS0bG2idl3BMjWoGDUuq6RHjKgl+b+3+8JT/t
         CCUdHpyhRKyoT7ja+jMqNPc1T5II8nPs4dKdLaInOCPrjoVQJAYm9wNRcSe3y7GWbgnV
         b1MHsWQ/3NQa1HhXuO13O8w8kVPU8+7eAZOPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtl2zyxtlXZuy7RvH3QWuxbUWBhaFjPFStjZLvJQGrk=;
        b=YRh/fQoe9Rcveww5F7rgDyZYzkeD/sM/WSDrq6a0SVr011R0O9CEx7cQs8RgOmwR3m
         b4q7AESbPcexED1yZAWglolzWj2uU5uITLN3EpQed8ykzx1tAAl4v42RPgx6uHb3CK+9
         B2CDzuz5d5E6MkHufHXdufHFy2ZN6mlsqLa+9N9HwDPmuTGrpcvctlD6uN7w9jrfNTwk
         eY8AJxb29Kk5uosBmLl385P1yaYDoaZGCNRezDkA6dvem1Zf/cr5U1C00Tw1vZtrL4v9
         3WzmvlLadFz9C1RW31wt6je37lOuD55/rbffnoHFh8UsRJRAE5KQH7DP3Mzee6k9IlxX
         FHSQ==
X-Gm-Message-State: APjAAAXXQ6dIa8kTjaJipzrSn8/M4hTdWamfIK/ZLfL+O9ua1S1udEms
        i5D2/FqfPTkeZ9+yBivYOTqiHUGMl7nbYgcuiV4O9g==
X-Google-Smtp-Source: APXvYqzCHPmQ8dEj63wpRIzUS09qNxccMSYkmYaPtSm1ncTKoz58AeDbzrz7cD88jFPL9iu1YKYjPUc8Ogk+W5bkiIU=
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr3275670ioa.212.1569505750220;
 Thu, 26 Sep 2019 06:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190926020725.19601-1-boazh@netapp.com> <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
 <e66f4a0a-c88f-67a8-a785-d618aa79be44@gmail.com>
In-Reply-To: <e66f4a0a-c88f-67a8-a785-d618aa79be44@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Sep 2019 15:48:59 +0200
Message-ID: <CAJfpegswpiuwHaAgo1kY2PWutjFtA_h-N_bMSaKA2MEsXkFXfA@mail.gmail.com>
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Boaz Harrosh <openosd@gmail.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 2:48 PM Boaz Harrosh <openosd@gmail.com> wrote:
>
> On 26/09/2019 10:11, Miklos Szeredi wrote:

> >  I found a big scheduler scalability bottleneck that is caused by
> > update of mm->cpu_bitmap at context switch.   This can be worked
> > around by using shared memory instead of shared page tables, which is
> > a bit of a pain, but it does prove the point.  Thought about fixing
> > the cpu_bitmap cacheline pingpong, but didn't really get anywhere.
> >
>
> I'm not sure what is the scalability bottleneck you are seeing above.
> With zufs I have a very good scalability, almost flat up to the
> number of CPUs, and/or the limit of the memory bandwith if I'm accessing
> pmem.

This was *really* noticable with NUMA and many cpus (>64).

> Miklos would you please have some bandwith to review my code? it would
> make me very happy and calm. Your input is very valuable to me.

Sure, will look at the patches.

Thanks,
Miklos
