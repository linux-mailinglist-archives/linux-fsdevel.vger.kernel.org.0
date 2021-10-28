Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D665C43E923
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJ1T7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 15:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1T7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:59:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B3C061570;
        Thu, 28 Oct 2021 12:56:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so8519872otj.6;
        Thu, 28 Oct 2021 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aak0WtxCK0j+PLN6qPbUpAPMN8pjL5YEDqdesj0sHso=;
        b=qqd0wZoN+xBz8fE9Rh+h0/0svB4rXHug2LFk6wlbgDpdf7UrBYzsrCNgaLQurlp+n3
         NOozGrA+LIIBA6U9mzzlg3HxbiZGIzP9IcIk1Z17gvlE5Td3Bwj8tZpG4+8lO55K/Tis
         xcc3A2m470Te5QqzVty56GqosmqDH9m2tUYjHisV/QxMzm9uvfbDjHP4paKByROkFvtz
         onyrDq8vG4sDalfVqva/ddI5rHXvBChv0d+rCF56M0HPOUgnRT4ZfmfIHw2WOiqSWg94
         +wmkQHt+8Dy/gbiHTarKPjmXRbZKHmoxbVO9GfJTPPcrhhXPQawKN3qeJ4BiH1XPLXZA
         prBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Aak0WtxCK0j+PLN6qPbUpAPMN8pjL5YEDqdesj0sHso=;
        b=Low7IXm04EbSj/C4NxAfj51HveOQazh3l++5gVWPa0lmV/qrxf5SY1LWbqz1euT+6T
         XmZISUokp6U3tAMvbQ7Lre45jBC318rPlqRfh7jHky4K14eQOM3hRNqnB5lSEMpL/ytm
         bXPA1o8VQqLIBMoA8JNfkSFABitehsIrBC87XOZ25wge/RB7v7lwySA/MowkHZXlBpTD
         vR7hvqnMIhE6p3LinahUzPz9eebPbiLxqmxAlK4H8Hsii6g8yxXfTgvki41exv5EmMPR
         BdBYE29AQnI6/RZQ6Bqg1nU3XbfW7zvoLuWK0SvtKPqjGnUT4PoR9R6ZO+IaP6vxFoom
         7jwg==
X-Gm-Message-State: AOAM531PMNyb0B5G7dUWRD5gnvVd3JpXf52xHzchP4JgkYWZDvozHQpg
        FWU/SoMYb1Rdw9KvHHUMy+RD3AJB2T0=
X-Google-Smtp-Source: ABdhPJxWjVYYNRZ4pv4iZvJGtxrZ/WoQ/oKbP8OY0Mtjc97K6COsubBavvYW4gCK/fVfeujMEdcARQ==
X-Received: by 2002:a9d:ba5:: with SMTP id 34mr5073772oth.108.1635451009303;
        Thu, 28 Oct 2021 12:56:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15sm1270940otu.67.2021.10.28.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:56:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 12:56:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 31/32] samples: Add fs error monitoring example
Message-ID: <20211028195647.GB739110@roeck-us.net>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-32-krisman@collabora.com>
 <20211028151834.GA423440@roeck-us.net>
 <87fsslasgz.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsslasgz.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 03:56:28PM -0300, Gabriel Krisman Bertazi wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
> > On Mon, Oct 18, 2021 at 09:00:14PM -0300, Gabriel Krisman Bertazi wrote:
> >> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> >> errors.
> >> 
> >> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> >> ---
> >> Changes since v4:
> >>   - Protect file_handle defines with ifdef guards
> >> 
> >> Changes since v1:
> >>   - minor fixes
> >> ---
> >>  samples/Kconfig               |   9 +++
> >>  samples/Makefile              |   1 +
> >>  samples/fanotify/Makefile     |   5 ++
> >>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
> >>  4 files changed, 157 insertions(+)
> >>  create mode 100644 samples/fanotify/Makefile
> >>  create mode 100644 samples/fanotify/fs-monitor.c
> >> 
> >> diff --git a/samples/Kconfig b/samples/Kconfig
> >> index b0503ef058d3..88353b8eac0b 100644
> >> --- a/samples/Kconfig
> >> +++ b/samples/Kconfig
> >> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
> >>  	  with it.
> >>  	  See also Documentation/driver-api/connector.rst
> >>  
> >> +config SAMPLE_FANOTIFY_ERROR
> >> +	bool "Build fanotify error monitoring sample"
> >> +	depends on FANOTIFY
> >
> > This needs something like
> > 	depends on CC_CAN_LINK
> > or possibly even
> > 	depends on CC_CAN_LINK && HEADERS_INSTALL
> > to avoid compilation errors such as
> >
> > samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
> >     7 | #include <errno.h>
> >       |          ^~~~~~~~~
> > compilation terminated.
> >
> > when using a toolchain without C library support, such as those provided
> > on kernel.org.
> 
> Thank you, Guenter.
> 
> We discussed this, but I wasn't sure how to silence the error and it
> didn't trigger in the past versions.
> 
> The original patch is already in Jan's tree.  Jan, would you pick the
> pack below to address it?  Feel free to squash it into the original
> commit, if you think it is saner..
> 
> Thanks,
> 
> -- >8 --
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> Date: Thu, 28 Oct 2021 15:34:46 -0300
> Subject: [PATCH] samples: Make fs-monitor depend on libc and headers
> 
> Prevent build errors when headers or libc are not available, such as on
> kernel build bots, like the below:
> 
> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file
> or directory
>   7 | #include <errno.h>
>     |          ^~~~~~~~~
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  samples/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 88353b8eac0b..56539b21f2c7 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
>  
>  config SAMPLE_FANOTIFY_ERROR
>  	bool "Build fanotify error monitoring sample"
> -	depends on FANOTIFY
> +	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
>  	help
>  	  When enabled, this builds an example code that uses the
>  	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
> -- 
> 2.33.0
