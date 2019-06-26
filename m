Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22656569AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfFZMrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 08:47:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18809 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfFZMrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:47:46 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190626124744epoutp023267a5ef7f24f9aa2f3502d2494717f7~rwGvFJcSE1693416934epoutp02W
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 12:47:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190626124744epoutp023267a5ef7f24f9aa2f3502d2494717f7~rwGvFJcSE1693416934epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561553264;
        bh=zH5ztn3xX70umuBcDQcF3am8p4S1Z0cIrMZJqK3E2CY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ewcLwayRZ4pRxQPNz2yVY9OIrGq6UqOhW4CY/8xSZOt5TXeLKBjfF0zVmkf4ARe5y
         /5/IqygTb0WTtbW1W3CW4QwdWA9WoeVm4RVvGFjVfxxpVz1//cMk0b+zO9MoX5xRKl
         eP1edKnpi3TYYqa7dyNX5fIGHxUHCY3ICwgk+Evo=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190626124744epcas5p467d19851ca8e3cde56123960ec2aac30~rwGucKiQG2481324813epcas5p4g;
        Wed, 26 Jun 2019 12:47:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.C2.04067.079631D5; Wed, 26 Jun 2019 21:47:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190626124743epcas5p105f8e82af483f0cd360b6c3d3944d545~rwGt9ylmb2730427304epcas5p1y;
        Wed, 26 Jun 2019 12:47:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626124743epsmtrp18e50bf82a358dde82e8a3fa29c6cd25b~rwGt9BOcl3178031780epsmtrp1K;
        Wed, 26 Jun 2019 12:47:43 +0000 (GMT)
X-AuditID: b6c32a4b-7a3ff70000000fe3-bf-5d136970370a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.52.03662.F69631D5; Wed, 26 Jun 2019 21:47:43 +0900 (KST)
Received: from JOSHIK01 (unknown [107.111.93.135]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190626124742epsmtip2335a164549cc240db896799ca1f82e62~rwGsgATdi1669716697epsmtip2L;
        Wed, 26 Jun 2019 12:47:42 +0000 (GMT)
From:   "kanchan" <joshi.k@samsung.com>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <prakash.v@samsung.com>,
        <anshul@samsung.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Jan Kara'" <jack@suse.cz>
In-Reply-To: <20190522102530.GK17019@quack2.suse.cz>
Subject: RE: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Date:   Wed, 26 Jun 2019 18:17:29 +0530
Message-ID: <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQJoSeMIlXjPMuci1lQDnd0IsY+e8wLu+qiYAUGsmF8ChgSNDQJyI1AuAi3VLdkCT/pK/wHswGQGpQM4GVA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89lO65Wpyns0SBzGaThpbI6gmhRHwYGRR/6YFkd86jD29jx
        khk0GsylWCZe2ipTs7QZJWqZ17xmYhbesLyVNclFhimINbq4HSW//Z7n//yfy8tL4bIW0o1S
        JSRxmgQ2TiGSEM86vLx81CrncP/BfJKxFeaRTG9OKcbcKtRhTPPoLsZYNC5impp7CGaw4baI
        uftgWsyUd//BmKG8UvygRFlT4a2sKbus/DE9Siiv1ZqR8nVxp1i5UL31uChMEhTJxalSOI1f
        8DlJjPnOJ5G6T36h5IMO0yKzcyZyooAOAGOWQZyJKEpGNyJ4GpWJJMs4j8BisOFCsIjgXadO
        tGowF2gJQWhGUFlajwnBFwQL462kvUpE74DJpWyHw4X2gb6SGWQvwulKDO7pbWK74LTcaibj
        qoOd6TOgnchxMLFsHihoczSS0oFQ8jZLJPBm6DFaCDvjtDvUzd7GhZW2QeN8Fynk5WDt6hQL
        gyPgysy0Y1WgM8RQMVaCCYYj0KR7IRbYGb52166wG1iv61eYh1/jXbhgNiAY0RoJQQiB/qbf
        mP3FcNoLnjT4CYM3QrbN4kgDLQWDXiZUe8Bk7jQpsBymbpatsBKmZmtQDvIwrTnNtOY005pz
        TP+HFSPCjFw5NR8fzfH71HsTuFRfno3nkxOifc8nxlcjx6/yDn2Oqt8cbUc0hRQbpFp3WbiM
        ZFP4tPh2BBSucJHeZ+lwmTSSTbvIaRLPapLjOL4dbaEIhVyaSw6fltHRbBIXy3FqTrOqYpST
        mxYV6B/ttIQW9dz4fCzvxES2u+7x+/1jU70/P7aNBUJoR4MVWvMtiVW2/nWewS5hWR1Rwy0P
        g/7GFnuvPxkygjqZucNWW1Gdv+LUWH1Ss2rPBBxwdUtdavKdl0ZlfRsOebU4N8Ee2u6evkQF
        eJkHWsszI6pmwzblfk/niJeXPEeHFAQfw+72xjU8+w/RrzTPUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvG5+pnCsQdMWDYvf06ewWpyesIjJ
        Yvb0ZiaLvbe0LWbOu8NmsWfvSRaLy7vmsFnMX/aU3WL58X9MFlemLGJ24PLYvELLY/OSeo+P
        T2+xePRtWcXocWbBEXaPz5vkAtiiuGxSUnMyy1KL9O0SuDJWzX3EVnBWvGLh/WamBsZVwl2M
        nBwSAiYSq6Y1sHQxcnEICexmlJjzsosRIiEu0XztBzuELSyx8t9zdoiip4wS1zq3MoEk2ARU
        Je796GUDsUUEdCXOLnzBCFLELLCZSWLLtrfMEB3tzBI/f64EG8UJtO9FeyeYLSwQI7F+8kKw
        bhagSZemHWQFsXkFLCUWnu9mg7AFJU7OfAJ0HwfQVD2Jto1g1zELyEtsfzuHGeI6BYndn46y
        QsTFJV4ePcIOcVCSRNOLpywTGIVnIZk0C2HSLCSTZiHpXsDIsopRMrWgODc9t9iwwCgvtVyv
        ODG3uDQvXS85P3cTIzjitLR2MJ44EX+IUYCDUYmHt0FeKFaINbGsuDL3EKMEB7OSCO/SRIFY
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYxqJnvkNHnU
        6yMWy7x+6RpmNdmudr3w6ZpbkQwrNB47fgo6/ltflJX/CdeqpRu+vI7+M2PRsv4ihm0NvwVn
        svE8Cepz7+xUyGmVWXl+3/ZpVxqn/PswLXtr2rJDV06azqjkmWHw18Y4NX3vm4SP0ftevX9y
        R+WF9XSlDmnX46eK5BzE1+4ufH9HiaU4I9FQi7moOBEAkovLmLQCAAA=
X-CMS-MailID: 20190626124743epcas5p105f8e82af483f0cd360b6c3d3944d545
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
        <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
        <20190510170249.GA26907@infradead.org>
        <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
        <20190520142719.GA15705@infradead.org>
        <20190521082528.GA17709@quack2.suse.cz>
        <20190521082846.GA11024@infradead.org>
        <20190522102530.GK17019@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph, 
May I know if you have thoughts about what Jan mentioned below? 

I reflected upon the whole series again, and here is my understanding of
your concern (I hope to address that, once I get it right).
Current patch-set targeted adding two things -
1. Extend write-hint infra for in-kernel callers 
2. Send write-hint for FS-journal

In the process of doing 1, write-hint gets more closely connected to stream
(as hint-to-stream conversion moves to block-layer). 
And perhaps this is something that you've objection on. 
Whether write-hint converts into flash-stream or into something-else is
deliberately left to device-driver and that's why block layer does not have
a hint-to-stream conversion in the first place.
Is this the correct understanding of why things are the way they are?

On 2, sending write-hint for FS journal is actually important, as there is
clear data on both performance and endurance benefits.
RWH_WRITE_LIFE_JOURNAL or REQ_JOURNAL (that Martin Petersen suggested) kind
of thing will help in identifying Journal I/O which can be useful for other
purposes (than streams) as well.
I saw this LSFMM coverage https://lwn.net/Articles/788721/ , and felt that
this could be useful for turbo-write in UFS.   

BR,
Kanchan

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Wednesday, May 22, 2019 3:56 PM
To: 'Christoph Hellwig' <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>; kanchan <joshi.k@samsung.com>;
linux-kernel@vger.kernel.org; linux-block@vger.kernel.org;
linux-nvme@lists.infradead.org; linux-fsdevel@vger.kernel.org;
linux-ext4@vger.kernel.org; prakash.v@samsung.com; anshul@samsung.com;
Martin K. Petersen <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
for Ext4 journal

On Tue 21-05-19 01:28:46, 'Christoph Hellwig' wrote:
> On Tue, May 21, 2019 at 10:25:28AM +0200, Jan Kara wrote:
> > performance benefits for some drives. After all you can just think 
> > about it like RWH_WRITE_LIFE_JOURNAL type of hint available for the
kernel...
> 
> Except that it actuallys adds a parallel insfrastructure.  A 
> RWH_WRITE_LIFE_JOURNAL would be much more palatable, but someone needs 
> to explain how that is:
> 
>  a) different from RWH_WRITE_LIFE_SHORT

The problem I have with this is: What does "short" mean? What if userspace's
notion of short differs from the kernel notion? Also the journal block
lifetime is somewhat hard to predict. It depends on the size of the journal
and metadata load on the filesystem so there's big variance.
So all we really know is that all journal blocks are the same.

>  b) would not apply to a log/journal maintained in userspace that works
>     exactly the same

Lifetime of userspace journal/log may be significantly different from the
lifetime of the filesystem journal. So using the same hint for them does not
look like a great idea?

								Honza
--
Jan Kara <jack@suse.com>
SUSE Labs, CR

