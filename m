Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF543E0CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 05:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhHEDC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 23:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhHEDC5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:02:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82D3161050;
        Thu,  5 Aug 2021 03:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628132563;
        bh=qDBlW4B4gSwZHvi0mYWCYW7Dr8lxWPIo4xN7SW8CISY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZBMzEmozzYs+RWrxoqVWVhZffhTByzYBLMyWGiZ9EJcz5E96mEGEoOSNYnit26oTX
         PHNybnEppQ1owSsgoMuJdzxadgi/MBSQjIE5qOtgaWJrb+WsdwezQvvnvgjFKKnqmV
         eamgeqa2E+ul+d7NskR4SrkgmqYqobpn8FoqLhkvQ07r19vqeCqY9NoJrOi8cJqnub
         Nr7xb2UW/LfBCNQ50mS+ubNjWcX/loraGSu0TDyHH5rlvAvLrLKhjFoRKW7crtZoZm
         dW+NTmO0OBF7o3bCKLf08svLWoUUdE+b7tJ0vsYzpUzQDBmwvB26KJ36c6B0xnqGu3
         T2/r0u7VJFTzg==
Subject: Re: [PATCH v3 3/3] erofs: convert all uncompressed cases to iomap
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>
References: <20210805003601.183063-1-hsiangkao@linux.alibaba.com>
 <20210805003601.183063-4-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <225f3b6b-7a78-5ab8-a356-893caaeb5dcc@kernel.org>
Date:   Thu, 5 Aug 2021 11:02:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805003601.183063-4-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/8/5 8:36, Gao Xiang wrote:
> Since tail-packing inline has been supported by iomap now, let's
> convert all EROFS uncompressed data I/O to iomap, which is pretty
> straight-forward.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
