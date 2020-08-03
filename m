Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101A923AC56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHCS1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 14:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:27:01 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC78C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 11:27:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j23so13489308vsq.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kP+FsGwT7Ong6g9Z4afLp/eWEQkLU5G56u7wCNQ8PbY=;
        b=AJgTtJOfq33QtwVrHYsaLOFspsbTiqgCrzwxWUY4KSq8nn719n+LK296FDkKFWb8T/
         zvbXOvclUTRqLQF7WTykx9gCeghXvWxet31NMy9+UG+NrC+4/FTyOer5i1CmCmMo0PV1
         yVvi/nIBZZJzUWIh9DtK+klhMtAxhPJ/ulejuNnLSgm60MrsJ2Q90/Typ5lUScJ085mD
         jNUdQOdm/4sVykvl/EH4WQG63v+mYA/ZS0d7HyrbkkRQjRXYZewhg6AiAQGcJcvP7FiZ
         olFj/Vgfz+QhA0pdRP+9yyIHjYV4J8WcoUK+EPB37dwI4LCLmCkX5KRmdpei3BwBnw5p
         +4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kP+FsGwT7Ong6g9Z4afLp/eWEQkLU5G56u7wCNQ8PbY=;
        b=Lheg70kfU+0JTGGOaPrfk8Gic+nIU0v/YUWiUVmPoKic6KX4jUoTOLHf1jeQzgo1rU
         AZdRQ59pdMEI9fze2K1ylrQwdH5i0fAR4feaoODlQ8GBfsdvGehE30ll9BOnjgd+mssR
         9WqMeSuc+Wwk8Odl6MRGWkpWykmei3G3gK430F0zR9Xm0p/zxs8I+QHHyC7Z4a7iEl0K
         RB+J+d8eFbGUwt3sgPaucd7qBC/M0FbPCqbaNcrlDKe0DU7Hw3TtJN4bDesJfXrnWNlr
         7rDRwj+6IX7cJ8C2MczCST4wP3O4L74wlCNLPJKItbBDPIoc8qH8E3+UZWEhfKv3uUvh
         OcIw==
X-Gm-Message-State: AOAM5329CIswQ8YzO7UOMJjpcn+tHwl4u5rQRcvAc4F0D01tzFt0bzeY
        mQ2a6R1ZiXSTK+eB++uUwLwM+Q==
X-Google-Smtp-Source: ABdhPJyU6H1ORSnyrbL6pgwSK5k0t4nkRLWrE1WiAHAQSrIO/HfrXXNuBwmpKt88ZgedOp1BLgmXJw==
X-Received: by 2002:a67:8084:: with SMTP id b126mr12585151vsd.163.1596479219744;
        Mon, 03 Aug 2020 11:26:59 -0700 (PDT)
Received: from google.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id o3sm1766447vka.42.2020.08.03.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:26:59 -0700 (PDT)
Date:   Mon, 3 Aug 2020 18:26:56 +0000
From:   Kalesh Singh <kaleshsingh@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 1/2] fs: Add fd_install file operation
Message-ID: <20200803182656.GA3230172@google.com>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-2-kaleshsingh@google.com>
 <20200803163429.GA15200@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803163429.GA15200@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:34:29PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 03, 2020 at 02:47:18PM +0000, Kalesh Singh wrote:
> > Provides a per process hook for the acquisition of file descriptors,
> > despite the method used to obtain the descriptor.
> > 
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> 
> I strongly disagree with this.  The file operation has no business
> hooking into installing the fd.
Hi Christoph. I am exploring the alternative suggested by Matthew in
Patch 2/2. Thanks :)
