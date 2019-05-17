Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E121136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEQATh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 20:19:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43047 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfEQATh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 20:19:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so2348996pgi.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
        b=trB5X+v2CFHJR5/h5Ogo8pnGEbixSq/5SbMCfW0BvmcDG2zeRdzxHL4lknPMI8JsaG
         91o9aNowjUtiTckfyBLWY/pZJBmRERl33EcI9dq0zR0lXd+XHl45wImJtwD6qTmBiD3C
         YvIdILOfNr02D208IUOgX7xjB1B80gLQERVK/akSkqvFqS79gmXpU/duephS4OxkvMCj
         iFkaZbcWb+04sJYfOvlYsPNWM7LK/oP8HkDOryS8f1XdKVoMLZUlQ8YVZMbBQiMDnraB
         fYXacmGWn0btEdYeftIv0rPSsHpeCBXpkkAwnfL+k2zqdhfQJ6WS6TGQ7DeGxI98ZyT1
         d5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
        b=sBg7Qom3ti9MasV/smTzGTmkH3aXD1xyI9uzCnmBLdBJNQmxP71Ezqj+sfn3xOqEkO
         pHPp476l5KZ39XgD3ngwmhsCPa6gSRBNJ0WlWdogBQvceJwh7BrUy5Ug63T+W+01NOeq
         /O61Xh4gQUQ87FB6QTkjAZzna+dAqCVaoM4jr82kJVcU9gn3o8et2bLFzaDowx2n+I//
         vCd8RjyEmFF3B/zx3m/qHeFIlh6qOxDuGS5BuOfb1lfddVzqlG2BhjddJkEqzYDEYjg8
         uyr9jdN996ZsVUzrL0pGg3y+9xuLsJWXMz6xw+Sl2jwudLJ+ZYRYHUXs+OFOCXDZrbSj
         QMIw==
X-Gm-Message-State: APjAAAVQ4p+Q3DbSSnrBXlaEtyAvPC/h1kjmWTdHFz+FBbwyUQsGz/nt
        I9ksA84ZwpAW4GFhAJbJNSnraQ==
X-Google-Smtp-Source: APXvYqyv1iVBQbL6jyOdYGu6UtPQiwVBUuqofcSXUoK/ck1DMyLzSDgzGJaT2Ro5WErOmsiHR9V/gQ==
X-Received: by 2002:a63:d816:: with SMTP id b22mr52619479pgh.16.1558051959951;
        Thu, 16 May 2019 17:12:39 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com ([2620:15c:202:201:b94f:2527:c39f:ca2d])
        by smtp.gmail.com with ESMTPSA id a6sm7245768pgd.67.2019.05.16.17.12.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 17:12:39 -0700 (PDT)
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        kilobyte@angband.pl, yuval.shaia@oracle.com, smbarber@google.com
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
From:   =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Message-ID: <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
Date:   Thu, 16 May 2019 17:12:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> +		if (!list_empty(&vpmem->req_list)) {
> +			req_buf = list_first_entry(&vpmem->req_list,
> +					struct virtio_pmem_request, list);
> +			req_buf->wq_buf_avail = true;
> +			wake_up(&req_buf->wq_buf);
> +			list_del(&req_buf->list);
Yes, this change is the right one, thank you!

> +	 /*
> +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> +	  * queue does not have free descriptor. We add the request
> +	  * to req_list and wait for host_ack to wake us up when free
> +	  * slots are available.
> +	  */
> +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> +					GFP_ATOMIC)) == -ENOSPC) {
> +
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem" \
> +			"device, no free slots in the virtqueue\n");
> +		req->wq_buf_avail = false;
> +		list_add_tail(&req->list, &vpmem->req_list);
> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +		/* A host response results in "host_ack" getting called */
> +		wait_event(req->wq_buf, req->wq_buf_avail);
> +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	}
> +	err1 = virtqueue_kick(vpmem->req_vq);
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +	/*
> +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> +	 * do anything about that.
> +	 */
> +	if (err || !err1) {
> +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> +		err = -EIO;
> +	} else {
> +		/* A host repsonse results in "host_ack" getting called */
> +		wait_event(req->host_acked, req->done);
> +		err = req->ret;
> +I confirm that the failures I was facing with the `-ENOSPC` error path are not present in v9.

Best,
Jakub Staron
