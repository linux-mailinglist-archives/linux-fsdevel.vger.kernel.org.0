Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3D72C6B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFLN7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjFLN67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:58:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A181FCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:58:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230612135700euoutp02428e95b9597f19a81683c2f168ba9757~n7fS6Wb_o0368603686euoutp02M
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 13:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230612135700euoutp02428e95b9597f19a81683c2f168ba9757~n7fS6Wb_o0368603686euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686578220;
        bh=3CCDOjcDLGMvxvfhrYdgwRDPhA1VByL794FBwAcU15I=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=T0TDpav+zTxNZC3+tSzaYiCWbRVeHPnYEWH00roVmAnSpsRU9PueLpQud5natEx1Q
         TRBXGdGK3H4tdf71j4xekfbuXUWGOCUcvKRONuLmyAii1z5hoxsmqMa4UbrGLL++Qz
         VtoiKdKL5hZsijm54pJHtcg5y31JJCg6RRqGnw7w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230612135700eucas1p2d44936c9197431d76cfd9d6be677019f~n7fSotgYn0288002880eucas1p2z;
        Mon, 12 Jun 2023 13:57:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.26.11320.C2427846; Mon, 12
        Jun 2023 14:57:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230612135700eucas1p2269a4e8cc8f5f47186ea3e7e575430df~n7fSPaN9W0287602876eucas1p2u;
        Mon, 12 Jun 2023 13:57:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230612135700eusmtrp1d7f865a6b7843d999b5e499c320877bd~n7fSOqjM01345513455eusmtrp1R;
        Mon, 12 Jun 2023 13:57:00 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-e7-6487242c0829
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.2D.10549.B2427846; Mon, 12
        Jun 2023 14:57:00 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230612135659eusmtip2989eb786958aab1ff9d76aaf61476a2b~n7fSFNjYE0718807188eusmtip2C;
        Mon, 12 Jun 2023 13:56:59 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 12 Jun 2023 14:56:59 +0100
Date:   Mon, 12 Jun 2023 15:56:58 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch()
 function out
Message-ID: <20230612135658.gvukpx7567avszph@localhost>
MIME-Version: 1.0
In-Reply-To: <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87o6Ku0pBg+/iFtsW7eb3eLd5yqL
        LcfuMVqcXHSY0eLyEz6L0xMWMVns2XuSxWLXnx3sFotXhlocPNXBbvH7xxw2B26PU4skPHbO
        usvusXmFlsemVZ1sHhMWHWD0eL/vKpvH501yAexRXDYpqTmZZalF+nYJXBkfzt5nL/jMWTFv
        +Qz2BsZv7F2MnBwSAiYSew/MZe5i5OIQEljBKLH7RS9YQkjgC6PE629WEInPjBJXj85mhelY
        8nITI0RiOaNE7+TNrHBVd258YYFwtjBK7L1wC2wWi4CqxNQ/74BsDg42AS2Jxk6wsIiAkcSD
        3lVgk5gFfjJJNDy6wAKSEBYIkzh+vpkNxOYVMJfY8e8rE4QtKHFy5hOwGk6BGIn2DwfZIE5S
        kmjYfIYFwq6VOLXlFhPIUAmByZwSd9vWM0IkXCRebn8M9bWwxKvjW6BsGYnTk3ugmqslnt74
        zQzR3MIo0b9zPRvI1RIC1hJ9Z3JATGaBDInte2Igyh0lpuz5xAhRwSdx460gSJgZyJy0bToz
        RJhXoqNNCKJaTWL1vTcsEGEZiXOf+CYwKs1C8tcshPGzwOboSCzY/YkNIiwtsfwfB4SpKbF+
        l/4CRtZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgWns9L/jX3YwLn/1Ue8QIxMH4yFG
        CQ5mJRFebZPmFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTByc
        Ug1MjDXpehxfs08I2X+X9Ihfqtqbs6C3KtpbguvVt/VyE60ir2e0LxG6c39TW/3hhNP+iYXJ
        Nw8zqE/ISzzRsVQ/sDV7d/yjs6uKfqsWlSl6yJ7La2fedao74EDv6+hm6yvnN8TIFW56XfYx
        NefhMefSaX9WZNTJKt2d8YZnR8wVaSGeM4Uuzuf944/XFR2yf3FxalHXmbObhTsXnHVOmZEt
        uONs+prJJw+/XiJ8bvX2XyuNsk3qAu/a5Hnwb3k+ST+k/28Zo+GrQ8vflAtp+Vkk3mKYq7lU
        +TWLY6+bixRbF3/i2tNvBe6Wpa5sjPrA4Ln8Q8eaVT80mV/Im1bNMhH4c3xZg1BIqgVPxPEZ
        rZOVWIozEg21mIuKEwEF0G1+0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7o6Ku0pBn9vM1lsW7eb3eLd5yqL
        LcfuMVqcXHSY0eLyEz6L0xMWMVns2XuSxWLXnx3sFotXhlocPNXBbvH7xxw2B26PU4skPHbO
        usvusXmFlsemVZ1sHhMWHWD0eL/vKpvH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpG
        JpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehl7Ny5gLdjMXrHy/ibWBsbzrF2MnBwSAiYSS15u
        Yuxi5OIQEljKKLGl/QATREJGYuOXq1BFwhJ/rnWxQRR9ZJToPHecBcLZwijRvuEMC0gVi4Cq
        xNQ/79i7GDk42AS0JBo72UHCIgJGEg96V4FtYBb4ySQxf/l2sA3CAmESx883s4HYvALmEjv+
        fWWCGNrFKHHyzyJ2iISgxMmZT8AWMAvoSCzY/YkNZAGzgLTE8n8cIGFOgRiJ9g8H2SAuVZJo
        2Axxj4RArcTnv88YJzAKz0IyaRaSSbMQJi1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GKfbjv3cvINx3quPeocYmTgYDzFKcDArifBqmzSnCPGmJFZWpRblxxeV5qQWH2I0BQbFRGYp
        0eR8YKLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgmua0Ynbd
        gmnmLdt2Llzwf7v7lvrGrXl7Hs0+ttYopepn2NnF/zl/d8myy8qmz1gdxm4S+//fxXfmd/6l
        z/r5/fm1U3Omf/+7WvyU9LKuvdFngx074hLuR6svzO9be8k1aO7KeZ15Ey4sVZq8efcHztAm
        dc9Hp7UjDl4/aJ3dtbP46Z9PSr/e7BMNbvAsP7Z1UZO10+oDHxa2ujJ/OK01rUNjy3vOj4W9
        hcekgy9uDo9zbz8bOuuCyltJEfGN6Qkb3yVnbc0/0v6kwvzLaraI5r7uZw2rFK0nRRru2cyT
        HzD7ZreoZ8AUtyNHmuo05kUqbXmU4bmRJ7i4eFcGK8vLTy6TQ1kFNzofmmZt7Gh+foYSS3FG
        oqEWc1FxIgBC0U0dXAMAAA==
X-CMS-MailID: 20230612135700eucas1p2269a4e8cc8f5f47186ea3e7e575430df
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----i63qqdr0js3PYYVF7qu0iAMt2eW_b44vb7XDklFFPIsMDmoM=_ddd08_"
X-RootMTR: 20230612135700eucas1p2269a4e8cc8f5f47186ea3e7e575430df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230612135700eucas1p2269a4e8cc8f5f47186ea3e7e575430df
References: <cover.1686395560.git.ritesh.list@gmail.com>
        <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
        <CGME20230612135700eucas1p2269a4e8cc8f5f47186ea3e7e575430df@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------i63qqdr0js3PYYVF7qu0iAMt2eW_b44vb7XDklFFPIsMDmoM=_ddd08_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Minor nit:

> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	int ret = 0;
> +
> +	if (!folio_test_dirty(folio))
> +		return ret;
Either this could be changed to `goto out`

OR

> +
> +	/* if dirty, punch up to offset */
> +	if (start_byte > *punch_start_byte) {
> +		ret = punch(inode, *punch_start_byte,
> +				start_byte - *punch_start_byte);
> +		if (ret)
> +			goto out;

This could be changed to `return ret` and we could get rid of the `out`
label.
> +	}
> +	/*
> +	 * Make sure the next punch start is correctly bound to
> +	 * the end of this data range, not the end of the folio.
> +	 */
> +	*punch_start_byte = min_t(loff_t, end_byte,
> +				  folio_next_index(folio) << PAGE_SHIFT);
> +
> +out:
> +	return ret;
> +}
> +

------i63qqdr0js3PYYVF7qu0iAMt2eW_b44vb7XDklFFPIsMDmoM=_ddd08_
Content-Type: text/plain; charset="utf-8"


------i63qqdr0js3PYYVF7qu0iAMt2eW_b44vb7XDklFFPIsMDmoM=_ddd08_--
