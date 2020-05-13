Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EE1D12AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgEMMah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 08:30:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39872 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgEMMag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 08:30:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b190so2184148pfg.6;
        Wed, 13 May 2020 05:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s6UKwXNDP9/u6KtJrcoesDc1tFaVGyXaG/2QuDgOJR0=;
        b=co8jHKFL+Mb5LtsFAWfz0YLxscLUWImEz3JVJoLLy+1eHoHJIi4hF4uTrWG9HJgDTn
         ZToyMAiUq6QvCHrPeAWZ96cCXKk1eFQ/02XJMBb7qo7wKKIgXWQo2zBe963txR4Yxatw
         fM86kAWoRt5Ax8A9Dc/mB9pWO/Qe3NT1tPnlX35HxDVRTrHx5lExXQDfoccQ5ZxkuoZY
         L0qzOJl8vPHZbVbzNRstQuNAVB0hGC95jvV3g8vhhEjLTra9wm35eq6z/GnTFZvkgrf8
         f1G3PmOqwXgW8xnMq6/+jhQpCy2zei1NulWChf0s0X/mTzSyPXjRWqB5rUS/Apjv3VRo
         5mCg==
X-Gm-Message-State: AGi0Pub+uZ7owmH5WLkKMnUpFV8w076KIJ0R0rdMsPp6eDZs7JyarhB+
        PQuDbcVwAUaOq9i1PRja/FE=
X-Google-Smtp-Source: APiQypJgfhEo9WP6IGCoJH2PF3oIVLchRnTrr8jLp5QQMzfIh8kliCILIbT2GCnajLPHNpJWyqBd/w==
X-Received: by 2002:a63:f809:: with SMTP id n9mr24815453pgh.355.1589373036088;
        Wed, 13 May 2020 05:30:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x23sm12936041pgf.32.2020.05.13.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:30:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A33864063E; Wed, 13 May 2020 12:30:33 +0000 (UTC)
Date:   Wed, 13 May 2020 12:30:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
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
Message-ID: <20200513123033.GL11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-7-scott.branden@broadcom.com>
 <20200513003830.GJ11244@42.do-not-panic.com>
 <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
 <20200513065046.GA764247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513065046.GA764247@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 08:50:46AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 12, 2020 at 11:31:28PM -0700, Scott Branden wrote:
> > Hi Luis,
> > 
> > On 2020-05-12 5:38 p.m., Luis Chamberlain wrote:
> > > On Thu, May 07, 2020 at 05:27:38PM -0700, Scott Branden wrote:
> > > > +#if defined(CONFIG_REQ_FW_INTO_BUF_PRIV)
> > > > +
> > > > +#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
> > > > +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf_priv
> > > > +int request_firmware_into_buf_priv(const struct firmware **firmware_p,
> > > > +				   const char *name, struct device *device,
> > > > +				   void *buf, size_t size,
> > > > +				   size_t offset, unsigned int pread_flags);
> > > > +
> > > > +#else
> > > > +
> > > > +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf
> > > > +
> > > > +#endif
> > > > +
> > > > +#endif
> > > Please clean this up, the code must reflect only the code upstream. No
> > > config stuff like this should be used on the driver. I had to stop my
> > > review here.
> > The CONFIG_ prefix shouldn't have been there as there is no Kconfig option
> > to select this.
> > Would like to just change it to a normal define without CONFIG_ prefix
> > instead?
> > This code is here to allow a limited version of the driver to run on older
> > kernels which do not have the necessary partial file read support.
> > By having it in the upstream codebase we don't need to maintain an internal
> > version of the driver.  User can take the upstream kernel module and compile
> > it against an old version of the kernel by via the define.
> 
> That's not how kernel drivers in the tree work, sorry.  They do not
> contain "older kernel support" in them, they work as a whole with the
> rest of the kernel they ship with only.
> 
> Otherwise all drivers would be a total mess over time, can you imagine
> doing this for the next 20+ years?  Not maintainable.

Scott, now imagine the amount of cleanup you'd need to do to your driver
to get it to a state where it doesn't depend on any old kernel. That's
the exact shape of the driver we want.

To backport, you can look into the backports project which strives to
backport drivers automatically [0] to older kernels.

[0] https://backports.wiki.kernel.org/index.php/Main_Page

  Luis
