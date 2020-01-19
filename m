Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB42141E81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 15:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgASOXE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 09:23:04 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASOXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:23:04 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTzKW-1j2Qbf2ytm-00R4oY; Sun, 19 Jan 2020 15:23:01 +0100
Received: by mail-qk1-f172.google.com with SMTP id c16so27620021qko.6;
        Sun, 19 Jan 2020 06:23:01 -0800 (PST)
X-Gm-Message-State: APjAAAVu11meHeLS1zFcWVTXiqa9Whtxu7P6WRmHbrSssopiDRzBpaSy
        qLq15J3dD33fSfSfAPtNmGCuqTHgl7B4KuLYJjA=
X-Google-Smtp-Source: APXvYqz30Qx9EHhKBQh1Sxzdt+3HC0Q+6z6YJyBsRHVZStEfnb4nGbz2NRbexESmLI0e+LQfzYqqgMCl9Oog/WkXi9M=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr48528100qkj.352.1579443780551;
 Sun, 19 Jan 2020 06:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-10-linkinjeon@gmail.com>
In-Reply-To: <20200118150348.9972-10-linkinjeon@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Jan 2020 15:22:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2_jnpuFou9EGhNvFFDmZX3H_eJDnbLGfC2Fcx+8QVTwA@mail.gmail.com>
Message-ID: <CAK8P3a2_jnpuFou9EGhNvFFDmZX3H_eJDnbLGfC2Fcx+8QVTwA@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] exfat: add misc operations
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QCmohTp/uw3IfTEro8fdsMN9E3yB8d7PDlOglXzxElG4gLK0vQA
 mh4GuML9sZn29UW3Km48ZHqFYs/2lgE62ogxI/XkmZWjNtlrBL6WROmVzcChnO3X4//lI2B
 JOop0YHtqjWMBshG0qYOgwVZRNXZKCxG2RadO6hZZHXVYlvv3FBBME+Rw39Vdt0RhVSu8x+
 va37NSwERrh5r6EgS7Org==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VkDYIeB1Lbg=:AF2zOMcCZN8Ih+K/qacIQn
 GicZzE0K4xBX2pKEgF6zWa+y0bF9rP723rbqsYHDfDzoVaWNfGE0gAZlXQnYee0mG3Yerr9/p
 mS9FeZut/OnL3W0lGGYEnXtwI0WaL1Q5reKmuiKIEaGpQmVHj3Uucv0uNRHIIHLOFu11SXRhZ
 gSzg2/NpGXfSJjy9Sei/RvkTGu+6p5zjb2h0N4hmcOsN+TOPYNzlnAnBQp7e3mrcW3N79wFWI
 Nl5KDzc6x+oFZDFb0JhPIWynIZiX/s9l8RMJQaHO4X6RIWQzZ7G3ojXv/DwVHO4FZinSYjudL
 7UUdtmY9NL6Oa16tXKiCVhBqnykwVPMGyXwh+iw88eHj8RKeCNPYbJrbOa94wzOq7axMxOWE6
 7PDI16U0SElQj5CIJZJjS7quprO28jaQfBYsLF0tWLcZe5cTOJppSPK12b+PpiEg0PSQNs5pf
 +qo4rsOxCnOKaZQztPaqZC0BVOaIiH9T8+WK0+m8CoFgwjx+9s2q3lpxHHbwhMOw27/5inmy4
 3N/fs/dGov8jvx7GiAY4dXs8DUKoKTgA03L94OMIITl5p675NdE0eKQUnj05c6cJAOgkR6SYT
 STy4d6SPPMo2QLeB0zKbUdyiEHk+Q9j8JVr7sXKYijg46ZC9m8uwHfKUuuH0VPcB/CYaKxK7i
 Xx3n6C/w/WEtmjobAmbmz9pRWYNfDReW6NxtCx6r+ExDRLsdfxHVKUzOJOp6WVL4ZFqhQeiXE
 y8nb0+ONq/Q8JwMKpZySGeqwXlWHdpST4QuKL96u6vFuGKRMJ2GVvRIink7QgGA399BTdtLst
 1XQUkAUmUWCozV1PEhHx2k/jcHZ5xxwR83OdBt7atnMSpKANArINo4k46kJvptYgy2B37ZOoq
 UAmvsyhsM3jjH7OaZIug==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 4:04 PM Namjae Jeon <linkinjeon@gmail.com> wrote:
>
> From: Namjae Jeon <namjae.jeon@samsung.com>
>
> This adds the implementation of misc operations for exfat.
>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
