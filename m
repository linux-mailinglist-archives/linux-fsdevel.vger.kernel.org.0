Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279856A9F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjCCSpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjCCSpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:45:30 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A07912BE3;
        Fri,  3 Mar 2023 10:45:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9B6FA3200437;
        Fri,  3 Mar 2023 13:45:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Mar 2023 13:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1677869107; x=1677955507; bh=czCFFzFaQjnmq2jNbCJAn96qNvrXg7kn6ZW
        3+GAl8rY=; b=UgNeXOGBiEOT2K0HO9CO8DUA56pg5dnquriQOI30B2JrykFlDk0
        1PzG9LcwcuqcCsE33Vblr+5A+OF40vcaoeNcvywMP1/3WAVwWABoiCoX2deXBbKO
        p7MaVZLQxBXl44D5UnEBSQdztpUFNPU5nXhTstynMSuShMSfxnIXi/ZMuZ7fRmu7
        MiGGmEVwrHV1puqWa3PKIwOE0VTtDBhf9fajtV7/SLFH/f1YQcKzkXtxfDCiAi0z
        HSCAWdzHe4c6f83+cxem9OaubwEdo+k2FNqTNio1GlC/sPbt04CfDjiaEBJV0IS+
        1xQmw8V3cQzQUfiqsgNdJkylpXFS+Sr8VeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677869107; x=1677955507; bh=czCFFzFaQjnmq2jNbCJAn96qNvrXg7kn6ZW
        3+GAl8rY=; b=eJ38k9/tbcMP5V3O1H8T4a+hJ3eYleAWW3FMcX/436K1vJRVD9m
        hBrGLTCXKDEWy6907MjpGqtbcZhgeG5+VmucHbMTYwbcrVog/jlRUNiHAqXVNrfT
        wwfR0SosDGCUqWktWiCAgcokYEIbHgh0us02Azd6eGpVHK2a18cfPzcdh4TtdWFh
        InoBaLFfXSMVG1VbV+Ob7glh9W7UVzO/pAaHlWkGeaGlyswh1m8hlsTKkuMjQor0
        m+Ur+XaZcKb973BbnvXJWlCK/HO4aov0FTP1h0/JYrDZTcytDpfQ5HCLfvcgYwKz
        M5tykf9NLbuRRRUKkhXGReeD4dCVpewQQeg==
X-ME-Sender: <xms:MkACZI-B57VzZEGcHr3HewJZmTNTYn3BYhRkzrSMt2fPiAdyAEdDnA>
    <xme:MkACZAvAwiuQcQXA34thnddb8TQWJRe0wlcCUVw10rhVcKcL6b7yl8ySun_sONHHH
    -2iP8I168CtUGEK>
X-ME-Received: <xmr:MkACZOD--SVGmwC5Okha9TKVWpe_5_VyXlWRTW71blT48sp1zgxkVhRux4bTf91cvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:MkACZIcx0kEajpXtZKxiVQkAzfcPs9qN2VgMNGfPB5jMrFnxCvHDQA>
    <xmx:MkACZNMkttVwaiAfDZNQZntjG3dCNr6ntf-tZNZ2qZd-i8q6ojL35Q>
    <xmx:MkACZCncDRGQY2Skq_JC0hmVZOe1A9JxaAC5hGeH_LjOuosKvCuQkg>
    <xmx:M0ACZOGRiw84xv1VuH5jnLXob_I_3GDZxVwJYXQljv0ndagOXYCE1w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 13:45:05 -0500 (EST)
Message-ID: <ba148a1a-26da-4fcc-e24c-b1f79d9ba014@fastmail.fm>
Date:   Fri, 3 Mar 2023 19:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 6/9] fuse: take fuse connection generation into
 account
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mszeredi@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-7-aleksandr.mikhalitsyn@canonical.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230220193754.470330-7-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


[...]
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index d5b30faff0b9..be9086a1868d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -110,7 +110,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
>   	if (refcount_dec_and_test(&ff->count)) {
>   		struct fuse_args *args = &ff->release_args->args;
>   
> -		if (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open) {
> +		if (fuse_stale_ff(ff) ||
> +		    (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open)) {
>   			/* Do nothing when client does not implement 'open' */

The comment does not match anymore.

>   			fuse_release_end(ff->fm, args, 0);
>   		} else if (sync) {
> @@ -597,9 +598,10 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
>   {
>   	struct inode *inode = file->f_mapping->host;
>   	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_file *ff = file->private_data;
>   	int err;
>   
> -	if (fuse_is_bad(inode))
> +	if (fuse_stale_ff(ff) || fuse_is_bad(inode))
>   		return -EIO;
>   
>   	inode_lock(inode);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 4f4a6f912c7c..0643de31674d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -954,7 +954,8 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
>   				    struct fuse_attr *attr)
>   {
>   	return inode->i_generation != generation ||
> -		inode_wrong_type(inode, attr->mode);
> +		inode_wrong_type(inode, attr->mode) ||
> +		fuse_stale_inode_conn(inode);
>   }
>   
>   static inline void fuse_make_bad(struct inode *inode)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c3109e016494..f9dc8971274d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
>   			fuse_dax_inode_cleanup(inode);
>   		if (fi->nlookup) {
>   			fuse_queue_forget(fc, fi->forget, fi->nodeid,
> -					  fi->nlookup, false);
> +					  fi->nlookup, fuse_stale_inode_conn(inode));
>   			fi->forget = NULL;
>   		}
>   	}
