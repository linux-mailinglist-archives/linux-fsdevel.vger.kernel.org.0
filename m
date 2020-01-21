Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85E014423D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUQdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 11:33:46 -0500
Received: from mout.web.de ([212.227.15.3]:37675 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUQdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579624409;
        bh=vkUMqMpSzQWOv5pE1yPpsgTJ0TCaAleQhLOhszH9RKE=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=IG+eWre8/eVD3hdJl6Cm6n98ehw26rmR71cdSjAmLw50tqen4gJR4APHN6xo9NxEU
         TuebV/NHdwOs7QuNImEfjFksN0EpsGG9ewQ27y2acRBWymr9yNeSWuaEYTrmkIG90o
         3ppWDsdfK01E9HiUXrzGxXgSj82MeLNZdgDeOOXM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.33.93]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mg7Zl-1jEe6v3ADV-00NT1v; Tue, 21
 Jan 2020 17:33:28 +0100
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v13 11/13] exfat: add Kconfig and Makefile
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <44d81272-60c9-72fa-60df-20282c370a7a@web.de>
Date:   Tue, 21 Jan 2020 17:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Y+PS0ccMxadJlzOXUYMJtQPr8NqZAA65HUWxMTCKqUKeZoA4HCS
 fezep9iJ1B8CLt4oB1Rp4yGQlYbkorl444OTCoae/VF9hEkY1w7DV4a+llFarBI5h58VtPo
 YcYnS5d3ZbAWKCLoTTmdFbgdn6IAjqHzYgRZWV9u44l1F7YvdToyn8hNjAZecFlolVrGyAt
 0uYpYI7x0herbiBML0dBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BW3bOvImGXU=:FPRnOMCeSaqMGlIAhwgQFF
 ttgS6BlnPvH9iaZ5WW+qk9a9rNR+RJURqrc4RTa6ZUp9utxTMWn2mDXQN7kBmKHYp5r4aZLBS
 CKbsxqAhJKi3f9E8Uxmh4c5ZnDq7lCnZv3t6jwW6XgAoNztRbrqLNe8qvIZxz7TgBi9N6xWCb
 8RrxU+p1rLmCQnalzsqMiuV/nBHdoQ5FoYBo1y2Ou7Tfu59xP2G8SRKIxJGlYUhj2r2mpwcF1
 Q0XBSaDYSJDO8Mr3x4ZUOByZA7Dcmaq3uX31ApMZE8a28O1yYZKANq+94MqvKUw4s+mzLyQlM
 EYM81IGABpxa+7zggDyTMT/TAM6Yy0sDF509OnPIYfbhUwrJFPKImUfwWLv7liehPLBmDRQcP
 6lqtzZDR8mK6r61Cczst8Q/00s/J63I1Onl3Cwg2Nr+F/BrJk02Kv9WXuNn/kkI5/OZeVbhga
 DwZBC8Niq5J0Gru3Q+ioU3BnwJhcZ11YJG47rvKeZXvQudjjLTUoTAeFo8IIi30sYG05HI37V
 o3yKJdYBR1YssnvaaRRtPVpoJH88nuvr4JT4/6lDhkM/CTxVcJA7Lsoa3MaqfepXBged7/bNb
 4B9gPQK2fvui/RqAy7ZbbvSUkZQ4M+zghjWB2fKNv4stVCKG8FVv7S03aRQ3lTcKXJ6zb0UPI
 FPgewWr8fdW6nUXnvzpDP8BMCtLptla8AQQYfpuN0epznm0h3QBsqIF53rUCal0sNID7NozmP
 /0vM1drcBuI0sLFhGP4kxAznV63fY7iZr2cdF//XSuGJsrN1M985bjuk4XOrNGLoS9wO5opNv
 24d8riQYxQIB+zbyBV4Y+DfEKRjmJ6j8qzljVDroQeFlTPrWbrKb9+5MdSZbbOhoZJpeFBxXv
 u/uMTDPxi+QBcVr2G7VDiRvtFEgxOSKZ0TyAQSTHMPtXfnV668AbL3dNAHLScfb2GbFpGW+gL
 5HAXWcejzL1V6HnSZm8DtPbYfQR6YC5WDLJpdFbwC5ygw8SNVi/ZVCv7BvPEzFynJbVFIHiGy
 1y2W4aVCTpmMOWygO92uu+0JIBZmZdMl1KtqxMyrN2X2eCMDk5nLUh4nyyTbNFW9WtAQkTVqm
 87/gUcoi+0EiVSbOAPPVOMHhUbUNMUMUD8q+59F/he5T5AWMSIVplcexiJyx4bFfDpwH06M1r
 VJ0P23rYw1WSncnvlNs/Ug4m7T2Cw3cI2mee77HmRy3m9b1lauqaItMR0dN3nkTX1Ag9W9WqR
 omPKVcIR+FIcFmBCC
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	  converting between the encoding is used for user visible filename and
> +	  UTF-16 character that exfat filesystem use, and can be overridden with

I would imagine an other wording fine-tuning here than the replacement of a dot
by a comma.

Regards,
Markus
