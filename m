Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556D01517BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBDJXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 04:23:52 -0500
Received: from mout.web.de ([212.227.15.3]:45405 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBDJXw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580808219;
        bh=qFFodg6FjTAzmbOWPLdYdtgK3Q2ItN0dlxBnaNp4kvI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=se0qgK5+LmvblxexiNDDoSl0sw+7Rl8PdHfSdGWYt22hViNTSxa8cwWIDMywFAxG6
         HlqEqKHhyysbFxW9zUmW6gzstx/vBvMVNhF4DMOzzvb1JqgCrhPH2unENmhQ0CuH0t
         ov3NwOxpjfjBTuBgBGv2fFWKuMvrvGTBvjp1kCuU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyOuM-1jeJoL23GQ-015nVB; Tue, 04
 Feb 2020 10:23:39 +0100
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v10 0/2] New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <b6046f64-89a0-faba-bbd8-f82c8809ee8f@web.de>
Date:   Tue, 4 Feb 2020 10:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pBoBB0tJqYGsVZuhA/IDWsJadO7GINgG5gK4Dkiw+MtUYmS1OBX
 XD+l3lhJuAK29e7GC64rvtizCPgSXNJh2P4Zf+svu14dNWTjxm70ih/uGS3ivWcljaVtLyY
 jyzOFjgahV6iaTHWk3WiinLUNplkAiPwapyJ9ilXGTK7QBmt8Y3My6SsHg3AjJ50Y3KAd1P
 +yuH5ohNoDjF579nLb0Jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZpg5oH4O8I=:5OQtx9akIUkZIctJbfbZas
 5JmPnBS6NwqedSpwTj8YYy8GKfpWdqLFaKewV29Pn3N4aLMSwxN8Oh7ZkzTpeGQF4FWPp5VCE
 ftWiaQk3QMQepvCF1VGuRaO8goYHFu0+WQZmttU+CrqNhiZHjA231/nMmN6L75raX/Fs9HFm9
 9lEdr8CiHlxw8VtoZw2uQS8HJgGuKaozPJMRWy4G1SXNWtJ2MG6kHG804U2UT1yKt/y0oycvM
 w/PDKxB6wxgoKwKgC8j+fRBQgvMYNwVkgZH6H0Wv5Aa/oCOUsI726nstaHa8n8kuOxvcUrrEw
 XYlPw9ps3XGVrbBRR+pjU7WEwU9ZycvsnRRa/QKlk0LbqqHpBRCEnSl0p/P9DQb7jVDZH9RPr
 PnGgn7/pAi5K0nfOwmPr5e0enu9dSq9fCuBt1JD5hCbpewL71ERkw6hqjQCi1Fkqjewwt5G5m
 BQYYueGJ6GDx8B26j/4uZ2uCdLaOv9/jS3XKxq4l+Xn+MBVcxqI9duxByeXr7TFPCbPPegiBy
 DzvjhGHzjmJtuZCVPb5+6IU8cHl24iKhXH4GRa+23E99dyumfT1JKjwGUWKiJx+apx+VgSLtj
 NYnS609Iz4nlhKljGCe21BgUu/2c1xoICOq1zgyHZtPa3u6UQBgkBDnsduSbQWD+kTLjFRhGn
 Gu3e+uQVjADPEcGYVf8CE8vOEBhmP8GyWuj1JEKK0s/IsJHVn94kn9u5XQ21T6am1/KNPl+CH
 WuG89qF+rih3o4jnkfrO30Bt5WAnP+E+9NxV0DuJSpkh6jHTWzMP5pHxaIFiQk0lc956pGWOc
 aFieQy6krWAB6EK6zvEVCnAAlv/xGrW9hxvC+xq7GI2kBIWqf6T2gbWEmwSF2dFXIbke8xDnN
 jWwauZBwxtYNQJto/sxufsji+VVZDOoPJ07bMASv0I0JIpGIVvLxNI3oYGWKh1tmeuSiHyK2b
 2Bh+huHzg/AYhrXRXLQs95cAwDqWR87aCKAsD8FqjsUYSAufNjocPE8z3Drpnub3P36KO4iST
 K67FHp3sRnsiDTKuMmjRSFqizC5y0UljeFjcAjVIkgi4BoabroJu4hWTxYFOGmikUF5Qn8S84
 Upr822LhisdKn5rpYzWInAWQtbSYC9qJs8jbT+ZPaS5fGJX3U4aKYYiyl1/UZmDwr9mn2JE+O
 EzwgtxjEDMB2C8IOG8pJILtAecmoLrWqTD2RM+I3KBUYtpQsqJtnF5pTE88Zklpqokcp6REgJ
 CEULoREhe4rSwWciF
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> zonefs IO management implementation uses the new iomap generic code.

Can it matter to begin such sentences with the capital letter =E2=80=9CZ=
=E2=80=9D?


> Changes from v9:

Are any more adjustments worth to be mentioned here?

Regards,
Markus
