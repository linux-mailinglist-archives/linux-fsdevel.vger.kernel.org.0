Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5154413A4C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 11:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANKCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 05:02:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41640 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANKCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:20 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so13175012ioo.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jfedMJ/vA4zu7acKics8Ws5Wqx3BUxJ/rGetXdTcgE=;
        b=Iw9W5uPcE5KYGDECfrMKJFS/UvhCajR1SyhNQ81PJhYOk238BnGqASfbVzfkO+gJ3D
         aX1O5FKC11K4/Vexl531cEfzSPe2fX+LN/BeZ+AMRcGUxl/leWqsAgqMoxLIbKFSsCwq
         wJT+NuK6bZgzo5Ssk4KtsHL6OC6fGpDa2A0+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jfedMJ/vA4zu7acKics8Ws5Wqx3BUxJ/rGetXdTcgE=;
        b=JvxmNs1H0gxoXQkOcSQfRjli7hPkxns/hLrjQVQXCM85Lz9g5om+kgg1xPGW3ZbDdg
         15R7RkSgGoNeXnWBeQlXtETwlpRnlXbBS/GvZTstIWNEoboqT9lLwucsb+RC4eH7vlJr
         4XNoWCwZnXBRyF/qyPzkY+2iFJf3jDVgl+Z/0CO8YAtjR9KE8375hca4IlmLVKB3ucyX
         fYkJaJZ9qkJ+BjMcbbbhKjplT/ra6JDu6PKtio3NDrjZfm/q16G3zw2h1H9rV6XlQtPH
         vH9HC0o2jbTE7AQZyDpumxRygKiZrKEddB+ZXjL/4TNAP34hc6/oabXNb8OE+gQPw04h
         dYow==
X-Gm-Message-State: APjAAAXfGOaMnFTgz3jl1YQAAvp+AI84xAdz44BnTVFfknhFqhcVU3oT
        McFj1RKefJ9/+c2ASXzk/iRO6EnAGM7CaRv1V6Tccg==
X-Google-Smtp-Source: APXvYqy1janO8CiU14UilTRqO1ag47AlOt4FEvHcayoRXkBmbTIyl/mKWpced1Ng5QCwcXRAE6MUNrzwdEYzKiB959k=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr17794901jap.35.1578996139394;
 Tue, 14 Jan 2020 02:02:19 -0800 (PST)
MIME-Version: 1.0
References: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jan 2020 11:02:08 +0100
Message-ID: <CAJfpegvpZq_mMAABWPWOGKJTfiAf6bJE9eBkvH-FkwhMJmdq5A@mail.gmail.com>
Subject: Re: [PATCH 0/4] fuse: use true,false for bool variable
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 3:55 AM zhengbin <zhengbin13@huawei.com> wrote:
>
> zhengbin (4):
>   fuse: use true,false for bool variable in readdir.c
>   fuse: use true,false for bool variable in file.c
>   fuse: use true,false for bool variable in cuse.c
>   fuse: use true,false for bool variable in inode.c
>
>  fs/fuse/cuse.c    |  4 ++--
>  fs/fuse/file.c    |  4 ++--
>  fs/fuse/inode.c   | 14 +++++++-------
>  fs/fuse/readdir.c |  2 +-
>  4 files changed, 12 insertions(+), 12 deletions(-)

Hi,

Could you please merge these four patches into one?

The patches are trivial and even the combined patch is tiny, so it's
not worth splitting it by source file.

Thanks,
Miklos
