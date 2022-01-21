Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84849679E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 22:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiAUVyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 16:54:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:33209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbiAUVyy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642802072;
        bh=o3HriOZZYTQr0RY2qA5gv/JQ+l5Hfs4zA46TyN1O4JI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Cyt9ijGHiAcuBFq7i1sKEXAXVc05o8facJ2ZWY2ycjTwBuWwBd8KWBtWAV9qF7CWI
         phD6JbCEeO37xJJHvEji6CPBEK7HSPv5GxM8EkFsnQZ0YqNcDlywsUpcmp2/K+ot95
         nV9nqAtZeaOI9JqFWeE0PWbK4aAolPN5eBHLZJEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.180.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1mz9u70RiN-00Bpnn; Fri, 21
 Jan 2022 22:54:32 +0100
Message-ID: <d150a5df-157c-a435-5696-93a1c1ed6406@gmx.de>
Date:   Fri, 21 Jan 2022 22:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [next] parisc: allnoconfig: ERROR: modpost: Section mismatches
 detected. Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        John David Anglin <dave.anglin@bell.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, pavel@ucw.cz,
        rppt@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Deller <deller@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <CA+G9fYvuEqeoLO6dC_qtGyRUz=UPv5i0C3jZ_n9nz5kWOuCHYQ@mail.gmail.com>
 <CA+G9fYuKGaDfyke81wbSe2yqTm6GqWNuKw2wB6NFaCLa1q7z6A@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CA+G9fYuKGaDfyke81wbSe2yqTm6GqWNuKw2wB6NFaCLa1q7z6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X5d0rsZTnoWGQfPByshx5re1SKOdQJRDvYRKNsEOWYjGMPMVEGH
 q5eWkJQbCg6jX3cHpq1ylLgtXak6CRPRqlJ2EJykNVJi0VDI2a6N72VHCarEe0CBNJbOwLz
 s5TuyUCEVRgtH3lWcOpsYQc0/eQs59D1ikjyhlWnpOCik3YSN5mCxv7K2xuNlD6Haf5gBO+
 GK/ElISvRuUEdtxugGR4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lUI10Suj44Q=:7jAVRQBTyxJN3t/c1FvNpj
 xyO02MpC52wNdI8H40C+fVWQTH1l2FHsTiMsZkRoKyWyNzzJ+s6Dj0aeOyFSsCwmRb9hlf+PT
 4lQ9Vuaf2PsCPT8D8SBilye1vj4RdpZBTeytUNrNqKfH2gSbM2zVTB1087ETLMGNSU4Rk3WUf
 HHVpvHx5fY7pPbHyPus9o91xhNE0Hp5T+W+hHlAGlWb1uRGqEkvO+TUzeHAKUgENYIxUKcNOS
 6t+FW/dC8i1NSRiD9TYwxG9ZndLJuC4CLc+f6bsuxbMygTEb8BuLaeouDiuTpNSG5v0OqH2V8
 4ppseO6bzfrrX5LQG2U4UGlVJ/cSuuGuGE0owG8SlG4Azb2Vu13z0IvGGMvbF9By3IrlmX7Im
 IgXyii62Xcf6MozWBWLbNqbnJRqeXPsFS7a56OWvTNp1bC+mD08zGSXSbUc2tGPKZ1+yx52yZ
 wceFnVk4xddpyV4HaS0KcCcQpcjpU4ZYqBmQ0DkjaE8EIgeUU6JsxjG6si6cma0f5rjoEf0DZ
 RH7JkqZkelPXp/VAy/2E7MGXoJDI6ztW3zXzE8aPuejh5X+ZrTqV5ldU2/TSu/1a/cSokdq74
 98w8Xb67lqq6pDrxo8EP9zpnivxtYmGJ9CHXppyOdzNdhWkAzIJb9yYMPPaavPdQdaZjMxPyi
 yL4qBu3eQoRjwTL62xL2rZUopjeWjZ5YAARXjfIZJxiMyVr7TJDH60Pcn5y0MZiLzJbGME+eC
 6MrFhWJvVEywQ9p4a6fOjCH9mfqdUmQlwb2w5/FX34occdFeeQBuwhUS3LJXfW093D6z3iDDt
 EtC2qTwqpBZC15wHkKrAcwml5yxNULewPG+iaR/NsyMHWneq0QyC0+iBSorvbkp7dX9T1CE59
 P/TZ3HxSQyZX4lC8gkVV1+1vlczdqTam8JXmvR6vT1XHNzSwPVYIMAn0LuGuB3gaY9VEZS8oK
 Vrn0+8IuVSHHTakkWw1diHvCEoHkJAIgfu/h8TG8yJzyuYXVFZlo8prcLsIAn8+ZGzmuAykHj
 IryZFf9Al6dG5HZ9YON+vbuwDucZYkHilCEwjBzh3EzSTXikOerdHoVNQpDSgt/+wS9xyeSOV
 dInWiD26xKZr1k=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/22 16:24, Naresh Kamboju wrote:
> On Fri, 21 Jan 2022 at 13:16, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>>
>> Linux next-20220121 parisc allnoconfig build failed with gcc-9/10/11.
>>
>> make --silent --keep-going --jobs=3D8 ARCH=3Dparisc
>> CROSS_COMPILE=3Dhppa-linux-gnu- 'CC=3Dsccache hppa-linux-gnu-gcc'
>> 'HOSTCC=3Dsccache gcc'
>>
>> WARNING: modpost: vmlinux.o(.text+0x1c8): Section mismatch in
>> reference from the function ksys_sync() to the function
>> .init.text:memblock_alloc_try_nid()
>> The function ksys_sync() references
>> the function __init memblock_alloc_try_nid().
>> This is often because ksys_sync lacks a __init
>> annotation or the annotation of memblock_alloc_try_nid is wrong.
>>
>> ERROR: modpost: Section mismatches detected.
>> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy to allow them.
>> make[2]: *** [/builds/linux/scripts/Makefile.modpost:59:
>> vmlinux.symvers] Error 1
>
> Anders bisected this build and the first bad commit is point to,
>
> first bad commit: [4f05e5a3946923676e147ad0e33c80df8249b2fe]
> parisc: Drop __init from map_pages declaration

I've dropped that patch for now. Will need some time to find
the best solution.

Helge
