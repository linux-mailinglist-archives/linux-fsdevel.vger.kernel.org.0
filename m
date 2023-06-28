Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7A742163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjF2Htm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjF2Hrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:47:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51B2D56
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 00:47:37 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230629074735epoutp027b87cf4708c7c703be039cf08522c035~tEamxPmEE1813218132epoutp02D
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 07:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230629074735epoutp027b87cf4708c7c703be039cf08522c035~tEamxPmEE1813218132epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688024855;
        bh=IyD2z568ZZGB9FehtcOv1GRa9s+/z/rHUL2vV68hwRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cz8Mh9kraMlg6KpMGNL3q95uT5xR3iADcB5oRFaJgoVkQOF2j3WI4HssNYoJIVs46
         k8EwtnrFKV0BPbdRa3BYawYzlSHrIiZNo8kYINTXSht9zdFLDVs5TOS28ChFrxVGYF
         78IHgfgxuUeAFDbgfJMQw10x4UqUjzZIVtNJSV5s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230629074734epcas5p4cc802435e65817703a6bfa7a237a6433~tEalXK4Ib2970729707epcas5p4t;
        Thu, 29 Jun 2023 07:47:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qs9XN4QGHz4x9Q2; Thu, 29 Jun
        2023 07:47:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.77.06099.4173D946; Thu, 29 Jun 2023 16:47:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230628164314epcas5p43d203daae701b950a2649bb97c0c8ef5~s4E-sqhrT1878918789epcas5p4N;
        Wed, 28 Jun 2023 16:43:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230628164314epsmtrp1b4b1b459c8517507dab6d889ddb70aa8~s4E-rV6Yc2914729147epsmtrp1o;
        Wed, 28 Jun 2023 16:43:14 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-69-649d37142ebc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.92.30535.2236C946; Thu, 29 Jun 2023 01:43:14 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628164304epsmtip18665c8edaf0a91b72f882ceb4459921d~s4E2b1J9z2949329493epsmtip1U;
        Wed, 28 Jun 2023 16:43:04 +0000 (GMT)
Date:   Wed, 28 Jun 2023 22:09:58 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <20230628163958.tgwtlszadsa7zoub@green245>
MIME-Version: 1.0
In-Reply-To: <365d5129-b65e-919a-3ceb-cc2ccf6b7a5a@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaUxUVxTHe9978+ZhO/pESC9ggU5DVQzL1GG4IJtRyWsgLS1tPxgbfDAv
        QIGZySxV2xrBjTiWGVaLI2WpVFlEwtKCLMVAcQSkqMheGkMGRKhIJRUIgmV40Pbb7/zP+eec
        e04uhdtWCB2peIWWUyvYRDG5ifi5bddODzvf7+XexWUuqLLzNo5OpS/jqHzUSKLptucAXZxd
        xJHlVipAvZbN6FFLMGqeuSxAQ7duYqjph0wMlZa3YyiztR+g8T4ThpqHd6Oic8UEamruIFBv
        Qx6JCq6OC9GFgXoSXTOvYKg16zSG6i0pAN2YfkagO8NOqGfZLEBLC3lkiBPT+zCMuWkaFTI9
        f1QRTE2JO9PbrWOqy86TTE3xSaZxKJlkrhiyBEza6RmS+Wt8mGCe/dJHMobaMsDUdH3NzFU7
        M9WWp1gEfSghII5j5ZzalVPEKOXxithAcVhk1P4oH5m3xEPih3zFrgo2iQsUHwiP8AiNT1xd
        jNj1SzZRtypFsBqN2CsoQK3UaTnXOKVGGyjmVPJElVTlqWGTNDpFrKeC0/pLvL3f81ktPJIQ
        d/H3SaCadDj2IOMqlgxe2umBDQVpKWxe6MH1YBNlSzcCWFc/vx48B7CrMlnIBy8A/GleT2xY
        eibNBJ9oBrB7uWPdMgHgbwsvMD2gKIJ2gxNz71uRpHfDrleU1WtH74A5WU3AWo7TehLeKSgX
        WBPbaBbWrRiEVhbRMph920TyvBV2XLKsNbahg2CVqWpNt6e3w9wf/17rC+lhGziab8b56Q7A
        kYa09Um3wSlzrZBnR/jEeG6dj8LS7BKSN58B0DRgAnwiGJ7tNOLWqXE6Dj4t8uLlt2BO5w3M
        yji9GaYtWTBeF8H6/A1+B16vLCR5doD98ynrzMAnFwYBv6A5AEsfVJLpwMX0v8eZ/mtnWmvh
        D8/PnhLwshO8tkLxuAtWNngVAkEZcOBUmqRYTuOj2qPgjv578BhlUjVY+zfuYfVg7NGsZyvA
        KNAKIIWL7UQjf16W24rk7PGvOLUySq1L5DStwGf1VBm4o32McvXjKbRREqmft1Qmk0n99sgk
        4jdF9wfS5LZ0LKvlEjhOxak3fBhl45iM6T/gWquRnvkw/fNI/ZHGPgHt2pK1d99dLOL1L5Rb
        2/ePjQyw3x5jvR77F5Qsuo+NgMOLWn+b9oMNecy+EfmEqKNW2hQfi2j8JRGgDp+qyR60v/5N
        SXD0UsiJCOOvdlPpXR9tyZU13pMiziX+rmtASt3bHQ7HD3kVPhz/+JOxCNm8z6s3dshLd2Zm
        5TTvVb3W7ew3eMXjXftP888MURZ7ERcJQj0DjNTyyaAqvI2D3SFuGVh4Qb/3bEV0y9S9g26p
        uakGYsY5fAshybxfFH3WMJNWNhxa78mZzNONIpdKndCwfSa0YTEU0x1+/J2gosCYfsI++7PS
        /ksDvuWFOj8xoYljJe64WsP+AxNX4wnABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCSnK5S8pwUgz1rWSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHu9XsWixO3pC3O/z3OavH7xxw2B2mPy1e8PXbOusvucf7eRhaPzSu0PC6fLfXYtKqTzWPz
        knqP3Tcb2DwW901m9ehtfsfm8fHpLRaP9/uusnn0bVnF6LH5dLXH501yHpuevGUKEIjisklJ
        zcksSy3St0vgyjiz/itTwSzxita/nUwNjCeEuhg5OSQETCTOvzjO0sXIxSEksJtR4uCHM6wQ
        CUmJZX+PMEPYwhIr/z1nhyh6wijR+/YDWxcjBweLgKrEs8+eICabgLbE6f8cIOUiAuoSUyfv
        YQQpZxboYZO4dQ1kASeHsECixPZ/fewgNq+AmcSUY7PYIGZ+ZpRombGcDSIhKHFy5hOwBmag
        onmbHzKDLGAWkJZY/g9sAaeAncTGWRvBykUFZCRmLP3KPIFRcBaS7llIumchdC9gZF7FKJla
        UJybnltsWGCUl1quV5yYW1yal66XnJ+7iRGcJrS0djDuWfVB7xAjEwfjIUYJDmYlEd7bb2an
        CPGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cB02LL7ZoB8
        v+7nV4u2nG2ewBEYfyx2Jdtl5iP5Wh0vT7VJxrYp2Hlydf/8KXdb4GfWSrW9AVPrZ0vNe9NR
        9/N9h90r+5UXJ9WteBH2jMtit/q1Zn7d0ICALWJJycFTVm2Oe3TO2cX29qLJhuvfaz6t9HMP
        T41syhMsMv048XaozAWFY+oxW7JnLp3j6SvguzdZgGVWnPw8py2Kpw0SfvXvf53+cvvahx8l
        PaSNjucX7jXIt/vInsozy0067Hpa5S7Nu8vzPOZZvC68cHq256f1QjU7L2rqnLb6xtZ1vWdt
        8s+03TtePZ/5q7/W9dPTPT/0YmyufreeJtJ1ZWPQmSedv/8cPp1fd5LrVsW/NIYdSizFGYmG
        WsxFxYkAxFAvgIIDAAA=
X-CMS-MailID: 20230628164314epcas5p43d203daae701b950a2649bb97c0c8ef5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_9622e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51@epcas5p4.samsung.com>
        <20230627183629.26571-5-nj.shetty@samsung.com>
        <365d5129-b65e-919a-3ceb-cc2ccf6b7a5a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_9622e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/28 03:51PM, Damien Le Moal wrote:
>On 6/28/23 03:36, Nitesh Shetty wrote:
>> For direct block device opened with O_DIRECT, use copy_file_range to
>> issue device copy offload, and fallback to generic_copy_file_range incase
>> device copy offload capability is absent.
>
>...if the device does not support copy offload or the device files are not open
>with O_DIRECT.
>
>No ?
>
Yes your right. We will fallback to generic_copy_file_range in either of
these cases.

>> Modify checks to allow bdevs to use copy_file_range.
>>
>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-lib.c        | 26 ++++++++++++++++++++++++++
>>  block/fops.c           | 20 ++++++++++++++++++++
>>  fs/read_write.c        |  7 +++++--
>>  include/linux/blkdev.h |  4 ++++
>>  4 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 09e0d5d51d03..7d8e09a99254 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -473,6 +473,32 @@ ssize_t blkdev_copy_offload(
>>  }
>>  EXPORT_SYMBOL_GPL(blkdev_copy_offload);
>>
>> +/* Copy source offset from source block device to destination block
>> + * device. Returns the length of bytes copied.
>> + */
>
>Multi-line comment style: start with a "/*" line please.
>
acked

>> +ssize_t blkdev_copy_offload_failfast(
>
>What is the "failfast" in the name for ?

We dont want failed copy offload IOs to fallback to block layer copy emulation.
We wanted a API to return error, if offload fails.

>
>> +		struct block_device *bdev_in, loff_t pos_in,
>> +		struct block_device *bdev_out, loff_t pos_out,
>> +		size_t len, gfp_t gfp_mask)
>> +{
>> +	struct request_queue *in_q = bdev_get_queue(bdev_in);
>> +	struct request_queue *out_q = bdev_get_queue(bdev_out);
>> +	ssize_t ret = 0;
>
>You do not need this initialization.
>

we need this initialization, because __blkdev_copy_offload return number of
bytes copied or error value.
So we can not return 0, incase of success/partial completion.
blkdev_copy_offload_failfast is expected to return number of bytes copied.

>> +
>> +	if (blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len))
>> +		return 0;
>> +
>> +	if (blk_queue_copy(in_q) && blk_queue_copy(out_q)) {
>
>Given that I think we do not allow copies between different devices, in_q and
>out_q should always be the same, no ?

acked, will update this.

>
>> +		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
>> +				len, NULL, NULL, gfp_mask);
>
>Same here. Why pass 2 bdevs if we only allow copies within the same device ?
>

acked, will update function arguments to take single bdev.

>> +		if (ret < 0)
>> +			return 0;
>> +	}
>> +
>> +	return ret;
>
>return 0;
>

Nack, explained above.

Thank you,
Nitesh Shetty

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_9622e_
Content-Type: text/plain; charset="utf-8"


------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_9622e_--
