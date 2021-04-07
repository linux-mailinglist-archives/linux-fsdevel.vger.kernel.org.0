Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721C135737C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355004AbhDGRtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354970AbhDGRtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:49:16 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1399C06175F;
        Wed,  7 Apr 2021 10:49:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l9so6700431ybm.0;
        Wed, 07 Apr 2021 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiOCUaiGGKRX88uC2hhWzg2n/Y2Yo2JIeBQw2MeES9Y=;
        b=IVYpe3h6vqlBmey674p9xQP8iu4QFcT9wa3nqNym6RVaW8qQFJHBdFrakWO0L3rYZd
         w3yFBZfp0YyF6nuuUavDQpcrmEJ9a5DWxJA3xcE0gFIvXuYjKG/UwC3TCDq6sobpqvg1
         q8ExndoCCn1h6Me6BiZp7WPo9QoBB2tGT2w8Vc7RD8agzDj3IbyfqSL2pOtyp1VX/+tL
         GfXq5M1b0QSB/nfj+iOz4oAOEg+pqHskzGDsa1LPO5zktWLQrJRWeSAbpNpszx9IrcBo
         L6rTeePhcA43iFyVlw/+BTOP5KeCaJ0+5Lhd8oZjPm2EB55W4Hp7enIw2R6HqXuhUSAd
         1IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiOCUaiGGKRX88uC2hhWzg2n/Y2Yo2JIeBQw2MeES9Y=;
        b=N39BYm2XldPHOgav0rjHbwwnGLwK5hlgVt4tppnpReq1yewe94Qk4aGbNHmkxCoudR
         p5JHvG75N8kpApZTf5+KsDE/5FScLlHt2ye24cmy0XQ+mB8ohvevMzGr0LUCaSd08CeH
         cgYQocLxYlUNlL0c9nj00fUwp2OmFRtbzJ7e42JBpA6q0fPn4a0qBjUAanMpqVfghhT0
         e2RDajRNkZIxOvDcGj2wIgAw2Cv8uaFAaGDAAPo74lA1pLjortjWs9uRHeW3JcG0iqXb
         E0yPXhgfwvMyoVClInzUdAeNxypEWQj3vTJ94/7tHGOY4jGSEwU06gpMPwJvwkh0uK0v
         qzsQ==
X-Gm-Message-State: AOAM531Opr7WjFQPtHnHHK5F3j5SS4BP0DqNYW49oYhAwcjF0M05+rdV
        gMqJiHfP5ZZE/6tvR0oRxcCAkPRAZw03uPEjKR0=
X-Google-Smtp-Source: ABdhPJxCjxRwQSFk8pt13CtSveZEy9xbCnZGaS4TDcTzHRbhv+2qbtCdklZM9+Xxt+utGikdBM6scZ90ysY1jtFE36s=
X-Received: by 2002:a25:56c2:: with SMTP id k185mr6365565ybb.131.1617817744836;
 Wed, 07 Apr 2021 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210406104500.675141-1-wanjiabing@vivo.com>
In-Reply-To: <20210406104500.675141-1-wanjiabing@vivo.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 7 Apr 2021 23:18:53 +0530
Message-ID: <CANT5p=qkE4+wDOV_LH07Zkfe=sxmNmaEWm2d-e525_oe7bm0_Q@mail.gmail.com>
Subject: Re: [PATCH] hfsplus/hfsplus_fs.h: Remove unnecessary struct declaration
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>

On Wed, Apr 7, 2021 at 1:28 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct hfs_btree is defined at 73rd line.
> The declaration here is unnecessary. Remove it.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  fs/hfsplus/hfsplus_fs.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 12b20479ed2b..4da395c25f4a 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -139,7 +139,6 @@ struct hfs_bnode {
>   */
>
>  struct hfsplus_vh;
> -struct hfs_btree;
>
>  struct hfsplus_sb_info {
>         void *s_vhdr_buf;
> --
> 2.25.1
>


-- 
Regards,
Shyam
