Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F831FC90A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFQIku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 04:40:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29985 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQIku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:40:50 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200617084046epoutp03ee83e00363add636f193d40df0b023c9~ZSCAiZ1jb1207312073epoutp03W
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 08:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200617084046epoutp03ee83e00363add636f193d40df0b023c9~ZSCAiZ1jb1207312073epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592383246;
        bh=DfAiU3R8rPHuEDdEz8zHDdo36LP4pVwp6GrKwVYFRhQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jMr2h/lBjQXsGChrMaazBUaB7cWVoIvJCXctFQYwQ/Kv0KYahQWoOb92JZ9TKUzVq
         5X+84Sz5oXyAvpfzvCKt4/ZWYbT0CPmlOj+dVetwmyhsKTFExjNsmOrKR/Dpzrf3QV
         p2Nv21NDjyWY5J3jm7JKK+zooQjGvj2d9CdMq9OU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200617084045epcas1p467ebb25cd31b77adf6c73ffb0ce22006~ZSB-j6oUN1251312513epcas1p4a;
        Wed, 17 Jun 2020 08:40:45 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49mz6h3646zMqYkn; Wed, 17 Jun
        2020 08:40:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.6A.29173.C07D9EE5; Wed, 17 Jun 2020 17:40:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200617084043epcas1p15b9a0ede7d9e129af942799f3f54de00~ZSB_T2WA60087000870epcas1p1P;
        Wed, 17 Jun 2020 08:40:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200617084043epsmtrp1b9b69fcb3186e35cb27ade2cf908f1f2~ZSB_TU5xG2448424484epsmtrp1s;
        Wed, 17 Jun 2020 08:40:43 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-3b-5ee9d70c408f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.90.08382.B07D9EE5; Wed, 17 Jun 2020 17:40:43 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200617084043epsmtip236c0b2a92a173f2620a0020cbaaa22d8~ZSB_FdE0F1759117591epsmtip2F;
        Wed, 17 Jun 2020 08:40:43 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <42fb01d6447e$c372d860$4a588920$@samsung.com>
Subject: RE: [PATCH v2] exfat: call sync_filesystem for read-only remount
Date:   Wed, 17 Jun 2020 17:40:43 +0900
Message-ID: <001e01d64482$fd03cbd0$f70b6370$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJvI9IWjSo26kFx55d3RL5JRBWksAG87Uq/ArpcdCinhwPs8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmni7P9ZdxBl/+i1hcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5KscmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PI43msBedYKg4fPMXSwHiVuYuRk0NC
        wETi2oFJLF2MXBxCAjsYJeaua2QHSQgJfGKUaPjEBpH4xijRufw7I0zH1obpLBBFexklzi9P
        gyh6yShxeuZ6JpAEm4CuxL8/+9lAbBGBUImTV5eBTWUWcJY4fOMU2GpOASuJKQufAw3i4BAW
        8JT48SEGJMwioCrxcvtKVhCbV8BSYl/Ld2YIW1Di5MwnLBBj5CW2v50D9YGCxM+ny1ghVjlJ
        LNx1mgmiRkRidmcbM8htEgIf2SUun2tgh2hwkfh5pYsFwhaWeHV8C1RcSuJlfxs7yD0SAtUS
        H/dDze9glHjx3RbCNpa4uX4DK0gJs4CmxPpd+hBhRYmdv+cyQqzlk3j3tYcVYgqvREebEESJ
        qkTfpcNMELa0RFf7B/YJjEqzkDw2C8ljs5A8MAth2QJGllWMYqkFxbnpqcWGBcbIMb2JEZwM
        tcx3ME57+0HvECMTB+MhRgkOZiURXuffL+KEeFMSK6tSi/Lji0pzUosPMZoCg3ois5Rocj4w
        HeeVxBuaGhkbG1uYmJmbmRorifP6Wl2IExJITyxJzU5NLUgtgulj4uCUamDisvPwLdryJfbT
        tut9dmVyczfIbnI93aGk+m0hq9vumgX8Jl0u9qdsNFQzFpvVdXDka7IsiY1Z33ytTF4gds0L
        /fWFnz9tPzi3bd6ZP2wFyned1hytOc7byfR9Q39yaezJ3qp3zMfatxaclnkQsWZha/nB8oJz
        ZsVBLqmGKzILueTNdESZ1L68nV37LuFAlv/J+Ye+3xZnLHdQNJG5t/uPw+qA7SuXMRrLhFkk
        9539mJB8WpLzZezzUrtJzz6fO1enVKoxJ0j4oU16wh976/17rjeI9J05wjPn4tkD7PvOpc3h
        P7iCfd7+OdYve7ZmdN42EN3U7TgzZum0Zu7zscEV8jJHP7NMX1W6PuHrbUYlluKMREMt5qLi
        RADn6fyMDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvC739ZdxBveOq1hcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvjyON5rAXnWCoO
        HzzF0sB4lbmLkZNDQsBEYmvDdJYuRi4OIYHdjBIfZq1ig0hISxw7cQaoiAPIFpY4fLgYouY5
        o8Suk5NZQGrYBHQl/v3ZD1YvIhAq0dp1DCzOLOAqMf/5ajaIhm2MErNOPmcCSXAKWElMWfic
        BWSosICnxI8PMSBhFgFViZfbV7KC2LwClhL7Wr4zQ9iCEidnPoGaqS3R+7CVEcKWl9j+dg7U
        AwoSP58uY4W4wUli4a7TTBA1IhKzO9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9Nxi
        wwLDvNRyveLE3OLSvHS95PzcTYzg2NDS3MG4fdUHvUOMTByMhxglOJiVRHidf7+IE+JNSays
        Si3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZqakFqEUyWiYNTqoEpZvnLZ2XvzVi+PGAw
        NZwcVrbrWVtNrpONrsSHOxflDA2DNCZez2v8fCb6fp7Y+sJTHHM3f55wVrvQp4hL35836qmA
        ovfklL+FrBz6B9jZ3aeL+ud0HClr62cJfqGzQGLdtQNvF2wXs+oWWcNV7mTtne1ou3mTWWrO
        x8uLA734Lv6ycT7IzxY+ZbVeV+5Jm706zt+XTXDv9zu6+rJ62vuthfJbThyunrN18vPbDSdy
        Hfw3Tvi2LDZtxzZn17VN/nqlz8I2vnS0dfi9cK0J865nCZGTPF9kXwnjPJegI+1kdnfanEqh
        wiDbPTu3Tfh0LGoKo1dfc85HD8dLNi6sL9f8MY+4VnrK9uamLwtyJigosRRnJBpqMRcVJwIA
        b4fvbPwCAAA=
X-CMS-MailID: 20200617084043epcas1p15b9a0ede7d9e129af942799f3f54de00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616053459epcas1p4e7a4908eda3785d6f5cbb71150cbe50b
References: <CGME20200616053459epcas1p4e7a4908eda3785d6f5cbb71150cbe50b@epcas1p4.samsung.com>
        <20200616053445.18125-1-hyc.lee@gmail.com>
        <42fb01d6447e$c372d860$4a588920$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > We need to commit dirty metadata and pages to disk before remounting
> > exfat as read-only.
> >
> > This fixes a failure in xfstests generic/452
> >
> > generic/452 does the following:
> > cp something <exfat>/
> > mount -o remount,ro <exfat>
> >
> > the <exfat>/something is corrupted. because while exfat is remounted
> > as read-only, exfat doesn't have a chance to commit metadata and vfs
> > invalidates page caches in a block device.
> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks!

