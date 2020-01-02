Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767E112E734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 15:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgABOU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 09:20:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgABOU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:20:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so39299021wro.9;
        Thu, 02 Jan 2020 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jW0bEHzRFYYf6qnsWzVCE8D6jWZAjzMpoArK+oSeNAE=;
        b=lAuzzY8WWZk6n7jKrodVmyR/4IP9c9zdS5GmgQzj0WGEdk9EMgggLAuONmx0GASO0O
         3k2PvKwk4a82sYoq5qikmlGSw2T2BQL6A1wmOEpL3UMATrxK7EiVMpLI1FgvusxNhnXi
         AEBiloOAJii9pgPvL4wFbYVMi6W8NbcReL7lr0jxlsKOBhrfv3K/8mNLNRtQUN6xWmEG
         fSNweWo19xuJmolQqs+tqMo2AU7ZHMZS4oVWlIz3HutMcIPoFGUJo9X6lbr1a2AzEMrS
         aI0DJkcO4/Df2Y0iVvwpXjGN+HHZBzi+I6MIFjeWQHWWPbRhwY68uSXSxk8yfvD2KD9D
         e37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jW0bEHzRFYYf6qnsWzVCE8D6jWZAjzMpoArK+oSeNAE=;
        b=bEh61r2b1UdiuhaZgJtMPp/FfZHmhxDx8YEhRKcCLGTDu4CNXeuhdrUUcwSuc4yL2s
         6BTPstqFUHN2pe+EUhdMRCcMY6ZtI23za/Zp2NOOucDyah2XK6tbmgLw2ATUFyN+6LGi
         7sUUZxb43eJHa4hm5SKHISJCh3woqeAq3H2OdPLbXLSPrMgHAw+j0EpqX5Om01kWEwxT
         8cOzulemWJwPscHu46KJmyr5pITEn5IHRiaIAO9kyMzmS95odgoxxGiFR30xuNjE8xA/
         YTUXb0RG0X/7EL7FHgyRyxRuGCiL+EqBEAUU+TnpVG5kdvci3yUXH7AvUfEzUYqRvKki
         aFYw==
X-Gm-Message-State: APjAAAUDxNTfOfmkB+tCwU5mGbLx2RDNHVDK5FEv7QAwNBw+M8xwYTpN
        zunhM74XCVBVQoLyBOGC6RY=
X-Google-Smtp-Source: APXvYqwKufscjQHQQQARenB2O2ju2sbn9cu4PZtEG1zdDgiOsECRa+DAaLSrvhhodS18IiCyk9zAnA==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr70012087wru.154.1577974827981;
        Thu, 02 Jan 2020 06:20:27 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i16sm8750799wmb.36.2020.01.02.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:20:27 -0800 (PST)
Date:   Thu, 2 Jan 2020 15:20:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200102142026.wb5glvnf5c7uweed@pali>
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
> @@ -0,0 +1,809 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/string.h>
> +#include <linux/nls.h>
> +#include <linux/slab.h>
> +#include <linux/buffer_head.h>
> +#include <asm/unaligned.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +/* Upcase tabel macro */
> +#define EXFAT_NUM_UPCASE	(2918)
> +#define UTBL_COUNT		(0x10000)
> +
> +/*
> + * Upcase table in compressed format (7.2.5.1 Recommended Up-case Table
> + * in exfat specification, See: https://docs.microsoft.com/en-us/windows/
> + * win32/fileio/exfat-specification).

Just a small suggestion: Do not wrap URLs as they are hard to copy-paste
into web browser. Also my email client is not able to detect URL
continue on next line...

> + */
> +static const unsigned short uni_def_upcase[EXFAT_NUM_UPCASE] = {
> +	0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
> +	0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,

...

-- 
Pali Rohár
pali.rohar@gmail.com
