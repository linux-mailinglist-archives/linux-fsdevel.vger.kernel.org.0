Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDB243575
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMHwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHMHwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:52:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB50C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 00:52:15 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s23so3635388qtq.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kbfJFqw0BUIJ5TzLMuAPa26O83MFMfq45p0iJLXoQ24=;
        b=ZAQkkNengTyFVITiU/IeQgQ8HUcxvR/qUzlEP1RkhZ4iS/OOOs5MyjOL3nQ9ZPHooL
         2Lm+rlX360bQxFPcvK+ssLbn55/ZstUNPA/IZ46mxJz660/HZNdYyR1dOgo4ohnvMnnB
         FM7Fk7t4lTwEdO8ewUfwXcSV8fzdb0Q+1cStpUJmN6rjCCECvD05//W62XGFcP5Gt2t5
         7/3/h3cAUMoxSh5DXwYOH4jHbFuLuUIpKk5KUxrZox9QeYctu7eizH7U7PvqsVHSX5+p
         9lQjmDIlIHqGjLXUQuJQ8nYrrWwq2vjQwsjqY0pG7M/1LYgcCxrtqvNNfZI0rq3HxnJw
         zZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kbfJFqw0BUIJ5TzLMuAPa26O83MFMfq45p0iJLXoQ24=;
        b=pLYNa3LVlV3dmMn77J9ONZdgSgr8f9WpCtXD9CHU3KETUZnOdmuS2/+0eY8Imu6rh5
         y59aujQT6jlz/se5skU6ZamoWzBOW0+DzSgweZURXio2AtIpcKRpie55sdki8kqWKTfv
         IntZajfVSbmM8fAeaeSzkgZ9P9mD+n4yp07W7Z/GAoJNc/rv16DGFONkJHIZXxJ7TVWx
         Ihbjp2V0Q1fIqPVKUckrpyQeUbwJ1+nCVE/6WKSrO0hcJviWR6FNmXkTxDGJPjnLF6Ju
         /98qRrff+6H6N8dbgivIzVe9R/3iyosGeujX9Jeot/zpfkATRQDZwG1/tmgoqqtMUDAe
         PoAg==
X-Gm-Message-State: AOAM531FRFWcSMctMr7yCYHZ0QqV6gFFLUqQdc7ux4T6cl214CQ/iUrt
        JYgYVjaJkMgET1WraXtIYusf2A==
X-Google-Smtp-Source: ABdhPJwXBjdbY+cfEn3nH6Dvsv9NW6v8lfVVdt+gfD3Khr2STj2r4zFVVUFuWHwQj4GikY9LLremaw==
X-Received: by 2002:aed:3e45:: with SMTP id m5mr3655774qtf.210.1597305134863;
        Thu, 13 Aug 2020 00:52:14 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y26sm5348981qto.75.2020.08.13.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 00:52:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Date:   Thu, 13 Aug 2020 03:52:13 -0400
Message-Id: <B409CB60-3A36-480D-964B-90043490B7B9@lca.pw>
References: <20200813054418.GB3339@dread.disaster.area>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, khlebnikov@yandex-team.ru
In-Reply-To: <20200813054418.GB3339@dread.disaster.area>
To:     Dave Chinner <david@fromorbit.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 13, 2020, at 1:44 AM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> Ok:
>=20
> file.fd_write =3D safe_open("./testfile", O_RDWR|O_CREAT);
> ....
> file.fd_read =3D safe_open("./testfile", O_RDWR|O_CREAT|O_DIRECT);
> ....
> file.ptr =3D safe_mmap(NULL, fsize, PROT_READ|PROT_WRITE, MAP_SHARED,
>            file.fd_write, 0);
>=20
> So this is all IO to the same inode....
>=20
> and you loop
>=20
> while !done {
>=20
>    do {
>        rc =3D pread(file.fd_read, file.ptr + read, fsize - read,
>            read);
>        if (rc > 0)
>            read +=3D rc;
>    } while (rc > 0);
>=20
>    rc =3D safe_fallocate(file.fd_write,
>            FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>            0, fsize);
> }
>=20
> On two threads at once?
>=20
> So, essentially, you do a DIO read into a mmap()d range from the
> same file, with DIO read ascending and the mmap() range descending,
> then once that is done you hole punch the file and do it again?
>=20
> IOWs, this is a racing page_mkwrite()/DIO read workload, and the
> moment the two threads hit the same block of the file with a
> DIO read and a page_mkwrite at the same time, it throws a warning.
>=20
> Well, that's completely expected behaviour. DIO is not serialised
> against mmap() access at all, and so if the page_mkwrite occurs
> between the writeback and the iomap_apply() call in the dio path,
> then it will see the delalloc block taht the page-mkwrite allocated.
>=20
> No sane application would ever do this, it's behaviour as expected,
> so I don't think there's anything to care about here.

It looks me the kernel warning is trivial to trigger by an non-root user. Sh=
ouldn=E2=80=99t we worry a bit because this could be a DoS for systems which=
 set panic_on_warn?=
