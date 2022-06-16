Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411354EDBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379313AbiFPXBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiFPXBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:01:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282FB62A1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 16:01:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id m16so401464ilf.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxYlFYa08li+b2bH2lpzssUgCCuwu/1aYyeRjozsoxA=;
        b=WI575e9Yb3UURQikbwMwnVlY7aFjJ5HZCCsnkaOWrdzEauSAVut+sqOcHZgLf0S7xa
         zqp6pmpRe8FHVecMzWb/PTiZZfyk5w2koS6iDe4Vg1KswQd3pBxNC++CyRGIgIveOAOf
         EDkFaZlrYPNMKdPMa8l9eLQGJYIp65QDsGwnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxYlFYa08li+b2bH2lpzssUgCCuwu/1aYyeRjozsoxA=;
        b=XwJDC5l07axSBX3ZT/vYxclKhuiul0U5SwYXMZJHyUc3wjI/Cmemm2c1476vDotB2b
         nRz3PDfP0HfAsE/k39kWws0KlG76zFKkvAfhCqFAKRUus/5+k9RjECqz+1pXavSuoJdz
         KDEDpEVJLS7wKqRZY/enbmrdk3SFAgqDkdGRbVzP/MXoBEaM7tYwMtXKbukh5N179rSQ
         7xUbsUzYCE4nh73RUgazgfBEvNW7YMJrURzjadUKWo22hmaGoUQuTcMviZK11/ruiFMl
         VogQZCGBOXp3KXwDqM+Nkoher+gHMBHtJEK89PgQDEaMO11UsWjvZNCLKftn7K+CI63k
         e59Q==
X-Gm-Message-State: AJIora+j1KxfLO5XxUW0QzYZ51+Ow1g8XOYkOmB3Prq2sB8tSuV7Ebsw
        AYOTv/8O2EfDwjb/+1sKmzXW0A==
X-Google-Smtp-Source: AGRyM1s7LIyJLY6T2Uw2EEkj6wJqA6dr2rUEctCYF7at0sSK8+Zh7zsCGDCfSXKU0oW2S2jL2LftaQ==
X-Received: by 2002:a05:6e02:152f:b0:2d4:980:a529 with SMTP id i15-20020a056e02152f00b002d40980a529mr4197820ilu.72.1655420509530;
        Thu, 16 Jun 2022 16:01:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s71-20020a02514a000000b0033171dafaa0sm1414627jaa.178.2022.06.16.16.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:01:49 -0700 (PDT)
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Dylan Hatch <dylanbhatch@google.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220616211016.4037482-1-dylanbhatch@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 17:01:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220616211016.4037482-1-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/16/22 3:10 PM, Dylan Hatch wrote:
> This test would erroneously fail the /proc/$PID/maps case if
> vsyscall=xonly since the existing probe of the vsyscall page only
> succeeds if the process has read permissions. Fix this by checking for
> either no vsyscall mapping OR an execute-only vsyscall mapping in the
> case were probing the vsyscall page segfaults.
> 

Does this fix include skipping the test with a clear message that
says why test is skipped?

> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> ---
>   tools/testing/selftests/proc/proc-pid-vm.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index 28604c9f805c..5ca85520131f 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -213,9 +213,12 @@ static int make_exe(const uint8_t *payload, size_t len)
>   
>   static bool g_vsyscall = false;
>   
> -static const char str_vsyscall[] =
> +static const char str_vsyscall_rx[] =
>   "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
>   
> +static const char str_vsyscall_x[] =
> +"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
> +
>   #ifdef __x86_64__
>   static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
>   {
> @@ -261,6 +264,7 @@ int main(void)
>   	int exec_fd;
>   
>   	vsyscall();
> +	const char *str_vsyscall = g_vsyscall ? str_vsyscall_rx : str_vsyscall_x;
>   
>   	atexit(ate);
>   
> @@ -314,7 +318,8 @@ int main(void)
>   
>   	/* Test /proc/$PID/maps */
>   	{
> -		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
> +		const size_t len_buf0 = strlen(buf0);
> +		const size_t len_vsys = strlen(str_vsyscall);
>   		char buf[256];
>   		ssize_t rv;
>   		int fd;
> @@ -325,11 +330,16 @@ int main(void)
>   			return 1;
>   		}
>   		rv = read(fd, buf, sizeof(buf));
> -		assert(rv == len);
> -		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
>   		if (g_vsyscall) {
> -			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
> +			assert(rv == len_buf0 + len_vsys);
> +		} else {
> +			/* If vsyscall isn't readable, it's either x-only or not mapped at all */
> +			assert(rv == len_buf0 + len_vsys || rv == len_buf0);
>   		}
> +		assert(memcmp(buf, buf0, len_buf0) == 0);
> +		/* Check for vsyscall mapping if buf is long enough */
> +		if (rv == len_buf0 + len_vsys)
> +			assert(memcmp(buf + len_buf0, str_vsyscall, len_vsys) == 0);
>   	}
>   
>   	/* Test /proc/$PID/smaps */
> 

The change looks good to me. Doesn't look like it skips the test though?

thanks,
-- Shuah
