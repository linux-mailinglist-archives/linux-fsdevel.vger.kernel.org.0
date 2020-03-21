Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C648618E147
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 13:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCUMi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 08:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUMi0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:38:26 -0400
Received: from [192.168.0.107] (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EFD20754;
        Sat, 21 Mar 2020 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584794305;
        bh=zp2n1MEssNtUaVqT85o+OvS2O3s3EUm4WEI+nLhZGcA=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=wg0BZOyQxkJPeGA6fMlf8DP3FnZm25yOoGK8F4EgvgaHjCd9lK/nlsw/qOgvlrhRT
         6g3ukkYCrGg4mHygVxRsdOHXGALoxh5W7NiPs4ZXnzM1hOpXl45tysIblZC1s7vspe
         QJhVI4uupeoTC2/6pjQQHfIwaDfJfrSYhoqespzM=
Subject: Re: [f2fs-dev] [PATCH v9 18/25] erofs: Convert uncompressed files
 from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-19-willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <2796a575-dd89-6cfb-a7af-511a2f463fda@kernel.org>
Date:   Sat, 21 Mar 2020 20:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320142231.2402-19-willy@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-3-20 22:22, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in erofs
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
