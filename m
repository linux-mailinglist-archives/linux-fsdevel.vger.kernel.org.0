Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C6398D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFBO4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhFBO4V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CF09613B4;
        Wed,  2 Jun 2021 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622645678;
        bh=CMRWorkve5j9VMMOu1GS9nLuWySAM7tRxFor5CPGeyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uIlweWKVN5VnHOpjMBsC3ZymUoSB+/zw6E15DFHI6pN1degN/3CS2BO6EV6DtZ7C+
         6+l8WXTpq9NzPXrA4CCY4CKxmIT/ydfP+N9QAvUcTBlAvQnyLYWz8jkChuRIagCyHL
         Lkiy7ztQ0eeyJCNRBRQx6/bRKryr2BklC4KSfhBZIzw0xsAR8+TnHgtbnp/t/xkQ96
         du/yPC7zS7eZLIz9uYVntSQqR2pzSWsL8lUabl81qaMDlVAvjbRP557Od2c1H6Qzu4
         PkAuS6SMWutxk4N3w6yu/c82H1wjWhPlj0mkVHWDMgwjzgxN17/f3qymzCGFB8opQl
         EwzPyutsrPKUw==
Subject: Re: [PATCH 1/2] f2fs: Show casefolding support only when supported
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
References: <20210602041539.123097-1-drosen@google.com>
 <20210602041539.123097-2-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f5344d8e-aa94-f3ef-8f74-01f96103632a@kernel.org>
Date:   Wed, 2 Jun 2021 22:54:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602041539.123097-2-drosen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/6/2 12:15, Daniel Rosenberg wrote:
> The casefolding feature is only supported when CONFIG_UNICODE is set.
> This modifies the feature list f2fs presents under sysfs accordingly.
> 
> Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
