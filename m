Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABE4058B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhIIOPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbhIIOPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:15:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72EC0F0378;
        Thu,  9 Sep 2021 05:30:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so3392793lfu.5;
        Thu, 09 Sep 2021 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAl/OZXNRp/QAbUi6FlwGJXU2TI4ZvTh9dSb4AyChuI=;
        b=IHBcF9fW/zT6xas0XbHv0lbF++TAh4rpkz3W5Vvr6PSzbIocMq9GcKAPb5Wj9LMUI8
         v2KO0fNYYWttrO6UD3GtUpiyC0m7tPbHiWkVwuPHQtFyZPR44ns6Rqc2XQoJhKSIgfho
         OBxCO4QGDcN3izAGsNxEK+NMOqTqGoFmqyCeFbEq1IKEIgFyxtwVtyqP+ZqnCcqy9ZrQ
         0F3RKNfLCWKhFy5RrFee/hfsL6j9VXkm5Q1W/6zUsTv8QHYx3VDhtWrdb51mwdKFp+Z5
         5KWQv+6kSTwqpBlXcxRXcUaXvEpUzKOEX2kpbSzgH+mpBcIfDs8lOqZ+PwujhQryvMvq
         tONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAl/OZXNRp/QAbUi6FlwGJXU2TI4ZvTh9dSb4AyChuI=;
        b=xvcg0yaASeuanCI8X6Kvznn5SItouBqxxyhumrY658m4pAHpG7sP1lTV+lzIwAs25f
         9FQVUAhuyD6NJb2hsN/USYedN961zQmS0ej5oY0/L4N3KoAasKC0Eyy5DCm45crS3AQR
         VHLSA001Pb2x9PM8cGC1PuRtC9fNnLM1mA9jjWYsCuvjSqhXbTacyd4AUtTLx7w7mvNt
         BbUTOhDE/y2Tqlh0/NiEhZIYrHGdd1LAsSXWarJicev62ltZDegYNFAWgRMpHsAcyJvU
         vzeghWHqC2NxVX+IiYjwLTpymQOixaF3Rn9Et9lvccFAX8dqFrLITpVrTn1bp8fl0puu
         u2SQ==
X-Gm-Message-State: AOAM530Xm00++6SBIMTtgDKCRSbJemzLVXn9q9nNTVA/sEMjxvIGU1+g
        f1b0ilJisasYY0J0TFED0MWHv7+p3PM=
X-Google-Smtp-Source: ABdhPJxa3w6Kqrb3uUV9i/wSpTFxJwPM+mc4Mrm3bk5Q5bnmgsRhV5dZAczLADmQxXMOXwIax+LQiw==
X-Received: by 2002:a19:c7cb:: with SMTP id x194mr2190596lff.490.1631190636694;
        Thu, 09 Sep 2021 05:30:36 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t17sm186042lfq.176.2021.09.09.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:30:36 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:30:34 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ntfs3: Change max hardlinks limit to 4000
Message-ID: <20210909123034.mlsq57bsjvonwwd2@kari-VirtualBox>
References: <89127d37-a38a-d15c-36f1-62f2ac0f4507@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89127d37-a38a-d15c-36f1-62f2ac0f4507@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:58:04PM +0300, Konstantin Komarov wrote:
> xfstest 041 works with 3003, so we need to
> raise limit.

No need to linebreak.

> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/ntfs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
> index 6bb3e595263b..0006481db7fa 100644
> --- a/fs/ntfs3/ntfs.h
> +++ b/fs/ntfs3/ntfs.h
> @@ -21,7 +21,8 @@
>  #define NTFS_NAME_LEN 255
>  
>  /* ntfs.sys used 500 maximum links on-disk struct allows up to 0xffff. */
> -#define NTFS_LINK_MAX 0x400
> +/* xfstest 041 creates 3003 hardlinks. */

It think comment is unnecessary here. If you think this is necassarry
comment then please but it same comment block as last row.

> +#define NTFS_LINK_MAX 4000

What draw backs there is if this is 4000? We really do not care about
xfstests if we have some reason to not do this. This info can be but
to commit message.

>  //#define NTFS_LINK_MAX 0xffff

We can probably same time get rid of this.

>  
>  /*
> -- 
> 2.28.0
> 
