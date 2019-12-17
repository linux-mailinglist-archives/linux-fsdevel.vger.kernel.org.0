Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8EF122C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLQNFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 08:05:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQNFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:05:49 -0500
Received: from [192.168.1.155] ([95.114.21.161]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4eOd-1hjMRu0z83-011hdK; Tue, 17 Dec 2019 14:05:41 +0100
Subject: Re: [PATCH 0/2] New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
 <20191216094241.til4qae4ihzi7ors@orion.redhat.com>
 <BYAPR04MB5816894E05A9334C122E785DE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <3565a0e7-b9ba-4f32-9f4b-3387f0a379a1@metux.net>
Date:   Tue, 17 Dec 2019 14:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816894E05A9334C122E785DE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+ABngioGkIBLDL6fLn8WCq3MvTH87+LP+0U3o+yGUKK5bO3Vh62
 6tUB8Z8zlSuT6yjUhIPhfiv8XDi56UUazaAhK8DbChs6tgAIngH/dRvFQxadl6vvfrs99Q+
 FtuHBf6sHVRw5F8IKs2EJm5KvVcrd+HeeX3rz0dbIhSDDXtmAi2x+kzFPqPLkzYdrXxS19V
 hNOqtfCJhjSaDRPyBF5QQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cbpw+reR0po=:oCZ4QpXWXVdJvR4emq05Ya
 +ENqKlNd7LhKXVzBvmgQwGndst/nG18+d/PEQDo1BcT6BPUvox03LjweuBMpkv/7mNHQvIyX1
 6iwoNnMyh73Hcbx80xLVAlRPJME6DEBPg1Tcp/e83Z6maz3Jh92Ker9BnhU95lLG33kF+OUTl
 1CnnmmviB4RL893JfY1ma1/7Zk3E/c4a7fIsv4vSAle1UAYLy+Q7SR3vp9rDCQxF6hAAmKMS1
 4/R+QkEZu2qcAiLkOi6WOzP3dhADw9CDtQxwvFtFpk+ogIEOtMm3hCJYk3s9RzuotXwrs3qnN
 nHZ+v2F0xjgKzCr0PlqYwb207wE8If7u9IYmypQaQ9R4g0CkTJSvj8cOstLCvziKstQiuIg+o
 Rev8SMdkYWum9olIL3VSsfviI6xncGPKApOJuQguBnHBiV3u/+6Jj1CdQsoutIcfNPrHzl/6H
 KjhvorICqOgX2AcOugkuHPksupygpD7V5IwK91DTVQdCDn8otPwDyIFzZH47xQaEL3ZerHD0h
 brSi7PVWjSONlrbXt6Ou0NckhJvh7z8LWHJgf9AUMKgaKe7cz7ZhjPgcJiZCx2ZfhEG40IGQz
 UZ36BoUjzFVr7bh3/8wq9MO6r3D7+ef3veP0pQP/aIrnq92mJ1WnsDN/g44S4JroUPUFkIyxm
 IZWsZQ+31sx2ESSKGiVj1iBkVPa6FpatOFWhtMRgDVo881XUuXTO+ePLzO8ibM3XFmnbuUdbf
 p+R6J3cNpmG6hYrO4e0NRVyffnFC7RKGwEu6zzBvyM5Qhv8qq5b75hTrYhDn6QuNzZ5+0ADlB
 X2bnpqwqdQre4XUWmjPoKIzwr6bkwo/gj6lNfn8zVSSDv1gTLcfQYTvwwZjE8ArscMNHQRrpP
 vSDzSgJU3TOtRWpu1/Fg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.19 01:26, Damien Le Moal wrote:

Hi,

> On the SSD front, NVMe Zoned Namespace standard is still a draft and
> being worked on be the NVMe committee and no devices are available on
> the market yet.

anybody here who can tell why this could be useful ?

Can erase blocks made be so enourmously huge and is there really a huge
gain in doing so, which makes any practical difference ?

Oh, BTW, since the write semantics seem so similar, why not treating
them similar to raw flashes ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
