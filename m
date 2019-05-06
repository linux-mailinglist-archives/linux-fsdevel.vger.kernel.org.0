Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D514AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEFNhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 09:37:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48888 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEFNhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 09:37:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506133722euoutp02dec01a95735e8efe954298157f176136~cG4gDasMd1221312213euoutp02U
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2019 13:37:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506133722euoutp02dec01a95735e8efe954298157f176136~cG4gDasMd1221312213euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557149842;
        bh=ivWh3sjUT+u6aXhVBQL9PxM3YzbFcHNAqkhkMUc2tsY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TKUbYCignlvBQl/XrqIS4eSybjl0dZPIWOgwmep+aEb3WKSQEkOhFsgIbFl+8MBpN
         d4m534yyM1gLh/M0bbNk77gnmCjGz5UAUe5kIITO6ovj+mMqBUY6fqgAuP+clAMaSA
         OtY2x/gprxbszYmprREJUtAXIXqehELwQu+jhSuw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506133721eucas1p27440dc17ceb96daa52db8e2efad45a99~cG4fr_4uq1303913039eucas1p2k;
        Mon,  6 May 2019 13:37:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E0.58.04377.19830DC5; Mon,  6
        May 2019 14:37:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506133720eucas1p21fdb024aa77d0318b927c4b5d11fd5b4~cG4e7mPNl0498204982eucas1p2F;
        Mon,  6 May 2019 13:37:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190506133720eusmtrp14885154361cfd95b7e34325a802a35a4~cG4eti-rB1141011410eusmtrp1C;
        Mon,  6 May 2019 13:37:20 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-cd-5cd038917450
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.42.04146.09830DC5; Mon,  6
        May 2019 14:37:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190506133720eusmtip2cb2ea03a98a265454bba097b2b135ea9~cG4eOyX-y1092710927eusmtip24;
        Mon,  6 May 2019 13:37:20 +0000 (GMT)
Subject: Re: [PATCH v3 14/26] compat_ioctl: move ATYFB_CLK handling to atyfb
 driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <28b28937-cd5c-61f4-6f84-c6108c006e21@samsung.com>
Date:   Mon, 6 May 2019 15:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190416202701.127745-3-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87oTLS7EGLybKm/xd9Ixdos551tY
        LK58fc9mcaLvA6vFnr0nWSwu75rDZjGx4yqTxZLO90wW5/8eZ7W40rWSyYHL4/evSYweW1be
        ZPK4332cyeP2v8fMHu/3XWXzOL5iDovH501yHpuevGUK4IjisklJzcksSy3St0vgyriy/i1L
        wQTmikcfprM2MJ5i6mLk5JAQMJG4/OElkM3FISSwglGi90gvlPOFUWLOtvtQzmdGiV1vn7HB
        tOzesJYdIrGcUWJ30wM2COcto8S36dNZQaqEBUIldu/7xghiiwgoSkx98YwZpIhZ4BSTxONd
        XWCj2ASsJCa2rwIr4hWwk7h5ogUsziKgInH79nKg3RwcogIREv1n1CFKBCVOznzCAmJzAl0x
        +9JUsFZmAQOJI4vmsELY8hLb384B2yUhcIld4sikTVCfukgcv/qRHcIWlnh1fAuULSNxenIP
        C0TDOkaJvx0voLq3M0osn/wP6mlricPHL7JC2I4SfS/aGUGukxDgk7jxVhBiM5/EpG3TmSHC
        vBIdbUIQ1WoSG5ZtYIPZ1bVzJTOE7SHxZOY5lgmMirOQ/DYLyT+zkPyzgJF5FaN4amlxbnpq
        sVFearlecWJucWleul5yfu4mRmC6Ov3v+JcdjLv+JB1iFOBgVOLhXaByPkaINbGsuDL3EKME
        B7OSCG/is3MxQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODil
        Ghgl09SnzDzCwlV9kz/ziM32xW1eCTdX8U/1Mzvvp9hx78BNv0SB6rBaz0//b1o/iOZTWy0m
        EjSDyfxs5K9L8T8sbDtTzzVLMP1c21/x9FdJkPsFrb2HA0Vm2quEfP34O/LCk13ZC60PHIkr
        aVPV3/jqqqBvgNcrrjcPVVRn+QY6fI08oG1YmK7EUpyRaKjFXFScCADNzKDUUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7oTLC7EGNx8o2rxd9Ixdos551tY
        LK58fc9mcaLvA6vFnr0nWSwu75rDZjGx4yqTxZLO90wW5/8eZ7W40rWSyYHL4/evSYweW1be
        ZPK4332cyeP2v8fMHu/3XWXzOL5iDovH501yHpuevGUK4IjSsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7iy/i1LwQTmikcfprM2MJ5i6mLk5JAQ
        MJHYvWEtexcjF4eQwFJGiWcvWxi7GDmAEjISx9eXQdQIS/y51sUGUfOaUeLVvn+MIAlhgVCJ
        3fu+gdkiAooSU188Y4YousMocfzVHFYQh1ngFJPE3Z3TWEGq2ASsJCa2rwLr4BWwk7h5ooUN
        xGYRUJG4fXs52EmiAhEStx52sEDUCEqcnPkEzOYEOnX2palgvcwCehI7rv9ihbDlJba/ncM8
        gVFwFpKWWUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwBrcd+7l5B+OljcGH
        GAU4GJV4eD2UzscIsSaWFVfmHmKU4GBWEuFNfHYuRog3JbGyKrUoP76oNCe1+BCjKdATE5ml
        RJPzgekhryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo6DbE2/Z
        ih8V3GrFp3+xTDid4f357cbLeU8vpDX1X5ddvPyd7D7Z3Q7MKknKDveUuCe0ezjPOMh5Leco
        16THPtuYDmzfwpSyha+b61mIhcJErbJXjrf8i+ufvqt4p+bXdSvL1+XvxGNlOWlztW5Iz//U
        cLnK46xEkvy62ML4CUXHJi+XUVi0UYmlOCPRUIu5qDgRABYE3tPXAgAA
X-CMS-MailID: 20190506133720eucas1p21fdb024aa77d0318b927c4b5d11fd5b4
X-Msg-Generator: CA
X-RootMTR: 20190416202751epcas3p3655845bd23c19d035b72d9b178427e28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190416202751epcas3p3655845bd23c19d035b72d9b178427e28
References: <20190416202013.4034148-1-arnd@arndb.de>
        <20190416202701.127745-1-arnd@arndb.de>
        <CGME20190416202751epcas3p3655845bd23c19d035b72d9b178427e28@epcas3p3.samsung.com>
        <20190416202701.127745-3-arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 04/16/2019 10:25 PM, Arnd Bergmann wrote:
> These are two obscure ioctl commands, in a driver that only
> has compatible commands, so just let the driver handle this
> itself.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
