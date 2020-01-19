Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10644141E85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgASOXz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 09:23:55 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASOXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:23:55 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MFsIZ-1iqhAk1SWN-00HPIf; Sun, 19 Jan 2020 15:23:53 +0100
Received: by mail-qt1-f179.google.com with SMTP id 5so25692014qtz.1;
        Sun, 19 Jan 2020 06:23:53 -0800 (PST)
X-Gm-Message-State: APjAAAW/QXalHU26BeBpslgf6nZkKqY6ZJt+Z+t6I4GtAKvpegukk1Wo
        6n16geobE9dROMdvg3s7gLSRxdCrfsCMliRF/jg=
X-Google-Smtp-Source: APXvYqzHCuGsp3rFT7YsZg9amyGvdjC3ojAJqlu4KS7WRv2xnidRsPe6DfCnS+7HdbXEpHmL6wgForilWoRhIJOklBc=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr16000972qtr.142.1579443832175;
 Sun, 19 Jan 2020 06:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-6-linkinjeon@gmail.com>
In-Reply-To: <20200118150348.9972-6-linkinjeon@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Jan 2020 15:23:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0eJKDYsrkHFxf=8fWpq26B1fXGgtth+ViLMXezx0SNUw@mail.gmail.com>
Message-ID: <CAK8P3a0eJKDYsrkHFxf=8fWpq26B1fXGgtth+ViLMXezx0SNUw@mail.gmail.com>
Subject: Re: [PATCH v11 05/14] exfat: add file operations
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
X-Provags-ID: V03:K1:7wIDx2QmCezR6cAwvFMz2RvCzSut+0wI04wygMt6U4HC/g8jMiJ
 dNRAV0w6SIvVpYRs6i1ice+ACqbOgATwGuKyAPr3ynIL069rnhRsJGFcuymTG7R5McvCHla
 f1zLX8PW2RIBCVKF/CLwV0+yVYzKLXCe1NuCn1srENT+WBS283PZF2qDjECW4O6TAnoOBOp
 /Hx7vhjaedcW2RRd4fU1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ccO8KNwsag=:FvKzj/ERinJeHBV3t0/l0r
 PvfPeNSBypuAimotYLB6OryZ1y5SGjxcp4MwRMNY4KHhnEIyBpSgmAWHFl5NtRFFe9Qcx4q5F
 o41+imxcBPlVneOIVXrcXWQZ9/zKiSD4RGq2WZqxw8IKWXmpkxWW8Z47/u9/0FLDbVQvMzqLB
 5Tq+7xHG7lQSFOwWD2uevhCP8ralB9f3eNZadzZ7ho8A/6P4Ft2OjkabnNjI/NekTZvrhO+35
 JXe+F5Ezv2kwuq7w9KsUoS23M8j1ngnXJNxhS3P/zB2D/Vr/hjNv50+J16UWU6+akO30/tBw+
 KVgtquS/vy2gnnnGklOjAwFzYOccKenlh49Kw+RBtaW0xTvHY+eBoz0WHb8X3wIyoZgQw/vng
 woSdOnqvKBl0M2cp1k14gTKoGeExT2hrQquS5zpbxdTtBfW6nyZGQhfgBhLVpyGDxLq4WvjsS
 SedZbgEb5u5VvvZ1b70PW9ehe9Bh4endLanMMJos0k0P+hM5XdgIIZbT+YbxHUnr1WPKJneda
 +oXfQjYN8Qy18/2XpBlGEskrpFidJZKX1tV2jx6+3jdGyXc/hIqtWH9e8OmYai5QP6xSVepCz
 hoJND0zkuW1NiL4+sn2BrUtqxNP325egNR/OfMrhjEiDPHKl8187O0hJTHAdXH22s1b0bSEa+
 aVaTTOiFLFyHJhlLvlUZf2Jbed/ig5dIPTugJ87GrRAPVNHGbcjeXCWitcTfTYH7iQtiXmHXK
 snAamy5fupL/X7Z0yIXcrBMtC6Flj81oH5NP9Kgml7480ownt7D38iO5l+PAqUfqlAXIZJd6A
 6QOvDxTS+OoCiK6CuYB/3S5e8uK/JG5q14N25L61LlHMzavmru6pheISaA4FVVthvsWGEx7/y
 +TgtEr14JD/hM7ArB1OA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 4:04 PM Namjae Jeon <linkinjeon@gmail.com> wrote:
>
> From: Namjae Jeon <namjae.jeon@samsung.com>
>
> This adds the implementation of file operations for exfat.
>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
