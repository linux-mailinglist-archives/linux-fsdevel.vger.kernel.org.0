Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8532D20AEB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFZJGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFZJGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:06:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE7C08C5C1;
        Fri, 26 Jun 2020 02:06:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so8646305ejc.3;
        Fri, 26 Jun 2020 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7k82GdfRQZIx/YywdeTQaGLOZj9qWIQ3HM2GGjeWyUU=;
        b=muNc1zvPbOcqM0AZGa4ENKGHHvs5qfjHgOqwmOWYFZO6IyGXNbaDyWW5hFIMQxXQhZ
         RjnHnqug0gx0eOoNveqteLuQCK6bDC1OIzfMko9z+I0Mevu6IqfoNFbPWE7Y7Sq3TMAV
         6OXYsWsbn5SWFuuqvAlrw1J9MtZox2rxgCFpEwlXB9hzwLOLFIHLgLiUN4rHdsBnKppd
         SfaoJJL656l5uRFUKbbrXqDLjkMHRiq3o11BzcpEtNcBG12vc4gaiNHIfcf0LGOK5+B5
         brljkx1ZY8TUHLQHQZc8vb3xmlNW6kzGZHitgbLb8PIJH+S/UQ3FbTUAmd/EZJgKJ/v3
         uhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7k82GdfRQZIx/YywdeTQaGLOZj9qWIQ3HM2GGjeWyUU=;
        b=DhjLeXuKsyRtshxmowmH1q+8Z8OFIPT8i4CqJIPr6JqsyeW66VhW0UcvzJ43nahSMr
         Fu+dMOVQRfy4uzQ/rXgVuUR2UkNVa91xfZmvCQECsl6XrKAh6wossBkdOjxVNpwB7SAC
         RoEOMON7d8+vjgeTQM/3QQjRJEvUvAbjqhJfEPQbXwcZD2t14qWVv2KJKSibVzx1Rm8q
         06YN0W9FzTtemW/eegL/hORAVPrGj94P4xa/FeK/sPFCd4C0IIgKa8L+4IoIMMvzoj7H
         tt8YcyJKs0Nx2gAadYJRyZzA+6rkm2apZdvnM/Dy73eH/0e9j3e8Es/778ai75ZnfYXf
         SITg==
X-Gm-Message-State: AOAM531zov1beIzto09gSaOVDwKHvY9CkG9Jh66a2rGO2f8wIwUg+GW6
        NwlzSehixluScIneF1Aaf5K+qXIO
X-Google-Smtp-Source: ABdhPJwL/O8ELz2OXgRCyWiTh5z9d1vYQ0aRl6btpPl1+FavJ/m62CF9RL3vOD1b4KD41Lf3WwdYDw==
X-Received: by 2002:a17:906:4086:: with SMTP id u6mr1807597ejj.9.1593162382413;
        Fri, 26 Jun 2020 02:06:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id z15sm18408763eju.18.2020.06.26.02.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 02:06:21 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org
Subject: Re: [PATCH v2] sync.2: syncfs() now returns errors if writeback fails
To:     Jeff Layton <jlayton@kernel.org>
References: <20200625233731.61555-1-jlayton@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3e2d6625-72bd-324c-b6d3-4e2a4bc5e369@gmail.com>
Date:   Fri, 26 Jun 2020 11:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625233731.61555-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

On 6/26/20 1:37 AM, Jeff Layton wrote:
> A patch has been merged for v5.8 that changes how syncfs() reports
> errors. Change the sync() manpage accordingly.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks. Patch applied. (I've not yet pushed it, in case any 
review comments might still come in.)

Cheers,

Michael

> ---
>  man2/sync.2 | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
>  v2: update the NOTES verbiage according to Eric's suggestion
> 
> diff --git a/man2/sync.2 b/man2/sync.2
> index 7198f3311b05..61e994c5affc 100644
> --- a/man2/sync.2
> +++ b/man2/sync.2
> @@ -86,11 +86,26 @@ to indicate the error.
>  is always successful.
>  .PP
>  .BR syncfs ()
> -can fail for at least the following reason:
> +can fail for at least the following reasons:
>  .TP
>  .B EBADF
>  .I fd
>  is not a valid file descriptor.
> +.TP
> +.B EIO
> +An error occurred during synchronization.
> +This error may relate to data written to any file on the filesystem, or on
> +metadata related to the filesytem itself.
> +.TP
> +.B ENOSPC
> +Disk space was exhausted while synchronizing.
> +.TP
> +.BR ENOSPC ", " EDQUOT
> +Data was written to a files on NFS or another filesystem which does not
> +allocate space at the time of a
> +.BR write (2)
> +system call, and some previous write failed due to insufficient
> +storage space.
>  .SH VERSIONS
>  .BR syncfs ()
>  first appeared in Linux 2.6.39;
> @@ -121,6 +136,13 @@ or
>  .BR syncfs ()
>  provide the same guarantees as fsync called on every file in
>  the system or filesystem respectively.
> +.PP
> +In mainline kernel versions prior to 5.8,
> +.\" commit 735e4ae5ba28c886d249ad04d3c8cc097dad6336
> +.BR syncfs ()
> +will only fail when passed a bad file descriptor (EBADF). In 5.8
> +and later kernels, it will also report an error if one or more inodes failed
> +to be written back since the last syncfs call.
>  .SH BUGS
>  Before version 1.3.20 Linux did not wait for I/O to complete
>  before returning.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
