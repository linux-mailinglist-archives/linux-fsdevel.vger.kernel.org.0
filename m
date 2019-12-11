Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7911A050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 02:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLKBA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 20:00:56 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:37590 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLKBA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:00:56 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191211010053epoutp02f25786dbeb90c7af47330ec8e6ea095b~fK1hWgeSG2237522375epoutp02X
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 01:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191211010053epoutp02f25786dbeb90c7af47330ec8e6ea095b~fK1hWgeSG2237522375epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576026053;
        bh=CC498m850tFquLPcTmQ5XpqjyiunPoHhTcbaYQMlE7s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Nwfe1Cuz8R0HwlE1QpCLbaaC0gLj5zo8XU3LJXV2zdsglzbsnThZWI2/v9yPfz60w
         0zr3oji0oJSoTM+lQp/2CfBuHleUb4UZZG9fVRpj9kut/xSOxfyv+AUK5SsDiHaThN
         /95t3NieBgzZVKYpcnOQf0MTnxq6ln3/KpwHxSE8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191211010052epcas1p1b768c4a9f1512fa3bc62959899d51e1f~fK1g_aIgC0668406684epcas1p1t;
        Wed, 11 Dec 2019 01:00:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47XdsH3D9JzMqYkj; Wed, 11 Dec
        2019 01:00:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.39.57028.3CF30FD5; Wed, 11 Dec 2019 10:00:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191211010050epcas1p1ea5ea7a401edb561a02854199611433b~fK1fbV6AB0665906659epcas1p10;
        Wed, 11 Dec 2019 01:00:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191211010050epsmtrp1b20b5bb2e8420c0563e1b686240146aa~fK1fal4D33087630876epsmtrp1K;
        Wed, 11 Dec 2019 01:00:50 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-3e-5df03fc3cf12
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.62.10238.2CF30FD5; Wed, 11 Dec 2019 10:00:50 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191211010050epsmtip1557b59908bbfd8fb32580c3775c31ab9~fK1fOHKr41680016800epsmtip1n;
        Wed, 11 Dec 2019 01:00:50 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Vyacheslav Dubeyko'" <slava@dubeyko.com>
Cc:     <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <e234c599ec452ed81fb703c69adf60c1e57062dd.camel@dubeyko.com>
Subject: RE: [PATCH v6 05/13] exfat: add file operations
Date:   Wed, 11 Dec 2019 10:00:50 +0900
Message-ID: <002a01d5afbe$6e64e250$4b2ea6f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJ4BHLZ9o05RvmzeddUXNtWjOPDsAGOqq8IAu+ci5ICERQsxqY69XBw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo7S6jRXPhjIOtEHtdnmduwU2lVk0QWpPlmyDu6wSbu1
        s0laxMhayzIb3UjLrMhKA0Usb4mk3Sw0r5GR4AeDNFG7WlTa5rHy2+953///ubzvQ2KK20QU
        mWV38y47Z6WJcPx+a4xa3bpuIkPT1Q5s3o1Kgr1T8VjCPmhqw9mehssEWzP1SMp+qimWsN3j
        E/h6meFh5ShuaL5yV2Zo7PcShtM15cjwuTra0FI7SqQR6dYkC8+ZeJeKt2c6TFl2czK9Zadx
        k5FJ1GjV2tXsKlpl52x8Mp2yNU2dmmUN9kKrsjmrJ3iUxgkCvXJtksvhcfMqi0NwJ9O802R1
        ajXOeIGzCR67OT7TYVuj1WgSmKByr9VSNnlV4jwqOzBWGkBeVCfNR2EkUHoIPB/G81E4qaDq
        EDwvvCAVg08Iznf+mA2+IfD1dv2zXAhUyMSLJgSDtW8kYjCCoON6/YyKoNQw9auZCLGSiodn
        VS+xkAijbiMYGj8bdJBkGLUZjh0xhzCCYuHo9PqQHKeWQ19B9YxVTq2Gzp57mMgLoe3SEB5i
        jIqDsmsfMLEhFdS1f0ChNEoqFV6/2i5KlFB8wjdTFahJAjpKOglRnwJVI02zHAEjT2tkIkfB
        cKFPFsoD1EH42Dyb3o/g/WSyyDror6yShiQYFQOVDSvF46VQ//MKEsvOh7Gvp6RiFjn4fQpR
        shxOd7dKRF4C+ccnZGcQXTRnrqI5cxXNGaDof7FShJejxbxTsJl5QevUzv3qajSzpbFMHTrX
        sbUFUSSi58lLa8czFFIuW8ixtSAgMVopf+oby1DITVxOLu9yGF0eKy+0ICb47AEsalGmI7jz
        drdRyyTodDpWn7gqkdHRkXLye1eGgjJzbn4fzzt511+fhAyL8iJv/dXfyvCuBaoVU2WWtwPT
        /oZdA3c0228p/SUb9hTsNxIR75I8kdz8hLxhRnUJz9/cA+lff5n46B2Fx158SUG7N0pPbhvq
        LdzmL2VTk655dExaOn3xjbfv8IuPzurRxuNPojOXpj/sZwY9jcVxAX35zbbIXIP+0I+8Ev2y
        6YJsGhcsnDYWcwncH0at/ty7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO4h+w+xBmuuG1o0L17PZrFy9VEm
        iz17T7JYXN41h81iy78jrBaftsxmsrj0/gOLA7vHwfVvWDz2z13D7rH7ZgObR9+WVYwenzfJ
        eRza/oYtgC2KyyYlNSezLLVI3y6BK+P4myPsBZ/YKhYs/cfSwLiMtYuRk0NCwERi2sTV7F2M
        XBxCArsZJc7cmcgOkZCWOHbiDHMXIweQLSxx+HAxRM0LRom1pxeB1bAJ6Er8+7OfDcQWEdCT
        OLHhPDNIEbPAOkaJ5ff3sEF0/GKUODHrM9gkTgFPidamdBBTWMBCouW/A0gvi4CqxNXeTWBz
        eAUsJS5c3soMYQtKnJz5hAXEZhbQluh92MoIYy9b+JoZ4k4FiR1nXzOCjBQRcJO4cc0PokRE
        YnZnG/MERuFZSCbNQjJpFpJJs5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJ
        ERxVWpo7GC8viT/EKMDBqMTDu2D7+1gh1sSy4srcQ4wSHMxKIrzH297FCvGmJFZWpRblxxeV
        5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cAYJzCrVKNr3RW1Ryfr5y9saL3s
        o5t9s/KEwv/O95yrnrLumN0iw6rj6v+k6476+ilzF12/2Vn/IEg71P9GmTbH/IiXHAzZZjcd
        lrI52X5JrH9uNY8lbLLljgSd9besKzT2CFafKJpzvUIssuuD8pe4TyrCB2vZq3f335r56pue
        yiLGVV/uBM9VYinOSDTUYi4qTgQA9vEQMqYCAAA=
X-CMS-MailID: 20191211010050epcas1p1ea5ea7a401edb561a02854199611433b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065500epcas1p3da26ef7963bbba978ed614bc19b2ea07
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065500epcas1p3da26ef7963bbba978ed614bc19b2ea07@epcas1p3.samsung.com>
        <20191209065149.2230-6-namjae.jeon@samsung.com>
        <e234c599ec452ed81fb703c69adf60c1e57062dd.camel@dubeyko.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> > +	/* Of the r and x bits, all (subject to umask) must be
> > present.*/
> > +	if ((perm & 0555) =21=3D (i_mode & 0555))
I modified it due to warnning alarm from checkpatch.pl.
Other octal permissions are same reason.
WARNING: Symbolic permissions 'S_IRUGO =7C S_IXUGO' are not preferred. Cons=
ider using octal permissions '0555'.
+       if ((perm & (S_IRUGO =7C S_IXUGO)) =21=3D (i_mode & (S_IRUGO =7C S_=
IXUGO)))

> > +	/* update the directory entry */
> > +	if (=21evict) =7B
> > +		es =3D exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
> > +				ES_ALL_ENTRIES, &ep);
> > +		if (=21es)
> > +			return -EIO;
> > +		ep2 =3D ep + 1;
>=20
> The ep2 could point out on the garbage here. Maybe, it makes sense to
> add some check here?
Could you please elaborate more? How could ep2 be the garbage?
I want you to check exfat_get_dentry_set().

Thanks for your review=21

