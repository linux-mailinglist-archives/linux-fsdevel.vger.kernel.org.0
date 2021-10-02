Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82F41FD7B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhJBRnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhJBRlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:41:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8409C0613EC;
        Sat,  2 Oct 2021 10:39:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d26so21034319wrb.6;
        Sat, 02 Oct 2021 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLvlEg/xtfBKsFwbRc8N23nwQpdQ2n6wElEzvyFdDJE=;
        b=FR33PUHHB5jWqQp2ersM4IZykeSE+TVTDI4sEmljdj0V5Op5FWTJ5ouW2iHTg7aMiF
         aFuvlvxHyIykRVVb47eMYpR/B9vt2GEnQdIGyMYLYP7P1TEisT8Edpq27t/trfJM8Eld
         FkH3CU/vbg0FMUguXS7G20/XuJJRlmf9Fn5UpHJsenAr3BNnbVK7NzWk/DHpusqHtf4k
         n2v/v+y6xkxLhq1DPP5aGc/BpEShhLc9eTKm7NHG2QNeLAyDIuAXSR0dCSphv3rqaaX6
         BT7cquGuYtyWFM1zs/XkKtmudsZxRu91XBnNQxWvMV4cTj20H94KTNTZWUzGda91iD88
         3Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLvlEg/xtfBKsFwbRc8N23nwQpdQ2n6wElEzvyFdDJE=;
        b=kThg0GW2Hn4p7AHQSJic7qkvchQvZJ8FFbzF96LnNgBE8m8sLf5HY7ZzjG39nKjNah
         6bajRJ9akJqN3kTcZMDtw/VorzD80SNmGrgdsAGZlH/GR7egiGe6QhWhN22VX9RCJQB+
         Q599s36cXpNuBmPqMF4+9YWosIxn8xl8zCmmpd3LnF16BN4FUcc59yrZ4VLOy73MQuRT
         ghiJPWMpBBCY9SrEHXDIcsMpJwB8/ikqRhSR2KsTBs5WtGzfKnm7qbjvD7nilD1IGBtS
         IHXILaH6KXeqZ5Jy4mIvAmpDKbmTpshjDS8//RonUqPVsFO51B0Cbo9YTSmOSzr/8qJZ
         8OLg==
X-Gm-Message-State: AOAM533+ckALD/SO7FMYR4Ts4RsJPlfYVqTRH0hH+T+SjY0P3PB9ilcP
        ssyYNML3BeHSU/2KXuhN6mjylxZnyjo=
X-Google-Smtp-Source: ABdhPJxZkKz8U6ZDP/F8/K8gIkDwCTyowWyjG6AvNi8m/BcGSzSfBgcfTfEmq/0f/4DDwMU3cFho9A==
X-Received: by 2002:adf:bb88:: with SMTP id q8mr4311262wrg.390.1633196396262;
        Sat, 02 Oct 2021 10:39:56 -0700 (PDT)
Received: from [10.8.0.30] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id b15sm10995233wru.9.2021.10.02.10.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 10:39:55 -0700 (PDT)
Subject: Re: [PATCH] mount.2: note that mandatory locking is now fully
 deprecated
To:     Jeff Layton <jlayton@kernel.org>
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-man@vger.kernel.org
References: <20211001115724.16392-1-jlayton@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <70df73be-1f6a-2317-fe60-79c9d0575d5e@gmail.com>
Date:   Sat, 2 Oct 2021 19:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001115724.16392-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jeff,

On 10/1/21 1:57 PM, Jeff Layton wrote:
> This support has been fully removed from the kernel as of v5.15.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   man2/mount.2 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/mount.2 b/man2/mount.2
> index bedd39e68a68..a7ae65fb0142 100644
> --- a/man2/mount.2
> +++ b/man2/mount.2
> @@ -195,7 +195,8 @@ this mount option requires the
>   .B CAP_SYS_ADMIN
>   capability and a kernel configured with the
>   .B CONFIG_MANDATORY_FILE_LOCKING
> -option.
> +option. Mandatory locking has been fully deprecated in v5.15 kernels, so
> +this flag should be considered deprecated.

Please use semantic newlines, as man-pages(7) notes.  It is especially 
important here, as otherwise you're hardcoding the number of spaces 
after the '.' (which if you don't, will typically be 2).

See man-pages(7):

    Use semantic newlines
        In the source of a manual page,  new  sentences  should  be
        started  on  new  lines, and long sentences should be split
        into lines at clause breaks  (commas,  semicolons,  colons,
        and  so on).  This convention, sometimes known as "semantic
        newlines", makes it easier to see the  effect  of  patches,
        which often operate at the level of individual sentences or
        sentence clauses.


Cheers,

Alex

>   .TP
>   .B MS_NOATIME
>   Do not update access times for (all types of) files on this filesystem.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
