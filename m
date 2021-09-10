Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E4406701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 08:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhIJGCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 02:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGCg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C2B26113E;
        Fri, 10 Sep 2021 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631253685;
        bh=6IqxKbNcEE+T/Q96S7CkCYo8fg/IBfC0XDxhuJ5O5sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Yq7cs9axFHM2e5zZg25/M9R11av2Zs+YeYJw3V22e3gvUkXejMY4rIeyluT8HcLT
         JnRx9dAVCYQTZMekFBE37Pznl0Q8wBv47x++g5qYKihHp7XRU5v8SC5WOd6pQQBqBD
         Nw5Z+F/6Ezk4wathujB6BB4BqFtUihIrWNEcsG3I=
Date:   Fri, 10 Sep 2021 08:01:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 2/2] support cgroup pool in v1
Message-ID: <YTr0n+lRtgwXXOD/@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
 <YTiuLES5qd086qRu@kroah.com>
 <a91912e2-606a-0868-7a0c-38dec5012b02@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a91912e2-606a-0868-7a0c-38dec5012b02@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:15:02AM +0800, taoyi.ty wrote:
> 
> On 2021/9/8 下午8:35, Greg KH wrote:
> > I thought cgroup v1 was "obsolete" and not getting new features added to
> > it.  What is wrong with just using cgroups 2 instead if you have a
> > problem with the v1 interface?
> > 
> 
> There are two reasons for developing based on cgroup v1:
> 
> 
> 1. In the Internet scenario, a large number of services
> 
> are still using cgroup v1, cgroup v2 has not yet been
> 
> popularized.

That does not mean we have to add additional kernel complexity for an
obsolete feature that we are not adding support for anymore.  If
anything, this would be a good reason to move those userspace services
to the new api to solve this issue, right?

thanks,

greg k-h
