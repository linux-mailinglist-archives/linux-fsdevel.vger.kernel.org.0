Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B7716921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjE3QXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjE3QWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 12:22:54 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711DE8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 09:22:50 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230530162247epoutp0228c7515e5f844f73c0f1402e2148fa01~j_F3VFQEV2697426974epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 16:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230530162247epoutp0228c7515e5f844f73c0f1402e2148fa01~j_F3VFQEV2697426974epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685463767;
        bh=iQHQHNsByexlloqhkgYnt5iCj3YMH2bRf9GJ2+IFCqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mj9Kp246tFJsvk49BzWLL8WrQrzlQlRGeWp84cPM2FN+4hmYdEjPTDdftj1sdpK4N
         kPbt3ynZUNGge8cf2RttYaaqgWdPbnyjQH9nFQOfCYHSzbBqhJoKc+SrE6EWA5YFeP
         9dsjRqvLAPoEyOfoEZY4Ouo2kinX1FtgaUMIzXe4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230530162245epcas5p13dd525f833dbe394e5e0edaa652cdb0c~j_F1911Nb0345803458epcas5p1-;
        Tue, 30 May 2023 16:22:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QVyNh1y9wz4x9Pp; Tue, 30 May
        2023 16:22:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.3F.04567.4D226746; Wed, 31 May 2023 01:22:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230530121351epcas5p2b18d46d6be650a7b830690b845ec22c8~j6sgq_Mda2862728627epcas5p2h;
        Tue, 30 May 2023 12:13:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230530121350epsmtrp2a219b3672da915ce319a0c25d4204123~j6sgpTLJG0347103471epsmtrp2-;
        Tue, 30 May 2023 12:13:50 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-4a-647622d46e21
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.D5.28392.E78E5746; Tue, 30 May 2023 21:13:50 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230530121346epsmtip2a090cc3928ef845f7729023ca25e9244~j6sc4LK2o1829318293epsmtip2a;
        Tue, 30 May 2023 12:13:46 +0000 (GMT)
Date:   Tue, 30 May 2023 17:40:43 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
Message-ID: <20230530121043.psdxyk7z3rk7sjtm@green245>
MIME-Version: 1.0
In-Reply-To: <CAFL455nMtKbDt1HeN6D2WPB2JjOYq2z1=RagmmuhmQ33eL2Bfw@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTHc+9tby+QYsdj/oBNoLoQmDy6lfpjAbfoipfgA0I0c8qwg2sh
        lLbpg83FOFYYOibykCErhIGylZc8t/EoMMJDXjIkPIfCGCmYQGQ8s2mF2nKL+t/nfM85v3N+
        5+QQmMMgy5VIkKoohVQk4eK2jPvd3l6+49zkuIC0vwlYO/gTBotqq3Goyd7BYNVsFg5XujcQ
        mL/2JwbnH5yE7auFTPioswWFbd/norCiqheF9VkE1Jeuo7DX9AcOc7smEbg4oUVh+8xR2NY+
        wIBjrUU4nKs2MeGtO4sseH2qGYe6vl0Udn2bisKh/EYMNhuuILBm5SkD9s+4wZGdPiY0Pi/C
        T71Ejo2Hk9rHwzjZop1lkSNz9QwyP3cQJxvLfcixYTXZUHkNJxs2cllkf4GRQTaWXSb1j1Jw
        MjN1FSfXF2cY5NOOCZz85m4lEuF4NjE4nhLFUQoPShori0uQikO44VExb8YECgJ4vrwg+BrX
        QypKokK4p9+O8A1NkJgnxfVIFknUZilCpFRy/V8PVsjUKsojXqZUhXApeZxEzpf7KUVJSrVU
        7CelVCd4AQHHAs2BnyTG/1A/i8oNDhcXbg6jKcg0OwOxIQCHD7Y1W0gGYks4cPQIuFo0YTU2
        EDD1y3cM2thEwEhBJ3M/ZTFn2OpoRUDHzxtM2lhCQF1NNWaJYnCOgL6tNfNbBIFzjoIhE2GR
        ncy4nlbGsDDGSWOBjQx7CztywoHhYR1qYTZHAMaH5q18AAzcNOzF23AiQX1T2Z7uzDkECm5v
        Y5a6gKOxBabSTYzu7jTQ/XoDp9kRLPfdZdHsCjZX2636BVCRV47TyWkI0E5pEdpxElwdzMIs
        TWOceFDVq6blw+DGYA1KN20PMo0GlNbZoLl4n18G1bUl1vddwOSzK1YmwVZ6G4seUBoKlgzr
        eDbirv3f57T/ldPulTgBrq1pmDS7g9R7hRgd4gZ0uwSN3qC21b8EwSsRF0quTBJTykA5T0pd
        +Hf5sbKkBmTvqHzCmpHZ+TW/LgQlkC4EEBjXiR0iUsY5sONEn12iFLIYhVpCKbuQQPPacjBX
        51iZ+SqlqhgePyiALxAI+EHHBTzui2yvkIFYB45YpKISKUpOKfbzUMLGNQXN9HkyJn7f7uF5
        k4tAevYDmHf/UiTOsMtV5f2O8/Idfc586fup5qMt/U66hrwcZWg6/mGXp8dbXxxiSZK1hg79
        6jusNx7f8fxK1iocp1ZqqstSEyblbZ/XhW8/UBl54gNzoV6FMcLxsKgefc+p4sbF5KFg/XtL
        57AfvXZ3FuQfCycSBzwuionb765HZ77yF+a1YM+OzM7v5mY3j/LugfqFEP/D10uHmMrypuU5
        d/clItlOfMzpt2jhmeet3s78Ql1SQYmb0HnxySgalnPwhVFdusvwrazpmSFjTyqrk1iaNp0L
        ZIUe+TrofOZytL9DcX+MseVV1x7dQf4zz3Gn0xVyIZehjBfxfDCFUvQPC7mUe90EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCSvG7di9IUgzm7jC3WnzrGbDFn/Ro2
        i6YJf5ktVt/tZ7N4ffgTo8W0Dz+ZLR7st7fY+242q8XNAzuZLPYsmsRksXL1USaLjf0cFrsX
        fmSyOPr/LZvFpEPXGC2eXp3FZLH3lrbFnr0nWSwu75rDZnFvzX9Wi/nLnrJbdF/fwWax/Pg/
        JotDk5uZLE5P28xsseNJI6PFutfvWSxO3JK2OP/3OKvF7x9z2BzkPC5f8faYdf8sm8fOWXfZ
        Pc7f28jiMW3SKTaPzSu0PC6fLfXYtKqTzWPTp0nsHidm/Gbx2Lyk3mP3zQY2j97md2weH5/e
        YvF4v+8qm0ffllWMAcJRXDYpqTmZZalF+nYJXBkHXvawF3zlr+g7v5i1gbGNu4uRk0NCwETi
        6cSzLCC2kMAORokF11Ug4pISy/4eYYawhSVW/nvO3sXIBVTzhFHi1bJl7CAJFgFVieNfPjB2
        MXJwsAloS5z+zwESFgEyP7YsYQGpZxboYpeY9X4hG0hCWMBb4sm5DUwgNq+AmcSV0w+YIIa2
        MElMmPOEFSIhKHFy5hOwi5iBiuZtfsgMsoBZQFpi+T8OiLC8RPPW2WDHcQoESmzcvgRspqiA
        jMSMpV+ZJzAKzUIyaRaSSbMQJs1CMmkBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
        TYzgxKOltYNxz6oPeocYmTgYDzFKcDArifDaJhanCPGmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cB00eRwQ+60icv0dNaHB2b/mqtT6ZofcXTB86ivtc0q
        +33nB/beCQ0xWOpTrB6oFy3xmXu2832rDfHXyj5fuTzRU45nYtyTAw2G++VOBbBN5vLcNGvp
        366/JX63a9pD3ybwZgh/V3m+uezBn3il+L/b+C7f81JVEtxyU6yWbeeiyISD72cna1R9TZE0
        nbvGXP7m3+T9hoqRBhyzZpQvUpmy3G6Wx5/FP/YcNPUqdfseq3Bp27TYMJnU3361dSkvNNdI
        sR++UqG782aTeLrWxEP57jvmnJ4oHJZ2ICPg04fpzhH3P0d3vTw8yf2kywoDnav5c457LrKe
        dOHe+22RH+o3ezW8rwlx/bFi7WMeVbWXSizFGYmGWsxFxYkAu5aSqKsDAAA=
X-CMS-MailID: 20230530121351epcas5p2b18d46d6be650a7b830690b845ec22c8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_319e1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8
References: <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
        <20230522104146.2856-1-nj.shetty@samsung.com>
        <20230522104146.2856-3-nj.shetty@samsung.com>
        <CAFL455nMtKbDt1HeN6D2WPB2JjOYq2z1=RagmmuhmQ33eL2Bfw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_319e1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 23/05/30 01:29PM, Maurizio Lombardi wrote:
>po 22. 5. 2023 v 13:17 odesílatel Nitesh Shetty <nj.shetty@samsung.com> napsal:
>>
>> +static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
>> +               struct block_device *bdev_out, loff_t pos_out, size_t len,
>> +               cio_iodone_t endio, void *private, gfp_t gfp_mask)
>> +{
>> +       struct cio *cio;
>> +       struct copy_ctx *ctx;
>> +       struct bio *read_bio, *write_bio;
>> +       struct page *token;
>> +       sector_t copy_len;
>> +       sector_t rem, max_copy_len;
>> +
>> +       cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
>> +       if (!cio)
>> +               return -ENOMEM;
>> +       atomic_set(&cio->refcount, 0);
>> +       cio->waiter = current;
>> +       cio->endio = endio;
>> +       cio->private = private;
>> +
>> +       max_copy_len = min(bdev_max_copy_sectors(bdev_in),
>> +                       bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
>> +
>> +       cio->pos_in = pos_in;
>> +       cio->pos_out = pos_out;
>> +       /* If there is a error, comp_len will be set to least successfully
>> +        * completed copied length
>> +        */
>> +       cio->comp_len = len;
>> +       for (rem = len; rem > 0; rem -= copy_len) {
>> +               copy_len = min(rem, max_copy_len);
>> +
>> +               token = alloc_page(gfp_mask);
>> +               if (unlikely(!token))
>> +                       goto err_token;
>
>[...]
>
>> +err_token:
>> +       cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
>> +       if (!atomic_read(&cio->refcount))
>> +               return -ENOMEM;
>> +       /* Wait for submitted IOs to complete */
>> +       return blkdev_copy_wait_completion(cio);
>> +}
>
>Suppose the first call to "token = alloc_page()" fails (and
>cio->refcount == 0), isn't "cio" going to be leaked here?
>
>Maurizio
>

Agreed, will free it in "err_token", and will update next version.

Thank you,
Nitesh Shetty

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_319e1_
Content-Type: text/plain; charset="utf-8"


------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_319e1_--
