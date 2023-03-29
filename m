Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D926CF79B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjC2Xo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjC2Xo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:44:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF359EA
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133496; x=1711669496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u0GDcNaX/W8JMXWCJKoDWEVkmUM3b9b6zaDxlqDnkVw=;
  b=G6Td+963/JyehEu6hkbdK9WQj8vA4porxCkWc0lxjphYbF91Op+I05Te
   oR5B6jxRvsy56poSra/+q8GbDABMVqY+jkOW1CL17GmCm783BMY28oHrN
   ZMsHI3ebJGxtAlqa/ATBaIkTWh/WId9RydV/jfNkZ+VkZcodO8O4IZtaJ
   al70WO/R+8a+tJL2f5CnoVXmiSQxDdpsRF1DezDUy6XOpwLrH57X+iYPD
   qT9/sUgRBdiYfmdtXvOD+gVCQQOOo1EUUgWTCOH8il3fdSHiaEm7kcWuI
   XF+Cp5rlvvgm8IG0fYYZ5hCAAsJ/N288qKqpBDH7y6K0pZmplVrCaYRk4
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="231809209"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:44:54 +0800
IronPort-SDR: vDdO5azd4iFUDj1c0DRCBksKiiTPRuT2frPi2qMWTZ/V/khiesMooUnlrK1UCzMagx3FIu7GI5
 GbVtDXaS4mHG4PDZP+Wg3HOq/QCa+zhzjfjRzWXHojnGm5YCR9Pfs5zawUcMGSF16/wLRcxuiQ
 kylw2tPt395g92HTrGS6Iuh3upZMFhauxILo+NOFZC9ClmiI0/jzqfLczHwpCxo3g/tg7SdEc0
 Mr2arlFjiO2lk8GI20rJ0ZI3no2FSameC21qDb4mNUHoPifTFP4GnWwKTLxN7xe55Q67IEXakc
 oN0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:55:22 -0700
IronPort-SDR: bycw1M6qFJ+TuacUfCLhuqFtygpQdJEh7+8Po+/j79q1od4e4vpVN7zdZ8ICK9xX1sHQCLL3eS
 vahYXnveyJwxhuq/L5rKjkSpoWnifQoRV7nO6pSTdQx9rBtnCEI7BbEP3aDcMtEGMr8+iiaVWG
 jGukR9mhKuW0ib3uSVRV7oFJBnBbFByKiS0sqcosxaMjAiX8V/MRyzV1n/ktvi8vU8FqiBwmCI
 Qww+W9NKvrTWnAzi0SGbFuRZPNlugDYB90hWtq63WBdl+FVuhpHjOG+MZrwqAwi9pMN8uDEUwn
 SIA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:44:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn37V1D3Sz1RtVq
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:44:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133493; x=1682725494; bh=u0GDcNaX/W8JMXWCJKoDWEVkmUM3b9b6zaD
        xlqDnkVw=; b=WJwHtYrK6cUOnM+VnT2jk5Mfr9s+niCpSB91nLIFGLw/LjRfqcW
        GRtXZX0oNrclBM2DNqkfcN1YnFfPWuu/3uuAiMyg6eEX9uS5WBiVLgV9C6Ke42ZK
        sNUd/Lk5FfOR9zoOwGw7vK+DMyEaf2Nh0lL3bn8kozM/PN+xGk5WNaeUFSQ495xC
        m3+jka4S3ZMzCjQe3PM51ILvGOxvEmWs3/fMbR5qgYcBILZP5srr/7uJBCJ/wroY
        l5et31OLQyU2xAAJhnAa2WINaElfod/eSSF/6/UGnt6ktk+ryZDvO9cNcRcPdUkr
        t/WELvtWnaTu/lmB1JoHwqRo2E4mbuCyI8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p-NvYHzi7S3x for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:44:53 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn37P0nXXz1RtVm;
        Wed, 29 Mar 2023 16:44:48 -0700 (PDT)
Message-ID: <7441afa8-3e60-79cf-66c7-4ddb692c1bcd@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:44:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 17/19] md: raid1: check if adding pages to resync bio
 fails
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <e2f96e539befa4f9d57f19ff1fc26cfc0d109435.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e2f96e539befa4f9d57f19ff1fc26cfc0d109435.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 02:06, Johannes Thumshirn wrote:
> Check if adding pages to resync bio fails and if bail out.
> 
> As the comment above suggests this cannot happen, WARN if it actually
> happens.
> 
> This way we can mark bio_add_pages as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/md/raid1-10.c |  7 ++++++-
>  drivers/md/raid10.c   | 12 ++++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index e61f6cad4e08..c21b6c168751 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
>  		 * won't fail because the vec table is big
>  		 * enough to hold all these pages
>  		 */
> -		bio_add_page(bio, page, len, 0);
> +		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {

Not sure we really need the WARN_ON here...
Nevertheless,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> +			bio->bi_status = BLK_STS_RESOURCE;
> +			bio_endio(bio);
> +			return;
> +		}
> +
>  		size -= len;
>  	} while (idx++ < RESYNC_PAGES && size > 0);
>  }
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6c66357f92f5..5682dba52fd3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3808,7 +3808,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>  			 * won't fail because the vec table is big enough
>  			 * to hold all these pages
>  			 */
> -			bio_add_page(bio, page, len, 0);
> +			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +				bio->bi_status = BLK_STS_RESOURCE;
> +				bio_endio(bio);
> +				goto giveup;
> +			}
>  		}
>  		nr_sectors += len>>9;
>  		sector_nr += len>>9;
> @@ -4989,7 +4993,11 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>  			 * won't fail because the vec table is big enough
>  			 * to hold all these pages
>  			 */
> -			bio_add_page(bio, page, len, 0);
> +			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +				bio->bi_status = BLK_STS_RESOURCE;
> +				bio_endio(bio);
> +				return sectors_done; /* XXX: is this correct? */
> +			}
>  		}
>  		sector_nr += len >> 9;
>  		nr_sectors += len >> 9;

-- 
Damien Le Moal
Western Digital Research

