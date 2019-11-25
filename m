Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51355108BF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKYKmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 05:42:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46618 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKYKmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:42:09 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so15584142iol.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 02:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+B/nVdafVBM5/dMhmn3bx+mejZS7Z1pG2S9hER1tbY=;
        b=UoGRlg/aCwPzEcnNH5oLQwU1wHejhiY4zlbMgpRVenqBQYvr0oU3s1HuYXUnBOpGaZ
         jSkG26bpnd7Z+2y621l1kUW4x2gy1WCbGVL34x+sDpMld724Yz/fQsNL/MwH4bIUORuH
         SV2LudJzIm7OVSUNO+c8CxfBRDsByThe02Ibo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+B/nVdafVBM5/dMhmn3bx+mejZS7Z1pG2S9hER1tbY=;
        b=Q9u+mJMnL/r4FvfE4MLBxBRKgf1g1lErQBbT7yOTgB9c0hjCr5r3CrMm1U9wxPIS4H
         wcyYUJ4Vmekt3YYc67UzzSj/NTc+VMJa6/Pu7W7S/lSYipO+fnVDgQKngbm56Fpp8d+S
         nIXZMjnX4M4rlaUo/1x606fc61xUIw5d/RBUnHeiADQXIyrUFxCbXDnTAcEDFA1kdfbU
         Q15mb0hX8pGtuRYfLU5CXjdDhbzu03wO2yMrbuERdcvodEdd2d0+wUzQSJSX2DXS9jUE
         un6N6brpXxjqRyeToEqa19N0RM2z4Mr9IZu8ptLTXoxSr70B5vFC92NQYD5hT5a6PBob
         2kkQ==
X-Gm-Message-State: APjAAAW+JQ6xFGTF2TSa2NTrdhxtZeh8DZ1rkIh1a6Rk+tSNHG1/K6S+
        TuRnjR6fZc4E/DtQGj6rGC3Cmv9dOXplzVyP4gOIaA==
X-Google-Smtp-Source: APXvYqwCxLkdsT8rBQH9Cd/qrlw5KUr81ZdbOyC/YXzhlOlZ5vfdgNrOJPgX7JYFLYBy6AmC+NrP8lZ13cYy8QnYAh8=
X-Received: by 2002:a5d:91da:: with SMTP id k26mr25050284ior.252.1574678528733;
 Mon, 25 Nov 2019 02:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20191120192655.33709-1-dwlsalmeida@gmail.com>
In-Reply-To: <20191120192655.33709-1-dwlsalmeida@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 11:41:57 +0100
Message-ID: <CAJfpegsxXJN1Z5fGzcv=+sid6gSzyD=KtA2omF2Xsx8dy00tRw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: filesystems: convert fuse to RST
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:34 PM Daniel W. S. Almeida
<dwlsalmeida@gmail.com> wrote:
>
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>
>
> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.

Hmm, most of this document is *not* an admin-guide at all.  The only
sections that really belong in that category are "What is FUSE?" and
"Control filesystem" and maybe some of the definitions as well.   The
mount options for fuse filesystem are not generally usable for
actually performing a mount, most of those are actually internal
details of the filesystem implementation.

So I suggest leaving this file under Documentation/filesystems/ for
now and later work towards splitting out the admin-guide parts into a
separate document.

Thanks,
Miklos
