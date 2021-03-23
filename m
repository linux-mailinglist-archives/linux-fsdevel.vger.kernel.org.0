Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D834561C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 04:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWDQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 23:16:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:60007 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhCWDQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:16:06 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210323031604epoutp0199c0a046f7575d0de277ae26547dd01f~u2lJ56-U82242822428epoutp01b
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 03:16:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210323031604epoutp0199c0a046f7575d0de277ae26547dd01f~u2lJ56-U82242822428epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616469364;
        bh=PfIewouVH2Ir+58txrjoFu9xSKAXnOYq8B7QFAr/zSc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IWcPWQCeyFfroT539q/egcrwFCXH3+bxEDcknTNiPWJOdxpVd59jl7dEQe/Km2t2h
         7vWJMl8Jv0JMbjKnWvXEL+EH8zm1/wTk+tKUFseGYRZrGqa8Fxn+gqFdgiZOJ4z+hw
         k+ObvwUGQhLAi6b6fNgM9c+Q3c7P7B67ucGeA5GU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210323031603epcas1p14af7d0fd77eb3705c18dea20a9f21535~u2lJBQ2L-2643826438epcas1p1b;
        Tue, 23 Mar 2021 03:16:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F4GjG0q0lz4x9Q8; Tue, 23 Mar
        2021 03:16:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.79.22618.17D59506; Tue, 23 Mar 2021 12:16:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210323031600epcas1p4f611d0e4ebee1a9bb6a07356f0f232fd~u2lHAtkK32263122631epcas1p4F;
        Tue, 23 Mar 2021 03:16:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210323031600epsmtrp28325c8cc037f775be1c98769a8b20e56~u2lG-gzRO2219922199epsmtrp2Q;
        Tue, 23 Mar 2021 03:16:00 +0000 (GMT)
X-AuditID: b6c32a38-e4dff7000001585a-83-60595d713a7a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.66.13470.07D59506; Tue, 23 Mar 2021 12:16:00 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210323031600epsmtip2fd9bc04f1ff2bfb158bae1d4f8cfbd76~u2lGvHL-71604416044epsmtip2R;
        Tue, 23 Mar 2021 03:16:00 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>, <smfrench@gmail.com>,
        <senozhatsky@chromium.org>, <hyc.lee@gmail.com>,
        <viro@zeniv.linux.org.uk>, <hch@lst.de>, <hch@infradead.org>,
        <ronniesahlberg@gmail.com>, <aurelien.aptel@gmail.com>,
        <aaptel@suse.com>, <sandeen@sandeen.net>,
        <dan.carpenter@oracle.com>, <colin.king@canonical.com>,
        <rdunlap@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>
In-Reply-To: <20210323031242.GA1719932@casper.infradead.org>
Subject: RE: [PATCH 1/5] cifsd: add server handler and tranport layers
Date:   Tue, 23 Mar 2021 12:16:00 +0900
Message-ID: <00da01d71f92$d9c76a50$8d563ef0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKnGOaYF8FWW41Vo1OapoCvoUV0QMoPiJ6Am1CcOcBjsy+tgLfBwFHAYenNeWqzZTjcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHdx+9bQm4a4FxxqLAzRyxsdhSiscJC3HO3WT7A+ZkyDSlwg10
        lrbpLUMEs2p4DUGozsgKgrANHI/Baqc8RlA6ggwTpmMOcFMQ3HgMX6C8YW0vy/jv8/ud7/n+
        zvecHAEmmiN8BWqtkTFoVRqKcMOv2LdKJIZDB+KkDRHwxFQPDrsml/lwsbaAgJMr53HYU1SJ
        wm9rO1F45/5jPhxbbcHg/OosAn9s68bhry2lBJz6w6ErOP2MB7P6xLD1+0oC1k+P8OE/Y3YC
        DprLCdi73MWDi3OlRIQXbTEVEHSJ6RZON1v+5NOXL4np1ovTKN06YCLorKZlPv304SBO274a
        RukG2284PW3dTFtHp9BI91hNWBKjSmAM/ow2Xpeg1iaGU+/tU76tVIRKZRLZTriD8teqkplw
        as/7kZK9ao0jJ+X/qUqT4mhFqliW2v5WmEGXYmT8k3SsMZxi9AkavUyqD2JVyWyKNjEoXpf8
        pkwqDVY4lHGapJpThbg+h3/03Nl7iAnp5uUhQgEgQ0B1cZ+D3QQisgkBt5ey1opnCFgd6cW5
        4gUCZmqGHYXAtaW8OZXrtyEg6/EMwhXjDtH8dczpS5ASsLLUTjjZi9wG8savumwx0oaDGwsn
        UeeCkAwD55r6XSJPci+4cu2si3FyC7hR9oXLyIPcCaqthWu8EXR/OYo7GSP9wNWpUowL4Q/m
        H1bxnKfzIqNBpdWbk3iBks+zMedcQNYKwS8/3UU4/R7QMjHM59gTTHTZ1tgXTD9qI7iU6eBp
        +5p9LgLGZsM5loOBhkbXKIzcChpatnPtANC8eAHhxm4Aj57n8zgXD5CbLeIkW8Dp23aU49dA
        Xs4TfhFCWdblsqzLZVkXwPL/sIsIXoO8wujZ5ESGlelD1r+1FXF9ATFsQi5MPQnqQFAB0oEA
        AUZ5eWR+FBMn8khQpR1jDDqlIUXDsB2IwnHTZszXO17n+ENao1KmCJbL5TAkdEeoQk75eByW
        DilFZKLKyBxhGD1j+G8fKhD6mlDofb4fPdj00uLhzeSdxqqKuq7AmEB+8oPUCJOfTRswe2ms
        LsQnMCbFrSfj3Yy44FjdYOZuUV129Tdn9r9uO4rXL8VW7FpQNI5/smmfqOH4tdF0+4kX5afU
        c9A+ECQFtMj360z9zyPHqeWND+ilDfK4Hxbg7wfq/FZbJo706suyBf1Jn5W8k757f8XNDzR1
        9X9/lyZu21RUVq3MkLubc4h7uUOy9lTp+HBnUb+PXKzL/0tYvHAo8WXrTfvdZuHc0MdGyRvx
        Ia+ao9Tm4kD24IdRIzAy/1hWwK3GpcsBk9l9M2eMhcjzFU/1/Z7OhYLo61VB/Gn3kiiS2ma0
        n9yVFm0up3A2SSUTYwZW9S+1ttRqiwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSvG5BbGSCwebnhhaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i7d3gOp6
        +z6xWrRe0bLYvXERm8Xaz4/ZLd68OMxmcWvifDaL83+Ps1r8/jGHzUHEY1ZDL5vH7IaLLB47
        Z91l99i8Qstj94LPTB67bzawebTu+Mvu8fHpLRaPLYsfMnms33KVxePzJjmPTU/eMgXwRHHZ
        pKTmZJalFunbJXBlrOruZyloZ6+YOvkeYwPjSdYuRg4OCQETifk7y7sYuTiEBHYzSizauoOl
        i5ETKC4tcezEGWaIGmGJw4eLIWqeM0pMW3yCFaSGTUBX4t+f/WwgtoiAjkTXy+2sIEXMAqdY
        JDb2LmSF6DjNJHG/bTM7SBWngI3E1B03wDqEBdwkth2YDGazCKhKnJg3hRnE5hWwlFi+qR/K
        FpQ4OfMJC8gVzAJ6Em0bGUHCzALyEtvfzmGGOFRB4ufTZWDPiAiESSzaJApRIiIxu7ONeQKj
        8Cwkg2YhDJqFZNAsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEJwMtzR2M
        21d90DvEyMTBeIhRgoNZSYS3JTwiQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Ykl
        qdmpqQWpRTBZJg5OqQYmLmO7msWFS3ad7V+vfsnbKuDu9HV/Czo4g9zn1TU9nO+QfXamgnI0
        i/PFNQ6HdvK8PPFd4ft0YfU33Z/2rI+sWNksuCP+02TDBQzPq94X8m8Wm+i8T8ZCMFwjNvSh
        t8/+KzseTXq3/cgU8/Jfa+9oSbzOeFLF0Pj36PEFdkY8U+WqLr3dIWgW4yTV7/9j+8neumQ+
        7wL/zPfv8sR9uNc+5K7f+v/r01m7yrNOrvC9dV1W65Tx7ASDNf/bBLP2Pznxqn1/B9fF/zvn
        PuMMO7nUPyx8J/87zeVvciwT5zOvWXzCw9PvtCQHt4i4o+25zUkzHDJXNHK5X7tRWStxZ6Z0
        g65q7PSNh1580ovxsN6wVImlOCPRUIu5qDgRACDoB9h1AwAA
X-CMS-MailID: 20210323031600epcas1p4f611d0e4ebee1a9bb6a07356f0f232fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7@epcas1p1.samsung.com>
        <20210322051344.1706-2-namjae.jeon@samsung.com>
        <20210322221816.GW1719932@casper.infradead.org>
        <00d901d71f90$cdfd24f0$69f76ed0$@samsung.com>
        <20210323031242.GA1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Mar 23, 2021 at 12:01:22PM +0900, Namjae Jeon wrote:
> > > On Mon, Mar 22, 2021 at 02:13:40PM +0900, Namjae Jeon wrote:
> > > > +#define RESPONSE_BUF(w)		((void *)(w)->response_buf)
> > > > +#define REQUEST_BUF(w)		((void *)(w)->request_buf)
> > >
> > > Why do you do this obfuscation?
> > I don't remember exactly, but back then, It looked easier...
> > >
> > > > +#define RESPONSE_BUF_NEXT(w)	\
> > > > +	((void *)((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
> > > > +#define REQUEST_BUF_NEXT(w)	\
> > > > +	((void *)((w)->request_buf + (w)->next_smb2_rcv_hdr_off))
> > >
> > > These obfuscations aren't even used; delete them
> > They are used in many place.
> 
> Oh, argh.  patch 2/5 was too big, so it didn't make it into the mailing list archive I was using to
> try to review this series.  Please break it up into smaller pieces for next time!
Okay:)
Thanks!

