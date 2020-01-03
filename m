Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA212F500
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 08:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgACHiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 02:38:02 -0500
Received: from sonic301-30.consmr.mail.ne1.yahoo.com ([66.163.184.199]:33453
        "EHLO sonic301-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgACHiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578037079; bh=MJdpASvZnpj3gXKZxrNskiGAl+hYYwdjGUMDZ9fMpsI=; h=Date:From:Reply-To:Subject:References:From:Subject; b=QSzh+FyK+PQqbNd1K5cuBfArUFqLiHiJAQkXv9ezOJqgEXC8QGQMQgZAHUyU4Q0YcLWtuY4D2Sr0/dr6OjadKmrFpRakTwV7xCp1Dw9f3Q8q2/NkQ+4lnuwCSU6ZzF+/SD5BmTiB2snpNWbd/vjroSKHRXVe13Ijb3DEHq61gm+41ZOBxaPDbGxUDpkZ8SREJ0VaTp1sKxjjUlqQ71XhzeDKepMbeP55ACCKICPw3k8vC84jh5JeEVKUf4+ADYt70sDmqegTPKmZMC9QOWyFjc5PX3rjn6/D10NDWKEFrjS7h/8J9Y+dKohuMDQAzRvoNR6eF6qw7FzJN6TwUm1t6Q==
X-YMail-OSG: yXnmVBcVM1nFNSolob2gHkbHPZ3yfZSyZjIbiwo.24pXbh3OORIC9CiEzjjKfH6
 8rSqYYnETRF7LhGLdUPzfYxNL6Gya8Ka3CCZWTtjqUbND6M5a2wBG3Y7vYCztdFqeu78uLMNZC5m
 b7EeHWZ4xaoadYgjjjfuitcXMc36jsOezDOKkecQ9TRe6DtHyC5EvQqVsYwapO8tlf4JYG6EG.FO
 fpu2auCbIRLs2MMA4vMibGMiLjZrSyX1kCZbgDexAdD_u8b6KDCrEjd.8YF8F5qs3Fs_VGdMsOR0
 jZsb6E8Efoq_Si6fVJggXbZQTFHf8MpBVXhO5euMma_ZBUlsoQi2o0U1Odi4aNmPfRfOEgmR90h.
 jdRum8_.6VtYtI_pOGkH2YCHRtFFd476aeEECdrF.AFtyXeOxs2o7H749gRc9BNV6sXxBwgMOj2E
 ShP09eiehvu.hKrhwu6x6yrDIIpsTqX7LCK0nHuyzZs1uvNd2EfdAbHabW7zBrJJLPT5PaIY4ovG
 p0Szss.hm_6Pz4O9p5anMdPoK43XMHT03yxf6swDbirj_O98EUYSPd9C6B1LXMD0iWHjuSl4tu4z
 GIkIvc5lErAM8tTr24dgvhNxDUiJjvDKO8aA9jRuhSAko29MJ2iRVxJezRLqhuWEeVdzlkskH9EI
 ZD_4G3.v4_qxcPOSs4ITL4lFHkQ3bJ1Y3Sy7rM5os5jjdtpUycMyD5TDpD__0Zyv.rpIlc3Kp6oq
 ina.QJE1E6rtxYYhIcDId1NSX8jEd6EvQxUOBktCleihXRVNPm2g0PWI_eEw1eFFFD7gOcvtR7WD
 BH75SicEpJ4UxtblvYRCgbF4nBbu07TsJlDBqpoYhXjSllQlGGLt66pzu0itIp62Il08vY2UkuvB
 47aUc1oLbRxxjU.ZjgJiYHzj6rspZAMCHXwdber4wpv4kbkhO7B1ErJ9czk266z92WRVUmIXubFy
 xoCO4fNiGxGSeULLlJXDzuatxKFNeZOshtAHHZsIYIpy8hqudstdD960GzqSzolnSothWFrZ9lPk
 fdpDXQjhh_Bhq4AyRjbclegvE0E2Q6oVs48sZAx4e9.9jOD53UK9T51iW.8Qg4gQ7WDyjiFU097R
 zRDteTFA2hFNqSihVhw0S70tRmOJUBWFF02lceT0zzN5czDm.R0ujSijrvskZZ8FRh6voapbwD2b
 2ZlGVZU0NAjdPxBL5xsAIPzLSSlYf_w7Z.xyZ7MCtzl.LRHZTR7.FX2iNvzladPYgxttJZOgLMCI
 m7qk3S8Vtp3MqstvSjUF8K5e9axmV8qc4Htq4lQZhpUQ8zddeP2QVwyQbhsfIP2LKdUbWexqI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Jan 2020 07:37:59 +0000
Date:   Fri, 3 Jan 2020 07:37:55 +0000 (UTC)
From:   Brian Gilvary <1brian.gilvary@gmail.com>
Reply-To: gilvarybrian@aol.com
Message-ID: <466166173.6197256.1578037075711@mail.yahoo.com>
Subject: Happy New Year For Our Mutual Benefits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <466166173.6197256.1578037075711.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

As the Chief Financial Officer, British Petroleum Company plc (BP), I am in=
 a position to facilitate immediate transfer of =C2=A3 48,000,000.00 (Forty=
 Eight Million British Pounds Sterling), to any of your nominated Bank Acco=
unt.

Source of Funds: An over-invoiced payment from a past project executed in m=
y department. I cannot successfully achieve this transaction without presen=
ting you as foreign contractor who will provide the bank account to receive=
 the funds. Every documentation for the claim of the funds will be legally =
processed and documented, so I will need your full co-operation for our mut=
ual benefits.

We will discuss details if you are interested to work with me to secure thi=
s funds, as I said for our mutual benefits. I will be looking forward to yo=
ur prompt response.

Best regards
Brian Gilvary
Chief financial officer
BP, Plc.
