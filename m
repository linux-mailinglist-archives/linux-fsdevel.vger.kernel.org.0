Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B384058F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhIIOZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhIIOZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:25:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4565C120D58;
        Thu,  9 Sep 2021 05:57:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i28so2836854ljm.7;
        Thu, 09 Sep 2021 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yaXPdkw/Y9GdnRrZu+T/3Q1JexcjWMNdLrpPjZG0BhA=;
        b=D2U7cycoQUakuVjq4AfwqLpDws5gRVABN3oZXOPsGA9tx1klPjt3fuGdthO9PRQyPj
         JjTfsoFHoQytvwYxGWTUr0xt6onfHdJavozJVa55xU2HxhD2l1EFovVSZPWgNY2l+5RK
         9Gufd6PR33/i4kY05o8oqmGhh/U8tmA2vLexbDBom+fOn1oWMvIx21lzAs/qSWeHAkFE
         wnJR2zAOHONpcwfAsHW0phzKMPE3AFd3q7gyS0HDPZIve7L1pZc7fRauGRsNg4il4DN0
         qB3Tf8KNgC6pzQpbMCiUeG8qDrJKrao7RX9AQ47CiuhyVkWYphxLO26DheX0FHpQCo8k
         f0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaXPdkw/Y9GdnRrZu+T/3Q1JexcjWMNdLrpPjZG0BhA=;
        b=GsKpJDez0Xijh0/odx1jwIYzXkhWkjv3DFXXnGpj6RMClcmTer0DjaYgwOkvj1jcEQ
         U7o1nEyzA5z8brsBn+hQRY1ZRDQRKpYZY6xoQdsRhZhEOOWBr/ypTb0KbwVq9WXMEhCZ
         pDzHjN/gkK8rmX4DFcBh6l1RS47D1jJ03tsidO0midlHqpDzMHO3NezdYlCiR5cnW0uI
         XRP2sISqwuuuDpsfYHTy0l8+IRIn4M6BVM2Lw2CunI9DSbyWpmqEftSBAKM09QTfycFg
         q2EM1kYL2UR/AN/d/cBWpA1vxAa0UZBIgtlrspWFCpJMWYnHBDYjazc0CE/JY0xWzr+m
         dX6A==
X-Gm-Message-State: AOAM532Ux0x0JtcqXpALR3WPha/GP6oCdQG4oMugrM7fNA53EOCP4OwD
        eNcN5BY8yOTE5LqiQx7V3N0iMdTGGrE=
X-Google-Smtp-Source: ABdhPJyoUGQQhyESyIlAvzDC1ZfD4wgWWHHcX2FtIYPuk2emCvOQAhNDUW3fyhSwACG6EDOJ10eYYQ==
X-Received: by 2002:a2e:955:: with SMTP id 82mr2107879ljj.274.1631192268253;
        Thu, 09 Sep 2021 05:57:48 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b12sm185350ljf.62.2021.09.09.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:57:47 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:57:46 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ntfs3: Change max hardlinks limit to 4000
Message-ID: <20210909125746.3io24xmh377ca4nh@kari-VirtualBox>
References: <89127d37-a38a-d15c-36f1-62f2ac0f4507@paragon-software.com>
 <20210909123034.mlsq57bsjvonwwd2@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909123034.mlsq57bsjvonwwd2@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:30:34PM +0300, Kari Argillander wrote:
> On Thu, Sep 09, 2021 at 01:58:04PM +0300, Konstantin Komarov wrote:
> > xfstest 041 works with 3003, so we need to

And it would be good to write generic/041. This way grepping is little
easier.

> > raise limit.
> 
> No need to linebreak.
> 
> > 
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > ---
> >  fs/ntfs3/ntfs.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
> > index 6bb3e595263b..0006481db7fa 100644
> > --- a/fs/ntfs3/ntfs.h
> > +++ b/fs/ntfs3/ntfs.h
> > @@ -21,7 +21,8 @@
> >  #define NTFS_NAME_LEN 255
> >  
> >  /* ntfs.sys used 500 maximum links on-disk struct allows up to 0xffff. */
> > -#define NTFS_LINK_MAX 0x400
> > +/* xfstest 041 creates 3003 hardlinks. */
> 
> It think comment is unnecessary here. If you think this is necassarry
> comment then please but it same comment block as last row.
> 
> > +#define NTFS_LINK_MAX 4000
> 
> What draw backs there is if this is 4000? We really do not care about
> xfstests if we have some reason to not do this. This info can be but
> to commit message.
> 
> >  //#define NTFS_LINK_MAX 0xffff
> 
> We can probably same time get rid of this.
> 
> >  
> >  /*
> > -- 
> > 2.28.0
> > 
> 
