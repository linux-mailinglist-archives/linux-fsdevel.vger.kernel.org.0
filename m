Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E462E286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE2Qte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 12:49:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39731 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2Qte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 12:49:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so1297472plm.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guRhBwE8Jq2pT9gu18nVOUDdNtCFbP3Mz6H0t8cPBts=;
        b=owoi9xfKHIupf14tvLmBO/xJECPkUet26Ff2rZMpBaDjptawMFz+qLRu/EHAbQ0Bry
         PSTJb6d4YTQ44rPFgu4JbHunc07WOZX6+H19OBRC5cl2Ve0mWzoQluglgcRvd4DWnbD0
         mmd7VRP80BBcpKBHftjArVPoBQitU5IyeuKdK8TwUPy7RZ+bWV8i+NsYFXva/hT/SNnZ
         q0vgJGx1btgIpDd4lQvDiLPhSrsdSBop+NjdfpT6cJ1vv7b9M3h/pwqZalVzAI17+MDb
         O4SSmvdUVR+V8RJl6zEcuFM1o3dxKOMqmmhkRr4Sa4RG6YsWzfbhAooxMqLjp8EhIw2s
         pLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guRhBwE8Jq2pT9gu18nVOUDdNtCFbP3Mz6H0t8cPBts=;
        b=ot6MUT6jKE/RbeKjQDfB6xuNOrh56WQqdqUNp8dhaG3AO4ymmfOAenr2W9mHQ8Gsej
         DGA+pvHYpkabrHxfGdQa5X2PXUgCqZ5SszR03L7puBv/XwNp/IO84x2shDWtzgpWC5Pa
         nVMYHMCcIqoglQDb+TPv8a19k1jQpf1s3Ppg7Rwm0ckXcKOfFsQxANmBxfNnnsxFNbkc
         B1hLXkKJ4Bh7+NWFz55IaTtYfhuFPtkTMPtQ5czC0hyKM4ScoBzPrUTAWgTPX4P700ni
         uMkR6RED+B6YuFjQukrYEYyDxzRz/6q5OqHaNlyjHs0rw+I+myVQIfiORJ2CxCyOCvd1
         ZsFA==
X-Gm-Message-State: APjAAAVLVet2fG+6hhtKJ0uakkRvxRAoYGSYJL0v3D3cn61N8XoP47KQ
        RFlP597P3d7kaWnhf0oSfehFr5P8sQNJGw==
X-Google-Smtp-Source: APXvYqwZgxtLbeCyy/Nl6uW+Awxng+CUJS+RH72nH5ZP7DP/yp4EpvZ8+VGRVPznECG4luF+b7CLFw==
X-Received: by 2002:a17:902:21:: with SMTP id 30mr125616112pla.302.1559148573721;
        Wed, 29 May 2019 09:49:33 -0700 (PDT)
Received: from [192.168.1.136] (c-67-169-41-205.hsd1.ca.comcast.net. [67.169.41.205])
        by smtp.gmail.com with ESMTPSA id l35sm175651pje.10.2019.05.29.09.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 09:49:32 -0700 (PDT)
Message-ID: <1559148571.2803.73.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: Replace strncpy with memcpy
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 May 2019 09:49:31 -0700
In-Reply-To: <20190529113341.11972-1-malat@debian.org>
References: <20190529113341.11972-1-malat@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-05-29 at 13:33 +0200, Mathieu Malaterre wrote:
> Function strncpy was used to copy a fixed size buffer. Since
> NUL-terminating string is not required here, prefer a memcpy
> function.
> The generated code (ppc32) remains the same.
> 
> Silence the following warning triggered using W=1:
> 
>   fs/hfsplus/xattr.c:410:3: warning: 'strncpy' output truncated
> before terminating nul copying 4 bytes from a string of the same
> length [-Wstringop-truncation]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  fs/hfsplus/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index d5403b4004c9..bb0b27d88e50 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -407,7 +407,7 @@ static int copy_name(char *buffer, const char
> *xattr_name, int name_len)
>  	int offset = 0;
>  
>  	if (!is_known_namespace(xattr_name)) {
> -		strncpy(buffer, XATTR_MAC_OSX_PREFIX,
> XATTR_MAC_OSX_PREFIX_LEN);
> +		memcpy(buffer, XATTR_MAC_OSX_PREFIX,
> XATTR_MAC_OSX_PREFIX_LEN);
>  		offset += XATTR_MAC_OSX_PREFIX_LEN;
>  		len += XATTR_MAC_OSX_PREFIX_LEN;
>  	}

Looks good. I don't see any troubles here.

Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Vyacheslav Dubeyko.

