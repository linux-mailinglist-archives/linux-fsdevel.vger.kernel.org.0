Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1841A158C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBKJxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 04:53:06 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34933 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbgBKJxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:53:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E360C53A;
        Tue, 11 Feb 2020 04:53:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Feb 2020 04:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        uoSAaTDVRkZ03ZmpHVTxZKngYYjWmZxYh7No4lON9Ig=; b=PPK1ZkDcEeVRkfmG
        PgkvX6I0yPQriaM+fS26m+Y7oiQYeybUoJbZZueKCPf59pzom1xN9hzY4aB6WWhy
        7RHjaQ/WCjQoaiPJtAY395L+0VSQn7F0NGqahYSotfU7JEen10GVeAF5aTtsZy+9
        KD372VNiHhxDHghrXFuD2EKL1zxu3xq8UF/FqX/wL5gKssVBtIFNqBHr3PQl97aA
        MU0NXog3xuudyaLuJjcXpONSVcnbSmAvkGtGDQrF0bn6JraNueXEevnto8RoOqeg
        YcYxs+6gcjsmhwqM4DMEKrl490ZHpvd+A4ZnLAiK7+l6Gu+RzBnnnltAYEueKx8D
        EwTuVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=uoSAaTDVRkZ03ZmpHVTxZKngYYjWmZxYh7No4lON9
        Ig=; b=WD1+Z50sj4DGX/sEUmSn1NssCCrqUSL01uUVR57/eOYGTX5/8xFJka/p5
        RBGUv2hxr9QbQvMa/OtrxN+tUC3pBPTy/nH3yELv7zCnrM9rcNwtT4yfEkObX9TU
        +Vvyqqs7oI/pTVh/mU2V2huGZO+Tq7YyAtcWTeem+3O+yLMbFU8J8ar7zwIhqd5c
        O/VHb7K0UNkjFU0R33gdR6A6M9t6QP/Tp1CG+fPinKO0BrX2M86kAO0WSUgK4fr6
        QO0QmvIFOMMg7x8FSQnaS7FMcmEWXglJammDHRwVqQOuAT6azx6gIns3rNpX8rW4
        5VupBsgfvXSQRUEv2WfGQRXST5l3w==
X-ME-Sender: <xms:gHlCXvmfpXFPr5ACykbqPPFbk_IyyR1FbmvxC-NaTDnjqz-04mwGig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieefgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dujeejrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:gHlCXhVbNbh6j3JDhc5vmftdIq5HF585A8dLpQP1xdnkoiZ9Wqk23w>
    <xmx:gHlCXhLlBipgmiG54k_5d4o7tdFF-NPHPH7L-rFuI6beGbvKIg5kjg>
    <xmx:gHlCXhtI0cEGLdIVdTEqNylS8dHeK7LD_4JdyWvyLIE8dbGJhu6iPQ>
    <xmx:gHlCXg2Vd9mOnlujpk-O7qSyYzx5vn7rjS0DH7Mnz8K4tzMs_DQFTA>
Received: from mickey.themaw.net (unknown [118.209.177.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82F3A328005D;
        Tue, 11 Feb 2020 04:53:02 -0500 (EST)
Message-ID: <30e120fdaee4234fcacea2c2fd1cc0aa95f755d3.camel@themaw.net>
Subject: Re: [patch] fs: fix use after free in get_tree_bdev
From:   Ian Kent <raven@themaw.net>
To:     Jeff Moyer <jmoyer@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 11 Feb 2020 17:52:58 +0800
In-Reply-To: <x49a75q1fg8.fsf@segfault.boston.devel.redhat.com>
References: <x49a75q1fg8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-10 at 13:10 -0500, Jeff Moyer wrote:
> Commit 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in
> get_tree_bdev()")
> introduced a use-after-free of the bdev.  This was caught by fstests
> generic/085, which now results in a kernel panic.  Fix it.

Oops!
Thanks Jeff.

Acked-by: Ian Kent <raven@themaw.net>

> 
> Cc: stable@vger.kernel.org # v5.4+
> Fixes: 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in
> get_tree_bdev()")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/fs/super.c b/fs/super.c
> index cd352530eca9..a288cd60d2ae 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1302,8 +1302,8 @@ int get_tree_bdev(struct fs_context *fc,
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
>  	if (bdev->bd_fsfreeze_count > 0) {
>  		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		blkdev_put(bdev, mode);
>  		warnf(fc, "%pg: Can't mount, blockdev is frozen",
> bdev);
> +		blkdev_put(bdev, mode);
>  		return -EBUSY;
>  	}
>  
> 

