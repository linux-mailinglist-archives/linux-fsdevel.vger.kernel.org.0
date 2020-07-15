Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF88220217
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 03:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGOByz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 21:54:55 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46551 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGOByy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:54:54 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200715015450epoutp04afe2064b1f22cd916555678c821719fc~hyjlfvkUr2346223462epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 01:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200715015450epoutp04afe2064b1f22cd916555678c821719fc~hyjlfvkUr2346223462epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594778090;
        bh=BM75WM+A9pA9ayxI/YRxm0bAY78/AuIlepl26x00ESM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=k3sprhZ1J7MauM9M0Ra/krF306jdkbuSbECXW7Th+9y6k/GmtKvESrZtuT/vcNaQu
         B0PE/cNxq3iXCrHoagzV2uG8axjbROUGdXa1zFB6pQaZ7H0e4MD9AaXgCPfq50djjN
         JP6ALIy9470tJBa5L/bB05dEdmZ1UatuVbRnshcI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200715015450epcas1p378c3c44bad600792888eb155cb94956f~hyjlIFO4-3168631686epcas1p3g;
        Wed, 15 Jul 2020 01:54:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B60nP1MRRzMqYkV; Wed, 15 Jul
        2020 01:54:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.0C.29173.9E16E0F5; Wed, 15 Jul 2020 10:54:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200715015448epcas1p42a3cefc71921a97f881d8d70670f8877~hyjjYXEvz2970629706epcas1p4q;
        Wed, 15 Jul 2020 01:54:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200715015448epsmtrp1f31c2fcd6068f552fb6ff7b581e6a4f9~hyjjXobhj2511625116epsmtrp1H;
        Wed, 15 Jul 2020 01:54:48 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-54-5f0e61e95b2d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.F9.08382.8E16E0F5; Wed, 15 Jul 2020 10:54:48 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200715015448epsmtip19bcd59920956b2125be2c8612e088456~hyjjJpAUh2702727027epsmtip1U;
        Wed, 15 Jul 2020 01:54:48 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Tetsuhiro Kohada''" <kohada.t2@gmail.com>
In-Reply-To: <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH] exfat: retain 'VolumeFlags' properly
Date:   Wed, 15 Jul 2020 10:54:48 +0900
Message-ID: <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOchBlupSQwdEhi4rggGDYoy3yLwE5agcKAmVRsN0CrFCHjqflVWYQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvu7LRL54g5932Cx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEnY8rpe+wFp0UrTvc+Z2xgPCLQxcjJISFgIjH3zjWWLkYuDiGBHYwSMz/fZ4Rw
        PjFKHJl8hQ3C+cYo8fTtUXaYltlt96ASexklLl87A+W8ZJTYdu8/K0gVm4CuxL8/+4ESHBwi
        AkYST08WgtQwC/xhlFjXd4sNpIZTIFbi0MN2sHphAUuJl5N2gsVZBFQlnh/6zgrSywsUP7PV
        HyTMKyAocXLmExYQm1lAXmL72znMEAcpSPx8ugxsjIiAm8Sdtu3sEDUiErM726BqFnJIzF5e
        CWG7SHx+PRcqLizx6vgWqMekJF72t7GDrJUQqJb4uB+qpINR4sV3WwjbWOLm+g1glzELaEqs
        36UPEVaU2Pl7LiPEVj6Jd197WCGm8Ep0tAlBlKhK9F06zARhS0t0tX9gn8CoNAvJX7OQ/DUL
        yf2zEJYtYGRZxSiWWlCcm55abFhgjBzVmxjBqVTLfAfjtLcf9A4xMnEwHmKU4GBWEuHl4eKN
        F+JNSaysSi3Kjy8qzUktPsRoCgzoicxSosn5wGSeVxJvaGpkbGxsYWJmbmZqrCTO++8se7yQ
        QHpiSWp2ampBahFMHxMHp1QDU8oMBm6dU8ViDRGyW4/fcLjEedCH4e/yvbrzc97I273vlNBm
        PjD3WW/iHvHaG+/vh2q7X/8dHiE3LfvcNCW3pftzxTXjYxR8Lc0rz86VVhJ2kZzzweHi5M+v
        39/IeFH78ffG1bxTS+SNTmUJ+3x1LFs5R3CvxP/+mulvY94rdn6wU1NjLTxYrXTO0KvzuFm5
        d4e3Ro9c1KyZDuW3f4Rt2GdwbtXifDXfV6VcHG2rNlx0XKn55Zv0jXN/f2lcnCvizRG88hdr
        geBc3v4nnIv1bvl8y3LRPH/xwaqf/TN27XTtn/LLp7v9steban/dq2HVe693mpvHCVV6rZmx
        fGPhqQttBvIvGQUVlfqfaygXKbEUZyQaajEXFScCACjzYI4uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTvdFIl+8wcI/khY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyphy+h57wWnRitO9zxkbGI8IdDFyckgImEjMbrvH1sXI
        xSEksJtR4kJnBwtEQlri2IkzzF2MHEC2sMThw8UQNc8ZJa482s0MUsMmoCvx789+NpAaEQEj
        iacnC0FqmAUamCSuzH8HNbSDSaJl5jd2kAZOgViJQw/bWUFsYQFLiZeTdrKB2CwCqhLPD31n
        BRnECxQ/s9UfJMwrIChxcuYTsHuYBbQleh+2MkLY8hLb385hhrhTQeLn02VgI0UE3CTutG1n
        h6gRkZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl
        5+duYgTHlZbmDsbtqz7oHWJk4mA8xCjBwawkwsvDxRsvxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPdG4cI4IYH0xJLU7NTUgtQimCwTB6dUA5Pes/5S5uKey9Mdp6mum9phazGlx3Nide/Kj6ys
        Py2/Clcc1Dmb9256LUvUvQgj29mn8tff9HewWhd/vKCTxXKqZeGjYtNVhgp2ghxTX7iGhem2
        /5Bds7Trh/FCU+5vLIe3Zj3bVvP+2LzeDObbbyPPuU3IsnE1UtJm1fkYabt3+9kIvpfNtjtY
        F8fX3aso4Fl7I/y0ffiv0/Wfbh5x+saRmfHj58STXKuXPpgQvSiotdDXfrGr1op9p3RZgoIK
        7lZVimeKbxMNlF23JDdSLSml/p2iZs8Ws61Pkx2+lNQXr+2f17U47X9lZpHMh76JiuWZcyye
        fd0zS6fxStF9kwMnCqZlXAyX5lne/krzqhJLcUaioRZzUXEiAKZAbb4aAwAA
X-CMS-MailID: 20200715015448epcas1p42a3cefc71921a97f881d8d70670f8877
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
        <20200708095746.4179-1-kohada.t2@gmail.com>
        <005101d658d1$7202e5d0$5608b170$@samsung.com>
        <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thanks for your reply.
> 
> > > Also, rename ERR_MEDIUM to MED_FAILURE.
> > I think that MEDIA_FAILURE looks better.
> 
> I think so too.
> If so, should I change VOL_DIRTY to VOLUME_DIRTY?
Yes, maybe.
> 
> > > -int exfat_set_vol_flags(struct super_block *sb, unsigned short
> > > new_flag)
> > > +int exfat_set_vol_flags(struct super_block *sb, unsigned short
> > > +new_flags)
> > >  {
> > >  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > >  	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
> > >  	bool sync;
> > If dirty bit is set in on-disk volume flags, we can just return 0 at the beginning of this function ?
> 
> That's right.
> Neither 'set VOL_DIRTY' nor 'set VOL_CLEAN' makes a change to volume flags.
> 
> 
> > > +	if (new_flags == VOL_CLEAN)
> > > +		new_flags = (sbi->vol_flags & ~VOL_DIRTY) | sbi->vol_flags_noclear;
> > > +	else
> > > +		new_flags |= sbi->vol_flags;
> > > +
> > >  	/* flags are not changed */
> > > -	if (sbi->vol_flag == new_flag)
> > > +	if (sbi->vol_flags == new_flags)
> > >  		return 0;
> > >
> > > -	sbi->vol_flag = new_flag;
> > > +	sbi->vol_flags = new_flags;
> > >
> > >  	/* skip updating volume dirty flag,
> > >  	 * if this volume has been mounted with read-only @@ -114,9 +119,9
> > > @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
> > >  	if (sb_rdonly(sb))
> > >  		return 0;
> > >
> > > -	p_boot->vol_flags = cpu_to_le16(new_flag);
> > > +	p_boot->vol_flags = cpu_to_le16(new_flags);
> > How about set or clear only dirty bit to on-disk volume flags instead
> > of using
> > sbi->vol_flags_noclear ?
> >        if (set)
> >                p_boot->vol_flags |= cpu_to_le16(VOL_DIRTY);
> >        else
> >                p_boot->vol_flags &= cpu_to_le16(~VOL_DIRTY);
> 
> In this way, the initial  VOL_DIRTY cannot be retained.
> The purpose of this patch is to avoid losing the initial VOL_DIRTY and MED_FAILURE.
> Furthermore, I'm also thinking of setting MED_FAILURE.
I know what you do. I mean this function does not need to be called if volume dirty
Is already set on on-disk volume flags as I said earlier.
> 
> However, the formula for 'new_flags' may be a bit complicated.
> Is it better to change to the following?
> 
> 	if (new_flags == VOL_CLEAN)
> 		new_flags = sbi->vol_flags & ~VOL_DIRTY
> 	else
> 		new_flags |= sbi->vol_flags;
> 
> 	new_flags |= sbi->vol_flags_noclear;
> 
> 
> one more point,
> Is there a better name than 'vol_flags_noclear'?
> (I can't come up with a good name anymore)
It looks complicated. It would be better to simply set/clear VOLUME DIRTY bit.

Thanks!
> 
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

