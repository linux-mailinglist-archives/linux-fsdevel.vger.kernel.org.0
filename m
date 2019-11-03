Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6CED461
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 20:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfKCTiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 14:38:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38238 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfKCTiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:38:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so14887480ljc.5;
        Sun, 03 Nov 2019 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DA97c1OVaZrH8SvTZWoH5od6ijrQ6ybNR3pRj3cE098=;
        b=FyDID7sVwcKA8u2OXigUOGeLpN0r0KJ3r2nEpMx0KzYOU04J9slKn6GMoVITpEqJuO
         NI4tMie2/xsh3jpLitK6dLyd8M8EaccIOt1TejbOamSIFRby8AV4N5sL2uJqUwFFKXMU
         N9d0oRR17KcF7aPixdnvTWNo4upGstyhwdGfP0mop5EWgRttjYfFxPP/m/IQdMnvSRZz
         K4MYMdzB4JUaqpB45vL4aYjyrhEJLQgfLQdmRAdMPNTdlQtjzfCsOnjYVEqcgKTFv3WX
         H+a7bWb5dLZI8JvzdxWN8m9e91gPfgdQTAGflmeuSSA4F//w3eGcuFkjgD4Fym33dRe2
         0hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DA97c1OVaZrH8SvTZWoH5od6ijrQ6ybNR3pRj3cE098=;
        b=PMoTSYxPhzxHAU9hIvOtUOix0XiqtPo3mtjrVpu44J6HHaEW9HS7rmppQFSYwSH+w7
         8B4OwRy5+fa9EL7usQsIBuR4Z3ej6wJu/Ze8zUGrTTwphWHa4+I/bkv6IsAeQd99iza3
         ni1eJw63tAPJWR7hiIQIQv1gD13EV3yYErSYWeGW2tMwcdCupuqIbjBOuvXVmHBi3JYr
         hSItAjGlT+vfHp0haQmbTbn27CuPzZOtBK/Sq7BX93Wtoh0Wza5FQCzNYwFCTTZq870r
         oTvIJrog6t4/uqjiMidLpH7l8NjhElPg/g6oGhFuAUJXoi9jn1q9RgyEUXvcw0B/eRlh
         N1uA==
X-Gm-Message-State: APjAAAXdbHiYSAr/5kNZZNR/qMRSVaiaZrX741TV3j5JvEBwEAuPC4NO
        /lORtvYg4tbdQ/rb/6G0vf3v5Au9
X-Google-Smtp-Source: APXvYqyI5+BujfgI/FWXMTlWmlpvJKcofGCBiYtBRXJQWqPdTY+AmdPXHL/kdDH4Ts+TNvIJ2IEotg==
X-Received: by 2002:a2e:3a1a:: with SMTP id h26mr16166320lja.25.1572809931956;
        Sun, 03 Nov 2019 11:38:51 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id v9sm5897917ljk.56.2019.11.03.11.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 11:38:51 -0800 (PST)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <87d0e8g5f4.fsf@x220.int.ebiederm.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
Date:   Sun, 3 Nov 2019 21:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87d0e8g5f4.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3.11.2019 20.50, Eric W. Biederman wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> Several items in /proc/sys need not be accessible to unprivileged
>> tasks. Let the system administrator change the permissions, but only
>> to more restrictive modes than what the sysctl tables allow.
> 
> This looks quite buggy.  You neither update table->mode nor
> do you ever read from table->mode to initialize the inode.
> I am missing something in my quick reading of your patch?

inode->i_mode gets initialized in proc_sys_make_inode().

I didn't want to touch the table, so that the original permissions can 
be used to restrict the changes made. In case the restrictions are 
removed as suggested by Theodore Ts'o, table->mode could be changed. 
Otherwise I'd rather add a new field to store the current mode and the 
mode field can remain for reference. As the original author of the code 
from 2007, would you let the administrator to chmod/chown the items in 
/proc/sys without restrictions (e.g. 0400 -> 0777)?

> The not updating table->mode almost certainly means that as soon as the
> cached inode is invalidated the mode changes will disappear.  Not to
> mention they will fail to propogate between  different instances of
> proc.
> 
> Loosing all of your changes at cache invalidation seems to make this a
> useless feature.

At least different proc instances seem to work just fine here (they show 
the same changes), but I suppose you are right about cache invalidation.

-Topi
