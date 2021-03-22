Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE03452F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCVXUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 19:20:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54067 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCVXUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:20:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210322232002epoutp043de969ecf76566c2dbd8512e117865e9~uzXFVfmhY2786527865epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 23:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210322232002epoutp043de969ecf76566c2dbd8512e117865e9~uzXFVfmhY2786527865epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616455202;
        bh=yowKQ1DnxB8uGC1tQdSiUvOwMNgjSuCBnJg0zNuQ6PE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CD9dyxQ6tZoGEMIn4RgZVLxu9s50KNITXdxKjCkUQUAbtcN1p5xceaPhOVlu4YcOw
         VXThFdv9/FX+3M+dicKo5ide/BkaOIJUp3f3T4XxIRbfXvPD+YgFivJu0SnOdj+d2s
         y83SjInUB9aLT8Nj0Q2kCOqoHfQr5kiNLNZz4Cqs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322232002epcas1p1bd6995b330ced2b6df351969588303e7~uzXEtgrgz0920509205epcas1p1G;
        Mon, 22 Mar 2021 23:20:02 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F49Sx4sfBz4x9Pp; Mon, 22 Mar
        2021 23:20:01 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.01.02418.12629506; Tue, 23 Mar 2021 08:20:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210322232000epcas1p28c05deccaa1120af13d28963a593a2a7~uzXDUgWB43231532315epcas1p2H;
        Mon, 22 Mar 2021 23:20:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322232000epsmtrp167db0ff674fa23739420669df358175d~uzXDTUBtv0793707937epsmtrp18;
        Mon, 22 Mar 2021 23:20:00 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-90-605926213cf2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.7B.08745.02629506; Tue, 23 Mar 2021 08:20:00 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210322232000epsmtip257b5a3c74ffd1dcd5ded4c027b94b782~uzXDEqXag1241312413epsmtip2S;
        Mon, 22 Mar 2021 23:20:00 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>, <smfrench@gmail.com>,
        <senozhatsky@chromium.org>, <hyc.lee@gmail.com>,
        <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <ronniesahlberg@gmail.com>, <aurelien.aptel@gmail.com>,
        <aaptel@suse.com>, <sandeen@sandeen.net>,
        <colin.king@canonical.com>, <rdunlap@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>,
        "'Dan Carpenter'" <dan.carpenter@oracle.com>
In-Reply-To: <20210322065011.GA2909@lst.de>
Subject: RE: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Date:   Tue, 23 Mar 2021 08:20:00 +0900
Message-ID: <009c01d71f71$e1a5e470$a4f1ad50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKnGOaYF8FWW41Vo1OapoCvoUV0QJx6VhoAkDjIaQCMP/z3QDRv4r9quv+OfA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmrq6iWmSCwdS1KhaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i7d3gOp6
        +z6xWrRe0bLYvXERm8Xaz4/ZLd68OMxmcWvifDaL83+PszoIe8xq6GXzmN1wkcVj56y77B6b
        V2h57F7wmclj980GNo/WHX/ZPT4+vcXisWXxQyaP9Vuusnh83iTnsenJW6YAnqgcm4zUxJTU
        IoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygH5UUyhJzSoFCAYnF
        xUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZbw/3sBb8
        Zanoa17J1MD4hLmLkZNDQsBEYsHiRjBbSGAHo8TJSRZdjFxA9idGibPLnjBCOJ8ZJdru9TPB
        dHROncMEkdjFKPH45X92iPaXjBLf7sqC2GwCuhL//uxnA7FFBNQkzvxsYwdpYBbYwSKxceY1
        sH2cAtoSt/YdBlrBwSEs4CyxcasMSJhFQFXiVHsPI4jNK2ApsWjDJTYIW1Di5MwnLCA2s4C8
        xPa3c6BeUJD4+XQZK8QuP4k7V89A1YhIzO5sYwbZKyGwmFNi/f8pUB+4SKz4/AGqWVji1fEt
        7BC2lMTLfpBDOYDsaomP+6FKOhglXny3hbCNJW6u38AKUsIsoCmxfpc+RFhRYufvuYwQa/kk
        3n3tYYWYwivR0SYEUaIq0XfpMNQB0hJd7R/YJzAqzULy2Cwkj81C8sAshGULGFlWMYqlFhTn
        pqcWGxYYIkf1JkZw6tcy3cE48e0HvUOMTByMhxglOJiVRHhbwiMShHhTEiurUovy44tKc1KL
        DzGaAoN6IrOUaHI+MPvklcQbmhoZGxtbmJiZm5kaK4nzJhk8iBcSSE8sSc1OTS1ILYLpY+Lg
        lGpgMqrdW6MTe/RfXFnz1v3b20Tqa7r7Ll6duHLi2hczJDycf89069g4qaeueSLbDX/+e3k3
        12ov3Sz5akb2nTchi39NXSvxl/1JRd4H28L+7PuromM1fT2Cz24XWLNlp+eF5vKV9w8e+Xr8
        9+IHznZ/fwr4Km86LnKff/7ZbnWvpuwU8znK5TXXQyyuOOmKTmM6uG1Z/+vF3XfD8vd9ipnG
        XX1M+NkdLe2Pq/rzJr/pdyy8M/eB423J/ct/s381v3zgWPn3fbPy7oYeXCxbs3xyR/91NZ+5
        DFe5RMsCjVWK+y9dam04d1Kp/sG6R8apAtEduo/zJhTsnKBy7+wC2bKFn6/6vZJO+SHbcG1P
        34F5768qsRRnJBpqMRcVJwIAJ4seUIYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSvK6CWmSCwbVXGhaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i7d3gOp6
        +z6xWrRe0bLYvXERm8Xaz4/ZLd68OMxmcWvifDaL83+PszoIe8xq6GXzmN1wkcVj56y77B6b
        V2h57F7wmclj980GNo/WHX/ZPT4+vcXisWXxQyaP9Vuusnh83iTnsenJW6YAnigum5TUnMyy
        1CJ9uwSujLeHe1gL/rJU9DWvZGpgfMLcxcjJISFgItE5dQ5TFyMXh5DADkaJ60v6oRLSEsdO
        nAGyOYBsYYnDh4shap4zSvxatJkVpIZNQFfi35/9bCC2iICaxJmfbewgRcwCZ1gkVtxuYYbo
        +MUosWHvF0aQKk4BbYlb+w4zgkwVFnCW2LhVBiTMIqAqcaq9B6yEV8BSYtGGS2wQtqDEyZlP
        WEDKmQX0JNo2gpUwC8hLbH87B+pOBYmfT5exQtzgJ3Hn6hkWiBoRidmdbcwTGIVnIZk0C2HS
        LCSTZiHpWMDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgJaGntYNyz6oPeIUYm
        DsZDjBIczEoivC3hEQlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2C
        yTJxcEo1MKWvKNN+eU30hmrNg6fxmstKT7cphC+7WZjUsFb5+p/3+/XaVkUGdOt5G+usnvHh
        Xs/dW3ZfqzSFguLPxu99ZxIxc35Y/XKelUyhuU9/iOpNmZn08uQT7bUMMkkGkx6vXbb/S3Nv
        iybLQuOzW+s3rZ0yTWMiy/EVN5sj7kt0JJgynl7xg7nyv8kjV/FvLzRXHGvbcausXj75Dpu3
        E5/qyuuL3mxZOuV2QbfGUc70lbXWLxiYzVpNy231l0vv0Uucrpz3OSVE9OLcF5axRx+8OXbJ
        XTVh4+5UB85Pr5q2bfBdufOspodZTLZFz8vtelc0rSY3WrH/SUnfdXBbSOg7DuOcBTce3buy
        /qri8+t8D4uUWIozEg21mIuKEwEt1fyQcQMAAA==
X-CMS-MailID: 20210322232000epcas1p28c05deccaa1120af13d28963a593a2a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052206epcas1p438f15851216f07540537c5547a0a2c02
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
        <20210322051344.1706-3-namjae.jeon@samsung.com>
        <20210322064712.GD1667@kadam> <20210322065011.GA2909@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Mon, Mar 22, 2021 at 09:47:13AM +0300, Dan Carpenter wrote:
> > On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
> > > +static unsigned char
> > > +asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch) {
> > > +	if (ctx->pointer >= ctx->end) {
> > > +		ctx->error = ASN1_ERR_DEC_EMPTY;
> > > +		return 0;
> > > +	}
> > > +	*ch = *(ctx->pointer)++;
> > > +	return 1;
> > > +}
> >
> >
> > Make this bool.
> >
> 
> More importantly don't add another ANS1 parser, but use the generic one in lib/asn1_decoder.c instead.
> CIFS should also really use it.
Okay, Let me check it, cifs also...
Thanks!

