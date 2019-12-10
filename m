Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532E4119BA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 23:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfLJWKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 17:10:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbfLJWKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576015818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ovr8AOrCcVXk6ps0Yd3R+k9jarJnVZ/R6m24MU31Neg=;
        b=Pqqc7OHLvlgJLovS9IHJmjbNTH8+nPSXzIN+/TMFoDTfU/i+1ZmaCDPGgS9eWkp4LLZxNA
        EmFsHRQKH8u0cBymH3EjS2eZQhvDmaSP5kxdAxqcpxiFy25fqeE+9BfYkoQFB5QlkApB4z
        GjjS7FgG6xWCUHD/+DuVRX5yU0zZWNE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-q5Gg1-v0OregkMqpmiCPfg-1; Tue, 10 Dec 2019 17:10:14 -0500
Received: by mail-qk1-f198.google.com with SMTP id 65so5597587qkl.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 14:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ovr8AOrCcVXk6ps0Yd3R+k9jarJnVZ/R6m24MU31Neg=;
        b=Mzs8SIH7bSM/Od1A3npAgKLofWLdvqxXyipPqv5BdFDHmlgud5BsDfb7DIevCTt098
         pfDNreoAt+z2qu+vdBrC5e0GAXvqxiAidjapARb58sEuWffdNnTxDv8xLhCGiH2tvZln
         OsDVeJ7A1svRpXsx65v5dZMV3fo41EYyCBtqrYwx6X5I3d/cZQiL2VsGfS6PQABVcaQC
         76euTLJDz4Dw8e1RX41ZV4jtlB1QyZz9stMbMFRqrChF2brmx+/Zb7UxScNr7uerxdC0
         9AK2qHm8wvQffwJKpzD0bqudSiJ7BecUV5hwKeA2DUuW2B3a1tVereXPLqXwRVTWoJAe
         o59w==
X-Gm-Message-State: APjAAAXj7URLpTBVn1v5yneJyp00PoC50LSobCtz9SEUag+3NADPyPTr
        L2mzxlVCsv5usn30SMFzibDi7wgNBq6cNCKhnXmuYJdJqALDt/PZ+y1Pbx6evgf8xSlfzVydQIb
        okE+xi9gTJL9WLy25k0rDgz/Agw==
X-Received: by 2002:a37:51d4:: with SMTP id f203mr18710qkb.212.1576015814423;
        Tue, 10 Dec 2019 14:10:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwpNDBUah/JxrSAKxCjiRELPnHOg3DdeD0npoO5tGbThZQTwIdN5FQktw+smPeDV7cbUZ/0w==
X-Received: by 2002:a37:51d4:: with SMTP id f203mr18680qkb.212.1576015814067;
        Tue, 10 Dec 2019 14:10:14 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id z64sm60335qtc.4.2019.12.10.14.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 14:10:13 -0800 (PST)
Subject: Re: Regression in squashfs mount option handling in v5.4
To:     Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
References: <20191130181548.GA28459@gentoo-tp.home>
 <6af16095-eab0-9e99-6782-374705d545e4@infradead.org>
 <20191210185002.GA20850@gentoo-tp.home>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2286b071-76ac-1659-5dba-6381ecb269c6@redhat.com>
Date:   Tue, 10 Dec 2019 17:10:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210185002.GA20850@gentoo-tp.home>
Content-Language: en-US
X-MC-Unique: q5Gg1-v0OregkMqpmiCPfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 1:50 PM, Jeremi Piotrowski wrote:
> On Sat, Nov 30, 2019 at 10:56:47AM -0800, Randy Dunlap wrote:
>> [adding Cc-s]
>>
>> On 11/30/19 10:15 AM, Jeremi Piotrowski wrote:
>>> Hi,
>>>
>>> I'm working on an embedded project which uses 'rauc' as an updater. rauc mounts
>>> a squashfs image using
>>>
>>>    mount -t squashfs -o ro,loop,sizelimit=xxx squashfs.img /mnt
>>>
>>> On my system mount is busybox, and busybox does not know the sizelimit
>>> parameter, so it simply passes it on to the mount syscall. The syscall
>>> arguments end up being:
>>>
>>>    mount("/dev/loop0", "dir", "squashfs", MS_RDONLY|MS_SILENT, "sizelimit=xxx")
>>>
>>> Until kernel 5.4 this worked, since 5.4 this returns EINVAL and dmesg contains
>>> the line "squashfs: Unknown parameter 'sizelimit'". I believe this has to do
>>> with the conversion of squashfs to the new mount api.
>>>
>>> This is an unfortunate regression, and it does not seem like this can be simply
>>> reverted. What is the suggested course of action?
>>>
>>> Please cc me on replies, I'm not subscribed to the list.
>>>
>>> Thanks,
>>> Jeremi
>>>
>>
>>
>> -- 
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Ping. This is preventing me from updating the kernel on my systems.
> 

Fedora is hitting a similar issue https://bugzilla.redhat.com/show_bug.cgi?id=1781863

Dec 10 10:04:06 kernel: squashfs: version 4.0 (2009/01/31) Phillip Lougher
Dec 10 10:04:06 kernel: squashfs: Unknown parameter 'errors'

I don't think squashfs ever actually supported the errors parameter
but it was just silently ignored. It turns out you could can pass
whatever nonsense you want for parameters so I don't think we can
reject parameters in the generic case

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..7ec20b1f8a53 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
  		return 0;
  	}
  
-	return invalf(fc, "%s: Unknown parameter '%s'",
-		      fc->fs_type->name, param->key);
+	return 0;
  }
  EXPORT_SYMBOL(vfs_parse_fs_param);

