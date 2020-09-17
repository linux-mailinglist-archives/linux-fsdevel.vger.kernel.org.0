Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C726DF64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgIQPQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:16:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgIQPLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:51 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:11:46 EDT
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MPosX-1k4oS230h1-00MvZo; Thu, 17 Sep 2020 17:06:09 +0200
Received: by mail-qk1-f176.google.com with SMTP id o16so2503067qkj.10;
        Thu, 17 Sep 2020 08:06:09 -0700 (PDT)
X-Gm-Message-State: AOAM530uPMI73zvlf6p4VX51VC/BBLDZoBNraF9NJ/JlDTmUnz6m6ALE
        oEGjREXJVWOi4OkqHEVTxCdOspb43VVHvatQv3g=
X-Google-Smtp-Source: ABdhPJzKte3sE0w3grmNzAcZz6I6dO+iCU7vaqRU7ZPNRSPiGZWy3ZkwDFx390y2hVXA2c946+2P8Nzpm+An38NI1VY=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr26786546qkk.3.1600355168294;
 Thu, 17 Sep 2020 08:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200917074159.2442167-1-hch@lst.de> <20200917074159.2442167-2-hch@lst.de>
In-Reply-To: <20200917074159.2442167-2-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Sep 2020 17:05:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+qdbGzWdi=PNL+goHDK9M=Y65p=UYTW=ze8PuN=KS_A@mail.gmail.com>
Message-ID: <CAK8P3a3+qdbGzWdi=PNL+goHDK9M=Y65p=UYTW=ze8PuN=KS_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Jan Kara <jack@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+kyRdoGXMGcCoFFC2gvTHjAv7SkQshfKd/Um6FcFTo8Qn+GeSAo
 oOAy5+6t8LQKXIpKs71bAw8AFw1iRKGHN4lAgIB/YCjlUvC3ry9a12LGmsIgZXijB88vNd7
 RbvBybC/W3/2cfui3Zl+iCXmnDwD8g/kcU2HZWGsBl+i//lF/oKRbrADyjo5NLZBqNue5jw
 ZOgV5f4oO1PvcgSPMJ+9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mOo9i8sIh1k=:PP27u5MgpCHKe0ejjq6zOJ
 0Nqw0ZPKfl0F+SPI/M5VW+dBb6I6ebHhsM9So4z/ZvX57wnLp9fKEbzjf/bWN7NGtqSSu/d1v
 MiigtWR0aB4zNJhFwMAuDsZhUamdRahHBIUUr/SzxrjZ/pv7YLo3r2c4ijxl713YWTSYK2gwH
 CeRC3k85gjAHlc39g4k5Bau4Ylbe6SQGEaKvB2hCQd2Dp5uaUbIb4n4X5vExa/0kUFNAS65Zn
 2fL3JCRQx0THOZb7A4rut2OIRRM41H4Bgzp9vS9HA8gxhiEFdIsM3+s9GTNA/b4T6b2W3MpKu
 Ajy5ODzpgZTStxLsyQfZ/1zYXhJXGzlmnrrDyLrS2faQV0Szgmy/+tBfH2C6CBP2ET/3zp2bs
 vffioUiYscYw7YFnULPfe4MBsGYvhtUK3vc9G00JF/4mlB+2KhqAwscm5kO0CmLxrjoTD/B49
 ZEwnZVKLuBGzrc0QOh3aMV5+SZKkTvaj5/m0Ihi3RkM2BjoExyQIQ8PVq27Qrj2/JjbxC/DUM
 sUDAEUhjqi1lOwNufa9xxwPvIqM44lr+OZnKSpn4sPeJocQP2QXK42eLUrVYokDnFhnudU89y
 oR5MCqhOY65ICgLGcyXanPy5aYJY63hS/dg2Z50RYPOBqaFPbRnBOZOiSo/GSiSr60lsv825x
 DULdu07eJN5Q+TTCJoHzZPpL8jD6ppRc4+hVWcKz5IGgO7ONJ1OCEd6y7smPFQbGB9AcE5ztd
 D4HRTod+4j2tX5Hye9EhyBraDmWBuSfTkSQOReX00jcdI8duhECo9wjqOoC1OG0cv22wWYgLt
 QmdDXADF0ZhDq+Nm/lOlZcd9RndVAEi17pS3PINIiI0gBwSgZp+GAn6KNSGo+ZppPNGh0toit
 hjTcIs2lUofrt2UkoCjW5MkzRrwxfyx0vt9xK7yGgrlIFDxQnoOSSI3cEfvaaDZz11UkJLQwy
 Y4KwUiTZB2KpxG2+/XajqtTBBjwT/ChWQjbMreSKNuWKeb508+WUL
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 9:46 AM Christoph Hellwig <hch@lst.de> wrote:
>
> lift the compat_s64 and compat_u64 definitions into common code using the
> COMPAT_FOR_U64_ALIGNMENT symbol for the x86 special case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/compat.h   | 2 --
>  arch/mips/include/asm/compat.h    | 2 --
>  arch/parisc/include/asm/compat.h  | 2 --
>  arch/powerpc/include/asm/compat.h | 2 --
>  arch/s390/include/asm/compat.h    | 2 --
>  arch/sparc/include/asm/compat.h   | 3 +--
>  arch/x86/include/asm/compat.h     | 2 --
>  include/asm-generic/compat.h      | 8 ++++++++
>  8 files changed, 9 insertions(+), 14 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
