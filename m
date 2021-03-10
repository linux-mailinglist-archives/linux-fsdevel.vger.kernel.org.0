Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994D33478A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 20:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhCJTH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 14:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhCJTHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:07:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6AC061760;
        Wed, 10 Mar 2021 11:07:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f12so24559557wrx.8;
        Wed, 10 Mar 2021 11:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jq0Z3fnfayb5xVqEpqsZTqs2j3PIOZdFc6XjGP6aSxY=;
        b=N5V5T0WvJEuIVWBGJQp3wl2yR/bq27+b5xGEjRfVwHwrtLTWVjxrBipiANQ++8JiQW
         wnMzEa+zHyVqZPTCxH3wLQ32ULfg+dV7VnItaQ3n7gxNU92TO7/4ak1Y+++25AHOEvPX
         OVDkKUgwyLFOB6cvlfTD1mQxdmtfaJnQycTkPPIFppEQA7Q0SXpB99fK7dHZI2/9LJYP
         Q75Tfqrr7hFOhj0m4u5T1DYMoOLcfNq7DjrbWUt7wqMXthaquFC/TJ4la5jW6tRmwMbT
         r2o7jTkdu25SGNuhWylTq7IOlS9INWsFzludN+0qcsUg8S1yUYe8MN3ADOGB4K1uwDnZ
         Tnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jq0Z3fnfayb5xVqEpqsZTqs2j3PIOZdFc6XjGP6aSxY=;
        b=S3pmYc5FwH+p0jogT/587KQJ/qvWgMujTKoVRkKqeSWA6fcPBdL7cuxRKO6vWave74
         7BePmqOb4LRmsVN+ELx+Mx+t2r3Cmp3Hx76/YjxuXoqDyqn2liBV2wbcUjTpwFyJOYUo
         72kiKIiGCcEwpjsPRiZRylJKHgxg9ZHRj8SpPS6tbJZwndgkKBF/ZyynexCWgB9rhA1Y
         t8V7SL1EVdYW4HgQEfQdVQjr7NunQKWenLn3sHtTb76ArCkuLfyh0Kz7d6267Vjc/nQD
         pFiBkZBfcXeHa0xCW7pb/fZwlfjrfhOyncdDIi327dk/6m/+meK9aG9Wxw/yUxNwyQio
         gbCw==
X-Gm-Message-State: AOAM531oFSmwDRuTJtXD+vtcusxMYDeeei0Ji/1LSGlA6RZIBgc6UdR5
        I9j/ypyDId/cPyMFZlIK0LEE3C2p5Hotfw==
X-Google-Smtp-Source: ABdhPJygXyC8VynAdD4EkBm0+DQD1agZcFD93qSYxIi+Je3GoFDgHz+ANI7V2twcV52xLHuVbiVH1A==
X-Received: by 2002:adf:82af:: with SMTP id 44mr4824283wrc.279.1615403224018;
        Wed, 10 Mar 2021 11:07:04 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id p27sm432050wmi.12.2021.03.10.11.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 11:07:03 -0800 (PST)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>
Cc:     smfrench@gmail.com, Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com>
Date:   Wed, 10 Mar 2021 20:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304095026.782-1-aaptel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/4/21 10:50 AM, Aurélien Aptel wrote:
> From: Aurelien Aptel <aaptel@suse.com>
> 
> Similarly to NFS, CIFS flock() locks behave differently than the
> standard. Document those differences.
> 
> Here is the rendered text:
> 
> CIFS details
>    In  Linux kernels up to 5.4, flock() is not propagated over SMB. A file
>    with such locks will not appear locked for remote clients.
> 
>    Since Linux 5.5, flock() locks are emulated with SMB  byte-range  locks
>    on  the  entire  file.  Similarly  to NFS, this means that fcntl(2) and
>    flock() locks interact with one another. Another important  side-effect
>    is  that  the  locks are not advisory anymore: a write on a locked file
>    will always fail with EACCES.   This difference originates from the de-
>    sign of locks in the SMB protocol, which provides mandatory locking se-
>    mantics. The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)
>    and  flock() lock propagation to remote clients and makes flock() locks
>    advisory again.
> 
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> Reviewed-By: Tom Talpey <tom@talpey.com>
> ---
[...]
> +This difference originates from the design of locks in the SMB
> +protocol, which provides mandatory locking semantics. The
> +.I nobrl

I agree with Tom.  It's much easier to read if you just say that 'nobrl' 
torns off the non-locale behaviour, and acts as 5.4 and earlier kernels. 
  Unless there's any subtlety that makes it different.  Is there any?

BTW, you should use "semantic newlines":

$ man 7 man-pages |sed -n '/semantic newlines/,/^$/p'
    Use semantic newlines
        In the source of a manual page,  new  sentences  should  be
        started  on new lines, and long sentences should split into
        lines at clause breaks (commas, semicolons, colons, and  so
        on).   This  convention,  sometimes known as "semantic new-
        lines", makes it easier to see the effect of patches, which
        often  operate at the level of individual sentences or sen-
        tence clauses.


Thanks,

Alex

> +mount option (see
> +.BR mount.cifs (8))
> +turns off
> +.BR fnctl (2)
> +and
> +.BR flock ()
> +lock propagation to remote clients and makes
> +.BR flock ()
> +locks advisory again.
>   .SH SEE ALSO
>   .BR flock (1),
>   .BR close (2),
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
