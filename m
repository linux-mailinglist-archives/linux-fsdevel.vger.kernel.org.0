Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48546A665C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 04:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCADLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 22:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCADLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:11:36 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7137B57;
        Tue, 28 Feb 2023 19:11:29 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230301031129usoutp011b1c1574968eedaa98ca76a644d27860~ILPRXUQQy2508925089usoutp01P;
        Wed,  1 Mar 2023 03:11:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230301031129usoutp011b1c1574968eedaa98ca76a644d27860~ILPRXUQQy2508925089usoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677640289;
        bh=FBjY1fk1hWDrtiqb5gvNjzuAcMFN5vVedT1qFKiguqQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZxT6Nb/K248zAb8hqbDKlc6Fh9o2Vc4rfiVyu+MNXbnh/GOBsstUePDOeCAO4Dj7S
         SCbjTCGfusXtNF7YpD9OtcoNkDw9B9pzMXnwB/HgA+twDU0RTVftZKX+/+48GxJlft
         eYyvbA1FBs85tNA3QdcXx3etQZ757ku8ShojNO+M=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230301031128uscas1p2c096ab212b64c11da611513d38bf22c1~ILPQ7_kt90798807988uscas1p2B;
        Wed,  1 Mar 2023 03:11:28 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 4D.94.06976.062CEF36; Tue,
        28 Feb 2023 22:11:28 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230301031128uscas1p2429451241f37f228cd2d8415a27ccc88~ILPQgjFzu0799707997uscas1p2A;
        Wed,  1 Mar 2023 03:11:28 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-67-63fec2604841
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 0A.8C.17110.F52CEF36; Tue,
        28 Feb 2023 22:11:28 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 28 Feb 2023 19:11:27 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        28 Feb 2023 19:11:27 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chandan.babu@oracle.com" <chandan.babu@oracle.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: kdevops live demo zoom & Q&A
Thread-Topic: kdevops live demo zoom & Q&A
Thread-Index: AQHZSwuXCuNP4TxPwEivOqf2pZxDLq7lPUyAgACJuoA=
Date:   Wed, 1 Mar 2023 03:11:27 +0000
Message-ID: <20230301031120.GA1403834@bgt-140510-bm03>
In-Reply-To: <Y/5O0yItfBwNKdXm@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <280005D3867E4C4FA4C556258890BC1C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djXc7oJh/4lG6w+LG9xYd1qRovXhz8x
        Wlw6KmexZv46VovVN9cwWvxctord4s9DQ4u9t7Qtzs86xWKxZ+9JFosbE54yWry83MNs0fHy
        KLMDr8ebly9ZPHbOusvusWlVJ5vHx6e3WDzm7upj9Jg6u95jwuaNrB67Tq5g8/i8SS6AM4rL
        JiU1J7MstUjfLoErY+1rrYIjrBX3eo6yNzD2sXQxcnJICJhILH3xl7WLkYtDSGAlo8TZZT/Y
        IZxWJokbv+eywlRd+/+SDSKxllFiwcbTjBDOJ0aJ7d8/MUM4yxgltt2+yQ7SwiagKLGvazsb
        iC0ioCGxb0IvE0gRs8BfFom7C8+BzRUW0JQ4vO8sI0SRlsSnBbNYIGwriRcdLWCDWARUJI7M
        uQ00iIODV8BM4sY/LZAwJ5C56NJCsFZGATGJ76fWMIHYzALiEreezGeCOFtQYtHsPcwQtpjE
        v10P2SBsRYn731+yQ9TrSCzY/YkNwraT2LFkNpStLbFs4WuwXl6gOSdnPoEGmKTEwRU3WEB+
        kRCYzSnxfWcb1AIXicaWKVC2tMTfu8uYQG6WEEiWWPWRCyKcIzF/yRaoOdYSC/+sZ5rAqDIL
        ydmzkJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb5qWW6xUn5haX5qXrJefnbmIEpr7T/w7n
        7mDcceuj3iFGJg7GQ4wSHMxKIrwLb/9JFuJNSaysSi3Kjy8qzUktPsQozcGiJM5raHsyWUgg
        PbEkNTs1tSC1CCbLxMEp1cC0OVBnkc3/kzNvOgtOaOD1+Sf/vnTBpZqW3tcr18lNXGNl72Wt
        +24y669pD29LcWgVbD4wM3ZDWr1fwuJ3OU8rdu9tnNnTeFT92Jx5Pc+m9vN9sTT5f3pe3pXN
        9scm9qbk/tQsMTPVfN+k/2yivbe26VLVmX8mr2NK1E5NjtipnyM08XrWlLfM/58ZHz1+x/fh
        8YtiP+/IOee7v3opavKgvu/Czt9urQXpy6dOe7Ely6dDd3P5wbz21ar6P5Q8ZhezWIhtKRRx
        cGO7GWNuEmsieHDNzqz3cWflH2U52Yf/knZWe6lQMvnfJe5WUd6rgg+552QfYmd9kMBW3mCi
        2Rp1J+5A6seqdWppdzzjw7SVWIozEg21mIuKEwHVATlF7AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWS2cA0STfh0L9kg3sNbBYX1q1mtHh9+BOj
        xaWjchZr5q9jtVh9cw2jxc9lq9gt/jw0tNh7S9vi/KxTLBZ79p5ksbgx4SmjxcvLPcwWHS+P
        Mjvwerx5+ZLFY+esu+wem1Z1snl8fHqLxWPurj5Gj6mz6z0mbN7I6rHr5Ao2j8+b5AI4o7hs
        UlJzMstSi/TtErgy1r7WKjjCWnGv5yh7A2MfSxcjJ4eEgInEtf8v2boYuTiEBFYzSlzccZcV
        wvnEKDFtwh5GCGcZo8T3ST/ZQVrYBBQl9nVtZwOxRQQ0JPZN6GUCKWIW+MsicXfhOVaQhLCA
        psThfWcZIYq0JD4tmMUCYVtJvOhoARvEIqAicWTObaBBHBy8AmYSN/5pQSzbyihxuL2XGaSG
        Eyi+6NJCsDmMAmIS30+tYQKxmQXEJW49mc8E8YOAxJI955khbFGJl4//sULYihL3v79kh6jX
        kViw+xMbhG0nsWPJbChbW2LZwtdgvbwCghInZz6BhoukxMEVN1gmMErMQrJuFpJRs5CMmoVk
        1CwkoxYwsq5iFC8tLs5Nryg2ykst1ytOzC0uzUvXS87P3cQITByn/x2O3sF4+9ZHvUOMTByM
        hxglOJiVRHgX3v6TLMSbklhZlVqUH19UmpNafIhRmoNFSZz3ZdTEeCGB9MSS1OzU1ILUIpgs
        EwenVAOTVLpBhKju9P9T1h11VVp4b+LvpEued9I+f/XosSg9cLez9CRbrYbkthPzL7n8sz4l
        sf/r911H7VZaBb7Ptni66sFbqXzTc5paCyazzE7vvhsQubVMN9WLoVrhafusd1+KG7Qv7J3Y
        bFAWxcylEOP1OvbKyhUtPvJc0nUr/rw9ZGLNnbjvqYZuple5fmJtl9/sM3tSJR+9K+nOnOJr
        /D06/87jopWMj8pWcjvomScahsafsVqukTaBXa+iwXGX+/HmeId6IZnrK1ZM/y38L+qil6uP
        8tPdD9JWBq2QTMty3fY2lWWv7s6sltVVUl211VvnqPRV7lDzD2ize1Rg4pG+QFLh14bXYvf6
        ghQZOpRYijMSDbWYi4oTAa0SotCLAwAA
X-CMS-MailID: 20230301031128uscas1p2429451241f37f228cd2d8415a27ccc88
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228185844uscas1p2d15f1ab2ef6a5e11c595585fc080031e
References: <Y/1KnN/ER8pnhbaa@bombadil.infradead.org>
        <CGME20230228185844uscas1p2d15f1ab2ef6a5e11c595585fc080031e@uscas1p2.samsung.com>
        <Y/5O0yItfBwNKdXm@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:58:27AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 27, 2023 at 04:28:12PM -0800, Luis Chamberlain wrote:
> > To start off with let me propose a few dates for this zoom demo (all
> > are Wednesdays as its my most flexible day):
> >=20
> >   * March 8  1pm PST
> >   * March 15 1pm PST
> >   * March 29 1pm PST
>=20
> Based on feedback to at least to get some EU folks I'll change this to 9a=
m PST.
> I know one person can't attend March 8th so the following dates are
> remaining:
>=20
> * March 15 9am PST
> * March 29 9am PST
>=20
> Let me know if this works for those who had expressed interest.
>=20
>   Luis

Either time works for me.

Thanks,
Fan=
