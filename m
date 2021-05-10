Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417853792AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhEJP23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 11:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237626AbhEJP0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 11:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620660311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K2CGR/IDsHtbZ5Y9P6c1L3DtRTFVjRlsHsiyPl4p12Q=;
        b=aH/eHjBWV4kZYRaIlolXTcsLvtf/f0OOeFsi/nSMA1Rzm6RlX2D3o9zcNCeBTqWEz0PF0s
        OlkzEIzkijHq2HYvIwisVr8GkCzW1gRIaczoTfrxx84ErfYSYwZXlLDAw5EzzbVULFedeD
        3iZP0Rneaz0O6m+Z/i9l5ZDgFf/lwaQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-TzulR7mBMOaIg49O6LLPoA-1; Mon, 10 May 2021 11:25:09 -0400
X-MC-Unique: TzulR7mBMOaIg49O6LLPoA-1
Received: by mail-qt1-f197.google.com with SMTP id s11-20020ac85ecb0000b02901ded4f15245so1686655qtx.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 08:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K2CGR/IDsHtbZ5Y9P6c1L3DtRTFVjRlsHsiyPl4p12Q=;
        b=W7KER3ANLbw0QdoJd/sUt0UHHqZ36mHOx97C4+9+ROSbLkM63bfUxDtTsg6vxZqqyw
         tW/mvPreHWAViOrwEJKficcX6dNsJ7lFOU19eowUjBIgXd7YLo7IjblFVYDvKKlIWb/f
         P2RetuEXDPmZJGl30Y3F1+bjkRuO1FkdtVeGQ1QB4N4xmdKUyCdsc5FtSA0nLMoKss8F
         fj8N7Htue8XtDzoEijwAzbONsJe3RLiylYbL6/2USs7RyqMRHETpZQ+i6OiPnJy3KCOS
         ssbw8RqC5SCQNo7uBvPO/JOh68YkBhUxBEggeYswzsdaUZnucBpd4ESHCWbdWF0nPm76
         99uA==
X-Gm-Message-State: AOAM530gnAwaUYhJpJdlnSoxF9zl1VUHq4s94VW2tckwEh1VvPzygj4M
        eeTUMiGeugNsxG8Oc1nSDzjIvVDGbpfaeebLXEYVd/JJ8mdvUNfcSCvBykxyuQ50dOYGtfb6umP
        BcTUojBdHIlZ1qiefXQprCWAYkg==
X-Received: by 2002:a37:4017:: with SMTP id n23mr21753959qka.338.1620660308754;
        Mon, 10 May 2021 08:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf+1jFnLT/UbwYtkRupiUPmDiPqdUTk6gWY3qtL/u/wOC2u18ZkK0Q8NmQNcSkgGbQ0jbSXQ==
X-Received: by 2002:a37:4017:: with SMTP id n23mr21753938qka.338.1620660308550;
        Mon, 10 May 2021 08:25:08 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net. [173.76.174.238])
        by smtp.gmail.com with ESMTPSA id 28sm6715878qkr.36.2021.05.10.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:25:08 -0700 (PDT)
Date:   Mon, 10 May 2021 11:25:06 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <20210510152506.GC150402@horse>
References: <20210507221527.699516-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507221527.699516-1-ckuehl@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 03:15:27PM -0700, Connor Kuehl wrote:
> Distribute requests across the multiqueue complex automatically based
> on the IRQ affinity.

Hi Connor,

Thanks for the patch. I will look into it and also test it.

How did you test it? Did you modify vitiofsd to support multiqueue. Did
you also run some performance numbers. Does it provide better/worse
performance as compared to single queue.

Thanks
Vivek

> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bcb8a02e2d8b..dcdc8b7b1ad5 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -30,6 +30,10 @@
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>  
> +struct virtio_fs_vq;
> +
> +DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
> +
>  enum {
>  	VQ_HIPRIO,
>  	VQ_REQUEST
> @@ -673,6 +677,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	struct virtqueue **vqs;
>  	vq_callback_t **callbacks;
>  	const char **names;
> +	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
>  	unsigned int i;
>  	int ret = 0;
>  
> @@ -681,6 +686,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> +	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
> +				       fs->num_request_queues);
> +
>  	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
>  	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>  	if (!fs->vqs)
> @@ -710,12 +718,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  		names[i] = fs->vqs[i].name;
>  	}
>  
> -	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
> +	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
>  	if (ret < 0)
>  		goto out;
>  
> -	for (i = 0; i < fs->nvqs; i++)
> +	for (i = 0; i < fs->nvqs; i++) {
> +		const struct cpumask *mask;
> +		unsigned int cpu;
> +
>  		fs->vqs[i].vq = vqs[i];
> +		if (i == VQ_HIPRIO)
> +			continue;
> +
> +		mask = vdev->config->get_vq_affinity(vdev, i);
> +		for_each_cpu(cpu, mask) {
> +			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
> +			*cpu_vq = &fs->vqs[i];
> +		}
> +	}
>  
>  	virtio_fs_start_all_queues(fs);
>  out:
> @@ -877,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>  	if (ret < 0)
>  		goto out;
>  
> -	/* TODO vq affinity */
> -
>  	ret = virtio_fs_setup_dax(vdev, fs);
>  	if (ret < 0)
>  		goto out_vqs;
> @@ -1225,7 +1243,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
>  __releases(fiq->lock)
>  {
> -	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
>  	struct virtio_fs *fs;
>  	struct fuse_req *req;
>  	struct virtio_fs_vq *fsvq;
> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>  		 req->in.h.nodeid, req->in.h.len,
>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>  
> -	fsvq = &fs->vqs[queue_id];
> +	fsvq = this_cpu_read(this_cpu_fsvq);
> +
>  	ret = virtio_fs_enqueue_req(fsvq, req, false);
>  	if (ret < 0) {
>  		if (ret == -ENOMEM || ret == -ENOSPC) {
> -- 
> 2.30.2
> 

