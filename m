Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3721254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 04:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfEQC4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 22:56:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfEQC4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 22:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4HJiSDZ6NVpZlfpbAIE9JY9i5H7mtH87panNL0CH9Zw=; b=joMy3UdnsiCdt1hoeX13+Vv6h
        LAb/YlelQoJg7XbXDsVeak+AK5oiHXrplz9aGnkr5ikxMvftHA1d864zkhZUa7INRGljf3cop5faP
        6eLUOQWenVHaZqNYk0FpGvaRzfthCKI//0n63yuNpBVSwQwrM04ognUMtqpwrowWlHP+EzWZwHDQt
        VYLFo+QzkJp2hyaqrNyEOSkbuF0RdzAkrqLZgtTOJ4MZDZ6aoUA2pHNk19c5b4bJGIndt+0aPROMw
        uUW5VNR1jtv2m7Vn1ceu8dz9MH/ntT9SeaaiPZaWC+wuizEVbbi/1JlJe5AbV4fOkY5Uv5mVOejYj
        O/LWOHXmw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRT2q-000080-Sj; Fri, 17 May 2019 02:56:28 +0000
Date:   Thu, 16 May 2019 19:56:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        miaoxie@huawei.com, fangwei1@huawei.com, stummala@codeaurora.org
Subject: Re: [PATCH v2 1/1] f2fs: ioctl for removing a range from F2FS
Message-ID: <20190517025628.GF31704@bombadil.infradead.org>
References: <20190517021647.43083-1-sunqiuyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517021647.43083-1-sunqiuyang@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 10:16:47AM +0800, sunqiuyang wrote:
> +++ b/fs/f2fs/f2fs.h
> @@ -423,6 +423,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> +#define F2FS_IOC_SHRINK_RESIZE		_IOW(F2FS_IOCTL_MAGIC, 16,	\
> +						struct f2fs_resize_param)

Why not match ext4?

fs/ext4/ext4.h:#define EXT4_IOC_RESIZE_FS               _IOW('f', 16, __u64)

