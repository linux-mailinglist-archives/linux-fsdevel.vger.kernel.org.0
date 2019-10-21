Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADACCDF43A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfJUR32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 13:29:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33813 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUR32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:29:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id b72so1693119edf.1;
        Mon, 21 Oct 2019 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EYUsjio6mmwd3BPOKV1gElxOC+8ifBzUcmXkyLesSv8=;
        b=ae0YyAgJUgh6AIFRiID5Nl+4QK8DShggkbfVS8PYIaGxtu/qAcFzyKjMO/p8qXsKdP
         xsE3a7LDER6KecKte+BWfGfk9zUjp4nSjtrPMxBnPnnRmlqoLgzHdN3t+bv9+MsqrklH
         x2T49SMy/XPz3wP8nyLMnGJxd1Zg0f2fJRTYKY619pcMW3lNZ7cPonS+nmw5hz5hWV1a
         irLC0MR832lpALcTxa5tPGzwRr+F2pJA57j3EnfASskNmIDVj2wq39XTykDQl+3ErJ+x
         4VMzKClR9zmP3QI54kLAjuYi45IZQuuMZYwI2om8wUxTGXA1bIH98wEPO0NaO4t7jUzd
         N2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYUsjio6mmwd3BPOKV1gElxOC+8ifBzUcmXkyLesSv8=;
        b=siOXxqld2er9woru+2hsK26K5b9QkGXgX7FqG5y8PnzFxTACi8u5ZxJ/25vMh/i+YH
         LnVTeatq6XtddVXz11q6WJRrgWfuD6B5/b+1nthMDGaY7rgjf53WY1vjZXgsvImf0GfJ
         EsmLU3N2zOx3hGZrBR+6fxigsYxVjbbqcJE9SDFmpykG5LoZBeSRoXZPpE86SZkeE/rS
         wi1TYKtF8AN/mJ+DiQNG3r5UqPh6Xap9f5bAzu4wMlFI6M01BWUnJyrcKS9Df4ssPiMX
         HY72DGGtYSsETjR3f/LIm2muCvQWKqLQeXZZ3ZGRxwu/D9KLzkFZQvnKK4q3pmSrG5ft
         umbA==
X-Gm-Message-State: APjAAAVY1wUNd2gUNYCJU0viwbfsvIxGWZ1nZxu3cFKrgCRCPnR7PAEs
        g6DQ5X4ki13pPA8WmPG94Q==
X-Google-Smtp-Source: APXvYqwXwzmDl4AWu4PXPmYxSpf0/owrpLJsadNE9k1i9N076cwi3uOZRW/Va9vltJar9N4WB89cvQ==
X-Received: by 2002:aa7:da96:: with SMTP id q22mr870455eds.278.1571678966846;
        Mon, 21 Oct 2019 10:29:26 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id g43sm207790edb.14.2019.10.21.10.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:29:25 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:29:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Fabrizio D'Angelo <Fabrizio_Dangelo@student.uml.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, fedora-rpi@googlegroups.com
Subject: Re: [PATCH] fs: proc: Clarify warnings for invalid proc dir names
Message-ID: <20191021172923.GA5355@avx2>
References: <20191020221742.5728-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191020221742.5728-1-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 20, 2019 at 06:17:42PM -0400, Joel Savitz wrote:
> When one attempts to create a directory in /proc with an invalid name,
> such as one in a subdirectory that doesn't exist, one with a name beyond
> 256 characters, or a reserved name such as '.' or '..', the kernel
> throws a warning message that looks like this:
> 
> 	[ 7913.252558] name 'invalid_name'

Yes, the important part is filename:line which uniquely identifies
the issue.

> This warning message is nearly the same for all invalid cases, including
> the removal of a nonexistent directory. This patch clarifies the warning
> message and differentiates the invalid creation/removal cases so as to
> allow the user to more quickly understand their mistake.

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -173,7 +173,7 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
>  		len = next - cp;
>  		de = pde_subdir_find(de, cp, len);
>  		if (!de) {
> -			WARN(1, "name '%s'\n", name);
> +			WARN(1, "invalid proc dir name '%s'\n", name);

Wrong string anyway, this is nonexistent name, directory or not.

> -		WARN(1, "name len %u\n", qstr.len);
> +		WARN(1, "invalid proc dir name len %u\n", qstr.len);
>  		return NULL;
>  	}
>  	if (qstr.len == 1 && fn[0] == '.') {
> -		WARN(1, "name '.'\n");
> +		WARN(1, "invalid proc dir name '.'\n");
>  		return NULL;
>  	}
>  	if (qstr.len == 2 && fn[0] == '.' && fn[1] == '.') {
> -		WARN(1, "name '..'\n");
> +		WARN(1, "invalid proc dir name '..'\n");
>  		return NULL;
>  	}
>  	if (*parent == &proc_root && name_to_int(&qstr) != ~0U) {
> @@ -402,7 +402,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>  		return NULL;
>  	}
>  	if (is_empty_pde(*parent)) {
> -		WARN(1, "attempt to add to permanently empty directory");
> +		WARN(1, "attempt to add to permanently empty directory in proc");

"proc" will be spilled over all backtrace.

> @@ -670,7 +670,7 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
>  		rb_erase(&de->subdir_node, &parent->subdir);
>  	write_unlock(&proc_subdir_lock);
>  	if (!de) {
> -		WARN(1, "name '%s'\n", name);
> +		WARN(1, "unable to remove nonexistent proc dir '%s'\n", name);

I'm not sure if such chatty strings are necessary.
