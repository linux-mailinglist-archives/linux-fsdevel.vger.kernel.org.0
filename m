Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA87AB2AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjIVN15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjIVN14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:27:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C914192;
        Fri, 22 Sep 2023 06:27:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 637D5320093F;
        Fri, 22 Sep 2023 09:27:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Sep 2023 09:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695389265; x=1695475665; bh=LuxxLYk2qqlqP0nAsR9F6xL5nJmSGtQ1WKf
        67JfCnuA=; b=ZsG3dVOabGAGbT50rXUlY7kCmtKhDCL4GmHzbrRC07MeFCUGMKA
        uf/KrbFjZ2tv3ya5ZsQ5P208jttzbrSEEH76Ug+eXmxFO/2lyEgHgM7C1RM9NCxv
        25QN/j6gHgxYOK1duu+E+pZS+3JlPbyMweHO+Hu7K63Hvw1sJ+wsuQVo+vbWD2P+
        OXMaQJd2vds9ptK6AYxoqB6WloI2s+bA0hNu3VLEoBhv44l3txHd1zQCgRcUVDCz
        5vLXArzQnsL/XNKHEEwemDys4kya2HP8Mz/BSSbyS/S80Osv9kLcADzp2gzFZwGZ
        kWp9a1LolgOTT9ZAGSB+iE1r6GdRKW6OPVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695389265; x=1695475665; bh=LuxxLYk2qqlqP0nAsR9F6xL5nJmSGtQ1WKf
        67JfCnuA=; b=IwMt3tXZS1i8gxYXW4cLDi4qT5CqPfY96PAzXGWJdjPwyKC4Zu1
        DIN4GdGmBDtTnwXaPhqvfwX7fPVvbruQ0tEpcVeXN1v5ERKwS6mQvb/WAygfJwbj
        uCbkN/VH7Z8cpStMBEe3O3EoUBdb44P0CqSu8N6b1w7mMdrCdFIL/lHBl0aSRSOS
        r9Gb6k9RGC7rTQJ6Fb26arG6F5qXKY8vQ/i5eiLdzw7MPcuDEEUppAzGn/NgNUYG
        bbE7H6emzCfRK7q93EJtnuNjwlSE9+1BzLVPQu1alGdfHXXmPPFEoogHjb2LexcA
        +055fcsT2m6IbJ8KY16q7n/TGLG8Z4didcA==
X-ME-Sender: <xms:UZYNZYSHMN7zgVWDMrDk2X322YccMTd7bcFNnHGl6wi_9jZ8vF2tqA>
    <xme:UZYNZVxnEOJU6_zyK_k_KRt5-FxU2_7IFKT4RITPwwMwolqGz4888FKGstq5QB9N7
    B8eyc0Jf3sW>
X-ME-Received: <xmr:UZYNZV0CCQZtWUqhobquwv6ZelLWK21CQKAwTWAI4A2V_0oIWLEwCnTG0A2zPyXAE6NaNUl5SLIh9pHq-jNRYJtCn8qHZT-5T3oWqDcW8g8SBu5aJURN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:UZYNZcD7lMIIoEak8DdQdyF23-xgPZOF2s5ibugk7ehynGWwu0yfmw>
    <xmx:UZYNZRh14YQwPI-do33ZnfvmBLWM0No65eh95Xf3-sGBR5w6Xe_0gQ>
    <xmx:UZYNZYoHOWY97z3MxbiaCgQ_MuBXDTnSKnUv3QEOrtyTJGTOtl-UiA>
    <xmx:UZYNZfagp1YlEc9VtQknR96JL4cCBJdpEUQd8E3RVxp4cgXKyl-o4A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 09:27:41 -0400 (EDT)
Message-ID: <7121dcf7-23fe-07a5-9df4-9ea7af6f5964@themaw.net>
Date:   Fri, 22 Sep 2023 21:27:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] autofs: convert autofs to use the new mount api
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
References: <20230922041215.13675-1-raven@themaw.net>
 <20230922041215.13675-8-raven@themaw.net>
 <20230922-vorbringen-spaghetti-946729122076@brauner>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230922-vorbringen-spaghetti-946729122076@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/9/23 19:59, Christian Brauner wrote:
>> +	fsparam_fd	("fd",			Opt_fd),
>> +/*
>> + * Open the fd.  We do it here rather than in get_tree so that it's done in the
>> + * context of the system call that passed the data and not the one that
>> + * triggered the superblock creation, lest the fd gets reassigned.
>> + */
>> +static int autofs_parse_fd(struct fs_context *fc, int fd)
>>   {
>> +	struct autofs_sb_info *sbi = fc->s_fs_info;
>>   	struct file *pipe;
>>   	int ret;
>>   
>>   	pipe = fget(fd);
>>   	if (!pipe) {
>> -		pr_err("could not open pipe file descriptor\n");
>> +		errorf(fc, "could not open pipe file descriptor");
>>   		return -EBADF;
>>   	}
>>   
>>   	ret = autofs_check_pipe(pipe);
>>   	if (ret < 0) {
>> -		pr_err("Invalid/unusable pipe\n");
>> +		errorf(fc, "Invalid/unusable pipe");
>>   		fput(pipe);
>>   		return -EBADF;
>>   	}
>> +static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   {
>> +		return autofs_parse_fd(fc, result.int_32);
> Mah, so there's a difference between the new and the old mount api that we
> should probably hide on the VFS level for fsparam_fd. Basically, if you're
> coming through the new mount api via fsconfig(FSCONFIG_SET_FD, fd) then the vfs
> will have done param->file = fget(fd) for you already so there's no need to
> call fget() again. We can just take ownership of the reference that the vfs
> took for us.
>
> But if we're coming in through the old mount api then we need to call fget.
> There's nothing wrong with your code but it doesn't take advantage of the new
> mount api which would be unfortunate. So I folded a small extension into this
> see [1].
>
> There's an unrelated bug in fs_param_is_fd() that I'm also fixing see [2].

Ok, that's interesting, I'll have a look at these developments tomorrow,

admittedly (obviously) I hadn't looked at the code for some time ...


Ian

>
> I've tested both changes with the old and new mount api.
>
> [1]:
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 3f2dfed428f9..0477bce7d277 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -150,13 +150,20 @@ struct autofs_fs_context {
>    * context of the system call that passed the data and not the one that
>    * triggered the superblock creation, lest the fd gets reassigned.
>    */
> -static int autofs_parse_fd(struct fs_context *fc, int fd)
> +static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
> +                          struct fs_parameter *param,
> +                          struct fs_parse_result *result)
>   {
> -       struct autofs_sb_info *sbi = fc->s_fs_info;
>          struct file *pipe;
>          int ret;
>
> -       pipe = fget(fd);
> +       if (param->type == fs_value_is_file) {
> +               /* came through the new api */
> +               pipe = param->file;
> +               param->file = NULL;
> +       } else {
> +               pipe = fget(result->uint_32);
> +       }
>          if (!pipe) {
>                  errorf(fc, "could not open pipe file descriptor");
>                  return -EBADF;
> @@ -165,14 +172,15 @@ static int autofs_parse_fd(struct fs_context *fc, int fd)
>          ret = autofs_check_pipe(pipe);
>          if (ret < 0) {
>                  errorf(fc, "Invalid/unusable pipe");
> -               fput(pipe);
> +               if (param->type != fs_value_is_file)
> +                       fput(pipe);
>                  return -EBADF;
>          }
>
>          if (sbi->pipe)
>                  fput(sbi->pipe);
>
> -       sbi->pipefd = fd;
> +       sbi->pipefd = result->uint_32;
>          sbi->pipe = pipe;
>
>          return 0;
>
> [2]:
>  From 2f9171200505c82e744a235c85377e36ed190109 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Fri, 22 Sep 2023 13:49:05 +0200
> Subject: [PATCH] fsconfig: ensure that dirfd is set to aux
>
> The code in fs_param_is_fd() expects param->dirfd to be set to the fd
> that was used to set param->file to initialize result->uint_32. So make
> sure it's set so users like autofs using FSCONFIG_SET_FD with the new
> mount api can rely on this to be set to the correct value.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/fsopen.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index ce03f6521c88..6593ae518115 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -465,6 +465,7 @@ SYSCALL_DEFINE5(fsconfig,
>   		param.file = fget(aux);
>   		if (!param.file)
>   			goto out_key;
> +		param.dirfd = aux;
>   		break;
>   	default:
>   		break;
