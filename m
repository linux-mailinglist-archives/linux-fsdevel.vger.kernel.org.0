Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7C15F654
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBNTDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 14:03:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36067 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgBNTDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:03:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so4302555pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X67Mr7JHgMW0MtPbY5RUDBc6idW8KEYPReWaSuRnXh4=;
        b=v0JLbJHanSqJgxnGB542gdGMsejEY6woNkilQ94b+P9gJ+YAMQgsu9ur6JPedZ9A3Y
         F2taOjVCszau/FtGTE4KIYWb00umSwqDTMoeIGGck0H4ZjPOUWqry7S8K5Fh6x28E6iF
         SmB56gTFYXn3LYMGEXqJsCBWipK43wSQa3ZDgo9lFxdMW4DVx4MCAFdqH4uMq98UCSIy
         c/9MmVX/DzPYfTZvGTwAJ5SMGNPcSMRjI7NG0ecOjiyy9p2kZXVm4ZJcMAnPZQlkGSPK
         XMzeJo/tveLYVOhGY1FueG8X0zp7bDjMGTcFGvf/espDzfHyJ5pmJJVFdkWZzoJOr9qB
         0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X67Mr7JHgMW0MtPbY5RUDBc6idW8KEYPReWaSuRnXh4=;
        b=CkgT2hn8CUP/JYotPLjD2j0Qpj0iBB7K7nHVN2aDo9qRDpnbtnmhUlv/tkkY7b2ari
         LUncjcmy7PbxKIaq0Pf+wRdH/o836RTbvXa83dLNQqsiK0YXsIihV3U3bmkyef/nxqo/
         qIkdKo7Z1PehK38DBsxhLApUtQvKIICzzCR8gLFNO99nJdzKG1f5APXwckgo2h9GgBng
         2bC4S3eeu5q3A72avD2+13W24fQEX31+Zinx1e86YUq4BllN2gbNvFLmLbnhxaV1EHvo
         HhNdYMHTuvIGnpU7YAoT0dXWmCJEW8/atsm6cgcR2QS4TYv6/gMkudbGS2W9KWe2mSBi
         XBlw==
X-Gm-Message-State: APjAAAVQmTnCoToX4JQ1bDIWrxYd2iZUPM2ht2K0aQXW0s2lm4oDQ9FH
        LNxs475tJ53c18K5UzeMvpcYFg==
X-Google-Smtp-Source: APXvYqwcwuUZwJSa7Do9y4rRp+P0PvJ6ZLvjFhDsEpfTEuG614CCQQrcH1qgYMDHXD8v2yUJD9C+uQ==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr5267083pjb.10.1581706997875;
        Fri, 14 Feb 2020 11:03:17 -0800 (PST)
Received: from cisco ([2001:420:c0c8:1005::22c])
        by smtp.gmail.com with ESMTPSA id r6sm7877667pfh.91.2020.02.14.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:03:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:03:14 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v2 19/28] stat: handle fsid mappings
Message-ID: <20200214190314.GD22883@cisco>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <20200214183554.1133805-20-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214183554.1133805-20-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 07:35:45PM +0100, Christian Brauner wrote:
> @@ -471,8 +484,13 @@ static long cp_new_stat64(struct kstat *stat, struct stat64 __user *statbuf)
>  #endif
>  	tmp.st_mode = stat->mode;
>  	tmp.st_nlink = stat->nlink;
> -	tmp.st_uid = from_kuid_munged(current_user_ns(), stat->uid);
> -	tmp.st_gid = from_kgid_munged(current_user_ns(), stat->gid);
> +	if (stat->userns_visible) {
> +		tmp.st_uid, from_kuid_munged(current_user_ns(), stat->uid);
> +		tmp.st_gid, from_kgid_munged(current_user_ns(), stat->gid);
> +	} else {
> +		tmp.st_uid, from_kfsuid_munged(current_user_ns(), stat->uid);
> +		tmp.st_gid, from_kfsgid_munged(current_user_ns(), stat->gid);
> +	}

I suppose this should be = ?

Tycho
