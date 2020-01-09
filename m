Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDCC13634D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAIWhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 17:37:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:37168 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIWhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:37:46 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109223742epoutp04805a212cf9144c87fd95580d4f0f9cfe~oWPFMPM7N1979219792epoutp049
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 22:37:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109223742epoutp04805a212cf9144c87fd95580d4f0f9cfe~oWPFMPM7N1979219792epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578609462;
        bh=kpZeS9gmOjU0iGT7GVawXCel1IcV5HDhplVN94HkDiU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N6pwx5l1sjkNxaQmk49Q4bFPvQSU1UUKj1yDNVF8viQUG3UrgcKQP9vwpOzgj4RXN
         G1cIltokhNLAWjwsnH+2TJ6s0uEBAxd5U8BmCfK2x14hANNh5Gqf0WWHC3Wu4gJtSj
         xK2M0eTjiFl5bYl6hSEg95tQgzJ+GYLGOUN1ouHM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200109223742epcas1p33f9c699329d55b14b611ca19c69a053b~oWPErdRI20785107851epcas1p35;
        Thu,  9 Jan 2020 22:37:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47v1GF2XrszMqYlp; Thu,  9 Jan
        2020 22:37:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.A6.57028.53BA71E5; Fri, 10 Jan 2020 07:37:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200109223740epcas1p14a99323e0a0a2fecc3805359380a975e~oWPDQfLIV1000710007epcas1p1p;
        Thu,  9 Jan 2020 22:37:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109223740epsmtrp1092591eab065dc9844808e82fd63f46a~oWPDPwri-2593825938epsmtrp1h;
        Thu,  9 Jan 2020 22:37:40 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-cd-5e17ab35215a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.A5.06569.43BA71E5; Fri, 10 Jan 2020 07:37:40 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109223740epsmtip21ef3f9239c77d681b231ffb58aa31ef0~oWPDDJMX21908619086epsmtip2w;
        Thu,  9 Jan 2020 22:37:40 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <tytso@mit.edu>,
        "'Gabriel Krisman Bertazi'" <krisman@collabora.com>
In-Reply-To: <20200105165115.37dyrcwtgf6zgc6r@pali>
Subject: RE: [PATCH v9 10/13] exfat: add nls operations
Date:   Fri, 10 Jan 2020 07:37:40 +0900
Message-ID: <001501d5c73d$66954a10$33bfde30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwHz+Lr1AtmMBwQCEsM+eKazQ8Cw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmnq7pavE4g+k9whbNi9ezWaxcfZTJ
        YtHR6ywW1+/eYrbYs/cki8XlXXPYLCae/s1kseXfEVaL1p6f7BaX3n9gceDy2HF3CaPHzll3
        2T32z13D7rH7ZgObR9OZo8wefVtWMXp83iTncWj7G7YAjqgcm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygI5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ
        +cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZX6/3MBV0clbs3NfA2sA4ib2L
        kYNDQsBEYsZcli5GLg4hgR2MEnvnNLNDOJ8YJV5132LsYuQEcr4xSnTuDIBpWLg5GaJmL6PE
        ya9nobpfMkq07rjCAtLAJqAr8e/PfjYQW0TAQmLH0e9sIEXMAh1MEte3gDgcHJwCxhJvv1WB
        1AgLmEu8WXqXHcRmEVCVmPRlJZjNK2Ap8eXEVChbUOLkzCdg85kF5CW2v53DDGJLCChI/Hy6
        jBVil5vEljlb2SBqRCRmd7Yxg+yVEJjMLtF+YScrRIOLxKfZ56CahSVeHd/CDmFLSbzsb4MG
        S7XEx/1QJR2MEi++20LYxhI3129gBSlhFtCUWL9LHyKsKLHz91xGiLV8Eu++9rBCTOGV6GgT
        gihRlei7dJgJwpaW6Gr/wD6BUWkWksdmIXlsFpIHZiEsW8DIsopRLLWgODc9tdiwwBA5pjcx
        glOvlukOxinnfA4xCnAwKvHwZgiLxwmxJpYVV+YeYpTgYFYS4T16QyxOiDclsbIqtSg/vqg0
        J7X4EKMpMNwnMkuJJucD80JeSbyhqZGxsbGFiZm5mamxkjgvx4+LsUIC6YklqdmpqQWpRTB9
        TBycUg2MTcma79dKHw7t/x48P/jPkm+c929fKWjpDw3KilKPO+dZcEgyneHhh88/pu85/+34
        xsdad5/9O19w0nFZt4r11KW26S1q7351LWDk2e9UIz9ja5NU7nZH//3qApe+pcZOU/3T6m/k
        vWTzZMH4rkOPt/xXzm4ofd9ueFlkanXA3v5NdSeV/MLfKLEUZyQaajEXFScCAPVv7sHTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSvK7JavE4g+WHlS2aF69ns1i5+iiT
        xaKj11ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWrT0/2S0uvf/A4sDlsePuEkaPnbPu
        snvsn7uG3WP3zQY2j6YzR5k9+rasYvT4vEnO49D2N2wBHFFcNimpOZllqUX6dglcGV+v9zAV
        dHJW7NzXwNrAOIm9i5GDQ0LARGLh5uQuRi4OIYHdjBLd3z4AxTmB4tISx06cYYaoEZY4fLgY
        ouY5o8SFfc/ZQGrYBHQl/v3ZD2aLCFhI7Dj6nQ2kiFlgEpNE08ff7HAdj+4tYgOZxClgLPH2
        WxVIg7CAucSbpXfBlrEIqEpM+rISzOYVsJT4cmIqlC0ocXLmExYQm1lAW+LpzadQtrzE9rdz
        mCEOVZD4+XQZK8QRbhJb5mxlg6gRkZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem
        5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHopbWDsYTJ+IPMQpwMCrx8GYIi8cJsSaWFVfmHmKU
        4GBWEuE9ekMsTog3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwen
        VANjm8yvV89VpkVrC9yoff38YN4kNetvh/wF47eK9Cv5mX77dn7rqmepl84yJ8zR7c8JmLwz
        t3/u4x+d3HIfL136ff/S3zNn9PobledaiBcYl6SwHUzSSItx3hA7ZbOOJXOn0dawgqiAzXem
        uDYkXnzh8f3uPKMPe0++3By5t8yVw01r7WT9sD/HlViKMxINtZiLihMBLynsqMACAAA=
X-CMS-MailID: 20200109223740epcas1p14a99323e0a0a2fecc3805359380a975e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
        <20200102082036.29643-11-namjae.jeon@samsung.com>
        <20200105165115.37dyrcwtgf6zgc6r@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> > This adds the implementation of nls operations for exfat.
> 
> Hello! In whole patch series are different naming convention for
> nls/Unicode related terms. E.g. uni16s, utf16s, nls, vfsname, ...
> 
> Could this be fixed, so it would be unambiguously named? "uni16s" name is
> misleading as Unicode does not fit into 16byte type.
> 
> Based on what is in nls.h I would propose following names:
> 
> * unicode_t *utf32s always for strings in UTF-32/UCS-4 encoding (host
>   endianity) (or "unicode_t *unis" as this is the fixed-width encoding
>   for all Unicode codepoints)
> 
> * wchar_t *utf16s always for strings in UTF-16 encoding (host endianity)
> 
> * u8 *utf8s always for strings in UTF-8 encoding
> 
> * wchar_t *ucs2s always for strings in UCS-2 encoding (host endianity)
> 
> Plus in the case you need to work with UTF-16 or UCS-2 in little endian,
> add appropriate naming suffixes.
> 
> And use e.g. "vfsname" (char * OR unsigned char * OR u8 *) like you
> already have on some places for strings in iocharset= encoding.
Will rename them on v10.

Thanks!

