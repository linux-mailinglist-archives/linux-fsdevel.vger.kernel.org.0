Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446A81D03B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgEMAie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:38:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33816 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEMAie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:38:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id g11so2895193plp.1;
        Tue, 12 May 2020 17:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwfbmlNBUU40Zjz8zlAOmtB3ueHeKYzt7ce5wGYgKFA=;
        b=aqH3pLaspKAfdvXZwLL+58pl/C0iJGFYNZL9atbYNikaxnaboV71owlw3D92JfvO52
         9Sw7zuGnvVs3qsa0ApEweFJZjUZyrqNDe4obTWdgwjzpWrdfOV1AEAuu1Gb0eiql5upu
         9LVVb1XJGntMunkvt9nun+ezBsbvd49ziTxGlXL3MsMZw81wPFh0LKzifFYt1cV6ioLL
         EwCj8D2NbAIvS8afGYccqfmo2wzaT+gzJQ7ZO06v36zTfe84tUOCJLqnY4UQbUyGTi5R
         OQx89I+OnxW6MV3WNoxvMZIDC3mBvful16jnzhkwCQ4RLPVDxTqLTO+jr1ocBfZLa7Kb
         6Faw==
X-Gm-Message-State: AGi0Puaq/9hTNvkY2An66cyZMbS8frs00te00VhubT+nvAq4qVCuIFHl
        omaUKZsGlJK1LxOqrl1SICQ=
X-Google-Smtp-Source: APiQypJrCgiM6NaHCnvonCFy7Yn3t2eJw+MEKj198/6OsHFmSqfNPQsM3ObIs9iYeLONwztqCuqQlw==
X-Received: by 2002:a17:902:bd81:: with SMTP id q1mr22856141pls.46.1589330312971;
        Tue, 12 May 2020 17:38:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j26sm13098929pfr.215.2020.05.12.17.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:38:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 60B934063E; Wed, 13 May 2020 00:38:30 +0000 (UTC)
Date:   Wed, 13 May 2020 00:38:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v5 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200513003830.GJ11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508002739.19360-7-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 05:27:38PM -0700, Scott Branden wrote:
> +#if defined(CONFIG_REQ_FW_INTO_BUF_PRIV)
> +
> +#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
> +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf_priv
> +int request_firmware_into_buf_priv(const struct firmware **firmware_p,
> +				   const char *name, struct device *device,
> +				   void *buf, size_t size,
> +				   size_t offset, unsigned int pread_flags);
> +
> +#else
> +
> +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf
> +
> +#endif
> +
> +#endif

Please clean this up, the code must reflect only the code upstream. No
config stuff like this should be used on the driver. I had to stop my
review here.

  Luis
