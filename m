Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2909C26572C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgIKC5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgIKC5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:57:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF94C0617A4;
        Thu, 10 Sep 2020 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HFnsD6JV3NOwtLdRVNqcKu08NGR+4LMb6IvOb5ypRuI=; b=Le2NgUZpmKT76kcFn1NILh9Gxl
        ka6REOFA1eLEHwsZtOksCBvgTArjAx2SGB38XhZYSme2MgW8z62IgocJ0uVW9qdBmWyV3QVaA3leu
        oFnLgQCARdDm2dKjCxn0Wyw+37jsAgab8owQ1zvjP4vRQe5NjeKqKPyC2inSnKuZmnTkQgRlbPQWh
        YA5COXz8/iA5LeGzWHSUpt6eokOlLjgH8/uC9GSg2KcJf35IzwF4d4+Xn19I1U23/LJYGDcD8RSGP
        8Xvxd+H15dSAzG4h+iZC3k1QDJQvnF37KJgC3m+KhXg4Tvmz3gGJL2tb+VeCKq7TxQ8Yd5xQihEV2
        znxaOM+g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGZFg-000203-7h; Fri, 11 Sep 2020 02:57:28 +0000
Subject: Re: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
To:     Tianxianting <tian.xianting@h3c.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200905071525.12259-1-tian.xianting@h3c.com>
 <3808373d663146c882c22397a1d6587f@h3c.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <07de1867-e61c-07fb-8809-91d5e573329b@infradead.org>
Date:   Thu, 10 Sep 2020 19:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3808373d663146c882c22397a1d6587f@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/20 7:06 PM, Tianxianting wrote:
> Hi viro,
> Could I get your feedback?
> This patch fixed the build warning, I think it can be applied, thanks :) 
> 
> -----Original Message-----
> From: tianxianting (RD) 
> Sent: Saturday, September 05, 2020 3:15 PM
> To: viro@zeniv.linux.org.uk
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
> Subject: [PATCH] fs: use correct parameter in notes of generic_file_llseek_size()
> 
> Fix warning when compiling with W=1:
> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
> fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/read_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5db58b8c7..058563ee2 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
>   * @file:	file structure to seek on
>   * @offset:	file offset to seek to
>   * @whence:	type of seek
> - * @size:	max size of this file in file system
> + * @maxsize:	max size of this file in file system
>   * @eof:	offset used for SEEK_END position
>   *
>   * This is a variant of generic_file_llseek that allows passing in a custom
> 


-- 
~Randy
