Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12299143CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgAUM1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:27:40 -0500
Received: from mout.web.de ([212.227.15.3]:60235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUM1j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579609642;
        bh=4AsEhigmHjF4iay/o25D46WTrYyu4CbFRtD9ibRmIjg=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Al2MQ0FMk7eZYIsAiq8xgQPyqst26lCadQYNgN2PabQcLjqIImL0/RFuYkynHEJ8T
         dKh1fzaStSqNFU/ZjsmCqW1vkYgl+7uhASCTV/cuDJUIikYkQJmF9cSW/yLPIyywvZ
         E/VPEnKgRei4k9bGyKvbizY5a7qbDTcbOqUA1GcM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.33.93]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlnQO-1jSwOY0pua-00ZKrv; Tue, 21
 Jan 2020 13:27:22 +0100
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v12 11/13] exfat: add Kconfig and Makefile
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <9c47fafb-c41d-656e-3a71-c68557582059@web.de>
Date:   Tue, 21 Jan 2020 13:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DduyVUG3RqQ5Ci3Xujy91wrXcuqTYGm/se1dkKcBa8e966vU9KZ
 6EYoqMcymZoa2ekVTwk1Uj9RTZyYTKd9S+YJ+qthUg3Z/zPrVL3oNJoF+goaMn719v8ZVjB
 WtntZYWayAu3cMXMSfwZdoVCbH95C9hzprNzMYpEQvy9VY2X3durP2Yz3QmK+HtxFVKVas9
 LfqjM/H2+ni2glonPkoYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyEidgvbvNU=:YwDB6EB1JOKpxIrXu82hBh
 MY/TnrPewJpzAqro6GB6FciBy8IPxzzDSgUNkIzb7D+27agO12eqNJ7Zv706afLvUxyW8wqLJ
 gnLQg002LIQQqHLiL5utDV+jCw3DRqrYuDFjWYPAoLYJqdzoWHJfhKKBdpAHXdqPG/onBaNjv
 OzE/cK+9Sw5ld9UxevTtRIjbs1suHKi9TGwO0Q77U+RXTpmiW7pimsyeqcx2MhnjOu6EnkTmb
 VKaPdckTWr2I0P8iDxsH/OiD0Awu0M04Vm1eGPnKEaXxFhoF5a7k1d6Jab4EAzy70NUU5mU2P
 KPXKMlTXEaMIHno56H5UISZLyn0p5/STjaAO15QNExBqgy9TQSoeXmiNsEf9w0PvKTkGP6LKm
 W9JtttDOcZqrEkMCuv+xBvZDXv7HU+aE6z4kes8TJkwDrFjMLHBffvG6RU158rX2Y4Y7JctEN
 CS0UC71jgdZYfATktfMBoNDMo70hQYJC/jgdv54bMQtPJBEHDjHUjQ5miF20k3g13hODiKDTG
 /aXBb/5T+9RS+vraJ72te/yWLdxmLOMcE9je2ZHf0Jd94hzqFTZvkTZlGr0ggZK6mlraptHZo
 CmuR4OpXB12wbzYPvaUv7uwQ4dJUElAf/SrRG6xI4WTmXSvHFbhh651X8NXmDpiIP7PWkDuXt
 niBXkao5IXE2qYBUryRX7VIV2H5Q79x/FfS0DoUMPnfPJ34uY+mpjGPX08kWmUZqcyTivP/Ah
 EDdlN7ftfF/w0SjhyZeqQE5igLgKsT+urSmkPhlZiIsoFgncHPEXP7sYGHtriY9gGDXKkrZGr
 hwRGburfjlV2QOJYPWgOvgs93ra6j+1hDu6lKWxe0vlxOvCPMZo+qcZvaI8jHxHt9W0cD9zx6
 BoaIPPrz5AYwIay6w1b3PV1IKvrggDFUFnPT1c166fdXU+9jfTJxIHkrXdgxsZnP2cg5hXWk+
 lvHl4dOiQ72yU3zdbw18qFew/MVVBQhRIZwE8zN6v9klT1ePadX7s4vEqcTXRSh5952gL+8/D
 KSAF0UEAl429XT0idp6yepzF4Axw2/ZoJZamxsjxEyd0lG7oIQGBT/tpameNkLdXWa+aK+VqU
 jRATOqJQIv9n/Jwf9dN8C1Ge4cqFTa+SRyWAfATKx2oAMOXo7fqSmmD76v4Q7L01Q66tgakhf
 z7ZrskqQf2mTNNPDFPD3vRsn7kR2JXNW+HuZE1EwEeT42MIHeDjqXa4B85u+k5vJ8mfIvoy3g
 3T8RYVPVfjryt9hmrYtTWSJybDBlwoqlAciTVZRn6J5QfaPUCvsWBAVwxdX0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6 use. and can be overridden =E2=80=A6

I propose once more to improve this wording.

Regards,
Markus
