Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2346F4720
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEBP1K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 2 May 2023 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjEBP1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:27:06 -0400
X-Greylist: delayed 721 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 08:26:51 PDT
Received: from repostorp.tmes.trendmicro.eu (repostorp.tmes.trendmicro.eu [18.185.115.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3E1FEA;
        Tue,  2 May 2023 08:26:51 -0700 (PDT)
Received: from 89.96.76.23_.trendmicro.com (unknown [172.21.174.129])
        by repostorp.tmes.trendmicro.eu (Postfix) with SMTP id DE8E210001CA9;
        Tue,  2 May 2023 15:14:48 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1683040484.205000
X-TM-MAIL-UUID: 9d34abb2-f98d-42fe-a519-740f63d20ec6
Received: from EXCH001EDG.int.milano (unknown [89.96.76.23])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTP id 322C01000031F;
        Tue,  2 May 2023 15:14:44 +0000 (UTC)
Received: from EXCH000HUB.int.milano (10.4.32.33) by EXCH001EDG.int.milano
 (89.96.76.23) with Microsoft SMTP Server (TLS) id 8.3.389.2; Tue, 2 May 2023
 16:03:58 +0200
Received: from EXCHSRVR04.int.milano ([10.4.32.36]) by EXCH000HUB.int.milano
 ([10.4.32.33]) with mapi; Tue, 2 May 2023 16:03:57 +0200
From:   Gregoraci Antonio <Antonio.Gregoraci@istitutotumori.mi.it>
To:     "21@hotmail.com" <21@hotmail.com>
Content-Class: urn:content-classes:message
Date:   Tue, 2 May 2023 16:03:57 +0200
Subject: ciao/hola 
Thread-Topic: ciao/hola 
Thread-Index: AQHZfP7wfDH5E7YQGE6pD/HaqgYuug==
Message-ID: <DCA15BFBCFA11D4DAAB69864B5B767D7022DA3790CA9@EXCHSRVR04.int.milano>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: it-IT, en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-ERS: 89.96.76.23-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27600.006
X-TMASE-Result: 10--0.498400-7.000000
X-TMASE-MatchedRID: qghvOcntWS2Z92UT4XKzJIzJSrP8XgcQT5ysQDj6eFkfC2FGu7tA81zc
        N74oAfwJEuGubd3QSKkLv2YeXovldp37S9TKDkH2Y7L5YZ/GWo88giGxpCWY0EtsJzQHCZcSwW/
        L3W0LVOkFEWquoassAFMDuVy2uLVtkx2Snp1oOy8JpZrBEBxeh6WZ8epSxLv1NrrXUu9NOw132d
        /lahyyuMIHIzZTHJ5RXIQHm/T01j24YWhbJElg6jQSLnXfNheG0Xm3zNiCTIf9QiAjQioU2p4Mw
        iLIKPp4EN4+/F+KW4JYt7+nUkbMzsuESocJdnC3tABKEc19JLDVbMYBwo6uo2GmZJthDk5L6OeM
        88/CbZ4Kgc+vdjiMm2CgLb7aOYXrX8HBJXDRyy3NyoQF1G8ewSZS+ESysQxCvcJqpATew29XGUf
        0pchVSzbrBWimww0Hq20+/bqOKqOjsapKl172KyN0LmCTISb/4lXux+bAZo91yKuDJrvsKvFzDQ
        YLzkK1m+Y5RjhtvgXX56Whmcn8cqnL54M5CzEQv5rsfD7H2pnzZKDA1/pIrhl8cUtiK/0jPS+7s
        rmYKnhHqemudHU/toBdglOtTT6k+bqkzTf+YoIMTyJMXCOBhsRB0bsfrpPIqxB32o9eGcn/ita+
        mP1RyFq78aR+OT5wLf4QJXn5pzx74uC9DRCKbZ75kL6lrN26ji8VocIQ8Bw=
X-TMASE-XGENCLOUD: c7fbe7a8-e9d3-48bb-9ba9-c5916eacd37c-0-0-200-0
X-TM-Deliver-Signature: A2950DBD9EEE484008B7DC5DBE4753C1
X-TM-Addin-Auth: B5QcoxCpSo5PVodC33tJfJhMpHl4Bm2Rq+2xtI3a8Y6D7M7j9yMSOVveL6z
        tQfbUjIjzYqWtpnPf5P0VNlyEo/Y+OQdj38v//3vfVGqprczd3PtZMWGjNR0dEW9w9yWL3a+qsl
        DIDO4nEdE/pKACzLZTo3MG6hg4BaDTx/j+Oud5oBnDMmmpESuPNMqYzLjjGCcIDsWx0pWzIII3r
        yiGGx+0Rqt5Sh3ZsVeQYiaART9vUb8dK+CZYyJh592Ovl6neFCl0W5DvK5KFl2uVGF2GzIwSco4
        RoTOaix29vTk8c8NGE9VuHBW1GYH9BYfOfOo.IRXidL09Bb5/Im+GYckGYbRI62YVz3t7NR8JUa
        5vBLuMuYwtK/rH+h1rCxYCblvHbDoPYtFls/0lkKnP7OLyMkFUf2OsWytnusx9CBqew0GjyX5zE
        Yd4LIm1/FBZ7RXMAOrEcAOfALcCZ0nZOAU3Gm+5G+k0x+gEuU6Mxdn7Q82TXgKdmoTQbkp31XLb
        7OsQzl3n5wozA4BKbXKojhwRSWIHOWvyay+eycn6XECj3NpiQUafs+On9a0A93yMSiFF7sWeRVJ
        UiTCQsE7453y4Pq54RwhJiQiO4BqfzZdQZAyAMct6m03Qt8P8A15EtUB8IlsASTWifGTiPCTnJB
        8CSg==
X-TM-Addin-ProductCode: EMS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello and how are you? There is a project that I would like to discuss with you. everything available. Please contact me directly at my private email.   ( drcc7072@gmail.com )





















































































============================================================================================================
La presente comunicazione, che potrebbe contenere informazioni riservate e/o protette da segreto professionale, � indirizzata esclusivamente ai destinatari della medesima qui indicati. Ogni informazione qui contenuta, che non sia relativa alla nostra attivit� caratteristica, deve essere considerata come non inviata. Nel caso in cui abbiate ricevuto per errore la presente comunicazione, vogliate cortesemente darcene immediata notizia, rispondendo a questo stesso indirizzo di e-mail, e poi procedere alla cancellazione di questo messaggio dal Vostro sistema. E' strettamente proibito e potrebbe essere fonte di violazione di legge qualsiasi uso, comunicazione, copia o diffusione dei contenuti di questa comunicazione da parte di chi la abbia ricevuta per errore o in violazione degli scopi della presente. Ricordiamo che la tecnologia di trasmissione utilizzata non consente di garantire l�autenticit� del mittente n� l�integrit� dei dati

This communication, which may contain confidential and/or legally privileged information, is intended solely for the use of the intended addressees. All information or advice contained in this communication is subject to the terms and conditions provided by the agreement governing each particular client engagement. If you have received this communication in error, please notify us immediately by responding to this email; then please delete it from your system. Any use, disclosure, copying or distribution of the contents of this communication by a not-intended recipient or in violation of the purposes of this communication is strictly prohibited and may be unlawful. The transmission technology used to send this mail can grant neither the sender identity nor the data integrity


