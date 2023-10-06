Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A551C7BB193
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 08:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjJFGem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJFGel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:34:41 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECFACA
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 23:34:38 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231006063435epoutp032cb26503cae749d52c237e8d0afaaa65~LcSH96fqd1574615746epoutp03V
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 06:34:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231006063435epoutp032cb26503cae749d52c237e8d0afaaa65~LcSH96fqd1574615746epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696574075;
        bh=9oSZ7fmA4mqWaKJ8Rdiwiyeth7cOhSmwwcOUHquZxKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTdgoy4W1H8S1AnPNqlN8gegua9pmKaK+3+mNWK0kYtUgSRQuvlpYoNzS80b/cp3S
         jkSIyNfRydOlZbiUjTxMagk2aGlnklLTogKp3oKw5GfL7FsBPyPFuFlrMkvfxjbcQn
         54kLWfyN28P4aDwkTG/VttCFFDJPlWKeUBbsHz2I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231006063434epcas5p298987cdcd8dabcd0b52dfa490888723e~LcSHYkQpm0821308213epcas5p23;
        Fri,  6 Oct 2023 06:34:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1zDT0Mkvz4x9Q9; Fri,  6 Oct
        2023 06:34:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.FF.09635.87AAF156; Fri,  6 Oct 2023 15:34:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231006063432epcas5p45ddbf3a433cab79ab3e4ccb10d4e64c1~LcSFTYsnu2828128281epcas5p4i;
        Fri,  6 Oct 2023 06:34:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006063432epsmtrp2758b86b73f11723113f7137fa4c53068~LcSFQs-IW1168411684epsmtrp23;
        Fri,  6 Oct 2023 06:34:32 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-23-651faa788ee4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.FA.08742.87AAF156; Fri,  6 Oct 2023 15:34:32 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231006063430epsmtip102ac448f24463d34ee1dc91ba5d948aa~LcSDgu4433249532495epsmtip1f;
        Fri,  6 Oct 2023 06:34:30 +0000 (GMT)
Date:   Fri, 6 Oct 2023 11:58:23 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Message-ID: <20231006062813.GA3862@green245>
MIME-Version: 1.0
In-Reply-To: <20231005194129.1882245-2-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmpm7FKvlUg6bv1hYvf15ls1h9t5/N
        YtqHn8wWqx6EWzzYb2+xcvVRJos5ZxuYLPbe0rbYs/cki0X39R1sFsuP/2OyePDnMbsDj8fl
        K94eO2fdZfe4fLbUY9OqTjaP3Tcb2Dw+Pr3F4tG3ZRWjx+dNch7tB7qZAjijsm0yUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5VUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnTHs9gblgE2vF
        s6X7mRsYb7B0MXJySAiYSPw/2c7UxcjFISSwm1Fi8YPtbCAJIYFPjBKbp7pCJL4xSjyf94wN
        pmNuzzRWiMReRoldK9axQDjPGCW2/LrHBFLFIqAicf7rB/YuRg4ONgFNiQuTS0HCIgIaEt8e
        LAerZxboZpZ4OXkjWL2wQKzEwo9z2EFsXgEdia6lG1kgbEGJkzOfgNmcAlYSR/btZgSxRQWU
        JQ5sOw52t4TADg6Jt+d3gi2TEHCRWLhZHeJSYYlXx7ewQ9hSEp/f7YX6IFni0sxzTBB2icTj
        PQehbHuJ1lP9zCA2s0CGxLYjP5kgbD6J3t9PmCDG80p0tAlBlCtK3Jv0lBXCFpd4OGMJlO0h
        sf3GQRZ4AD1Yd49lAqPcLCTvzEKyAsK2kuj80MQ6C2gFs4C0xPJ/HBCmpsT6XfoLGFlXMUqm
        FhTnpqcWmxYY56WWw+M4OT93EyM4AWt572B89OCD3iFGJg7GQ4wSHMxKIrzpDTKpQrwpiZVV
        qUX58UWlOanFhxhNgdEzkVlKNDkfmAPySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1O
        TS1ILYLpY+LglGpg2n35fcRkjxNzbbSOy/7fw9jwTdHlwRt1mU6FXX8PVzxhPZ4+UfjawU/f
        JqewX6gK0H5qmrsopOXWutKKuOv2LrzrX4bKWLk6t1h/DEx9UxfnIWzJ+K5x2cK5u948eGJ7
        T/yE3av8Zvtdrc1l55s+McuvFe/bmnV4x367qyfvanXu+nI645XHvFVPFZxv988/oWyt2Nt5
        8va286UHdl2pfjaxLsj9yqTtR7vuSC5fv4T/Aedj2c9lWm0tn3iEX7Jevvlq1W//jAQJpr3a
        t0N+3L35wGMCz6o9LvG5P/fb2Hf5fdx89ZAt97XY6F3i6za1hJbLX252D2X74FrCO8euseK+
        1pTu08HF2y7u2v7oebASS3FGoqEWc1FxIgC1RNUWSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTrdilXyqweIH0hYvf15ls1h9t5/N
        YtqHn8wWqx6EWzzYb2+xcvVRJos5ZxuYLPbe0rbYs/cki0X39R1sFsuP/2OyePDnMbsDj8fl
        K94eO2fdZfe4fLbUY9OqTjaP3Tcb2Dw+Pr3F4tG3ZRWjx+dNch7tB7qZAjijuGxSUnMyy1KL
        9O0SuDI2zTjIUvCEqWLvpj2sDYxLmLoYOTkkBEwk5vZMY+1i5OIQEtjNKHHz42xGiIS4RPO1
        H+wQtrDEyn/P2SGKnjBKtG74DpZgEVCROP/1A5DNwcEmoClxYXIpSFhEQEPi24PlLCD1zAL9
        zBLtL4+DbRMWiJVY+HEOWC+vgI5E19KNLBBD9zJKTPszhxkiIShxcuYTFhCbWcBMYt7mh8wg
        C5gFpCWW/+MACXMKWEkc2bcb7FBRAWWJA9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucW
        GxYY5qWW6xUn5haX5qXrJefnbmIER5WW5g7G7as+6B1iZOJgPMQowcGsJMKb3iCTKsSbklhZ
        lVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTChiZbRUf84N+/ddmK/+9
        7l3qCt+fChwCqz16je9YM74MfsafZjZzimV6du1Zb+mtL/WF/JLXxASUByU0yzj+NvNam8cn
        cmmLbu8trWgF9nz/JsYf1+/cmWVcGLA5ZZf6mcXfXx8sa5TxiRdxWvdIrXCBrCjvAtbN+ZHX
        opMiS1L2np3/ji3IN0Shm6uGV+HXois31x4VWpvekW59pbP5g9LjJi61oOdS9Rv5XAz7mS/Z
        WO96dPN5xCfjy5XH6uwWe94zfM7xkF0p/V3c5u3BhkG//IVlWVY33ZObkRSYErB3qtNfqYaC
        G60b3/JdZHg16+HE17LGH49Z2fYdfGb/XuoFx0adjmNPm9XtBP64K7EUZyQaajEXFScCABDk
        1PcZAwAA
X-CMS-MailID: 20231006063432epcas5p45ddbf3a433cab79ab3e4ccb10d4e64c1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Q05VG59npZNIcC9SezYoqUiUcYZ5r-Xh01bG8k0yiPfvookF=_470d8_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e
References: <20231005194129.1882245-1-bvanassche@acm.org>
        <CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
        <20231005194129.1882245-2-bvanassche@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------Q05VG59npZNIcC9SezYoqUiUcYZ5r-Xh01bG8k0yiPfvookF=_470d8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Oct 05, 2023 at 12:40:47PM -0700, Bart Van Assche wrote:
>A later patch will store the data lifetime in the bio->bi_ioprio member
>before bio_set_ioprio() is called. Make sure that bio_set_ioprio()
>doesn't clear more bits than necessary.

Only lifetime bits need to be retained, but the patch retains the CDL
bits too. Is that intentional?

------Q05VG59npZNIcC9SezYoqUiUcYZ5r-Xh01bG8k0yiPfvookF=_470d8_
Content-Type: text/plain; charset="utf-8"


------Q05VG59npZNIcC9SezYoqUiUcYZ5r-Xh01bG8k0yiPfvookF=_470d8_--
