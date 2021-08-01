Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1C3DCBEA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhHANsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHANsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 09:48:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B8C06175F;
        Sun,  1 Aug 2021 06:47:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso2379173wmq.3;
        Sun, 01 Aug 2021 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLePBnGNMT64iPL9g6BRKM5SmHQEMJsjl0K/pqskcO4=;
        b=OnII6LtwIaDld4l5/yNHOQDFRgWPfLrvMDJuwk5ubCHqsge44NFCZ19urpRQ/J5FiC
         ZwoJANlVpckqvFjAfOJOJ/EpJsMzjRJ3h5s/hI5veHSUgX9AMBfm8QbsZgKuW4iaHEZ8
         RxyekELAPia7r5l+ZubKEDt/Rhvsxr/SHOliv+MOrVlqs7QovvFNzEdqQn/4JKOoa5OO
         l+U+HlItcnjASTGW4z1fKVreR2yhUygqqidg2Rx6h2i9ApRy/Q/41548iS3Vakz6QJTp
         fedszDh9O7Y+oQSQePhr+39XSq3bJxfyVSrHXrwO/f6XPF0a3j6LVgRuZmwG9wluTG/V
         p24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLePBnGNMT64iPL9g6BRKM5SmHQEMJsjl0K/pqskcO4=;
        b=SGPn58XMB4snJxWAfDxntbWv3alRX6FF+qM3xNtWzxD3Wv1JZyNd8KgDWpmJq0NePt
         yHgnz83rdCxtwXLiRXlJq5STwyUWd+MtccKFH9bHvrWLPOVuVor4sGxFvTbqdJwmorXx
         ARnsJzjt2CEY6j7XFikdRJnYD3kouKfLopEFeWiWsPkpEmgTLhhBGmwXzbxEE1+Xq3wV
         bCmV48bowg3QIpBsGYqZJ8iwxJBUgwfrGQ2hhY4Q6Xmj0K6byLlTWOUeFXiQImEhfyAL
         hjR1QNhiZIZnOEmBJNLJrjVhhD+4bEJ48AX0JJnN3bLhj9uP3xz6PLr00cBsg0KrELWy
         r61A==
X-Gm-Message-State: AOAM533eOZMsyExSPn8ZurKW9FoCZnajGsG4gCslZm2gO1V4CXMq7Idn
        s6vbGOoMmY8LLcQ3HF0LiKb+gk41wqQ=
X-Google-Smtp-Source: ABdhPJyQJbKM3Ne11Z2qKFZ2QJTDaZKDzYw/IIcl+g9yikgfJaPqqu5NKxpE6Ifg+OTCChXPS/+wUw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr12260531wmj.56.1627825675790;
        Sun, 01 Aug 2021 06:47:55 -0700 (PDT)
Received: from [10.8.0.10] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id v18sm7375507wml.24.2021.08.01.06.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 06:47:55 -0700 (PDT)
Subject: Re: [PATCH v3] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
To:     Christian Brauner <brauner@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210731101527.423200-1-brauner@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <828acf6c-dd06-e153-f7c8-9e1de7342b5f@gmail.com>
Date:   Sun, 1 Aug 2021 15:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731101527.423200-1-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

This time I'm going to point out issues about the contents only, not 
groff fixes nor even punctuation fixes.  I'll fix those myself and CC 
you when I do that.

However, if you render the page yourself (man ./mount_setattr.2), you 
will probably notice some formatting issues.

Please see some comments below.

Thanks,

Alex

On 7/31/21 12:15 PM, Christian Brauner wrote:
> 
> +.SH ERRORS
> +.TP
> +.B EBADF
> +.I dfd
> +is not a valid file descriptor.
> +.TP
> +.B EBADF
> +An invalid file descriptor value was specified in
> +.I userns_fd.

Why a different wording compared to the above?  Aren't they the same?

userns_fd is not a valid descriptor.

That would be consistent with the first EBADF, and would keep the 
meaning, right?

> +.TP
> +.B EBUSY
> +The caller tried to change the mount to
> +.BR MOUNT_ATTR_RDONLY
> +but the mount had writers.

This is not so clear.  I think I understood it, but maybe using language 
similar to that of mount(2) is clearer:

EBUSY  source cannot be remounted read‐only, because it still holds 
files open for writing.

Something like?:

The caller tried to change the mount to MOUNT_ATTR_ONLY but the mount 
still has files open for writing


> 
> +static const struct option longopts[] = {
> +    {"map-mount",       required_argument,  0,  'a'},
> +    {"recursive",       no_argument,        0,  'b'},
> +    {"read-only",       no_argument,        0,  'c'},
> +    {"block-setid",     no_argument,        0,  'd'},
> +    {"block-devices",   no_argument,        0,  'e'},
> +    {"block-exec",      no_argument,        0,  'f'},
> +    {"no-access-time",  no_argument,        0,  'g'},
> +    { NULL,             0,                  0,   0 },
> +};

The third field is an 'int *' 
(https://www.gnu.org/software/libc/manual/html_node/Getopt-Long-Options.html). 
  Please, use NULL instead of 0.


> 
> +    struct mount_attr *attr = &(struct mount_attr){};

Wow!  Interesting usage of compound literals.
I had to check that this has automatic storage duration (I would have 
said that it has static s.d., but no).

I'm curious: why use that instead of just?:

struct mount_attr attr = {0};

> 
> +    if (ret < 0)
> +        exit_log("%m - Failed to change mount attributes\en");


Although I typically use myself that same < 0 check,
manual pages typically use == -1 when a function returns -1 on error 
(which most syscalls do), and Michael prefers that.



-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
