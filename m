Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5488738103
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFUKpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjFUKo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC10199C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 03:42:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621104248euoutp0138a34cd76f746a846392c718139d4c19~qppTTv1Fh1810318103euoutp01o
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 10:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621104248euoutp0138a34cd76f746a846392c718139d4c19~qppTTv1Fh1810318103euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687344168;
        bh=l1C4lvIt3QKQmaC9+QjfjU/cqjeq5T+23Tlro/biFn0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=EjXl3a6ae7hTq+stLNivKpQOU64pssSpvJgD7ORWYuEKDACjvJW7Qd+01e3X8Rc+j
         aUSpZXilw1s4jF7I9dlI62JvKsHHQ6ytKn+u/siyxjyPTBadJNo9pRN3sRfdh7/6SR
         5kWTOL+2INP/pfBSpE8u1lO5A3W5OViJDmnPevHs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621104248eucas1p27a4a8a897900d5e64e2493f4cb5ad695~qppTCqiIK3009130091eucas1p2N;
        Wed, 21 Jun 2023 10:42:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.18.37758.824D2946; Wed, 21
        Jun 2023 11:42:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621104247eucas1p1008c472be110abce7d38366964c9eb4e~qppSoA0zh3236032360eucas1p17;
        Wed, 21 Jun 2023 10:42:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621104247eusmtrp1e4451c41261eee14caa8481d053a482d~qppSne4T21503715037eusmtrp1f;
        Wed, 21 Jun 2023 10:42:47 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-d2-6492d4281bc9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.91.14344.724D2946; Wed, 21
        Jun 2023 11:42:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621104247eusmtip1fce9a88bea1d162fbc5cc50b80394027~qppSZeRXa1760517605eusmtip1o;
        Wed, 21 Jun 2023 10:42:47 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 11:42:45 +0100
Message-ID: <d275b49a-b6be-a08f-cfd8-d213eb452dd1@samsung.com>
Date:   Wed, 21 Jun 2023 12:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [RFC 3/4] block: set mapping order for the block cache in
 set_init_blocksize
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, <willy@infradead.org>,
        <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <a25eb5ce-b71c-2a38-d8eb-f8de8b8b449e@suse.de>
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87oaVyalGLw/xG6x5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtigum5TUnMyy1CJ9uwSujMNvPzEWzOer2L2ppoHxOncXIyeHhICJxLGlm9m7
        GLk4hARWMEr82NHBDOF8YZRYfaqdFcL5zCjRNWMxK0zL9Psv2SASyxklWs5uZIKrurR6KyOE
        s5NR4vaFD2AtvAJ2Ehd/bmQBsVkEVCWW3JjJDBEXlDg58wlYXFQgWqJ12X02EFsYyN71pxms
        l1lAXOLWk/lMILaIQJDE0c5TYNcyC0xjlFh+8QrQNg4ONgEticZOdpAaTgFriZdvHkP1yks0
        b53NDHG2osSkm++hXqiVOLXlFhOE3c4psW1FEoTtItH6agU7hC0s8er4FihbRuL05B4WCLta
        4umN3+BAkhBoYZTo37meDeQGCaDFfWdyQExmAU2J9bv0IcodJSYvPMYCUcEnceOtIMRlfBKT
        tk1nnsCoOgspIGYheXgWkgdmIQxdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzAh
        nf53/OsOxhWvPuodYmTiYDzEKMHBrCTCK7tpUooQb0piZVVqUX58UWlOavEhRmkOFiVxXm3b
        k8lCAumJJanZqakFqUUwWSYOTqkGpvCYKat71CvSk7e/8qpKFWAv41yxTt58yf3QRMft76RL
        1X7Hh+berz3xfF9odLBEmrXUhm81eex3PgXELjo30YMp7mXS4+J3K3fsk7hhKq9//4HHr+c6
        ch/0PveK5z/d9DR6tenj5lcnXonzJYjs9fi779I/Xbn9rPUHrq+4eZJxv/DXrc7id8wtpomz
        PjrxOq62cO/ujVP0WZ9+/KEhyJd7IuODSW5wbdKzRQq8HQn3Ngso7HzA/lK6NSj7VfwTA4mW
        uZf17fYwHP7xK86Q5/tXle+rHe0vTT0wYXnfBPmNtR5nHt1fm/muu+j7u3M2pzJOzDE0Ouzn
        k2C4JrFwt7+xp/HNrz5/FiawBYn41SuxFGckGmoxFxUnAgCRBmr4twMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7rqVyalGPzs0LTYcuweo8WeRZOY
        LFauPspkce1MD5PFnr0nWSwu75rDZnFjwlNGi98/5rA5cHicWiThsXmFlsemVZ1sHrtvNrB5
        bD5d7fF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexuG3nxgL5vNV7N5U08B4nbuLkZNDQsBEYvr9l2wgtpDAUkaJyYusIOIyEhu/XGWF
        sIUl/lzrAqrhAqr5yCixd8p0RghnJ6PEpPU32UGqeAXsJC7+3MgCYrMIqEosuTGTGSIuKHFy
        5hOwuKhAtMTqzxfApgoD2bv+NIPZzALiEreezGcCsUUEgiSOdp5iB1nALDCNUWL5xStQ2z4x
        Sjx8eQeoioODTUBLorETbDGngLXEyzePoQZpSrRu/80OYctLNG+dzQzxgqLEpJvvod6plfj8
        9xnjBEbRWUjum4XkjllIRs1CMmoBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwFjeduzn
        lh2MK1991DvEyMTBeIhRgoNZSYRXdtOkFCHelMTKqtSi/Pii0pzU4kOMpsBAmsgsJZqcD0wm
        eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTFa1F/rPrxP8p7Iv
        oIo/4fLiKyWc2/anRVb2Wh978PpthvybMuFf5dbTDi193r/pdp9axDWRKVydiXl3bZY66cVP
        VnbdWt7tYuH/Vb5ubeaRfubSyNNbtYJmhB80yTsgriFwgy96Z1+JsmLukVfvqjUtw66XnkzW
        bTBbYXr99KomS72ucLuu29ynHrbt+aj6YpLVwpnrQq6KZJ3cmv7xWAdD+LpX3CEu4t8SF+mX
        tVs1/hWP5+HxfSS83sAyROj/KsvoLPvJeoqse+072Q/Nv1x/Vrk3ymK9oNX5TaazuQ0zDt+J
        X8RQ9PRBfNmUE1ft8o65fDFps5OcsbrZ1yr4Yry1bpCXWv3RWl+NGcJKLMUZiYZazEXFiQBT
        sdKrbgMAAA==
X-CMS-MailID: 20230621104247eucas1p1008c472be110abce7d38366964c9eb4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083828eucas1p23222cae535297f9536f12dddd485f97b@eucas1p2.samsung.com>
        <20230621083823.1724337-4-p.raghav@samsung.com>
        <a25eb5ce-b71c-2a38-d8eb-f8de8b8b449e@suse.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>       bdev->bd_inode->i_blkbits = blksize_bits(bsize);
>> +    order = bdev->bd_inode->i_blkbits - PAGE_SHIFT;
>> +    folio_order = mapping_min_folio_order(bdev->bd_inode->i_mapping);
>> +
>> +    if (!IS_ENABLED(CONFIG_BUFFER_HEAD)) {
>> +        /* Do not allow changing the folio order after it is set */
>> +        WARN_ON_ONCE(folio_order && (folio_order != order));
>> +        mapping_set_folio_orders(bdev->bd_inode->i_mapping, order, 31);
>> +    }
>>   }
>>     int set_blocksize(struct block_device *bdev, int size)
> This really has nothing to do with buffer heads.
> 
> In fact, I've got a patchset to make it work _with_ buffer heads.
> 
> So please, don't make it conditional on CONFIG_BUFFER_HEAD.
> 
> And we should be calling into 'mapping_set_folio_order()' only if the 'order' argument is larger
> than PAGE_ORDER, otherwise we end up enabling
> large folio support for _every_ block device.
> Which I doubt we want.
> 

Hmm, which aops are you using for the block device? If you are using the old aops, then we will be
using helpers from buffer.c and mpage.c which do not support large folios. I am getting a BUG_ON
when I don't use iomap based aops for the block device:

[   11.596239] kernel BUG at fs/buffer.c:2384!


[   11.596609] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[   11.597064] CPU: 3 PID: 10 Comm: kworker/u8:0 Not tainted
6.4.0-rc7-next-20230621-00010-g87171074c649-dirty #183
[   11.597934] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014


[   11.598882] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[   11.599370] RIP: 0010:block_read_full_folio+0x70d/0x8f0

Let me know what you think!

> Cheers,
> 
> Hannes
> 
> 
