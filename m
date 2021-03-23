Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B93455DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 04:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWDBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 23:01:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19352 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCWDB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:01:26 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210323030124epoutp04f430247ffc3183a48489fd24a364fd0f~u2YWtUeiN2280422804epoutp04E
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 03:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210323030124epoutp04f430247ffc3183a48489fd24a364fd0f~u2YWtUeiN2280422804epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616468484;
        bh=zBS8pwQVYwk/Dc+dG60rDT0FuBHEKko+RRMZ08todfw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GtCUyKg4rS67yZeQQvZcmr3BK3HaRW/6X06eRDKA79+VX9jWot6gpogiO9NyjGGDY
         LpnXsa6HmahUz+coj7nlPSy6E4nhxdUoAnxYHyUMOtkLPqA0I00jZjTZD7EpK8OSSF
         AswXHUGSVSsmes+L+1i+vtwgLnevyY8DQmTNbM2U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210323030123epcas1p283ad5d568f2a1e6a2220b1eee9c252fc~u2YWLLu_j0184801848epcas1p23;
        Tue, 23 Mar 2021 03:01:23 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F4GNL60P2z4x9QF; Tue, 23 Mar
        2021 03:01:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.12.63458.20A59506; Tue, 23 Mar 2021 12:01:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323030122epcas1p147f5f0b852da3e35e928496737b85f0e~u2YUpHm2t2478424784epcas1p1o;
        Tue, 23 Mar 2021 03:01:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210323030122epsmtrp285c519b915fdba75e16667736fb75baa~u2YUn8Ryl1483914839epsmtrp2T;
        Tue, 23 Mar 2021 03:01:22 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-bb-60595a021871
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.C4.08745.10A59506; Tue, 23 Mar 2021 12:01:22 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210323030121epsmtip27f30b5160f4fafe3846d6e38d6f83351~u2YUTe8JZ0545905459epsmtip2_;
        Tue, 23 Mar 2021 03:01:21 +0000 (GMT)
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
In-Reply-To: <20210322221816.GW1719932@casper.infradead.org>
Subject: RE: [PATCH 1/5] cifsd: add server handler and tranport layers
Date:   Tue, 23 Mar 2021 12:01:22 +0900
Message-ID: <00d901d71f90$cdfd24f0$69f76ed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKnGOaYF8FWW41Vo1OapoCvoUV0QMoPiJ6Am1CcOcBjsy+tqrwuGGg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO6Tk9LbK6Y6n4BRctx7Eh49JSWz9MIWRTdhLIJMFFxrK0BzgD
        RmlrC9ucP1Y3biIwL3NoQYY4uYwtXETAIkPLEFxhCooJTBQjZLBSJ3RTLgIrPZrx73mf93ne
        N8/35eWjwgXch5+mzWQMWlpD4uuwlq7tIUGchA/UksojQfCww4bBHvsSDy7WFeHQvlyCQdux
        Sg6srevmwLsP/ubByRULCudXniHwSscNDN62lOHQcc+lKyqe5cKcOwGwvbEShz87H/Hg9GQX
        DkeOf4/Dm0s9XLg4V4ZHiiizqQinSk0DGHXZPMqjLtYEUO0VTg7VPmzCqZy2JR41MzGCUc3n
        H3Ko+uYhjHI2baGaxh2c2FcSNMpUhk5mDGJGm6RLTtOmhJPRcap3VHKFRBokDYM7SbGWzmDC
        yd0xsUFRaRpXUFL8Ka3JclGxtNFIhkQoDbqsTEacqjNmhpOMPlmjl0r0wUY6w5ilTQlO0mXs
        kkokoXKXUq1JLb42gerzhZ9fKD+LmZCS9QWIBx8QO8Cf7afQAmQdX0i0IeB23ddctphFQNf1
        FpwtnAgoXVjmFSB8t2V6ZjPLWxBQOHURYYspBFxrvIqtzsWJILD8vBNfxSIiEBRMtbrHokQz
        BnoXvuKsNjwIJbA+HXVjLyIKtFw96TZghB+Y7qt18wIiDNhH8zAWbwA3zoy7MUpsBa2OMpQN
        IQbzE1VcdlkUqBwyoaxGBEqP5LrDAaLaA9gLm3msYTeY/anohdkL/NXzkvcBzscdOBvzEJjp
        fCHJR8Dks3AWy8BwfQN3VYIS20G9JYSlfcHlxbMIu3Y9ePxvIZedIgD5uUJW4geKB7s4LN4M
        CvKe8I4hpHlNMPOaYOY1Acz/L6tAsB8Rb0ZvzEhhjFJ96NrPbkLcRxCgaENOOJ4EWxEOH7Ei
        gI+SIkH2/ni1UJBMH/yCMehUhiwNY7QictdTH0d9NibpXFekzVRJ5aEymQzuUOxUyGXkJgEt
        GVMJiRQ6k0lnGD1jeOnj8D18TBy0f+rp6/vyv4m0+Pd9FGcb8s2WjVuC45Vn+h2tYjUYi7gg
        +EMURtQvdCjfG/TsHr2+yzl1yXNMkfyD/yb5gWxh7pVfogfvDxQN1o3EmW71ndbHdN6vqdF7
        g8DIOc3eu/5kxMbEjz31K1V3fj8X7Kh+95HsnGPBj9Zma6K/6zx6ujVOuefgAVgR6HfJMZS4
        IdbyYbXtUP/egYC5XtvbJ167uaXqk21bfw0xhT//R33e+9S9mobflpp8y49aiZLyZq/+xoHe
        Ze/0hNrPKCI0L+nVB/FC4tss2+FK4lZ3j1Wx5w3dl3nR74tm35xJ7bI9fCvHbt8Wl75Psl/V
        MG4bThTGqOfLSMyYSksDUIOR/g8xNy5gjQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/ne889Rfa4bnyVidswpx/yY75IMbTHGCWbtLXuTo+06tzu
        qfzadLYKZ9fkt7sTZZnEWlfqUsKdSor8KD+iJSpZHdJC03Xc3Uz/vff+vN7vvf/40KToA/Sh
        E5WpnFopT5ZQnrDCKvELIGJ2yBbm5AN82NYEcUO/XYh/F+so3D92DuKmEwUELiquI/DLzq9C
        3Oe4TeIRx0+Aa+40QvzitpHCtnd/OV3OdwHOapXi6tICCt8c+ijEA31WCrfnXqJwi71BgH//
        MlKrxaxeo6NYg+YZZKv0HUK27JqUrb48RLDVbzQUm2W2C9nBnnbIll/pItiS8jbIDplmsqZu
        GxExKcYzJJ5LTkzn1EGhMs/dOfd7SNVR0b7CvItQA85N1gKaRswSNDDoqwUetIgxA/TIscup
        EeOL6h82k27EG1mtvBZ4/kU+AXS2tYRyMhQTgMZG77q0mPFH2s+VAidEMo8gKtXlC9wJG0Bl
        OjvhpDyYEGT50eHS3kw4qrh3ypWGzBw00Fzk8r2Y5ai/4wh06ymo8UI3dK4gmUCUXQqcNsn4
        oUqbkXQPnYVGeq4K3CPCUUGbhnQzYmQ4lk2eAN76cU36/036cU36cYnLAF4H0zkVn5KQwger
        Fim5vYG8PIVPUyYE7tyTYgKuN5BKzaDm+rdACyBoYAGIJiVir8zt0TKRV7x8/wFOvSdOnZbM
        8RbgS0PJNK+n2sY4EZMgT+WSOE7Fqf9dCdrDR0PcDPXfpihjorLIN4+XtphiM6ZGLltYbMge
        nvDF//2EZR8z2Lolrb31qLf4U6lmUJl/6rlE/Hb2ytCuysW5W+cmyw6uMZkjU/POrCtve0nX
        rnQYkqy3cgq3RAY/2OSYZd9qXV4Y3Lq+6bNwwX4F96HXGkJXmTMVe8M21E/NCDqba8x6/7oQ
        vFKkvz1pJA0+Y7wKRm+e0RT25NtoXqwcFlV0+9mj1tb6xJqj4rsqRu6FHFgw/xBuXH+8Pb2v
        xOZ9fnje6KQH0uakfXTcxB2W8PCamLSGNdaJYZ1gMC5US4fJthgd0fIBwK2KiJg9xtM/9Z2b
        YKbwxQqwserG6VHFsFoC+d3yYCmp5uV/AB1dI011AwAA
X-CMS-MailID: 20210323030122epcas1p147f5f0b852da3e35e928496737b85f0e
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Mar 22, 2021 at 02:13:40PM +0900, Namjae Jeon wrote:
> > +#define RESPONSE_BUF(w)		((void *)(w)->response_buf)
> > +#define REQUEST_BUF(w)		((void *)(w)->request_buf)
> 
> Why do you do this obfuscation?
I don't remember exactly, but back then, It looked easier...
> 
> > +#define RESPONSE_BUF_NEXT(w)	\
> > +	((void *)((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
> > +#define REQUEST_BUF_NEXT(w)	\
> > +	((void *)((w)->request_buf + (w)->next_smb2_rcv_hdr_off))
> 
> These obfuscations aren't even used; delete them
They are used in many place.
./smb2pdu.c:            *rsp = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            err_rsp = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            rsp_hdr = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:    struct smb2_hdr *hdr = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:    struct smb2_hdr *rsp = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:    rsp_hdr = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            rsp = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            rsp = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            hdr = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            hdr = RESPONSE_BUF_NEXT(work);
./smb2pdu.c:            rsp = RESPONSE_BUF_NEXT(work);

./smb2pdu.c:            *req = REQUEST_BUF_NEXT(work);
./smb2pdu.c:            rcv_hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    struct smb2_hdr *req_hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    struct smb2_hdr *req = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    rcv_hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:            req = REQUEST_BUF_NEXT(work);
./smb2pdu.c:            req = REQUEST_BUF_NEXT(work);
./smb2pdu.c:            hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    req_hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:            hdr = REQUEST_BUF_NEXT(work);
./smb2pdu.c:    req_hdr = REQUEST_BUF_NEXT(work);
> 
> > +#define RESPONSE_SZ(w)		((w)->response_sz)
> > +
> > +#define INIT_AUX_PAYLOAD(w)	((w)->aux_payload_buf = NULL)
> > +#define HAS_AUX_PAYLOAD(w)	((w)->aux_payload_sz != 0)
> 
> I mean, do you really find it clearer to write:
> 
> 	if (HAS_AUX_PAYLOAD(work))
> than
> 	if (work->aux_payload_sz)
> 
> The unobfuscated version is actually shorter!
Yep, looks better, Will fix it.

Thanks for your review!


