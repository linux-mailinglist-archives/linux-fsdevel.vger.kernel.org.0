Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F279121F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLQADC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:03:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10502 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLQADC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:03:02 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191217000258epoutp03bef0698f4ae67b7c58da2c611a930413~g-6q38Jtq2140321403epoutp03D
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 00:02:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191217000258epoutp03bef0698f4ae67b7c58da2c611a930413~g-6q38Jtq2140321403epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576540978;
        bh=ciQbpU1wunt+IIv+D/PXz4k6+WkURdQNkPVZxzGbpOI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QMGwfqu9kCk9sKA6SqHB4sFpyFMcGRU3054IyOG6K70zI7z/Ven+av1NruNMuLmfw
         NOEmia3uCzr9hWAF/zklSidZMdw6ShOHbywFut1RbU6Jc/P+O5Yqu+j9tJ7wYMSaBu
         Zy7AzYky1NifMYbENrEQ9EQqbCP3WSOFHG8oxOXA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191217000257epcas1p35fe0c177852e302bca3c42d30ddfc98e~g-6qe0hof3031030310epcas1p3M;
        Tue, 17 Dec 2019 00:02:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47cJHh6WnzzMqYkc; Tue, 17 Dec
        2019 00:02:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.FD.57028.D2B18FD5; Tue, 17 Dec 2019 09:02:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191217000253epcas1p4d2962765c6b1f3cba1648e7bf414f034~g-6mD0A6B2424724247epcas1p4D;
        Tue, 17 Dec 2019 00:02:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217000253epsmtrp2df7d895f11db90df1595e53aa23ffcb2~g-6mDIXxr2255822558epsmtrp2W;
        Tue, 17 Dec 2019 00:02:53 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-5f-5df81b2da7be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.AF.10238.C2B18FD5; Tue, 17 Dec 2019 09:02:52 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217000252epsmtip1c210904c1390d89e2f37ef1d13f932b4~g-6lzv4BX0178801788epsmtip1O;
        Tue, 17 Dec 2019 00:02:52 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
Subject: RE: [PATCH v7 01/13] exfat: add in-memory and on-disk structures
 and headers
Date:   Tue, 17 Dec 2019 09:02:53 +0900
Message-ID: <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQFm2LC/h6nQOwj4JCuWUtKX9oQxIwE+vU/YAbPr/rCog5NBAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+XkfXqXFbVqeVtS6EmIy3Zyzq7SIihhYYARFgtlFL5u1l7tT
        sv5IknyM0YuoXNoDK9Ie2pRcK1luWUgvKii0oLeZlppSGoV1513kf5/z5XvO75zzOxQmbyIV
        VLHVyTusnJkhY/HroWS1SrVgMl/92pfAVja2kGzTpe4o9lZnD84+89eT7B/PJ4Jtn7pDsE9H
        RvFV0YZAw+Vow83eCtJwoL0ZGca9iwzBji+k4WX/dTyXzDOvMPFcEe9Q8tZCW1Gx1ahncjYV
        rCnQZao1Kk0Wu5xRWjkLr2fWrs9VrSs2i70wyjLOXCpKuZwgMGkrVzhspU5eabIJTj3D24vM
        do3anipwFqHUakwttFmyNWp1uk50bjebAkebkL0O2zXuTqxAE1EuFEMBnQEdNWOEC8VSctqH
        oDbYgEnBGIL7zQO4FPwQg1O30b+Un3+qIimdCNrujkRcgwg+93QTYRdJq2Dqd4AMczydCke+
        hKZ1jHZHwdnnc8IcQ2eDf3/ltB5Hb4GDtd14mHF6KVwcqMfCLKOzwHt+HyHxHOip+4BLdVLg
        wtkhTOpICb6HQ0jS4+FkbRUmvbsaTn/tmp4H6BESej++I6WEtTDceYqQOA4G77VHS6yA8eFO
        0UOJvAe+BSL1axAMTOgl1kJvSysRtmB0MrT40yR5Cdz41RBpYTYMf3cTUhUZ1FTJJctSOPA0
        FFn7AnBVj0YfQoxnxmCeGYN5Zgzj+f/YGYQ3o3m8XbAYeUFj18z8ay+aPtNlOh86+mh9ENEU
        YmbJ7GUT+XKCKxPKLUEEFMbEy3xKUZIVceW7eYetwFFq5oUg0ol7P4wp5hbaxKO3Ogs0unSt
        VstmZC7P1GmZBBk1+SRfThs5J7+T5+28419eFBWjqECLk0OZW/cmBfsfPPfwL4yNjqv+yo4u
        16231WbSpG8LTaV4FSUH09YtQYHtrVRGdk1G3VfXlTeJJfMHsrrPBfL6Gj9uSHz32P844XDJ
        +/RXoznHh8ovldRXb762IxDTn/xowjPW92uE2rjtStJg0rycCxfdR45tTV14KC/O9MR9YtLL
        4IKJ0yzDHAL3F0EwwhO8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnK6O9I9Yg0tXrC2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxf9ZzVost/46wWlx6/4HFgd1j/9w17B67bzawefRtWcXo8XmTnMeh7W/Y
        PG4/28YSwBbFZZOSmpNZllqkb5fAlbFhyh+Wgk1MFW0/XrI3ML5l7GLk5JAQMJH4+b+NtYuR
        i0NIYDejxIkNq5ggEtISx06cYe5i5ACyhSUOHy6GqHnBKNG2eyELSA2bgK7Evz/72UBsEQE9
        iUlvDoMNYhaYwCSxaVInM9zUlmdT2UGqOAWsJHa1NrOC2MICoRIrDj8C62YRUJVY8WIOM4jN
        K2ApsWlpEyuELShxcuYTsG3MAtoSvQ9bGWHsZQtfM0NcqiCx4+xrqLiIxOzONmaIi5wk5r89
        yDyBUXgWklGzkIyahWTULCTtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeW
        luYOxstL4g8xCnAwKvHwSpR8jxViTSwrrsw9xCjBwawkwrtDASjEm5JYWZValB9fVJqTWnyI
        UZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDo9As2d0MswwN8jnuXpszPfEXz12tFSay
        sxhNy6ICopbWb5RVv65lqRtxt339+SbNrgXZCbwPr5yff8CfbRa70aNTmpUFditOTHtSuj3m
        zE6efycfZfFJPZk5LS3bTz95SUzgU/M5R6bmf7dOfV58YML2UwZHTDU3uRVrKU51cLtT2u52
        Iu35JiWW4oxEQy3mouJEAGp270ypAgAA
X-CMS-MailID: 20191217000253epcas1p4d2962765c6b1f3cba1648e7bf414f034
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
        <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
        <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 2. Which source file should provide the corresponding implementation?
>    (I did not find it in the update step =E2=80=9C=5BPATCH=20v7=2006/13=
=5D=20exfat:=20add=20exfat=0D=0A>=20=20=20=20entry=20operations=E2=80=9D=20=
so=20far.)=0D=0AGood=20catch,=20I=20will=20move=20it=20on=20next=20version.=
=0D=0A=0D=0AThanks=20for=20your=20review=21=0D=0A>=20=0D=0A>=20Regards,=0D=
=0A>=20Markus=0D=0A=0D=0A
