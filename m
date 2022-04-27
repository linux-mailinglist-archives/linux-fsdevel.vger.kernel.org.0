Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD82510EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357273AbiD0CwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 22:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357267AbiD0CwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:52:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3ECDB2F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651027748; x=1682563748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWpU0HwIqdFrg2zx3TJihfa/upjaFNfHL6fd3w+flV4=;
  b=Ux/W3TlTkiagYd/6vb/jiVYXnsSRDsoh1aRzciyY4EDX+sQLNKZCZ4lo
   djJHQdfKZP2pnT18MjvUwiuMT1QN1TRV+LBL4jNFUWEg+OTpYiLIpKg7S
   iXrjMzYdyBED2r20YUiZn9RoEkjHh3C0mYKRlcZ/a6D/OPeeBuE7vYd4+
   eWapqx48bYiVfSKPGEduwIm/t0rsJ45wL4MUIIVzU0tdOpmbRGPYaJJMr
   BDEz/JRqPzef3qy9MqB8VeyuHKZyyWNNPVQ3/7rNP2OYvbqbsAuN5ppcg
   e2ssyXVfJSz6Ch5XEHZJEu9NwQHLrUaAkJYYjfSQje2wJSfK3NEDQ2sPX
   w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="198912065"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 10:49:06 +0800
IronPort-SDR: CMGgDr22mzdhMTO19AK3jMrnLXfCoODl0965f88xKRAW0IsHmnj2x1dw0dRa3t0J2bhLwNOc+S
 PYWlXrEHEVz/zekdHRm3e81cuE72mv3ErQT/x8laal7RjwnDt28cRsvwPvALdqddmGeIZ/Z6lF
 0UOg0Xx0ivnXPEg5VyH2G0VleyIur9wBJOzTXP/KJYU7uGBmjbVc87Fm2zrx+Q+MfY5+c+DzLJ
 36nweShNCve643SVvH+YJluHxTCKrVv06ssWRZm7ybQqkGVTonQrjam64ezrVDSRzDxSx28u9w
 vGqUXt9tRiuEz59yCZY0uPFc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 19:20:00 -0700
IronPort-SDR: 5LozqLlqnEKYhaIZm28Ts0x648OfyV08++e72+hpXmUte8MkO6mFueWbMSOve1clBql7aChP4X
 DY2TFex32sCs4BiuLETuVTlKt+AfeGE//oN5n8jnsPg+mSrS3e6reDsx8OAX/bwtXoRqtNuc64
 nc3Hyd4Y0GKakERRfr7W/Ueiabn4OoW01aB7oBXhZhtJF4yrKSgiz7bgJeQcZzVcu9EpljtiG9
 fVYJPpHSz7tYA9JA4fq8s3jRFG5la90zw8GPN5WXFB7AalhKDxX1IxMRlZEgVHfkYJdOx2qIyt
 lak=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 19:49:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp39Z3t2Wz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 19:49:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651027745; x=1653619746; bh=iWpU0HwIqdFrg2zx3TJihfa/upjaFNfHL6f
        d3w+flV4=; b=hikYTurwappRrrZasDTrqUqmKOTuKu4rZvUNZjPAd1cl9dkwlq/
        m2Sa9DPyXNi3xu6jhSuIOCnmz1HjekfSujLBC8Vzwj+VpHXxKwTa0kHl3cC6q4I/
        vnebs5mXEBMfWil0VWD7Aliqzov5gJfUIOuG8BMSxpnxmXzqLSESCpAsTlPy26QP
        XVwKEGJVnLpYvh1n7JAKbFMbo2+O962s9G7/+vWFGFYAQfeC+S5aTobuLNYzvtsm
        0hjcJOJFy01d0didhwDTvIOJY4NO8/OUayXwuqJfYagWh55n9Tco6gfvUlI1N9d4
        i1TD2XJ7QSFZG2GpfC0R35CGnj2voYJyncg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PltdNIdbllyU for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 19:49:05 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp39Q3MMrz1Rvlc;
        Tue, 26 Apr 2022 19:48:58 -0700 (PDT)
Message-ID: <513edc25-1c73-6c85-9a50-0e267a106ec0@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 11:48:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 03/10] block: Introduce a new ioctl for copy
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
 <20220426101241.30100-4-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> Add new BLKCOPY ioctl that offloads copying of one or more sources rang=
es
> to one or more destination in a device. COPY ioctl accepts a 'copy_rang=
e'
> structure that contains no of range, a reserved field , followed by an
> array of ranges. Each source range is represented by 'range_entry' that
> contains source start offset, destination start offset and length of
> source ranges (in bytes)
>=20
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
>=20
> Example code, to issue BLKCOPY:
> /* Sample example to copy three entries with [dest,src,len],
> * [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device=
 */
>=20
> int main(void)
> {
> 	int i, ret, fd;
> 	unsigned long src =3D 0, dst =3D 32768, len =3D 4096;
> 	struct copy_range *cr;
> 	cr =3D (struct copy_range *)malloc(sizeof(*cr)+
> 					(sizeof(struct range_entry)*3));
> 	cr->nr_range =3D 3;
> 	cr->reserved =3D 0;
> 	for (i =3D 0; i< cr->nr_range; i++, src +=3D len, dst +=3D len) {
> 		cr->range_list[i].dst =3D dst;
> 		cr->range_list[i].src =3D src;
> 		cr->range_list[i].len =3D len;
> 		cr->range_list[i].comp_len =3D 0;
> 	}
> 	fd =3D open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 	ret =3D ioctl(fd, BLKCOPY, cr);
> 	if (ret !=3D 0)
> 	       printf("copy failed, ret=3D %d\n", ret);
> 	for (i=3D0; i< cr->nr_range; i++)
> 		if (cr->range_list[i].len !=3D cr->range_list[i].comp_len)
> 			printf("Partial copy for entry %d: requested %llu, completed %llu\n"=
,
> 								i, cr->range_list[i].len,
> 								cr->range_list[i].comp_len);
> 	close(fd);
> 	free(cr);
> 	return ret;
> }

Nice to have a code example. But please format it correctly.

>=20
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  9 +++++++++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 46949f1b0dba..58d93c20ff30 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -120,6 +120,36 @@ static int blk_ioctl_discard(struct block_device *=
bdev, fmode_t mode,
>  	return err;
>  }
> =20
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	struct copy_range crange, *ranges =3D NULL;
> +	size_t payload_size =3D 0;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >=
=3D MAX_COPY_NR_RANGE))
> +		return -EINVAL;
> +
> +	payload_size =3D (crange.nr_range * sizeof(struct range_entry)) + siz=
eof(crange);
> +
> +	ranges =3D memdup_user((void __user *)arg, payload_size);
> +	if (IS_ERR(ranges))
> +		return PTR_ERR(ranges);
> +
> +	ret =3D blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list,=
 bdev, GFP_KERNEL);
> +	if (copy_to_user((void __user *)arg, ranges, payload_size))
> +		ret =3D -EFAULT;
> +
> +	kfree(ranges);
> +	return ret;
> +}
> +
>  static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t m=
ode,
>  		void __user *argp)
>  {
> @@ -481,6 +511,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,
>  		return blk_ioctl_discard(bdev, mode, arg);
>  	case BLKSECDISCARD:
>  		return blk_ioctl_secure_erase(bdev, mode, argp);
> +	case BLKCOPY:
> +		return blk_ioctl_copy(bdev, mode, arg);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
>  	case BLKGETDISKSEQ:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 822c28cebf3a..a3b13406ffb8 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -78,6 +78,14 @@ struct range_entry {
>  	__u64 comp_len;
>  };
> =20
> +struct copy_range {
> +	__u64 nr_range;
> +	__u64 reserved;
> +
> +	/* Range_list always must be at the end */
> +	struct range_entry range_list[];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl defin=
itions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -199,6 +207,7 @@ struct fsxattr {
>  #define BLKROTATIONAL _IO(0x12,126)
>  #define BLKZEROOUT _IO(0x12,127)
>  #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> +#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
>  /*
>   * A jump here: 130-136 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)


--=20
Damien Le Moal
Western Digital Research
