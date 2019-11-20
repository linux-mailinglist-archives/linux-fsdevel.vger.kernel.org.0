Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165D710328F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKTEdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 23:33:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19135 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfKTEdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:33:21 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191120043318epoutp01e8c6ca182ed8fb97bbdbdb467d06ec43~YxMAOwaef2620926209epoutp01N
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 04:33:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191120043318epoutp01e8c6ca182ed8fb97bbdbdb467d06ec43~YxMAOwaef2620926209epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574224398;
        bh=+WrvUKRWjigTO8zWpKSQfeGnJ6UtPUA5CN1IJiTH4vs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aUeq+hBkpOw6oPebhKGGJoIhOKtfDqGg4jD5sN5eKMVQMvhlUO/1cIvc60TPulJyF
         wAZtlMPjKfUcMM5tnWliBbYldUNlSjNMcIunTl1ITrlFr7U3fgVSrMPakJtnxYbtDd
         9LMj1MdZ3sY75iZKjdvKpoIypiRCu2GEN80m6Xlc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191120043318epcas1p2e23d237b91c282f7c5c093a9613bd272~YxL-9mAQ11649016490epcas1p2w;
        Wed, 20 Nov 2019 04:33:18 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47HqZ53wWLzMqYkf; Wed, 20 Nov
        2019 04:33:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.C0.04235.D02C4DD5; Wed, 20 Nov 2019 13:33:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191120043316epcas1p2ead7f625cfdd1574387fb4d58dc98365~YxL_btG0w3201932019epcas1p2R;
        Wed, 20 Nov 2019 04:33:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191120043316epsmtrp21a6d7e0ee72ba6e30dd1a6d55354a333~YxL_a_RwI2914729147epsmtrp2X;
        Wed, 20 Nov 2019 04:33:16 +0000 (GMT)
X-AuditID: b6c32a36-defff7000000108b-8b-5dd4c20d2445
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.54.03654.C02C4DD5; Wed, 20 Nov 2019 13:33:16 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191120043316epsmtip2409e867c6a92859f2b0bd6e515c223a8~YxL_NZsuU0399303993epsmtip2U;
        Wed, 20 Nov 2019 04:33:16 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     "'Daniel Wagner'" <dwagner@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <Markus.Elfring@web.de>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20191119171752.GA20042@lst.de>
Subject: RE: [PATCH v2 02/13] exfat: add super block operations
Date:   Wed, 20 Nov 2019 13:33:16 +0900
Message-ID: <007901d59f5b$a0eb6780$e2c23680$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQEo1XJlLzywHhHshRBLsQkFEP9+bwICkZlvAboM/rECPrXdMAJVBHmKAkbIIb+omFKvQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmgS7voSuxBl/OSlscfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxZZ/R1gtLr3/wOLA6bFz1l12j/1z17B77L7Z
        wObRt2UVo8fm09UenzfJeRza/obN4/azbSwBHFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA5ykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iyfl/nL7jKWrHr9yymBsZNLF2MnBwSAiYS
        vf/vs3YxcnEICexglPiw5w4jhPOJUWLBpAVsEM43Rokp0x4wwrQcv30dKrGXUeLb93csEM4r
        RokJ69rYQKrYBHQl/v3ZD2aLCKhJnPnZxg5SxAwy9/7MbqBRHBycAjoSe++Ug9QIC9hLXJy/
        jwnEZhFQlXj7eiPYNl4BS4mtKzZA2YISJ2c+ATucWUBeYvvbOcwQFylI7Dj7mhEiLiIxu7ON
        GWS8iECYxIfNQSBrJQT62SW2d+yE+sBF4uLRGdAAEJZ4dXwLO4QtJfH53V42kF4JgWqJj/uh
        xncwSrz4bgthG0vcXL+BFaSEWUBTYv0ufYiwosTO33OhLuCTePe1hxViCq9ER5sQRImqRN+l
        w0wQtrREV/sH9gmMSrOQ/DULyV+zkPwyC2HZAkaWVYxiqQXFuempxYYFRshRvYkRnHC1zHYw
        Ljrnc4hRgINRiYfX4tLlWCHWxLLiytxDjBIczEoivH6PLsQK8aYkVlalFuXHF5XmpBYfYjQF
        BvtEZinR5HxgNsgriTc0NTI2NrYwMTM3MzVWEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoGR
        LUJtS33szykCUTX7H2lO3XStedlr9uViCtt9q56VOSnf6ymIf/f/15T5X/b+n/480VE2PPI5
        /1sp1mdlynd1OYyuX2i7wLeIt6SHX/2X6vLnzSxLvoamqKe/kTjy917M7ZPXRW65eaSXsk96
        3Ph/5jdv1bli8Xf5L589lDqt2N7n6JpLufW5SizFGYmGWsxFxYkAN8F2+84DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvC7PoSuxBs27TSwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzVYsu/I6wWl95/YHHg9Ng56y67x/65a9g9dt9s
        YPPo27KK0WPz6WqPz5vkPA5tf8PmcfvZNpYAjigum5TUnMyy1CJ9uwSujN/X+Quuslbs+j2L
        qYFxE0sXIyeHhICJxPHb19lAbCGB3YwSRw7EQcSlJY6dOMPcxcgBZAtLHD5cDFHyglHi+oMM
        EJtNQFfi35/9YK0iAmoSZ362sXcxcnEwC/xilDj3vosVxAGaySTR+vM7G8ggTgEdib13ykEa
        hAXsJS7O38cEYrMIqEq8fb2REcTmFbCU2LpiA5QtKHFy5hMWkFZmAT2JNogSZgF5ie1v5zBD
        nKkgsePsa6i4iMTszjawk0UEwiQ+bA6awCg8C8mgWQiDZiEZNAtJ8wJGllWMkqkFxbnpucWG
        BYZ5qeV6xYm5xaV56XrJ+bmbGMExp6W5g/HykvhDjAIcjEo8vBaXLscKsSaWFVfmHmKU4GBW
        EuH1e3QhVog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbG
        SEWVdI05u49mqYff/2zvm1h5I+VmM/9H+RMPfhTd5tN8deTj9nUiOZsd0z00X5hpTYzY++/a
        k13LS0rq5y3sSTfaWV3O3bYr520Rq+77a2xL2e4rlAoXJGz99Tmp2fCss6RXzYSycwKbDacY
        tNiejbWJvi954FCdDrdPY+fXliX5UenzhZ2VWIozEg21mIuKEwF1F7VBtQIAAA==
X-CMS-MailID: 20191120043316epcas1p2ead7f625cfdd1574387fb4d58dc98365
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
        <00d101d59eba$dcc373c0$964a5b40$@samsung.com>
        <20191119171752.GA20042@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Nov 19, 2019 at 06:22:28PM +0900, Namjae Jeon wrote:
> > > No idea what the code does. But I was just skimming over and find the
> > > above pattern somehow strange. Shouldn't this be something like
> > Right.
> >
> > >
> > > 	if (!READ_ONCE(sbi->s_dirt)) {
> > > 		WRITE_ONCE(sbi->s_dirt, true);
> >
> > It should be :
> > 	if (READ_ONCE(sbi->s_dirt)) {
> >  		WRITE_ONCE(sbi->s_dirt, false);
> > I will fix it on v3.
> 
> The other option would be to an unsigned long flags field and define
> bits flags on it, then use test_and_set_bit, test_and_clear_bit etc.
> Which might be closer to the pattern we use elsewhere in the kernel.
I will replace it with test_and_set/clear_bit().

Thanks!

