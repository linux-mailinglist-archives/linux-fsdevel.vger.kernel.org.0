Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31A18E151
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 13:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCUMlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 08:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUMlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:41:18 -0400
Received: from [192.168.0.107] (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B163C20754;
        Sat, 21 Mar 2020 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584794477;
        bh=SYButYYnPtTNzTsvJv/ztlsV2rT6hQCbbeI2pzlT52k=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=mZAqbYYEyed/TRFC34Za867sHZy20DSHbKWw+pfpCOnVubLSkgdKhC74IfLXb0oQ5
         irgqnDuLIeHhDqhwmSXSHDKHRIlhYBBteSxo2x9Zg8CrGALnf5+E10sckAtjZq5EYM
         B0EReMmsHEMDlh4R+X7pNuj+kYgFVEbn3aKM9dbQ=
Subject: Re: [f2fs-dev] [PATCH v9 19/25] erofs: Convert compressed files from
 readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-20-willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <135c3eeb-c809-08dc-8b4b-31ced90c622a@kernel.org>
Date:   Sat, 21 Mar 2020 20:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320142231.2402-20-willy@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-3-20 22:22, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in erofs.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
