Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6214C758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgA2IUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 03:20:36 -0500
Received: from mout.web.de ([212.227.17.11]:47441 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgA2IUg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580286022;
        bh=tQri1edDa91kqLteq8ZB5NArUvsgvHIMED+tnqAit8U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZbmCYLXWdZCT2u7MUK4E6UEbw6GOFyp5/JqSF+bf/ElTjE9TYrm7vme996pmTyJ6B
         ueF8lIUa2ov78e9n10pwQ7Hk2GjovPj36ivG31+zJ9hwoI4kKMMolMilrewz6nwbmb
         rfQ/ogKNXMFKKqBhOXm8t+pQGubyfRdwTlUV+nWY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.70.44]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1X9B-1jpWCC3a9Z-00tPkz; Wed, 29
 Jan 2020 09:20:21 +0100
Subject: Re: [v9 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <23bf669d-b75f-ed94-478d-06bddd357919@web.de>
 <5fe2d31c2f798b0768eec3ebc35bc973bc07ba1c.camel@wdc.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <938e70e3-0f45-2858-a4fc-dd90371e4e90@web.de>
Date:   Wed, 29 Jan 2020 09:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5fe2d31c2f798b0768eec3ebc35bc973bc07ba1c.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PLm4Glozz6oS0aLFLldM/En7SfLq1Lpc2hlL9LhSlqvSXqtmXLE
 BY7eBssOkysJKFEfih/3tAi5i3E5URrz1g6MLOyQb6YpYAS9UG0Xxi93zb7sYkTrRzhT8BO
 fhbFPlGZufA/XsS3gppL6LKWTAlEiVElX/Lj38RFcvMld9WJ430HSH8yts9a5L3p2bGGBEa
 feeL5yBA781dnYwluK5kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z7sqPbNLeos=:81AATFj02WUoLyVQO6W3dX
 t5V01gaDOXhBzyUIquL3o9bjFF38g97GdOs2+AL5qcpaBr3P4+pSPEExG97GDp+kCBUNBABs8
 gdITGLifKZeYouH/Z3nRzQBESvutABwBm0IwciHiPpFDwA4nA7qlA7AXNUYweK93HBW8Fr60b
 gl7+3S/Fb38+V4pkRkw0WThf3s6+GTL3sdyp9aOhUjKhe9S5eO7MRW8CYWw8xCdRhwkWxU+kV
 e29DWN1w2f+r+pFoXxqGyiOwF1J3ekTAlqAVjfuSuNjPM8/f1F3X9B7cyposV8Kd0i/kEaRp/
 EO7RYDb0E7DXEKFI+Yuzmp2Z6qT3/kgUJ91HIoteyKFlUhe2v9nSg8xk2YdTAcKfb6T2KUBD6
 kUMabgt8/3oNJLc1gRBXUMewj5NMsRPCDdBtgocRMG++4a0jxO2cW0XPuS8UH1P5CWVKbTK+k
 T1zmermha0HYlw+B38x68X9gsqLd7krfY4AIcX81QdjGM2cMoMya5yMPnx8t054ovY6vtFHXS
 4U2/LSdHQUzpsqqsJ55YFfbfn2XxaI9J+CIqA44WTwOM/9Ub8T8ypkLcTDtuI9u6cH7mYAjK5
 C2ccVFeMTGMwBGL4g9KXeDApcC53eZUndpGI2e67bJyxrEAqVMuKGNdWXuhlJoKrUmM3lWTxh
 MX5EU14NC6z+hdb8Pg/DnzK1blDJ3oUiHcscquDRnXGph1B4cRjPOcWPvyGbeySWBLNx8TMpY
 j0ZQJMUSGR5NL8KyYMuz5dVIZ5vjn0bj0N/5oaGfV22U6xZIRVm/6x8vTvmQHhsGHLbITAE/v
 /V5VRtTmejCJKH4Y7ZqHuNU+8mh48+8QywaRuC78KTH7geKfSl2Fu0P8RGkF8X9HFpbsEAY38
 DsVDunJdfHmUooi2XmKoHr5E9Ol4a3WoPKhUfl6KgNsah7px+2sWDUNbvUmjiEkjI8VrhxpX1
 hjNZHkqs/9YfFQqNI5pI+lSUsOjyLI69BykaLzTLMAtwkdIrPUn0GBV09PMd5kVy6ni3Cb3m3
 RzSR2HYjqHnm9eb96sxyaxKYhtQX9t4IDrU1pRnCfRt4yMI7qa+3qqBwbAhiIk4kZxwn23TVf
 zeW1ezQYNk+sR9HMOf4awPebXpYLZlGPiwU40FrYnPGUU/rWN/8ZAAf35Xe4Wz34hLiFamAtQ
 pwVHrZ5CzZ3mdyhA4qmDh/cRveRHLBg2E1c3T/uuje52n9QpRdMqEnj/g0aFsIz6VKCHoazy6
 pxjq1AlBGD2fr5B7T
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Would you like to reconsider your name selection for such labels?
=E2=80=A6
> Fixed. Thanks !

Will a different identifier be occasionally more helpful than the label =
=E2=80=9Cout=E2=80=9D
also at other source code places?

Regards,
Markus
