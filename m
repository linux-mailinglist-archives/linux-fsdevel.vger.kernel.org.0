Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2F6BEDCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQQOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQQOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:14:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA2E31BDC
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 09:14:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230317161431euoutp01c8d675697a8e60a8204da03e9731c512~NQPhnvg-90881908819euoutp01E
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 16:14:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230317161431euoutp01c8d675697a8e60a8204da03e9731c512~NQPhnvg-90881908819euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679069671;
        bh=YrbXOp1kaF/fSjcqSlUL3mIFVZ7FXQpuL51vCvFRlxg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=WIufnSCR8ZPgvaP9gXBFgOqtbF5VgzywEHVoe7BTFTCPL/nPpKDrXMUnOcM631fGD
         y0dFmcXNbdkEotu5tJDMHV1HoHq9Nh3pdkhaQif60eGeiwErAHSLtsXNHvY3iGXJHc
         zx7rYFnJoGhmTsSyGgSpQjxnmkBAm/IEcpM1nB3M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230317161431eucas1p28a0ceeafee3b29e9afe4718e7e25183a~NQPhJuVHC1500115001eucas1p2N;
        Fri, 17 Mar 2023 16:14:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C7.DD.09503.7E194146; Fri, 17
        Mar 2023 16:14:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230317161430eucas1p1028206eaa12f7a07ea86e2b456cd4ab9~NQPgjV8z41239112391eucas1p1I;
        Fri, 17 Mar 2023 16:14:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230317161430eusmtrp15435566687c094b2f9d990300fbc8f8c~NQPgiX-eE0931209312eusmtrp1c;
        Fri, 17 Mar 2023 16:14:30 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-34-641491e7b81f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.07.09583.6E194146; Fri, 17
        Mar 2023 16:14:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230317161430eusmtip1e7fceaffc2054fa52094127c3343de70~NQPgW_j1O1750317503eusmtip1P;
        Fri, 17 Mar 2023 16:14:30 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.172) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 17 Mar 2023 16:14:28 +0000
Message-ID: <04047489-e528-4451-4af2-c19bd3635e7e@samsung.com>
Date:   Fri, 17 Mar 2023 17:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>, <hubcap@omnibond.com>,
        <senozhatsky@chromium.org>, <martin@omnibond.com>,
        <minchan@kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <gost.dev@samsung.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZBSH6Uq6IIXON/rh@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7rPJ4qkGBw7wGoxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaL0xMWMVm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovdGxexWZz/e5zV4vePOWwOAh6zGy6yeGxeoeVx+Wypx6ZVnWwemz5NYvc4MeM3i0fD
        1FtsHr9u32H1+LxJzmPTk7dMAVxRXDYpqTmZZalF+nYJXBkf/15iKjjEU9HcVtrA+Jyji5GT
        Q0LARGLxr4mMXYxcHEICKxglLrZ0QDlfGCX2H5nHBuF8ZpTo7dvPAtNy7s5kdojEckaJbdN2
        s8NV/dixB6p/N6PEut457CAtvAJ2Eit7PrOB2CwCqhJrZs2DigtKnJz5BGgsB4eoQJTEi9dl
        IKawgLvEx115IBXMAuISt57MZwIJiwhoSLzZYgQynVlgK7PEkY5XjCBxNgEticZOsIGcQLf9
        3vOaDaJVU6J1+292CFteYvvbOcwQ9ytLzHm9A8qulTi15RYTyEwJgUecEnu/9TNCJFwk9u+6
        AWULS7w6voUdwpaROD25BxoQ1RJPb/xmhmhuYZTo37meDeQgCQFrib4zORCmo8TR2RoQJp/E
        jbeCEOfwSUzaNp15AqPqLKRgmIXk4VlIPpiF5IMFjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS
        9ZLzczcxAtPg6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8vD+FU4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwhYvtWyS/cLZBX/T77B0ddV4HGd9duHZ0
        z3J75utnPvg8Ozhns7Ko6Op+zl/bnR9yXnF4EZ6z0+nPLbGbV/zdc25q6K1wT/BY+zAnfXOi
        YSXXF/cyYfPKnfvuzlQ74Pv12JVremJHklfVTdcXXLq6LrJqwv/k0sg6rosi0zQZ3h7Z23lI
        svBJ99XHdcIPIkL2CgUe61ZRa+6OnPzYRfDVBK+MDS5OyjqZXRF2ud/85lYGFGueZl9bvM1k
        x+s1Jp1hJUG1opbypjtcrdgfnVk1KVRq3ZdlvoeWmTgq3Jrbv4wn6V5d7lL7ohX8elc4s6/2
        VF1ztnVgz/e+fevkec5ljAcvWOVG5t4TlGxffyJeiaU4I9FQi7moOBEAD4+/EPIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xu7rPJoqkGLRck7GYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPF6QmLmCza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XujYvYLM7/Pc5q8fvHHDYHAY/ZDRdZPDav0PK4fLbUY9OqTjaPTZ8msXucmPGbxaNh
        6i02j1+377B6fN4k57HpyVumAK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsj
        UyV9O5uU1JzMstQifbsEvYyPfy8xFRziqWhuK21gfM7RxcjJISFgInHuzmT2LkYuDiGBpYwS
        vyY2s0AkZCQ+XfnIDmELS/y51sUGUfSRUeLO60lQHbsZJVbsnsoGUsUrYCexsuczmM0ioCqx
        ZtY8doi4oMTJmU/ApooKREk8vXOIuYuRg0NYwF3i4648kDCzgLjErSfzmUDCIgIaEm+2GIGM
        ZxbYyixxpOMVI8Sug0wS009uBetlE9CSaOwEG88J9MHvPa/ZIOZoSrRu/80OYctLbH87hxni
        AWWJOa93QNm1Ep//PmOcwCg6C8l1s5CcMQvJqFlIRi1gZFnFKJJaWpybnltspFecmFtcmpeu
        l5yfu4kRmEC2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuHl/SmcIsSbklhZlVqUH19UmpNafIjR
        FBhEE5mlRJPzgSksryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
        ie3TZf0D+68cE5onee395Y/KAjwuxUvVRa01z6rUL12t53ju0/603+Xtb20i5htaNO849zyJ
        p3vrPt2Nq0Kkr+87vUEqrEe2ZqpSIlueoOuWhldm/qfPVsd8TJ947uKUubO5PLIuJP36UBAn
        8mx1E8PdRhvFjjVMdnemLTsov3J7A5uN5oaCzH/TZxnerW4Ue3nkMhNjl/iOs5oLnlln2WWE
        nCm/XSDR1Ti5smZ3z57+oFmrjyv/ujE1L9TM+aaMFX+ivuUFtoeqH3ZeORtQ9uB2bh3bEeaz
        s+8YrD5uGd71W/7EbrYlnnuqp+kaceRLaF/+sKRAl+9C6uVpB3wb7WSWGIb/37WPNTXC9a3E
        WSWW4oxEQy3mouJEAH1FW52pAwAA
X-CMS-MailID: 20230317161430eucas1p1028206eaa12f7a07ea86e2b456cd4ab9
X-Msg-Generator: CA
X-RootMTR: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
        <20230315123233.121593-2-p.raghav@samsung.com>
        <ZBHcl8Pz2ULb4RGD@infradead.org>
        <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
        <ZBSH6Uq6IIXON/rh@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-17 16:31, Matthew Wilcox wrote:
>> +
>> +       while ((folio = readahead_folio(rac))) {
>> +               folio_mark_uptodate(folio);
>> +               folio_unlock(folio);
>>         }
> 
> readahead_folio() is a bit too heavy-weight for that, IMO.  I'd do this
> as;
> 
> 	while ((folio = readahead_folio(rac))) {
> 		if (!ret)
> 			folio_mark_uptodate(folio);
> 		folio_unlock(folio);
> 	}
> 

This looks good.

> (there's no need to call folio_set_error(), nor folio_clear_uptodate())

I am trying to understand why these calls are not needed for the error case.
I see similar pattern, for e.g. in iomap_finish_folio_read() where we call these
functions for the error case.

If we don't need to call these anymore, can the mpage code also be shortened like this:

-static void mpage_end_io(struct bio *bio)
+static void mpage_read_end_io(struct bio *bio)
 {
-       struct bio_vec *bv;
-       struct bvec_iter_all iter_all;
+       struct folio_iter fi;
+       int err = blk_status_to_errno(bio->bi_status);

-       bio_for_each_segment_all(bv, bio, iter_all) {
-               struct page *page = bv->bv_page;
-               page_endio(page, bio_op(bio),
-                          blk_status_to_errno(bio->bi_status));
+       bio_for_each_folio_all(fi, bio) {
+               struct folio *folio = fi.folio;
+
+               if (!err)
+                       folio_mark_uptodate(folio);
+               folio_unlock(folio);
+       }
+
+       bio_put(bio);
+}
+
+static void mpage_write_end_io(struct bio *bio)
+{
....
+
