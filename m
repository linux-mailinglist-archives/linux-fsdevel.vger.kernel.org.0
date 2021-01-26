Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3083E305D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313046AbhAZWau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:30:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62099 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbhAZFIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:08:51 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210126050805epoutp0169a2b443449cbda219df3198aeea8572~dr__jglts0958209582epoutp011
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 05:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210126050805epoutp0169a2b443449cbda219df3198aeea8572~dr__jglts0958209582epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611637685;
        bh=vqROIDmaSvsLlGImacUn4JYph8r0jrP/w4/IEv9wYEo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HVsW/My4umhfWVAyqwAM7MV+A5uibjZ2b5Td9MsTlO8sDb22fWY+qGdaKJnxUnCr/
         oqxbIjLTgc9CEU2fXukynnJVwnV5PpL8ZBmZatNNDdFTrdDhpwbQc99JYX/gAHKeIE
         itS1t+1hCQc2n9iFh1YHRnDvpp0kljxLRxwMr1tc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210126050805epcas1p4b7af6e66c8d35407f9ecf503634b2876~dr__KJ87_0080400804epcas1p4H;
        Tue, 26 Jan 2021 05:08:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DPvrN0V2Pz4x9Pw; Tue, 26 Jan
        2021 05:08:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.8A.09577.3B3AF006; Tue, 26 Jan 2021 14:08:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210126050803epcas1p181f28ec96236552fad1901672aed6f2b~dr_83eSKy2695926959epcas1p1P;
        Tue, 26 Jan 2021 05:08:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210126050803epsmtrp1bcddb9539ce6550404ff8c9361844fc2~dr_82uhZj2301423014epsmtrp1P;
        Tue, 26 Jan 2021 05:08:03 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-a4-600fa3b3f05e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.AC.13470.3B3AF006; Tue, 26 Jan 2021 14:08:03 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210126050803epsmtip1a77f5a94ef9fe62dcc840b75bd7682fb~dr_8nohi52075620756epsmtip1M;
        Tue, 26 Jan 2021 05:08:03 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>, <syzkaller-bugs@googlegroups.com>,
        "'syzbot'" <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>
In-Reply-To: 
Subject: RE: UBSAN: shift-out-of-bounds in exfat_fill_super
Date:   Tue, 26 Jan 2021 14:08:03 +0900
Message-ID: <052101d6f3a1$3997c420$acc74c60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKx/jOXwjWHcb1Mo6E7TSXbn6EBcQJApmhQAe65oTeoYcKoMIAAB+GA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTX3fLYv4Eg7W2Fnv2nmSxuLxrDpvF
        ln9HWC3uXWe0uLFlLrPF7x9z2BzYPPZMPMnmsXmFlkffllWMHjPfqnl83iQXwBqVY5ORmpiS
        WqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtF1JoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCT0fblBWvB
        BfaKO7cfMDcwrmbtYuTgkBAwkTix36qLkYtDSGAHo0TTkevsEM4nRollu/cyQTjfGCWW3mpn
        gemY+54DIr6XUaJ5zzpGCOclo8Sn7p9sXYycHGwCuhL//uwHs0UEdCS6Xm5nBSliFjjBKHHl
        zmmw3ZwCvBIT/lmD1AgLWEtMebobrJ5FQFVi3+0GdhCbV8BSYuGtaYwQtqDEyZlPWEBsZgF5
        ie1v5zCD2BICChI/ny5jhdjlJnF49kmoGhGJ2Z1tUDVTOSSWveSEsF0kZjy+ywphC0u8Or6F
        HcKWknjZ38YO8WS1xMf9UK0djBIvvttC2MYSN9dvALueWUBTYv0ufYiwosTO33MZIbbySbz7
        2gMNXF6JjjYhiBJVib5Lh5kgbGmJrvYP7BMYlWYh+WsWkr9mIbl/FsKyBYwsqxjFUguKc9NT
        iw0LTJFjehMjOFlqWe5gnP72g94hRiYOxkOMEhzMSiK8u/V4EoR4UxIrq1KL8uOLSnNSiw8x
        mgJDeiKzlGhyPjBd55XEG5oaGRsbW5iYmZuZGiuJ8yYZPIgXEkhPLEnNTk0tSC2C6WPi4JRq
        YCpKWnH34p3Kxjm1zvnGi7oux+ulWyRE35I/175ijdr0U4vjzzxUTpi0qM2gfwOvmc3dyUmq
        jYJBBjarF56pWCjIu89Cadu3JUuqVFJfSzZ5XpabdPp+EBNj0n/rKO50h+i7Ezq267+eHX0i
        yPukxuapggal292YoiotXJ6/NXs7/16dSeVu8/2R5VHPt7lMmhbTHlbdMXPZ3VKmh2fPpN59
        ax+bs5/Hv4V3sXOoQ0L2HSab77wp+ldUz+jdKDzc4BiZYp4i81rwZo1tCP+7d6XnFor6dh2q
        4FS8c8lR/uTarKkbj73bGJWu0riL76R5otjVia+PVTziZir137n/2Ycgx0mxD65mmFz2uPxr
        jRJLcUaioRZzUXEiAKDGeHwfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnO7mxfwJBlNfyFjs2XuSxeLyrjls
        Flv+HWG1uHed0eLGlrnMFr9/zGFzYPPYM/Ekm8fmFVoefVtWMXrMfKvm8XmTXABrFJdNSmpO
        Zllqkb5dAldG25cXrAUX2Cvu3H7A3MC4mrWLkYNDQsBEYu57ji5GLg4hgd2MEr8/f2DqYuQE
        iktLHDtxhhmiRlji8OFiiJrnjBJXWjcxg9SwCehK/Puznw3EFhHQkeh6uZ0VpIhZ4AyjxPeu
        6ywQHdsZJTp+/WEHmcQpwCsx4Z81SIOwgLXElKe7wZpZBFQl9t1uYAexeQUsJRbemsYIYQtK
        nJz5hAWklVlAT6JtI1iYWUBeYvvbOcwQdypI/Hy6jBXiBjeJw7NPskDUiEjM7mxjnsAoPAvJ
        pFkIk2YhmTQLSccCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBkaOluYNx+6oP
        eocYmTgYDzFKcDArifDu1uNJEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZq
        akFqEUyWiYNTqoHpgNQ5hkvNM3Y8e7Kjd/GZ9/Y/Tz3MnerwcuGk+2n3TF8/PWU2t3VBMC+T
        6IfXQpmGRnUiVhrT7kc+X91+dPZxM7bwjxM65y2JUFLceXlS0M8Aq1v9B9dvuVEeqzineFlY
        zIWqLVlbbVX2KKnyxgjIeAhr2237I2If+qTlcMqdL5Yv9M6891bcpMrS3r40zbrom/aGwK9/
        79RMXThLMm9Z1JTnng9nRb7+VPI5MU7o5JaJhlO2Pp/6++6SjrxvdjVbpz3/PM0qTbTjhYB2
        HuNVKym562rt3tKvVqZMV39c1WArnL1lZUH4/ymBszftzs2yCcs9tdXQzVLmN3fs0j1yu6Oe
        rPmmPG3v9uvPfvoLVCmxFGckGmoxFxUnAgBpP4tyCwMAAA==
X-CMS-MailID: 20210126050803epcas1p181f28ec96236552fad1901672aed6f2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210125184007epcas1p39999c1e4325b738e4ff5e42899b8f6b7
References: <000000000000c2865c05b9bcee02@google.com>
        <CGME20210125184007epcas1p39999c1e4325b738e4ff5e42899b8f6b7@epcas1p3.samsung.com>
        <20210125183918.GH308988@casper.infradead.org> 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > On Mon, Jan 25, 2021 at 09:33:14AM -0800, syzbot wrote:
> > > UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28 shift exponent
> > > 4294967294 is too large for 32-bit type 'int'
> >
> > This is an integer underflow:
> >
> >         sbi->dentries_per_clu = 1 <<
> >                 (sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> >
> > I think the problem is that there is no validation of sect_per_clus_bits.
> > We should check it is at least DENTRY_SIZE_BITS and probably that it's
> > less than ... 16?  64?  I don't know what legitimate values are in this field, but I would imagine
> that 255 is completely unacceptable.
> exfat specification describe sect_per_clus_bits field of boot sector could be at most 32 and at least
                                                                                                 typo ^^16
> 0. And sect_size_bits can also affect this calculation, It also needs validation.
> I will fix it.
> Thanks!

