Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDE68123
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfGNURk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 16:17:40 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com ([77.238.179.148]:34378
        "EHLO sonic304-23.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbfGNURk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 16:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563135457; bh=56HhVaYrGJR6MKwMAHA5oXMmLrE4kBnjCe5YrgJnE0Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sxa1IwEU7eor3oDsNszfggOWP57K1Y0xmPk5qfjzHi2J4X6TpELj0cq88IIMlZeVVUHCnf3BuAynuKNX8OOBxmUu0e3myq7TnZG5w27KlpsxTqexu/fjrq4xfJI1Nvnzh8FQwaqpA2SGC02bR0KYlsu3s3QxVeY5OI/9A4o5lwN0YKxNlMziV/iDc1Om/+gsocNVcmdfInXhYce89EPd9DI8hy/ZJ9OSuSR61VJADAzb0Qwgix/N2Pxggl5aJ/KIhYZm/aRBDrFR4PXPT24eOjDuFwf/tdepbG4fg0+8k2xILzlsK5js6PxAKI8chFfus3Eq9sn38w4hVVY+EGpOig==
X-YMail-OSG: 5f5JlG0VM1nEWdED4kc1O5vDYV1TBMbik3rr6xHjhcOE0YrkOxozeOqftS2pMA8
 uw1GF3zBCAy3dSmGgFvmalRWSNS5ifsJZK0ahvVX1e2li8eSn.7_wP_iChD0o79Sc9BOw1jvBiBo
 3wrA4r70efi_UHxnQZEve68AyHtK349bIU875z9q.ssyngPfhfQNL7poB8814er2SE2dx793dddW
 X5xSFSYDX72RUdAE5Iqz_bGbUUQOVgsbGugtpAMJIo0Fwy1vvX3sYPm3nc4M68.q.AV_IPIg9lil
 QSSdvCmoZpMydj8N6VYq6Mfewly5EtIfNmMRBNW5AYzKtRED2s0lIruwoMoJQ1yo70ZrexRjJLwr
 qEBiwPMwgVSxLte9u8INfUcaPyhBbCqNPGmpb9bQ52KSpXrYoEEGAJXbUxWvfK4A0rC48Kotvwv5
 F8ci6VsS0qkJHLPsH9D1zK.LAQA63epbHgOzSAMa.ZmsI7Za.YYss_swumkilNXlvMyEh7pevYtW
 eljhaJTLyIQhMBhU3sdSPe7KgYWx4o6JJKmG0wlS5Cj6RO6Hbz61oGi0VqJB2V1SYjjtsLQgooDV
 RkGqrMpC9LD4jg7dt.KJqHw.r153K8GhRhbyC1ofu_wUqO4_mQvB8aCraTQoz7dVed4jqXel60N7
 gY3fW_Lakfd4rPYvBoZHLN_8IAV6M9AnrpAa0Ay1vYZ7C37lGxhUmWsHhdtNd.0tk9pXWKf5aaQu
 5iACGLixi0Gd7zmgQnKmkMpHvkSyfyQFWbME9wKy0jJoQJMhbM1xafy9bmLUL8f.ZxXRNxHTS1Nf
 _Evb4foUrDqJKca.Xccl9DX5vUKayfvhGfAxiMq.efxZGjw3XjGGgm8tHTKdsU_yIswx6M.ksTM3
 UilyGVCJnnqd1oFZmSitLxLckDaSZ.iwcEXICBTTI_S5fsfcwpWQSxVJlVGaJ2OPVlJvoXQ97oIX
 CM3fMzYb3q0iUSEzALZp33xpajR.gvJMEJhI99qLXcMClCRxtTjShcKiVSrgSdWOD_oDcNNb.G7n
 3IAovnPSWyOmtHeuGZ_28GXZhoRfmTrORKCT3Z89hJbGKcTc7sK0T2pVaDQiFFgjc66ssP1LrpoK
 2nQPbQo3h0LAvxdtMhMYRahH8dU9_6Odjjlhf8KjhYqOJEn5ifOdINwY.VndlIApGFPNsQcBb72h
 vJ_f62vLvQ5tqOgG_JUBI9hMqlfBUcWKWGHOecLuIpwP9JUwPsLqMC4SWd4s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 Jul 2019 20:17:37 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a912500c5590c551bd3365812827a21d;
          Sun, 14 Jul 2019 20:17:34 +0000 (UTC)
Subject: Re: [PATCH v2 00/24] erofs: promote erofs from staging
To:     Pavel Machek <pavel@ucw.cz>, Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190714104940.GA1282@xo-6d-61-c0.localdomain>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <63b9eaca-5d4b-0fe2-c861-7531977a5b48@aol.com>
Date:   Mon, 15 Jul 2019 04:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714104940.GA1282@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

On 2019/7/14 18:49, Pavel Machek Wrote:
> On Thu 2019-07-11 22:57:31, Gao Xiang wrote:
>> Changelog from v1:
>>  o resend the whole filesystem into a patchset suggested by Greg;
>>  o code is more cleaner, especially for decompression frontend.
>>
>> --8<----------
>>
>> Hi,
>>
>> EROFS file system has been in Linux-staging for about a year.
>> It has been proved to be stable enough to move out of staging
>> by 10+ millions of HUAWEI Android mobile phones on the market
>> from EMUI 9.0.1, and it was promoted as one of the key features
>> of EMUI 9.1 [1], including P30(pro).
> 
> Ok, maybe it is ready to be moved to kernel proper, but as git can
> do moves, would it be better to do it as one commit?
> 
> Separate patches are still better for review, I guess.

Thanks for you reply. Either form is OK for me... The first step could
be that I hope someone could kindly take some time to look into these
patches... :)

The patch v2 is slightly different for the current code in the staging
tree since I did some code cleanup these days (mainly renaming / moving,
including rename unzip_vle.{c,h} to zdata.{c,h} and some confusing
structure names and clean up internal.h...). No functional chance and I
can submit cleanup patches to staging as well if doing moves by git...

Thanks,
Gao Xiang

> 							Pavel
> 
