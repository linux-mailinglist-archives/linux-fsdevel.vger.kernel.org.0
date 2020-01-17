Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67881405F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAQJSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:18:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40052 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAQJSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:18:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so21904272wrn.7;
        Fri, 17 Jan 2020 01:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sgkfz+kjf0RnGDSX0eAgQGIvd5AcbyYWbs9Q4SdU2FY=;
        b=tQ2nuEcLHSdatZ7aDMW0eoUp+CquqasQVrzToMiCUf38eDWQlc7yBQy8DmNICmpkWk
         MHws4CS4T5xSKQGrbVcAAlsL67YwmUAnssQL7yvJFgvxxpHwibc7/jUwdv4pxCMrzMLT
         xCSReSA9UwkSCnOjNm0wF1GWBMhYf0MYpJSmQxtlA7wzhSI9eJxv9UOtKbGtmQYUk/aS
         RvdkZw88V7xt6TSiHPltPxMr/cdk9nVuC4cCQn0JiZ9dfPQtfumzvBrtAAO52gfZNJ41
         e3rPSZtvg5FNDBd3jYsJ/OKJEmTUCCJCE+zF/tUdPdLfY8AaswNVq3vQrQLpoC/okBIR
         gRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sgkfz+kjf0RnGDSX0eAgQGIvd5AcbyYWbs9Q4SdU2FY=;
        b=F6Iu92naT5Jfa/bXFweojGiRR22Y2I6NYHN60p4Kk65aAASO/KyOSIckmprjX4TZHj
         pqjj+qz37GYXFvFeVojx4D5ObmaSPh84TapovceMy0DxxN0Pikw48DWvrN64ZpNJTRiO
         Eo314kuzkG/l31dbBtFMB/AqcqeR3g7YCxCOadC+RNOsCKT4VL+jbKxvmRb+BBaY3k95
         qfaSp1hIysPWkPiLQPi8YAGvIXsswDg4lz2dw12vSiBmdR8ywSz0aK0QNN/I6WZE9mrC
         0fb1UOA5jhUByVinR4WPFy27DYRT72Ki2nafP2rovDLI5vVuKuRRUt8EjJ+QzvD7Us1F
         MHow==
X-Gm-Message-State: APjAAAUB/NQiqknU6ii17fLCE+gc2DE4zq/A76BgUiry8HPkrp45aPXz
        Ku3EjaOhNavL9ULAkC1c046BPY4y
X-Google-Smtp-Source: APXvYqx7SgdQdfu43QBwheduAVgJvOAqo2Dd0n2ZtSTP07qDzVNH62Qq9NdXVSeeFetZWUYzzavxCQ==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr1949433wrp.236.1579252694686;
        Fri, 17 Jan 2020 01:18:14 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q68sm9552538wme.14.2020.01.17.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:18:13 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:18:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 05/14] exfat: add file operations
Message-ID: <20200117091813.wiksrz5khmtoocbj@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082821epcas1p4d76d8668dfac70ae3e3889d4ccb6c3ee@epcas1p4.samsung.com>
 <20200115082447.19520-6-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115082447.19520-6-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 17:24:38 Namjae Jeon wrote:
> This adds the implementation of file operations for exfat.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/file.c | 355 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 355 insertions(+)
>  create mode 100644 fs/exfat/file.c
> 
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> new file mode 100644
> index 000000000000..b4b8af0cae0a
> --- /dev/null
> +++ b/fs/exfat/file.c

...

> +/* resize the file length */
> +int __exfat_truncate(struct inode *inode, loff_t new_size)
> +{

...

> +
> +		ktime_get_real_ts64(&ts);
> +		exfat_set_entry_time(sbi, &ts,
> +				&ep->dentry.file.modify_time,
> +				&ep->dentry.file.modify_date,
> +				&ep->dentry.file.modify_tz);

Hello! Now I spotted that you forgot to update "modify_time_ms" entry.

To prevent this problem, maybe function modify_time_ms() could take
another (optional) parameter for specifying time_ms?

> +		ep->dentry.file.attr = cpu_to_le16(ei->attr);
> +
> +		/* File size should be zero if there is no cluster allocated */
> +		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
> +			ep->dentry.stream.valid_size = 0;
> +			ep->dentry.stream.size = 0;
> +		} else {
> +			ep->dentry.stream.valid_size = cpu_to_le64(new_size);
> +			ep->dentry.stream.size = ep->dentry.stream.valid_size;
> +		}
> +

-- 
Pali Rohár
pali.rohar@gmail.com
