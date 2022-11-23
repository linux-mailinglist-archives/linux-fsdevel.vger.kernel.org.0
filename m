Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56905635C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiKWMNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 07:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiKWMNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:13:52 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C59E98
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:13:50 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221123121347epoutp037d6305e187b24201d0dda71da87a165b~qNayyhVdi0307003070epoutp03n
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 12:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221123121347epoutp037d6305e187b24201d0dda71da87a165b~qNayyhVdi0307003070epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669205627;
        bh=AEB9aQViCL6lHuTz1oSexRbvesKx+Nv+v6B7olpRQsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KBdKpBFeGBcWmGWOOCEwc8KpOGSmjBH8QJr8UWcfeQTl4wQIbqoFnTOFYi4ZosPbR
         ge2Q+bQh3L9DfGB1remHfLhja/bxtaMj2h+vgNQdBiojFur3d6v40R24JqvNsOlS8b
         GFIr1HJRF6kQ5LZRqN+a/e4sO+0YsxtL5HiQP/r0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221123121346epcas5p27e8a210b1d5d58d29f70054e9bcf62ab~qNaxiqq473009530095epcas5p2j;
        Wed, 23 Nov 2022 12:13:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NHKm829xrz4x9Pp; Wed, 23 Nov
        2022 12:13:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.35.39477.87E0E736; Wed, 23 Nov 2022 21:13:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221123095047epcas5p1ae1143d6f36df2887dc6d0e89e0a3296~qLd75q69K2353123531epcas5p1I;
        Wed, 23 Nov 2022 09:50:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123095047epsmtrp27172fc6e6ab539e4aea9cb2292b33c37~qLd73Wqop0501205012epsmtrp2J;
        Wed, 23 Nov 2022 09:50:47 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-7b-637e0e78390c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.3D.18644.7FCED736; Wed, 23 Nov 2022 18:50:47 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123095044epsmtip297accf117a7980fa5c8ce38286643dea~qLd48Wj5X3271432714epsmtip2g;
        Wed, 23 Nov 2022 09:50:44 +0000 (GMT)
Date:   Wed, 23 Nov 2022 15:09:24 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 06/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <20221123093924.GA31595@test-zns>
MIME-Version: 1.0
In-Reply-To: <482586a3-f45d-a17b-7630-341fb0e1ee96@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPfeW2wsbeq0gh7IhK1kmKEgR6mWDaXgsV+cMGWPLhIU17V1h
        wG1pCyoSqAOygfISyVwxDtzYeBjIkPGuA4TxkIeIFAthQARlGkFAJo4Ia7ll4b/P73u+3/x+
        53dycJRXzOXjUYyaVjLiGAFmxam95eLidnp7ssTj0eTrZFXPnyj5Te4rlKwYz8HI1b4BlNTN
        FVqQhpYGhCyr6EDIpuIFhOxYf4qRU89HOWR+ZjcgL7bpATkzrEVI3eg+slnXzSGHGq9g5I+/
        zHDJvM4bFmT99DlALpWkccnKJ/McsmvUgRx41WlxxI7STvRhVIN2nEsN/PUbhxrqi6eqyzOM
        0pQPdePnFKrJoMGorNQ5o5I+YUHN3xzGqOyackAtVTtS37acR6jq6adI8I6T0b6RtFhKK51o
        RiKXRjEyP8GHIREBEd4iD6Gb0Ic8JHBixLG0nyDweLDbB1Exxh0InBLEMfFGKVisUgkOvO+r
        lMeraadIuUrtJ6AV0hiFl8JdJY5VxTMyd4ZWvyv08PD0Nhq/jI68O/aa4lLo6f6Sh1wNuBuQ
        CSxxSHjBMX0NZmIe0QTgSAk/E1gZeRHA+cIZlC2WAGwoqkM3E2Wld8wHjQCOaQswtngI4My1
        rg0Xh3gbjuU/52QCHMeIffD2Om6SbYi9cDy/BpgYJTQcOGMgTJZdxCfw73lbE1oTbvDqoNTk
        sCZ2wu4fpjkmtiSC4PLszY1BbQln2FLbiZi6QuKWJczOegzY2QLhbF+qec5d8HFnDZdlPlya
        02Esn4Jll0oxNpwGoHZEaw4fhuk9OSg7WySs7Js0h9+EBT2VCKtvh1mr0wirW8P6q5vsDK9X
        FZkb2EP9i3NmpmC7/nuE3c+/AC5f60RywR7tlttpt/TTGheAEi6wqvEAK++Bqb8XoqzsAH9d
        w7c4igBWDuxphSpWRqu8FZ4Mfer/l5fIY6vBxl9xPVYPpiafubcBBAdtAOKowMY65WiShGct
        FZ9JpJXyCGV8DK1qA97GV8tD+bYSufGzMeoIoZePh5dIJPLyOSgSCuysf7rsKuERMrGajqZp
        Ba3czCG4JV+D5ON583k7HrSHOOa2Lob1+nc12fFs9LXyunRDRlza7Fcfl0gbo3bvXnEsuHN2
        wv+YaLr3xHj/R7ojsn8W6rIuM4lnQr2XmwPVDfHLDFK68/OS9TWvT5OtYven9dTPnUiPG3w0
        CJmI4/RbreEuvtHV94P7p7QvrjhHC18OF2gk4W6a1ncCPiseSvsuaCC4ZlQhLU6VjuQ53v7D
        IagqATjLDh+9MMp9GZZk9UYNbLyXUbBt0X/FYK9PCS0bvNiBZ/PutW+zwsLcdE+4SysVYfJK
        /jPPr/c2dyYlD/kvHkQS9xsSg052zCTg2eFrvbEeDgtxORfOavTvGe4f+iKE+2D1elW2gKOK
        FAtdUaVK/B/Hwv8RtAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45OzsuVqeZ9amZNdHCappZfVlUEtrpBhVBJQtbejDJTdtm
        96HZXVlqEtY0s6x2EQvNlmWWzNSZTO1ioaYmzTK7LNEulHM5R+R/P57n4cf7x0vhggHCi4qX
        KVm5TJIgJHmEsUboO//nZ1VM8Kme6ej20zocpWXZcVTcmUmiP5ZmHFV9zeOgtur7GNIX12Ko
        8uoAhmodX0jUM9ROoJz0BoDOm14B1NuqwVBV+1z0sKqBQC8e5JPoys1eLsquv8NBFdZjAA3e
        OMFFtz7ZCGRu90bN9nrOqmmMpttCMvc1nVymuauUYF5Ykpkyw9nRqGcpc+d6ClPZlkoy6uNf
        R5OT3RzG9qiVZM6VGwAzWDaDOV2dgTFl1i/YpklRvOWxbEL8flYetGIXb88bg5mTZNxy8KXW
        QaaCrPB04EZBOhTqdS14OuBRAroCwDrTZ46r8IQ37U9wF7tD/cgHrmtkBTB3UEc4C4L2hx05
        Q6NMUSQ9FzY6KGc8hZ4DO3PKgXOP02kELHjVQTo37vRW+NHm4UQ+PR8WPIt1KX8DaCotGVPy
        6cmw4ZJ1jHF6NhwueI479zjtDbUjlCv2hcfv5o2d5kZHwO99j0gne9B+sNpYj2UBgWacSTPO
        pPlv0owzFQLCADzZJIU0TqpYkBQiYw+IFBKpIlkWJ4pJlJaBsa8IDKwADw3fRCaAUcAEIIUL
        p/BT1h6NEfBjJYcOs/LEaHlyAqswAW+KEE7jt6Q3RAvoOImS3cuySaz8X4tRbl6pmIr1DVE3
        RQWEXAw7pszEbRFeomHVTBXy2Tn8qzhYatthXZJGLF+zTuXRqi3UbpzV1M095U+UXkm9bG+a
        +KYxuGbZohJvpSMxck5F5+aol+sziiI9JxSNGIOK3y0Wv450dJ9LuOavU5mnrs8/UQSG3529
        Wz5gCY/ok9Fs9vk14l0pOn182GPK56RiRREUH9nS1dWvnrcXiH9sz13cMWQKXclp7Bf52Un7
        79DCy+tW79a9X7iv7m3AUveW1YE2bUaT+cKtAOGSaIfSU+23VRmmvvcgv8a4UXnIN/4Mg1p8
        Tmda7crgtpCSIZGdU1my7XWz/rHFzNsQHnngmti/pjdOSCj2SBYE4nKF5C88pAyphAMAAA==
X-CMS-MailID: 20221123095047epcas5p1ae1143d6f36df2887dc6d0e89e0a3296
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_666e9_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061031epcas5p3745558c2caffd2fd21d15feff00495e9
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061031epcas5p3745558c2caffd2fd21d15feff00495e9@epcas5p3.samsung.com>
        <20221123055827.26996-7-nj.shetty@samsung.com>
        <482586a3-f45d-a17b-7630-341fb0e1ee96@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_666e9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Nov 23, 2022 at 04:17:41PM +0800, Guixin Liu wrote:
> 
> 在 2022/11/23 13:58, Nitesh Shetty 写道:
> > Add support for handling target command on target.
> > For bdev-ns we call into blkdev_issue_copy, which the block layer
> > completes by a offloaded copy request to backend bdev or by emulating the
> > request.
> > 
> > For file-ns we call vfs_copy_file_range to service our request.
> > 
> > Currently target always shows copy capability by setting
> > NVME_CTRL_ONCS_COPY in controller ONCS.
> > 
> > Signed-off-by: Nitesh Shetty<nj.shetty@samsung.com>
> > Signed-off-by: Anuj Gupta<anuj20.g@samsung.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c   |  9 +++-
> >   drivers/nvme/target/io-cmd-bdev.c | 79 +++++++++++++++++++++++++++++++
> >   drivers/nvme/target/io-cmd-file.c | 51 ++++++++++++++++++++
> >   drivers/nvme/target/loop.c        |  6 +++
> >   drivers/nvme/target/nvmet.h       |  2 +
> >   5 files changed, 145 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index c8a061ce3ee5..5ae509ff4b19 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -431,8 +431,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >   	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
> >   	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> >   	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
> > -			NVME_CTRL_ONCS_WRITE_ZEROES);
> > -
> > +			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
> >   	/* XXX: don't report vwc if the underlying device is write through */
> >   	id->vwc = NVME_CTRL_VWC_PRESENT;
> > @@ -534,6 +533,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
> >   	if (req->ns->bdev)
> >   		nvmet_bdev_set_limits(req->ns->bdev, id);
> > +	else {
> > +		id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
> > +		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
> > +				(PAGE_SHIFT - SECTOR_SHIFT));
> > +		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
> > +	}
> >   	/*
> >   	 * We just provide a single LBA format that matches what the
> > diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> > index c2d6cea0236b..01f0160125fb 100644
> > --- a/drivers/nvme/target/io-cmd-bdev.c
> > +++ b/drivers/nvme/target/io-cmd-bdev.c
> > @@ -46,6 +46,19 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
> >   	id->npda = id->npdg;
> >   	/* NOWS = Namespace Optimal Write Size */
> >   	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
> > +
> > +	/*Copy limits*/
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
> 
> Based on my understanding of the NVMe protocol 2.0,  the mssrl is the max
> length per single range entry,
> 
> the mcl is the total max copy length in one copy command, may I ask why mcl
> = msssrl? not mcl = mssrl * msrc?
> 
> Best Regards,
> 
> Guixin Liu
>

You are right, as per NVMe spec, mcl >= mssrl. Since we decided to make
copy offload generic for NVMe/Xcopy/copy across namespaces and all, we went
with 2 bio/bdev design, which is compatible with device mapper.
So effectively we are using 1 range(msrc), when using only 1 range, I
feel it makes sense to use one of the limits, so went with mssrl.

Thanks,
Nitesh

> >   }
> >   void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
> > @@ -184,6 +197,23 @@ static void nvmet_bio_done(struct bio *bio)
> >   	nvmet_req_bio_put(req, bio);
> >   }
> > +static void nvmet_bdev_copy_end_io(void *private, int status)
> > +{
> > +	struct nvmet_req *req = (struct nvmet_req *)private;
> > +	int id;
> > +
> > +	if (status) {
> > +		for (id = 0 ; id < req->nr_range; id++) {
> > +			if (req->ranges[id].len != req->ranges[id].comp_len) {
> > +				req->cqe->result.u32 = cpu_to_le32(id);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +	kfree(req->ranges);
> > +	nvmet_req_complete(req, errno_to_nvme_status(req, status));
> > +}
> > +
> >   #ifdef CONFIG_BLK_DEV_INTEGRITY
> >   static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
> >   				struct sg_mapping_iter *miter)
> > @@ -450,6 +480,51 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
> >   	}
> >   }
> > +static void nvmet_bdev_execute_copy(struct nvmet_req *req)
> > +{
> > +	struct nvme_copy_range range;
> > +	struct range_entry *ranges;
> > +	struct nvme_command *cmnd = req->cmd;
> > +	sector_t dest, dest_off = 0;
> > +	int ret, id, nr_range;
> > +
> > +	nr_range = cmnd->copy.nr_range + 1;
> > +	dest = le64_to_cpu(cmnd->copy.sdlba) << req->ns->blksize_shift;
> > +	ranges = kmalloc_array(nr_range, sizeof(*ranges), GFP_KERNEL);
> > +
> > +	for (id = 0 ; id < nr_range; id++) {
> > +		ret = nvmet_copy_from_sgl(req, id * sizeof(range),
> > +					&range, sizeof(range));
> > +		if (ret)
> > +			goto out;
> > +
> > +		ranges[id].dst = dest + dest_off;
> > +		ranges[id].src = le64_to_cpu(range.slba) <<
> > +					req->ns->blksize_shift;
> > +		ranges[id].len = (le16_to_cpu(range.nlb) + 1) <<
> > +					req->ns->blksize_shift;
> > +		ranges[id].comp_len = 0;
> > +		dest_off += ranges[id].len;
> > +	}
> > +	req->ranges = ranges;
> > +	req->nr_range = nr_range;
> > +	ret = blkdev_issue_copy(req->ns->bdev, req->ns->bdev, ranges, nr_range,
> > +			nvmet_bdev_copy_end_io, (void *)req, GFP_KERNEL);
> > +	if (ret) {
> > +		for (id = 0 ; id < nr_range; id++) {
> > +			if (ranges[id].len != ranges[id].comp_len) {
> > +				req->cqe->result.u32 = cpu_to_le32(id);
> > +				break;
> > +			}
> > +		}
> > +		goto out;
> > +	} else
> > +		return;
> > +out:
> > +	kfree(ranges);
> > +	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
> > +}
> > +
> >   u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
> >   {
> >   	switch (req->cmd->common.opcode) {
> > @@ -468,6 +543,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
> > index 64b47e2a4633..a81d38796e17 100644
> > --- a/drivers/nvme/target/io-cmd-file.c
> > +++ b/drivers/nvme/target/io-cmd-file.c
> > @@ -338,6 +338,48 @@ static void nvmet_file_dsm_work(struct work_struct *w)
> >   	}
> >   }
> > +static void nvmet_file_copy_work(struct work_struct *w)
> > +{
> > +	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
> > +	int nr_range;
> > +	loff_t pos;
> > +	struct nvme_command *cmnd = req->cmd;
> > +	int ret = 0, len = 0, src, id;
> > +
> > +	nr_range = cmnd->copy.nr_range + 1;
> > +	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
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
> > +out:
> > +		if (ret != len) {
> > +			pos += ret;
> > +			req->cqe->result.u32 = cpu_to_le32(id);
> > +			nvmet_req_complete(req, ret < 0 ?
> > +					errno_to_nvme_status(req, ret) :
> > +					errno_to_nvme_status(req, -EIO));
> > +			return;
> > +
> > +		} else
> > +			pos += len;
> > +}
> > +	nvmet_req_complete(req, ret);
> > +
> > +}
> >   static void nvmet_file_execute_dsm(struct nvmet_req *req)
> >   {
> >   	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
> > @@ -346,6 +388,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
> >   	queue_work(nvmet_wq, &req->f.work);
> >   }
> > +static void nvmet_file_execute_copy(struct nvmet_req *req)
> > +{
> > +	INIT_WORK(&req->f.work, nvmet_file_copy_work);
> > +	queue_work(nvmet_wq, &req->f.work);
> > +}
> > +
> >   static void nvmet_file_write_zeroes_work(struct work_struct *w)
> >   {
> >   	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
> > @@ -392,6 +440,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
> >   	case nvme_cmd_write_zeroes:
> >   		req->execute = nvmet_file_execute_write_zeroes;
> >   		return 0;
> > +	case nvme_cmd_copy:
> > +		req->execute = nvmet_file_execute_copy;
> > +		return 0;
> >   	default:
> >   		return nvmet_report_invalid_opcode(req);
> >   	}
> > diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> > index b45fe3adf015..55802632b407 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -146,6 +146,12 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   		return ret;
> >   	blk_mq_start_request(req);
> > +	if (unlikely((req->cmd_flags & REQ_COPY) &&
> > +				(req_op(req) == REQ_OP_READ))) {
> > +		blk_mq_set_request_complete(req);
> > +		blk_mq_end_request(req, BLK_STS_OK);
> > +		return BLK_STS_OK;
> > +	}
> >   	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
> >   	iod->req.port = queue->ctrl->port;
> >   	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index dfe3894205aa..3b4c7d2ee45d 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -391,6 +391,8 @@ struct nvmet_req {
> >   	struct device		*p2p_client;
> >   	u16			error_loc;
> >   	u64			error_slba;
> > +	struct range_entry *ranges;
> > +	unsigned int nr_range;
> >   };
> >   extern struct workqueue_struct *buffered_io_wq;

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_666e9_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_666e9_--
