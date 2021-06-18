Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FC3AC819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhFRJ5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhFRJ5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:57:37 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C20C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 02:55:28 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b1so4637538vsh.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXoLC8xSY0jDl6EA8igvgz4yLKJxOfwVcSJzT49WjS4=;
        b=addmB2u/2i2j3j4KRLPux4XXXn8DgN1mr1GQDfeBXvX3qDJdDh8d7oU6BfNDkRFNa5
         cQDHuwocb+ljlxqE2yySNMU0FExIY9hAcevZte74TOdnMOtxqijRoblUdX8dLRT0YGlg
         0pmODbsSqDZmWUgZmblnzhLn9q813Tufydjno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXoLC8xSY0jDl6EA8igvgz4yLKJxOfwVcSJzT49WjS4=;
        b=N52CIweV8FI/k9VmHZWxsPaxipegZwKYXoOd6LZOeiKXx2juarLBnKhk8lzkGsTvx3
         E2f2tFhNSjp2XnySndXjS4GP/tOrJioxtgQzL+8D7PqgxFpKZqVgD8WRMnNKMTlsJFw/
         3losETyDtQWYkmuFWswZ/14Q5W/4N+nmxFd4AYa/eZraDZS3qVJ9QcqQNp4sFhiToNUB
         cNUtfGLC9OXeE8M5XVfRWMruj0cnAKuu1+OpN47RpQ1TSg10X0oGvpQarm/zqXYFjbvB
         qXx3mgZ6na1tdwYxB30dRi7ySvOAK2A2gEXhHc8epNgOSdfoFZ/BIXsYBL7BTe594Wvs
         WI/A==
X-Gm-Message-State: AOAM531uTWlhv26twqCzHeQRkCIR/PvXqaqrJJsuf7NSZssOpZAfOSae
        fCJkvRfSDyWXM9eLOTTpx9ODkPIlVlmU43WDIk+Alg==
X-Google-Smtp-Source: ABdhPJxhaqY6e1R51cAlENX0BEBC+/uaW+xBKl3GiSGyCT2HSPL/l2zWYvhgUWmk5DziqZFJ+VUXFOBdLdyDdZBK2XI=
X-Received: by 2002:a67:bb14:: with SMTP id m20mr5939948vsn.0.1624010126889;
 Fri, 18 Jun 2021 02:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210615064155.911-1-jzp0409@163.com> <CAJfpegsDP7C_8O5_pPKSwLz20-=JpEMzq7U+kwKGG9Fku==g3Q@mail.gmail.com>
 <3a47eade.6096.17a1e87d2f9.Coremail.jzp0409@163.com>
In-Reply-To: <3a47eade.6096.17a1e87d2f9.Coremail.jzp0409@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 11:55:16 +0200
Message-ID: <CAJfpeguvTrSe_jysWqT-p7YsGL3NNia6a+bQdMFEQEx+-xqobA@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: set limit size
To:     =?UTF-8?B?6JKL5b+X6bmP?= <jzp0409@163.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "edison.jiang" <jiangzhipeng@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Jun 2021 at 11:51, =E8=92=8B=E5=BF=97=E9=B9=8F <jzp0409@163.com>=
 wrote:
>
> At 2021-06-18 15:10:27, "Miklos Szeredi" <miklos@szeredi.hu> wrote:
>
> >On Tue, 15 Jun 2021 at 08:41, jzp0409 <jzp0409@163.com> wrote:
> >>
> >> From: "edison.jiang" <jiangzhipeng@yulong.com>
> >>
> >> Android-R /sdcard mount FUSE filesystem type,
> >> use "dd" command to filli up /sdcard dir,
> >> Android will not boot normal,
> >> becase this system need at least 128M userspace.
> >>
> >> Test: open adb port,
> >>       adb shell "dd if=3Ddev/zero of=3Dsdcard/ae bs=3D1024000 count=3D=
xxx"
> >>
> >> Result: if not limit size,Android system  can not boot normal.
> >
> >Without understanding the specifics, this does not look like a kernel
> >issue at all.
> >
> >Why can't the fuse server do the limiting?
> >
> >Thanks,
> >Miklos
>
> Upstream nevert do the limiting,This leads to the problems I mentioned ab=
ove=E3=80=82
> That's why I want to solve it from kernel.

Upstream of what?

Thanks,
Miklos
