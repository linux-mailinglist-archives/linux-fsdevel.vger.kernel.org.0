Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4C747C41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 07:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGEFIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 01:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEFIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:08:40 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B91700
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 22:08:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230705050836epoutp027d1b4aab3df48587f12b588ff97bd3ae~u4HgDCACB2068320683epoutp02b
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 05:08:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230705050836epoutp027d1b4aab3df48587f12b588ff97bd3ae~u4HgDCACB2068320683epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688533716;
        bh=4Ewd3gtlsRFOPjxmqq4oPNNNlKps69tnLeCMAL7g76s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHL2+HBO+rENRTAh52BBoUnyH+UfrKCoGp4vmS8HdV6zGo1LqMc2SqeiDynf3Mfqd
         qTpbfiBydtbVePkxL96nFU46g2jU1U1rdwKMecyyY7EmTv4gDGeA4fGHkW7nurm9H8
         uB9aV0QMJqeZWOA27nlG5nSpOKL4As2AJLb+mteQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230705050836epcas5p1f1ad4f1ec0602b11a4b0b80cbffab182~u4Hfz3sLf1822118221epcas5p1n;
        Wed,  5 Jul 2023 05:08:36 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Qwnk964Wvz4x9QD; Wed,  5 Jul
        2023 05:08:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.A7.57354.ACAF4A46; Wed,  5 Jul 2023 14:08:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230705050825epcas5p3d58c4d83fc8c4768a261e54f56d8e492~u4HWYQfmK2595625956epcas5p3P;
        Wed,  5 Jul 2023 05:08:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230705050825epsmtrp1b023a6b83f8a3b06f1bac5496ff18d94~u4HWXgKu11624916249epsmtrp1N;
        Wed,  5 Jul 2023 05:08:25 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-bc-64a4facad95f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.42.34491.9CAF4A46; Wed,  5 Jul 2023 14:08:25 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230705050824epsmtip1fe377366da3ec3f0b1507392955dcf00~u4HVYzcLc0370203702epsmtip1c;
        Wed,  5 Jul 2023 05:08:24 +0000 (GMT)
Date:   Wed, 5 Jul 2023 10:35:10 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/32] block: Use blkdev_get_handle_by_dev() in
 blkdev_open()
Message-ID: <20230705050510.GA28287@green245>
MIME-Version: 1.0
In-Reply-To: <20230704122224.16257-3-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmuu6pX0tSDBqn61isvtvPZnF6wiIm
        i9nTm5ks9t7Sttiz9ySLA6vH5hVaHpfPlnqcWXCE3ePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygpUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iz/z+6zFjziq/j3aSdjA+M+
        ni5GTg4JAROJrrVrWboYuTiEBHYzSsw928cM4XxilHg2+TwThPONUWL98lvsMC13761hg0js
        ZZR4fXg1I4TzjFHiw5JdTCBVLAIqEgtXrQOaxcHBJqApcWFyKUhYREBaYtaxlWD7mAVaGSUW
        Xn3OCpIQFgiWeLL0Blgvr4CuxJR1n5ghbEGJkzOfsIDYnAJGEvePTgOLiwooSxzYdhzsPAmB
        R+wSvX272SDOc5H4uGQDlC0s8er4FqizpSRe9rdB2ckSl2aeY4KwSyQe7zkIZdtLtJ7qB1vA
        LJAh8f79HiibT6L39xMmkGckBHglOtqEIMoVJe5NesoKYYtLPJyxBMr2kJjXfAMadKsZJU41
        L2GcwCg3C8k/s5CsgLCtJDo/NLHOAlrBDAyk5f84IExNifW79Bcwsq5ilEwtKM5NT002LTDM
        Sy2Hx3Jyfu4mRnBC1HLZwXhj/j+9Q4xMHIyHGCU4mJVEeFd8X5wixJuSWFmVWpQfX1Sak1p8
        iNEUGD8TmaVEk/OBKTmvJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5O
        qQamDT+SDzuJlq/I8DiRN4+7qVpcU9bU46WewpQvha/KT7VtmyfsW3P5TfOfc8fmPjYxMVYx
        36a4TU7nBrdBkGb1Rh7PGTu45i2+1PDde4Z+10ZZn1XBPSs5HpqV3NSeHebbu6l4jlmixJSd
        d2ImJqg/npnGcvBtX3gR58tlH8ImtdVddGqY/+voJpN9+udzu1LaJL6rX51tWFu3z9WF8+bt
        26Xt/jbp+o8stKpjovlt4+/GHzLNyyz3i7hebGfUZM9W8s2PqT/jpZduV/rCf8Gi9TuXr/p4
        /80Eve8pzjO2LWfpctpeHKy9cp7ht8N/rNPKk/2W73k4K9Oyw+9Nn8Fa56224roLvux8FL/g
        d6ISS3FGoqEWc1FxIgBoib+LEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO7JX0tSDFZeMrNYfbefzeL0hEVM
        FrOnNzNZ7L2lbbFn70kWB1aPzSu0PC6fLfU4s+AIu8fnTXIBLFFcNimpOZllqUX6dglcGQ8f
        f2ctmMJTcWymbQNjF1cXIyeHhICJxN17a9i6GLk4hAR2M0o8mPyWGSIhLtF87Qc7hC0ssfLf
        c3aIoieMErefTGMFSbAIqEgsXLUOqIGDg01AU+LC5FKQsIiAtMSsYytZQOqZBVoZJQ7cf8YC
        khAWCJZ4svQGE4jNK6ArMWXdJ2aIoasZJc5c+8kKkRCUODnzCVgDs4CZxLzND8EWMANNXf6P
        AyTMKWAkcf/oNLBDRQWUJQ5sO840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERzeWpo7GLev+qB3iJGJg/EQowQHs5II74rvi1OEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MCW+eGluw+W8aqp6Q3OE5nRNRtG4
        GwEcaYWWBkcVrObdT/fWYN0oz7PAUirmV3P6syNt5xflZNsduVF33f3GyvDvm9dGulVtX670
        cd9a+ae7rWfvEWzIuxy24rXhPsPXiznWOSr9/W/3Z12yCPdn56kn7YLfSawW2iVhypI118P6
        YcSUluxN/pdP6eRzeuv3N+pxPUzVXsFp4H6DdY/yjos/e6sWb+cTvx7KEtxw3HetqUd6r2P5
        ESnXfYe+35yreNXU1XfiTaOWM6XeX9YseTW91bNVZl9LmsTO/ueTP9xeNvuFiOJHlYT1hblW
        bVM+Sr/beHK6pqhpdo/yyqSf+dPERWWjl187f2DjET+rc0osxRmJhlrMRcWJAIrlqOXeAgAA
X-CMS-MailID: 20230705050825epcas5p3d58c4d83fc8c4768a261e54f56d8e492
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a6ccd_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230704122236epcas5p4f17ed438838d75c8229e4ab0ea009c37
References: <20230629165206.383-1-jack@suse.cz>
        <CGME20230704122236epcas5p4f17ed438838d75c8229e4ab0ea009c37@epcas5p4.samsung.com>
        <20230704122224.16257-3-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a6ccd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Jul 04, 2023 at 02:21:30PM +0200, Jan Kara wrote:
>Convert blkdev_open() to use blkdev_get_handle_by_dev().
>
>Signed-off-by: Jan Kara <jack@suse.cz>
>---
> block/fops.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
>diff --git a/block/fops.c b/block/fops.c
>index b6aa470c09ae..d7f3b6e67a2f 100644
>--- a/block/fops.c
>+++ b/block/fops.c
>@@ -496,7 +496,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
>
> static int blkdev_open(struct inode *inode, struct file *filp)
> {
>-	struct block_device *bdev;
>+	struct bdev_handle *handle;
> 	blk_mode_t mode;
>
> 	/*
>@@ -509,24 +509,25 @@ static int blkdev_open(struct inode *inode, struct file *filp)
> 	filp->f_mode |= FMODE_BUF_RASYNC;
>
> 	mode = file_to_blk_mode(filp);
>-	bdev = blkdev_get_by_dev(inode->i_rdev, mode,
>-				 mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
>-	if (IS_ERR(bdev))
>-		return PTR_ERR(bdev);
>+	handle = blkdev_get_handle_by_dev(inode->i_rdev, mode,
>+			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
>+	if (IS_ERR(handle))
>+		return PTR_ERR(handle);
>
> 	if (mode & BLK_OPEN_EXCL)
> 		filp->private_data = filp;

Is this needed?
This is getting overwritten after a couple of lines below.

>-	if (bdev_nowait(bdev))
>+	if (bdev_nowait(handle->bdev))
> 		filp->f_mode |= FMODE_NOWAIT;
>
>-	filp->f_mapping = bdev->bd_inode->i_mapping;
>+	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
> 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
>+	filp->private_data = handle;

Here.


------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a6ccd_
Content-Type: text/plain; charset="utf-8"


------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a6ccd_--
