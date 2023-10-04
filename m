Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308027B7E58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbjJDLjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbjJDLjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:39:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F650B0
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 04:39:48 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231004113944euoutp024fa30a0de4245472863407471c9c6e9a~K5J-h1jor1000010000euoutp02g
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 11:39:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231004113944euoutp024fa30a0de4245472863407471c9c6e9a~K5J-h1jor1000010000euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696419585;
        bh=5EyetCJEC/MoTj6t1PP+QfnfcAe1AO87KAQSjgTsJTk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lQrgJ4eULNBArg6sZVwhedCNCNTAYAjkoBTBjX5amje7IY3g/vTuaJW0bCBPiAK/P
         CWG0CZJwi7PrG+7RbkiDcQ+udg50V2cCxFW4T1oCwnQGp2zjLj/J8gHgvtiVSylT75
         o1c7BEcFe6fdLf+LMu4u8SpUy31kKFirZFaEIxz0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231004113944eucas1p2dff9bfa6ad520de6293edc191458e4af~K5J-D7na40425004250eucas1p2R;
        Wed,  4 Oct 2023 11:39:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.74.11320.00F4D156; Wed,  4
        Oct 2023 12:39:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc~K5J_mFlv82099320993eucas1p2_;
        Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231004113943eusmtrp20a065a1aa77a862031c2af256748880e~K5J_lEQs71686816868eusmtrp2T;
        Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-67-651d4f006761
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.6D.25043.FFE4D156; Wed,  4
        Oct 2023 12:39:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231004113943eusmtip206e9477e2972dd6b1ec12114cb7617c9~K5J_Y2-6B3057530575eusmtip24;
        Wed,  4 Oct 2023 11:39:43 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 4 Oct 2023 12:39:42 +0100
Date:   Wed, 4 Oct 2023 13:39:41 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     John Garry <john.g.garry@oracle.com>
CC:     <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <djwong@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <chandan.babu@oracle.com>, <dchinner@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <jbongio@google.com>, <linux-api@vger.kernel.org>,
        Alan Adamson <alan.adamson@oracle.com>, <p.raghav@samsung.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231004113941.zx3jlgnt23vs453r@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-22-john.g.garry@oracle.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7djPc7oM/rKpBm3fxS329J9islh9t5/N
        4vXhT4wWl47KWZx9NZfd4vITPouVq48yWZzc/57NYtGNbUwWF37tYLSYdOgao8Xm7x1sFntv
        aVvs2XuSxeLyrjlsFvOXPWW32PVnB7vF8uP/mCzWvX7PYtHa85Pd4vzf46wOoh4LNpV6nL+3
        kcXj8tlSj02rOtk8Jiw6wOixeUm9x+6bDWweTWeOMnt8fHqLxeP9vqtsHp83yXlsevKWKYAn
        issmJTUnsyy1SN8ugSvj4I9jjAUrOSvajnexNDAeY+9i5OSQEDCR2Dj5AHMXIxeHkMAKRomm
        l+cZIZwvjBK7Gn6zQzifGSVO/f/NCtMy+9oNFojEckaJZcteMcJVbXr4gxXC2cwo0fG9E6iM
        g4NFQEXiQ7M0iMkmoCXR2MkOYooIaEgcOSQNUs0ssJpFYsrnt2ALhAXMJI7svsIMYvMKmEv8
        WfGIFcIWlDg58wkLiM0soCOxYPcnNpA5zALSEsv/cYCYnAIOEg8XxUOcqSTRsPkMC4RdK7G3
        +QDUx984Jbbv84ewXSRW3bjCBmELS7w6vgWqRkbi/875TBB2tcTTG7/BISQh0MIo0b9zPdha
        CQFrib4zORA1jhKzZn5nhAjzSdx4KwhxJJ/EpG3TmSHCvBIdbUIQ1WoSq++9YZnAqDwLyVuz
        kLw1C+GtBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJT5el/x7/sYFz+6qPeIUYm
        DsZDjBIczEoivOkNMqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbB
        ZJk4OKUamAKlOlnPJ3yQLWNY+jKqbS/vEvaitb/r9+fuUL9Zcq537r9toQF1oZ6pe57MbfMv
        b3I6UijnInRpb/BiGY4Xs0NrdunU7n/157fhMiuz7u+imvp8VqcfxEUtCpj8bgGHsMouUUFO
        j6cO9+P5729eKhkw7+NcA5X/Bj/Tlk7LDVjro7Sba43cNUWWlrzea1cWHhVeHiy4pyB+m+ir
        j8bnJv3NDVN11Ju5cVHx3B0qTguiP3hUOaj/mP02drER6/rPz9ntJbc/Tf2VWpK2eNXGrezJ
        20UKhOeesUx5+O7NqyIf5hd9dzovTTka/OlF8vWO/tK5smplK3yTYjNvHXjtJ7xrgV/p8y2f
        +pLuRX6UKFRiKc5INNRiLipOBADfaNVWBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd3/frKpBlfazCz29J9islh9t5/N
        4vXhT4wWl47KWZx9NZfd4vITPouVq48yWZzc/57NYtGNbUwWF37tYLSYdOgao8Xm7x1sFntv
        aVvs2XuSxeLyrjlsFvOXPWW32PVnB7vF8uP/mCzWvX7PYtHa85Pd4vzf46wOoh4LNpV6nL+3
        kcXj8tlSj02rOtk8Jiw6wOixeUm9x+6bDWweTWeOMnt8fHqLxeP9vqtsHp83yXlsevKWKYAn
        Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4I9j
        jAUrOSvajnexNDAeY+9i5OSQEDCRmH3tBksXIxeHkMBSRolbFx6zQCRkJDZ+ucoKYQtL/LnW
        xQZR9JFR4s21c1Admxklfv7fA+RwcLAIqEh8aJYGMdkEtCQaO9lBTBEBDYkjh6RBqpkFVrJI
        /Dx8jRlkprCAmcSR3VfAbF4Bc4k/Kx6B7RISKJHoPfmLBSIuKHFy5hMwm1lAR2LB7k9sIDOZ
        BaQllv/jADE5BRwkHi6Kh7hSSaJh8xmo62slOl+dZpvAKDwLyaBZSAbNQhi0gJF5FaNIamlx
        bnpusZFecWJucWleul5yfu4mRmDK2Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmEN71BJlWINyWx
        siq1KD++qDQntfgQoykwGCYyS4km5wOTVl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
        dmpqQWoRTB8TB6dUA1P8s7qDx2ufL/vxeEP8tUWRYo4BKu967rAEGb7SvKmm+Cbw62WnR5+P
        rG16LXvvoNia2hks0+v++lp9bl1W5cnEZ6x2/vqfOGu2UuH40+xv7+fd0b4nKxd0Y4n5wpuf
        ps39YRa65VLZi88XU+66PAvRO7FHSOwyp+j8SQm9F3Lu/fuzoUBl96FVS8OF1O8dWd/jeL1z
        1hIOW3GTLxP/Xfq07tD6Wz+uGIdMS8zV+3H/X9p1P77v+/NmLT0mWqj8lME4c2G++oFPkk9F
        nZfVn9mRa9nJ++fPN+1QqbYmN3n/PpHDixq4ps7j5VJ4Mb9Iff9Lk9eSHL+n8VWdUQxm5nTk
        3bItm1u25qNIFHfwPbtEJZbijERDLeai4kQADCX/S6IDAAA=
X-CMS-MailID: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
X-Msg-Generator: CA
X-RootMTR: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-22-john.g.garry@oracle.com>
        <CGME20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +++ b/drivers/nvme/host/core.c
> @@ -1926,6 +1926,35 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	blk_queue_io_min(disk->queue, phys_bs);
>  	blk_queue_io_opt(disk->queue, io_opt);
>  
> +	atomic_bs = rounddown_pow_of_two(atomic_bs);
> +	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
> +		if (id->nabo) {
> +			dev_err(ns->ctrl->device, "Support atomic NABO=%x\n",
> +				id->nabo);
> +		} else {
> +			u32 boundary = 0;
> +
> +			if (le16_to_cpu(id->nabspf))
> +				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +
> +			if (is_power_of_2(boundary) || !boundary) {
> +				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
> +				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
> +				blk_queue_atomic_write_unit_max_sectors(disk->queue,
> +									atomic_bs / bs);
blk_queue_atomic_write_unit_[min| max]_sectors expects sectors (512 bytes unit)
as input but no conversion is done here from device logical block size
to SECTORs.
> +				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
> +			} else {
> +				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
> +					boundary);
> +			}
> 
