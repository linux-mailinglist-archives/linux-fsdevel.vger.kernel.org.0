Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8F1DDAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 01:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgEUX2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 19:28:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44179 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUX2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 19:28:11 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200521232808epoutp010341c0ca1002075fd61c619987846274~RLuFZtDf10299002990epoutp01f
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 23:28:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200521232808epoutp010341c0ca1002075fd61c619987846274~RLuFZtDf10299002990epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590103688;
        bh=HWCziiPaJnNdzvCOhDUsacfYegMGVNrpvJbpZy4IQ3w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ryVfta9mIenFngIsY9CUg9X178bCr6sfUhJrU/MW2i3vT7thO9hP00u4GVHFZ9yLH
         svaMvjBpPrd04qpWQmcOtQsC/EVltt3mN2SNgaWu+qMRxOMdn5+b2asi0sv3CNHqyu
         XjMuagLzw4QYzBjBtFxrFo36w+5ucY/i/seokBp0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200521232808epcas1p4c408b45323e506c195ddcddc1c490230~RLuFCRnWY3128131281epcas1p4K;
        Thu, 21 May 2020 23:28:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49Sm5337BqzMqYlp; Thu, 21 May
        2020 23:28:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.28.04402.78E07CE5; Fri, 22 May 2020 08:28:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200521232806epcas1p47c618d7f8a08c5144805c1d197d25d92~RLuDWS18M3124631246epcas1p4U;
        Thu, 21 May 2020 23:28:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200521232806epsmtrp20ca25e44795fc8bc43257fd663270b55~RLuDSzwIH0871308713epsmtrp2K;
        Thu, 21 May 2020 23:28:06 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-7c-5ec70e879624
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.F7.18461.68E07CE5; Fri, 22 May 2020 08:28:06 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200521232806epsmtip1efbfd278e85e9b52d173a0523a08def5~RLuDDgRER0727807278epsmtip1m;
        Thu, 21 May 2020 23:28:06 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>
In-Reply-To: <20200521173201.GG23230@ZenIV.linux.org.uk>
Subject: RE: [PATCH] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
Date:   Fri, 22 May 2020 08:28:06 +0900
Message-ID: <004101d62fc7$7b2e5640$718b02c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH1VjccOADZmdfuS2FcImOIOWOQ6QExygk1AmrS+6WoV/o7AA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHObt38yotr9PscUGtS35QMbfmdIaL3igxIaEvUbB1cbcp3d2t
        3WlZBJJUam+aKbaUFM3CBHNqvpQUWpkZSlqIIZZiYZZSrRdCs+52lfz2O8/5n+d//uc8BKYo
        kSmJDM7JODiapWQB+L3uCHX0uZU9RvWtGtAXld7E9A86e3H9UEe5TD9xacZPP/CnR7pVmuSu
        y5clPSubw5M87rVJ7skZSSp+gE1MZ2gz41AxXJrNnMFZDNSefaYdJl2cWhOtSdDHUyqOtjIG
        amdKavSuDFbwpVRZNJsplFJpnqditiQ6bJlORpVu450GirGbWbtGbd/I01Y+k7NsTLNZN2vU
        6k06QXmITW+YdUvtNcTxC4PfJTloQFaA/AkgY+FN+2XkZQXZhmDkO1eAAgT+huDzi0qZuPiJ
        oLm/3m/pxNuJUSRudCJoaWrHxcVHBB+aS329ZGQ0LMw/9HmEkBHwt6IQ84ow8jKC6drbPpE/
        qYfqT30+DiYPg+fBFamXcTIcOgpP+1hOJoDn/igmchD0XpvEvYyR66B1phwTr6SC3+9rBT0h
        mG2H8p4wURIC1/PP+nyBzCfg/vz0YuidUJS39ADBMN3TvBhNCZ7ZTpm3D5An4evDxfZ5CKZ+
        GUTWwkjDXZ8VJuRq6IgRy+uhfa4CibYrYfbHBanYRQ55ZxWiJBwuDXZLRF4DBee++BUiyrUs
        l2tZLteyAK7/ZpUIr0OhjJ23WhheY9cs/2s38o1kpK4NXe1P6UIkgagV8ndpT40KKZ3FZ1u7
        EBAYFSKvCnxiVMjNdPYJxmEzOTJZhu9COuHZizDlqjSbMOCc06TRbdJqtfrYuPg4nZZaLS8Z
        Zo0K0kI7mSMMY2ccS+ckhL8yB7UWVz/a33yjOmi4qhurrJhqimnKIsaCg1SPEy7K6wd6uWOd
        L8tYVDbbmPM02MQ0VCb3h0VwNfNTR+MCi5NTh7jzG8badC25ReONZta4rbU3I7d43OTabTi1
        EGrwfx3Ob6+tUMq/vioYCorac8cSdkbi6UvY2z7iPtjnp3weFUPhfDqticQcPP0PFGkddKgD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnG4b3/E4g1+XZSwmTlvKbLFn70kW
        i8u75rBZPOp7y25x/u9xVgdWj02rOtk8Tsz4zeLxeZOcx6Ynb5kCWKK4bFJSczLLUov07RK4
        Mta/28RasISjoufSF6YGxvNsXYycHBICJhL3H91h7GLk4hAS2M0oMXfhXHaIhLTEsRNnmLsY
        OYBsYYnDh4shap4zSqx7P5URpIZNQFfi35/9YINEBDQl/s+dwAxSxCwwmVHi08OPLCAJIYGd
        jBKrrpaD2JwCFhKLX58GaxYWSJGY/L0DzGYRUJXYNaGJFcTmFbCU+Lz7DjOELShxcuYTFpAj
        mAX0JNo2gpUzC8hLbH87hxniTgWJn0+XsYKUiAg4Scw5LglRIiIxu7ONeQKj8Cwkg2YhDJqF
        ZNAsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4qW5g7G7as+6B1iZOJg
        PMQowcGsJMK7kP9onBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2Cy
        TBycUg1MrYGX+TUfBzJsmrEyo3fBuS+pBfwW02w+NhU7WPx6N/NDkNX7KXbfzwluNT6gLfvg
        yjq+A5n/Hric/Dhv/1vtDtO7Dwo+nhK9bnlzvc6rL8/l+fPvP9y80bH3y8pbCe0qouJrdqS6
        SoWdmPE3SXtqFW9R6x9XDfZmW5nl7aqZccbRBQw9kkU3eDZZ++UEpZn2385zC8ldv9M/97Pi
        h6n3lj5jSZ58auGbub8bFhYdnjPzQodvsPGm9h1Kioe4FRkvSnN0eO7dqrJl3uorzrYn5pRp
        M5RUrExm3xTOf37/rYijrGnhliYTl9+aNVN3ysLCfV4Tw/1zw65O3yl15Xdx9/bPcma6xSJ3
        Ndssew34lFiKMxINtZiLihMBzRMLMAQDAAA=
X-CMS-MailID: 20200521232806epcas1p47c618d7f8a08c5144805c1d197d25d92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200521173209epcas1p29a26d78a46e473308553c6b3a6d0ce83
References: <20200521122034.2254-1-namjae.jeon@samsung.com>
        <CGME20200521173209epcas1p29a26d78a46e473308553c6b3a6d0ce83@epcas1p2.samsung.com>
        <20200521173201.GG23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, May 21, 2020 at 09:20:34PM +0900, Namjae Jeon wrote:
> > As Ubuntu and Fedora release new version used kernel version equal to
> > or higher than v5.4, They started to support kernel exfat filesystem.
> >
> > Linus Torvalds reported mount error with new version of exfat on Fedora.
> >
> > 	exfat: Unknown parameter 'namecase'
> >
> > This is because there is a difference in mount option between old
> > staging/exfat and new exfat.
> > And utf8, debug, and codepage options as well as namecase have been
> > removed from new exfat.
> >
> > This patch add the dummy mount options as deprecated option to be
> > backward compatible with old one.
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Do you want that to go via vfs.git #fixes, or would you rather have Linus apply it straight to
> mainline?
I would really appreciate if Linus apply it directly to mainline.

Thanks!

