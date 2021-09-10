Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF971406704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhIJGDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 02:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGDX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6245B6113A;
        Fri, 10 Sep 2021 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631253733;
        bh=kWhJlIC/1vHbeFhKoaxwk/xnuUNuDuDMWv8UUrP4zwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKOXggWLy1L4eUBaHMMLpMRIcYzEKuAxNZ96kGhtbWEkketIVT4i+VcUb2tvEfQmq
         /8SEFpiR/3lcdZhmoSCeEkWsx74JVPuFkg6E8bZ7Xu4fBKzz5jPK/HTt6GkMJXJdTL
         vN42zrZNw87OmLaDErMrRv0IPf47T4dVNRQ1N7Ik=
Date:   Fri, 10 Sep 2021 08:01:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <YTr0zvythCIJk4Xb@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTiugxO0cDge47x6@kroah.com>
 <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:11:53AM +0800, taoyi.ty wrote:
> On 2021/9/8 下午8:37, Greg KH wrote:
> 
> > Perhaps you shouldn't be creating that many containers all at once?
> > What normal workload requires this?
> 
> Thank you for your reply.
> 
> 
> The scenario is the function computing of the public
> 
> cloud. Each instance of function computing will be
> 
> allocated about 0.1 core cpu and 100M memory. On
> 
> a high-end server, for example, 104 cores and 384G,
> 
> it is normal to create hundreds of containers at the
> 
> same time if burst of requests comes.

So it is a resource management issue on your side, right?  Perhaps
stagger the creation of new containers to allow the overall creation
time to be less?

thanks,

greg k-h
