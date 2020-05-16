Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A31D5D8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 03:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEPBF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 21:05:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45929 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPBF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 21:05:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id u22so1595898plq.12;
        Fri, 15 May 2020 18:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m5wWi4zwve7Yga52EBlx0nkz/MFClZtxjUAQqODyXXw=;
        b=Yzg8EbwYJ699znw/qQssAohAxPH3VNDrgGSot5ft37x+ZFZsBKtMaRakQETwCx59RC
         hFCpjD+HFV+071aVuQZGair3nU/Q+g0VxrrhF4FSThPRixupyc47vBkw0VXG722a04oY
         EZBAQGmh69ujOhx4WG/qOJia90I7oet5pItrPM7J+aCs3YEbNUG0QS82rZ7W63qbZE+Z
         NH/PGRUoNyBogd9zNB+2FYr+vixXvjrIKfGsfAeL/oKL/qJ/rsGlwXYEEuAFe5vMZ67s
         +6azimvbf5ILiZVzesVLXnT0S2jpiC4nTPgjVhS+mDHGWkIDKrssbZuzIWMD3PZa37z4
         c1QA==
X-Gm-Message-State: AOAM533HMQMzR1/AOAaW0AcwEaWF58Iu5HMNqE3PW9Lx8Syc0M+ROmYT
        zH5tcIpYavCx1yZDd9qgfMk=
X-Google-Smtp-Source: ABdhPJwAEYJ79xx0iFmKVcjpSH0tNN0WwT/ce2Bd2fLwJ+MLlbHfvJyXk5z5Mb20eBiJX9Pu9BpuMg==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr6184941pjp.214.1589591155899;
        Fri, 15 May 2020 18:05:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d18sm2454752pjv.34.2020.05.15.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 18:05:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 04928404B0; Sat, 16 May 2020 01:05:53 +0000 (UTC)
Date:   Sat, 16 May 2020 01:05:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mimi Zohar <zohar@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 0/7] firmware: add partial read support in
 request_firmware_into_buf
Message-ID: <20200516010553.GF11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <1589387039.5098.147.camel@kernel.org>
 <20200515204700.GC11244@42.do-not-panic.com>
 <1e75c270-eae5-8f1d-ecc6-1fd2fb248f29@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e75c270-eae5-8f1d-ecc6-1fd2fb248f29@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 04:28:08PM -0700, Scott Branden wrote:
> Hi Luis,
> 
> On 2020-05-15 1:47 p.m., Luis Chamberlain wrote:
> > On Wed, May 13, 2020 at 12:23:59PM -0400, Mimi Zohar wrote:
> > > Hi Scott,
> > > 
> > > On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
> > > > Please consider this version series ready for upstream acceptance.
> > > > 
> > > > This patch series adds partial read support in request_firmware_into_buf.
> > > > In order to accept the enhanced API it has been requested that kernel
> > > > selftests and upstreamed driver utilize the API enhancement and so
> > > > are included in this patch series.
> > > > 
> > > > Also in this patch series is the addition of a new Broadcom VK driver
> > > > utilizing the new request_firmware_into_buf enhanced API.
> > > Up to now, the firmware blob was read into memory allowing IMA to
> > > verify the file signature.  With this change, ima_post_read_file()
> > > will not be able to verify the file signature.
> > > 
> > > (I don't think any of the other LSMs are on this hook, but you might
> > > want to Cc the LSM or integrity mailing list.)
> > Scott, so it sounds we need a resolution for pread for IMA for file
> > signature verification. It seems that can be addressed though. Feel
> > free to submit the u32 flag changes which you picked up on though in
> > the meantime.
> Sure, I can submit a new patch to change the existing enum to
> a u32. 

Great thanks!

> For the new pread flags I am adding I could also leave as
> a u32 or change from a u32 to an enum since there is currently only
> one flag in use.  Then, in the future if another flag was added we would
> need
> to change it back to a u32.

Yes that approach works well, enum for now.


  Luis
