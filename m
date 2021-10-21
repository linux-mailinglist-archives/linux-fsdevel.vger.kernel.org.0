Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6900743629A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhJUNTE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 09:19:04 -0400
Received: from mailin.dlr.de ([194.94.201.12]:52009 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhJUNTD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:19:03 -0400
X-IPAS-Result: =?us-ascii?q?A2GJBAAIZ3Fh/xaKuApagQmBWYMLgWKaDZdkgXwLAQEBA?=
 =?us-ascii?q?QEBAQEBCAFBBAEBh1AmNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFB?=
 =?us-ascii?q?AEBAoEghS9GgjUihDVRAT5CJgEEG7J2gTOBAYRphQ+BOoV9VIoVhBABhX6FM?=
 =?us-ascii?q?ASNFsJ7B4IJgTGeXy8Ug1gBkhORMZYNoHGFCQIEAgQFAhaBaASCCnGDOVAXA?=
 =?us-ascii?q?g+ccIEsAgYLAQEDCY88gRABAQ?=
IronPort-PHdr: A9a23:yUGs/B/w3SEI3v9uWRi8ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 AqFv6sm0Q6BdL6YwsoMs/DRvaHkVD5Iyre6m1dGTqZxUQQYg94dhQ0qDZ3NI0T6KPn3c35yR
 5waBxdq8H6hLEdaBtv1aUHMrX2u9z4SHQj0ORZoKujvFYPekdi72/qs95HNYghEizqwbLdvJ
 xiqsAvdsdUbj5F/Iagr0BvJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4U
 KdXDC86PGAv5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7S60/Vza/4
 KdxUBLmiDkJOSMl8G/ZicJwjb5Urh2uqBFk347UeYOVOOZicq/BY98XQ3dKUMZLVyxGB4Oxd
 4wCAvYAPOlCs4nxvUMArQakBQmjHuzvzj5IiWHo3aAhzushFRvG0BY9EN0QqXnZqsj+O6gOX
 +6v1qbI0SnDYO1M2Tf78IXFfB8srPCQUL9xf8TcylQiGg3KgFiftIHpIzOY2+QQvmSG7uduW
 +Gih3M7pwxsrTaixNshh5TNi48X11zI6St0zYAoLtO7UE52ecOoHIdKuy2HNIZ7TdkuT3xmt
 Ss50LEKp4C3cDAXxJkl2RLTceKLf5WS7h7+VuucIC10iG9jdbminRi961Kgxff5VsSs1VZKq
 TdKncfUu3AW0hzT9tCHSvxg/ke9wTqP1x7c6uVDIU0sm6TVLZAvzLEwmJQTtkrNHSj4ll/og
 KOIeUsr+/al5/7mYrXgup+cLZV7hhvjPaQqgMyzG/k3PRYWU2ia/+SzyqHj8FXkTLlWlPE6j
 6rUvZ/AKcgGqKO0ABVZ3pg95xqnCjepytUYnX0JLFJffxKHipDkNk3PIf/iEfezmUyikCpxx
 /DJJLLhBpTNIWbdkLr6YLl971RcxBAuwt9B/55UEK0OIOrvWk/ts9zVFhs5Mw2yw+b6B9Rxz
 40eWXmSDaCHLqPdr1uI6/kxI+mDeoAVoizxK/s76P70i382h1sdcbOu3ZsNZ3DrVshhdhGdY
 HzxkpIPCmsHoAc6ZPLlhUfEUjNJYXu2GaUm6WdoJpihCNKXb5KknPqnwT20F5lXa35uBlSWV
 3vlIdbXE8wQYT6fd5cy2gcPUqKsHtdJ6A==
IronPort-Data: A9a23:TCcr8K5HmbFg0qzpCaU6YAxRtKLFchMFZxGqfqrLsTDasY5as4F+v
 mFMUGmObvrcMGX8e9EgOdy29hhSvsLdxtVlSlQ4r3swZn8b8sCt6fZ1j6vT04F+CuWZESqLO
 u1HMoGowPgcFyOa/lH0WlTYhSEUOZugH9IQM8aZfHAuLeNYYH1500s6w7Rg2tcAbeWRWmthh
 /uj+6UzB3f4g1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW5
 gr05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkQLb9crSiEai84G2PQghUh/lBzOv+5L9
 I53trurWwIJAI2Pqe4bXEwNe81+FfUuFL7vDVyTnOK96mzjSyG27sVFSkAwIZcRvOpzGydC+
 JT0KhhUNlba177wmenrDLM27iggBJCD0Ic3k2Np0Xf/EOwpSJTCTrvi6dtCmjs97ixLNauPO
 ZFGOGY3BPjGSx1KInYxWKxvp+ChjV28bBB3iHGsjoNitgA/yyQ0itABKuH9ft2MWNUQkF2Uq
 3zL+0znDRwAct+S0zyI9jSrnOCnoM/gcI4WGLC2+PtrhUXJnGEDA1sXU0ehqL+1jlT4V983x
 1EoxxfCZJMarCSDJuQRlTXjyJJYlnbwg+ZtLtA=
IronPort-HdrOrdr: A9a23:AW6uCahgqgOdTawxrzlleRnnZHBQXgMji2hC6mlwRA09TyX4rb
 HSoB1/73TJYVkqOU3I5urwXpVoLUmxyXc32/hpAV7aZnichILwFvAZ0WKA+UydJ8SdzI5gPM
 5bGsAVNDSXNzdHZK3BjTVQfexP/DH7mJrY/ds2G00dLz2DF8lbnmBE436gYy5Lrf59dP4E/T
 Onl696mwY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.87,169,1631570400"; 
   d="scan'208";a="59637940"
From:   <Azat.Nurgaliev@dlr.de>
To:     <linux-fsdevel@vger.kernel.org>
Subject: Turn off readahead completely
Thread-Topic: Turn off readahead completely
Thread-Index: AdfGfdxpjOk8ymokTbSOj+D6SC4J2w==
Date:   Thu, 21 Oct 2021 13:16:46 +0000
Message-ID: <8aa213d5d5464236b7e47aaa6bb93bb8@dlr.de>
Accept-Language: en-GB, en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 4FCDBC6963BD3DC2CEC786D70BB33D9126CF53FAA534CED031CDA00364D96CF72000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone,

I need to turn readahead off completely in order to do my experiments. 
Is there any way to turn it off completely?

Setting /sys/block/<dev>/queue/read_ahead_kb to 0 causes readahead to become 4kb.

Thanks,
Azat
