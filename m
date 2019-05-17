Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70322136B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEQFcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 01:32:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22042 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfEQFcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 01:32:10 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190517053207epoutp0449cb4ca4fcd45e893e47ede43093e25a~fYW9kVnMi2295422954epoutp04D
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 05:32:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190517053207epoutp0449cb4ca4fcd45e893e47ede43093e25a~fYW9kVnMi2295422954epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558071127;
        bh=QoTb4J0MrDDwjXI5H0Us5qd6vRZEw/A2DnYVdFwNDKs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AdUEU8kyiPppfK8EiOpBmjPqi8cBeSx0mXpu7jy6Bn3kD3wRG2LdivADeGg5yp3cp
         0J09ysVXCuc9RQYhIauxTmu29imNiWpL7SNKRzP+Fq9JCqDAmZojkBjtlGIx0Tg15c
         c9IS3WPk2Wp7VBU0OisVxeQ14iOu5qsaQcbMPsow=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190517053206epcas5p4b2e9229062957ac7436e187f43b9036d~fYW9AI5Bn2456024560epcas5p4s;
        Fri, 17 May 2019 05:32:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.D8.04066.6574EDC5; Fri, 17 May 2019 14:32:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190517053206epcas5p275a94194a8e60c0ec38c9f8ad7424570~fYW8tLZYv2772627726epcas5p2-;
        Fri, 17 May 2019 05:32:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190517053206epsmtrp268ab76a813e98e2764488c436d7cc3f0~fYW8sdtQd1717817178epsmtrp2v;
        Fri, 17 May 2019 05:32:06 +0000 (GMT)
X-AuditID: b6c32a4a-973ff70000000fe2-77-5cde47560a17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.63.03662.6574EDC5; Fri, 17 May 2019 14:32:06 +0900 (KST)
Received: from JOSHIK01 (unknown [107.111.93.135]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190517053204epsmtip298269f87eb140783bb081bc4f965491c~fYW7U4EYQ2086620866epsmtip2j;
        Fri, 17 May 2019 05:32:04 +0000 (GMT)
From:   "kanchan" <joshi.k@samsung.com>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <prakash.v@samsung.com>,
        <anshul@samsung.com>
In-Reply-To: <20190510170249.GA26907@infradead.org>
Subject: RE: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Date:   Fri, 17 May 2019 11:01:55 +0530
Message-ID: <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJoSeMIlXjPMuci1lQDnd0IsY+e8wLu+qiYAUGsmF+lJrwgsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmlm6Y+70Yg8nHZS1+T5/CanF6wiIm
        i723tC1mzrvDZrFn70kWi8u75rBZzF/2lN3iypRFzA4cHptXaHlsXlLv0bdlFaPH501yASxR
        XDYpqTmZZalF+nYJXBmXD25kLZgtWHH8xQbmBsa5fF2MnBwSAiYSV349ZAaxhQR2M0pcW6sM
        YX9ilNj/172LkQvI/sYo8X/tJrYuRg6whj1rYyDiexklFt37yALhPGeUODnlGTtIN5uAqsS9
        H71sILaIgK7E2YUvGEFsZoGrjBIXNoeC2JwCxhJvlj4D2ywsECfRcHcCWC8LUO/TjnZWEJtX
        wFLiz81JTBC2oMTJmU9YIObIS2x/O4cZ4gMFid2fjrKCHCci4CSxckUuRIm4xMujR9hBbpMQ
        eM0m8WfTGhaIeheJyUuusEPYwhKvjm+BsqUkPr/bywZhF0v8unOUGaK5g1HiesNMqGZ7iYt7
        /jKBLGMW0JRYv0sfYhmfRO/vJ0yQAOKV6GgTgqhWlLg36SkrhC0u8XDGEijbQ+Lh282MExgV
        ZyH5bBaSz2YheWEWwrIFjCyrGCVTC4pz01OLTQuM8lLL9YoTc4tL89L1kvNzNzGCk4+W1w7G
        Zed8DjEKcDAq8fAK+NyNEWJNLCuuzD3EKMHBrCTCu+H97Rgh3pTEyqrUovz4otKc1OJDjNIc
        LErivJNYr8YICaQnlqRmp6YWpBbBZJk4OKUaGHsUg/cuzhA3cT5ize57oPVrbt+qZ8ukNXPF
        4htk4/hyipyzlRJ0l4rHdC6sdptRwXbn4YdN336vO/Z30V+W2sTyzRLLNC/+sf4Xpm8aE/1l
        +ZVwNa1Uo0kXW1XsPp77FTtJYcGpJ1y+vGzXpJ/dvq8yp3P2l986uz/unCp8+sPLnMexjdsW
        /ldiKc5INNRiLipOBABRZoWPOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXjfM/V6MwZZPHBa/p09htTg9YRGT
        xd5b2hYz591hs9iz9ySLxeVdc9gs5i97ym5xZcoiZgcOj80rtDw2L6n36NuyitHj8ya5AJYo
        LpuU1JzMstQifbsErozLBzeyFswWrDj+YgNzA+Ncvi5GDg4JAROJPWtjuhi5OIQEdjNK7Fy+
        kq2LkRMoLi7RfO0HO4QtLLHy33N2iKKnjBJHN0wCK2ITUJW496MXzBYR0JU4u/AFI0gRs8Bd
        Rom3M5Yxwo3tX/UerIpTwFjizdJnzCC2sECMxPrJC8HiLECTnna0s4LYvAKWEn9uTmKCsAUl
        Ts58wgJyKrOAnkTbRkaQMLOAvMT2t3OYIa5TkNj96SgrSImIgJPEyhW5ECXiEi+PHmGfwCg8
        C8mgWQiDZiEZNAtJxwJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFRpKW1g/HE
        ifhDjAIcjEo8vDs878YIsSaWFVfmHmKU4GBWEuHd8P52jBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQbGtSvPLP/z/omR9ddeRvfu0w+PfZjBnCjFePmI
        jOy9FvdSs4uffx69fXBt9MyJPXr1heeyt/4ttfuzrti6OexOkqbs9CUf/hZwVpkov/qx513o
        6ZK8pzqTtP26G69duvT8WMvyL6sefy7I+NjMZ7/i8Yk614sftLn5ckW57t0RDNm/Jmbi87jv
        05VYijMSDbWYi4oTAciFmlieAgAA
X-CMS-MailID: 20190517053206epcas5p275a94194a8e60c0ec38c9f8ad7424570
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
        <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
        <20190510170249.GA26907@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph, 

> Including the one this model causes on at least some SSDs where you now
statically allocate resources to a stream that is now not globally
available.  

Sorry but can you please elaborate the issue? I do not get what is being
statically allocated which was globally available earlier.
If you are referring to nvme driver,  available streams at subsystem level
are being reflected for all namespaces. This is same as earlier. 
There is no attempt to explicitly allocate (using dir-receive) or reserve
streams for any namespace.  
Streams will continue to get allocated/released implicitly as and when
writes (with stream id) arrive.

> All for the little log with very short date lifetime that any half decent
hot/cold partitioning algorithm in the SSD should be able to detect.

With streams, hot/cold segregation is happening at the time of placement
itself, without algorithm; that is a clear win over algorithms which take
time/computation to be able to do the same.
And infrastructure update (write-hint-to-stream-id conversion in
block-layer,  in-kernel hints etc.) seems to be required anyway for streams
to extend its reach beyond nvme and user-space hints.
  
Thanks,

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Friday, May 10, 2019 10:33 PM
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-kernel@vger.kernel.org; linux-block@vger.kernel.org;
linux-nvme@lists.infradead.org; linux-fsdevel@vger.kernel.org;
linux-ext4@vger.kernel.org; prakash.v@samsung.com; anshul@samsung.com
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
for Ext4 journal

I think this fundamentally goes in the wrong direction.  We explicitly
designed the block layer infrastructure around life time hints and not the
not fish not flesh streams interface, which causes all kinds of problems.

Including the one this model causes on at least some SSDs where you now
statically allocate resources to a stream that is now not globally
available.  All for the little log with very short date lifetime that any
half decent hot/cold partitioning algorithm in the SSD should be able to
detect.

