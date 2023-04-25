Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E976EDE59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjDYIle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjDYIlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:41:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAB14F72
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 01:38:53 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230425083815epoutp0301781b8c1268bce61875e7e84252b3a1~ZILSa5Jxx2533725337epoutp03J
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 08:38:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230425083815epoutp0301781b8c1268bce61875e7e84252b3a1~ZILSa5Jxx2533725337epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682411895;
        bh=swlgyjxeZRHK5br/YzpC0QXj2VMezak3pvZdUxIn0jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R6awrt9n6fA7toVwnvNFYRfSli/yfSHrYEwgZVi4mxbK2/p8mKZg6d6azy5ud93dR
         5DwIsV5NGnUjABWSh/JGIh45I+YfBftN2UTsJE7S7C8o4sgm9QAvl/EZqFVdWv16mI
         ZCuia2AMUbwIfx11oVLhtgshbJuP2tZdv9COt+TU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230425083815epcas5p39854738053985ff0e106a9043d4c4087~ZILRweSJ10616906169epcas5p3V;
        Tue, 25 Apr 2023 08:38:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q5Fks3DGcz4x9Px; Tue, 25 Apr
        2023 08:38:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.2A.54880.57197446; Tue, 25 Apr 2023 17:38:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230425082930epcas5p1157cd2ebc608fe4d4247e8a7d860ba7c~ZIDo3arJ-0885208852epcas5p1T;
        Tue, 25 Apr 2023 08:29:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230425082930epsmtrp14bd10fb98c25a06f84d7e583df65c478~ZIDo0xR6v1984619846epsmtrp1J;
        Tue, 25 Apr 2023 08:29:30 +0000 (GMT)
X-AuditID: b6c32a49-b21fa7000001d660-ba-64479175ed5c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.4A.27706.96F87446; Tue, 25 Apr 2023 17:29:30 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230425082925epsmtip222d9f988a7e984bda383203b39ff8c6b~ZIDksCMmW2116121161epsmtip2B;
        Tue, 25 Apr 2023 08:29:25 +0000 (GMT)
Date:   Tue, 25 Apr 2023 13:56:34 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 6/9] nvmet: add copy command support for bdev and
 file ns
Message-ID: <20230425082634.GA23150@green245>
MIME-Version: 1.0
In-Reply-To: <77ed029d-4058-b7f9-8dd1-6bc4b1c2b0dc@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1STVRjHue873g2PW6+AchmonFlylJibjXEh8Udx5PXYOVJZHTmdQ3N7
        49fY1sYgKmoIqFAImlgOSCwqBg2U3zAmNkPip50IwZ0DakC/PPxM8CggbXul+u9zv8/3uc99
        7nMeDu5pZPM5CaoUWquSKQXEGlbjtW2BwfrTUQqR+ScvVNN9HUfHCpdxVDVSQKB71+YAOjfz
        EEfT34+5ozvte5B1qtgd3bragqG2L89gyFTVgSHLxVkMdaxMEuiM7SZAVnsQarN2sdBAawmB
        LnwzwUa2T7Mw1DyeCVD1vWkW+tHuh24sd7rv9aEGfjlIGW/3EVSLcYRN3Ri9zKIG+vRUbWUu
        QdWVf0RZbhkIKj9riqCmrwwS1Kn6SkDV9bxP/V27iaodn8SieTFJu+JpmYLWBtAquVqRoIqL
        EBx8NfbF2BCpSBwsDkOhggCVLJmOEES+FB28P0HpaF4QkCpT6h1StEynE+zYvUur1qfQAfFq
        XUqEgNYolBqJRqiTJev0qjihik4JF4tEO0McxreS4s118+6abvm7n8+usA3AfigPcDiQlMCZ
        S755YA3Hk7QAuLI8wGIOcwDacttx5rAA4OK4CV/NGM7R5AEPh24Fjmw+4/kNwJHGWcIZYJHP
        wPyOJZbTT5BBsGeF45S9SSEctA+znX6cvMuG5t9LWM6AF/kKPDYzhjmZSwbDwlPFLIbXwa7z
        4y72IHfDR+2fuHg9uQVebezEnBdB0uIBc5fMrgAkI+Hi/MAT9oJ/ddazGebDPwuOP+E0aDpb
        QTDJ2QAah4yACeyBOd0Fri5xMh4O25MYeSMs6q52PQ4neTB/cRxjdC5s/mKVt8DvasoIhn3h
        zQeZBPNZFOxt4zIfNA3g15ceuReCzcb/9Wb8r5rRVUEIh4vOEgxvhlkNxThj8YPfPuYwuA3W
        tO4oA0Ql8KU1uuQ4WheiEavotH8nL1cn1wLXkmw/0AxG7swIbQDjABuAHFzgzeWmRyk8uQpZ
        +nu0Vh2r1StpnQ2EOMZ2Guevl6sdW6ZKiRVLwkQSqVQqCXtOKhb4cAMjuuSeZJwshU6iaQ2t
        Xc3DOB58A0ZcbDIZDEpbZsVnPvxeFu/wUi5aqD+neDs/9MH90gb/D9vnjzTczk4Nf7NII0t2
        C/qjaow3Wnc3Y/HED/7Wh9LjJkXqG0/HlHPN1e0Zm/JivK+c2F8/VDMYGLM1vXzrUNDzE1Nl
        k2H2THmi25z/kb4mHiofJhTmk+UneQa1MDvm2REOT9n7QUsA7/W0npzzPW7v7B2NkiWu8MRY
        2lHRU32hlb9O88luqiv/hdTSwBJuf9mhw/vWWiYWhBTuI8xo21Dq93PXBr5JF96EwpYk/ZZ1
        glav8NzRQDZHael57fLL8ONZRVV/nHnZqr5gLzr6OKEx8itr4r7rOzfeb05dW3FAwNLFy8Tb
        ca1O9g+wEbW/rQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSvG5Wv3uKwZJOJov1p44xWzRN+Mts
        sfpuP5vF68OfGC2mffjJbPH+4GNWiwf77S32vpvNanHzwE4miz2LJjFZrFx9lMli98KPTBZH
        /79ls5h06Bqjxd5b2hZ79p5ksbi8aw6bxfxlT9ktDk1uZrLY8aSR0WLd6/csFiduSVuc/3uc
        1UHc4/IVb49Z98+yeeycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHr3N79g83u+7yubR
        t2UVo8fm09UenzfJeWx68pYpgC+KyyYlNSezLLVI3y6BK+POuk7GgucJFQsmnmVvYJzs28XI
        wSEhYCJxo7Wgi5GLQ0hgN6PEzDefmLoYOYHikhLL/h5hhrCFJVb+e84OUfSEUeL+++msIAkW
        AVWJ3qN/WEAGsQloS5z+zwESFhHQk7h66wZYPbPAS3aJ3wsngQ0SFgiSmPBuHpjNK6ArMaFv
        NgvE0PeMEhfe90MlBCVOznzCAmIzC+hI7Nx6hw1kAbOAtMTyfxwQYXmJ5q2zwco5Bewkfu3v
        ASsXFVCWOLDtONMERqFZSCbNQjJpFsKkWUgmLWBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqX
        rpecn7uJEZwetDR3MG5f9UHvECMTB+MhRgkOZiURXt5K9xQh3pTEyqrUovz4otKc1OJDjNIc
        LErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamNizl86ck+Zx6WZ6RsZc9+dPC5fdmfxup2WK
        SWLH/vN9f/9G7M0RdZn3VMa5Q7ZUXVh+7VuVGTsKO7bdCbm03jLxbWB2ftmkmQkaotmT1weK
        MAnlCHuJhZ44Pc/4huvp5O1xdjZ/zA8c1AhJY9qqOuXT0oJPH//t2uwTxH/A2vB079Y5uQeM
        Vxny/RUPEFHUejjx+0LzpH1V3rF3D3bPmvlKR/vlxXeqijXHsj4JTouSnNvapMcRzRMmMbNf
        Y9edpAhjwWCNpHj74zsnLBVg9hWe6Tz98YN0DzXlji2CHzv3HDpumrPd+aHMrKgqRTmn+ZM0
        /CS50xbJ75XT/GfOZZ8mUO3cw5Rg63mx4iWLEktxRqKhFnNRcSIAIDigr34DAAA=
X-CMS-MailID: 20230425082930epcas5p1157cd2ebc608fe4d4247e8a7d860ba7c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----d4EnuX4PxHJ3dMseTbYmBkzD7TFyGjCVpggVcmKL0qRf9gu2=_43cbf_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081332epcas5p257c090a0d1ea6abf98416ca687f6c1e1
References: <20230411081041.5328-1-anuj20.g@samsung.com>
        <CGME20230411081332epcas5p257c090a0d1ea6abf98416ca687f6c1e1@epcas5p2.samsung.com>
        <20230411081041.5328-7-anuj20.g@samsung.com>
        <77ed029d-4058-b7f9-8dd1-6bc4b1c2b0dc@nvidia.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------d4EnuX4PxHJ3dMseTbYmBkzD7TFyGjCVpggVcmKL0qRf9gu2=_43cbf_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Apr 25, 2023 at 06:36:51AM +0000, Chaitanya Kulkarni wrote:
> On 4/11/23 01:10, Anuj Gupta wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> >
> > Add support for handling target command on target.
> 
> what is target command ?
> 
> command that you have added is :nvme_cmd_copy
>

acked. It was supposed to be nvme_cmd_copy.

> > For bdev-ns we call into blkdev_issue_copy, which the block layer
> > completes by a offloaded copy request to backend bdev or by emulating the
> > request.
> >
> > For file-ns we call vfs_copy_file_range to service our request.
> >
> > Currently target always shows copy capability by setting
> > NVME_CTRL_ONCS_COPY in controller ONCS.
> 
> there is nothing mentioned about target/loop.c in commit log ?
>

acked, will add the description for loop device.

> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c   |  9 +++--
> >   drivers/nvme/target/io-cmd-bdev.c | 58 +++++++++++++++++++++++++++++++
> >   drivers/nvme/target/io-cmd-file.c | 52 +++++++++++++++++++++++++++
> >   drivers/nvme/target/loop.c        |  6 ++++
> >   drivers/nvme/target/nvmet.h       |  1 +
> >   5 files changed, 124 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 80099df37314..978786ec6a9e 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -433,8 +433,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >   	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
> >   	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> >   	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
> > -			NVME_CTRL_ONCS_WRITE_ZEROES);
> > -
> > +			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
> >   	/* XXX: don't report vwc if the underlying device is write through */
> >   	id->vwc = NVME_CTRL_VWC_PRESENT;
> >   
> > @@ -536,6 +535,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
> >   
> >   	if (req->ns->bdev)
> >   		nvmet_bdev_set_limits(req->ns->bdev, id);
> > +	else {
> > +		id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
> > +		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
> > +				(PAGE_SHIFT - SECTOR_SHIFT));
> > +		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
> > +	}
> >   
> >   	/*
> >   	 * We just provide a single LBA format that matches what the
> > diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> > index c2d6cea0236b..0af273097aa4 100644
> > --- a/drivers/nvme/target/io-cmd-bdev.c
> > +++ b/drivers/nvme/target/io-cmd-bdev.c
> > @@ -46,6 +46,19 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
> >   	id->npda = id->npdg;
> >   	/* NOWS = Namespace Optimal Write Size */
> >   	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
> > +
> > +	/*Copy limits*/
> 
> above comment doesn't make any sense ...
>

acked, will remove it next version.

> > +	if (bdev_max_copy_sectors(bdev)) {
> > +		id->msrc = id->msrc;
> > +		id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
> > +				SECTOR_SHIFT) / bdev_logical_block_size(bdev));
> > +		id->mcl = cpu_to_le32(id->mssrl);
> > +	} else {
> > +		id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
> > +		id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
> > +				bdev_logical_block_size(bdev));
> > +		id->mcl = cpu_to_le32(id->mssrl);
> > +	}
> >   }
> >   
> >   void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
> > @@ -184,6 +197,19 @@ static void nvmet_bio_done(struct bio *bio)
> >   	nvmet_req_bio_put(req, bio);
> >   }
> >   
> > +static void nvmet_bdev_copy_end_io(void *private, int comp_len)
> > +{
> > +	struct nvmet_req *req = (struct nvmet_req *)private;
> > +
> > +	if (comp_len == req->copy_len) {
> > +		req->cqe->result.u32 = cpu_to_le32(1);
> > +		nvmet_req_complete(req, errno_to_nvme_status(req, 0));
> > +	} else {
> > +		req->cqe->result.u32 = cpu_to_le32(0);
> > +		nvmet_req_complete(req, blk_to_nvme_status(req, BLK_STS_IOERR));
> > +	}
> > +}
> > +
> 
> please reduce calls for nvmet_req_complete().
> 
> +static void nvmet_bdev_copy_end_io(void *private, int comp_len)
> +{
> +	struct nvmet_req *req = (struct nvmet_req *)private;
> +	u16 status;
> +
> +	if (comp_len == req->copy_len) {
> +		req->cqe->result.u32 = cpu_to_le32(1);
> +		status = errno_to_nvme_status(req, 0));
> +	} else {
> +		req->cqe->result.u32 = cpu_to_le32(0);
> +		status = blk_to_nvme_status(req, BLK_STS_IOERR));
> +	}
> +	nvmet_req_complete(req, status);
> +}
> +
>

makes sense, will modify this snippet.

> >   #ifdef CONFIG_BLK_DEV_INTEGRITY
> >   static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
> >   				struct sg_mapping_iter *miter)
> > @@ -450,6 +476,34 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
> >   	}
> >   }
> >   
> > +/* At present we handle only one range entry */
> 
> please add explanation why ...
>
Because we aligned copy offload similar to copy_file_range in out recent
revisions, discarding multi range support.
Sure we will update comments to reflect the same.

> > +static void nvmet_bdev_execute_copy(struct nvmet_req *req)
> > +{
> > +	struct nvme_copy_range range;
> > +	struct nvme_command *cmnd = req->cmd;
> 
> don't use cmnd, cmd is used everywhere and matches req->cmd,
> applies to everywhere in this patch...
> 

acked

> > +	int ret;
> 
> wrong return type is should be u16 since nvmet_copy_from_sgl()
> returns u16 if I remember correctly.
> 
> > +
> > +
> 

acked

> no extra white line between declaration and body of functions
>

acked

> > +	ret = nvmet_copy_from_sgl(req, 0, &range, sizeof(range));
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = blkdev_issue_copy(req->ns->bdev,
> > +		le64_to_cpu(cmnd->copy.sdlba) << req->ns->blksize_shift,
> > +		req->ns->bdev,
> > +		le64_to_cpu(range.slba) << req->ns->blksize_shift,
> > +		(le16_to_cpu(range.nlb) + 1) << req->ns->blksize_shift,
> > +		nvmet_bdev_copy_end_io, (void *)req, GFP_KERNEL);
> > +	if (ret) {
> > +		req->cqe->result.u32 = cpu_to_le32(0);
> > +		nvmet_req_complete(req, blk_to_nvme_status(req, BLK_STS_IOERR));
> > +	}
> > +
> > +	return;
> > +out:
> > +	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
> > +}
> > +
> 
> again one call to nvmet_req_complete() can do the same job.
> consider following totally untested  :-
> /* TODO: add detailed comment here why you support one range ? */
> static void nvmet_bdev_execute_copy(struct nvmet_req *req)
> {
>          u32 blkshift = req->ns->blksize_shift;
>          struct nvme_command *cmnd = req->cmd;
>          struct nvme_copy_range range;
>          u16 status;
> 
>          status = nvmet_copy_from_sgl(req, 0, &range, sizeof(range));
>          if (status) {
>                  goto out;
>          }
> 
>          ret = blkdev_issue_copy(req->ns->bdev,
>                                  le64_to_cpu(cmnd->copy.sdlba) << blkshift,
>                                  req->ns->bdev,
>                                  le64_to_cpu(range.slba) << blksize_shift,
>                                  (le16_to_cpu(range.nlb) + 1) << 
> blksize_shift,
>                                  nvmet_bdev_copy_end_io, (void *)req, 
> GFP_KERNEL);
>          if (ret) {
>                  req->cqe->result.u32 = cpu_to_le32(0);
>                  status = blk_to_nvme_status(req, BLK_STS_IOERR);
> out:
>                  nvmet_req_complete(req, status);
>          }
> }
> 

acked, thanks for sharing the snippet

> >   u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
> >   {
> >   	switch (req->cmd->common.opcode) {
> > @@ -468,6 +522,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
> >   	case nvme_cmd_write_zeroes:
> >   		req->execute = nvmet_bdev_execute_write_zeroes;
> >   		return 0;
> > +	case nvme_cmd_copy:
> > +		req->execute = nvmet_bdev_execute_copy;
> > +		return 0;
> > +
> >   	default:
> >   		return nvmet_report_invalid_opcode(req);
> >   	}
> > diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> > index 2d068439b129..69f198ecec77 100644
> > --- a/drivers/nvme/target/io-cmd-file.c
> > +++ b/drivers/nvme/target/io-cmd-file.c
> > @@ -322,6 +322,49 @@ static void nvmet_file_dsm_work(struct work_struct *w)
> >   	}
> >   }
> >   
> > +static void nvmet_file_copy_work(struct work_struct *w)
> > +{
> > +	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
> > +	int nr_range;
> > +	loff_t pos;
> > +	struct nvme_command *cmnd = req->cmd;
> > +	int ret = 0, len = 0, src, id;
> 
> reverse tree style for declaration ...
> 

acked

> > +
> > +	nr_range = cmnd->copy.nr_range + 1;
> > +	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
> 
> you have a cmd variable above and you are still using req->cmd ?
> why create a variable on stack then ? u don't need that variable
> anyways...
>

acked

> > +	if (unlikely(pos + req->transfer_len > req->ns->size)) {
> > +		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
> > +		return;
> > +	}
> > +
> > +	for (id = 0 ; id < nr_range; id++) {
> > +		struct nvme_copy_range range;
> > +
> > +		ret = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
> > +					sizeof(range));
> > +		if (ret)
> > +			goto out;
> > +
> > +		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
> > +		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
> > +		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file,
> > +					pos, len, 0);
> 
> 5th paramaeter to vfs_copy_file_range() is size_t you have used int
> for len ? also
> vfs_copy_file_range() returns ssize_t you are catching it in int ?
>

acked, will change it to ssize_t.

> > +out:
> > +		if (ret != len) {
> > +			pos += ret;
> > +			req->cqe->result.u32 = cpu_to_le32(id);
> > +			nvmet_req_complete(req, ret < 0 ?
> > +					errno_to_nvme_status(req, ret) :
> > +					errno_to_nvme_status(req, -EIO));
> 
> again plz don't add multiple nvmet_req_complete() calls
>

acked

> > +			return;
> > +
> > +		} else
> > +			pos += len;
> > +	}
> > +
> > +	nvmet_req_complete(req, 0);
> > +
> > +}
> 
> wrt above comments consider following totally untested :-
> 
> static void nvmet_file_copy_work(struct work_struct *w)
> {
>          struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
>          int nr_range = req->cmd->copy.nr_range + 1;
>          u16 status = 0;
>          int src, id;
>          ssize_t ret;
>          size_t len;
>          loff_t pos;
> 
>          pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
>          if (unlikely(pos + req->transfer_len > req->ns->size)) {
>                  nvmet_req_complete(req, errno_to_nvme_status(req, 
> -ENOSPC));
>                  return;
>          }
> 
>          for (id = 0 ; id < nr_range; id++) {
>                  struct nvme_copy_range range;
> 
>                  status = nvmet_copy_from_sgl(req, id * sizeof(range), 
> &range,
>                                          sizeof(range));
>                  if (status)
>                          goto out;
> 
>                  src = (le64_to_cpu(range.slba) << 
> (req->ns->blksize_shift));
>                  len = (le16_to_cpu(range.nlb) + 1) << 
> (req->ns->blksize_shift);
> 
>                  ret = vfs_copy_file_range(req->ns->file, src, 
> req->ns->file,
>                                          pos, len, 0);
> 
>                  if (ret != len) {
>                          req->cqe->result.u32 = cpu_to_le32(id);
>                          if (ret < 0)
>                                  status = errno_to_nvme_status(req, ret);
>                          else
>                                  status = errno_to_nvme_status(req, -EIO);
>                          goto out;
>                  }
>                  pos += ret;
>          }
> out:
>          nvmet_req_complete(req, status);
> }
> 
>

Thanks for snippet will update this in next version.
--
Nitesh Shetty

------d4EnuX4PxHJ3dMseTbYmBkzD7TFyGjCVpggVcmKL0qRf9gu2=_43cbf_
Content-Type: text/plain; charset="utf-8"


------d4EnuX4PxHJ3dMseTbYmBkzD7TFyGjCVpggVcmKL0qRf9gu2=_43cbf_--
