Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2ED1AB862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408409AbgDPGrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:47:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10192 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408163AbgDPGrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:47:31 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200416064727epoutp049914d88e77c0a4b9da6369da2ade6236~GOfYVhYHq3168731687epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 06:47:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200416064727epoutp049914d88e77c0a4b9da6369da2ade6236~GOfYVhYHq3168731687epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587019647;
        bh=aYAXJ/MbIpJmoQFqUryNTObxQnaVU2aQ3CBL7V8k3WY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DB3x1FIP90v3wefJnpLqPBN7m8n3oZBGh+ZIQULVy4NnMMD2gmlPunhTflqkLp48c
         tSz7I+fVpV5R74o4KWaxL5N+OxWUasIJyIdMpANnAmq1eRBqeGATwfTHi8ShaD3Hfk
         VsAdEYW9bWyUBnJBQcEb4/pRomn8pcyfC9LD0Gd4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200416064727epcas1p31f13c4177c4d459a0f9aab82d170e137~GOfYAFVI61175811758epcas1p3s;
        Thu, 16 Apr 2020 06:47:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 492qXY70RnzMqYm5; Thu, 16 Apr
        2020 06:47:25 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.37.04402.D7FF79E5; Thu, 16 Apr 2020 15:47:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200416064724epcas1p25697c19824e1c6df85d53fdcbd89c665~GOfVcX5Bx1002810028epcas1p2h;
        Thu, 16 Apr 2020 06:47:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200416064724epsmtrp11f8937e4afed8d34ff4658cd4eb2d6b3~GOfVbZaHa0338903389epsmtrp1l;
        Thu, 16 Apr 2020 06:47:24 +0000 (GMT)
X-AuditID: b6c32a35-ca04b9e000001132-0f-5e97ff7d0e04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.4C.04024.C7FF79E5; Thu, 16 Apr 2020 15:47:24 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200416064724epsmtip1b42c54f5190392a57a1309cddcdc191f~GOfVPh2c42522925229epsmtip1B;
        Thu, 16 Apr 2020 06:47:24 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Matthew Wilcox'" <willy@infradead.org>
In-Reply-To: <TY1PR01MB157894A971A781BE900C5A7590DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Date:   Thu, 16 Apr 2020 15:47:24 +0900
Message-ID: <006a01d613ba$e2e19e10$a8a4da30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE756cOWkSWdyX4fUAG5iBImQRCHAHs2XDjAV3IMHoCBKFRS6mFKQKQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmrm7t/+lxBl/Ws1u8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSy2/DvCavH7xxw2B3aPL3OOs3u0Tf7H7tF8bCWbx+YVWh59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISdjTetdtoKDnBVTn61ja2Bcy97FyMkhIWAi0XV+O3MXIxeHkMAORonzz26xQjif
        GCW+b/vNAuF8Y5RYOm0iI0zLlPt7oRJ7GSVWfDrLCOG8ZJS4cqUZbDCbgK7Evz/72boYOThE
        BIwknp4sBKlhFvjJKNFxZANYDadArMSVS33MIDXCAo4S7WdjQcIsAqoSv1YuYgKxeQUsJTbf
        n80CYQtKnJz5BMxmFpCX2P52DjPEQQoSP58uY4VY5SZxerEARImIxOzONrDXJAQ+s0mcn9gL
        9bOLxPJpV9ggbGGJV8e3QMWlJF72t7GDzJEQqJb4uB9qfAejxIvvthC2scTN9RvAVjELaEqs
        36UPEVaU2Pl7LiPEWj6Jd197WCGm8Ep0tAlBlKhK9F06zARhS0t0tX9gn8CoNAvJX7OQ/DUL
        yQOzEJYtYGRZxSiWWlCcm55abFhgiBzVmxjBiVTLdAfjlHM+hxgFOBiVeHgNXk6LE2JNLCuu
        zD3EKMHBrCTCu8N/epwQb0piZVVqUX58UWlOavEhRlNgsE9klhJNzgcm+bySeENTI2NjYwsT
        M3MzU2Mlcd6p13PihATSE0tSs1NTC1KLYPqYODilGhgt1l076qw5hfnAE5HjF1aq5hqzJn87
        ePHZv3qZS2HpiyQvux+7njJvS0TpRNlpcfL70k4dfdh3x7Dkd2KbarSrZYz+xr7OJIkl870y
        //28GJnQdfENp4376/igi60Hzdf+dXDiV5RbYPnBpyvNf0LU9JV+O1qr7r3s+rP3l61guXxY
        VlPq46tKLMUZiYZazEXFiQA/S1cRugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnG7N/+lxBs/Xqli8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSy2/DvCavH7xxw2B3aPL3OOs3u0Tf7H7tF8bCWbx+YVWh59W1Yx
        enzeJBfAFsVlk5Kak1mWWqRvl8CVsab1LlvBQc6Kqc/WsTUwrmXvYuTkkBAwkZhyfy9LFyMX
        h5DAbkaJGScOM0MkpCWOnTgDZHMA2cIShw8XQ9Q8Z5RouTGRFaSGTUBX4t+f/WwgNSICRhJP
        TxaC1DAL/GWU+H66gQmiYQmTxNG1d8C2cQrESly51Ac2VFjAUaL9bCxImEVAVeLXykVMIDav
        gKXE5vuzWSBsQYmTM5+wgJQzC+hJtG1kBAkzC8hLbH87B+pMBYmfT5exQpzgJnF6sQBEiYjE
        7M425gmMwrOQDJqFMGgWkkGzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR
        HE9amjsYLy+JP8QowMGoxMNr8HJanBBrYllxZe4hRgkOZiUR3h3+0+OEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYGxnVuNQu+ckq/Tg6MH9qxccsFVV
        chZbxf/fQjHmZqhmyjG/jfldwfNzin5pzHpVxxu89+uZjcYnrEtWmPn0CxxmXbGnc8aJV1F/
        Je3iFfsKrpjmN5Q+5miY+8jpSNsZo/e13W9rYnrDs/nKKrrFTp62fVZt+e//0yka3cfZbqje
        UyuYvEJfTomlOCPRUIu5qDgRAIybIcWjAgAA
X-CMS-MailID: 20200416064724epcas1p25697c19824e1c6df85d53fdcbd89c665
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200413094319epcas1p236a2145766a672f718030b4199b82956
References: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
        <20200408112152.GP21484@bombadil.infradead.org>
        <CGME20200413094319epcas1p236a2145766a672f718030b4199b82956@epcas1p2.samsung.com>
        <TY1PR01MB157894A971A781BE900C5A7590DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Please leave at least 24 hours between sending new versions so that
> > you can collect all feedback relating to your change, and we don't see
> > discussion fragment between different threads.
> 
> Thanks for good advice!
> 
> > > +		ts->tv_sec += (time_10ms * 10) / 1000;
> > > +		ts->tv_nsec = (time_10ms * 10) % 1000 * NSEC_PER_MSEC;
> >
> > I find this more confusing than the original.
> 
> The parentheses were intended to group conversions into milliseconds, but
> were not necessary from an "operator precedence" perspective.
> 
> 
> >
> > 		ts->tv_sec += time_10ms / 100;
> > 		ts->tv_nsec = (time_10ms % 100) * 10 * NSEC_PER_MSEC;
> >
> > is easier to understand for me, not least because I don't need to worry
> > about the operator precedence between % and *.
> 
> If I use '100' for the divisor of '10ms', I find it difficult to
> understand
> the meaning of the operation.
> 
> When using '100' for the divisor, I think cs (centi-sec) is easier to
> understand than 10ms.
> Which do you prefer, time_10ms or time_cs?
Can you resend the patch again after changing to time_cs ?

> 
> 
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

