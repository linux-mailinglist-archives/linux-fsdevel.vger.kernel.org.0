Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA73272A12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIUP2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIUP2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:28:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF13C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 08:28:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so13183010wmi.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0nAWnY87KOUm3TmW0inHlpng/Oa6fR5bWkP5SWjBms=;
        b=iHfyA/N+cFOP3dm1xHQGJi0wTCEYS8CK4/qFGF17fbWz0r7GMLlK/jCS+6uIZx+gzi
         K87BVBTLovwDs2dO7vo8xivjahY5AFY/10N0i93JiU+FwjfUxi2K/q1KLzO6nLDxKOQz
         XsWR/rQJl9DsSb8J4EyJKaKSDMvS0VVObRsDk9a+0yilVx4+EnfaAUiax9D6xTzEwgaM
         0wo6XQs7uMA1mh4CQAvsGIDDZ1ae4xjYUrgE0QYKN40dxsS51WSxuqDEVP+JkjZgmHoN
         zv+5BjwAZOLTVSIoB6NnBrXQzCA6nnCIEw6Z8atTdxLSW/UwUWMs+tvRIMRHoDjqoWXY
         e0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0nAWnY87KOUm3TmW0inHlpng/Oa6fR5bWkP5SWjBms=;
        b=ktngaQnNeg5CysAREM400jBChUpyNGDX5s2RrnndbBy2Ua4O6VDXZXUcwTpC06XNiw
         Eo1kEaKoANSth9zgdW8rC/h4ntIExxxLZXuFBb3TIPov45tZKrGwlncLI7eidamwVEeF
         vKyi2CUhVO96HFiXIXixGRuTmDtKk6gyFtgOuJRadFxSYiCgEwAKKw1Sj+PacNYVlNs3
         xOE2rTYPKOYSTOAK66OhDxGRR7iuudyk8+mxoLnFlXUG1iPHvdEJZ2WCPf9G5WhuxpdY
         UDnk6YxUV1e6XKyWsKZnZY3p2adBbMkIapWrXxivSBSpVH/n4j39IcKAtYs8BM6pxSQ9
         WWnw==
X-Gm-Message-State: AOAM533Kj6si+uHs3o78Fmbmc7b/ZlD79MqBAZVgrGZ6UQ7e8p7FtzZn
        xnyFfs+IP2dVsrITJOKOjEdhjQ==
X-Google-Smtp-Source: ABdhPJwQOEN7N4ON4+kBSC+xSudCe51Kv4hpYOWF5ZhQL4sia2gLckZUNo0SrhV93J5PkQgaKEzxuA==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr155409wmj.163.1600702126177;
        Mon, 21 Sep 2020 08:28:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k5sm20168920wmb.19.2020.09.21.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:28:45 -0700 (PDT)
Date:   Mon, 21 Sep 2020 16:28:44 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 3/3] fuse: Handle AIO read and write in passthrough
Message-ID: <20200921152844.GA600068@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-4-balsini@android.com>
 <f83b1074-3f20-771f-7b2f-a2fd3ffb4e44@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83b1074-3f20-771f-7b2f-a2fd3ffb4e44@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:23:22AM -0600, Jens Axboe wrote:
> On 9/11/20 10:34 AM, Alessio Balsini wrote:
> > Extend the passthrough feature by handling asynchronous IO both for read
> > and write operations.
> > When an AIO request is received, targeting a FUSE file with passthrough
> > functionality enabled, a new identical AIO request is created, the file
> > pointer of which is updated with the file pointer of the lower file system,
> > and the completion handler is set with a special AIO passthrough handler.
> > The lower file system AIO request is allocated in dynamic kernel memory
> > and, when it completes, the allocated memory is freed and the completion
> > signal is propagated to the FUSE AIO request by triggering its completion
> > callback as well.
> > 
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  fs/fuse/passthrough.c | 66 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 63 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index 44a78e02f45d..87b57b26fd8a 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -2,10 +2,16 @@
> >  
> >  #include "fuse_i.h"
> >  
> > +#include <linux/aio.h>
> 
> What is this include for? It's not using any aio parts at all.
> 
> -- 
> Jens Axboe
> 

Slipped from a cleanup. Fixed.

Thanks!
Alessio
