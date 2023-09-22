Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D307AAE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjIVJeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjIVJdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:33:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B651B2;
        Fri, 22 Sep 2023 02:33:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B35AD5C02AA;
        Fri, 22 Sep 2023 05:33:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Sep 2023 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695375225; x=1695461625; bh=fv6T8BTqNkPx4jUIYjRek+Zs0clEKtCxgTn
        B6FxWGCw=; b=i3nM40jij4I984LClHOriPJA56klkl5FY5AepJOld99IVG8cegQ
        yOOPzMWOk9Jag8wzIt5CZsGQDo/AIvCSWOkRFt1aaP4SOkSgGM58T0LHob+TxenB
        +GWdkPPRjPm4BylfdUo/fzBcesRvTYobCWNcOBBL+NPZDEDNshKSAzbO51syPwVv
        krNG+I3zfsIqZ4ar7QrFWBS3r1oMFaY015PAGVaAgE3xks5Z24R39sEpe4b1chdJ
        aUHGatl7UFb44qicf7spJOFdTFAXy2+jPZUnU2GdW+hwwuIk21Fw2Su9Qi1W0Kqu
        SLKX1HvGSDT3zAf5BJJDUv4t3J7b0veDkYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695375225; x=1695461625; bh=fv6T8BTqNkPx4jUIYjRek+Zs0clEKtCxgTn
        B6FxWGCw=; b=Z2DTRPg9rRaozL3uj6C/42iWObK4gSFHvZGeGVnrpdm1Lh2IHUe
        TtUt+HC1knZGkuT+Ew8lEuNA+cTwHaqRgLde3G5H1IWL3W5bkomPipCZ7h2mgAsW
        WdSYnaCCOUr50VocRVsjr3/X4wQq230fyk7DX/D5ljRdBv+jpxKvvWOTafbFuR3+
        cmb7fDSekl9MrIfM+MUvOyJkpnKo0jKpEdo6nLjaQ3FkM6RzldRk4jGpOnXBI5qY
        d9gkZxNGsanGRd7d6rzC1S/j0JEULFF5DZkxp5FIhdhe72AIN1OvS5/IToO/M51r
        CWjnxRl7oCY+p+7UVxz+Z9yQNMeF6sOpF2g==
X-ME-Sender: <xms:eV8NZQby7R2BwIUqGHPH45qKs_YIkBBw1akWBd7iauu26Iqp9HJARg>
    <xme:eV8NZbaMPx_5J_jJxI67clMH7HGihzYWm4_saPgnjGfUMOC115tptu9IQrEmb64oB
    4GgqtekEbZT>
X-ME-Received: <xmr:eV8NZa_FounO79UsHqV87UFfrOQVlH0rHAiW3-2-Fhcj7H0r0gOpSTrDK6v_i29YppjjYnbv1ra7dLWQVJiH8lAa3rFH1ejjM8UOtkcSIeAaIIpEj84G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:eV8NZarRIPwyd51X041aYpvBBDOvpPZkgqY12ft0UiR1eAO_wlhaug>
    <xmx:eV8NZbrFU8cfdOUFX1oER6l-FLGrxyWZKxJ4s1-bcRDEkXvsOcoc1w>
    <xmx:eV8NZYTorjbQ4hrQaZ03OvFCi1tU1nsF5ERfOgIWrVihW4kp9JchWQ>
    <xmx:eV8NZcCyafNeQxPZWbQQV6QF9WL5vE4I604DQFKwZ7pq5qB5ep7Qaw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 05:33:41 -0400 (EDT)
Message-ID: <d3b89797-8065-4b75-69dd-1d602e9f7c09@themaw.net>
Date:   Fri, 22 Sep 2023 17:33:37 +0800
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
 <20230922-appell-vordach-1608445c5251@brauner>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230922-appell-vordach-1608445c5251@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/9/23 16:31, Christian Brauner wrote:
> On Fri, Sep 22, 2023 at 12:12:14PM +0800, Ian Kent wrote:
>> Convert the autofs filesystem to use the mount API.
>>
>> The conversion patch was originally written by David Howells.
>> I have taken that patch and broken it into several patches in an effort
>> to make the change easier to review.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>   fs/autofs/autofs_i.h |   5 +-
>>   fs/autofs/init.c     |   9 +-
>>   fs/autofs/inode.c    | 247 ++++++++++++++++++++++++-------------------
>>   3 files changed, 142 insertions(+), 119 deletions(-)
>>
>> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
>> index c24d32be7937..244f18cdf23c 100644
>> --- a/fs/autofs/autofs_i.h
>> +++ b/fs/autofs/autofs_i.h
>> @@ -25,6 +25,8 @@
>>   #include <linux/completion.h>
>>   #include <linux/file.h>
>>   #include <linux/magic.h>
>> +#include <linux/fs_context.h>
>> +#include <linux/fs_parser.h>
>>   
>>   /* This is the range of ioctl() numbers we claim as ours */
>>   #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
>> @@ -205,7 +207,8 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
>>   
>>   /* Initializing function */
>>   
>> -int autofs_fill_super(struct super_block *, void *, int);
>> +extern const struct fs_parameter_spec autofs_param_specs[];
>> +int autofs_init_fs_context(struct fs_context *fc);
>>   struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
>>   void autofs_clean_ino(struct autofs_info *);
>>   
>> diff --git a/fs/autofs/init.c b/fs/autofs/init.c
>> index d3f55e874338..b5e4dfa04ed0 100644
>> --- a/fs/autofs/init.c
>> +++ b/fs/autofs/init.c
>> @@ -7,16 +7,11 @@
>>   #include <linux/init.h>
>>   #include "autofs_i.h"
>>   
>> -static struct dentry *autofs_mount(struct file_system_type *fs_type,
>> -	int flags, const char *dev_name, void *data)
>> -{
>> -	return mount_nodev(fs_type, flags, data, autofs_fill_super);
>> -}
>> -
>>   struct file_system_type autofs_fs_type = {
>>   	.owner		= THIS_MODULE,
>>   	.name		= "autofs",
>> -	.mount		= autofs_mount,
>> +	.init_fs_context = autofs_init_fs_context,
>> +	.parameters	= autofs_param_specs,
>>   	.kill_sb	= autofs_kill_sb,
>>   };
>>   MODULE_ALIAS_FS("autofs");
>> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
>> index e2026e063d8c..3f2dfed428f9 100644
>> --- a/fs/autofs/inode.c
>> +++ b/fs/autofs/inode.c
>> @@ -6,7 +6,6 @@
>>   
>>   #include <linux/seq_file.h>
>>   #include <linux/pagemap.h>
>> -#include <linux/parser.h>
>>   
>>   #include "autofs_i.h"
>>   
>> @@ -111,7 +110,6 @@ static const struct super_operations autofs_sops = {
>>   };
>>   
>>   enum {
>> -	Opt_err,
>>   	Opt_direct,
>>   	Opt_fd,
>>   	Opt_gid,
>> @@ -125,35 +123,48 @@ enum {
>>   	Opt_uid,
>>   };
>>   
>> -static const match_table_t tokens = {
>> -	{Opt_fd, "fd=%u"},
>> -	{Opt_uid, "uid=%u"},
>> -	{Opt_gid, "gid=%u"},
>> -	{Opt_pgrp, "pgrp=%u"},
>> -	{Opt_minproto, "minproto=%u"},
>> -	{Opt_maxproto, "maxproto=%u"},
>> -	{Opt_indirect, "indirect"},
>> -	{Opt_direct, "direct"},
>> -	{Opt_offset, "offset"},
>> -	{Opt_strictexpire, "strictexpire"},
>> -	{Opt_ignore, "ignore"},
>> -	{Opt_err, NULL}
>> +const struct fs_parameter_spec autofs_param_specs[] = {
>> +	fsparam_flag	("direct",		Opt_direct),
>> +	fsparam_fd	("fd",			Opt_fd),
>> +	fsparam_u32	("gid",			Opt_gid),
>> +	fsparam_flag	("ignore",		Opt_ignore),
>> +	fsparam_flag	("indirect",		Opt_indirect),
>> +	fsparam_u32	("maxproto",		Opt_maxproto),
>> +	fsparam_u32	("minproto",		Opt_minproto),
>> +	fsparam_flag	("offset",		Opt_offset),
>> +	fsparam_u32	("pgrp",		Opt_pgrp),
>> +	fsparam_flag	("strictexpire",	Opt_strictexpire),
>> +	fsparam_u32	("uid",			Opt_uid),
>> +	{}
>>   };
>>   
>> -static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
>> +struct autofs_fs_context {
>> +	kuid_t	uid;
>> +	kgid_t	gid;
>> +	int	pgrp;
>> +	bool	pgrp_set;
>> +};
>> +
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
>> @@ -167,58 +178,43 @@ static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
>>   	return 0;
>>   }
>>   
>> -static int autofs_parse_param(char *optstr, struct inode *root,
>> -			      int *pgrp, bool *pgrp_set,
>> -			      struct autofs_sb_info *sbi)
>> +static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   {
>> -	substring_t args[MAX_OPT_ARGS];
>> -	int option;
>> -	int pipefd = -1;
>> +	struct autofs_fs_context *ctx = fc->fs_private;
>> +	struct autofs_sb_info *sbi = fc->s_fs_info;
>> +	struct fs_parse_result result;
>>   	kuid_t uid;
>>   	kgid_t gid;
>> -	int token;
>> -	int ret;
>> +	int opt;
>>   
>> -	token = match_token(optstr, tokens, args);
>> -	switch (token) {
>> +	opt = fs_parse(fc, autofs_param_specs, param, &result);
>> +	if (opt < 0)
>> +		return opt;
>> +
>> +	switch (opt) {
>>   	case Opt_fd:
>> -		if (match_int(args, &pipefd))
>> -			return 1;
>> -		ret = autofs_parse_fd(sbi, pipefd);
>> -		if (ret)
>> -			return 1;
>> -		break;
>> +		return autofs_parse_fd(fc, result.int_32);
>>   	case Opt_uid:
>> -		if (match_int(args, &option))
>> -			return 1;
>> -		uid = make_kuid(current_user_ns(), option);
>> +		uid = make_kuid(current_user_ns(), result.uint_32);
>>   		if (!uid_valid(uid))
>>   			return 1;
> This and the make_kgid() instance below need to return -EINVAL or use
> invalfc() to return an error message. I can fix this up though so no
> need to resend for this.


Right you are, sorry about that and thanks very much for fixing it for

me.


Ian

Ian

