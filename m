Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA012E6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgABNzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:55:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgABNzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:55:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so5700477wmc.3;
        Thu, 02 Jan 2020 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Umw3KabgQc+joAVZVI/kqZfdiIRA+6g2g4xfLJJZ/Ts=;
        b=W6MKeho9eQynkeDso8Ap8avMGZoSiEZy9PoRcCXamHEpKXKVXeb7UhSzOMr259Bp7d
         mhf27AUh3BZkAdcmB2YdYYSuBiqE+/cKgmcSNsHgmmKoR7kAfdj+HaE78jc/45raO0h3
         bW6yKE+KXVRlEWiBTVftfape34T3lSwfTvNvi0fzy4VuUKFi4ZwFeXzfuhR+LmpSRj3I
         j34XadXGgRwyxLIrI6cvGRwFts0h9rpEJmlpt1+dWtReAiszQAT4fyIFeEtkOCE3H+4s
         EjVy4SohDJp5rGoXovhyQVDoLQU0A6+LhVe+ZZC1CHe4eavB/IU8vm6hTLhFIXhv/FAG
         50pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Umw3KabgQc+joAVZVI/kqZfdiIRA+6g2g4xfLJJZ/Ts=;
        b=COVQZHEj3aIHia5BN/yIuFV4gZpgTsd6nwhkvQcz2DN2r+i9ZGaNekM6tzXOdCluH8
         06Aq09cHUUuPB/q81Xe8qc1jaSShk9oFNC5KQ2I4TZYpRPWfHKbgy2IBrJR1alOMG6LH
         gwzVH0v56SYhSmj49b9th6QdDcw6xJfFaEUA0sUNkfHwtd6eHjVPHk6CcFEINE5ELAeX
         K8Q87q13r/UJ2cOOfOD8y+SQIUoU4zD4RhnRw+CSkVqzpL5ut7JdV34/CEKIKvtCVMjx
         rDCEul4dPrm2yyJ9GCfcSpeeLSBfvQnkZYioKo7ge3yY7WTa0Mo+QBkgk7cgib7mXI77
         a6NQ==
X-Gm-Message-State: APjAAAX+1WB2tLpAVT35YfSYOJ07gpRq3K+KVkgr+lTEZiHKzbAdrK9T
        OUVNML0G8m17+34/VSdBqC8=
X-Google-Smtp-Source: APXvYqzH+bnnP2wiom274iCBMvTz7vSwKEfteTZgsf9jqEkx9QNftRRR/QFV7K1ZUpOcajGbx9Acag==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr14851523wmn.47.1577973303893;
        Thu, 02 Jan 2020 05:55:03 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i16sm8689698wmb.36.2020.01.02.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 05:55:03 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:55:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200102135502.hkey7z45gnprinpp@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102082036.29643-11-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> This adds the implementation of nls operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/nls.c | 809 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 809 insertions(+)
>  create mode 100644 fs/exfat/nls.c
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> new file mode 100644
> index 000000000000..af52328e28ff
> --- /dev/null
> +++ b/fs/exfat/nls.c

...

> +int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> +		struct exfat_uni_name *uniname, unsigned char *p_cstring,
> +		int buflen)
> +{
> +	if (EXFAT_SB(sb)->options.utf8)
> +		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> +				buflen);
> +	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring, buflen);
> +}

Hello, I'm looking at this function and basically it do nothing.
Or was it supposed that this function should do something more for UTF-8
encoding?

There is one if- statement, but in both branches is executed exactly
same code.

And executed function just pass same arguments as current callee
function.

So calls to exfat_nls_uni16s_to_vfsname() can be replaced by direct
calls to __exfat_nls_uni16s_to_vfsname().

Or maybe better, rename __exfat_nls_uni16s_to_vfsname() function to
exfat_nls_uni16s_to_vfsname().

> +int exfat_nls_vfsname_to_uni16s(struct super_block *sb,
> +		const unsigned char *p_cstring, const int len,
> +		struct exfat_uni_name *uniname, int *p_lossy)
> +{
> +	if (EXFAT_SB(sb)->options.utf8)
> +		return __exfat_nls_vfsname_to_utf16s(sb, p_cstring, len,
> +				uniname, p_lossy);
> +	return __exfat_nls_vfsname_to_uni16s(sb, p_cstring, len, uniname,
> +			p_lossy);
> +}

And same for this function.

-- 
Pali Rohár
pali.rohar@gmail.com
