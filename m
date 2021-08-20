Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157DB3F3030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhHTPxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 11:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241159AbhHTPxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629474745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlZGKQdLiYduLYkrU1ycwzHzZ/QPrtvBjhejt7xEWxE=;
        b=f6w2pqh+i/ipjT0HvYCUSuPXJu6gOhZr7bMZVyaQRTya47PLRS6qsQoAk2H+fuSz3JpqNM
        MS0KQzgeAB0QWGR0FHVym/uwjVC+EzSWVr7qhimmUQbFRPXl7cI0LVl+jdC+RcvXKjntwj
        YDHFXl9KziFdhuvtWU/4R2cxeF3oG7w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-DnIPy9dDNs6R_3heXN7V1g-1; Fri, 20 Aug 2021 11:52:22 -0400
X-MC-Unique: DnIPy9dDNs6R_3heXN7V1g-1
Received: by mail-wm1-f69.google.com with SMTP id 201-20020a1c01d2000000b002e72ba822dcso633332wmb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 08:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JlZGKQdLiYduLYkrU1ycwzHzZ/QPrtvBjhejt7xEWxE=;
        b=K23aTrPmpMQVHreI884TnhxFZEa1Fmj0ZlWMmWdbP90HmsPSTX0PnJlO3VRSVSov7a
         mdwHDz/ZLPQeJPIzrNDhrYIKdhVNNLmoSiLLN6+Tz4eQAik47mReToygdezVZXH09u4G
         V6ll3yBn10l+SWZNtgnuehmLbjYQfufJU9xPoJaLINvy01TYtuVQFqyrUx4fiK6ipJ3l
         NIepKBPp1GD4b/J+eIv0nnjZsY7pjdtVQFTdgj1PpQmyWO1O8cwDfybw4PV0CcEHn2Hu
         heEZISwZEkUy1GI1LFpo/t8m3+VPJ/BuUIqaas9d2f1KRWcN/AabBfE4EBWZNCZkUJFK
         f7Ag==
X-Gm-Message-State: AOAM533SbEFT0o/bRVKXeljdoYriqAkrIrIMkseEtAen8M6Tt7CNJ3LM
        AIQ0GUqdmT11RqhV3EnFyswAGdB46HXsRk12vhQ+c91yeIR67A2wRv841WYzFC3tt9U+E54sOSb
        sMK361lnd5pYj4jXghh8aXJX2BA==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr4714037wmi.60.1629474741075;
        Fri, 20 Aug 2021 08:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaJBeCrGw4MnIfr+I5SADEkPPbDd6DJwmXEz/DXBgKbV1Dt/yBLdB7ItdMspgW4ZXDhi9QGA==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr4714020wmi.60.1629474740919;
        Fri, 20 Aug 2021 08:52:20 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id a18sm10107804wmg.43.2021.08.20.08.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:52:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fs: warn about impending deprecation of mandatory
 locks
To:     Jeff Layton <jlayton@kernel.org>, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, willy@infradead.org,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, bfields@fieldses.org,
        w@1wt.eu, rostedt@goodmis.org, stable@vger.kernel.org
References: <20210820135707.171001-1-jlayton@kernel.org>
 <20210820135707.171001-2-jlayton@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0f4f3e65-1d2d-e512-2a6f-d7d63effc479@redhat.com>
Date:   Fri, 20 Aug 2021 17:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820135707.171001-2-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.08.21 15:57, Jeff Layton wrote:
> We've had CONFIG_MANDATORY_FILE_LOCKING since 2015 and a lot of distros
> have disabled it. Warn the stragglers that still use "-o mand" that
> we'll be dropping support for that mount option.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/namespace.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ab4174a3c802..ffab0bb1e649 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1716,8 +1716,16 @@ static inline bool may_mount(void)
>   }
>   
>   #ifdef	CONFIG_MANDATORY_FILE_LOCKING
> +static bool warned_mand;
>   static inline bool may_mandlock(void)
>   {
> +	if (!warned_mand) {
> +		warned_mand = true;
> +		pr_warn("======================================================\n");
> +		pr_warn("WARNING: the mand mount option is being deprecated and\n");
> +		pr_warn("         will be removed in v5.15!\n");
> +		pr_warn("======================================================\n");
> +	}

Is there a reason not to use pr_warn_once() ?


-- 
Thanks,

David / dhildenb

