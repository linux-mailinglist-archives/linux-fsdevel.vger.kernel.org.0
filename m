Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D7F19AE28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgDAOlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 10:41:37 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54637 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgDAOlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:41:37 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so21843pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HfPFNwmDkfOnPIp3KtUBPjXsLI4JkbyQkGj/q/lYOhA=;
        b=hILXlyNm5rm7/90fu4LZHfY8txVlENFOCqA4PZl86jm8x2OBMfsHvUZ5pdiUliB7Hu
         cv9JY4xBiLTe6uc2ub02+xaJuTc3BaebPjgHNOKmxUeJ//gdmwM3Hl/A/iwgyKHSGleO
         a/QJNazm72wndR0thboWymnLEjA3/IpeYzEmAoToZjCeaKvcA5BqRXR2mjMFi+rvs49D
         Z3CMHZW8kq+WVp3psWkogqjtIOmZVmz210VSzg/08nAZbEk9H5nQQ2gcsHFWKgv2hBN+
         qbMqlyE85zkniXlwJEWqR72C9LcezWglQ1OddmoyVuNcqWOaUzQx2IGOiCfh+LTz/ur4
         mp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfPFNwmDkfOnPIp3KtUBPjXsLI4JkbyQkGj/q/lYOhA=;
        b=DjF/IK99vx92z8Jv+GAntwxd5xkigaFZvtoHVDNV/9RmatOeLTOizC2OwuqTpH1twV
         NHEEaXRh4Ba3H8UQHQmiyvjUqrlSjyWoZaJE3XZH1g/fPqDagpRQ6zL/uwOfnIKmocVT
         emrBt7czlrInW1kh5acRU+B65b29R2BhegG7aT5IrAQbpFY3/9SIr2s0WR2oOrlrBLdE
         4ENOuSmpE7T9HAs8XUPm0/LUlAbIPxQBDy8nGXQDlyPbJmoQZLzGyL8xN+y6CLE/Dqb8
         vZe9GqfWtI/C7BiogLAEAp9CY8HwhB0c0elrjJvj4YQoHzPsddGo1HwKK0GQBaPUkt6X
         wzEQ==
X-Gm-Message-State: AGi0PuYhbdZtjmlq+AauoXHyGCB/WUuyGejEvfZ4D+RJ/FzQyUCHrMf1
        WqOVcSYYViobL+nJMEqwymAySg==
X-Google-Smtp-Source: APiQypJHLsC2dVtdtQ3xLsn8BhVe1AEHtj2of90gLEdROpcJkWt08CvYqtJlTaMbh5SGXzO/+fyCwQ==
X-Received: by 2002:a17:90b:3747:: with SMTP id ne7mr5091522pjb.181.1585752095779;
        Wed, 01 Apr 2020 07:41:35 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 135sm1779210pfu.207.2020.04.01.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:41:34 -0700 (PDT)
Subject: Re: [PATCHv3 1/2] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200302175135.269397-1-dima@arista.com>
 <20200302175135.269397-2-dima@arista.com> <87tv23tmy1.fsf@mpe.ellerman.id.au>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <daf484e9-7f3d-9c76-d4c4-a054dcf236c1@arista.com>
Date:   Wed, 1 Apr 2020 15:41:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tv23tmy1.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michael,

On 4/1/20 1:22 PM, Michael Ellerman wrote:
[..]
>>  
>> +/**
>> + * sysrq_mask - Getter for sysrq_enabled mask.
>> + *
>> + * Return: 1 if sysrq is always enabled, enabled sysrq_key_op mask otherwise.
>> + */
>> +int sysrq_mask(void)
>> +{
>> +	if (sysrq_always_enabled)
>> +		return 1;
>> +	return sysrq_enabled;
>> +}
> 
> This seems to have broken several configs, when serial_core is modular, with:
> 
>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> 
> See:
> 
>   http://kisskb.ellerman.id.au/kisskb/buildresult/14169386/
> 
> It's also being reported by the kernelci bot:
> 
>   https://lore.kernel.org/linux-next/5e677bd0.1c69fb81.c43fe.7f7d@mx.google.com/


Thanks for reporting this,

I've reproduced it and sent a fix:
https://lkml.kernel.org/r/20200401143904.423450-1-dima@arista.com

Thanks,
          Dmitry
