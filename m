Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40ED17DF72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCIMBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:01:41 -0400
Received: from mout.web.de ([212.227.15.14]:37345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCIMBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583755285;
        bh=rziJM53QWPLw2h+NFNA0oVLKnePui2TOJR7KKhLlKoo=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=pxkg9Kxd7I8YQbUeVS8nQSET9Iawf2LEh1iA7CbLjVrQYSs+Z1W5IC0v2e1Iqq4La
         /T7vRsrry9WLSmBxY+7Un/V/eFsvHGDLitIfo6trCoOZCKD1ZkF58EB90AaPk7AUqi
         PLUI5zP63SxzFrDBiJt7u9XtD/wkqrRgV6jyhPj0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.147.116]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoYJu-1jqeac3fbO-00gUN3; Mon, 09
 Mar 2020 13:01:25 +0100
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v14 00/14] add the latest exfat driver
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <82902684-6daf-4eec-b1aa-3ba746898eff@web.de>
Date:   Mon, 9 Mar 2020 13:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2OnXjI5R4EaBwJcwHXapGHQVbHXel9nMTPk3hH+JlaHz7yb3wLU
 53ps6G22rSIjPYPp/J9pgbips2cBM9VyUlMAi/I9tkUKFZUiWSYIDxEOxZWkhbNMs/xmTkd
 BrT4HqqI8O6J6Jw5EjolEgTWlcIWit/rUkmyYc9AYhwggsmGz6hJgoKjDIXxdMh3jt7Yb87
 HhV/MKoB6oMDvbbAJkD0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iO14Kcfz//o=:CQMyeYw4Vy4SEAxVJ9CGU/
 fPZymbpnpZ77rVp7V7Q9sd5Nu05bWHRC0DWjVo/s8rge9zkJ+cDmwoD+OJtYZ9Hsc5eTRHWcU
 LCieuAJGU7w0pAAV2rA5q1nLY3jtTvVnOvI2GQHk6ZI0SJl/s2tfPo4pqqn3HOGgO1powPTT9
 4Ygt9FoNXGzqNFpGgDpaWYpdXR7tU/HAiYA8mWNb3zh/nxwVsSw8t787mAOAKge0LnVH6Pz67
 v9xc7vTW4Fp0zMtyCd8k5i2ke1+LrhERkbqe6TkdTkIdI3W9VcR4rOZBCH48kpPSwKhqB5A4b
 8mZjnCXG/mUYcPsBs8X31ELkQN/KMEo68XG+gMRW4ollVwWy6uy4TFBeXQsSUvN9PRWY8HfH/
 eq1nndA3EGBjbC/OWeeyNhzuB7qTOSdNcvurb2UuHjwmUNz2Ctr+2Db666Vbo3ZURkzVHSkR7
 mc1hW2PeoCSG/TLbRM160kdXKBcx7GO3SVGF5W9+wmKhnBJSmxJJWgc0W5sD3uaq4sBPby2jC
 mfoqpfNKroHgGHJVxglHomRBLbCsuRgn3gzgklopepExfTneRZr5y5pZ2rZ6apkpRSVK7bvlf
 Fbi8G4DNb+Bo2ho6OXdSe542cr2KTzvwCENxycfHjr5c+InumBc0U1vobLMdMd88UEQgUurfz
 nIa69+8AA7TgQu+U6Ykh0cUqJjR/hAjp5/7YcM/fP94da3micQVgEBbJrarpHs/RNShLXVw3X
 Nd5ccUZZFFBw9V6A+94Fv7JnGyhCPKHKKPJCpBCoM6+5gft6saF4D85sWqnfGVoL1modZs5is
 orEgrhP2ZdviTTogxkmoilvKlBLDdYVlQ+INA0BUuicLqaxoTPMtgYrN6yvg5K5C5GoiNG7tn
 XPPdWVUJsHHWND+8LJrEvbEvh4fNqX583yflbfQ2zZDTTTPANc1n+wlg1Ryf7ZmofNTanOwjc
 VL+Z+gjKUxv0Du8XH8fbz7vdRVU0DOMw0tkXt2s6JB181QXfxEmCtbhuFq5JMwQR62Gl6bCec
 KAqEX7srZQy2T51hbsMRjE9Aa1dNgngV3PSmp/FNltPxd7e852eyIxgP30H9ldkmLxMcPaQiD
 YpMum6p6OuB43eNmbgUj6gYIYWBZejAfdf7j9EkAzVu/IbQGHAA+mO2Kbh1q4h2xv4AylhFvS
 8n7JmQmKqAj770K9ZCxwe9vdHO2KpyvikNaJLCCRpEBvByTjijJdhk9BTWwsDvFy46jTO6+zF
 HQRlIKQHsPUeIErDY
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> v14:
> - update file system parameter handling.

How long will it take until further implementation details will get
any more software development attention?

Regards,
Markus
