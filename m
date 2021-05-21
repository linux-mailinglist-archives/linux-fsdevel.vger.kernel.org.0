Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEF38C5DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhEULm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhEULm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 07:42:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469AC061574;
        Fri, 21 May 2021 04:41:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p20so23576266ljj.8;
        Fri, 21 May 2021 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFYeACD6ntHDr3ZzL7zrrnF7+KzQ9eLPKf1tdFUUddQ=;
        b=C19rWBqLdiJcQCPCyqFA0u37icaVwV4D09Rt8zjZm5Hxl+j78AQ/TO1W0R01yYFuqr
         EKzIgdDPIkW2YGGY8ow+B91Ne2XTmXgnuMeK2Kel7XbaBTDt5BpFWF/PpyuSyIJBM0GK
         vUf4fh8ZyIjNn2CbfXQ8WDNGZNH+KGtbYyiIck6MzNQf2jSqpjOeZqOfv6jvOvxioOv1
         QzCVTJAMxOAalZ2kwdzofV709K/FHkJpMZPXNA1xjiJ7MKE5ZKuGfvbjybHvhgN8ymy9
         v2XdB5ZHlExKxkErQwEDWvAEE8zzrbBaJvcB9y7KakQDKkYPUvIkU2dugfm1ltdjFYBr
         ZgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFYeACD6ntHDr3ZzL7zrrnF7+KzQ9eLPKf1tdFUUddQ=;
        b=K9AEmsWvEkQu40kDvHHWFpMJtkfipHk9ZzRMwnaGshCovWmRwDVMd1c8056jePZSQh
         W5VLJ94MYt0dBoa9Skmj4gzM6qGVoNp1lZ4Xhka+JSN+8KtNHVA6MGWbwi/a2XOT7dOi
         jxbmFzqP2uFfCKer+YiwIE0iSHYWvUtyAsQO+T9sPVKwlqxV7cz9bAYY7kaDP5PL44L8
         EGS7Kry8tteBsM6t0tPJUT+omyApXqW6HFVh9LoS1+pQnXZg+uSBHKST3nqU4PSxRlKy
         CreuRMHB/uT/o0XMrZtjrBuEhGC+mv9RPcoDWAMyxqc5d1jsk16O/bNQK2yjswV196I9
         Q2Xg==
X-Gm-Message-State: AOAM530kzJdxhmu9xAymuABfFOr+63sFxsbGbaKd6BXWUljaLeztDBR8
        V6Fdj/5achIaXgP+3/Yot9s=
X-Google-Smtp-Source: ABdhPJykWgciebUg4UHyYyvCEuObukTkXyH+IRrTgfovQF4Kf899lKrwftO2wF8cWlzIIMGgSQJYVA==
X-Received: by 2002:a2e:a594:: with SMTP id m20mr6911414ljp.114.1621597291530;
        Fri, 21 May 2021 04:41:31 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.140])
        by smtp.gmail.com with ESMTPSA id z41sm597991lfu.88.2021.05.21.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:41:31 -0700 (PDT)
Date:   Fri, 21 May 2021 14:41:28 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     viro@zeniv.linux.org.uk, shuah@kernal.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This commit fixes the error generated due to the wrong
 indentation which does not follow the codding style norms set by
 Linux-kernel and space- bar is used in place of tab to give space which
 causes a visual error for some compilers
Message-ID: <20210521144128.052e3c48@gmail.com>
In-Reply-To: <20210521105654.4046-1-shiv14112001@gmail.com>
References: <20210521105654.4046-1-shiv14112001@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021 16:26:54 +0530
Aviral Gupta <shiv14112001@gmail.com> wrote:

> ERROR: switch and case should be at the same indent
> +	switch (whence) {
> +		case 1:
> [...]
> +		case 0:
> [...]
> +		default:
> ERROR: code indent should use tabs where possible
> +                              void (*callback)(struct dentry *))$
> 
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
> ---
>  fs/libfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Hi, Aviral!

Always check your patches with ./scripts/checpatch.pl. It will warn You
if your patch has common errors (ex: too long subject line like yours). 

I think, this link might be helpful
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.
This document contains canonical patch format and other useful
info about "how to send patches".

Goog luck! 


With regards,
Pavel Skripkin
