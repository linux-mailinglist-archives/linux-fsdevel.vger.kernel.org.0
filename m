Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB04711A3B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 06:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfLKFSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 00:18:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:55648 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKFSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:18:48 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191211051845epoutp031ff97c0f3846d4b307d643e73dd8758d~fOWrlTLnr0573805738epoutp03g
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 05:18:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191211051845epoutp031ff97c0f3846d4b307d643e73dd8758d~fOWrlTLnr0573805738epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576041525;
        bh=uc6C3cxp7lRdunglDtkY/yYbPnYu/jwUgWkeZZHuAuc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=prQRN8QHgKrXyCBCco20ZfVnrqQooPcvRMfLGyDMGYL6ohl2W8v3L+qL+wXxaA9qp
         hlTt4zh+kRscfbA18BdTLbHR299FuOH8Hpo3pD1jrMc41pWhAlPhbzWibG5BLD4SO2
         R9Y8Y3MmlVdy/H+gzfClcMUIST7d/ErOjjNaDSL4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191211051845epcas1p2640ab43228c7ad55f999375694d10754~fOWq9U2Mg1032310323epcas1p2T;
        Wed, 11 Dec 2019 05:18:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47XlZq6BSqzMqYkb; Wed, 11 Dec
        2019 05:18:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.3C.48019.33C70FD5; Wed, 11 Dec 2019 14:18:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191211051842epcas1p1bdde2fb41b3a10ae05772939385aa283~fOWoqSTVM2757727577epcas1p1S;
        Wed, 11 Dec 2019 05:18:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191211051842epsmtrp22ca362cd7f0ddcdb097f255b7814f85f~fOWoptisX2074320743epsmtrp2T;
        Wed, 11 Dec 2019 05:18:42 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-89-5df07c33e1d5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.7A.06569.23C70FD5; Wed, 11 Dec 2019 14:18:42 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191211051842epsmtip28c383ca1ff18228ffdc5c7e5f51ee61c~fOWof1j130095500955epsmtip2u;
        Wed, 11 Dec 2019 05:18:42 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Vyacheslav Dubeyko'" <slava@dubeyko.com>
Cc:     <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <0c9f9da087571c7c4b1e01a6da16822eb115bf9a.camel@dubeyko.com>
Subject: RE: [PATCH v6 02/13] exfat: add super block operations
Date:   Wed, 11 Dec 2019 14:18:42 +0900
Message-ID: <005101d5afe2$744ef920$5ceceb60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJ4BHLZ9o05RvmzeddUXNtWjOPDsAG4I5TRAhmnGRsBf4wunKZFMM3g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3t3dxctbtPqsKLWFaEEdWubXkstSWKRkRVFFKIXvU1rL3en
        ZQUpydJVI5OofEAgQVa0CN8py1mZlT3UqLAoyqKHTUt6YJltu5P87zvnfN855/v9DonJLxEK
        Ms9s52xm1kgTM/GmrmWqaM3B0QzV5H2COVznJpj6S7dETHtHD870t9UQTMPfm2LmW0O1iOkb
        GcVXS/Sd7mFc76m9LNFff15M6F0NF5F+7Noivbd5mEgndhgTczk2h7MpOXO2JSfPbEii12/J
        XJOpi1Opo9UJTDytNLMmLolOTUuPXptn9O9CKwtZY4E/lc7yPB2bnGizFNg5Za6FtyfRnDXH
        aFWrrDE8a+ILzIaYbItphVqlWq7zM7OMufWXnRJrvWhf/3kvKkafkRNJSaC0cMb1QuxEM0k5
        1YJgrOIGEoJvCE69qpAIwQ8EE1ecxJTE1/EUEwodCFz9naHgE4LyrvPBxgQVDX//eIKKcCoG
        7lx9GCRh1AUEQyOVokBBSq2DpkmPJIDDqFVQ2f1IHMA4FQmtdV+CjWRUAjyq7RQLeA70nB3C
        AxijFkPzlxpMWEkJLb2Co3BqLbSUjCOBEw7V5Y7gYKB+EjBU3RgSpELXh7chP2HwqbtBImAF
        jPk6/HnSjw/AV0+IXobgw88kAWvgufuqOEDBqGXgbosV0kug9XdtaOxs8H0/Jha6yKDMIRco
        keDq6xIJeAE4j4xKTiC6apqxqmnGqqYZqPo/7BzCL6J5nJU3GThebdVO/+1rKHioUUwLan+Q
        5kUUiehZMn3jSIZczBbyRSYvAhKjw2XdDl+GXJbDFu3nbJZMW4GR471I53/3CkwxN9viP3uz
        PVOtW67RaBhtXHycTkPPl5G/HmfIKQNr5/ZwnJWzTelEpFRRjLbtffasfgAGfbGF+SdS8PzT
        82YnRMavUzh6spp3lq28G3Hcs71ky/rBhRsYkUs6rsn76GbsA0cXlqZj7bGVEWGbB94f//Hy
        WOMwtzvVUVR9ZuLdLunjw8pig6JH0pZs1R4yljb9Kumb8Vkc/2DTvT11b/iTr7cWap8sHdmY
        klLUe5vG+VxWHYXZePYfHUfl4r4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvK5RzYdYg6lTtCyaF69ns1i5+iiT
        xZ69J1ksLu+aw2ax5d8RVotPW2YzWVx6/4HFgd3j4Po3LB77565h99h9s4HNo2/LKkaPz5vk
        PA5tf8MWwBbFZZOSmpNZllqkb5fAlbFyTRd7wUqmistLDzE2ML5m7GLk5JAQMJF4t/c6cxcj
        F4eQwG5GiblPnrFAJKQljp04A5TgALKFJQ4fLoaoecEocWHhAbAaNgFdiX9/9rOB2CICehIn
        NpwHG8QssI5RYvn9PWwQHb8YJdpu72cCqeIU8JTY9n8/O4gtLGAvMfn4BVYQm0VAVWLn4rdg
        J/EKWEpcmHuQFcIWlDg58wnYNmYBbYneh62MELa8xPa3c5ghLlWQ2HEW4h0RATeJHY2/oGpE
        JGZ3tjFPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMGxpaW1g/HEifhDjAIcjEo8vAu2v48VYk0sK67MPcQowcGsJMJ7vO1drBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZGmY0iN8xypoR/nKvvyKB6L3j+
        3eQDDNzGl7cUn1o3eVLlpO17r3Oq3XU5Me8F66TVer1lW6a9qzsVkcyyPPmpQcnMlALHB84C
        e17vuHhshvmmLWzpXEZrfu2QmxpxqLa3vf7/pW9fzu3+c+jgnaqy41t1ow87aSho5aksEfWP
        Ojz/odbh3tmHWZRYijMSDbWYi4oTAQYJdEepAgAA
X-CMS-MailID: 20191211051842epcas1p1bdde2fb41b3a10ae05772939385aa283
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e@epcas1p1.samsung.com>
        <20191209065149.2230-3-namjae.jeon@samsung.com>
        <0c9f9da087571c7c4b1e01a6da16822eb115bf9a.camel@dubeyko.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +	sbi->options.fs_gid = current_gid();
> > +	sbi->options.fs_fmask = current->fs->umask;
> > +	sbi->options.fs_dmask = current->fs->umask;
> > +	sbi->options.allow_utime = -1;
> 
> Why -1? Any special purpose?
No, It is just to initialize.
> 
> Thanks,
> Viacheslav Dubeyko.
> 


