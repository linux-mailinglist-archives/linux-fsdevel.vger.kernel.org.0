Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BFF5F5A27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJESyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiJESyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:54:01 -0400
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Oct 2022 11:54:00 PDT
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461686E889
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:53:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjNyY57T3zMqGXm;
        Wed,  5 Oct 2022 20:53:57 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjNyX6tDfz3k;
        Wed,  5 Oct 2022 20:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664996037;
        bh=ljZRze/N/m9CPBbrjY5RWsT55yRxL6hGaxZnan724g0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JKxnmzq8JABtbqJNCp8orWwIluxUpJ41CZjEHY7+0VnddzsxzFPkYAcwDMjtaUC61
         qPX474+zaDpme2A4BX4yyYKV4NeX+kSuq28NpVxnMV3uXBQx28G7P/lGXcbDQb1Z3D
         eppc2o1jWMFhIP28VdJHVKq31RHpxOOyg4UlbpME=
Message-ID: <beb43471-48fa-9f8f-767c-a025db3bd660@digikod.net>
Date:   Wed, 5 Oct 2022 20:53:56 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 2/9] selftests/landlock: Locally define __maybe_unused
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for cleaning this. Can you please move this patch just before the 
test patches?


On 01/10/2022 17:49, Günther Noack wrote:
> The checkpatch tool started to flag __attribute__(__unused__), which
> we previously used. The header where this is normally defined is not
> currently compatible with selftests.
> 
> This is the same approach as used in selftests/net/psock_lib.h.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/common.h | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 7ba18eb23783..7d34592471db 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -17,6 +17,10 @@
>   
>   #include "../kselftest_harness.h"
>   
> +#ifndef __maybe_unused
> +#define __maybe_unused __attribute__((__unused__))
> +#endif
> +
>   /*
>    * TEST_F_FORK() is useful when a test drop privileges but the corresponding
>    * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
> @@ -140,14 +144,12 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>   }
>   
>   /* We cannot put such helpers in a library because of kselftest_harness.h . */
> -__attribute__((__unused__)) static void
> -disable_caps(struct __test_metadata *const _metadata)
> +static void __maybe_unused disable_caps(struct __test_metadata *const _metadata)
>   {
>   	_init_caps(_metadata, false);
>   }
>   
> -__attribute__((__unused__)) static void
> -drop_caps(struct __test_metadata *const _metadata)
> +static void __maybe_unused drop_caps(struct __test_metadata *const _metadata)
>   {
>   	_init_caps(_metadata, true);
>   }
> @@ -176,14 +178,14 @@ static void _effective_cap(struct __test_metadata *const _metadata,
>   	}
>   }
>   
> -__attribute__((__unused__)) static void
> -set_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
> +static void __maybe_unused set_cap(struct __test_metadata *const _metadata,
> +				   const cap_value_t caps)
>   {
>   	_effective_cap(_metadata, caps, CAP_SET);
>   }
>   
> -__attribute__((__unused__)) static void
> -clear_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
> +static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
> +				     const cap_value_t caps)
>   {
>   	_effective_cap(_metadata, caps, CAP_CLEAR);
>   }
