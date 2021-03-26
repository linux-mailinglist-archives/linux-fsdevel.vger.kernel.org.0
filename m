Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF934AAEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCZPFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 11:05:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCZPFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:05:16 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My2pz-1lZkxy2eUB-00zWk0; Fri, 26 Mar 2021 16:05:13 +0100
Received: by mail-oi1-f169.google.com with SMTP id x207so6005180oif.1;
        Fri, 26 Mar 2021 08:05:04 -0700 (PDT)
X-Gm-Message-State: AOAM530fdy5QxpS755pIewQBaHtI2VLwXrNSuiJV32dzfLjZhSsfnPjc
        ABfQWCitlfG4AQ1jK8cW4qzoWpJA0lR63Tw0cOw=
X-Google-Smtp-Source: ABdhPJxkabhICNjVimKONzi11M/Se4ShvOLHDXtHqNvGZV2LWEfIbqRfkSQLV++Q5maH4NbCwdiaxdlkbDHuJr8w0IQ=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr9838151oie.67.1616771103242;
 Fri, 26 Mar 2021 08:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210326143831.1550030-1-hch@lst.de> <20210326143831.1550030-2-hch@lst.de>
In-Reply-To: <20210326143831.1550030-2-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Mar 2021 16:04:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zGcjPXPhKiUVZOwocYFKNfSGSx-M_ZY1hytp1+xEt0g@mail.gmail.com>
Message-ID: <CAK8P3a1zGcjPXPhKiUVZOwocYFKNfSGSx-M_ZY1hytp1+xEt0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: remove do_execve
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:URfZZHCCTamxrijNQjzHTl6gyNX03jfzwQHNzUvoL0Mjn5PBBLR
 TP1awvfrzdl3sB9hOE35X5M/KpxDifuLJfWn0We9WOTvyA7g6uDgoXxyWKlCDYEOdUneuy5
 ukJPdfmR+G98Lg1xaBJ2SXr+k0VnrFT240QdmNqFuwQajkam3OmpTQvnE6lLF+b6s3w71/l
 5fkSgf5WqPpVeDF/3qT5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hvukc4TgRqE=:LogwYpTTwOgmDhsEqrJsWD
 Hzfle7UMVUuhobrYoPLu+Mc+JRmO5PRBgW2pz5rUcmgTLHH/krpkqQE7AHZi7bbsBcnRpH5uv
 3D7cKW0sJ6/9lz8mTFxl1fC35LqQAKRCTV6RE0uEgDaqmt6GvBcb+Q5PI9iK5aLMNeskTMNKB
 oc7IEeJF93lpb8uRU9wnGfym+EvG0xXsWVYsc705xOQjGjjG4Y48U5DeOuGrl0B6l/FZKGTBM
 57a4tZjYP4rvHgCQmayLJyF+xfrRVzQtQ3oXZB9Quv8qDZydn/VSeH4/m//03XeY2G6qdBE6p
 Xs6G/Vt+vZZ3+fCoer9TMHHJoXyeauZGW/WU/+nwB7gRW5qjSRPpHv3KAkDGTmlMEB1MTrnZv
 XMqAZlWLtT7XMzV4b2G0GqUF4KHks1P2NPA0sNsjOsLCZUfM/00UY3XjKAOXDAlwXb2hZqnoo
 TFlZFMKQfMBrj15m4Ll+QnDOMhK3st/+Bndty73Lt1BolCcJpggyGy3bD0mfMoI0UUa3vlSsZ
 qqsIT9cQsdz5YMMM+6ayVAJvPVtMBQy18InQemOjCGf8X3t8qq/EW003peCFm8SuLfjZH1Xk0
 LEKvQHe1EGeAJb2iXAxwU+3lLb+Jb1w4TN
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Just call do_execveat instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
