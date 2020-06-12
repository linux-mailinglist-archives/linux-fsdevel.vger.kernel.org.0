Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E471F7D46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLTAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 15:00:34 -0400
Received: from mout.web.de ([212.227.17.11]:36947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgFLTAc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591988425;
        bh=WSvz5iR9hp1Prq3Qr+9+rmXYQSibTT4zi0zEBk9MRw8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=coedfnGz2HS6Ucd60bUzLqBoROH/x4hqhKq1EbucltTJFML9+uXNWNnD1bntvsvy0
         sYZV/oM9ZUE7TUV1wuouKztmRnBX7i/jae0tjF663mlGvj2PgmM4FR7dpHEbgCpl6f
         EugGsx4BwC6z3KN3dFSFGto78rjelDZxx3WmxBI4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLmq-1jNDpr1EY6-00Va6f; Fri, 12
 Jun 2020 21:00:25 +0200
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
To:     Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
 <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
 <20200612184701.GI8681@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <95eacd3e-9e29-6abf-9095-e8f6be057046@web.de>
Date:   Fri, 12 Jun 2020 21:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612184701.GI8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:viRVcz28H7ZERBgjLeCO7m3ios9FGw0rhc8SuSmc0V3vHBbpGNW
 qKYYJe7ZvQcpT/nNIgBPx95vDYvWvfZILi+QTJ5sQ0KDJo7FzpFZ8Fbl/VddW2d7rlH84i3
 GKHY5bTKsG8tvvQsjLEQrLFw52eXM+DZ1gaZP5z5f6bn7QLeiP2PgsiIwNn6Ca43kvw/dqi
 ghpclJrNONGL9OzXo6xDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcW7WeEjsJA=:dHyQN2+8ifIcT62TxfFAQx
 N3luaHIqEOCbjRbNPvmhjOwHdC2OJ+p5Qii+qyD9gTLjYHGkzP+jSfJymxotT+R5fepzOcg6K
 7CM5auyVzjrXtkbbknZY/1WxdxKn3Nu2YMRB4cWDxLPe/nSERKnvN7YLK+ohNHOoLurVl0gyR
 IpsJLsg5syU8D1MuNUnSyDa67I/93P/s8rUC0rEWa08aKJOZcVtakPFgQsj64hK8FRgmxFCXp
 7X+uGynkBHTcZE0fGGwSWHMCWr7+nFC/r7Wcr4Qq2oNwslTcXcXKNmTku2up1RNFOap3NEEp9
 BaGONDyEhm/CBNKt1aE6cC+/2YHIUFWa3e6JxkW4AViQgQaV5T8V/X58Tf3KAPDaNCC6lhHEl
 dHWtozOSyG8MFMe9+IadMc1788okf1gjc94CmmFH+ongsc5vlGFb2VnZH/4jKCS6xDNIaiV/S
 mFzt97K6crYcy78AGwGb/iRrH7qQrMfo5EP7e1z+t1HJA0xwPIPbqcy4c09SZ7c7EUPgFUu5e
 5gAgnyh3Zo0v3b9nq/uqoEnmqBhGOcdAybiaSSAEXJh6Z8nUcaguX7XKoxv80TSfhXTPqcMSd
 WgnIU43UXww5WcqPW1BpKJdjGo9ePLEgmxr6pElN7YFw7m3E6Qtjxrxz63NHVdZaEk61VZ6/2
 /6w5Kg4358h5nrNlN12W4JxWLflwiRxtqYY9MNhYqtS7+GX3lUxSg+ikeE+Nhcsg6fALxn9CI
 FTpo4g34yEQXx3t2OYk9/uJMHqQ7gOyVAwNsHzPb5qJJexa7eaeMEuiZ3YwiR+GOdofyFUbSW
 jeBDxJWq81gAZ+OXA5X1Tmx5rMbq2o+mdkkiWVFH4wQEQoTRPVGjmbZLz1U5o69s6nFRjym8R
 zxZvPP/zMWGP/w6z1wFUW/QI6979mA+javrGSIP+3yQ5kQlSdxhlrvpUPp1XOfAm+uTZIiRWM
 DsrYiQto2vOzLifGD0vfB1INnil73y3HuxLW0zTucOflGg/ZNU2PiGiUzTVU3Xw2t/AvPoSC0
 9LBzM/dgP35hQCjF8Ft6/10KHl65H0WbXvQ0woNq5cv7bJgDXLZHt10/APef2YwxU/srVZPPo
 sSfhi6Pda5RCDcIVV8AaS5NVTgm6Ff1C2SsszVJYgruMgezSDyrXK8DVKBat4MhA025uppaSp
 QRYcCuekx3tScva64e0zNHOTYw2MnGFJHT7URC8nlLxIePyLRf+Gut1tk1tW6U/9LRtNoDe5g
 EMZXylCrkj8KyFjnD
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I suggest to take another look at published software development activi=
ties.
>
> Do you collateral evolution in the twenty?

Evolutions and software refactorings are just happening.
Can we continue to clarify the concrete programming items
also for a more constructive review of this patch variant?

Regards,
Markus
