Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51AAD585A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfJMVmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 17:42:13 -0400
Received: from sonic315-21.consmr.mail.ne1.yahoo.com ([66.163.190.147]:43979
        "EHLO sonic315-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbfJMVmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571002932; bh=AZDKeY/KduJkitky/ovq7oNAqmYov3JYHc+M1QmYqnU=; h=Date:From:Reply-To:Subject:From:Subject; b=WLqD/BceALicXFQ2HysQF+M/1T5kXG6DQkeO3gEWhZd9ATBJB4ste5QP6xbqGxCwD4k1BLIiAURoPaxn6zY+9kQSt6PvLwDSzlDg2R8QXr5Q06eA7scLQLOtSeGT7UsT66IqjLNmSWGkGcTNyFi8X6SFOZrlM5LGd/rYtcxOsUm23rRMuRbgwMJuusTAMlYSxojHho1RaqpVGDrHNSpv/PlQ4mkk1o97uE3PHnRJiIJNFZZIROhlJBr9KYwQxU46vJze+wxtj7zjLcArsB7JCSCEVFg5dadJbKTF6Xc1QgmnVhWibao52JIGbHoiucIuvIl2GG0WXq+teaC45SGF2Q==
X-YMail-OSG: 9SN.jO4VM1m5UBqEhlFxOzSqph_GFnNCQteNFa5xKuNdyg7syt6rYQvFEp46mn7
 BHb1IIQ2eAXDxN66JKdSiPGOFJBSjVCt64qjSZcZM7xeMVacftlydN8Y3q6TX2SYJjG4jj5OGZIj
 BDGO6n3bZ5tofxetPHBUlG6qnagQBrMqqjDBGXal.1O.nDUREPNKLo.b1IaZix8k1MH4nrv_ABPV
 P3.oY41hAgfL3TmeICs4oDFu8CFA9WXuqfxn2eAPEyyfeLA.efQJx7hqhkVsYWwyXQhOSRwg6.Gi
 mOw5JPxqA21DSuVr2RjoiZuhvwSauIyhjskh0UtN0UEdUF78raZtDubJXPBGwUYepSYI_OHDnPsP
 pj3olL5dn1tKw7X4dZVYN_UeorMp62fEZ5DVsinrzXR9c7R5iNS1KeaU9sVsHxHQTE10s.xJydcU
 3A6Y3W62mRdcYzMPqAGIaLR6JD8MkpWjwKlcIV_84lV4ZAliIBPmVIdYCD32q_fTHTiEoU72cG1n
 lH74WZFZpojxMKRGpoaBioEqULeL_yVjO56.CXdPb19zymHffYdxkSMFb1FNKr22k6AyHxS9lKOZ
 EA8iq3BVhP2hY_M95UpV19gZRM2hv6ddyFIB8G0FCRpwhE2OjS0YaQq1qrcssQyHSQyAgunUBkuq
 Jq.qntn.qJGIzVsxQmSPD2BtXBnPOAOS_OF3YEy0wtjE_gvVrqrywOneO7qnyRuZJDeng3m64UqO
 CxPzOfBAv4sqja1PvA4NoETwD0fLgtQjs53v9GSN4Y0W08rpTGdsB5pcsYvmb49Xh4PLEESXIbg8
 a0GdFpW3AncxGkvTO6ev720Hs5mbkYjzReaG2cP540s9ZHP4knd7QVbhdyXT87MYrqJbdDPVD8fV
 JEsJf4LcVaQaIbYgnY2lSQL6yxHZMeaFzRMbSGDpJ4.ooW6iI7E6YiiAyq5KxPQB4WhU7zZ0diF6
 E16G6hhR_a.GhsDzpDeWRD59hIwutrQoaMZu42QPKXvuSlXloARtIxCD.l.WrUUM4S88xlwnlwrz
 3z2tr6PoaFwSHDtH_HDqHKnIQkXOv1Mt0nTBlQeyOWoEbS.2.hb9up1EWv3DtjQIFQiShXG55Shd
 ZdxmVu9EHHg7ejoHN2eKMsAf8EY2bJU9zvKs19kpNJL1ESFCPBCX3Y8S68J3FtJ0RMUlaTRNVje9
 TfJJP9TMX8lguLzgifqkcTMrcwVD3CZQ.VKNlg4xe9COsYZLnYr9C8yJ7z_mit8g8B7iQAOkbGi.
 wbY8Yn.iRqu6R3O3rkg1y_0VKj26jjyA7Ka5Om2IzaCHVNcaY.UQFrA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 13 Oct 2019 21:42:12 +0000
Date:   Sun, 13 Oct 2019 21:42:11 +0000 (UTC)
From:   Lipton Davied <barrsterliptondaveid@gmail.com>
Reply-To: barrsterliptondaveid@gmail.com
Message-ID: <1726240534.968324.1571002931214@mail.yahoo.com>
Subject: HI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Lieber Freund


Ich bin Herr Lipton, Rechtsberater. Ich m=C3=B6chte, dass Ihr Kontakt mir h=
ilft, einen von meinem verstorbenen Kunden auf seinem Konto hinterlassenen =
wertvollen Betrag (4,8 Mio. USD) wiederzugewinnen, bevor er von der Securit=
y Finance-Firma, bei der der Betrag eingezahlt wurde, unbrauchbar beschlagn=
ahmt oder ausgewertet wird.


Ich bitte nur um ehrliche Zusammenarbeit, um diese Transaktion so schnell w=
ie m=C3=B6glich zu sehen.


Ich suche eine direkte Antwort auf weitere Klarstellungen.


Gr=C3=BC=C3=9Fe


Mr. Lipton Daveid (links)
