Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459403E16CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhHEOSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 10:18:43 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:32944
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240231AbhHEOSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1628173108; bh=9+gSHMwzaMjedHzJLR+xBl2EvJdH5KdhquajRHszUs8=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=iqYjydmxYrP9R7WgDVysws74ul6IFqT4Yhvflvo+mtFUFwnINb2xv8diKYzM+2A8XOpLdcmVeEbWTyoeWOMQ8Y3Q9nDVe5mjQPfg5dOs5iHBmnyzYuAG8YzVhQ+FWfuzoW1daJlCwB1i5lxll10oiOzAdBBc2WyE4cQjTBWUJWXNizbqeXMNtgPuevfVN01/bxgPE2AmU2ujWf0y9xQknDwIUp77zbxT960kAyBgUmfacc5S/YmlOWDdPUXhcNbB1uZ5hOkYxa1d6ZzxgboQAJ1IbnEIM9E3IP7hTXGlpkEFpCZQDUKz25jRJAcHO05JUOGIMsvhoRLg+TuxeJ2HYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628173108; bh=KWUY/0CFxvN8ajb44suJ5QB4cYSABSsm5WF8Oy+XtdT=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=lCY6e+wD5Xx1TYPQrrzkxTNriSyTJ52hLiO2+FisY7fiFPxPs3BT3oltwOu07FzM+YoeGaDSA5xrNgtKB67aMk8jIpj9fnwc0I/mUgllsujrZn/vezMA7ZEMpQeaDrfw/QR9oUtwViR5RdBa/l2PnNm1UD3gYZuTR1j9MJHpaTjvFzucCzlKklCUXwU5YRY5m9wO0q+TFOpBxtkqXZXmuph0GwEgZkDqDJosPrTE3QOmVlJkBYuUwnj2iBnujPj+bvaMBUg2o6xenfZ8cSanzkCXn9ZIG/zKshTSPOvzBuU7XkzBMO50kkh9AReWCzZ6ff54YSDejcf5pvgmZQB0Gg==
X-YMail-OSG: Y8Mqda8VM1kJRYyAgQWph5YbVZ1ybUQK8SUdrbvfp782LwLqpyTik7J3NZIoQEm
 9Agb03.7wFW6103gvtnWLYpW_pd783NS82g2G4lMk8bI7LdEFDJlk.SbtBHdiVvdan3GNOaUuTdY
 W5O2giBztnaOCXdYohMR.9saOMQkA5xBPKOHj_IZALWW8GqG4dGe23zUdfp4lZneDpOcxzewXdjE
 eBl2hm7fl1_Ta_.HAuct252Q5l2wpRonFs_a06276rzcfTR5_7hHDcvffO8iBfhDl5ooET4Ox9rb
 WiF1i_OK4Qk_Xc7SWG9yjTMRQMHrKLyeXuVUnRYLdzXTRGSLJtLqVUntXsDYKsrlcAcTriyTVQ9v
 zzc8XZaF3YSy07gtb8NSpnlSeZhtZVscEyLck3VsAZXZPTlBS39hCgwYQ6AVNR8KJoOj9tbuyKiS
 YMizY_b_.EE9FW9UiUEiogd2z7cwRs31ejJa0g0Er6mL2ZFBw.klwvho6eKEnvecBm3cylivwNqA
 2RDeHDcZ68nNpVj5pSqyt1d7rtnBjOvKHD9PtDsvTVt3M9A8yT9s64AuI4qxzPA2a1OiOl6Vb9Fo
 2uQWfVSW074trAqL3BnVSEZ7SZ8oJjD0eas7_Mz5AkgzWpx_GDDvLpa0YF3tlZYP4mD.ceqxu4S6
 Kxpc0t4ssqi43eyp76rYDchuP.pvIDWUQu4NJ4WbRKDHhnyXhs2Q8_F.YhEHqNxG80YwQC81lj5r
 ZsnVn84LbAiS3UseNRK0D2NzFyTzTLi6yTJprMxlMSO0hgvoEyU0TLSoOtLA8Dbl6fJ.j1G9i14o
 ZYkfM1fj11FUcQTxjIEq6MwqtiBpIWdImTtrk5H5I20TELtDHNW2SzXiGvqXhbZVuZc7DFgKu14P
 76LLTmJ4X_O3Q4jzjci4FDX0N1ZIHs.zZJCAouqqMn6jqOv9gPdfZiu0x8Lv9xYt0gj2FhS.NfZb
 EEbpcazrPzxjAe0K7zFLLnW0QK4PMnTREnQZg4TLON2Tfq3TyhEsMaHHWlNPoVI6Tvupydh7JMfV
 hJ1DUH0S.N.ScfRg.b2KNG34Nkw8YJCTMq6XZBfvDyKrrTn7jH67bgkwJlj2JL8dkaHyuD_2h48s
 l2fW50csxIU.eS9yIoz.qypVaa8gONNxYrxOEfBIYbXFL8QbKvY.Qt.QdiZyhQ4_lHPq2gnEAv0r
 AH6CAFmZo304IrdjlapA40Wnn_mWFw0P0AUODpCSgExoOd_TEF41np5YaZVrYaUnU3e5BGX08ZxP
 4PDXLZhjXQg89ncyL1kZvN5aEHYZ0AKVVDrxUcJBW62n7obLIPwhdmW6ETLhxxdy14gMouK2jbdl
 U0u4mj7njzISGBVwPiT2cUj3RH1nhsb_N1yCWhScRIHTovCjmh__zarUD9JIfiuAhMZYKMxLetqk
 uxvwVP1SupmAf6VoikdOc71RNUshCU4k3IXHQM_u.IZefsWjIOnDIWOCI.ORb_7rfuKNjNcFwDKV
 iuGPTaQOWYkrJWBHItMujSywoi6r_oO7Ms3I0GKpL7ylZ5uD6cWzTM6rG9KA703pzVCOggCibmr5
 rqSTDQXBsTOoBYIJJ73fgxSRp14eQD9tfeWN9JpJH9W_B_e0oudfLiri8t8pA7b.iB.rRH7AEsOm
 VIYh4VwZu4s04PhbKMApKE_f.E2XzK14GXiHtPkAyE2MhfpW_Cdi.WvUXahxYtb7JIk_6PxkL72v
 IxFQ6PscSZ2J8l4Dsjc5VDDlEbnpXCU6ZT2lEiWoO90qokB2UfNpUXOX0efma2hFoadHHR.mjMmH
 HlV12HwEMF2aGJvC9qmmbPAgnB.R0Km3oiPEi6vYf34Ce_duNGgOcUbSASLYHHrqInaE13hBo5I.
 XmgnT_n8rcH7GiPKQleXWO.s3AN9DEL8tAmBUr3tPLAYhshc19A.Jbq4Fn4GUCMs3D5aKI0T26gv
 ogNXbtYWAO5WpOHW9U_WMbjVCk5rRTVW2EoTXChU9jBE8WuXSONIhncZv4fbKoXJ7MacKKqvO0e8
 se0sKyEEjltIIwskxmE7LgFlTDrcEfMsnuRqSx87_fc1jLk33C7xOhhpWrhJxIE4ZDYsePEml1Da
 eZ1w8Nu28fMqdJVpjB.hMWHcmTZPGsfrW2VEwNyH6NBbH.l8ZzYsOjg2RMrMKTvjzLWlmPyWKiNF
 RCO1e4WZp3HT.18_.gyknisrb9byU74B46cQ.5gjtva0dRT64K9_L8zzEzFzJmIjP.Df8i9PEMpJ
 VLLtTVPKO75NCmEsQyoWqHaOGEuZW5BWxX_LYcUKCriSIV54aoGsNnmzBWKRCDfw01pJgoCslIOV
 WY9KHRPUMLttykJGWLkiVj81QY_KOkCaNM4PLxBCeSlbr0yW4RXRYlDXU2abqJ_furayVH7YmyV9
 OS5ip21KYowZIhmCEy08Wk_jomNJQ221Qi5f224E9BjdF899AG2a.dQ9an9itCA9YO.uYXYedEcC
 haiNvmDsOBrYQ4IZqX8sVdBCcghhRXdvRmOnPbn3L_vqMcQY0RIkeAoKVbOFk2jL34f89nDQM9Ys
 zMrTp7a02gzh.3geZn9bNykh7zKBs69RFtt22RS5qDNGu.H.TduhUFZXA8URGQ2wMQu_0d3n9r3w
 AXAlCos_TuthEAWUvljCAaLrdVEA_gQYmVN2xrRXt4zEbfxSYPhOeoT_INN6I4ZB1es58xlk1sCS
 sN.R8qujdpbIgCXJ4gtEgXZhdUAcKcpQz5Wg2J2roA0FodBHF.sus0y5vCqODdVU0PuVceu92SLs
 YxUFTWncCN3Q96orSoO7jGmMF8LWvCIoYgCPujrjufGSbXtiLH1a2YNj7j1M0X3L8etnf53mRY6B
 jSxLyTyxHfItZ.YZLi0V5Td.kGF0n6ie8Bri7eaj5rkVhssmirQHJtQTfEWpHBe1jiPBSQvHPvlc
 X_NyaR2siPuBMHY4sTT9JYI3xFL4PrsjkyeQjYPk2WrHJABkGZEGhlnYyUQLpW0Cq7xyCglwhRuX
 dmDp7u5LessLJWW4gyx2Ajmq5vPsreITfQMa7orbyZdiOcqh3vvgKxhKIZLxOlZ9HhV4KM26LOM6
 _BpHO9xwZQ97JNEuiSVY2uF2pEtK4hpMdL6QgIzoWNUMNXXuAtvkBdshzoxch3ftcMUDPD2rMuEW
 Lf1krBmOyVSH3eqrmw24eWRmuO3j7eAT828kuSKSLyeN9t6QGP1ihl9YJ2WPXxzsTDvz3lrbJLza
 R6KjcItOJQuz.RQD3gf6HjQAP4hH4Tsybr6ZLlg--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 5 Aug 2021 14:18:28 +0000
Received: by kubenode544.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6934473a6e897de19b3adfa8f92c3920;
          Thu, 05 Aug 2021 14:18:26 +0000 (UTC)
Date:   Thu, 05 Aug 2021 10:18:22 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] pipe: increase minimum default pipe size to 2 pages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christian@brauner.io, dhowells@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.or, linux@rasmusvillemoes.dk,
        nicolas.dichtel@6wind.com, peterz@infradead.org, raven@themaw.net,
        torvalds@linux-foundation.org
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
        <20210805000435.10833-1-alex_y_xu@yahoo.ca> <YQuixFfztw0RaDFi@kroah.com>
In-Reply-To: <YQuixFfztw0RaDFi@kroah.com>
MIME-Version: 1.0
Message-Id: <1628172774.4en5vcorw2.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18749 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Greg KH's message of August 5, 2021 4:35 am:
> On Wed, Aug 04, 2021 at 08:04:35PM -0400, Alex Xu (Hello71) wrote:
>> Before this patch, the following program prints 4096 and hangs.
>> Afterwards, it prints 8192 and exits successfully. Note that you may
>> need to increase your RLIMIT_NOFILE before running the program.
>>=20
>> int main() {
>>     int pipefd[2];
>>     for (int i =3D 0; i < 1025; i++)
>>         if (pipe(pipefd) =3D=3D -1)
>>             return 1;
>>     size_t bufsz =3D fcntl(pipefd[1], F_GETPIPE_SZ);
>>     printf("%zd\n", bufsz);
>>     char *buf =3D calloc(bufsz, 1);
>>     write(pipefd[1], buf, bufsz);
>>     read(pipefd[0], buf, bufsz-1);
>>     write(pipefd[1], buf, 1);
>> }
>>=20
>> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
>> ---
>=20
> Is this due to the changes that happened in 5.5?  If so, a cc: stable
> and a fixes tag would be nice to have :)
>=20
>> See discussion at https://lore.kernel.org/lkml/1628086770.5rn8p04n6j.non=
e@localhost/.
>=20
> This can go up in the changelog text too.
>=20
> thanks,
>=20
> greg k-h
>=20

I tested 5.4 and it exhibits the same problem as master using this=20
non-racy program. I think the problem goes back to v4.5, the first=20
release with 759c01142a ("pipe: limit the per-user amount of pages=20
allocated in pipes"). The issue likely become more apparent with the=20
improvement in pipe performance from v5.5, whereas before that, pipes=20
were too slow for the issue to manifest in racy environments.

I'll send a new patch with #include lines and a Fixes: 759c01142a. I'm=20
not 100% sure that it actually goes back that far, but the worst thing=20
that can plausibly happen is that applications opening very large=20
numbers of pipes suddenly use slightly more memory. I certainly hope=20
nobody is relying on pipes randomly blocking roughly 1/4096 of the=20
time.

Regards,
Alex.
