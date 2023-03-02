Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237E56A8C63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCBW6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCBW6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:58:41 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4138037;
        Thu,  2 Mar 2023 14:58:38 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2A9E13F301;
        Thu,  2 Mar 2023 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677797915;
        bh=nkU4U7NSmjI2zWgPD+AtYN7NNzpxjnc7tmq01qgN89k=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QkcSCzV3s2aj6boz+mHxWsvucqomXVM/UQMrhA8Io4U8bKBeQ81oMS6ckekAuDzcQ
         nkee4Drs6MUphvNdT3zxLyELL0QBD3OjNecncPrTQ+WRLaN25mbdEPFtaIB/hxBYjZ
         6LQWJNNw1PSTwYQ9GiuttKxMpIh3lrywy15enDkd4vPX4jww9qJK/F3V6v+YoVGM8p
         KwJTSxjKOR0eVcxtl4LhCOnUwTRrQuiV6DbFt5hbn1WrxG7+UhtfmpUHN3F3VQ90D6
         3Txt4UavSwO0JpLNRp9W8onES1k7FXy6P1GVHKx0l9OcE5dMacEx5bs89r2WVKcrd2
         wQtRYLKHRCkVg==
Message-ID: <257aa5c0-144b-b157-0270-0a7f470c195b@canonical.com>
Date:   Thu, 2 Mar 2023 14:58:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/11] loadpin: simplify sysctls use with
 register_sysctl()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-6-mcgrof@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230302202826.776286-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/23 12:28, Luis Chamberlain wrote:
> register_sysctl_paths() is not required, we can just use
> register_sysctl() with the required path specified.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/loadpin/loadpin.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index d73a281adf86..c971464b4ad5 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -52,12 +52,6 @@ static bool deny_reading_verity_digests;
>   #endif
>   
>   #ifdef CONFIG_SYSCTL
> -static struct ctl_path loadpin_sysctl_path[] = {
> -	{ .procname = "kernel", },
> -	{ .procname = "loadpin", },
> -	{ }
> -};
> -
>   static struct ctl_table loadpin_sysctl_table[] = {
>   	{
>   		.procname       = "enforce",
> @@ -262,7 +256,7 @@ static int __init loadpin_init(void)
>   		enforce ? "" : "not ");
>   	parse_exclude();
>   #ifdef CONFIG_SYSCTL
> -	if (!register_sysctl_paths(loadpin_sysctl_path, loadpin_sysctl_table))
> +	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table))
>   		pr_notice("sysctl registration failed!\n");
>   #endif
>   	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");

