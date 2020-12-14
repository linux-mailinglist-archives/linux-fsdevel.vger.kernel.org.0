Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087702D92ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 06:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgLNFqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 00:46:15 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9101 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388513AbgLNFqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:46:13 -0500
X-IronPort-AV: E=Sophos;i="5.78,417,1599494400"; 
   d="scan'208";a="102362932"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2020 13:45:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 3136F4CE600E;
        Mon, 14 Dec 2020 13:45:17 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Dec
 2020 13:45:17 +0800
Subject: Re: [PATCH] fuse: clean up redundant assignment
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201126040313.141513-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <53733a62-c04c-48b4-af0c-e8bcaeca948b@cn.fujitsu.com>
Date:   Mon, 14 Dec 2020 13:43:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201126040313.141513-1-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 3136F4CE600E.A9581
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi guys,

any ideas?


--
Thanks,
Ruan Shiyang.

On 2020/11/26 下午12:03, Shiyang Ruan wrote:
> The 'err' was assigned to -ENOMEM in just few lines above, no need to be
> assigned again.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   fs/fuse/dir.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ff7dbeb16f88..f28eb54517ff 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -528,7 +528,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>   	if (!forget)
>   		goto out_err;
>   
> -	err = -ENOMEM;
>   	ff = fuse_file_alloc(fm);
>   	if (!ff)
>   		goto out_put_forget_req;
> 


