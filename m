Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2783677B749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjHNLEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjHNLEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:04:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6118F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:04:50 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230814110447epoutp029b0e1e73ff18a1ff6adec621612208e0~7Ox6vsT4Q3253532535epoutp02N
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 11:04:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230814110447epoutp029b0e1e73ff18a1ff6adec621612208e0~7Ox6vsT4Q3253532535epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692011088;
        bh=MpU5sg64Rtz0wgAz4NAZ93T3v5OyDdjEZ/irGTT+4ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oLkfbfpCgv+Jr4yhM1GpSQMl3BOS784wQWuq0A9PdlVZLI8EM7CGoWX+a11G0dxfh
         Jq572gIsL94mXckbKtny1oR739QLKIpPzWhCdjFipfX3p/2DK0da4kwFNtN+udV4G1
         o+QEksRxl+W8mf43fadi2/CJHJdziYi/+zzxhStI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230814110447epcas5p490379260eb7de32348ca4fc4b8d3cfc2~7Ox6IFwcC2024420244epcas5p4m;
        Mon, 14 Aug 2023 11:04:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RPWkj4Rfpz4x9Pr; Mon, 14 Aug
        2023 11:04:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.39.44250.D4A0AD46; Mon, 14 Aug 2023 20:04:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230814103824epcas5p2e5155c861ab70bb8cca3e76bdd927a81~7Oa4VdjhG0954109541epcas5p2F;
        Mon, 14 Aug 2023 10:38:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814103824epsmtrp1d65eec6dba8f8ada46fd5bd57ce2d5ee~7Oa4Ub3752451324513epsmtrp12;
        Mon, 14 Aug 2023 10:38:24 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-9a-64da0a4d2535
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.B3.64355.0240AD46; Mon, 14 Aug 2023 19:38:24 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814103821epsmtip27238edf5915e73a70212847347f4b676~7Oa1Opylv1721117211epsmtip2Q;
        Mon, 14 Aug 2023 10:38:21 +0000 (GMT)
Date:   Mon, 14 Aug 2023 16:05:05 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v14 01/11] block: Introduce queue limits and
 sysfs for copy-offload support
Message-ID: <20230814103505.rjcv4esakiqpndnl@green245>
MIME-Version: 1.0
In-Reply-To: <170b68ca-b24c-0723-cc54-7fcdc9004bcc@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH9+u9vbTEkrsC+hOQ1RocYAotlnpRq0t8cINbIMFtCZkpld6U
        jtI2fQz1HxkMESIC4xFXGDJEy2MroTinPITgGFLmWFd5deBwFDIHCOI7DlhLgfjf53zP7/s7
        OefkMBD2Ba8AhkKlp7QqqZKLeaM37oSF8z7ydsj4k4vbiCbrLwiRVbSEEI3jhRgxc2cREOUL
        rxHC2ZULiInOg0TH4wo6Mdp1i0bUN/bQiJ6VOYz4unsIEFODRhrR4dhFfHeuFiXaO/pQwt5a
        iRGXr015EabeZRoxUjQFCPPMPErcdQQSA0u99A+2kPb7x8iBB80oab9nIC0NeRjZUnuWbBvN
        xMgrF0voZEH2Y4x8MuVAyfnbgxh58XoDIJ9agkmLc46WwEpK259KSWWUlkOpUtQyhUou5h5L
        lBySRIv4Ap4ghtjD5aik6ZSYe/jDBN5RhdLVOJfzhVRpcEkJUp2OG3lgv1Zt0FOcVLVOL+ZS
        GplSI9RE6KTpOoNKHqGi9HsFfH5UtOthclpq12Qf0IxipzprHF6ZYJSeDxgMiAvhq9ygfODN
        YONtAPbN9tA9wSKAL7NzwEZQPNiy4egeXtNvATj2vBh162x8GsDy2HzAZKB4CGyZKfdyyxi+
        C/avMNyyHx4KX0yYULcVwW/TYaF5CXEnfHElrCttx9zMwkXQbi5BPPwu7PvGibqZie+DZaOL
        q+yPB8FLV58j7o8gfoUJLQ4nzZ2A+GE41Jbr5WFf+G/v9TUOgI8Kz61xBqwvrcM85q8ANA4b
        gSdxEOZYC1crI3gqzJpeWdO3wTKrmebRfWDBm/ViLHizap13wO+bqjEPb4VDL79cYxKWnX+C
        eaa1AGBV0RxaBN4zvtWd8a16Ht4L8xay6EbX9BA8EJqWGR4Mg02tkdWA3gC2UhpdupzSRWui
        VFTGxr5T1OkWsHoW4XE3wcOJhYhuQGOAbgAZCNeP5YgdkrFZMunpM5RWLdEalJSuG0S7tlWM
        BPinqF13pdJLBMIYvlAkEgljdosE3C2smZxvZWxcLtVTaRSlobTrPhqDGZBJkwtP88HAm+XL
        xY2tIX0/ODifcEvif7SfjVu6MR1aNfH6xMIf88HRf+/cd21ZFW6zXcpoaXpHHDcb72Tjr1oU
        /Sa/IluFYNJin5IcKTA9MolrZvPCP8upffEgXmKLLL9ad//TKF6BbCT2zKGInyL+rBn7a+Q/
        6dHPmZVlysphOfP3Z9VFm6wlY4GHksYvhHTsEIdod2tO9rd1Jq9YBZyk5YJ/alOCHyZXBBXc
        zQ31PcLTGk4ossz+85tL32+qrB8wa+lZonwLes+htbN/c9jabYUjrRW/2jGrT+KpZ+cDTvIU
        2WHHnbWyxP6cPdvDjm/Cu4xjPk97D4wHNTfDnR//vHmSi+pSpYJwRKuT/g9IngSjnwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvK4Cy60Ug8MndSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFg/221vsfTeb1eLmgZ1MFitXH2WyOPr/LZvFpEPXGC2e
        Xp3FZLH3lrbFwrYlLBZ79p5ksbi8aw6bxfxlT9ktlh//x2RxY8JTRot1r9+zWJy4JW1x/u9x
        Vgdxj8tXvD3O39vI4nH5bKnHplWdbB6bl9R77L7ZwOaxuG8yq0dv8zs2j49Pb7F4vN93lc2j
        b8sqRo/Pm+Q8Nj15yxTAG8Vlk5Kak1mWWqRvl8CV8eHDWuaCbpaKb9OWMDcwLmXuYuTgkBAw
        kTh0nbGLkYtDSGA7o8SKzoesXYycQHFJiWV/jzBD2MISK/89Z4coesIoceToDSaQBIuAqsTm
        19PYQQaxCWhLnP7PARIWEdCQ+PZgOQtIPbPAEVaJKY1PWEASwgI5Eium7GEDsXkFzCQur5vM
        DDH0A6PEwckr2CESghInZ0I0MAMVzdv8EOxSZgFpieX/wBZwClhLTL35CaxEVEBGYsbSr8wT
        GAVnIemehaR7FkL3AkbmVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjB8a0VtINx2fq/eocY
        mTgYDzFKcDArifDecr+WIsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1
        CCbLxMEp1cDE55XF06k678cOKYMt5Wt8I3o7Zx7jDNiosGSR4Syb3s8rs/un7vr702Jl2of+
        3ooWlqVX/iitPelgtffR5/12i6XemiV+O2mt2XMwQnZ3YdlHwwS17L7zNW8SjPtkmnaeevuM
        uzSj8VL1+4cqIqeTxRYtL/ppKXrqbvLNI8b3927Mc1Hnc+4Ml2NOn8l0sXDHpfy2tynffDk7
        bIXF9J9O3GVjl3NBPHCCRpay6ESLIhuFi0xxmSfiDZ/vzRb6VpP17q1YqO0Ch1PWN/7y6R7Z
        uUVQyD7w4TlXP9vDG97G1YRlpyR/yEg6yjqtsGBuE8dGa76jj/a8PCF2tVlxsqH2zkLZ2LMJ
        R3c07Qm/6K7EUpyRaKjFXFScCABloun2XgMAAA==
X-CMS-MailID: 20230814103824epcas5p2e5155c861ab70bb8cca3e76bdd927a81
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_545b7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1@epcas5p4.samsung.com>
        <20230811105300.15889-2-nj.shetty@samsung.com>
        <170b68ca-b24c-0723-cc54-7fcdc9004bcc@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_545b7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/11 02:56PM, Bart Van Assche wrote:
>On 8/11/23 03:52, Nitesh Shetty wrote:
>>+/* maximum copy offload length, this is set to 128MB based on current testing */
>>+#define COPY_MAX_BYTES		(1 << 27)
>
>Since the COPY_MAX_BYTES constant is only used in source file
>block/blk-settings.c it should be moved into that file. If you really
>want to keep it in include/linux/blkdev.h, a BLK_ prefix should
>be added.
>
We are using this in other files. So we will add a prefix BLK_.

Thank you,
Nitesh Shetty

------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_545b7_
Content-Type: text/plain; charset="utf-8"


------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_545b7_--
