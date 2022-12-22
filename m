Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027E653D82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiLVJeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 04:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiLVJeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:34:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5C26496;
        Thu, 22 Dec 2022 01:34:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so1507693plj.3;
        Thu, 22 Dec 2022 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPKybboGCvicn0U7sdQcBMFG6D8bbPiUYEtx1iI7x/k=;
        b=QqGFeFSVbWYowseU+ncOISNaKVTXMZlJIno+dSXNYV7y0sNHoeJoEsqsEqNSh7z0jk
         5sgiWdKghR16fZRNRixaq8zrhJI7B1nC0JwlbrDn+iN49jE0sm1ZVQ3m6MgcwXmLWIn/
         e5lbMQxFNRSNfeN8abg6mHvFEhUTZYbKpLcRJ59RX4rmPDHpOvDpHd045FTnL9Do8vRg
         VDjRB1nYZIU5QBUB7iiJLjqU0vXc35OC1f4xyesAjiIrEJR3fE8W90i1WBO2XVwIpBWh
         uLhV1jTlmR8vWVlBMrH6W4OfAf++vFznpt10x3BbOUwKE1NBNfoxGwyy/ZQIu4qEQzUw
         PGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPKybboGCvicn0U7sdQcBMFG6D8bbPiUYEtx1iI7x/k=;
        b=lfLsfoQMgVh9mWOAHavNPa2YH/8EVco2ZIehrF9G6f9EAgwMu/eOA7zcYjDRpArpZu
         3XGsvLLZaO5jmoUhehz3rJLAtLT7sbfcyHmeozDZ4M5WsTaYIqMYf2c2HMKvh2FrjyX/
         C+Ib62Y2Yj69Xvaslj8OIQlamc5CNj8YXFgrOv0NRfwOGkyrH/o8GxAedCN/Qb63XnI4
         46DzdiCv/jYX8htwelxn4DUHqCDyfZQudlHmSVSs+BbS2dkRMIiTFKnUg+lJnteM/24m
         jzZKGuykIvaPgYkHAPdRHf2MHwqr23YDtxGLVmqALk1uPcEU94CRIApMZFgtjQxixIEC
         xvBw==
X-Gm-Message-State: AFqh2kq2SO+hdkVW8lWxflHWjQv4axEANyB1a55fX1tjhIhPX//cWito
        SATplyR9pjF1M5Ewi4bjWvQ=
X-Google-Smtp-Source: AMrXdXtnu3AmL957S2esLYiFd+068mIgjFjLS6oODmu+20WLj4wWAW61aWVKwg4b8hIbLxPqfNb/Ww==
X-Received: by 2002:a17:902:ec82:b0:187:2f28:bfd6 with SMTP id x2-20020a170902ec8200b001872f28bfd6mr8157260plg.21.1671701655145;
        Thu, 22 Dec 2022 01:34:15 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id r25-20020a634419000000b004771bf66781sm329097pga.65.2022.12.22.01.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 01:34:14 -0800 (PST)
Date:   Thu, 22 Dec 2022 17:34:07 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Pradeep P V K <quic_pragalla@quicinc.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     quic_stummala@quicinc.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_sayalil@quicinc.com, quic_aiquny@quicinc.com,
        quic_zljing@quicinc.com, quic_blong@quicinc.com,
        quic_richardp@quicinc.com, quic_cdevired@quicinc.com,
        tkjos@google.com, qixiaoyu1@xiaomi.com, zhubin3@xiaomi.com
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
Message-ID: <20221222093407.GA1141@mi-HP-ProDesk-680-G4-MT>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pradeep, Miklos,

We have found this patch benefits the decompress performance up to ~46%
on our Android smart devices.

Use-case details:
1. prepare a zip file with 2000 pictures into /sdcard path
2. use unzip command to decompress the zip file

-------------------------------------------------
| Default   | patch          | Improvement/Diff |
-------------------------------------------------
| 13 sec    | 7 sec          | 6 sec (46%)      |
-------------------------------------------------

On Android platform, the server thread runs in MediaProvider as a
background service, and it may runs on little cores. However, applications
usually run on big cores, for they are forground. With this patch, the
server threads can run much faster and benefit the decompress performance.

------------------------------------------------------------------------
| Total Wall duration of server threads (ms)                           |
------------------------------------------------------------------------
|           | Wall duration  | Occurrences   | Occurrences on big core |
------------------------------------------------------------------------
| Default   | 3583  (ms)     | 13926         | 5%                      |
------------------------------------------------------------------------
| patch     | 1276  (ms)     | 12996         | 79%                     |
------------------------------------------------------------------------

Thanks,
Xiaoyu

On Mon, Dec 06, 2021 at 02:16:45PM +0530, Pradeep P V K wrote:
> The synchronous wakeup interface is available only for the
> interruptible wakeup. Add it for normal wakeup and use this
> synchronous wakeup interface to wakeup the userspace daemon.
> Scheduler can make use of this hint to find a better CPU for
> the waker task.
> 
> With this change the performance numbers for compress, decompress
> and copy use-cases on /sdcard path has improved by ~30%.
> 
> Use-case details:
> 1. copy 10000 files of each 4k size into /sdcard path
> 2. use any File explorer application that has compress/decompress
> support
> 3. start compress/decompress and capture the time.
> 
> -------------------------------------------------
> | Default   | wakeup support | Improvement/Diff |
> -------------------------------------------------
> | 13.8 sec  | 9.9 sec        | 3.9 sec (28.26%) |
> -------------------------------------------------
> 
> Co-developed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
> ---
>  fs/fuse/dev.c        | 22 +++++++++++++---------
>  fs/fuse/fuse_i.h     |  6 +++---
>  fs/fuse/virtio_fs.c  |  8 +++++---
>  include/linux/wait.h |  1 +
>  4 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index cd54a52..fef2e23 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -207,10 +207,13 @@ static unsigned int fuse_req_hash(u64 unique)
>  /**
>   * A new request is available, wake fiq->waitq
>   */
> -static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq)
> +static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq, bool sync)
>  __releases(fiq->lock)
>  {
> -	wake_up(&fiq->waitq);
> +	if (sync)
> +		wake_up_sync(&fiq->waitq);
> +	else
> +		wake_up(&fiq->waitq);
>  	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
>  	spin_unlock(&fiq->lock);
>  }
> @@ -223,14 +226,15 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
>  EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
>  
>  static void queue_request_and_unlock(struct fuse_iqueue *fiq,
> -				     struct fuse_req *req)
> +				     struct fuse_req *req,
> +				     bool sync)
>  __releases(fiq->lock)
>  {
>  	req->in.h.len = sizeof(struct fuse_in_header) +
>  		fuse_len_args(req->args->in_numargs,
>  			      (struct fuse_arg *) req->args->in_args);
>  	list_add_tail(&req->list, &fiq->pending);
> -	fiq->ops->wake_pending_and_unlock(fiq);
> +	fiq->ops->wake_pending_and_unlock(fiq, sync);
>  }
>  
>  void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
> @@ -245,7 +249,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
>  	if (fiq->connected) {
>  		fiq->forget_list_tail->next = forget;
>  		fiq->forget_list_tail = forget;
> -		fiq->ops->wake_forget_and_unlock(fiq);
> +		fiq->ops->wake_forget_and_unlock(fiq, 0);
>  	} else {
>  		kfree(forget);
>  		spin_unlock(&fiq->lock);
> @@ -265,7 +269,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
>  		fc->active_background++;
>  		spin_lock(&fiq->lock);
>  		req->in.h.unique = fuse_get_unique(fiq);
> -		queue_request_and_unlock(fiq, req);
> +		queue_request_and_unlock(fiq, req, 0);
>  	}
>  }
>  
> @@ -358,7 +362,7 @@ static int queue_interrupt(struct fuse_req *req)
>  			spin_unlock(&fiq->lock);
>  			return 0;
>  		}
> -		fiq->ops->wake_interrupt_and_unlock(fiq);
> +		fiq->ops->wake_interrupt_and_unlock(fiq, 0);
>  	} else {
>  		spin_unlock(&fiq->lock);
>  	}
> @@ -425,7 +429,7 @@ static void __fuse_request_send(struct fuse_req *req)
>  		/* acquire extra reference, since request is still needed
>  		   after fuse_request_end() */
>  		__fuse_get_request(req);
> -		queue_request_and_unlock(fiq, req);
> +		queue_request_and_unlock(fiq, req, 1);
>  
>  		request_wait_answer(req);
>  		/* Pairs with smp_wmb() in fuse_request_end() */
> @@ -600,7 +604,7 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  
>  	spin_lock(&fiq->lock);
>  	if (fiq->connected) {
> -		queue_request_and_unlock(fiq, req);
> +		queue_request_and_unlock(fiq, req, 0);
>  	} else {
>  		err = -ENODEV;
>  		spin_unlock(&fiq->lock);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c1a8b31..363e0ba 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -389,19 +389,19 @@ struct fuse_iqueue_ops {
>  	/**
>  	 * Signal that a forget has been queued
>  	 */
> -	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
> +	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq, bool sync)
>  		__releases(fiq->lock);
>  
>  	/**
>  	 * Signal that an INTERRUPT request has been queued
>  	 */
> -	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
> +	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq, bool sync)
>  		__releases(fiq->lock);
>  
>  	/**
>  	 * Signal that a request has been queued
>  	 */
> -	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
> +	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq, bool sync)
>  		__releases(fiq->lock);
>  
>  	/**
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4cfa4bc..bdc3dcc 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -972,7 +972,7 @@ static struct virtio_driver virtio_fs_driver = {
>  #endif
>  };
>  
> -static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
> +static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq, bool sync)
>  __releases(fiq->lock)
>  {
>  	struct fuse_forget_link *link;
> @@ -1007,7 +1007,8 @@ __releases(fiq->lock)
>  	kfree(link);
>  }
>  
> -static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
> +static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq,
> +						bool sync)
>  __releases(fiq->lock)
>  {
>  	/*
> @@ -1222,7 +1223,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	return ret;
>  }
>  
> -static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
> +static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq,
> +					bool sync)
>  __releases(fiq->lock)
>  {
>  	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 2d0df57..690572ee 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -228,6 +228,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
>  #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
>  #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
>  #define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE)
> +#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
>  
>  /*
>   * Wakeup macros to be used to report events to the targets.
> -- 
> 2.7.4
> 
