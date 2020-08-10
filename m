Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F4240725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgHJODg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgHJODa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IyuaY9t2vA/B12pZXPt0Wm8+ZAqAc40MFsIlLkmWgc=;
        b=Fk/tCZxXxHhIrMjaEsl8RHjudy2GRZ54xuz6wW6790+HefDsf8reE8kG447OLXiEk4ndvU
        7zNkng6CY4mDVczIXSzl5HlrYwUnh+4OrrntTPOdQ+5YqkmdgJZjEZThhNZrxWfq8wbLvM
        OkqbmPaTj/hoWk15LKg6J+qENJEy1LM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-jqMvyddbMpKpydBh0TDVxw-1; Mon, 10 Aug 2020 10:03:25 -0400
X-MC-Unique: jqMvyddbMpKpydBh0TDVxw-1
Received: by mail-wm1-f72.google.com with SMTP id h205so2912933wmf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 07:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0IyuaY9t2vA/B12pZXPt0Wm8+ZAqAc40MFsIlLkmWgc=;
        b=ABojuoTwNOuk8GcElysw8uf581eT3zG5/XfcWWrpWCMvldQQaiRvDIvxkWjh2UR4U6
         O46BjHRNAL8WtpDcY3BUPmpA0ZHk01MWW7gqOM+LIvb2prqrfvCKkJbaMICCHMI0rd0Z
         xgMmGSgFyGRFfy5N4dSVpqZhPp+ZwRepdOzcalwmlRG67Rn31cZtAXdRckDWYupe7nm2
         07y0efudaUIin85uJlmBhaiUBtGi3jZygBm6bAMEyjOpcGDnLx0VRYVq8LOcY3vKejQL
         2g5w8pLkqMWdyeByf8tpIqtbEB1ozEH1i8ydjtgbSRmVEPkD884LVZuuDWWkTkroZ65u
         tacg==
X-Gm-Message-State: AOAM532EztBAu7SOwCmKp/gjfMqxBAV952oxmjl66YOTpWCDcqcPHMny
        UpXugPgrz6kY8C6I0SaZ9sFF5TZkci7bq2+JfumdXo5Dgr+KoiY25JpiHpuexf+lq3dWlTz7mGB
        Q9ToLzKyJnD5mH04eIkPZhP5otg==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr24858799wmj.74.1597068204361;
        Mon, 10 Aug 2020 07:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjNtR3OArq0V+wemZ+ZAqdL/eGbHMLXToEAuqW5w/uHw7UhkAdm+a8gtIMsDr6mATcbBH4jA==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr24858780wmj.74.1597068204153;
        Mon, 10 Aug 2020 07:03:24 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id r11sm21350307wrw.78.2020.08.10.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:03:23 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:03:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/20] virtio: Implement get_shm_region for MMIO
 transport
Message-ID: <20200810100240-mutt-send-email-mst@kernel.org>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-6-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-6-vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:11PM -0400, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On MMIO a new set of registers is defined for finding SHM
> regions.  Add their definitions and use them to find the region.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 627ac0487494..2697c492cf78 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -498,6 +498,37 @@ static const char *vm_bus_name(struct virtio_device *vdev)
>  	return vm_dev->pdev->name;
>  }
>  
> +static bool vm_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 len, addr;
> +
> +	/* Select the region we're interested in */
> +	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
> +
> +	/* Read the region size */
> +	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
> +	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
> +
> +	region->len = len;
> +
> +	/* Check if region length is -1. If that's the case, the shared memory
> +	 * region does not exist and there is no need to proceed further.
> +	 */
> +	if (len == ~(u64)0) {
> +		return false;
> +	}
> +

It might make sense to validate that addr/len do not overlap.
Will be useful for PCI too.
Can be a patch on top.

> +	/* Read the region base address */
> +	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
> +	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
> +
> +	region->addr = addr;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get		= vm_get,
>  	.set		= vm_set,
> @@ -510,6 +541,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get_features	= vm_get_features,
>  	.finalize_features = vm_finalize_features,
>  	.bus_name	= vm_bus_name,
> +	.get_shm_region = vm_get_shm_region,
>  };
>  
>  
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
> index c4b09689ab64..0650f91bea6c 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,17 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
>  
> +/* Shared memory region id */
> +#define VIRTIO_MMIO_SHM_SEL             0x0ac
> +
> +/* Shared memory region length, 64 bits in two halves */
> +#define VIRTIO_MMIO_SHM_LEN_LOW         0x0b0
> +#define VIRTIO_MMIO_SHM_LEN_HIGH        0x0b4
> +
> +/* Shared memory region base address, 64 bits in two halves */
> +#define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
> +#define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
>  
> -- 
> 2.25.4
> 

