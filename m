Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304563C146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 14:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiK2NlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiK2NlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:41:22 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D20627E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 05:41:18 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221129134113epoutp025f81d6a1acf45a8fd10d319842974903~sEe13bEiu3040830408epoutp029
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 13:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221129134113epoutp025f81d6a1acf45a8fd10d319842974903~sEe13bEiu3040830408epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669729273;
        bh=0pWGjvANPUvTa3dYIQwedngLsOojYGWVDq6llT6gHoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WnYR49PujOqcUbiHT1RsfR9NGbw/ww/QHo2efH49uqDTPTNR2MldCFUTw7isLX7Ey
         NeTFIRmSkybGzGUSoXnZSWc26bhvIcDQGaBbJ8y+GhEN9VelO8J9VoWzloph/5EBVM
         0wHWribQWa/h8QWdzxZAsIGsmP5GSTtXIfkf52+w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221129134112epcas5p3952d6737265a7cced70c5b9b42f44fb7~sEe1UCJyF1247612476epcas5p3C;
        Tue, 29 Nov 2022 13:41:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NM3QH1RHTz4x9Pt; Tue, 29 Nov
        2022 13:41:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.D7.39477.6FB06836; Tue, 29 Nov 2022 22:41:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221129122758epcas5p4903125cb05fb36a5fdd4d89dd7c4a0a2~sDe5LYffZ1886718867epcas5p4I;
        Tue, 29 Nov 2022 12:27:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221129122758epsmtrp213e89db4e58bd0a233dd3b860258c1bf~sDe5Iyxd20446004460epsmtrp2E;
        Tue, 29 Nov 2022 12:27:58 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-c9-63860bf62376
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.0B.18644.ECAF5836; Tue, 29 Nov 2022 21:27:58 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221129122755epsmtip1895a7d26f3d2b28585636e34b555dfa4~sDe2Jo09q2443424434epsmtip1U;
        Tue, 29 Nov 2022 12:27:55 +0000 (GMT)
Date:   Tue, 29 Nov 2022 17:46:34 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v5 00/10] Implement copy offload support
Message-ID: <20221129121634.GB16802@test-zns>
MIME-Version: 1.0
In-Reply-To: <cd772b6c-90ae-f2d1-b71c-5d43f10891bf@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0xTZxjH857TnrbccgSUVxTBOhNAi9SV7kWBYQQ5MmKIzixxWVhXjoVA
        L7RFkS9yVbkoQsRt3QRUwHGZhMK4CsOiq0AImQwGjIowZozMdlCWRhFYS8vit9/zz/N/Lu+T
        l427l7O82ckyNa2UiVK5hBOjrT/An2dxviQObjRiqGnwFxzlXF/FUYOhhECmh38y0crwCI56
        jN8x0WRfJ4bqGh5jqPv2IoYer78m0OzyFAOV6cYB6pnahx70DDDQaNf3BKqs/YuFSvUtTNQx
        nw2QuSaPhe4vmBioV3McPZnagUZW9cxIL0ozM0xQnRoDixp51sygRofTKW19AUG1VF+kuiez
        COpqrtGakD/DpEy9YwR1rbUeUGbtLupyXxFGaedfY/FuZ1LCkmhRIq30o2VieWKyTBLO/eRU
        wtGEEGEwn8cPRR9x/WQiKR3OjYqL5x1LTrWuz/U7J0pNt0rxIpWKeyAiTClPV9N+SXKVOpxL
        KxJTFQJFkEokVaXLJEEyWn2IHxx8MMSa+GVK0g3dBKawOGcsXWsnssAcpxBw2JAUQEvdBF4I
        nNjuZDeAlWv9LHuwBOCt4mpgD8wAro5ZWJuWCf20w9IFoH7hR0fWCwCXm7QMWxaD3Au1T5uJ
        QsBmE+Q+OLTOtsmeZBAcm5rYaIGTz9iwfOjpRlUPMgy2/PoTYWNXkgff5LQ7eAsc+HZ+oyaH
        jIB5hrdMG28l98C+Nj1mKwTJBg78Y+E2sI8XBSdmZx3sAV/pWx1je0OzsYew83lYd+MHwm7O
        A1Dzu8Zh+BjmD5bgNsbJJNi0lOPQfWD54H3MrrvBqyvzmF13hR0Vm7wHNjZVORpsh+OWbAdT
        8O9G08YG7qQOwPGfna8DX817y2nea2fn/bCqe4nQWB8PJ3fAe2tsOwbApq4DVYBZD7bTCpVU
        QqtCFAdl9Pn/Ty6WS7Vg438ExnaA2ef/BOkAxgbWrmyc6+m6eDJf7O6aKLqQSSvlCcr0VFql
        AyHWY5Xi3lvFcusHk6kT+ILQYIFQKBSEfijkc71c734TKHYnJSI1nULTClq56cPYHO8s7ALn
        zWc1BjQuPRVtqiUsKK1997YZXu7ipwXCw2tHmCdYt0yec4dc/Avno97FlNVkyn0D+nfHCI8n
        Fivq38kqlqsvR8Qad9ZlRIWHeky9vFOs/eIr4mgFZ/ql5wq/oSsje+9D4vOLZ58cDoiWCwXO
        206UnnFhFv2r/41qGepbKbsSV3C6k5qT17jEZnEnTTuxR70+016+BobEgE9/ra58EOk/G2vQ
        +YAXTrNb1i89z0uoTclb0kkCzZKz+1+NdZC72j849/bezbS2TOIu9DjZdqeyXFMijK5eTDMn
        ZUdKjVrekZioRstoeisjoPl0hFOmc1rcwFzglVyPjmMZRXy3R1yGKknED8SVKtF/MTinN6gE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUhTYRTGe++9u7sbrK5f+aplsIpi4cpa9v4hkUZ0g4ioiDBIl97UdCa7
        fqQhmWnRJLOIylVUpsVmaG5Z2tpalk1naiWGWW6lSzOZ32Bfc7VZ1H8P5/k9zzlwKNz3DRFM
        JadlsMo0eaqYFBL3n4pDw9q/F8WvcrvDUY31OY4KSl04quo9Q6LRJ/089KOtA0fGkcs89Nbc
        gCFNVROGDDfGMdTkdpLo41QPgc41vgHI2LMCPTK2EKjz4RUSXbv1iY/OWvQ8VO84BtBkZSEf
        VQ+PEsik3oKae0JQh8vC2xDIqO1tJNOg7uUzHbZagulsy2R02lMko684yhje5pPM6eMjv4Ei
        O48ZNXWRTMk9LWAmdaHMSXMxxugcTmz73BhhZAKbmpzFKleujxMm9VmukukPBIddpVd5+cDA
        VwEBBWkZ7La8x1VASPnS9QDWdo6AWSMI3nI9w2e1H9TMDPJnIQeA181TXoigl0Ld61pSBSiK
        pFfAVjflGfvTUtjV0+3lcfozBcsnBr1FfnQk1L+qIz1aRIfBbwUPyNnSRgCrvhX/MXxgS5mD
        8GiclsDumSHMswCnQ+DtGe8CAb0eFvZ+53l0AL0Ymu9bsFLgo/4vrf4vrf6Xvg5wLQhi0zlF
        ooILT1+dxmZLObmCy0xLlMYfUuiA9/USST14pB2TNgKMAr9Po3Cxv2h8R1G8ryhBnpPLKg/F
        KjNTWa4RhFCEOFD0UtUS60snyjPYFJZNZ5V/XYwSBOdjzQa9LXrx8MIjp6wG1dD5cyfmJ8F4
        WV5ZrFWaE5WUykXJ7ZVrYdc75zrZdPlQeYNTZGvXhOl2RGC7L9Zxoxnm22sW9OmnKkTtu5ML
        Qq0uTVa21v9CgtzHdqI5Yq0BtBp3KezrNI8L907XzJNIddoocc6ca2Fx+9iInZvGBhbQugGF
        aTAWE7ps1NZ+ILhkuXPTfmb/orqsEv6mn4vuEheDA4wHR4jhVdGKyurAFPcBmWwJuTFgvjNm
        Tu3mmqZtL9Z8KAjKOelnLcmN00wv25brH32vZbJyaKpto+lnRV6Gq3fuxzEHPs9UvOdLoOKL
        ZMmEmpjRLhd+xcokBy81iQkuSR4uwZWc/Be6kX6QaQMAAA==
X-CMS-MailID: 20221129122758epcas5p4903125cb05fb36a5fdd4d89dd7c4a0a2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d164_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5
References: <CGME20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5@epcas5p2.samsung.com>
        <20221123055827.26996-1-nj.shetty@samsung.com>
        <cd772b6c-90ae-f2d1-b71c-5d43f10891bf@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d164_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Nov 23, 2022 at 10:56:23PM +0000, Chaitanya Kulkarni wrote:
> (+ Shinichiro)
> 
> On 11/22/22 21:58, Nitesh Shetty wrote:
> > The patch series covers the points discussed in November 2021 virtual
> > call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
> > We have covered the initial agreed requirements in this patchset and
> > further additional features suggested by community.
> > Patchset borrows Mikulas's token based approach for 2 bdev
> > implementation.
> > 
> > This is on top of our previous patchset v4[1].
> 
> Now that series is converging, since patch-series touches
> drivers and key components in the block layer you need accompany
> the patch-series with the blktests to cover the corner cases in the
> drivers which supports this operations, as I mentioned this in the
> call last year....
> 
> If you need any help with that feel free to send an email to linux-block
> and CC me or Shinichiro (added in CC )...
> 
> -ck
>

Yes any help would be appreciated. I am not familiar with blktest 
development/testing cycle. Do we need add blktests along with patch 
series or do we need to add after patch series gets merged(to be merged)?

Thanks
Nitesh

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d164_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_7d164_--
