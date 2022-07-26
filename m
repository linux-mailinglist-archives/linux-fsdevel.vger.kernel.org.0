Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2DA580C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiGZHCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGZHCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768411A19;
        Tue, 26 Jul 2022 00:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B127861374;
        Tue, 26 Jul 2022 07:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18445C341CD;
        Tue, 26 Jul 2022 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658818963;
        bh=go+bvXX6X7Grn7l+6nOhjY0anqvIAvVpR0lLJyna+kg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IHDEy8v9aVTJuqnkYAFN+DrknKc9EBq0T8+cRJHTDvRkUCpu6fQdx7r3+3TrOhfYw
         wejFAG/NDLaMV8ztTOt68ZQ62cIj7m5z8F+An+HxQi/ljVpqtEf5AMcxPcXPl+1jza
         AOoZF+uG8jbwV6qVe5Z++PWhCXBx5JyjuGxu9FCFBEvc1Nbo5Whx6qKh25lNVusxpU
         HiosIT0B+AvQ12yZ2+DUC9fVJyLStxxG1hJas/BygKpQVp7WZiobSRDx6nUSdUWzvH
         b4d2Ll+TYs63zyhb/ID+vKxWHCM+Mj/WDfw9lqYVmMX+KZLcEa5QVLap/AiCSxZG7Q
         8HbJlOoBdnAnQ==
Received: by mail-wr1-f53.google.com with SMTP id v13so11059665wru.12;
        Tue, 26 Jul 2022 00:02:42 -0700 (PDT)
X-Gm-Message-State: AJIora+W/RaviDZd70ooh++WcvPT/GJIyTzU0e49gY503vSQOY3iAC2V
        2hrtCjRvUVZlZkLnUipQckArjDQCuyE1D7kjxcs=
X-Google-Smtp-Source: AGRyM1txSeWGlenvhfUKX16pjeQ9aRbuFF0X2fCivMQ2vCukJuqCAUP+YdoLmY5ZhDaWjupT4CTh2qQHkNCVgThTBvI=
X-Received: by 2002:a5d:6d0b:0:b0:21d:9f26:f84a with SMTP id
 e11-20020a5d6d0b000000b0021d9f26f84amr9862540wrq.155.1658818961280; Tue, 26
 Jul 2022 00:02:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f7cb:0:0:0:0:0 with HTTP; Tue, 26 Jul 2022 00:02:40
 -0700 (PDT)
In-Reply-To: <87edyc2r2e.wl-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de> <20220722142916.29435-4-tiwai@suse.de>
 <0350c21bcfdc896f2b912363f221958d41ebf1e1.camel@perches.com> <87edyc2r2e.wl-tiwai@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 26 Jul 2022 16:02:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_tohLszyrThNLE5tPHt=2Z8Xtt=hzzEQe3iqf0t549EQ@mail.gmail.com>
Message-ID: <CAKYAXd_tohLszyrThNLE5tPHt=2Z8Xtt=hzzEQe3iqf0t549EQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] exfat: Expand exfat_err() and co directly to pr_*() macro
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Joe Perches <joe@perches.com>, linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-07-23 17:04 GMT+09:00, Takashi Iwai <tiwai@suse.de>:
> On Sat, 23 Jul 2022 09:42:12 +0200,
> Joe Perches wrote:
>>
>> On Fri, 2022-07-22 at 16:29 +0200, Takashi Iwai wrote:
>> > Currently the error and info messages handled by exfat_err() and co
>> > are tossed to exfat_msg() function that does nothing but passes the
>> > strings with printk() invocation.  Not only that this is more overhead
>> > by the indirect calls, but also this makes harder to extend for the
>> > debug print usage; because of the direct printk() call, you cannot
>> > make it for dynamic debug or without debug like the standard helpers
>> > such as pr_debug() or dev_dbg().
>> >
>> > For addressing the problem, this patch replaces exfat_msg() function
>> > with a macro to expand to pr_*() directly.  This allows us to create
>> > exfat_debug() macro that is expanded to pr_debug() (which output can
>> > gracefully suppressed via dyndbg).
>> []
>> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> []
>> > @@ -508,14 +508,19 @@ void __exfat_fs_error(struct super_block *sb, int
>> > report, const char *fmt, ...)
>> >  #define exfat_fs_error_ratelimit(sb, fmt, args...) \
>> >  		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
>> >  		fmt, ## args)
>> > -void exfat_msg(struct super_block *sb, const char *lv, const char *fmt,
>> > ...)
>> > -		__printf(3, 4) __cold;
>> > +
>> > +/* expand to pr_xxx() with prefix */
>> > +#define exfat_msg(sb, lv, fmt, ...) \
>> > +	pr_##lv("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> > +
>> >  #define exfat_err(sb, fmt, ...)						\
>> > -	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
>> > +	exfat_msg(sb, err, fmt, ##__VA_ARGS__)
>> >  #define exfat_warn(sb, fmt, ...)					\
>> > -	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
>> > +	exfat_msg(sb, warn, fmt, ##__VA_ARGS__)
>> >  #define exfat_info(sb, fmt, ...)					\
>> > -	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
>> > +	exfat_msg(sb, info, fmt, ##__VA_ARGS__)
>> > +#define exfat_debug(sb, fmt, ...)					\
>> > +	exfat_msg(sb, debug, fmt, ##__VA_ARGS__)
>>
>> I think this would be clearer using pr_<level> directly instead
>> of an indirecting macro that uses concatenation of <level> that
>> obscures the actual use of pr_<level>
>>
>> Either: (and this first option would be my preference)
>>
>> #define exfat_err(sb, fmt, ...) \
>> 	pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> #define exfat_warn(sb, fmt, ...) \
>> 	pr_warn("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> etc...
>
> IMO, it's a matter of taste, and I don't mind either way.
> Just let me know.
Joe has already said that he prefers the first.
Will you send v2 patch-set ?

Thanks!
>
>> or using an indirecting macro:
>>
>> #define exfat_printk(pr_level, sb, fmt, ...)	\
>> 	pr_level("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>
> Is pr_level() defined anywhere...?
>
>>
>> and btw, there are multiple uses of exfat_<level> output with a
>> unnecessary and duplicated '\n' that the macro already adds that
>> should be removed:
>>
>> $ git grep -P -n '\bexfat_(err|warn|info).*\\n' fs/exfat/
>> fs/exfat/fatent.c:334:                  exfat_err(sb, "sbi->clu_srch_ptr
>> is invalid (%u)\n",
>> fs/exfat/nls.c:674:                     exfat_err(sb, "failed to read
>> sector(0x%llx)\n",
>> fs/exfat/super.c:467:           exfat_err(sb, "bogus sector size bits :
>> %u\n",
>> fs/exfat/super.c:476:           exfat_err(sb, "bogus sectors bits per
>> cluster : %u\n",
>
> Right, that should be addressed in another patch.
>
>
> thanks,
>
> Takashi
>
