Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08C049174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfFQUgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 16:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFQUgM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:36:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4532084B;
        Mon, 17 Jun 2019 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560803771;
        bh=RBEoU7K4ZyXjT/BPfVR3ydSkkFVBWSYhZLSbBJZIwnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ii0V8rWo4jEGHSK7qh1pFdLGpxHb2Hv219ILGasyXFoTZazQP6oCwgztS3yHEs1P2
         XyAUH9b7y+2Edk6GIYsLYLsn/4FzQIFDG5rF8iJmQ3RSzDK4jEiX/8AoEb8yMGpEXE
         Zy71RMbIL59ib2in0pJ2SNuk/itNAXD/1eOMafqU=
Date:   Mon, 17 Jun 2019 22:36:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     chao@kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
Message-ID: <20190617203609.GA22034@kroah.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
> At last, this is RFC patch v1, which means it is not suitable for
> merging soon... I'm still working on it, testing its stability
> these days and hope these patches get merged for 5.3 LTS
> (if 5.3 is a LTS version).

Why would 5.3 be a LTS kernel?

curious as to how you came up with that :)

thanks,

greg k-h
