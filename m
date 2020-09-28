Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0427A902
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1Htj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 03:49:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37971 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgI1Hti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:49:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200928074935epoutp03630b487ad237e715431e27b109bd8046~44xu4DbJf1336913369epoutp03e
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 07:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200928074935epoutp03630b487ad237e715431e27b109bd8046~44xu4DbJf1336913369epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601279375;
        bh=cT1jG6d44BxbMOeI9Jd+R7Rj+TjyWzem/28HC4X3mxE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ASFBaC3awHFneJ2D/zgdZXfWqB6MN8e9ijLzhh6wOqoXz5kAsJgfbK5N8Gx48Tu8i
         4ClyPVh7Q54CYch5XfdnRmC809T7VIDQXk6EraBECl8IynwJDOAYofEOXcpzy9jdPY
         Ijtap2P5W7iCznciL9Fod5AtPA8RP56HmhOq2EjM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200928074935epcas1p37bb24c0b23389aca8de549d9a0a4c917~44xuZ6DzC3019430194epcas1p3j;
        Mon, 28 Sep 2020 07:49:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4C0F66174kzMqYkc; Mon, 28 Sep
        2020 07:49:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.00.10463.E85917F5; Mon, 28 Sep 2020 16:49:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200928074933epcas1p3b9790f1c77fe4f8ed208454fa4f5ac49~44xtA0DyB3019430194epcas1p3c;
        Mon, 28 Sep 2020 07:49:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200928074933epsmtrp134697861416c0800625df84f092ce5db~44xtAMLLh1259712597epsmtrp1T;
        Mon, 28 Sep 2020 07:49:33 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-9e-5f71958e6f72
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.BC.08745.D85917F5; Mon, 28 Sep 2020 16:49:33 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200928074933epsmtip21ee9e80b15097ab5c1b3c43c941ddf45~44xszwthw0267902679epsmtip2F;
        Mon, 28 Sep 2020 07:49:33 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <8c9701d6956a$13898560$3a9c9020$@samsung.com>
Subject: RE: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Date:   Mon, 28 Sep 2020 16:49:33 +0900
Message-ID: <000001d6956b$e7bab2e0$b73018a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGgZsB+KXs97exselB5tzyGrN5ddgLZy8s5AfgkmQwBsa3PiQKkiTMzqaDIvgA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmnm7f1MJ4g0+TWC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEn49LU6awFx4Uqpm5tYGlgXMDXxcjJISFgIjGx7RdbFyMXh5DADkaJxycmsUA4
        nxglGhq7GSGcz4wSO7smsMK03PixCqpqF6PE9lPdrBDOS6CqvU1gVWwCuhL//uxnA7FFBPQk
        Tp68DraEWaCRSWLC9R6wBKeAlcTsmTvZQWxhAU+Jxi9rgMZycLAIqEpcajQGCfMKWEq8bdzG
        BGELSpyc+YQFxGYWkJfY/nYOM8RFChI/ny5jhdjlJ9G/aCITRI2IxOzONmaQvRICCzkkXh/v
        YoJocJE4tP8SO4QtLPHq+BYoW0riZX8bO8gNEgLVEh/3Q83vYJR48d0WwjaWuLl+AytICbOA
        psT6XfoQYUWJnb/nMkKs5ZN497WHFWIKr0RHmxBEiapE36XDUAdIS3S1f2CfwKg0C8ljs5A8
        NgvJA7MQli1gZFnFKJZaUJybnlpsWGCCHNmbGMHpVMtiB+Pctx/0DjEycTAeYpTgYFYS4fXN
        KYgX4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnAhJ5XEm9oamRsbGxhYmZuZmqsJM778JZC
        vJBAemJJanZqakFqEUwfEwenVAOT377f6tcK33nvYH9hr/A/UUDKK1Dh24U/Jstc8+0+zplc
        NVfi5OfsHbe8bsuKLjv/fOudeKH8OuHz92/odLPdDPGpiwpvD235VXGQac/KBVNmVGst7ln2
        +kYy35cI3zLJjc7eGauve3VLZGzMElfzmcYUvTzi+pzgw9VJGiLz5p5vT352yiygReC+XKK1
        fMdFlgAP66NcXpdFeK5/csr2mc+0ZfqtmHDHAsNK2Ys8/pbhFSd2n5cTnfDRVOv7xEyN5z7l
        3xo3H+3Syc5L2JcZLM+nrPSOJ9jcW5cvaT/fp8IDwmrruz7ofD0cHbbV96fVirY1n24EmBYe
        fjJPpLBzm1agXWhZdaXKlTkLk5VYijMSDbWYi4oTAaRbUZgwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXrd3amG8weFGVYsfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZVyaOp214LhQxdStDSwNjAv4uhg5OSQETCRu/FjF0sXI
        xSEksINR4uKsG4wQCWmJYyfOMHcxcgDZwhKHDxdD1DxnlFh+YjILSA2bgK7Evz/72UBsEQE9
        iZMnr7OBFDELNDNJfN57mx0kISQwnUlid3ckiM0pYCUxe+ZOsLiwgKdE45c1LCALWARUJS41
        GoOEeQUsJd42bmOCsAUlTs58AraLWUBbovdhKyOELS+x/e0cZog7FSR+Pl3GCnGDn0T/oolM
        EDUiErM725gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOC40tLawbhn1Qe9Q4xMHIyHGCU4mJVEeH1zCuKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        836dtTBOSCA9sSQ1OzW1ILUIJsvEwSnVwBTVmvxl96qinb9t1Gda72xmDPB585FPSnZ2Scyf
        pSonXtytLlepnmfwxbotTi3v/46m9q7oZ5JRfqzbS+ezq8gaF8lW7brh+Zwnznv3VYWQll6R
        Xc/Xau6fy7do0dy6k5aMZuv1eRYppArtmDm7hGO+9fWlfJbW8U83rV7x5r3CjPQ+/moWqx6v
        /3IcN73qWbbUXZogWpGh//j5TZH9udNTK7cXJCUum2v5jectf+DNjOe8qXzn5f34j92ZFTSt
        19BcbcaLz2IbxSqX6hatXrDDWiOq4+a51M2v/Or3GL5hqgjveuW1ewNTteTsC2+X7ZyzZX31
        hbM8UyeJV1cqGtwuFVtQVB2buGuPEkPWbiWW4oxEQy3mouJEAFtRXWEaAwAA
X-CMS-MailID: 20200928074933epcas1p3b9790f1c77fe4f8ed208454fa4f5ac49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
        <20200911044506.13912-1-kohada.t2@gmail.com>
        <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
        <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
        <8c9701d6956a$13898560$3a9c9020$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >> --- a/fs/exfat/namei.c
> > >> +++ b/fs/exfat/namei.c
> > >> @@ -1095,11 +1095,6 @@ static int exfat_move_file(struct inode
> > >> *inode, struct exfat_chain *p_olddir,
> > >>   	if (!epmov)
> > >>   		return -EIO;
> > >>
> > >> -	/* check if the source and target directory is the same */
> > >> -	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
> > >> -	    le32_to_cpu(epmov->dentry.stream.start_clu) == p_newdir->dir)
> > >> -		return -EINVAL;
> > >> -
> > >
> > > It might check if the cluster numbers are same between source entry
> > > and target directory.
> >
> > This checks if newdir is the move target itself.
> > Example:
> >    mv /mnt/dir0 /mnt/dir0/foo
> >
> > However, this check is not enough.
> > We need to check newdir and all ancestors.
> > Example:
> >    mv /mnt/dir0 /mnt/dir0/dir1/foo
> >    mv /mnt/dir0 /mnt/dir0/dir1/dir2/foo
> >    ...
> >
> > This is probably a taboo for all layered filesystems.
> >
> >
> > > Could you let me know what code you mentioned?
> > > Or do you mean the codes on vfs?
> >
> > You can find in do_renameat2(). --- around 'fs/namei.c:4440'
> > If the destination ancestors are itself, our driver will not be called.
> 
> I think, of course, vfs has been doing that.
> So that code is unnecessary in normal situations.
> 
> That code comes from the old exfat implementation.
> And as far as I understand, it seems to check once more "the cluster number"
> even though it comes through vfs so that it tries detecting abnormal of on-disk.
> 
> Anyway, I agonized if it is really needed.
> In conclusion, old code could be eliminated and your patch looks reasonable.
> Thanks
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> >
> >
> > BTW
> > Are you busy now?
> I'm sorry, I'm so busy for my full time work :( Anyway, I'm trying to review serious bug patches or
> bug reports first.
> Other patches, such as clean-up or code refactoring, may take some time to review.
> 
> > I am waiting for your reply about "integrates dir-entry getting and
> > validation" patch.
> As I know, your patch is being under review by Namjae.
I already gave comments and a patch, but you said you can't do it.
I'm sorry, But I can't accept an incomplete patch. I will directly fix it later.
> 
> >
> > BR
> > ---
> > Tetsuhiro Kohada <kohada.t2@gmail.com>


