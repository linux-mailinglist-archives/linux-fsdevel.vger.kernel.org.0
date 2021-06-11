Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457883A38D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 02:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFKAeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFKAeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:34:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A115C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 17:32:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so3835276pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=++2B8d5fvOzqfmYiuDaSJxcRRKShSVx8KEKs7FThcfg=;
        b=TMeTM0ouMBYmgieA03iv25oddMK9HW7W1WJynPHCoRz7BBemrTehpf6SjWQ+tMcdwq
         kpYsjFfck8rNcUqB6GBFe+BGDBSUFcJOb3Cirfi94BLNTi+VUGVQF+u+m6IvbBxrFnrB
         fLj3BIbMJp1bXYscVbb1PmSF/VBZESJyFy2umxKHHRiVP3Vp1MquYtNZ1Xqp/0ZSTAVc
         TTSvPmZnUNEHYejdXTaL3XNZi6iWno7PrjWWaF6p5zjSI1cDd316EvnAc773cf5G+nUy
         4ZnPSA5g5OBZvL0ftInRFeNj5NZt6aOG1LL80iXyQ8D5pwUMIg7ol+nNc30As610cARL
         YAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++2B8d5fvOzqfmYiuDaSJxcRRKShSVx8KEKs7FThcfg=;
        b=ZUT1Q5NRZvdsSRk6bxDzkDkFwfatR1IGnHC7eSoKrgBUsKD+KqbLTTLWCbg+x7E8oZ
         Bxkz3Mkpj7s1OB67B/obRuy+adwmXATQBge6O0g7n4N/7ekLFIpjagMx/rkqioJSG/ky
         sSdLJhjFN50O2Qy2Y/ebl4QW5KU3fDCgLC2kAWPnBenauvubGbAzKxeY8cY2dhxjA5Zw
         uojeiqVJR7mGH+fYr4OugI/APiM29CXKdjsDw7+3y+Znx/Mo47dpsKA6uUDX3UH0nAaZ
         2ItPrKOklwQ5O4NgXAsflUZhMytOpBFHK+NuqYC5/kL3FKWmaXfGTCcMpkRwdYE4ELa3
         9nMw==
X-Gm-Message-State: AOAM530Ja6FSDV4+m7d9SLK7UPn4aHAC2LEZErYMcwO0YjG4u5pcQJkZ
        B4cux/7Gt3VJzMw00aPYzeVSFg==
X-Google-Smtp-Source: ABdhPJziHGyrWRr5MMsPVVYR5VicCcAozjFIrfEVZ4lVrO8rClc4TbrgTf6Is3NF+hlragoonGOlnw==
X-Received: by 2002:a17:903:2310:b029:109:e746:89a2 with SMTP id d16-20020a1709032310b0290109e74689a2mr1366262plh.8.1623371556671;
        Thu, 10 Jun 2021 17:32:36 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:f66a:ff0e:a646:785c])
        by smtp.gmail.com with ESMTPSA id e24sm3672999pgi.17.2021.06.10.17.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:32:35 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:32:24 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YMKvGEvNISpIOOFE@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <20210610112331.GB23539@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112331.GB23539@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 01:23:31PM +0200, Jan Kara wrote:
> > @@ -524,6 +561,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  	}
> >  	metadata.fd = fd;
> >  
> > +	/*
> > +	 * Currently, reporting a pidfd to an unprivileged listener is not
> > +	 * supported. The FANOTIFY_UNPRIV flag is to be kept here so that a
> > +	 * pidfd is not accidentally leaked to an unprivileged listener.
> > +	 */
> > +	if (pidfd_mode && !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) {
> 
> Hum, you've added FAN_REPORT_PIDFD to FANOTIFY_ADMIN_INIT_FLAGS so this
> condition should be always true? I don't think we need to be that much
> defensive and would just drop the check here.

Yes, that's right, so dropping this check is also fine with me.

> > @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  		put_unused_fd(fd);
> >  		fput(f);
> >  	}
> > +
> > +	if (pidfd < 0)
> > +		put_unused_fd(pidfd);
> > +
> 
> put_unused_fd() is not enough to destroy the pidfd you have. That will just
> mark 'pidfd' as free in the fd table. You rather need to call close_fd()
> here to fully close open file.

Ah, I see, put_unused_fd() doesn't free up the file instance. I will swap
this out with close_fd() instead.

Thanks for the suggestions Jan!

/M
