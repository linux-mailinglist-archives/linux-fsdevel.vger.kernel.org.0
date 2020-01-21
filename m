Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2829C1435B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAUCeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 21:34:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58497 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAUCep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:34:45 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200121023443epoutp0114f38ee08662f6f31d248257149a04b8~rxkKgKe8P0414804148epoutp01b
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 02:34:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200121023443epoutp0114f38ee08662f6f31d248257149a04b8~rxkKgKe8P0414804148epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579574083;
        bh=ytyuKC3Vaj3EpWIHdeU7Z8cdnKoV6N5MeakWV4sXtIk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VJIt6MyKso2pVx9TnGLfwBsCWnuMLWneCaZeDsj+BL4fC+B2BUjumA4lWKaUqSY9G
         eN4rH/7ISf52qTzHj4FF3eyDf84hxqdbg7q2L6+XoYmEadmBaQKVksr/luqaSrVLGi
         8JELOIkEbkxRRYYaa0tzAoTFeMrOBTm0vVbkYTBE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200121023442epcas1p41268305eb429b9922c322b88fcd89f22~rxkJg5a-U0657906579epcas1p46;
        Tue, 21 Jan 2020 02:34:42 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 481t0d5ll4zMqYkZ; Tue, 21 Jan
        2020 02:34:41 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.9C.52419.143662E5; Tue, 21 Jan 2020 11:34:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121023441epcas1p2d4bbc0d350fbb1f6cad140b932b1d917~rxkIEjHI30266402664epcas1p23;
        Tue, 21 Jan 2020 02:34:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121023441epsmtrp11d6e4ae4dfa611f73148564084643db0~rxkIDo2S31841618416epsmtrp1x;
        Tue, 21 Jan 2020 02:34:41 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-c5-5e266341338e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.AB.06569.043662E5; Tue, 21 Jan 2020 11:34:41 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200121023440epsmtip11d8a475f58e79ed8dda32c196ed89aab~rxkH3LIIh1939219392epsmtip1X;
        Tue, 21 Jan 2020 02:34:40 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <pali.rohar@gmail.com>,
        <arnd@arndb.de>, "'Namjae Jeon'" <linkinjeon@gmail.com>
In-Reply-To: <20200121014924.GI8904@ZenIV.linux.org.uk>
Subject: RE: [PATCH v12 02/13] exfat: add super block operations
Date:   Tue, 21 Jan 2020 11:34:40 +0900
Message-ID: <005201d5d003$55325960$ff970c20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGweyIxypJzru68cwvOK1cQ+ZOFYgKRp5m0AvjvcmoCRBuVtKgAmmug
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmrq5jslqcQd8XfYu/k46xWzQvXs9m
        sXL1USaL63dvMVvs2XuSxeLyrjlsFhNP/2ay2PLvCKvFpfcfWCzO/z3O6sDl8fvXJEaPnbPu
        snvsn7uG3WP3zQY2j74tqxg9Pm+S8zi0/Q2bx6Ynb5kCOKJybDJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJVJuRkLD+5lLngBG/F40s/mBoYm7m7
        GDk5JARMJPbOucvaxcjFISSwg1HizNUNbF2MHEDOJ0aJlz4Q8W+MEtO/TWSEaZjRvoAFIrGX
        UeLjyi9Q3S8ZJf79uccKUsUmoAtk72cDsUUENCX+z53ADFLELPCbUaJpcwMTSIJTwFxi+rpL
        7CC2sICDxOSDt1lAbBYBVYlf+2aA1fAKWEpcnNDADGELSpyc+QSshllAXmL72znMECcpSPx8
        uowVYpmbxNcnV9ghakQkZne2gS2WEFjELnFq5T4WiAYXiU/XN0P9Iyzx6vgWdghbSuJlfxs7
        yP8SAtUSH/dDze9glHjx3RbCNpa4uX4DK0gJM9Bj63fpQ4QVJXb+nssIsZZP4t3XHlaIKbwS
        HW1CECWqEn2XDjNB2NISXe0f2CcwKs1C8tgsJI/NQvLALIRlCxhZVjGKpRYU56anFhsWGCPH
        9SZGcPrVMt/BuOGczyFGAQ5GJR5eh2mqcUKsiWXFlbmHGCU4mJVEeBc0AYV4UxIrq1KL8uOL
        SnNSiw8xmgLDfSKzlGhyPjA35JXEG5oaGRsbW5iYmZuZGiuJ885wUYgTEkhPLEnNTk0tSC2C
        6WPi4JRqYKw4b2oV1XLhnsnFq+KMTten/7lZpXHrjv3JPdPmxl3zmvR5Y/H2vjnvL+ystnl4
        pOLrvVUMgucPZB+IiPG7ntj6ZVaf1p7/Hu3f31v8Tu25sustg/KB/C8L1p+uZGv0XMR6s/7A
        j0usrfHppyUdfV/t9HB+LTWP4UOGXfxl2xSulx2bLeZl71msxFKckWioxVxUnAgA1AWn6tUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnK5jslqcwf2PTBZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLCae/s1kseXfEVaLS+8/sFic/3uc1YHL4/evSYweO2fd
        ZffYP3cNu8fumw1sHn1bVjF6fN4k53Fo+xs2j01P3jIFcERx2aSk5mSWpRbp2yVwZSw/uZS5
        4ARvxeNLP5gaGJu5uxg5OSQETCRmtC9g6WLk4hAS2M0osezWVlaIhLTEsRNnmLsYOYBsYYnD
        h4shap4zSsxed4oFpIZNQFfi35/9bCC2iICmxP+5E5hBipgFWpkkPq5aATZISOAJo8T7TVwg
        NqeAucT0dZfYQWxhAQeJyQdvgw1iEVCV+LVvBhOIzStgKXFxQgMzhC0ocXLmExaQI5gF9CTa
        NjKChJkF5CW2v53DDHGngsTPp8tYIW5wk/j65Ao7RI2IxOzONuYJjMKzkEyahTBpFpJJs5B0
        LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyHWlo7GE+ciD/EKMDBqMTD6zBN
        NU6INbGsuDL3EKMEB7OSCO+CJqAQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZ
        qakFqUUwWSYOTqkGxrawL4s475l3amy+fXK54HKmdV/fTbhicvHuiW6mtwn9jisvieS5ZV+6
        a/yi1vzivRf13/JeqtVbmjeG9doeMwphMJPv05rT03dk6fq/7UYRD84Z7ymdsXzWr6/B5vUT
        ExcyCmr+k+bmu/pd+m6u5Y7Y4NV91naNb3ffXf5ZiX177WLeRhbl20osxRmJhlrMRcWJAAuI
        uH2/AgAA
X-CMS-MailID: 20200121023441epcas1p2d4bbc0d350fbb1f6cad140b932b1d917
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200121014933epcas1p22c54d6162bca6ebe14715542f034993b
References: <20200120124428.17863-1-linkinjeon@gmail.com>
        <20200120124428.17863-3-linkinjeon@gmail.com>
        <CGME20200121014933epcas1p22c54d6162bca6ebe14715542f034993b@epcas1p2.samsung.com>
        <20200121014924.GI8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +static void exfat_put_super(struct super_block *sb) {
> > +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > +
> > +	mutex_lock(&sbi->s_lock);
> > +	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state))
> > +		sync_blockdev(sb->s_bdev);
> > +	exfat_set_vol_flags(sb, VOL_CLEAN);
> > +	exfat_free_upcase_table(sb);
> > +	exfat_free_bitmap(sb);
> > +	mutex_unlock(&sbi->s_lock);
> > +
> > +	if (sbi->nls_io) {
> > +		unload_nls(sbi->nls_io);
> > +		sbi->nls_io = NULL;
> > +	}
> > +	exfat_free_iocharset(sbi);
> > +	sb->s_fs_info = NULL;
> > +	kfree(sbi);
> > +}
> 
> You need to RCU-delay freeing sbi and zeroing ->nls_io.  *Everything* used
> by ->d_compare() and ->d_hash() needs that treatment.  RCU-mode pathwalk
> can stray into a filesystem that has already been lazy-umounted and is
> just one close() away from shutdown.  It's OK, as long as you make sure
> that all structures used in methods that could be called in RCU mode (-
> >d_compare(), ->d_hash(), rcu-case ->d_revalidate(), rcu-case -
> >permission()) have destruction RCU-delayed.  Look at what VFAT is doing;
> that's precisely the reason for that delayed_free() thing in there.
Okay.
> 
> > +static void exfat_destroy_inode(struct inode *inode) {
> > +	kmem_cache_free(exfat_inode_cachep, EXFAT_I(inode)); }
> 
> No.  Again, that MUST be RCU-delayed; either put an explicit
> call_rcu() here, or leave as-is, but make that ->free_inode().
Okay.
> 
> > +static void __exit exit_exfat_fs(void) {
> > +	kmem_cache_destroy(exfat_inode_cachep);
> > +	unregister_filesystem(&exfat_fs_type);
> 
> ... and add rcu_barrier() here.
Okay, I will fix them on next version.
Thanks for review!!
> 
> > +	exfat_cache_shutdown();

