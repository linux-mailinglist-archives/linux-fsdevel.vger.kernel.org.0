Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42BD104963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUDjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 22:39:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58787 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUDjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:39:39 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121033934epoutp01127d0ca6ef8a4bcca3b4ba26835e50df~ZEGX0a_uP1418414184epoutp01O
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 03:39:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121033934epoutp01127d0ca6ef8a4bcca3b4ba26835e50df~ZEGX0a_uP1418414184epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574307574;
        bh=uQNbH50lNFfugAkg2yFVCKuYW7I5kKvXlaRcbbWS5PE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=B3HCn4y85BRIz8YqC98ZJyfPmR5Eopx8DxzsZ0pcbwZv23nj1Sy8MBZLJPEwq8ALn
         NIImVF3JPw2rgrBY0Dc2Iaao1yktrXJcYt+X4r85+4x9sHXAL4qNHXX3ZwQODOAm8E
         JuIJ/wGZiB1Sin8lGdBtKIBM/rzEzYOFJh1s0RNs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191121033934epcas1p453727c81c1517e448da6431e4b29b161~ZEGXMrETe2622126221epcas1p4R;
        Thu, 21 Nov 2019 03:39:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47JQKd21fpzMqYkd; Thu, 21 Nov
        2019 03:39:33 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.B1.04406.3F606DD5; Thu, 21 Nov 2019 12:39:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191121033930epcas1p221152c49adc0bcc2a8d2664515dbcbd3~ZEGT5sI0q2663826638epcas1p2a;
        Thu, 21 Nov 2019 03:39:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121033930epsmtrp125cd19ce6e3661c38e62fd26d702e51c~ZEGT5Ba2z1812818128epsmtrp1O;
        Thu, 21 Nov 2019 03:39:30 +0000 (GMT)
X-AuditID: b6c32a38-95fff70000001136-d5-5dd606f3a6b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.AF.03814.2F606DD5; Thu, 21 Nov 2019 12:39:30 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191121033930epsmtip2d8a298d0e2e602ae24814c235b2b4700~ZEGTwHdHB0367903679epsmtip2g;
        Thu, 21 Nov 2019 03:39:30 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?windows-1257?Q?'Valdis_Kl=E7tnieks'?= <valdis.kletnieks@vt.edu>
Cc:     "'Nikolay Borisov'" <nborisov@suse.com>,
        <gregkh@linuxfoundation.org>, <hch@lst.de>, <linkinjeon@gmail.com>,
        <Markus.Elfring@web.de>, <sj1557.seo@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <87255.1574306312@turing-police>
Subject: RE: [PATCH v2 05/13] exfat: add file operations
Date:   Thu, 21 Nov 2019 12:39:30 +0900
Message-ID: <010201d5a01d$48493270$d8db9750$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1257"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQEo1XJlLzywHhHshRBLsQkFEP9+bwE2rzOUAX+3+6QCnhKN6gFMKmQnAnC4oSSopgQxUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0hTURTHu3tvb2/R4rWsDpNqvTJKWO41Z89qEfSDUUJSEWGIvfTprO1t
        7U3J+keyZkloUotcSj+kKAuMNDXTtrQI+2FkvzBTi6IflqmzsjCqzbdi/33uued77vecey+J
        qZsJDZktuHinwFlpYjxe1zpfpxsmnqXqm0sptqCymmAvXLwtY593v8DYpuY2nH3cWE6wf7zv
        5eyfz/twtvb3LTnbMTCIL1ear3m7FWZfxSWF+XpnPmEurq1C5urap7h5+MoMc0v9Z8Lc9a4O
        TyZTrEstPJfBO7W8kG7PyBayTPTaDWkr0owJekbHJLKLaK3A2XgTvTIpWbc62xr0R2tzOWtO
        MJTMiSIdt2yp057j4rUWu+gy0bwjw+pg9I4FImcTc4SsBel222JGr19oDGZutVp6igdwx0/Z
        rpvPbsny0VFZEVKSQMXDSNu5MVZTDQj8pVuL0PggBxC883hwafEdgae68b/ixaefhLTRjODq
        6FlMkvch6GlPDDFB6eD3Lx8R4ihqFVS4C1BIgFEfEbReagyWJUllMKnLYwrhZIqF24VzQ+k4
        FQPtnld4iFVUIhy+XhPmSdBW9naMMUoP/vtnkcQzob6/HJO8aaHhwadwPApOHHRjkoVNcHNv
        DRayAFSJAnpLzxOSYCWUjR5DEk+Gvju1Cok18LHErQh5A2oPDPnC9Q8g+DBiktgAndWX5RLP
        gmujFeFzJ8KXb4fkklQFB9xqKSUGijtawyOMhqLCQcVhRHsjOvNGdOaN6Mwb0c0phFehqbxD
        tGXxIuOIj7zrK2js6cayDaipPakFUSSiJ6gs856mquVcrphna0FAYnSUqun5k1S1KoPL2807
        7WnOHCsvtiBjcPKlmGZKuj34EQRXGmNcaDAY2PiERQlGAz1NRf54lKqmsjgXv4PnHbzzn05G
        KjX5qJLxz/Br1BCzvFK+ZqBbk1lmeTTT81Lw5cb2REcfT/jatH1cXpQfqxS2nFSeiQukFBew
        XwuHc/e/sVYFyG+ZJTcuJvb2Ne7HV21rD6z3uYf7M2fPuZc+WFJjz9t8mjqy5PW6O9OHuoeS
        7z7u7awfIR/2k2VxOwNdDn35KwY2dtC4aOGYWMwpcn8B8MTEctADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO4ntmuxBt92KVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfj/poXFYsu/I6wWl95/YHHg9Ng56y67x/65a9g9dt9s
        YPPo27KK0WP9lqssHp83yXkc2v6GzeP2s20sARxRXDYpqTmZZalF+nYJXBn3+t6zFPxkqjh4
        7QhTA+MUpi5GTg4JAROJW69/snUxcnEICexmlNj9bQ0jREJa4tiJM8xdjBxAtrDE4cPFEDUv
        GCW2zl7JDFLDJqAr8e/PfjYQW0TAVWJuWzNYL7PAR0aJq3s5IRr2MEncXnuQFWQQJ1DD7am2
        IKawgIXE0XY1kHIWAVWJc1MfsIDYvAKWEhN2b4ayBSVOznzCAjHSSGJS53smCFteYvvbOcwQ
        ZypI7Dj7GmqtiMTszjZmiHPCJA42bWaewCg8C8moWUhGzUIyahaS9gWMLKsYJVMLinPTc4sN
        C4zyUsv1ihNzi0vz0vWS83M3MYKjT0trB+OJE/GHGAU4GJV4eDM0rsYKsSaWFVfmHmKU4GBW
        EuHdc/1KrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQbG
        6U1HVRTfrdllevn9wdwvU39ZS/eKpbgeeO55pGO65q+nFrseP7/1/k/ZlxCXhT6rtVnflnaF
        PGNIt28q7Ijq/SXkLvDrmOHqklvPLuz6opuWvDdmk18tV9hK14BjZeWrfSbrTzZJ0FVbPE9j
        RbpR46cp7O4ajjc6CzNEt3JevCyh8i/KUeiVEktxRqKhFnNRcSIAhw2EQboCAAA=
X-CMS-MailID: 20191121033930epcas1p221152c49adc0bcc2a8d2664515dbcbd3
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6@epcas1p4.samsung.com>
        <20191119071107.1947-6-namjae.jeon@samsung.com>
        <398eeca9-e59f-385b-791d-561e56567026@suse.com>
        <00d201d5a00c$e6273ac0$b275b040$@samsung.com>
        <87255.1574306312@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> On Thu, 21 Nov 2019 10:42:13 +0900, "Namjae Jeon" said:
> 
> > > > +		if (clu.flags == 0x03) {
> > >
> > > That 0x03 is magic constant, better define actual flags and check
> > > clu.flag == (FLAG1|FLAG2)
> > Okay, Will fix it on v4.
> 
> Make sure you catch all the cases.  I seem to remember a lot of 0x01's
> in the code as well....
Yes, I know.
Thanks!

