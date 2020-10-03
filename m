Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E06282329
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgJCJcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgJCJcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 05:32:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96643C0613E8;
        Sat,  3 Oct 2020 02:32:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so4331149wrn.13;
        Sat, 03 Oct 2020 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wmkJ9FxHCpTr+iWv6GHurEZpNNofEO+mT2y21utzFUs=;
        b=i1gww9oLCuAl7ps5bghVOHqyGmypLPIhDKuBqotkCvdnqEFRaD36CeVYStIMsJFTUN
         D6OtC9a5Pd3uni6o0V4KWqVjMy4G9aoHk65TQ0a3vqdwc8JJkyW9d2HuLnCONT5/aDfg
         6/s3VQo5bRbDCwgHl10h4opIShPXPwp0jNEqEv/LXoy0m9KLmBLPzE2Ma/7RxYryfpvx
         KDR4E1aW4hiJeLllUYcX3LaBX6pETHnRvDUFo4bDzUh+KpIuRoixv+Md31XOw1sV9Y0U
         jfsAyXPOLfP0gNHv1chHDLJodyRwn8IOgMLUW4LseTUQ8ulmWGY0taiIppcuxmyOrSSX
         QMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wmkJ9FxHCpTr+iWv6GHurEZpNNofEO+mT2y21utzFUs=;
        b=H6/nd45JXOBDvTLuQRJGWY8zFWX/vnRp1f9Yjso3Bm/7AUoKmu6pMEXGZahaRfm3Uu
         YDBAMDSIvrWHUcyUYpXRCCf1CXQi52wW5y+eqYrfP0mE6tCDYLZsdLQ6sRZWVQmSozog
         qBfdxZkd5VD3DSRKx5mNXLJpH7kqNqHAQKkoNDbUllEJQo+24HxucSYGZx1bsmkb+MS+
         3QAdEsbi0CaI4dy7KbwHQAAuMqX9XLwMaYyna/iWLdFc8OsANPyK/R9DoWfx3nGK9g3e
         oN3RsWxrKA0bfF0bqrHLeJXX/t8hJiMYc6dgh+7az9E/To9DXJygxb+DTC7VEK6wrQZL
         OHYg==
X-Gm-Message-State: AOAM530yzSJKHjgrMxaFCUiLnHNPJoqnYDBPSXfrerPWdT5z/LRnvqwy
        wIttkG5maRCSrqRyE7Y6E8U=
X-Google-Smtp-Source: ABdhPJxF6OsanYU7MGuhJyTy3ufPHyRz/VHEz71PltEzIDMI5xb5/GcsYkMEQc6B2ut+ufvoU3MTDA==
X-Received: by 2002:adf:e391:: with SMTP id e17mr7048859wrm.289.1601717566307;
        Sat, 03 Oct 2020 02:32:46 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id i14sm4778140wml.24.2020.10.03.02.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 02:32:45 -0700 (PDT)
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     rppt@kernel.org, mtk.manpages@gmail.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com,
        jejb@linux.ibm.com, kirill@shutemov.name,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org, rppt@linux.ibm.com,
        shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws,
        viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org,
        x86@kernel.org
References: <20200924133513.1589-1-rppt@kernel.org>
 <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Message-ID: <94cf1b3a-e191-a896-a27d-cd7649cb2c59@gmail.com>
Date:   Sat, 3 Oct 2020 11:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike and Michael,

Ping. :)

Thanks,

Alex

On 2020-09-24 16:55, Alejandro Colomar wrote:
> * Mike Rapoport:
>  > +.PP
>  > +.IR Note :
>  > +There is no glibc wrapper for this system call; see NOTES.
> 
> You added a reference to NOTES, but then in notes there is nothing about 
> it.  I guess you wanted to add the following to NOTES (taken from 
> membarrier.2):
> 
> .PP
> Glibc does not provide a wrapper for this system call; call it using
> .BR syscall (2).
> 
> Cheers,
> 
> Alex
