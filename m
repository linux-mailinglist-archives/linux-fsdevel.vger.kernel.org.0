Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8223CB7171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 04:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfISCOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 22:14:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:51833 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbfISCOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:14:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190919021447epoutp0407cf16f0971131c9bdf81927182e2145~FtTXBXv9f1874318743epoutp04Z
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 02:14:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190919021447epoutp0407cf16f0971131c9bdf81927182e2145~FtTXBXv9f1874318743epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568859287;
        bh=AtgesWOHsfbaq9Kj5/tNceRw+CGKiQA5nLpQb69plM0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rKWvUw2ZrSbofJ0CmbSJBmCqI5tTQi5PiFSD7LuurABB2VWEOko8VSHE6GlYi6ORq
         5+F9ZgUuyFCUd7VO5y3dWidIRg0CDoZlhC2p2Gtj+aG+e/WjrDTZbOTaDey+XQ54H3
         eFCyCD8ToNWkjXtd8EmBijmIHPQLPpV14N8LyASw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919021446epcas1p2edf9dc5c820d110949802d4d8a240250~FtTWVMtnK2148921489epcas1p2r;
        Thu, 19 Sep 2019 02:14:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 46YgQs6yBJzMqYkf; Thu, 19 Sep
        2019 02:14:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.8C.04085.594E28D5; Thu, 19 Sep 2019 11:14:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919021445epcas1p20f7267d354d5a0d247591a85acb4d7d4~FtTU9VPff2483524835epcas1p2z;
        Thu, 19 Sep 2019 02:14:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190919021445epsmtrp2f991922884200bc5a3c66a296fa0b875~FtTU8eW4v1870218702epsmtrp2f;
        Thu, 19 Sep 2019 02:14:45 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-c1-5d82e495be13
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.22.03638.594E28D5; Thu, 19 Sep 2019 11:14:45 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919021445epsmtip166923a5b30b6116e66ba7b196291e6ce~FtTUw13Ly2780227802epsmtip1y;
        Thu, 19 Sep 2019 02:14:45 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>,
        "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linkinjeon@gmail.com>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>,
        <linux-kernel@vger.kernel.org>, <alexander.levin@microsoft.com>,
        <sergey.senozhatsky@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>, "'Ju Hyung Park'" <qkrwngud825@gmail.com>
In-Reply-To: <20190918092405.GC2959@kadam>
Subject: RE: [PATCH] staging: exfat: add exfat filesystem code to
Date:   Thu, 19 Sep 2019 11:14:45 +0900
Message-ID: <008c01d56e90$01420eb0$03c62c10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGT5RAmYrUvbIdPV5wSdu6UWeOkRAHEPqcjASg+jxcBWaTXGQHGgTvdAmfpepEChGr/QAIs0XV3AVAC8PIBuUjzQAFD/owypymulmA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmnu7UJ02xBs8fWVjsm/6U2eL1v+ks
        FnvO/GK3aF68ns3i+t1bzBZ79p5ksbi8aw6bxdHHC9ksHk2YxGSx9vNjdost/46wWlx6/4HF
        gcfj3r7DLB47Z91l99g/dw27R+uOv+weH5/eYvHo27KK0ePzJjmPQ9vfsAVwROXYZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCdq6RQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMlo+n+JteAD
        e8X3XR2MDYzT2boYOTkkBEwkzl+exd7FyMUhJLCDUeLi3VdMEM4nRonlvUugMt8YJfrPP4Nr
        aX5/kBXEFhLYyyixe7EURNErRonpKyYygSTYBHQl/v3ZD9TAwSEiECPR9dgdpIZZYD6zxJav
        n9hBajgFtCTuHjgLZgsLOEr8uHwArJdFQFXi5v1TzCA2r4ClxJTewywQtqDEyZlPwGxmAXmJ
        7W/nMEMcpCCx4+xrRhBbRKBM4tbqa4wQNSISszvbmEEWSwisY5d4+GAuVIOLxML9r6BsYYlX
        x7ewQ9hSEp/f7QU7WkKgWuLjfqiSDkaJF99tIWxjiZvrN7CClDALaEqs36UPEVaU2Pl7LtRa
        Pol3X3tYIabwSnS0CUGUqEr0XTrMBGFLS3S1f2CfwKg0C8ljs5A8NgvJA7MQli1gZFnFKJZa
        UJybnlpsWGCKHNebGMEpWctyB+Oxcz6HGAU4GJV4eAO0mmKFWBPLiitzDzFKcDArifDOMQUK
        8aYkVlalFuXHF5XmpBYfYjQFhvtEZinR5HxgvsgriTc0NTI2NrYwMTM3MzVWEuf1SG+IFRJI
        TyxJzU5NLUgtgulj4uCUamA8aLJMw+bNgszkH0rG5Z8rDh61WaO04/UPxqb+mg2eD/SSRIPu
        P945JZ5z2oIlFxkqg6VFn2ttmdt69HU9v8m3urqL9+duqq7INs0OvvWshF1Gq5ErROO8RMrh
        6B7GOPFfVS/8a38aZStOeyJ/PlRW9XJo/tWQaRtelAo+ejR505yjFRcOKs9SYinOSDTUYi4q
        TgQAu0LOMN8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnO7UJ02xBjM7JC32TX/KbPH633QW
        iz1nfrFbNC9ez2Zx/e4tZos9e0+yWFzeNYfN4ujjhWwWjyZMYrJY+/kxu8WWf0dYLS69/8Di
        wONxb99hFo+ds+6ye+yfu4bdo3XHX3aPj09vsXj0bVnF6PF5k5zHoe1v2AI4orhsUlJzMstS
        i/TtErgymv5fYi34wF7xfVcHYwPjdLYuRk4OCQETieb3B1m7GLk4hAR2M0qs/3yZCSIhLXHs
        xBnmLkYOIFtY4vDhYoiaF4wSu6ZtZAWpYRPQlfj3Zz8bSI2IQIzEiUsCIDXMAiuZJVYufscG
        0TCNRWLa4oMsIA2cAloSdw+cZQexhQUcJX5cPgC2jEVAVeLm/VPMIDavgKXElN7DLBC2oMTJ
        mU9YQBYwC+hJtG1kBAkzC8hLbH87hxniTgWJHWdfg8VFBMokbq2+BlUjIjG7s415AqPwLCST
        ZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHppbWDsYTJ+IP
        MQpwMCrx8P5Qb4oVYk0sK67MPcQowcGsJMI7xxQoxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+
        /1ikkEB6YklqdmpqQWoRTJaJg1OqgXF12FzdEOObeUsY/T3kAh9qLkuQeXjwhr6R8ruPDmll
        0tPPVlUJOuvmBr7O1fA5uVpmVdilB2nCD2fscbCqbPp5/7o/v0+P2pLLrh8q1fYGf/4olPpX
        0mr6OnUfNrXofzJud3O7joc0zjc+5s6zrPD8V6G3rrOmnbmirLPa3TyoXcFBbbnqXyWW4oxE
        Qy3mouJEADZbqN7JAgAA
X-CMS-MailID: 20190919021445epcas1p20f7267d354d5a0d247591a85acb4d7d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a
References: <8998.1568693976@turing-police>
        <20190917053134.27926-1-qkrwngud825@gmail.com>
        <20190917054726.GA2058532@kroah.com>
        <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
        <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
        <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
        <20190918061605.GA1832786@kroah.com> <20190918063304.GA8354@jagdpanzerIV>
        <20190918082658.GA1861850@kroah.com>
        <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
        <20190918092405.GC2959@kadam>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[..]
> Put it in drivers/staging/sdfat/.
> 
> But really we want someone from Samsung to say that they will treat
> the staging version as upstream.  It doesn't work when people apply
> fixes to their version and a year later back port the fixes into
> staging.  The staging tree is going to have tons and tons of white space
> fixes so backports are a pain.  All development needs to be upstream
> first where the staging driver is upstream.  Otherwise we should just
> wait for Samsung to get it read to be merged in fs/ and not through the
> staging tree.
Quite frankly,
This whole thing came as a huge-huge surprise to us, we did not initiate
upstreaming of exfat/sdfat code and, as of this moment, I'm not exactly
sure that we are prepared for any immediate radical changes to our internal
development process which people all of a sudden want from us. I need to
discuss with related people on internal thread.
please wait a while:)

Thanks!
> 
> regards,
> dan carpenter
> 


