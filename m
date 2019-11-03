Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7AFED45B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfKCTYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 14:24:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45407 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfKCTYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:24:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so1640199ljg.12;
        Sun, 03 Nov 2019 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Cn+TTapRLyVC5hXpBcuynf0UtMJbDzZiiqHnWWqVcxk=;
        b=XQbAHQUEXAph8jh6KhXJIuUOdDoO/EBJecQlBnsil0vmMdvd1uDPNKeSt39/cP+m9I
         7C6inMHs5AJMnB8QWk1pstsGIif9Z/W8dK5S7c4fmnhVWiYYkra23J/iRvsY+1NFUVIk
         ehioaSP3YlJYWK4GQIzsYr9eabziBpMyWyb3cUSze0aq64pyE5ll1IJYFHC+Jg7HcwAv
         qo76D83s+5ZLfPdNVc/gsH8NkdxTHPYAoVEaGiPkCvM6BuQ+HNLdx3cWyJfRYzFT9U/+
         Z7kvmkSBGqGAY/MNfW+S/592BgXuejYp8TRc1TN/dMHReBK4OQVxeTatYr+Fl4ekXBWJ
         odBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Cn+TTapRLyVC5hXpBcuynf0UtMJbDzZiiqHnWWqVcxk=;
        b=RNRIvQhZ68r5955yRht/dkbBDCG55YqHFXfYyxX3xYyW44GpIGSGd1zR7WPbnTMJNK
         jAKueyEYfcBEZSd/EONzXk/FqXjwoc479wojqRez+ictJh6iv2lCTE94AAyeLx+dfqhc
         i9oLmGnLZc84x4i+KMP8ODdE9pWX8yVBCU6HiVo60YyiYzzQ6rwn2HYXaT2Yl+aqXkAj
         6Lg+aXbi1epfMTZH+9jpyCoG7ISoqcd0vJC+cU/jD9OoBROi7NuXaYT9CQbDOJiPs56N
         RcmsbWOzDMpIvT65SBjwEuK/tRoI76psBB15s9jKwsw48OPito9Um+eRQZXLxDMYxthS
         ctfw==
X-Gm-Message-State: APjAAAV7p7l70BxvJ1PJTNvDYFfZ/FufxbFWhFVOcPSuJ8EFzf6WtdeP
        WKmP+kjv/wqYNLvzuLcKAgOuBC7s
X-Google-Smtp-Source: APXvYqwUIZAyYXiBwtW09jUHGCsQ29gpEInO9eR0oD1e+HyzRTbRa5GCW7l3dapLf38f580FPFeQ3g==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr4238773ljg.157.1572809069716;
        Sun, 03 Nov 2019 11:24:29 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id d28sm5604066lfn.33.2019.11.03.11.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 11:24:29 -0800 (PST)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191103175648.GA4603@mit.edu>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <226c6c2b-df7a-7eb1-e8c5-60fc23998f89@gmail.com>
Date:   Sun, 3 Nov 2019 21:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103175648.GA4603@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3.11.2019 19.56, Theodore Y. Ts'o wrote:
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
>> Several items in /proc/sys need not be accessible to unprivileged
>> tasks. Let the system administrator change the permissions, but only
>> to more restrictive modes than what the sysctl tables allow.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> Why should restruct the system administrator from changing the
> permissions to one which is more lax than what the sysctl tables?
> 
> The system administrator is already very much trusted.  Why should we
> take that discretion away from the system administrator?

That could make sense, in addition changing UID/GID would allow even 
more flexibility. The current checks and restrictions which prevent 
those changes were already present in original code in 2007. I didn't 
want to change the logic too much. Perhaps loosening the restrictions 
could be a follow-up patch, as it may give chance to use more of generic 
proc or fslib code and thus a larger restructuring.

-Topi
