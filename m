Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE94885B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 20:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiAHTxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 14:53:05 -0500
Received: from mout.web.de ([217.72.192.78]:46135 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbiAHTxE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641671581;
        bh=1WVD8sonhTLURoKUip2kjYjg4FF2hd+FCM0q+/QbYDM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=HI+LsoJjrpJarY5PC2jnWthra6+hzz1n/twlgNAR+jRHaKvlsvEf7D22sld9bYOse
         xeC+jRGo34sbkwQR0+iUnuG07XBH8rc8EZ5HLembkdVjteEhxro9OsYumFVQB+Kukc
         og9z8r9D9ccYTK9+Xu9JSo7v/Ge9eL99Ldjj07cw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.151.24]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKbj-1mF0Si1UDh-00r490; Sat, 08
 Jan 2022 20:53:01 +0100
Date:   Sat, 8 Jan 2022 19:52:59 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
Subject: Re: [dm-devel] Proper way to test RAID456?
Message-ID: <20220108195259.33e9bdf0@gecko>
In-Reply-To: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AGazrWY5rmVs3KLflW/ztv0A9Mbn86f0R+FugVm+ZYTHp7FWmhP
 UvJZ7Mc6s9oUNuBwc+domY47DVsmzp1hcddFyhihrJZm94jzAM/cdMUybsVRXFVs1ix97Gr
 yUM0jx4iKxPulgBfO3FqcjTf+8YUYTlwb+qhzXu6GDGY4VsOiMiFlnsMswKbB4rsGTkCp3i
 U3YHoiSxmX6OtjPgyUEKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ef3i2KUnSBY=:4g/W591zD1UlL8Yb2WX+B8
 r1UoDoaKzksXCE4os1w3nACPuh/ySwzvZGc413W+WlWuW2T/NfQruF4er6nRFvayFLnKt2eOL
 qOmeHqQdoaJ0sfRWyhmsv2GT9ggBKpW4K6qlhaJ3ygAxSOGQs0UeSU+yDuS1MrJCclUAkDo4B
 rrnPk2g/7656zG+1Qm40Vqk7f657JeIcG/HNLtHSLz7I1102SltZHV+tUGj+l4BwRFX1sWvl9
 RbnFGBXr/44y3bLF7rN4FH1IlPFja6M4nKK2nXy6znDC+d9V/iXd8tjyR9JIZBuDks3H0coWX
 5kugKKRpwzONWZaqD//w01j7qrD/CRoC08845Y+lJZ6CtB/enhSnWY30ReDzQXJVAvsTY+Agg
 nz2LhQ4aEq98sXKFpqZIV5YnKVdrfwTo+yGBRT43GGcjhqrtbj4DwF9K4FPxQ4W82CUUya+lk
 AUn3V1imD1vSz8DzhLhsEAES3RF3vRAsvUg/0nlmKGJ4VashcP3TdmarvRAfd+2SMB81r5ni+
 tVHW1TmYdzq4IvdWnUAko06M8a7fLZqYdKgTItuti8YBiE5XjeHN+CZjXDAUIdHqAhilU0pTM
 dvAXUsgEs2mddPocJuVGy39SD/kxiLp2XWPW2TaUuXhBoMuWSLctr6mYYNl/b7Bxvy+ExJQq9
 cowacETdAxgBsXiRiyUWV6Ui8OrYG6gK7cuFWEQrPr+V8/ZQgMB3TCErUoDfjLi7uz3jT1oF7
 lbvObD046YkIHxZg8b7qNOcLTJaZ5o+aJ4bhG7CrXMISbqBIhGu++jd79q1FFeswdF41qC1Yg
 ppSNtBX98EFoX2I5ox7zGvaoqo0HWVeaPpuL8XKaVNv0XfRyg8OOu4WdBF7C77FPDKjNU34Za
 Ze4ePujn1Mo0uMdJNM3gOqBr1APf4u8wUp68Jr8xogp/7st9gpHbf3bUETu/xkOsauZXSDLIP
 tdT512V6gxLGtQaunF2jDLB2h1btyWjTKm+00aD2kH3pX9olpgIfvulpoRJKz6gJk+XN30iRq
 AF49TnIRQfiaQsN51E0+pDGwJVQXmWg1gqjFs0QQfg3E3N9Wj4enPK4qBPKKm6Ql436D5KW1w
 UlmJoRr99Y61bc=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC'ing linux-raid mailing list, where md raid development happens.
dm-raid is just a different interface to md raid.

On Fri, 7 Jan 2022 10:30:56 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> Hi,
>
> Recently I'm working on refactor btrfs raid56 (with long term objective
> to add proper journal to solve write-hole), and the coverage of current
> fstests for btrfs RAID56 is not that ideal.
>
> Is there any project testing dm/md RAID456 for things like
> re-silvering/write-hole problems?
>
> And how you dm guys do the tests for stacked RAID456?
>
> I really hope to learn some tricks from the existing, tried-and-true
> RAID456 implementations, and hopefully to solve the known write-hole
> bugs in btrfs.
>
> Thanks,
> Qu
>
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
>



=2D-

