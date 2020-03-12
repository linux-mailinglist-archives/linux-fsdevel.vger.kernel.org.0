Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81B183BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 23:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCLWFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 18:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCLWFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A673206CD;
        Thu, 12 Mar 2020 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584050716;
        bh=BTpIEKtjB3xS8Vr88vILZ1/PyE+yHgP6lcXkkl1uiTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlCHVt9vSpN0nO4WKoQ4CaiSFxd7Cb27vMQY8jGeM8rNWy8Bb9999bcCaochj/gD4
         FzTgBR79rC4+rMZIU1QDDKzSTa6AJ5118ZkPjhrKz/UJ+0IfLRlT3xH3g9sEh8UM9x
         mvRtV6WEU7YoOoURFCPmg+iQbVkT94X3HzJ5V5zA=
Date:   Thu, 12 Mar 2020 23:05:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, viro@zeniv.linux.org.uk,
        shakeelb@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
Message-ID: <20200312220512.GA614185@kroah.com>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
 <20200312211735.GA1967398@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312211735.GA1967398@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:17:35PM -0400, Tejun Heo wrote:
> Hello,
> 
> Daniel, the patchset looks good to me. Thanks a lot for working on
> this.
> 
> Greg, provided that there aren't further objections, how do you wanna
> route the patches? I'd be happy to take them through cgroup tree but
> any tree is fine by me.

Sure, feel free to take them through your tree:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
