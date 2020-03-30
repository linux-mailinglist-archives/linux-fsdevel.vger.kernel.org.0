Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD80198583
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgC3Ui6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 16:38:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50718 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3Ui6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:38:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so295093wma.0;
        Mon, 30 Mar 2020 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wIS8kcOfMdiLcF7GHMifTO3FG4cTr1kUUyJCKWFtoek=;
        b=TXXSJiG7sVGGZRSXubnBPGXMTOK6PetTPnREaATSAhyRr2vXg7dnHQimskdflqKTda
         PjjjnKro2YgrHPwlCQjRBLYKrYYjB7/F/XOuV5OzXXC0r1RAZZsvUQ5QB+H3+wfKrXGH
         h0sZJvxSpAFaSS7//d56KkRw2/CdcsvPRtPCOi7/qKS1PvUCPUyAdMPpIwV9Sgi7YG/l
         3yr1ioESr7nglRnLIjq9fj6RTFJP7o5dhJrybdkfDxfBMQGAccoCDyh6lwAHLbSoL+ql
         +gDqqLxSY7btVzklSSjDM+PLZ3mn9b6DYxHSyOgQXzuztx6ycJYzOMgtkv7VljVIJaQk
         ZOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIS8kcOfMdiLcF7GHMifTO3FG4cTr1kUUyJCKWFtoek=;
        b=VL/jGpUxYNMxTbY7FayHFpCOoFze9zR8lrksJzu1lFQ2qA6ZQfIvspOAjxFCZcEQtX
         pLuYVnfMdLuXE95PRchpC2v9aqM+2TqjhT0TLyhkh+Kv2qqH3c5vuO2uEFCtO5Q7QEvO
         3Z3kvxYAC9eEFRcGULRRHB6uz91AYBcs3wnvcaQ69CCLwbgnWkM1WTRsIOatHHWNjB43
         +/Fy6xw+lHlV5r+k2XoUQr4/HtSLy0Bw5+XN1aubuGHg7bDqkq78He42Rmso6831qbin
         n2E0Xzfnzz8jOYg0EK06WtyV63cVcFhoadEO4A0/dgx7+KPQsfe6i9JsDnlaYf/4N5cN
         Ewdg==
X-Gm-Message-State: ANhLgQ2RnziX9X0QBW3ExVr7ggc80PKh6Av/HWhgV56OFWUWzHDAJskU
        7Q7c7KPqjvrqzO4eLmyKqtFx07UU
X-Google-Smtp-Source: ADFU+vttoYXmT2g+WCD3s/CaXKQ7th36r70uNdZXH6YsVhOlRTrlaDaQLIWbIGvmDSLCWrEmQEgeTg==
X-Received: by 2002:a1c:770a:: with SMTP id t10mr1098020wmi.150.1585600734819;
        Mon, 30 Mar 2020 13:38:54 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id x16sm4080956wrn.71.2020.03.30.13.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 13:38:54 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] path_resolution.7: update to mention
 openat2(2) features
To:     Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-2-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0b3289e5-06b9-63a3-8a19-56e2551d2ce0@gmail.com>
Date:   Mon, 30 Mar 2020 22:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200202151907.23587-2-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks. I've applied this patch.

Cheers,

Michael

> ---
>  man7/path_resolution.7 | 56 ++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> index 07664ed8faec..b4a65cc53120 100644
> --- a/man7/path_resolution.7
> +++ b/man7/path_resolution.7
> @@ -29,30 +29,38 @@ path_resolution \- how a pathname is resolved to a file
>  Some UNIX/Linux system calls have as parameter one or more filenames.
>  A filename (or pathname) is resolved as follows.
>  .SS Step 1: start of the resolution process
> -If the pathname starts with the \(aq/\(aq character,
> -the starting lookup directory
> -is the root directory of the calling process.
> -(A process inherits its
> -root directory from its parent.
> -Usually this will be the root directory
> -of the file hierarchy.
> -A process may get a different root directory
> -by use of the
> +If the pathname starts with the \(aq/\(aq character, the starting lookup
> +directory is the root directory of the calling process.
> +A process inherits its root directory from its parent.
> +Usually this will be the root directory of the file hierarchy.
> +A process may get a different root directory by use of the
>  .BR chroot (2)
> -system call.
> +system call, or may temporarily use a different root directory by using
> +.BR openat2 (2)
> +with the
> +.B RESOLVE_IN_ROOT
> +flag set.
> +.PP
>  A process may get an entirely private mount namespace in case
>  it\(emor one of its ancestors\(emwas started by an invocation of the
>  .BR clone (2)
>  system call that had the
>  .B CLONE_NEWNS
> -flag set.)
> +flag set.
>  This handles the \(aq/\(aq part of the pathname.
>  .PP
> -If the pathname does not start with the \(aq/\(aq character, the
> -starting lookup directory of the resolution process is the current working
> -directory of the process.
> -(This is also inherited from the parent.
> -It can be changed by use of the
> +If the pathname does not start with the \(aq/\(aq character, the starting
> +lookup directory of the resolution process is the current working directory of
> +the process \(em or in the case of
> +.BR openat (2)-style
> +system calls, the
> +.I dfd
> +argument (or the current working directory if
> +.B AT_FDCWD
> +is passed as the
> +.I dfd
> +argument). The current working directory is inherited from the parent, and can
> +be changed by use of the
>  .BR chdir (2)
>  system call.)
>  .PP
> @@ -91,7 +99,7 @@ Upon error, that error is returned.
>  If the result is not a directory, an
>  .B ENOTDIR
>  error is returned.
> -If the resolution of the symlink is successful and returns a directory,
> +If the resolution of the symbolic link is successful and returns a directory,
>  we set the current lookup directory to that directory, and go to
>  the next component.
>  Note that the resolution process here can involve recursion if the
> @@ -124,6 +132,12 @@ the kernel's pathname-resolution code
>  was reworked to eliminate the use of recursion,
>  so that the only limit that remains is the maximum of 40
>  resolutions for the entire pathname.
> +.PP
> +The resolution of symbolic links during this stage can be blocked by using
> +.BR openat2 (2),
> +with the
> +.B RESOLVE_NO_SYMLINKS
> +flag set.
>  .SS Step 3: find the final entry
>  The lookup of the final component of the pathname goes just like
>  that of all other components, as described in the previous step,
> @@ -145,7 +159,7 @@ The path resolution process will assume that these entries have
>  their conventional meanings, regardless of whether they are
>  actually present in the physical filesystem.
>  .PP
> -One cannot walk down past the root: "/.." is the same as "/".
> +One cannot walk up past the root: "/.." is the same as "/".
>  .SS Mount points
>  After a "mount dev path" command, the pathname "path" refers to
>  the root of the filesystem hierarchy on the device "dev", and no
> @@ -154,6 +168,12 @@ longer to whatever it referred to earlier.
>  One can walk out of a mounted filesystem: "path/.." refers to
>  the parent directory of "path",
>  outside of the filesystem hierarchy on "dev".
> +.PP
> +Traversal of mount points can be blocked by using
> +.BR openat2 (2),
> +with the
> +.B RESOLVE_NO_XDEV
> +flag set (though note that this also restricts bind mount traversal).
>  .SS Trailing slashes
>  If a pathname ends in a \(aq/\(aq, that forces resolution of the preceding
>  component as in Step 2: it has to exist and resolve to a directory.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
