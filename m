Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C031F545A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFJMOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 08:14:41 -0400
Received: from mout.web.de ([217.72.192.78]:47789 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgFJMOl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591791260;
        bh=pBm5IMHL7FVaD0k0KmA/bqWajr9j4HYNky5AVQf4gnE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=VsKltnoR7ptj0X0xAYUMaXnU4I1sLf9Zvi8wM4O0UwbBEWUUHqx3vVQngjJ2JzAYi
         LzJle0uQb4dDGzLFAT40U2pEO4JVSb1F67zhwcndrHcJ24N7tYsIieuxgqYRgNWMoC
         8vKaqFMkTgY7bDc/f79qmH70p02q8Cbov9LUS0og=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0Qkb-1ivYKP2qKr-00uXoz; Wed, 10
 Jun 2020 14:14:20 +0200
Subject: Re: exfat: Improving exception handling in two functions
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-fsdevel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
 <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4379dad4-8c76-6790-2d5b-91a8fbdffc9f@web.de>
Date:   Wed, 10 Jun 2020 14:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OkKpHaS1U3vQq96DspLBKT9LuRuOOeAzvC/kvsXcf2ICtE4hVVU
 jFkWuJbwyR9iI3/SGhhNwnicSoWXbeaOWDIOkb3EZDrrCRi4VkR1FtABAfH9DPAOyUGT3Hz
 RrosBCcVCBwoz1/xTKTN2g6t6Wmj2Z5z4N9ngpZIuleZmGQb+fxfKPydGssILdPo2jXGX7d
 +Uvdt7AvjCIY+TAsrAIzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7867ozUOF0w=:OnLlKXz2d9bpod3W4MdcYb
 Ijq0DQCyvT1CHCA9egbTbu+XA8CBmjfopy/xmo0Fmhb6f/5AU3Hqw3pWXap2eqTZ8KicHei/M
 iLmVm+tgDF5TqXFJswlJJr4JRXomhQ5SdJ2DMil6ULi5RnkMDSncu2Inr1RLvVSi+fxRWVLtY
 Z/eCvF8fNDGhSmaHEWfbVS8nqWmSmZq4eb48ofP/SdMlVE/1Z/dyZAOvC4qO75Ob//7hL5eqx
 LlCbqYOHS1NDY8P4FZT2NMfcM9u8OgA12w4+9kPfQoj58PwPfaTu/DRBBgxei/7xcMGUktoiy
 kKSLtCVUt8IVujY6A/cbRekxbi3ZsTNeuduWczLdamqj3uHXaggpUYBYytSjxtQq9dFPzJLWw
 IdIb/eB3QCCo527etTJi3/HeFTI64fzmhVTcHP26Q4QubasasrQ0MLV0cQ0b7jtk68NW0yguW
 z6EQrEokkkpYSFEkFncu9gr3gGSgDJSsMnbQI6R1qzNXWzCnk3/kSVnnFGoNE380slqPf3SWX
 LRTL4TMESRt42FNGxu3FEO3wmJu6bAKgEN7NjAQZK9Zi47N8npVDa1s4zO08rUmGTLmeTWnX4
 +t6EUhUi27L0IX4GLgDymStf+tZBMcCsBJeZjgjkZi1rBkt9GFvUgfA+82buJsdL78DzDEW/o
 q5UaAqn2XxmypluB49jLAlJIOZEYNfiCSxTC678H9ZwfxzyHZscSamLkdT6whdpjhyEAqBqtu
 41HC+g87oMbJl4mLhiBJXUjnbxc/c0UedzgEEM0+oKW8PiLk9N6wKBmqQBLGnkEl6JBrrOoRo
 9FwyiZRHQrHHSyXjslJf+H1+Azwmnl+2MqesErJ3CLuT8ACCfZ2OxjNjRBC0kF1gaVqI6qC5s
 XrOPhEUxyDyhnsdL+Sn5XhXwzcCrasxDrbvA0mNGk4jO7sGQhAJJhJZHfuH7INHTECikbu1HB
 I9ZK1iQjYKIpiY3xsdPhgU3woGBdmfuSqIidiCQeSXIfvkegtjShyxAw7DoQ1f1YfwEtPvhr1
 xqV1YGO3sxGLiRldlFCvY8iwoM1q873wYJINx3D1XNLRDYPmtI9y+CXUC0bVUmvIIxn3+Isky
 MbjdLFMJ+ifHPiyWfcT+uW0MfozE3RI6O8MZ3Mu8bxc9RmGx8TeLYdcZX3+jV9An6FyY431yP
 +rHwYUGCGBafyRUPKsfhtuRgaIEYjgE5FrNkcNWx4006bW3t6m5Y347IeO5Q6PT4fVM5y5O7I
 /TyzYHH1fNQeUrXY/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> My source code analysis approach pointed implementation details
> like the following out for further software development considerations.

The clarification of corresponding collateral evolution will be continued
with the update suggestion =E2=80=9Cexfat: call brelse() on error path=E2=
=80=9D.
https://lore.kernel.org/linux-fsdevel/20200610095934.GA35167@mwanda/
https://lore.kernel.org/patchwork/patch/1254515/

Regards,
Markus
