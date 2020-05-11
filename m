Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090891CE7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEKVuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgEKVuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:50:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9FC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:50:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so11606846ioh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30OBEUef85m/ckhkASd0DpFRvKSiINQKGJMeze9kTy0=;
        b=Ba5c2U5iI75Br2YzOpt0q4NQjCS14rKxUGorMjadU4DgW1qTJq3Iyc4NoW7b5wADFi
         33sHbejqVvHEAYKZj3+Dp7YKKy4fNJ0DM4fFi5+EPpd7Qvasyqbq1qV1YEo4l1NIEjjs
         Lc7ZVjVDHjzgO95qhCtYxd+JZv5S8kCOto76bX4/8IxR5U/ugC+QsLnr43mli9l6SNln
         riiokyMgevwIcF73XUXVEgRM6Er7wHGWR0i/l3g1m1d1c3Xd2f21FVLM/txbG3O/+MP1
         UNGCzYX7OpiRaMQC2fpSeMfQjGd8gIsANIVnBOpXh6WwgxQYhmcJ5gzMzv4ylmHIcJME
         jrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30OBEUef85m/ckhkASd0DpFRvKSiINQKGJMeze9kTy0=;
        b=IFXDprSSmNtKHYoqrtIJBibreOGUO2bDErY81/vG9LsAC1rxFu89DY8cq97ABaqHHq
         rJRUXXMzzkNGJRxtGtcNjWwIHifBTDOzkwJNwohrOYPFkkNAlZ3VvG1SC1XrK57wFxRm
         j0t/tEz2O2OyyacPPgHOnsQGz5MobKuu2DWGtEKknjPQ3BZdPNAMW+uELoA+NtLzGh5L
         WJagCges/k+nGwrDQx5yTiZS82njV9iD3oMmaBrkoxPmws6Kx5hQu5s34hOSK958uLai
         2btkt9JwI5+WkJEvckomYH8X93SOUkjiUb8/EsJEJTDFls/nGFRbmIy4TIqu0gHfyhbh
         YDHg==
X-Gm-Message-State: AGi0PuZF1M5umBbhDvkOVbzMYciR/tizD615nfVM522fI90F1guXionH
        FBdruRsa8M5Iit7SZKbcTeiXYB9YyGzpzXKsYjs=
X-Google-Smtp-Source: APiQypJDYCUWqulxNR6khHuPzKCs4htOkq7OUmS8hihuk9/7nwxfPuZPX1CAOa3/504mNwcafL+8CbcpZCyCUl9saww=
X-Received: by 2002:a5e:840d:: with SMTP id h13mr7377001ioj.64.1589233810705;
 Mon, 11 May 2020 14:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200511180227.215152-1-fabf@skynet.be>
In-Reply-To: <20200511180227.215152-1-fabf@skynet.be>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 00:49:58 +0300
Message-ID: <CAOQ4uxhyjPD=Q7e-v1LWH3b7kcT-R+UCF6RaU11CTs+2+B5RKw@mail.gmail.com>
Subject: Re: [PATCH 7/9 linux-next] fanotify: don't write with zero size
To:     Fabian Frederick <fabf@skynet.be>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 9:02 PM Fabian Frederick <fabf@skynet.be> wrote:
>
> check count in fanotify_write() and return -EINVAL when 0
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  fs/notify/fanotify/fanotify_user.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 02a314acc757..6e19dacb2475 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -485,6 +485,9 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
>         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
>                 return -EINVAL;
>
> +       if (!count)
> +               return -EINVAL;
> +

Maybe even (count < sizeof(response)) ?

>         group = file->private_data;
>
>         if (count > sizeof(response))
> --
> 2.26.2
>
