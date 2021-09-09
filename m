Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A810640573D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357854AbhIINcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355159AbhIIN3D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35C8960555;
        Thu,  9 Sep 2021 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631194068;
        bh=XpeCXNiZs6k6Qga5sIYIZXRpCs3ByBtUz6pFet31rnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAf6nUxoaPrL70PA/26xhRPokkiDEFCut0yBCkcDEr2pZCBUZ4QJ1Mv6XZNeRHzeL
         cGd5xeG9+b5s/VifYhI0UKQlmJ3X6k8xY5p6kHrdQ/CGgOtw7XbFSAVqjnHjB1bK3j
         KHmXk1V/FggSwg7QqUsktiqq9q3jd7ROA0bxCm9A=
Date:   Thu, 9 Sep 2021 15:27:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 2/2] support cgroup pool in v1
Message-ID: <YToL0sfpX+zVjveT@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
 <YTiuLES5qd086qRu@kroah.com>
 <084930d2-057a-04a7-76d1-b2a7bd37deb0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <084930d2-057a-04a7-76d1-b2a7bd37deb0@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 08:36:10PM +0800, taoyi.ty wrote:

<snip>

Please do not send HTML email, all of the mailing lists reject it.

Please fix up your email client and resend your replies and I will be
glad to continue the discussion.

thanks,

greg k-h
