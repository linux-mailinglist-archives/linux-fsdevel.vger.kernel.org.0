Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1011C5A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgEEPAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:00:34 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgEEPAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:00:31 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6H7o-1jTl4Q0ZdQ-006cvC; Tue, 05 May 2020 17:00:30 +0200
Received: by mail-qv1-f43.google.com with SMTP id p13so1109209qvt.12;
        Tue, 05 May 2020 08:00:29 -0700 (PDT)
X-Gm-Message-State: AGi0PuZmBpVYAiEFjxHnkMj44pEum+WuhQRrU2a7ujZa/Yq3jfSU5GQx
        3OA5ZUWaGF8Bg8GHBmE253KaY34iezgcjlVUnWU=
X-Google-Smtp-Source: APiQypKrddD0XLM23ERKqp8jN3+C82vh7NIDRBG0Uf01KOrVl399PbZ2DcqmCHoRuZCUuRyJT5cdYW0eG7pmsStXQPk=
X-Received: by 2002:a0c:e781:: with SMTP id x1mr3317423qvn.4.1588690828960;
 Tue, 05 May 2020 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200505143028.1290686-1-arnd@arndb.de> <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
In-Reply-To: <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:00:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
Message-ID: <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rxM3GBXNbjQCzWEHPzyHTPa7qUdjCipkeA/r6+eAINZgG1WPD/j
 LYmMxQV7mBG3+0cXIAYsOZgIRjxVNaBydlVjKiCd6bH91u9kN1lCzlPAitJy3aAGek/a+GR
 FyY1X3GZ6hmlLpBFCgwH/zaTtO4D3Vx4/Tk7ThJ9rsfXh2oBg2YCdJuHP85TzmLHl0KucaQ
 jISdWaYRwtnpuIqS2gDcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5mt9Fx4RWYw=:9fCUuVrwzdfJlVlyuFtWcn
 1CPajEk6NCZx936DBzJvYz7hnImlDfykx6qoA4ZlvvN9oJF3HRFs68WQ8lC0WhJbl7XIEqwDo
 mrlfZgdgM56ZNF3JoYkVryfdc+VVYi3PZs3ZisMzx+e4HjOpQfV/V3YA9Tf3swKKhpo4fzzmV
 XKtzwIH+XoVyM/Iig3bcS5w2V2Ppl2PX05K9BfTaDvhnxQhUmYaGHjQsAV0jbPABqjCmg4DrX
 ZovnnD+hKl+w69j/RgFWRme0yxiHgEkiscaaPxBYaXFQNYIIrjn6YcVQDdsHPfazqh0SltOkJ
 sge/PhaHU7sh4sW+81+4TWDN5mTZwnBv0kasxxvsKcIdYDJ93eQEVQCpuweKqW2OfnpYvDrqQ
 OzdgdbFS48epsofYftSPyqERaOrRH8+2mDc8nHXUfAp4/5Ii4AlQPT/Afcb6Tf/ju1O9vOg7O
 VSo0c7fjuq1XBQhnYhqGIgCiVjcD9cokSVgyH1Cq2V9/3UAfdqaaicWolocH9GBfGDi5X4i3F
 Omf+wpbZ1eQdgcVa2HOmJr8Vk5v7lDBe/DhNGClZbtfSfD03h4AY5zCxy9qd9gsBO8iAIhI6+
 VIdCRPeeQ5ZStIS2q86S9qvlX1gc5O+L76wIxNdM8QuZc4ZUHqIRal4acBO1VWN1CSjOcCIyp
 ypzWzNAakklCar1zG3nll8K2oZJ1rk7x6S8A4XnRXmqbKBII1KDGBU7jdBzFSPPtuudtGB/vE
 msRaKD+ItnUa+cqdZwkKoiWyA5pnomIHBMAzkzWuiBNhNSWAQgrBx/7SIR72Vp5t9xEJ/dJdt
 b87hLa1M4Ui0nTz4Ua8ktzLSqxIQZKTZJIquBHmgPisW6Y59Z4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 4:35 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 5/5/20 09:30, Arnd Bergmann wrote:
> > gcc-10 warns about accesses into the f_handle[] zero-length array.
> >
> > fs/notify/fdinfo.c: In function 'show_mark_fhandle':
> > fs/notify/fdinfo.c:66:47: error: array subscript 'i' is outside the bounds of an interior zero-length array 'unsigned char[0]' [-Werror=zero-length-bounds]
> >    66 |   seq_printf(m, "%02x", (int)f.handle.f_handle[i]);
> >       |                              ~~~~~~~~~~~~~~~~~^~~
> > In file included from fs/notify/fdinfo.c:3:
> > include/linux/fs.h:988:16: note: while referencing 'f_handle'
> >   988 |  unsigned char f_handle[0];
> >       |                ^~~~~~~~
> >
> > This is solved by using a flexible array instead.
> >
> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Gustavo has done the same thing as part of a treewide change, but keeping
> > this separate lets us backport it to stable kernels more easily later.
>
> Arnd,
>
> I wonder why would we need to backport these changes to -stable... merely
> because of the use of a new version of GCC?

Yes, we usually backport trivial warning fixes to stable kernels to allow
building those with any modern compiler version.

       Arnd
