Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3237530665
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiEVWBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEVWBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 18:01:45 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFE237FD;
        Sun, 22 May 2022 15:01:44 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220522220141usoutp025a96a23b1ee25774022f99d708b14e18~xjGSGOTvT1556715567usoutp02t;
        Sun, 22 May 2022 22:01:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220522220141usoutp025a96a23b1ee25774022f99d708b14e18~xjGSGOTvT1556715567usoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653256901;
        bh=EfTuUUdLKmSUsQiDO9qYEBbG/J1wxpqf5Hgx5lMt0BQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=EKLuO5I/w3zhOvQS50xc5n6h4fVtDvs91HXq1KxrRbFv9t1WqBy/1GQSaiF2bck1f
         +tA2Y1cyWpJLElVWYSueDB/1L4rJVHygnDGCITphDgoqAl4oCl/sIlnJyTGkWT4dfo
         xRrWqXTQ2V84AsKfgAab9IsNF+trrfMWtnZWTq2g=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220522220140uscas1p22d4a147918cf989a4404f62fa141dfc1~xjGRLL0Rz2024220242uscas1p2I;
        Sun, 22 May 2022 22:01:40 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id FA.1F.09642.4C2BA826; Sun,
        22 May 2022 18:01:40 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2~xjGQI9cZg2083020830uscas1p1R;
        Sun, 22 May 2022 22:01:39 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-e5-628ab2c4ddd4
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id CE.A4.52945.3C2BA826; Sun,
        22 May 2022 18:01:39 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Sun, 22 May 2022 15:01:38 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Sun,
        22 May 2022 15:01:38 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mb@lightnvm.io" <mb@lightnvm.io>, "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
 Conference 2022
Thread-Topic: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
        Conference 2022
Thread-Index: AQHYbieCqwy4fi3r20GqJMCAwVTLug==
Date:   Sun, 22 May 2022 22:01:38 +0000
Message-ID: <20220522220128.GA347919@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <597CF64C8C3AE644ACFB3A70A5B9FCE2@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH53fv3bu3rXRbTR2tYaxpUGMrI9awCs1YhsljGPK8dFWqLXvL
        c0iGURvNhlJbXtXUSimL1qTH9JjUJr2kJo8mCjsGkVIobDej/z7nd8739/2emUPh4tsCZypY
        FcmqVUyolBQRRTUDjXOrDZo9HgXJzvLST2kCeUnGBUxe2ukmb3mjF8pLSusIeWtxOinXG6sJ
        eYe2F/lQSkNuHKmMbxtCys9lbaTybv0xZb9h2jqBv2hJABsafJBVuy/dLQq6UpAojHgFhxsT
        B4Un0TnQICsK6PlQ12dGGiSixPRNBJmabNLSENNnMHj80PvfUFfWe4wfykcwXHyW5IuvCG4U
        5Aj5IhtB3LXrmEVC0h7w89Ed3MIO9DJ4UDEwpsDpLgxiTUXI0phMb4XKlA8kP7QTWspiEM8y
        OJVeItAgiiJoFzA3bLE829JekJX9lLAwoh3huylvzAunnaCz5xrGR7WHjLQSnGdHGC3uJnme
        AV3fzULLlzg9BwqK3XnpUtBWpxI8z4BL8d1C3soe6lJ7CF46BSr0HeNcS0HK89U8+8JHU8O4
        lQQu57USlhWBPougT1sm4Astghcfh8dDLIbRuGdC3m0SjPx4jbRopm7CDrr/+XQT8ukm5NNN
        yHcdCXKRUxTHhQWy3DwVe0jGMWFclCpQtjc8zID+nlT9aFX4A9Te+UVWiTAKVSKgcKmDrZGJ
        3SO2DWCOHGXV4bvUUaEsV4kkFCF1ss0OLmTEdCATyYawbASr/tfFKCvnk1jMcSqBPOD3ayRm
        X33VoobkxFWZL4mmhC1PfLDJ7jnbnij6U73zexpr1obfOlXhepCZWg6nbfA3bbcuZSqyQPHC
        OH1W3I5uhd/25Y7bnn+bNmJcaFdYkx5y9SIu9Huda5Xla03tX7vV3iNhekaHg6hrtX1rTjmW
        O8eYuDHz3lBLffzbBe8MsGHeeefbJk52QjXVqDf5f8B9mmvbOavLm6j1ZYpVy62Tvtmd8ZSa
        3RzcJO83b5itj5H0apNX9I20Od3vjng1tObK+YX7GvtdBpPo6KDm2RmU/+90O9/SpFHZz9TI
        NYRZH2BemWaKDltUGDvJ8Zcr4X5xf9Nxu/uxNkVeEinBBTGerriaY/4AZk1MI8EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWS2cA0Uffwpq4kgwnbxS32vpvNarFn0SQm
        i723tC0uPV7BbrFn70kWi8u75rBZrNh+hMXixoSnjA4cHptWdbJ5dF/9wejxft9VNo/Np6s9
        Pm+SC2CN4rJJSc3JLEst0rdL4MqYu34ie8E9iYrzE7+xNzD2SHQxcnJICJhI3F/ygqmLkYtD
        SGA1o8SF7xOgnE+MEqdal7BBOMsYJb59P8QI0sImYCDx+/hGZhBbRMBRYsfBr2BFzAL3mSQ6
        Tm0DKxIWiJQ4NOM1G0RRnMSXAz+hbD2Jpjl7WLsYOThYBFQlXp6NAAnzCphKLFl2hQXEZhQQ
        k/h+ag0TiM0sIC5x68l8JohTBSSW7DnPDGGLSrx8/I8VwlaUuP/9JTvISGYBTYn1u/QhWu0k
        JhyZyQJhK0pM6X7IDrFKUOLkzCcsEK2SEgdX3GCZwCg2C8m2WQiTZiGZNAvJpFlIJi1gZF3F
        KF5aXJybXlFsnJdarlecmFtcmpeul5yfu4kRGK+n/x2O2cF479ZHvUOMTByMhxglOJiVRHi3
        J3YkCfGmJFZWpRblxxeV5qQWH2KU5mBREuf1iJ0YLySQnliSmp2aWpBaBJNl4uCUamAyYJ40
        /8xEpintW1gCefyVuuZEv9+ptHjxrdjbMq8PLZ+XuC3n/W3P+VzVZ4TS/LmX8+5qdzU7pvg8
        KXE2U/1SDbPjZTnG/msmSPsqiXxc9uTvd/3zk9qnFIdd7o3LWPpoqXM5y73UOQESQg3zBERK
        dTwfSyTxTneOexC19pdTkdOPT0kt4Xud3Nuk9mzkuhi+NvHAtPRXyo+OaT5SPrfUYk1le+LO
        T+8bz6vt7O3rnLV38nOBGU/LLzhw8TZnhcY8912/cvWb0K87HToTP5dGuN1snb72QD5X1nuB
        XW5zvDe57bDiTPd26e88Xy56vl0l6voq+/Y7XkdVGnXvFWzfeONLubbgraWssa/a3r5SYinO
        SDTUYi4qTgQA4u756EYDAAA=
X-CMS-MailID: 20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2
CMS-TYPE: 301P
X-CMS-RootMailID: 20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2
References: <CGME20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2@uscas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wm9uZWQgU3RvcmFnZSBEZXZpY2VzIChTTVIgSEREcyBhbmQgWk5TIFNTRHMpIGhhdmUgZGVtb25z
dHJhdGVkIHRoYXQgdGhleSBjYW4NCmltcHJvdmUgc3RvcmFnZSBjYXBhY2l0eSwgdGhyb3VnaHB1
dCwgYW5kIGxhdGVuY3kgb3ZlciBjb252ZW50aW9uYWwgc3RvcmFnZQ0KZGV2aWNlcyBmb3IgbWFu
eSB3b3JrbG9hZHMuIFpvbmVkIHN0b3JhZ2UgdGVjaG5vbG9neSBpcyBkZXBsb3llZCBhdCBzY2Fs
ZSBpbg0Kc29tZSBvZiB0aGUgbGFyZ2VzdCBkYXRhIGNlbnRlcnMgaW4gdGhlIHdvcmxkLiBUaGVy
ZSdzIGFscmVhZHkgYQ0Kd2VsbC1lc3RhYmxpc2hlZCBzZXQgb2Ygc3RvcmFnZSB2ZW5kb3JzIHdp
dGggaW5jcmVhc2luZyBkZXZpY2UgYXZhaWxhYmlsaXR5IGFuZA0KYSBtYXR1cmUgc29mdHdhcmUg
Zm91bmRhdGlvbiBmb3IgaW50ZXJhY3Rpbmcgd2l0aCB6b25lZCBzdG9yYWdlIGRldmljZXMgaXMN
CmF2YWlsYWJsZS4gWm9uZWQgc3RvcmFnZSBzb2Z0d2FyZSBzdXBwb3J0IGlzIGV2b2x2aW5nIGFu
ZCB0aGVpciBpcyByb29tIGZvcg0KaW5jcmVhc2VkIGZpbGUtc3lzdGVtIHN1cHBvcnQgYW5kIGFk
ZGl0aW9uYWwgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucy4NCg0KVGhlIFpvbmVkIFN0b3JhZ2UgbWlj
cm9jb25mZXJlbmNlIGZvY3VzZXMgb24gZXZvbHZpbmcgdGhlIExpbnV4IHpvbmVkIA0Kc3RvcmFn
ZSBlY29zeXN0ZW0gYnkgaW1wcm92aW5nIGtlcm5lbCBzdXBwb3J0LCBmaWxlIHN5c3RlbXMsIGFu
ZCBhcHBsaWNhdGlvbnMuDQpJbiBhZGRpdGlvbiwgdGhlIGZvcnVtIGFsbG93cyB1cyB0byBvcGVu
IHRoZSBkaXNjdXNzaW9uIHRvIGluY29ycG9yYXRlIGFuZCBncm93DQp0aGUgem9uZWQgc3RvcmFn
ZSBjb21tdW5pdHkgbWFraW5nIHN1cmUgdG8gbWVldCBldmVyeW9uZSdzIG5lZWRzIGFuZA0KZXhw
ZWN0YXRpb25zLiBGaW5hbGx5LCBpdCBpcyBhbiBleGNlbGxlbnQgb3Bwb3J0dW5pdHkgZm9yIGFu
eW9uZSBpbnRlcmVzdGVkIGluDQp6b25lZCBzdG9yYWdlIGRldmljZXMgdG8gbWVldCBhbmQgZGlz
Y3VzcyBob3cgd2UgY2FuIG1vdmUgdGhlIGVjb3N5c3RlbSBmb3J3YXJkDQp0b2dldGhlci4NCg0K
U3VnZ2VzdGVkIHRvcGljczoNCg0KICAgIC0gRWNvc3lzdGVtICYgQXJjaGl0ZWN0dXJhbCByZXZp
ZXcNCiAgICAtIFlvdXIgam91cm5leSB1c2luZyBvciBlbmFibGluZyB6b25lZCBzdG9yYWdlIGRl
dmljZXMNCiAgICAtIEN1cnJlbnQgYW5kIGZ1dHVyZSBrZXJuZWwgd29yayAobm9uLXBvd2VyIG9m
IDIgem9uZXMsIHN3YXAgDQpzdXBwb3J0LCByYWlkLCBsb2ctc3RydWN0dXJlZCBibG9jayBkZXZp
Y2VzIOKApikNCiAgICAtIFFlbXUgc3VwcG9ydCBub3cgYW5kIGxhdGVyDQogICAgLSBTUERLIHN1
cHBvcnQgbm93IGFuZCBsYXRlcg0KICAgIC0gRmlsZSBzeXN0ZW1zIHN1cHBvcnQgbm93IGFuZCBs
YXRlciAoZjJmcywgYnRyZnMsIHpvbmVmcywgLi4uKQ0KICAgIC0gQXBwbGljYXRpb24gc3VwcG9y
dCBub3cgYW5kIGxhdGVyIChDYWNoZUxpYiwgQ2Fzc2FuZHJhLCBDZXBoLCANCkhERlMsIFJvY2tz
REIsIE15U1FMLCBUZXJhcmtEQiwgeW91ciBmYXZvcml0ZSBhcHBsaWNhdGlvbiwg4oCmKQ0KICAg
IC0gVG9vbHMgYW5kIGxpYnJhcmllcyByZWxhdGVkIHRvIHpvbmVkIHN0b3JhZ2UgZGV2aWNlcyAo
Ymxrem9uZSwgDQpmaW8sIGxpYnpiZCwgbnZtZS1jbGksIHhudm1lLCB4enRsLCDigKYpDQogICAg
LSBEZWJ1Z2dpbmcgdG9vbHMgYW5kIGFwcHJvYWNoZXMNCg0KDQpJZiB5b3UgYXJlIGludGVyZXN0
ZWQgaW4gcGFydGljaXBhdGluZyBpbiB0aGlzIG1pY3JvY29uZmVyZW5jZSBhbmQgaGF2ZSANCnRv
cGljcyB0byBwcm9wb3NlLCBwbGVhc2UgdXNlIHRoZSBMUEMgQ0ZQIHByb2Nlc3MgWzFdLCBhbmQg
c2VsZWN0ICJab25lIA0KU3RvcmFnZSBNQyIgZm9yIHRoZSAiVHJhY2siLg0KDQpUaGUgc3VibWlz
c2lvbiBkZWFkbGluZSBpcyBKdW5lIDMwLg0KDQpDb21lIGFuZCBqb2luIHVzIGluIHRoZSBkaXNj
dXNzaW9uLiBXZSBob3BlIHRvIHNlZSB5b3UgdGhlcmUhDQoNCkZvciBtb3JlIGluZm9ybWF0aW9u
LCBmZWVsIGZyZWUgdG8gY29udGFjdCB0aGUgWm9uZWQgU3RvcmFnZSBNQyBMZWFkczoNCiAgICBB
ZGFtIE1hbnphbmFyZXMgPGEubWFuemFuYXJlc0BzYW1zdW5nLmNvbT4NCiAgICBMdWlzIENoYW1i
ZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4NCiAgICBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdo
dG52bS5pbz4NCiAgICBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCg0KWzFdIGh0dHBz
Oi8vbHBjLmV2ZW50cy9ldmVudC8xNi9hYnN0cmFjdHMv
