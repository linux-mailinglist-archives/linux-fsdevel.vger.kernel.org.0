Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75FD1FEDBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgFRIgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgFRIgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:36:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739EC06174E;
        Thu, 18 Jun 2020 01:36:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so2477310pfn.3;
        Thu, 18 Jun 2020 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=klpQjbXIkQXxjkoBdlgU5/GUXlGcyonJcPCF31K/eoI=;
        b=R1ISLPA1Bi1xyMmkZ6RmwaiRYT+NeGSvP7tRvlCO2sPLopPDh2AEfRp1FZ+YRS+cAb
         Ti/x24ez6I0XQ7GX7YWZkIimYpp8UHUNmHwHwTVS9CRDTG+G58t/D70U73pC3crvNv2n
         BLz0/3asjEx4TgVQqdUMhN5rTRRizc3uS0wRx8Qp8ORKHfDCeNxwfowq8cmFgtzKtHAh
         IX3oEQahvvezWP2001tg7HMteHsNa/BOk/AP1r+6TNVdSWQH4La7yMdOzKUrF39kYdQ7
         p2akBaO2Ifma+fyhWoB0a1kR12YhtpoP0+2SAQBgltC+nnJSy2VXMUWm/IkHAe6QxfgK
         7LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=klpQjbXIkQXxjkoBdlgU5/GUXlGcyonJcPCF31K/eoI=;
        b=L+mSBvyzsWeYY1CdKPdFFSIwtvG+HtCdXsK6KtyEoUt+4SBQ8BiF3qgwn97GrSVrR9
         k5aewD0mmBC+zJoqt4kvcG8UrzSfm3cX1UxvT7cSMy38MtPZ32sxk7cJoMPgkBkkT/dg
         8vsO5B9184YaRzT8/1jESDyJzlL1TrrvI3SlX4wPPbvtYxH5IFm61T3HUaxJwcfmW4VW
         Opz4ux8kXwMEkMUjoJZyWdbNuD33UboPFtMKQ+h3HfYGwZNHuofI+fxo+EWCKCQ2qFXc
         CUE0utpHnJHSFesW3FU6+u1BB/mx/5qtqVyOb28pLryV4FeF4oglLHalkpB287m7ms++
         KJtA==
X-Gm-Message-State: AOAM531kh9oW0knUqEYy7n7IXwmNdvMdYuXaLKgY254XtcX+DjjAHlld
        y04CnnBEyA2oQm/tRQUaDuvtmd8qkvc=
X-Google-Smtp-Source: ABdhPJyP1p+nWNCcIHbB2JgesFBWX2Y+8DA/h7dXnvxqC3c+r+3RPNEepdSs1JVhNHE3l4QlM3gBtw==
X-Received: by 2002:aa7:9a5d:: with SMTP id x29mr2543652pfj.65.1592469397756;
        Thu, 18 Jun 2020 01:36:37 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:f960:d5b8:822f:1ca1? ([2404:7a87:83e0:f800:f960:d5b8:822f:1ca1])
        by smtp.gmail.com with ESMTPSA id m14sm1948808pgt.6.2020.06.18.01.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 01:36:37 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
 <20200616021808.5222-1-kohada.t2@gmail.com>
 <414101d64477$ccb661f0$662325d0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
Date:   Thu, 18 Jun 2020 17:36:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <414101d64477$ccb661f0$662325d0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your comment.

On 2020/06/17 16:20, Sungjong Seo wrote:
>> remove EXFAT_SB_DIRTY flag and related codes.
>>
>> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
>> sync_blockdev().
>> However ...
>> - exfat_put_super():
>> Before calling this, the VFS has already called sync_filesystem(), so sync
>> is never performed here.
>> - exfat_sync_fs():
>> After calling this, the VFS calls sync_blockdev(), so, it is meaningless
>> to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
>> Not only that, but in some cases can't clear VOL_DIRTY.
>> ex:
>> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
>> return error without setting EXFAT_SB_DIRTY.
>> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
>>
> 
> Since this patch does not resolve 'VOL_DIRTY in ENOTEMPTY' problem you
> mentioned,
> it would be better to remove the description above for that and to make new
> patch.

I mentioned rmdir as an example.
However, this problem is not only with rmdirs.
VOL_DIRTY remains when some functions abort with an error.
In original, VOL_DIRTY is not cleared even if performe 'sync'.
With this patch, it ensures that VOL_DIRTY will be cleared by 'sync'.

Is my description insufficient?


BTW
Even with this patch applied,  VOL_DIRTY remains until synced in the above case.
It's not  easy to reproduce as rmdir, but I'll try to fix it in the future.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>



