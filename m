Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D44141E87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 15:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgASOY6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 09:24:58 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASOY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:24:58 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mlvmv-1jKVdT32JP-00j5hM; Sun, 19 Jan 2020 15:24:56 +0100
Received: by mail-qt1-f178.google.com with SMTP id e25so14335062qtr.13;
        Sun, 19 Jan 2020 06:24:56 -0800 (PST)
X-Gm-Message-State: APjAAAWXQxVXgBbdTogQkNgx/9pYq9a9Go2hC+sOa9VKOAo40ElHSwFs
        GkEt/Ml8Nz6RG31pXLBij7bbmwXUyTJWhQJpMaM=
X-Google-Smtp-Source: APXvYqxrafmnxNuzCwK3/36buZK4R4f8MDQ4Tt6/l87rNbHptsH4UaocIHxOaaZ4qwJSuQSOfdxLmevczkRbYXLFrrM=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr16102286qte.204.1579443895598;
 Sun, 19 Jan 2020 06:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-3-linkinjeon@gmail.com>
In-Reply-To: <20200118150348.9972-3-linkinjeon@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Jan 2020 15:24:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a15cMvfNe248CCePJ=zq1n7Ssdao5O2SVP2Aj+EBwSqnQ@mail.gmail.com>
Message-ID: <CAK8P3a15cMvfNe248CCePJ=zq1n7Ssdao5O2SVP2Aj+EBwSqnQ@mail.gmail.com>
Subject: Re: [PATCH v11 02/14] exfat: add super block operations
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
X-Provags-ID: V03:K1:gfLNI3SdZ3NTejtkozKCmnWyuRcKkx7Dy1qXTeypL8mJNrMeKPW
 ZMokDGhmVdef7SfQaGAdnehun8zqA1IF99R/tDms5U9UP45hfOFVwAkLfu8TmpaQLKA7NHB
 zuRlzdm9ZMjhGJYpAsIKxocNzdYzQanzqP3L2Rm0e3NP80Y7axlTk4EMLcyzqg2Zt0vvQnH
 PMS9gL15rs65+oFZmXU8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rkAf1KRpzrI=:EUYADzAl3ivqSflyYS8j5S
 xqO85sAMrEzH3PNTXLCcIOMvTzqoQ0//IBQBj86H1D1FcQDXJAwVaM3n8ruMWtfP/NJAaRhhA
 QoPpfLqvskapq1+6Q3gRoF/wIVafYpOKO12FoBozKyaVSCNd/YMk44QA18Ij32P6CHkkLEg3e
 jmZv9sLT8dyzvCEVLDLcm2TeZ6J9DD8AEXvq0zgvcPQF0UhNbBwnPG3ko8w4YipsSf5SGrFq+
 WBKrzu7dGskeNzuvJaI3pR2fKBB5XU4w6b8uc2T/9ZwguSZHer8yJ0v2zC36bxqTD3gtVcsSR
 YoKvnR6MufwkTh8pkiWg5qGmt6VwSyAMJzdUqb634OIvq5PgqvJvnUE6lhJOMPwfE/uaKvAOo
 NM+espKfYl7gp5D7qS+vaggBrYbH86j2WyrDfwSEjdSmlxiZLsKEcDTudzSW5xKIB73kCDpQ8
 4znHnuMa6eVqndKxppLlSex2RD3Agyn2X+evy0+CxIz0ToEscf5yL76mENBfgbKZuYBXJQBjb
 dDq6feB/f0GY7QF+dLu9mEMFk/9jyxZmKoHp9fSnjNO8S4hCQDrCefQrK4lzsu903lGWdRksm
 ioq+zkjmwvnjS8ywX6VeE8OgFz4jsFCa1EZL1CE3QqwsB1+lniraUNoMbnIIZ/n5GdNFi1sNE
 kG3rGp2WLzrsju6BdYjzFHbAweHLjuE2qrvypGc/Hmqv1f9n9KNBnFdIGaIEDPuibOAwQ2cEJ
 TNITNeP8vQXQ+Q8GA0ZaZvb3Xe9HeqituquEsAy2gNzeJLNeILV5jZOsK1iiA1ozbD6XFt83H
 OGGE7MohvDWBwPCZOzJFc6OU1+hQ6qvXgB1prtKAMBYsmoNjLS1bTw0OjZqfMjtyUNJEYX46h
 V79d1TCQDMRwDhBF4rGg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 4:04 PM Namjae Jeon <linkinjeon@gmail.com> wrote:
>
> From: Namjae Jeon <namjae.jeon@samsung.com>
>
> This adds the implementation of superblock operations for exfat.
>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
