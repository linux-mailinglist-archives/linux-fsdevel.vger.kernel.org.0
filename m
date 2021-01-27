Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EE305D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhA0NmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 08:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhA0Nla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:41:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B2C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 05:40:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p15so1935077wrq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ut1wpPTIfgnn/vBXNh4Zm9DnQde/13g8LB3xXa5ADwc=;
        b=uP+ZFiQvIWr7dGlnG7w4JM9eXIsJAsTa/ghknwwy5ZFOvH9BXSqVHvtjSGbiHB88k4
         glmOo3H+yB2GLb8No6KDul2LTRdEJxAw985UlMcoP9fWaiMVg3/cRmb9SjPwijJkE9Ig
         ++zTu6n6zG3+SCyK5t8kJXYSUQNJ1hAvnRENRpJ4GMEkoHQ2ltsCNAhnFuOpAACWdkmU
         Zqu1/vmW1NUnB0r1pjZ/8cochpfna/Wy88gLuVt0gnegDKPiDek7QlaximA3jlNxlbib
         iWgaSehQCSMAlL90nPhXqldT9ADBtFCnHU89GsipprpTafd+tLeY3JsKJ6j9U6Kh4w9w
         TRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ut1wpPTIfgnn/vBXNh4Zm9DnQde/13g8LB3xXa5ADwc=;
        b=ipUdg/jwjJ2i+HVaxwHfM+2y2X/+vvWxALyj2CfdomaI7FVLtunbc3u4gHUvYvyQum
         PPJFqaeigz4hcirXwD2+q995J9z/j0mmhI4Sx58CpRexiQi8y1NI1rFM4+9KsCk7wVls
         3z+bUzqIU7UYi/v6f65Wz8jZGO+24HmrSxB1eStAxJ83BQEfZ5P2yAtcbpnOLEj/1Ujf
         1RQJdzLbFRTCZC9ugznC9U4cG3l7lf1G7THndXM+UanThKjo70JJzFTiS5MQTYoFxs39
         /o0Z6P4rGsDtw9YzEk4wW7s9MpIDcujRVb3CsCMNge+cXQLmAM7f85sQ10VYDg+6nenS
         aMZg==
X-Gm-Message-State: AOAM533xEUc3wAI2p9epxUw32RjIrhOp++FtCo+zMZLmFcHbjbKg+gNK
        qJKydQIW/mYYY/cU2yqY0pOnLQ==
X-Google-Smtp-Source: ABdhPJzrwczNYHNOaS9EkacIC3ae0J6dCCn0Prj1GFoTmWaJOwiWlZyca/ZnRFBNApdjJdaB53YdUQ==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr11255881wrq.49.1611754848751;
        Wed, 27 Jan 2021 05:40:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:811b:8e2:92b4:d783])
        by smtp.gmail.com with ESMTPSA id s4sm3001940wrt.85.2021.01.27.05.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 05:40:48 -0800 (PST)
Date:   Wed, 27 Jan 2021 13:40:46 +0000
From:   Alessio Balsini <balsini@android.com>
To:     qxy <qxy65535@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
Message-ID: <YBFtXqgvcXW5fFCR@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-3-balsini@android.com>
 <CAMAHBGzkfEd9-1u0iKXp65ReJQgUi_=4sMpmfkwEOaMp6Ux7pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAHBGzkfEd9-1u0iKXp65ReJQgUi_=4sMpmfkwEOaMp6Ux7pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:15:19PM +0800, qxy wrote:
> Hi Allesio,
> 
> Thank you for your supply for 32-bit user space.
> Actually we have already met this issue on our product and we resolved it
> like this:
> 
> Project *platform/external/libfuse*
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index e9d4f1a..fe0cb6d 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -562,7 +562,11 @@
>          uint32_t fd;
>          /* For future implementation */
>          uint32_t len;
> -        void *   vec;
> +        union {
> +                void *   vec;
> +                /* compatible for 32-bit libfuse and 64-bit kernel */
> +                uint64_t padding;
> +        };
>  };
> 
> However, if we need to use *vec in the future,  we still need to do more in
> 32-bit libfuse to work with 64-bit kernel :(
> 

Good point.
What I had in mind as a possible use was the possibility of enabling
passthrough for only a few regions of the file, similar to fuse2.
But it doesn't really make sense to define the data structure fields for
uncertain future extensions, so what we could do is:

struct fuse_passthrough_out {
+	uint32_t	size;	// Size of this data structure
	uint32_t	fd;
-	/* For future implementation */
-	uint32_t	len;
-	void		*vec;
};

Similar to what "struct sched_attr" does.
This is probably the most flexible solution, that would allow to extend
this data structure in the future with no headaches both in kernel and
user space.
What do you think?

Thanks!
Alessio

