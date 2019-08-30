Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1983FA362D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfH3MBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 08:01:00 -0400
Received: from mout.web.de ([212.227.15.14]:52537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfH3MA7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567166420;
        bh=7fxlgd4hZrILEvOf/F6mMfDqgF1HNFPlpJAW44RPfbo=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=Kywu54IqJVRYAlLQ7nhqVZcBp27C9ZlYs6jTU9DqQsdj6C07Q7KVhJ4QfNXEHXlkA
         nDjOM3FMsJYFuTEOJZpwfsisnrcuRjbrUOK72WCqPohURBwa7jUinXBkvSGdzmL8af
         u9/XDDVH3Q9/z0vCq1atnc4YdbWZA6Dn6Jmku0VQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.166.132]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWS0g-1hg89R3i3e-00XbqT; Fri, 30
 Aug 2019 14:00:20 +0200
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ogawa Hirofumi <hirofumi@mail.parknet.co.jp>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Chao Yu <yuchao0@huawei.com>
References: <20190830063838.GA144157@architecture4>
Subject: Re: Checking usage of likeliness annotations
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <50c1dad3-c19c-3f95-405c-da7c6d0b7bf4@web.de>
Date:   Fri, 30 Aug 2019 14:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830063838.GA144157@architecture4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:5hSF1VhouE827mMr8faeRcTzdqvFnAsbl1HPZ3fCRurpYru7Idt
 cJYALT20Jx1kDDr9Q3H21QGt8fkkdpXSlyxM99G77JLdjOz9t1GQ0tT5vw7w5QwUajCrtaV
 HK+LcIxZ9nfx1Kmr35Q0IlWvqMJ38NABFE1GAgLrg/1bTrVet4eb2Ri/wndYXrDeYHi3T/Q
 cXSTyHG1ftXmOrm1Vj3Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TjJuGtu5FeQ=:v1bATQRbPMke+6RYLQgpHm
 sIX6dDTiZh6VQSqjVtIj/gS0mWzY+roULYD3WyexDnrK6Ei2BIt3guqK7iBXBvqFSeYfF2svp
 vFdd2DPdpgK+2gp0HMD1hP8g74FtyVixECs86x5QaPgG+Wlgq7WECFKJ8PggqZvAE56LMXStz
 O7OZcHpnaV2M4k51hwZKNIkj4lMakqzSKlpMzaF3J8a39gkyrRah7ZTaOPQXngRLqSoYNnngp
 tyx0JLfd3IvRXJOoPCa+EWh0WTzVIGGvTgV/yiY1eKkeGDISiBf9u3crqTaosAHD+ks3bwQa1
 uySBddgl5OVT0DIhfWRIAKAcP+L34OhDh1r7meuEVnwVJ3CIM7F5V21uQR7HZYXBvcjGBD5Pt
 aSL3Mp0gybDJM49dnei+IK0+q0Fr8Wbe8xIgVJtajKRH/LgtkUnGm5ZEPCBNU69vcvm00TDRQ
 bHfwhgJaYRN3dLBZZUni68mD7FR3xccq55VPuMhX1eUHOxJoAoTAc6e+MBE7p8QGHXwblMhSX
 YZlfOvv2a7GFAjwGZ/9r5eYzLlwny1XxI7+lBtRKC166pEys9BJjmvawsiljdVVfxYukRFUgR
 BIF1CiACGJjLhxJt/XSZBh9WSp8SEfNoFh0COgsL63Fahqi2UNKVsO0MhlI/zO2U6XE/C6T0J
 uB78ZW8x2Tj8a0eGooEaEGuNKalRl680GYypbWaN2lSqIUBf/vF+6k5aYe8ZgDxpqcKCWk2Sz
 lTpeisR2TBEC/i9xcsHjmsYUZf6At92ojYe3n9VwivMPJNHuS/NumuxxTyJmJ26u1FYPrWx3C
 kid/YGh25P1Yol+uBthdlPPilSuJ5KPK7sJwtR4E4b04lnU+dCCyvv834Psf+uClEeP063wQ0
 D1LCe+6MEveCNODhxvCrHgYNdLDL843wPEnH4Nx2IRzt8RNGXCMSaDGjSqU84zm8rOt6+/5qh
 /kkpHAyL1hbB3+qOGrSbibEayF/9aM6PuPo8ADnusUYA9Q1GiRDBhHu9lkigBCKPWVO+9yjBp
 oulS90N1shNJ4heqG4mow9PG61qMN4zO3RV6HZxKuXXSHkOZD41i6vQH7xblxYF808fEx51VL
 u7iyCyUljjAXLVkqMvJgoiNiPQeK2uHReV25c8fYoGyiL+PX0Ztg/emOyShIlykvWSApWh7YL
 2YW9KP8IbWMttApOM7F2nmWz5+cIHLpQ8wk4JFPONrZA5FWw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I'm also curious about that, what is the filesystem or kernel standard about
> likely/unlikely use (since I didn't find some documented standard
> so I used in my personal way,

Such information is helpful.


> I think it is reasonable at least to cover all error handling paths),

I hope so, too.

I imagine that the likeliness annotation usage could depend also on
software build parameters.
Would you occasionally like to influence corresponding probabilities
any more by system settings?


> maybe I'm an _idiot_

I hope not.


> as some earlier unfriendly word said somewhere
> so I'm too stupid to understand the implicit meaning of some document.

Can the software development discussion be continued in more constructive ways?

Regards,
Markus
