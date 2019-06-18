Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4454749922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 08:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfFRGp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 02:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfFRGp1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:45:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E49520665;
        Tue, 18 Jun 2019 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840326;
        bh=AsLPFQxG7ndhZoGklcal2RUbRlsZc5q+fbIUAet9OU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LykOYnEhygr2UoCYGIzigAn5SYQJzvzdCc7fW0yHdJ1zlRWfUsTKyKvSrfBNb1cFk
         9Fbjn+M1HZyrOnHXXtYaq0rvLWbxTIiQbNUNehRRGn0dyK9laDbBRHnNOznLcerKpe
         d5SDZZ8PNq9uCFkMNHzygg+AxVMUCLXmr4zOWFvY=
Date:   Tue, 18 Jun 2019 08:45:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
        chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
Message-ID: <20190618064523.GA6015@kroah.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
 <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
 <20190618054709.GA4271@kroah.com>
 <df18d7f9-f65a-5697-c7c4-edb1ad846c3e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df18d7f9-f65a-5697-c7c4-edb1ad846c3e@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:18:00PM +0800, Gao Xiang wrote:
> 
> 
> On 2019/6/18 13:47, Greg Kroah-Hartman wrote:
> > On Tue, Jun 18, 2019 at 09:47:08AM +0800, Gao Xiang wrote:
> >>
> >>
> >> On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
> >>> On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
> >>>> At last, this is RFC patch v1, which means it is not suitable for
> >>>> merging soon... I'm still working on it, testing its stability
> >>>> these days and hope these patches get merged for 5.3 LTS
> >>>> (if 5.3 is a LTS version).
> >>>
> >>> Why would 5.3 be a LTS kernel?
> >>>
> >>> curious as to how you came up with that :)
> >>
> >> My personal thought is about one LTS kernel one year...
> >> Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
> >> which is not suitable for all historical LTSs...just prepare for 5.3...
> > 
> > I try to pick the "last" kernel that is released each year, which
> > sometimes is 5 kernels, sometimes 4, sometimes 6, depending on the
> > release cycle.
> > 
> > So odds are it will be 5.4 for the next LTS kernel, but we will not know
> > more until it gets closer to release time.
> 
> Thanks for kindly explanation :)
> 
> Anyway, I will test these patches, land to our commerical products and try the best
> efforts on making it more stable for Linux upstream to merge.

Sounds great.

But why do you need to add compression to get this code out of staging?
Why not move it out now and then add compression and other new features
to it then?

thanks,

greg k-h
