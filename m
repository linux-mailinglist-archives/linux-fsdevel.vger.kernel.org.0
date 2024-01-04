Return-Path: <linux-fsdevel+bounces-7358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98982413C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27F91F24B8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48612136B;
	Thu,  4 Jan 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jjJRdywM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1421366
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso456293e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704369803; x=1704974603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUJhuebzE3MQn2Hp2CPQ9vaRRluvOV5K20Hvjb/8s9M=;
        b=jjJRdywM+ivClG7RbSa3rurwjlcgBEfGLwZbZsy9SRmJj5c0lUE+0L6rirj6QLp/FJ
         bjWhIVI7cZmIKiDMGpjAAJA1Vkw376eKGoBoCbcY/MHiYrmdJoU4o8GvWc3+Oo1O9CiB
         bjOgzgY6+QNNIBmuommpWHXisRyyQNibkKEi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369803; x=1704974603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUJhuebzE3MQn2Hp2CPQ9vaRRluvOV5K20Hvjb/8s9M=;
        b=K6GzD2/nDWuSGBWgg5hd3wDG7xX5tuNHXMIyyZ1wmp7UUjvOca04Mc0aC4sVS75cVJ
         Dk/+44jWmJao7KQkbV1+aBrHe9cBJ2zzpxyjJ5028TMOHnG9zEt6yhRMjqIYcI7wTSpa
         Qbedu71Y+Uk64GTSXw4Rz7oMb56W4mJ5yUojaUQNpWMmzAdeuC2TPZagBMwnWiKYHYDC
         3alCZAiAb/7VOUkC+kT2VgdeypTnWjFQG50/kBk9wdKo6caM3vogqGUzjJbPAU/PYXpU
         gIGXYGDU/gknZkkVarZ1Hr+/ebXYDFOaHB3wmMZ9T4bCOBq8/c+oJdeQ0DRaMyaAupbK
         CBTQ==
X-Gm-Message-State: AOJu0YyaPhMRGeKm29csWhRfSYzj8AAs/TDqMu0tjAKoDY8ZUmwkNQb/
	3OfvYuCFkNo1MQoO96ogkLXa3HhbZk/mSrq+wrq4gf8m/FXH4Q==
X-Google-Smtp-Source: AGHT+IGybP2xoxsloaLm/3TEDKIk6xY/pU9gByXubHSM5AGAloJqEVW+xDjw+GYjrgldCKecTir+pGHS/8R+j1TrGMA=
X-Received: by 2002:a05:6512:90d:b0:50e:6332:8083 with SMTP id
 e13-20020a056512090d00b0050e63328083mr162372lft.183.1704369802717; Thu, 04
 Jan 2024 04:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220084928.298302-1-winters.zc@antgroup.com> <20231220084928.298302-2-winters.zc@antgroup.com>
In-Reply-To: <20231220084928.298302-2-winters.zc@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jan 2024 13:03:11 +0100
Message-ID: <CAJfpegtTzwANHiZty89qo77ryz0XAN4_uDP9oZ4Syx4D4YkiDA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/2] fuse: Introduce a new notification type for
 resend pending requests
To: Zhao Chen <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 09:49, Zhao Chen <winters.zc@antgroup.com> wrote:
>
> When a FUSE daemon panics and failover, we aim to minimize the impact on
> applications by reusing the existing FUSE connection. During this process,
> another daemon is employed to preserve the FUSE connection's file
> descriptor. The new started FUSE Daemon will takeover the fd and continue
> to provide service.
>
> However, it is possible for some inflight requests to be lost and never
> returned. As a result, applications awaiting replies would become stuck
> forever. To address this, we can resend these pending requests to the
> new started FUSE daemon.
>
> This patch introduces a new notification type "FUSE_NOTIFY_RESEND", which
> can trigger resending of the pending requests, ensuring they are properly
> processed again.
>
> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
> ---
>  fs/fuse/dev.c             | 64 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  1 +
>  2 files changed, 65 insertions(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 1a8f82f478cb..a5a874b2f2e2 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1775,6 +1775,67 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
>         return err;
>  }
>
> +/*
> + * Resending all processing queue requests.
> + *
> + * During a FUSE daemon panics and failover, it is possible for some inflight
> + * requests to be lost and never returned. As a result, applications awaiting
> + * replies would become stuck forever. To address this, we can use notification
> + * to trigger resending of these pending requests to the FUSE daemon, ensuring
> + * they are properly processed again.
> + *
> + * Please note that this strategy is applicable only to idempotent requests or
> + * if the FUSE daemon takes careful measures to avoid processing duplicated
> + * non-idempotent requests.
> + */
> +static void fuse_resend(struct fuse_conn *fc)
> +{
> +       struct fuse_dev *fud;
> +       struct fuse_req *req, *next;
> +       struct fuse_iqueue *fiq = &fc->iq;
> +       LIST_HEAD(to_queue);
> +       unsigned int i;
> +
> +       spin_lock(&fc->lock);
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               return;
> +       }
> +
> +       list_for_each_entry(fud, &fc->devices, entry) {
> +               struct fuse_pqueue *fpq = &fud->pq;
> +
> +               spin_lock(&fpq->lock);
> +               list_for_each_entry_safe(req, next, &fpq->io, list) {

Handling of requests on fpq->io is tricky, since they are in the state
of being read or written by the fuse server.   Re-queuing it in this
state likely can result in some sort of corruption.

The simplest solution is to just ignore requests in the I/O state.  Is
this a good solution for your use case?

Thanks,
Miklos

