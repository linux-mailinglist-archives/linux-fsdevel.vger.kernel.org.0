Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBD102020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKSJWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:22:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:60259 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSJWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:22:32 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119092229epoutp045d87ff4b737993e875b845549112e752~YhfNXvo3V2842728427epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:22:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119092229epoutp045d87ff4b737993e875b845549112e752~YhfNXvo3V2842728427epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574155350;
        bh=C5HpzZF/B40I1DytgsV5YV/JWUVpaZHra+uzjDkLEQI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Z34phKAZfGzrFPpxyMKoI/APRzjdlr1rpZ46fbfU8JcqK1AG3nWRdHfFm/ActxSdn
         TgLTIPYJw9hRCCmiWJobaCDMPZxk15CAJ4na5/YaHtt0VfWPBXdlSsGaPTYeg/PqJF
         Jjyu1x6g9iY/ktJEA5i4bXPF9wtDYt1VPq/bpu4k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119092229epcas1p2e7c11995821098d63cec46cd3fdb80b5~YhfNG-tMe1921919219epcas1p25;
        Tue, 19 Nov 2019 09:22:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HL2D5Jv5zMqYls; Tue, 19 Nov
        2019 09:22:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.13.04080.454B3DD5; Tue, 19 Nov 2019 18:22:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191119092228epcas1p3bd6eb5a18d813ce1e222e1700647662a~YhfL3YG0a0425704257epcas1p3a;
        Tue, 19 Nov 2019 09:22:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119092228epsmtrp200d78084ed50ab62b8e39b948d634912~YhfL2j-Ws2735327353epsmtrp2Z;
        Tue, 19 Nov 2019 09:22:28 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-f5-5dd3b4548fb7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.5F.03814.454B3DD5; Tue, 19 Nov 2019 18:22:28 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119092228epsmtip1a7ed9bcc4b06a8ecb5333369a159c8f9~YhfLq3ufr0678606786epsmtip1c;
        Tue, 19 Nov 2019 09:22:28 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Daniel Wagner'" <dwagner@suse.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <linkinjeon@gmail.com>, <Markus.Elfring@web.de>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20191119085639.kr4esp72dix4lvok@beryllium.lan>
Subject: RE: [PATCH v2 02/13] exfat: add super block operations
Date:   Tue, 19 Nov 2019 18:22:28 +0900
Message-ID: <00d101d59eba$dcc373c0$964a5b40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEo1XJlLzywHhHshRBLsQkFEP9+bwICkZlvAboM/rECPrXdMKi77zBA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmnm7IlsuxBgeWaVocfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxZZ/R1gtLr3/wOLA6bFz1l12j/1z17B77L7Z
        wObRt2UVo8fm09UenzfJeRza/obN4/azbSwBHFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA5ykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iyjj1fw1JwgLVi3R6TBsb5LF2MHBwSAiYS
        e14EdzFycQgJ7GCUWLjsGDOE84lR4uXUDnYI5xujRP+WO6xdjJxgHZsvX4aq2sso0b36DBuE
        84pRYm3TZCaQKjYBXYl/f/azgdgiAuoS9xsngxUxC9xklNjYtIcFJMEpYCPxpOcmmC0sYC9x
        cf4+sGYWAVWJW7ebwQ7kFbCUeLPdHyTMKyAocXLmE7ByZgF5ie1v5zBDXKQgsePsa0aIXW4S
        i5cdZ4KoEZGY3dkGdqmEwHR2iab7m6GedpG4+DsWoldY4tXxLewQtpTE53d72SBKqiU+7oca
        38Eo8eK7LYRtLHFz/QZWkBJmAU2J9bv0IcKKEjt/z2WE2Mon8e5rDyvEFF6JjjYhiBJVib5L
        h5kgbGmJrvYP7BMYlWYh+WsWkr9mIbl/FsKyBYwsqxjFUguKc9NTiw0LjJFjehMjON1qme9g
        3HDO5xCjAAejEg+vgvrlWCHWxLLiytxDjBIczEoivH6PLsQK8aYkVlalFuXHF5XmpBYfYjQF
        hvpEZinR5HxgLsgriTc0NTI2NrYwMTM3MzVWEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoFR
        /+ifZJ98z4P5n5xTJB9XWDpt0f/95pRNO+/f+ti8eK3sr88F5Gd9OcL7Vi/v5CbvJi4ri5LX
        j7L2753wK42rgkH8C8fqWXeWl9/fd+XlGdsTpfL6gSy2AQo2ts/3uH+0+qp/w/Giw77r2+YH
        V6QqF7pt5ZxseuvB1TNm7MeOsT85csHYJHCpEktxRqKhFnNRcSIAUX/zhs0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnG7IlsuxBrtvCVgcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxZZ/R1gtLr3/wOLA6bFz1l12j/1z17B77L7Z
        wObRt2UVo8fm09UenzfJeRza/obN4/azbSwBHFFcNimpOZllqUX6dglcGceer2EpOMBasW6P
        SQPjfJYuRk4OCQETic2XLzN3MXJxCAnsZpQ48uk8O0RCWuLYiTNACQ4gW1ji8OFiiJoXjBJ7
        1i5jBqlhE9CV+PdnPxuILSKgLnG/cTIbSBGzwGNGiebeB2AbhATeMkpMumIAYnMK2Eg86bkJ
        FhcWsJe4OH8fE4jNIqAqcet2MwvIMl4BS4k32/1BwrwCghInZz4BCzML6Em0bWQECTMLyEts
        fzuHGeJMBYkdZ18zQpzgJrF42XEmiBoRidmdbcwTGIVnIZk0C2HSLCSTZiHpWMDIsopRMrWg
        ODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzjutLR2MJ44EX+IUYCDUYmH94TK5Vgh1sSy4src
        Q4wSHMxKIrx+jy7ECvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl
        4uCUamAU/f7/0IIuYS6vMNlLW/4VfkhQqdz+3Mmm9qyMxqHH1+ui5328WXFkQa+u9kZNPuOz
        j9Ydszd2Ohmu9Ptv/GnRtJkbnHvzFr7e5vFy2u6wzxr1OvFXXVmfTa0J+7bS8Xx17Kd629c8
        1+YLnd6iufW0cmTpiXsZ/3v3/JfWjVmgaHBjdfXJkhk+SizFGYmGWsxFxYkAZohG+bcCAAA=
X-CMS-MailID: 20191119092228epcas1p3bd6eb5a18d813ce1e222e1700647662a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071403epcas1p3f3d69faad57984fa3d079cf18f0a46dc
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071403epcas1p3f3d69faad57984fa3d079cf18f0a46dc@epcas1p3.samsung.com>
        <20191119071107.1947-3-namjae.jeon@samsung.com>
        <20191119085639.kr4esp72dix4lvok@beryllium.lan>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Hi,
Hi,
> 
> On Tue, Nov 19, 2019 at 02:10:56AM -0500, Namjae Jeon wrote:
> > +static void exfat_put_super(struct super_block *sb)
> > +{
> > +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > +
> > +	mutex_lock(&sbi->s_lock);
> > +	if (READ_ONCE(sbi->s_dirt)) {
> > +		WRITE_ONCE(sbi->s_dirt, true);
> 
> No idea what the code does. But I was just skimming over and find the
> above pattern somehow strange. Shouldn't this be something like
Right.

> 
> 	if (!READ_ONCE(sbi->s_dirt)) {
> 		WRITE_ONCE(sbi->s_dirt, true);

It should be :
	if (READ_ONCE(sbi->s_dirt)) {
 		WRITE_ONCE(sbi->s_dirt, false);
I will fix it on v3.
Thanks for review!
> 
> ?
> 
> Thanks,
> Daniel

