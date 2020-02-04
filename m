Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF115162E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 07:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgBDGxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 01:53:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49682 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBDGxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:53:41 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200204065340epoutp02c5a562f105c850cfaeeb7b5fa97f9863~wIIPrMAnr3029930299epoutp02x
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2020 06:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200204065340epoutp02c5a562f105c850cfaeeb7b5fa97f9863~wIIPrMAnr3029930299epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580799220;
        bh=M0xz+FX9Njete8XBnuXr5iyf/TCr/CudSOBVfJT8FpQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Gc7IHYVo8oZ2du7cwoYxUzqADYPq1Cqs6XE3qscWGfvmFZZjiWecD3buRGk1c07Ad
         S2LM29PqGUWy2UhG6xJORKpi2vjWvYcsNc48wM97xgs3llKrjW6kQH9UJQ9hg7wWke
         LXGbmsCeMceyxKCsJZvI7r+j2coZvo8NRFGsk0rU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200204065339epcas1p34f6e1cc8146332bf73b97a6a4a954cd7~wIIPS8JJa0765807658epcas1p3s;
        Tue,  4 Feb 2020 06:53:39 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48Bb4y4CWdzMqYkp; Tue,  4 Feb
        2020 06:53:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.A1.57028.2F4193E5; Tue,  4 Feb 2020 15:53:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200204065338epcas1p3c8c5e52a85ceedd3d4cbe540e28d0d36~wIIN3f32l0270002700epcas1p3H;
        Tue,  4 Feb 2020 06:53:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200204065338epsmtrp2685bdef72af5da971f3c32fff4e4be57~wIIN2ogvY2803228032epsmtrp2g;
        Tue,  4 Feb 2020 06:53:38 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-7d-5e3914f22b48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.F7.10238.2F4193E5; Tue,  4 Feb 2020 15:53:38 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200204065338epsmtip148be7b568560c88d232fc131e2d0b17b~wIINqK1Io2695226952epsmtip12;
        Tue,  4 Feb 2020 06:53:37 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>
Cc:     "'Namjae Jeon'" <linkinjeon@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <sj1557.seo@samsung.com>,
        <pali.rohar@gmail.com>, <arnd@arndb.de>, <viro@zeniv.linux.org.uk>,
        "'Christoph Hellwig'" <hch@lst.de>
In-Reply-To: <20200204060654.GB31675@lst.de>
Subject: RE: [PATCH] exfat: update file system parameter handling
Date:   Tue, 4 Feb 2020 15:53:38 +0900
Message-ID: <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ3hnUxsyInosG8UqH0czz03xeGfQIFUA17AgPO9oympvlEgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0hTURzHObvb3dVcXOesH+u1bgVpLjfn9BoqvchBBkr0Rw+0i142aS92
        Z/QgMXpYKyR7NzO1wsgKw1Y5S0azl5YVFYiGkVhYmvnqvRltu4v87/P7ne/vec4hMOk9XE4U
        me2szcwYKTxSeKs1LlE5JkvLU/XVzKEnjj4U03suNOD05SsPBHRnTzdG321pE9Kvms/idMUT
        n4B2/bkvol8Ojwjp5xOPREsjdb7fR5HO7ewR6zxVV8W6O12luK7cVY90442zdd7bn3Fd4/sh
        QQ6xwZhuYJlC1qZgzQWWwiKzPoNavTZ/Rb42RaVWqtPoVEphZkxsBrUyO0e5qsgYaJJSbGWM
        xQFXDsNxVGJmus1SbGcVBgtnz6BYa6HRqlZZF3OMiSs26xcXWExL1CpVkjag3Gw0uE534tYa
        0bae8ahStFfkQBEEkMnw/YoLD7KUbELQ3ZDsQJEBHkNQ5i8X8sZ3BKP+asG/iMEzNRh/0IKg
        2dMbNj4hOPnhXSgXTirhj98TYIKQkcvA3x8Z1GBkhQCqO9pCmSLIBDhy9TEKckxAc+j6eIiF
        5HwY/tYXYgmZBo4WJ8ZzNLSdeS8MMkYugrraQYzvSAG/PtSF5pGRy+GgtxrjNTKoPLg/1ByQ
        p8RwYehXOGAl+Osd4QXEwMAjl5hnOYx/aQk1DeROGPWE5QcQfPyRwbMGuhqui4ISjIyDhuZE
        3j0X3L4qxJedCl++HRbxWSRwYL+UlyyA8pet4R3OAEfZiPgIopyTBnNOGsw5aQDn/2I1SFiP
        prFWzqRnObVVPfmqG1Ho+cZrm9DxZ9leRBKIipK8yKTzpCJmK7fd5EVAYJRMUrJEmyeVFDLb
        d7A2S76t2MhyXqQN7L0Ck8cWWAKfwWzPV2uTNBoNnZySmqLVUNMlvevj8qSknrGzW1jWytr+
        xQmICHkpumRPX8QM4lmboh6PWta546PX5N6sa/9R1ZHbt3zOxdf65g3t2jLOsW3fuc4TJb6Z
        lWO57vYpC9jna2upjQt7z/sGshYmTI+9pnhKZb75eEL5dsD1JOn20Ci3e95PySxx0rEqrF/Q
        VDtRkhrTe2Pe7gT3qa8dhpRd5Vl0/wupR/xGTgk5A6OOx2wc8xdLSE8b1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSnO4nEcs4g/uT2S3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWl95/YLE4//c4qwOXx+9fkxg9ds66
        y+6xf+4ado/dNxvYPPq2rGL0+LxJzuPQ9jdsHpuevGUK4IjisklJzcksSy3St0vgyrj66wlr
        wR3misX3NzM1MDYydzFyckgImEi8nrkAyObiEBLYzSjx+1ETI0RCWuLYiTNACQ4gW1ji8OFi
        kLCQwHNGibuz+EFsNgFdiX9/9rOBlIgIOEr8ec4FMoZZYDaTxN7OJYwQM+czSvzpOMMO0sAp
        oCMxYc0JsPnCQA3dGz6D2SwCKhLvvz4Gs3kFLCW69s5ihrAFJU7OfMICYjMLaEs8vfkUzl62
        8DXUAwoSP58uYwWxRQScJDoPzWeGqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZVjFKphYU
        56bnFhsWGOallusVJ+YWl+al6yXn525iBEeiluYOxstL4g8xCnAwKvHwXrCziBNiTSwrrsw9
        xCjBwawkwltnZRonxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwT
        B6dUA2OK3n+Jp32vTZM+bH1xe0FI2pkvnX8b3z/RVSnPnvxMblMsz7cXp9prdyqv837+wWtS
        jlldwVbdOUsZq1aYap/5UnGclSc7pr5ucfWh4FV8llKxgtUn73wPOnn6qcI/X2uWQNdVEz9m
        V3y/r+Si09h63+tSkllxkLDpWwPpN6FJPAoFB/l/fFViKc5INNRiLipOBACxjOPawAIAAA==
X-CMS-MailID: 20200204065338epcas1p3c8c5e52a85ceedd3d4cbe540e28d0d36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55
References: <297144.1580786668@turing-police>
        <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com>
        <20200204060654.GB31675@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Feb 03, 2020 at 10:24:28PM -0500, Valdis Kl=C4=93tnieks=20wrote:=
=0D=0A>=20>=20Al=20Viro=20recently=20reworked=20the=20way=20file=20system=
=20parameters=20are=20handled=0D=0A>=20>=20Update=20super.c=20to=20work=20w=
ith=20it=20in=20linux-next=2020200203.=0D=0A>=20>=0D=0A>=20>=20Signed-off-b=
y:=20Valdis=20Kletnieks=20<valdis.kletnieks=40vt.edu>=0D=0A>=20=0D=0A>=20Lo=
oks=20good:=0D=0A>=20=0D=0A>=20Reviewed-by:=20Christoph=20Hellwig=20<hch=40=
lst.de>=0D=0AAcked-by:=20Namjae=20Jeon=20<namjae.jeon=40samsung.com>=0D=0A=
=0D=0AIf=20I=20need=20to=20make=20v14=20patch=20series=20for=20this,=20Let=
=20me=20know=20it.=0D=0A=0D=0AThanks=21=0D=0A=0D=0A
