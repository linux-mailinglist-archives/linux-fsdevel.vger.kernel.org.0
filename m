Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74A37026F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjEOIQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 04:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjEOIQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 04:16:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F35E61
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 01:16:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515081619euoutp01b2b597cf05c645cc13af38d3156f7f4c~fQx2Buwu72003320033euoutp01L
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 08:16:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515081619euoutp01b2b597cf05c645cc13af38d3156f7f4c~fQx2Buwu72003320033euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684138579;
        bh=/5j9rq/N37cKF0DkziC8eF8iKHmBh5BwV0qhp6JBOao=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jIWYwu+1CXauq3XVQzPkCaNyvGyQta1SRiY9hPP0+sPA3RI58MWJQIaDHhViZTGm/
         qSmWY60CaK6ZsNMvA2PphEJBz0fKgIx97kTmRh27we6tEhgPpGXVZmsUDc/gN4Pd5p
         sgJXThBUog//R4Rzi5DHFMd81oRIfiHnWk2fTgcs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230515081619eucas1p2596b338afadde8999c8f634f81a8e949~fQx1qC_kj0922909229eucas1p2A;
        Mon, 15 May 2023 08:16:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.B5.37758.35AE1646; Mon, 15
        May 2023 09:16:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515081618eucas1p1c852fec3ba7a42ee7094248c30ff5978~fQx1NuoPR1647716477eucas1p1f;
        Mon, 15 May 2023 08:16:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515081618eusmtrp2139f18226d1f468bb71f453dbb3f3e4a~fQx1M8xLb3057130571eusmtrp2E;
        Mon, 15 May 2023 08:16:18 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-33-6461ea530568
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.C5.14344.25AE1646; Mon, 15
        May 2023 09:16:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515081618eusmtip1193d0eb0c92919f59d5d01fb5b6078f5~fQx1AIvlI1017710177eusmtip16;
        Mon, 15 May 2023 08:16:18 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 09:16:14 +0100
Date:   Mon, 15 May 2023 10:16:13 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>, <mcgrof@kernel.org>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <20230515081613.rlnehghsypix5ddm@localhost>
MIME-Version: 1.0
In-Reply-To: <86987466d8d7863bd0dca81e9d6c3eff7abd4964.1683485700.git.ritesh.list@gmail.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87rBrxJTDLoWc1l0vt/GbvHuc5XF
        lmP3GC1OLjrMaLFn70kWi11/drBb3JjwlNFi8cpQi4OnOtgtfv+Yw+bA5XFqkYTHzll32T3e
        nkvx2LxCy2PTqk42jwmLDjB6vN93lc3j8ya5AI4oLpuU1JzMstQifbsErowHezaxFDRwV3Qv
        7GRvYGzj7GLk5JAQMJFo6/3K1MXIxSEksIJR4vuF+4wQzhdGibW/D7NBOJ8ZJbovzWeBaVky
        dQ8LRGI5o8SWky9Z4KrurZ/JClIlJLCFUeLYUgcQm0VAVeLB+4PMXYwcHGwCWhKNnewgYREB
        I4kHvavA1jEL7GaSeP34BlhCWCBaovPZIzCbV8Bc4uSrPcwQtqDEyZlPwK7gFIiR+Dn/GCPE
        RUoSDZvPQF1XK3Fqyy2whyQE+jkl5t98CVXkItG67jwbhC0s8er4FnYIW0bi/875TBB2tcTT
        G7+ZIZpbGCX6d65nA7laQsBaou9MDkgNs0CmxJVFk6B6HSXami6xQ5TwSdx4KwhRwicxadt0
        Zogwr0RHmxBEtZrE6ntvWCDCMhLnPvFNYFSaheSxWUjmQ9g6Egt2f2KbBdTBLCAtsfwfB4Sp
        KbF+l/4CRtZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgans9L/jX3cwrnj1Ue8QIxMH
        4yFGCQ5mJRHe9pnxKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFk
        mTg4pRqY5Badm3Ll9Pn9cc9qeTk1Lk8w32vmoK7XXllyW0JdZLKhgmzonPt/LO+u+qxc8qc7
        rnmRmdIxlufu5986OHqIX1S3Wrxik68240umY+++uc1eHlq3dNvzL5ezo+u8Hp3n4PnOWvYk
        U/zKB92so48SxL8I2cg+XtJxjfFt/K3ut8vuTG7n5pi6+UYv/8taadFNj1gfC7/W//Ym4Arf
        syyl0kv78yxfnKrXXh70TKxK+uV2ASF/44Oy/t2Tnmpr/Z20rvnoAze2+5tmmjxP521cXcDm
        +Iu9TkRRqeZA8u9vhtr9PwT6Dr/f5CHCxW8mO3fj0wXmuyoWf5y7QSSp6MT3MM5fDZOP6DD/
        Y8m8epxTSYmlOCPRUIu5qDgRABDnr6DUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7pBrxJTDJY+07TofL+N3eLd5yqL
        LcfuMVqcXHSY0WLP3pMsFrv+7GC3uDHhKaPF4pWhFgdPdbBb/P4xh82By+PUIgmPnbPusnu8
        PZfisXmFlsemVZ1sHhMWHWD0eL/vKpvH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpG
        JpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkTVy5gLNjLUTF331WmBsY7bF2MnBwSAiYSS6bu
        Yeli5OIQEljKKHHg3ylmiISMxMYvV1khbGGJP9e62CCKPjJKfD//FapjC6PE3JPtLCBVLAKq
        Eg/eHwTq5uBgE9CSaOxkBwmLCBhJPOhdxQhSzyywm0liwYM3TCAJYYFoic7GY2BFvALmEidf
        7WGGGNrFKNG2ZjEzREJQ4uTMJ2ALmAV0JBbs/sQGsoBZQFpi+T8OkDCnQIzEz/nHGCEuVZJo
        2HyGBcKulfj89xnjBEbhWUgmzUIyaRbCpAWMzKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        43TbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd72mfEpQrwpiZVVqUX58UWlOanFhxhNgUExkVlK
        NDkfmCjySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYZC66Xz7L
        +ojp2/bDlsW5BnIO9gtWlWxifnqbdy6ve+byOZnfHSXv/vs7592cI40nZ9/S07DlYPcWSKnm
        iqvz0b5Wr9ddkGr3MqStIuxzzNKsl08iJX6ZZ5688uX3Ok7FE5fMRWcdtpjX8yEoTvE143HZ
        L0rXrLp191j08VqrOWmqPeZeu/ZO5m4lPT9Pj9orq94Ye+0y5NP/9vpBjmD2nOWhnXpharen
        vzDfciiwzX/6/n1lfY8kj1736qgJz9no+CAmyU12n5tGzxTj8rYu3c2PGhnez9npdEThxFv3
        YM4fvWeddU1ev2eY26Zxik3NING3b+r3HLfjs9Zt/nd98znfEvN11meinsrYPfFWYinOSDTU
        Yi4qTgQAZ87OjFwDAAA=
X-CMS-MailID: 20230515081618eucas1p1c852fec3ba7a42ee7094248c30ff5978
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_19d366_"
X-RootMTR: 20230515081618eucas1p1c852fec3ba7a42ee7094248c30ff5978
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515081618eucas1p1c852fec3ba7a42ee7094248c30ff5978
References: <cover.1683485700.git.ritesh.list@gmail.com>
        <86987466d8d7863bd0dca81e9d6c3eff7abd4964.1683485700.git.ritesh.list@gmail.com>
        <CGME20230515081618eucas1p1c852fec3ba7a42ee7094248c30ff5978@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_19d366_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> @@ -1666,7 +1766,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_page *iop = iop_alloc(inode, folio, 0);
> +	struct iomap_page *iop = iop_alloc(inode, folio, 0, true);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1682,7 +1782,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !iop_test_block_uptodate(folio, i))
> +		if (iop && !iop_test_block_dirty(folio, i))

Shouldn't this be if(iop && iop_test_block_dirty(folio, i))? 

Before we were skipping if the blocks were not uptodate but now we are
skipping if the blocks are not dirty (which means they are uptodate)?

I am new to iomap but let me know if I am missing something here.

>  			continue;
> 
>  		error = wpc->ops->map_blocks(wpc, inode, pos);

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_19d366_
Content-Type: text/plain; charset="utf-8"


------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_19d366_--
