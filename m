Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74023333F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfFCPPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 11:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729081AbfFCPPt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:15:49 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296B524CF1;
        Mon,  3 Jun 2019 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559574949;
        bh=54oATYsXXJ8P2M14fItKq+XktmeWUBPg/oIseVIgycE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TpgLbiVsdpdF49lOLEgS3pAq5qsVYM50r0Mf7QmMNRzjzT8t79qh6m4Fskm/t1uYo
         r1bBMKVQe/rmg2KBYIAKSwupUWc1XTvQ+PDNJhfTfzkQpaI1dEC/Plups1LVSK0PPR
         dZ1+o65toz9AvGiaT+4WjOIPD47zO+vVeIiX0Bc4=
Subject: Re: [f2fs-dev] [PATCH v3 4/4] f2fs: Add option to limit required GC
 for checkpoint=disable
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-5-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <cbd6e561-66c3-da63-d5b4-e81da990bd15@kernel.org>
Date:   Mon, 3 Jun 2019 23:15:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530004906.261170-5-drosen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-5-30 8:49, Daniel Rosenberg via Linux-f2fs-devel wrote:
> This extends the checkpoint option to allow checkpoint=disable:%u[%]
> This allows you to specify what how much of the disk you are willing
> to lose access to while mounting with checkpoint=disable. If the amount
> lost would be higher, the mount will return -EAGAIN. This can be given
> as a percent of total space, or in blocks.
> 
> Currently, we need to run garbage collection until the amount of holes
> is smaller than the OVP space. With the new option, f2fs can mark
> space as unusable up front instead of requiring garbage collection until
> the number of holes is small enough.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
