Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE05AD152
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfIHX4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:56:19 -0400
Received: from sonic313-47.consmr.mail.gq1.yahoo.com ([98.137.65.110]:46683
        "EHLO sonic313-47.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731675AbfIHX4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567986978; bh=8Bw5voSTyYrsH2EAJhL50ttNNY3dDd4r+nOeI5GfOvg=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=tL/8v1jpjRvms20TUNCbAmRx/hdb5qPyZX8CthEXrsS++H29mh99uWuDhZuUn5dW/RuQjNtVb7fH3qhz4DdGxqhFw8D3TYQW5qZdlNqsA5QiPcY327ov14m8oxwY4LAMGszvJLASLnjHOFnor40OYZ1O1EJMY1yZVUHuuZyZZjNIbD7KFIgUb/xg0GU7g2xTyM9/mHt1zwqWV/Y0KFMct21VDiGj2Do4Uo8QYg11EjITLkaMOdk13XF7vZegHQZZ8lj1xnp5e6/5aNmrtY3VReG6KV7unBMz5k8w3IGP0TSo7NtEt0tzPDKsjzyyGcnzigEgW0CWqNJpRejFnpEeow==
X-YMail-OSG: J6SKBjYVM1mjNqKqQ3tXtlQ2CuiSFiySX37CDfVPT6pWvSJDNsYFAdWDyjgLNgz
 W4O45.ExIXNMOLRi84GdjesazT6pQ.IdxnITBU.I2M1Na.ioLp63wsw4hR1putkUB4G23V3XXH.f
 MXb5WIL4fJhcdS_gXe3oGCwTLQdYk60eXp9MABgS3ziXNTTP6FwINwPXIy_MsgWYD_fr9zbhYkmo
 t0kYM4rCjb9ttRq2JYvml1za2cEi7Of7ymlz3B203DTmd2yllgGjcYFestrxckUtFQB6vlbK3CGz
 NWEg2pe_695mjCV0uAu7P68gNr6WxjZgsvwiuR0jb3b_BIuQOu19qFd1LZUNU4TNe9BuVL2tqQNy
 SB6QhObYOIy07zyhFLIRU03Hw.j5bXBtbr.G6gclW95kSnkJMXkTWo3Atms85EMWUY2YcGB3_J5T
 TVXh9GuvJHspXclpLlgvMn2ymW7lTGldCOnhv9hRIaI9arVek4TQ8uWU2rs2C61VW4bVA_5I8aM7
 1NDq30wL1ckHgLoa.otgt_ZGv3fztY05..p6ePatmgoyb4eEYQWXj2zJ1d6HheFAL1tSApygb3UA
 loKoyS5.kJWkX5xgvXEQioefSMPxSG_COpteAJN5xJNa_hNNkFaBJXc3IuJ8xTa5F0xSLdPQRKNB
 69FGfNiygKp6w4KZpU_.vzgO3c6Kdj2zeNGm0FlzC7_aBuHybalJKi6.LiC9bxBprReOwEqdEWD8
 bGF_mn0pTgMmtoVxG.DhgMsL2DaDF__UhnwoNrKdN5KmCQ8MVvYqveYuKLZ3.PQax63UyR9s_KIo
 kTlH0FKKptH18ZIpczH5IyrBiPDl4Nd8TSUxway_KtZ_a_uc0LA0s3H.4vJzvddJOTyrwYH9nYHo
 SnlXqk6wCdq0blVDFIwzvIAQpEzId84f6pYr7vyg5Vt9UH3wHUpjHuqfPzYtk0VZd7WtArhJDaOO
 PbUGojP9qgjOnR4X.b3oT7ySXZv0oda8N_SwxA0K0LD55CKgH0lzmCAWPojHvQOwtqup3zO_zUkQ
 1CILTF7Wgmmdxs6tQBwQV34aGPkAnvaO9wVXdyKpI77.clbvoH7jnMxczbxOplTEy5LqBb8Qgt_z
 cbEwnFD2JSAIp2aEb2Euqsfl1m1SjrxdOqah5WdY_Scu03ZAggPT8gJfO7oEyOOVZ_qnHDOG6DWT
 CBWbY6Dl986wEj8bnTDh_vYuZBu6ft2mqucbGACzyi7JrXSFwWXoPnTUrWHDo.c0nJwnj8uEpOzR
 CTRsYIZMQFmpITJXao7rZ4e3JXjpqEiQ_OcTwjRFdk6hwQLEFPizLE9.rcK69cnjCzv7IZ0R68WZ
 uXrIBL9Dh1EAnaOV00cl3ZVx8_o8wCoH9pskcaMezpIn2aqq.Q3RMvnYmB5z1zZWFapL1E2XNXK2
 epV2g11X7x6NeSJIOwAgomIJ71_PAPEviBFsYzkzEX7hB0itAP6bgS26mxQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 8 Sep 2019 23:56:18 +0000
Received: by smtp416.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2eacc41cc96e05ff3db40f99becfb3a1;
          Sun, 08 Sep 2019 23:54:16 +0000 (UTC)
Date:   Mon, 9 Sep 2019 07:54:12 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH erofs-utils v2] build: cure compiler warnings
Message-ID: <20190908235409.GA9570@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190908214821.32265-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908214821.32265-1-jengelh@inai.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14303 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

(cc erofs mailing list...)

On Sun, Sep 08, 2019 at 11:48:21PM +0200, Jan Engelhardt wrote:
> On i586 I observe:
> 
> In file included from inode.c:16:
> inode.c: In function 'erofs_mkfs_build_tree':
> ../include/erofs/print.h:27:21: error: format '%lu' expects argument of type
> 'long unsigned int', but argument 7 has type 'erofs_nid_t' {aka 'long long unsigned int'} [-Werror=format=]
>    27 | #define pr_fmt(fmt) "EROFS: " FUNC_LINE_FMT fmt "\n"
> ../include/erofs/print.h:43:4: note: in expansion of macro 'pr_fmt'
>    43 |    pr_fmt(fmt),    \
> inode.c:792:3: note: in expansion of macro 'erofs_info'
>   792 |   erofs_info("add file %s/%s (nid %lu, type %d)",
> inode.c:792:37: note: format string is defined here
>   792 |   erofs_info("add file %s/%s (nid %lu, type %d)",

Thanks for your patch. This patch looks good to me, applied with
minor update (80 character per line) and adding a unique prefix to
the subject line.

I've been on vacation in Japan for about a week, could not be reply in time..

Thanks,
Gao Xiang

> ---
>  lib/compress.c | 4 ++--
>  lib/inode.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index a977c87..cadf598 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -457,8 +457,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
>  	DBG_BUGON(ret);
>  
> -	erofs_info("compressed %s (%lu bytes) into %u blocks",
> -		   inode->i_srcpath, inode->i_size, compressed_blocks);
> +	erofs_info("compressed %s (%llu bytes) into %u blocks",
> +		   inode->i_srcpath, (unsigned long long)inode->i_size, compressed_blocks);
>  
>  	/*
>  	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
> diff --git a/lib/inode.c b/lib/inode.c
> index 141a300..db9ad99 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -789,8 +789,8 @@ fail:
>  
>  		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
>  		erofs_d_invalidate(d);
> -		erofs_info("add file %s/%s (nid %lu, type %d)",
> -			   dir->i_srcpath, d->name, d->nid, d->type);
> +		erofs_info("add file %s/%s (nid %llu, type %d)",
> +			   dir->i_srcpath, d->name, (unsigned long long)d->nid, d->type);
>  	}
>  	erofs_write_dir_file(dir);
>  	erofs_write_tail_end(dir);
> -- 
> 2.23.0
> 
