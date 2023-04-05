Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177946D723B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjDECAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjDECAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:00:40 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0F2708
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:00:33 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230405020029epoutp02a10614f0304038afa96df40b69e2135a~S52R4Rl_p0812008120epoutp02b
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:00:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230405020029epoutp02a10614f0304038afa96df40b69e2135a~S52R4Rl_p0812008120epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680660029;
        bh=4thd3heMEraca//jwqJ0ec4LoGtfGKo+0QaJP9sr9II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNhUeftUqfUjH3ltgf0fbBPLINVd8lSG1M/eaFgqxKAAWQFoXXvt2sAdnM53tlNKy
         5axdXz3z7wB/4LP72Sh5Ls14US/8WDHBGdlGn4fLEU3MUzYZwk8NC5w/McjLcIGV9M
         P9TyMOy15W+n7A43N52lvaQ9u2FYsvqhSqdKrl8E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230405020028epcas2p2847d97067fccea2f9c3434afb89d9b49~S52RJCxWu1499914999epcas2p2I;
        Wed,  5 Apr 2023 02:00:28 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Prns82915z4x9Q1; Wed,  5 Apr
        2023 02:00:28 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.A6.35469.C36DC246; Wed,  5 Apr 2023 11:00:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6~S52QNybSg3010330103epcas2p4O;
        Wed,  5 Apr 2023 02:00:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230405020027epsmtrp2958bd39a98ddadadcc48e188140e1af7~S52QNBfTV1003310033epsmtrp2-;
        Wed,  5 Apr 2023 02:00:27 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-fe-642cd63ce796
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.5A.18071.B36DC246; Wed,  5 Apr 2023 11:00:27 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020027epsmtip2e94be8e8537bddb9e3784a7ab098f603~S52P9gE_w1602716027epsmtip2p;
        Wed,  5 Apr 2023 02:00:27 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     willy@infradead.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
Date:   Wed,  5 Apr 2023 11:00:27 +0900
Message-Id: <20230405020027.413578-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmma7NNZ0UgzsveS2mH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbvOg8zmTRseENo8XvH3PYLDbef8fmwOXx78QaNo/NK7Q8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjMMXGlgL7vJWrOhdy9TA2M3dxcjJISFgIrF+
        2SO2LkYuDiGBHYwS33/dZQZJCAl8YpTY+c8MIvGNUWLb9E5GmI69fz9DdexllNg7aTUjhNPF
        JNG34DJYFZuAtsSfK+fZQGwRAXGJY1NPgsWZBf4xSuy5LAliCwuESqy/sIwJxGYRUJVoeHae
        HcTmFbCROLRyJdQ2eYmZl76DxTmBNh/bMYcRokZQ4uTMJywQM+UlmrfOZgY5QkKglUNi8/+1
        LBDNLhK7L0yHGiQs8er4FnYIW0ri87u9bBB2scTj1/+g4iUSh5f8huo1lnh38zlrFyMH0AJN
        ifW79EFMCQFliSO3oNbySXQc/ssOEeaV6GgTgmhUkdj+bzkzzKLT+zdBDfeQmLDqJwskqNoZ
        JdbcvMUygVFhFpJvZiH5ZhbC4gWMzKsYxVILinPTU4uNCkzgEZycn7uJEZxYtTx2MM5++0Hv
        ECMTB+MhRgkOZiURXtUurRQh3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M7Xkl8YYmlgYm
        ZmaG5kamBuZK4rwfO5RThATSE0tSs1NTC1KLYPqYODilGpi457Vsbi+5Gr7zHLOmy2QG94km
        AZeezDqyYyZH12aR0hXHspL6r+/eVPatLCt0StmWMG2dRq0jSU0t8kp/7230jLm8omdtz0aF
        ZcuubayQiTwS3hXlJeDxba/cD7tH2Z77Q5nPKTHKrJMx/1X076rdSkdlR1mjjXVBTcVpl6dv
        rNWUD5R/UfZ+1dKoX/Nj/ONn/lwjqfg3yl/y2/v9+o1Kq6y9/k2Jehri75DByefzOurYxXyz
        Ow+qIqetTLuYW99Y9DKwU+k2c8KfZP4lS398sVXM2hl7dYL81D2WHzmv3BTI1809usNLQfH4
        7PbMNHNNtn+3FxefbNW5fXpa4NINCi4FhxdckbJK/Lmt1FaJpTgj0VCLuag4EQDW2LA2NQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvK71NZ0Ug61HdSymH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbvOg8zmTRseENo8XvH3PYLDbef8fmwOXx78QaNo/NK7Q8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG4QsNrAV3eStW9K5l
        amDs5u5i5OSQEDCR2Pv3M1sXIxeHkMBuRontDRPZIRJSEu9Pt0HZwhL3W46wQhR1MEks/3WG
        DSTBJqAt8efKeTBbREBc4tjUk4wgRcwgRVsvTwdLCAsES7y7dY8ZxGYRUJVoeHYebCqvgI3E
        oZUrGSE2yEvMvPQdLM4JdNKxHXPA4kICxhKPjq2HqheUODnzCQuIzQxU37x1NvMERoFZSFKz
        kKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgMtzR2M21d90DvEyMTBeIhR
        goNZSYRXtUsrRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5O
        qQamSdb9ImfEOrf+2TDr0fYUvWvFTnv3snc8mHW+1npt5w+j86ElDttkr5yXqr9z3tabZcmb
        QtGiOYx7O8NsNq7xXT3/8cM5Mslvp79f+FWpMk4pzP3zh/usYjlaylLPzwpsTIqf3rgnQY/T
        f+4U+Vv7p3od3bhr/v3ZD6aUR6ct/ipxJVK7NFB8woHodbo9gVN2cOdLmHex6abdUn3U2iu3
        TrymuPaeo/DTlZeCVO/OWpTvdDO6q25RWYDdLPFsx+Y3Mnqr9toKrRETm6Fn/c7544nFVWl/
        k71lZjQ8brS7ffSuoN9ePpOLIu/Xuce6+lRfbZW62Bdu9CzplpJ4+jv79Rz3wuOvxKrs/JHz
        722VEktxRqKhFnNRcSIAaaqqBfICAAA=
X-CMS-MailID: 20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
        <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Fri, Mar 31, 2023 at 08:37:15PM +0900, Kyungsan Kim wrote:
>> >> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>> >
>> >This sounds dangerously confused.  Do you want the EXMEM to be removable
>> >or not?  If you do, then allocations from it have to be movable.  If
>> >you don't, why go to all this trouble?
>> 
>> I'm sorry to make you confused. We will try more to clearly explain our thought.
>> We think the CXL DRAM device should be removable along with HW pluggable nature.
>> For MM point of view, we think a page of CXL DRAM can be both movable and unmovable. 
>> An user or kernel context should be able to determine it. Thus, we think dedication on the ZONE_NORMAL or the ZONE_MOVABLE is not enough.
>
>No, this is not the right approach.  If CXL is to be hot-pluggable,
>then all CXL allocations must be movable.  If even one allocation on a
>device is not movable, then the device cannot be removed.  ZONE_EXMEM
>feels like a solution in search of a problem

We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
Also, not all kernel objects can be allocated from ZONE_MOVABLE.

ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.

