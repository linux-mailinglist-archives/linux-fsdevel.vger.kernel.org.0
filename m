Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6CC4A506A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 21:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350866AbiAaUos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 15:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiAaUom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:44:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA8C061714;
        Mon, 31 Jan 2022 12:44:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h21so27811902wrb.8;
        Mon, 31 Jan 2022 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lXdF60hk6Iak8+tYodZnEN6ChdtDV++2j27B2BNhxMM=;
        b=FC0VJ/tdPWkKPPH1lphXRetxYfkwOh1eNep0PhJZLoZOz/p+YTA3kb0Ps+/hIsvsJC
         Gj2744yc9PA6tfAIm71E39s9roikWW9RiZE7r8Xnb4QzOE3KgG/2EivXX/6wi1qlxPuQ
         ahEvl4k4GWWQZpzD6TncPUM7YLyQDFn/5ff1EoQXOSDELHQoos03K0UMfGOL1jaE/gO8
         iBw0MwxQRwSMNz4+EDmFxQga5EXsjFp3qMxjzJ/j0DlWpYkNXyPjthSbH1bIPMsJzQcy
         GZr2+6ALnXXdwucDP9x+hsTkzA6xUBlxaHykuaf3vxPYGWozGH28OucY0gdUe4kKH2/F
         0qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lXdF60hk6Iak8+tYodZnEN6ChdtDV++2j27B2BNhxMM=;
        b=WZSGaG6C1upX5AS0caRb/V5w8FIjLZupcSmU4SA/nsgSAVv210yK3RdW2wMU/IRvFL
         3JYSupudwJ2o2NtaK6Om/Tmu5zl0iPiFlCqlkLL6suBLp0nffWfrbPP1TaM/yEysL34D
         cdi/mvlGdIdd70AliHS+TQrj+OuFa7FP6MYhTApSzTWd8bI9lmdUokxNsQ0j+NHgO0du
         TztjWddt2UKW++eqTbeREtu+QUV5V7jrgPVa9jCXfBPTnLeYpyPjG02/rKxYFRvnBYoX
         gO6L0Kq7q4m7Gvz3kfY1oxZoh6BYjlqajn0MJvnP4VC+ce0pwimkiN4Ur4Lhxho4+Zva
         luSg==
X-Gm-Message-State: AOAM531AH+UJXX0AhJE+o72Qqte+Owm3bwykAoMm4PvoHOXja5SjxEvI
        pkp6yjap/qthBSpmmD0yrhB44YNhSXE=
X-Google-Smtp-Source: ABdhPJwfj8LE/Im2CTZOc67KE0bynhTmp0hzhqo4N2wZPCBNkqsh5SzXcdHHzDjkt33MydFT3peYmA==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr18394012wrm.608.1643661880427;
        Mon, 31 Jan 2022 12:44:40 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id m187sm308114wme.25.2022.01.31.12.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:44:40 -0800 (PST)
Message-ID: <55d40a53-ad40-0bbf-0aed-e57419408796@gmail.com>
Date:   Mon, 31 Jan 2022 21:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: EINTR for fsync(2)
Content-Language: en-US
To:     Mathnerd314 <mathnerd314.gph@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org
References: <CADVL9rE70DK+gWn-pbHXy6a+5sdkHzFg_xJ9phhQkRapTUJ_zg@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <CADVL9rE70DK+gWn-pbHXy6a+5sdkHzFg_xJ9phhQkRapTUJ_zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alexander,

On 1/31/22 19:32, Mathnerd314 wrote:
> Hi,
> 
> The POSIX standard says fsync(2) can return EINTR:
> https://pubs.opengroup.org/onlinepubs/9699919799/
> 
> The man page does not:
> https://man7.org/linux/man-pages/man2/fsync.2.html
> 
> I think fsync can be interrupted by a signal on Linux, so this should
> just be an oversight in the man page.
> 
> At least, fsync on fuse seems be able to return EINTR:
> https://github.com/torvalds/linux/blob/5367cf1c3ad02f7f14d79733814302a96cc97b96/fs/fuse/dev.c#L114
> 
> Actually there seem to be numerous error codes that can be returned
> from all filesystem calls on fuse: ENOTCONN, ENOMEM, etc. But EINTR is
> at least documented in the POSIX standard, whereas these others seem
> really rare. But for full correctness I suppose these should be
> documented as well. It would be quite an undertaking.
> 
> -- Mathnerd314 (pseudonym)

I got this report on linux-man@.  Could you please confirm if there are
any ERRORS that should be added to the fsync(2) manual page?

Thanks,

Alex

Mathnerd314:  Thanks for the report!  It's useful to CC the relevant
kernel developers when reporting non-trivial bugs such as this one.
They know better than we do.  :)

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
