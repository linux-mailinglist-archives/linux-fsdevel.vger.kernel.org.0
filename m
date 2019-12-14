Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEA11F4D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 23:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNWRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Dec 2019 17:17:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56075 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNWRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:17:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so2603430wmj.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2019 14:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=79IrCBJD/FrWwFsM5VkomWZRb2YW0b9uPZeIzeZo4a0=;
        b=X4i2STGLFXwRLGU11iIHHLPOLbLvUhQbAKPOoSKNMUC6tUNkmWSGaYHipTewealELB
         FuOA/dit6jslVoqQPf62hdN2CnC9DaqfdKOwp60vloOuMo8eOv79XTJOszHRmzz+QmW+
         YPRnZivgdSBm/zZu5rvEeQfWFaJO3VF2FP8dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=79IrCBJD/FrWwFsM5VkomWZRb2YW0b9uPZeIzeZo4a0=;
        b=HBuewZySXF79FtwnIeic3Jtz1nAosF2PCaD/JACAxEwjN3OIVlZPf3FPDlSeSwm92w
         uGNQVsq3myTRDcVy6QpfBY5T7TttXN91WoaGw4VZtKc3Wh3ocfTQZjxMOYSsr9283K7Y
         ns8jjXGMB0pCt+6OZlTyAL2MNmmdXIaBaeFIKKl/l5GVcDkDO1vn/jGp1QcTHmkZyyNL
         KOa2Cf/FlSUyBpEwAt7djFkRb3j1EKnZ4xyMMTpM6RH69+QW7cWJCMnC7xmarXgP37D+
         75UIGTVaXuf3ctJH2ePGhGefu3hoBM6mEWNH3rDX0S6A8BkQp86IkZtv245tOZszVO3y
         0w+Q==
X-Gm-Message-State: APjAAAWxb57hxoXkiQ4UKEAWQB/Z4giSzNAGjXKNlJx01yEYLV9hhyHR
        4gbE5YhJXxPsdjZp0j9FnNa+GQ==
X-Google-Smtp-Source: APXvYqyrVaOO0U+Mr+LFVkJVcWO83f79a/GXZPmUsVx+I6HsOiWfA8Ln09V9gPIVtGfmEcdbjQTv7w==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr11325387wma.10.1576361872889;
        Sat, 14 Dec 2019 14:17:52 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id x7sm15381620wrq.41.2019.12.14.14.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 14:17:52 -0800 (PST)
Subject: Re: [PATCH] openat2: switch to __attribute__((packed)) for open_how
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     dev@opencontainers.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20191213222351.14071-1-cyphar@cyphar.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
Date:   Sat, 14 Dec 2019 23:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213222351.14071-1-cyphar@cyphar.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/12/2019 23.23, Aleksa Sarai wrote:
> The design of the original open_how struct layout was such that it
> ensured that there would be no un-labelled (and thus potentially
> non-zero) padding to avoid issues with struct expansion, as well as
> providing a uniform representation on all architectures (to avoid
> complications with OPEN_HOW_SIZE versioning).
> 
> However, there were a few other desirable features which were not
> fulfilled by the previous struct layout:
> 
>  * Adding new features (other than new flags) should always result in
>    the struct getting larger. However, by including a padding field, it
>    was possible for new fields to be added without expanding the
>    structure. This would somewhat complicate version-number based
>    checking of feature support.
> 
>  * A non-zero bit in __padding yielded -EINVAL when it should arguably
>    have been -E2BIG (because the padding bits are effectively
>    yet-to-be-used fields). However, the semantics are not entirely clear
>    because userspace may expect -E2BIG to only signify that the
>    structure is too big. It's much simpler to just provide the guarantee
>    that new fields will always result in a struct size increase, and
>    -E2BIG indicates you're using a field that's too recent for an older
>    kernel.

And when the first extension adds another u64 field, that padding has to
be added back in and checked for being 0, at which point the padding is
again yet-to-be-used fields. So what exactly is the problem with
returning EINVAL now?

>  * The padding wasted space needlessly, and would very likely not be
>    used up entirely by future extensions for a long time (because it
>    couldn't fit a u64).

Who knows, it does fit a u32. And if the struct is to be 8-byte aligned
(see below), it doesn't actually waste space.

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index d886bdb585e4..0e070c7f568a 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -109,17 +109,16 @@
>   * O_TMPFILE} are set.
>   *
>   * @flags: O_* flags.
> - * @mode: O_CREAT/O_TMPFILE file mode.
>   * @resolve: RESOLVE_* flags.
> + * @mode: O_CREAT/O_TMPFILE file mode.
>   */
>  struct open_how {
> -	__aligned_u64 flags;
> +	__u64 flags;
> +	__u64 resolve;
>  	__u16 mode;
> -	__u16 __padding[3]; /* must be zeroed */
> -	__aligned_u64 resolve;
> -};
> +} __attribute__((packed));

IIRC, gcc assumes such a struct has alignment 1, which means that it
will generate horrible code to access it. So if you do this (and I don't
think it's a good idea), I think you'd also want to include a
__attribute__((__aligned__(8))) - or perhaps that can be accomplished by
just keeping flags as an explicitly aligned member. But that will of
course bump its sizeof() back to 24, at which point it seems better to
just make the padding explicit.

Rasmus
