Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30514B27D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 11:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgA1KU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 05:20:57 -0500
Received: from mout.web.de ([212.227.15.14]:38683 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgA1KU4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580206839;
        bh=kbfBGKYYnZCfS1K6d2I7C9nCWzJjuTWxaN3fvhto/DI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=miY5i2GpRpL2k6xXZFkw2ingU6g6UyxayVEVbwqkYbf5YucuvaRG7HjAxnrNj4G2h
         Q2bOPGbRZWJ0YIEYq41wh7dPz5d4wcif8rqe/nVP9krzb+Z1oJtwduAsZH+O0TgXPD
         1hajMCQpId/T+SACr6ZpUhcG+sxYuwoO6+N7ZsR0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.131.179]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MI6JC-1j0EGn0yXW-003rjD; Tue, 28
 Jan 2020 11:20:39 +0100
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v13 00/13] add the latest exfat driver
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b7779ac7-a8f7-16e1-7561-270b319bd095@web.de>
Date:   Tue, 28 Jan 2020 11:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:LFncuN+4503kOeW+9II6/aDRZNAvS3wnS1xpGf7+HWku9Bdy0Qg
 Ewcm/9ClwEX4jV8KE0kGTxsI0zZS9yDXf11XHEDSdQqy4mX8wa2pZoIIskdSYJD4gNO+nCm
 wnGOetw/5cLAwhnuPjSAGtsGOv8qmkZiLIrPbL31aYykkUIAsiHyIhfVFOTblHkpR1/HOQ9
 TKJdlLVA85TGKsrIU4vfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jwMk9qCTSZg=:oJbnAikqxo0hVdJ5US6Ojc
 AYS2a0K1KxREjryohjFoSqKO/QHR2qHo83/0nylCTXrGc5+oo7zNWrLoa1sRYxUCnu1LGbLxm
 YxsksRoW6AE3h6YTFhC4JK15E5kpmdo9H1h08Urxnm1Y4ra3JxrlAniJCxAXutwf06vyuBfNZ
 o5Vy9ec7gs7VwPjRzYBY0cZwBQcORhcd232iF/IWCK+IkrdPwcyFYDeQYAdb0cdonsp4eeJ5O
 yR/+DOm7ycj4YaqJcSaStmiF2+zn7uITPY1Hr8KsldmuLaWCY6KgelLL5OZM39rqJkhGW1cWk
 93DeBhlZawWsj5anZYIOMcTsU2mci32MYCBin8rxyAOH+QgqyUGyZd1rs92WvUpAc8Z9pv08E
 lqF2jdr+kcM69dbgiZuuTwtA0+QxpQS1B6ASRRiDN6z6b4ulYZGOAuSATJM39YeqdMs4HIok8
 bWS0Zr4Kpca/eAa9hQuSU6wqB94skYSDWZd5uYTy8soOawY6bAohiplyDitVkfQLGjxOR6nXF
 TN3SZUhg1KkJeR7YXRMRCeiMyhSFvsbnUnO/pFBy6AiN0hEQ7fjBoJ6uCwsX06Up8wjU2K/k3
 WbENUoWSH+/fBFDYwh+p0LW4s0M1g3Z1S++1BSLLP313u52vz6OnSvt5tBQ3lbxdioPOOa2GM
 rhTCtxk8dW6jlJFzv3eZlnobUlk/kMMpRKCSZpxQ7PuIW1WEo2U35DsRrTx9H2PKs91IZ36E5
 frcq4HdcfQbK/I3PqNITkK78rUm1Xq3o+pSwdQxF+Sb+z2N7OGStm5NRHgpWL0VByI0Vyrrw8
 SookfoiSTmC+R69Hj3w2Q4iDp4XtSdux1n8oiEjVw1Q3QdNtmMx8HEXIbBFcgeF0g+bzMeiXn
 322hjpExC0ZG5oaejXCkbNpuaGe/8fl74APzDLLCgtJWvJv9JXL5X/nv5jJlCdsjpQh4nIudl
 /IQUIrLMVCigATBAhKMkRnnlEBpwSWd8pxonT7O4GlwjB2BdxM9O8PoDDKhh5z4KMBvVCepKh
 nmK2F6jvbYTPOtnsT46mwxX575DAdZt2OgECiM7C2TcF+dsutg3NQLlpUd7/bf6uZsCZL6S8b
 vx/Ul0+npxd0+ULUqeFJ7BJ9M8JjVgkpaXWpKpm9UO4Rxnd5/46K33Teo3rLMPnBRpyXwjKek
 rryE8A42fHJS6JQRK1E0qGJd8qo1FX40XtJJcikmaJouX0sXRfE8NoQysyXRFvpLcpyR3lL/f
 mKWs54TlkwUPkBQXw
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Are there any other issues with this last version?

I hope that a few implementation details will get further
software development attention so that the desired clarification
can be achieved finally.

Regards,
Markus
