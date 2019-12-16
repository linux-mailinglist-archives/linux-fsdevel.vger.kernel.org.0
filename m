Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5611200AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLPJN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:13:58 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfLPJN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:13:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MA7Su-1iZecs0hdC-00BdHz; Mon, 16 Dec 2019 10:13:28 +0100
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
To:     mtk.manpages@gmail.com
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Henning Schild <henning.schild@siemens.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>, Jann Horn <jannh@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20191107140304.8426-1-laurent@vivier.eu>
 <20191107140304.8426-2-laurent@vivier.eu>
 <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu>
 <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
 <1576267177.4060.4.camel@HansenPartnership.com>
 <3205e74b-71f1-14f4-b784-d878b3ef697f@vivier.eu>
 <CAKgNAkiaKJZMA0pzvwDa75CxfULTL1LmOZDzhW0Y5TmL7nBGZw@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dbd19cb9-9172-d89d-f796-05a23213ca69@vivier.eu>
Date:   Mon, 16 Dec 2019 10:13:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKgNAkiaKJZMA0pzvwDa75CxfULTL1LmOZDzhW0Y5TmL7nBGZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JF7Lzr1vsKqPzH1SsoAnWaCSGZUs5IgOJ9JG4v5PDzWo2yl7HY4
 85lF/dqHHKK5J2Nym/TCuVgkf6dFBODzMRk/QQAbnMkoGNHBGFC71ttmfDrjxHBtnWDze+w
 6KtWT/nKQGrcs1aS6no07MsHzaztSYW4NDCZmRm3RJCmm3azQSxQDnbzXWP1QaeOw9VflIe
 O54+hzIBmsA+zMFw9EnOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5sVftxCw9qM=:2kh7xWHcpiQGwOqXjDAYIH
 ll0Avwf/z41TIvLG9pe4n89gtmcJUDZZELLYKgSCb8u42Q+Jxn7ZXuALF/3sBAf8pzYbIU2Qz
 xsHe4v5lQ8m550sKNdO/DyLnYJ1bC/e6OC3kYdzkIGe1Z3FSrE91H4D3Fqepe9YFO/cgWqEV0
 c9g4lahzN150UF8+TknVKGmg6pEMT1hGRIswFshfwabcG4o6/zaJKZPSkKQ5F0UTKG6FQBRo+
 5lIy2ygbnwNkUqllYp8jpv/zS7rzrYxVMidTEUHQ2CsRVByCyMMy6ENXHuo3srKRrkKYoVeXy
 M+HML7F0Lxs60O7OW06N548d2JQYmGDAMeZFq5Em18DIHGTxAjF+/5QBq9fy/i4X8OiW9m9mP
 waHAalD8CV9DoSAfv5vx4f5OeaeV1nWJiqMnHG7cs4uFYcXtcqMbxA8RogU0s3mFYqlDGLfzH
 vOK/0uq/t+P0qSiYm2ASZLlg8XifeY66UU8d+WH3pELnceYtfbAcodpzgUmEgxrS7tUizBDeQ
 GLih22bT3/cfXyJy2WG2Jg1FdTppZSjYQbhEM2wuYKhlrjR4ae4JmQz4N/uXeTjWIv1eb7WvK
 +fwXN08C/e5ngfkbqwTmGCR4XUQQTdV21Ctkz2S6V2F33yCHQYbF3dXe9Tpz6rCd7Fq0JB2O2
 RwUtxgZn2Nf/7DRRYby7E1XD2dNwmShzk99FUomD08lvKO3/D3Lo4UtMUbZJuyFjJKcCvqua6
 gC0RZDHAf1ruI22HFR091ZgRPcrEyyitvTf1XqQhlbMXW9rEks6hIS1aeuI4bGcn3WSi/6H96
 QTj4qCItWwfMu0FV6b535ySOLZY916mT/38D4RyDXkmmFMoU27CBdsghYKvgd82qSiK5NmEQV
 RdxFxs16gLfYBlXgeJEQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 14/12/2019 à 13:32, Michael Kerrisk (man-pages) a écrit :
> Hello Laurent,
> 
> On Sat, 14 Dec 2019 at 12:35, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 13/12/2019 à 20:59, James Bottomley a écrit :
>>> On Fri, 2019-12-13 at 18:51 +0100, Henning Schild wrote:
>>>> Hi all,
>>>>
>>>> that is a very useful contribution, which will hopefully be
>>>> considered.
>>>
>>> I'm technically the maintainer on the you touched it last you own it
>>> basis, so if Christian's concerns get addressed I'll shepherd it
>>> upstream.
>>
>> Thank you.
>>
>> I update this in the next days and re-send the patch.
> 
> Would you also be so kind as to craft a patch for the
> user_namespaces(7) manual page describing the changes (sent to me,
> linux-man@vger.kernel.org, and the other parties already in CC)?
> 
> If you do not have the time to familiarize yourself with groff/man
> markup, a patch that uses plain text is fine; I can handle the
> formatting.

I will send a patch for the user_namespaces(7) manual.

Thanks,
Laurent

