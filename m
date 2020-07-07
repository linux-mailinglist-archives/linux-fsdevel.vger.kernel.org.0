Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F649216753
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgGGHYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 03:24:14 -0400
Received: from mout.web.de ([212.227.17.11]:59717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGHYM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594106633;
        bh=RCybKhZpqcLTwXjVI1FtcQylTZ3NjercuEDConjSsYM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hJdOzDAQ923A5s3U76mz9GILrJewU46LmIG7dcFNYAtwXxAKXj8ko9oPfBmiaF5HN
         C7ixnd8q0LY0zWwHspdUbpi794VRhLdXIth2DZmH/pRm6hAgiemkFoUUNydvboaf6N
         3RoX6DDOZ9fVp6G/AjBhaClFf1nzwObUWx92hT8c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.121.241]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5v3-1k3xIm2ocz-00BPHy; Tue, 07
 Jul 2020 09:23:53 +0200
Subject: Re: [PATCH v2] proc/fd: Adjust variable initialisations in seq_show()
To:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e0c48e5a-650d-b475-abe8-32315f2b6ac9@web.de>
Date:   Tue, 7 Jul 2020 09:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612160946.21187-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:p8oLjhveHhW47M9piXcNBT4Bd24Cr//51RwjFNAvO/rm/q5t0yk
 ydjoicdyQlI4Tz/fqj0xcx54FaRpZWRiPDlOCtUQhm7YP98YA2u+wYdHjL9fG2JdtNO1Q2m
 jumBVv8BDxG3mked0zPkk+PuiNvTGErBaX28aEivYWh1cZQVLuKeZ1tyiJrKwNVIzOGfGXR
 De2TrcvGv7Jp+Qwmtlr6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPshzkKtiOU=:7vdAWQMENfmJzdGgH0OovN
 3Tr77eUNvrmajBpi+CAE0Ultn99kEErvkSaOd1kDGcwNgRzMpU5gCpwcrLegwPzERNiSyElLI
 72+413Y5iwBAJ+xHl3Tkipxv3oRZEp3E2r3HXn2tmZBDusNXOcFOTyZmORQU5nuSO1MObT9W4
 PjVKHfK0lEF7cEcirHrUxWZ1o0f4Hb+lMgP7A+OwKcKQImVeyXVen2mGHirMYlwr/AO3genGA
 boda7UvLhLEzu5vZbPWvNxeQV8INPv9JJPA/0aHhP+T7OWVE4n4ulM9C7zW0iZMcFjWkeNan5
 2vAXS4TBeSSmTLx42gDpIf4p/IvZHzYQ15khFmMk77WxFlnvW8k25zpgMJlrnkt4aCk+tQLQd
 ruftjZvvqMnwzqvX0UeEVjHcPD7B1/B9EMxVNUtvyO+epp2I7OFCa3LCZmeH1S5yA4YjaEZHD
 1kvHuU4S2VMtIiNxf/6Q0Gr+CuH08+VtLRn9yhh3Ct6czUNUNvpmPN00rMClssBv9zMEezDZO
 1m8CL7723flEay9TT8mt5hLTK3l65nb4qiSzqCg9Jv2Gn4eMaAjK+S5VZ0UBCr34gTgzEbALf
 uswdfV7nN+UmQO/5CkgCUt+VX84OUhruZ4HqNR0WepKoJ/BPbYxY0+4INJ68yyB90VzA7+mdU
 N5Q7HVxos3NHnWyZhmjGINwyIMOmDDpzpkIOPIF43gfty2S0YD5MdaQ+LgHp8PeA/Aahut5L1
 WixlT1uX4rU7UPvDBEgsSx/8X+K+HF5tVJ7x/HUNMRW1xQwQPyOZG9rxRHlzEOU38t1Kt+VQK
 nqlDKRCst/7lX7ALlrlZpcy+fymfdC7LepM1dulYZ0Bjc279RNDpneJvamqMbC3EGa1SJ1ztj
 20QoYZ+QAwrNJELs7p1mchDEceZGUvMA9Q92Yl7tNAjFBCRG94Pv5gN9ajxgnaZAWUeNv1ZZC
 GZ2+6cgwZu5ugSOixmpkS+/D2hWiTHnDsV2er3QlAMB3Mw3mWDxY/wpdpza3XTfoJmX2Gunzi
 6R8UMNl1AYgdoLz24KnqguVO5cy3BFNo9d6Obq9mCHw+5latkh5ZrVfEdGJ8wIt4Vrm00HIxK
 MpqTkNW7SidXmG/IQOWjWkF9E48PTd1qyZr+/VLspSNbZCHLeefU9Z6wh2tK0gtylZeJPICqz
 NDld7OxZFrqbI6jn+2aXslMtW55NGo9HdEie2TijtRGYfM+3utjQXDXG5hZQ15sITWXE7+nat
 9zRr4hyplv9eGnvXKfEuYPOsy8dixLQarldUWug==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 'files' will be immediately reassigned. 'f_flags' and 'file' will be
> overwritten in the if{} or seq_show() directly exits with an error.
> so we don't need to consume CPU resources to initialize them.

How do you think about to reduce the scope for four local variables
in this function implementation?
https://refactoring.com/catalog/reduceScopeOfVariable.html

Regards,
Markus
