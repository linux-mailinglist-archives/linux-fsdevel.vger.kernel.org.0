Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA286F5FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjECUGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECUGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:06:20 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227C7DA8;
        Wed,  3 May 2023 13:06:18 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230503200615usoutp01a661af4f841d6de6b16f0109f57ba0a8~buuRYTJjB1421714217usoutp01b;
        Wed,  3 May 2023 20:06:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230503200615usoutp01a661af4f841d6de6b16f0109f57ba0a8~buuRYTJjB1421714217usoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683144375;
        bh=NKRjG6i2hJ6zP0UKtWm1EEioV8BAaLE3n33pY++wYcg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZclIiLoeJGBLpVrku5bDH3mW1QqXt9kxLFJ+HPSHTAXz+yYU7rnBsbNo8Cmm4TVjr
         U/jw6rv8vEYQqRemr1bUM2IP/Ts6ylDpOxss9gMOY0ubcrZuUpv8UEA4g2eerk18iF
         fTKbT5+I7RyiUDqimp5yy6RDLgZAENmYifK6ZYZw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230503200615uscas1p1a24f16a2804ccf8a98364debbc509f39~buuRHsQq11968819688uscas1p19;
        Wed,  3 May 2023 20:06:15 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 14.A5.20392.7BEB2546; Wed, 
        3 May 2023 16:06:15 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230503200615uscas1p23e32a33fb6a61794a25376312c4eeb6f~buuQzO2971595915959uscas1p2R;
        Wed,  3 May 2023 20:06:15 +0000 (GMT)
X-AuditID: cbfec370-597ff70000024fa8-48-6452beb77e2d
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 5A.79.38326.6BEB2546; Wed, 
        3 May 2023 16:06:14 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 3 May 2023 13:06:13 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        3 May 2023 13:06:13 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "chandan.babu@oracle.com" <chandan.babu@oracle.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: LSF/MM/BPF BoF: pains / goods with automation with kdevops
Thread-Topic: LSF/MM/BPF BoF: pains / goods with automation with kdevops
Thread-Index: AQHZM6N9g74zTm4CmkqgfDKi5XH6ka9KAm4AgAABCQA=
Date:   Wed, 3 May 2023 20:06:13 +0000
Message-ID: <7320b0c4-9922-4246-a79b-6f8b30e7547f@nmtadam.samsung>
In-Reply-To: <e44bb405be06fe97dbb0af3e47b4e8dd1c065f29.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79A4491EDEC90B4F892638F74615476B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djXc7rb9wWlGLxfIGhxYd1qRotLR+Us
        fi5bxW7x56Ghxd5b2hZ79p5ksdj3ei+zxY0JTxkdODx2zrrL7rFpVSebx+Qbyxk9Pj69xeIx
        YfNGVo/Pm+QC2KK4bFJSczLLUov07RK4MnZO3MBe0CdcMWXNa9YGxjP8XYycHBICJhJT7u9m
        6WLk4hASWMko0XHvHRuE08okceDzFWaYqsMv70Il1jJKvLv3nxHC+cgo8fLla3aQKiGBpYwS
        5xaXgdhsAgYSv49vBOrm4BARUJG41ZAJUs8ssIFZ4v67p4wgNcIC7hK7bjYygdgiAh4S7xdd
        Z4OwrSQmPf4ANpMFqHfxoa0sIDavgJPEugMTwC7iBKp/82wNWJxRQEzi+6k1YHOYBcQlbj2Z
        zwRxtaDEotl7oD4Qk/i36yEbhK0ocf/7S3aIeh2JBbs/sUHYdhIfli1khrC1JZYtfM0MsVdQ
        4uTMJywQvZISB1fcAIeXhMADDomrd1dCJVwknp3/zwphS0tcvT4VanG+xK42WDBWSFx93Q11
        hLXEwj/rmSYwqsxCcvcsJDfNQnLTLCQ3zUJy0wJG1lWM4qXFxbnpqcXGeanlesWJucWleel6
        yfm5mxiB6er0v8MFOxhv3fqod4iRiYPxEKMEB7OSCO+HQr8UId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4ryGtieThQTSE0tSs1NTC1KLYLJMHJxSDUxLNeeZuM868XLnr9sfmw7oKC54re2Uv6SV
        V016CX9v/K22urSIyBnpYsFXRY6q/DkQFLZxVePBky995s9as/xQ0szkepPvl5hFQ13qHNfY
        Kc0ObtbPlznFmn1Y+NurS6ION3zjmG+7x0moHvpoX3H/qMamRWa3CtS/OXavdO7etMTr2qTd
        KaHfl9gtyd7AKB7DaeO7ouzl78Vb8q7wyZ2f9s1CfEn+vjiBj5vdnaYqzNpboLm78GhYXq79
        D+/AHX3G23NNNn2Zu97a0c0nV4LnsexjppyGlAczwi/XNafzRHeLlr1t/6F/6eeBrlOecQfY
        n3VsTlg8zzY9o/TNovfv9R56am3fIR4kcnfmncVKLMUZiYZazEXFiQBqCMbGxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWS2cA0SXfbvqAUg7vvLCwurFvNaHHpqJzF
        z2Wr2C3+PDS02HtL22LP3pMsFvte72W2uDHhKaMDh8fOWXfZPTat6mTzmHxjOaPHx6e3WDwm
        bN7I6vF5k1wAWxSXTUpqTmZZapG+XQJXxs6JG9gL+oQrpqx5zdrAeIa/i5GTQ0LAROLwy7ts
        XYxcHEICqxklZn0/BOV8ZJT4/LITylnKKHHgxhImkBY2AQOJ38c3MncxcnCICKhI3GrIBKlh
        FtjALLFpzW+wGmEBd4ldNxvBbBEBD4n3i66zQdhWEpMef2AHsVmAehcf2soCYvMKOEmsOzCB
        GWLZcUaJ69cvgCU4gZrfPFsDZjMKiEl8P7UGbCizgLjErSfzmSB+EJBYsuc8M4QtKvHy8T9W
        CFtR4v73l+wQ9ToSC3Z/YoOw7SQ+LFvIDGFrSyxb+JoZ4ghBiZMzn7BA9EpKHFxxg2UCMESQ
        rJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrig3zUsv1ihNzi0vz0vWS83M3MQKj/fS/w5E7
        GI/e+qh3iJGJg/EQowQHs5II74dCvxQh3pTEyqrUovz4otKc1OJDjNIcLErivEKuE+OFBNIT
        S1KzU1MLUotgskwcnFINTIdj37jc/mK2ZdY0k8U7D9rliy6oYXWJEpihEG/dtd/k6rzjzaqC
        r//7nH+ef0pBKTXVcbPnraY9tmulbywXjP4bkKv9TiaOKe3RpY7W2/0HREtZDwhO3MF34G7H
        MaUCl+ltu5KY09rX5C3+xcvSs3xSmZCJ7T3Zo0tqJ/Bl7fXU3WReO1PhuPoCr0Lx31fdmyoe
        37ednVcb3s5yZ7UFV2rZJYuMTWkc+yS33T24h1E27/KZlrQdKyfumxYpUMzbO5P1Ha+GWIvt
        66Mrbm993mPAu9yi7ssf6S05yomt2U2n9xa/zNuzhnuH2hSBPWUSrfLFKU47HZ71db85yxgv
        HpampztPcGdOna5CRX+NEktxRqKhFnNRcSIAkiEtfGUDAAA=
X-CMS-MailID: 20230503200615uscas1p23e32a33fb6a61794a25376312c4eeb6f
CMS-TYPE: 301P
X-CMS-RootMailID: 20230503200234uscas1p2166cda8b4ca171b02446549cc67e5c4c
References: <Y9YFgDXnB9dTZIXA@bombadil.infradead.org>
        <CGME20230503200234uscas1p2166cda8b4ca171b02446549cc67e5c4c@uscas1p2.samsung.com>
        <e44bb405be06fe97dbb0af3e47b4e8dd1c065f29.camel@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 04:02:26PM -0400, Jeff Layton wrote:
> On Sat, 2023-01-28 at 21:34 -0800, Luis Chamberlain wrote:
> > More suitable towards a BoF as I don't *think* a larger audience would =
be
> > interested. At the last LSF during our talks about automation it was su=
ggested
> > we could share a repo and go to town as we're all adults. That's been d=
one:
> >=20
> > https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3Da83=
af7a2-f7a1cec7-a83b7ced-000babff32e3-f8d68746f8f1175e&q=3D1&e=3Df2f6f708-e4=
a4-4976-bd4f-5faebd8f572c&u=3Dhttps*3A*2F*2Fgithub.com*2Flinux-kdevops*2Fkd=
evops__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!Ton7OdUx1HbmbleyTg_Qx_6ZjiVDqNkYaXn6c=
WoJHlqUeQpwcbBsUot5meY3ylHMj0cnj4kBWKKYM-Yq9ZOLLA$=20
> >=20
> > At ALPSS folks suggested maybe non-github, best we can do for now is
> > gitlab:
> >=20
> > https://urldefense.com/v3/__https://gitlab.com/linux-kdevops/kdevops__;=
!!EwVzqGoTKBqv-0DWAJBm!Ton7OdUx1HbmbleyTg_Qx_6ZjiVDqNkYaXn6cWoJHlqUeQpwcbBs=
Uot5meY3ylHMj0cnj4kBWKKYM-a0CMLpjQ$=20
> >=20
> > There's been quite a bit of development from folks on the To list. But
> > there's also bugs even on the upstream kernel now that can sometimes er=
k us.
> > One example is 9p is now used to be able to compile Linux on the host
> > instead of the guests. Well if you edit a file after boot on the host
> > for Linux, the guest won't see the update, so I guess 9p doesn't update
> > the guest's copy yet. Guests just have to reboot now. So we have to fix=
 that
> > and I guess add 9p to fstests. Or now that we have NFS support thanks t=
o
> > Jeff, maybe use that as an option? What's the overhead for automation V=
s 9p?
> >=20
> > We dicussed sharing more archive of results for fstests/blktests. Done.
> > What are the other developer's pain points? What would folks like? If
> > folks want demos for complex setups let me know and we can just do that
> > through zoom and record them / publish online to help as documentation
> > (please reply to this thread in private to me and I can set up a
> > session). Let's use the time at LSF more for figuring out what is neede=
d
> > for the next year.
> >=20
> >   Luis
>=20
> Luis mentioned that no one had replied to this expressing interest. I'm
> definitely interested in discussing kdevops if the schedule's not
> already full.

+1 for me as well.=20

> --=20
> Jeff Layton <jlayton@kernel.org>=
