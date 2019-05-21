Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6092C25124
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfEUNvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 09:51:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37993 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfEUNvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 09:51:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so9758321qtj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TK1+q9ordzXuZZneT1jdBLnWaxfhFR3So8YN5DgmZPE=;
        b=oK2Cq1pXzrK3SvsiAugrfP5ar2lxCzw3HZ070Hq0JIVqlKzYBj0cHNo2lMP2DCKt4D
         TsgkTxTTD2s8G1B9y3vjlp/pr5ov9ZKejbWXqtB++EzypR9QjBGWuKYiBAcLq7Qd0bsP
         z39LIaOYyRkQb2zbad5+0qKmy3GxGb5vYBRq3x+PuFXNoGMiLu+Qq7ol6FMZW6yoWCKf
         36vAa9uo1KmKCyeo6V+hb25eVeTRyQE7YLye4Kyr7v6oWPzk1UGm/N4+RLpCsqyc1uhx
         QJCc1523ALgLHtBtmmjTf+Npp4oyQxUMPKfiqrGrd7CUJSQpyANe6d0nE1QQPDSmls4F
         X/sw==
X-Gm-Message-State: APjAAAXxwgw7r3W2nC+jhEo1O33+XLTSjWf/vk3GuwcDtAgWfK6k3vsE
        VfvR0KUCbVLh01UOmVQAcD8EzQ==
X-Google-Smtp-Source: APXvYqyh4Hn5uFOLIUZJ6Or+HOPTIpSiSFn1uSWJgwWbt4T3Cy3pGgBfYiLTVuICBM9UJLxQWjWXvw==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr28772252qtn.177.1558446698964;
        Tue, 21 May 2019 06:51:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id q27sm13106373qtf.27.2019.05.21.06.51.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 06:51:37 -0700 (PDT)
Date:   Tue, 21 May 2019 09:51:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com,
        dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com
Subject: Re: [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
Message-ID: <20190521094543-mutt-send-email-mst@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
 <20190521133713.31653-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521133713.31653-3-pagupta@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 07:07:08PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..7a3e2fe52415
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Definitions for virtio-pmem devices.
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +

config generally should be __u64.
Are you sure sparse does not complain?


> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +
> +struct virtio_pmem_resp {
> +	/* Host return status corresponding to flush request */
> +	__virtio32 ret;
> +};
> +
> +struct virtio_pmem_req {
> +	/* command type */
> +	__virtio32 type;
> +};
> +
> +#endif
> -- 
> 2.20.1

Sorry why are these __virtio32 not __le32?

-- 
MST
