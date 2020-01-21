Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E922143922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 10:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgAUJJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 04:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbgAUJJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579597762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcizW7prnwG3DUhwFU76Cl1Qf4//rkB+ABdaxXIm62c=;
        b=QmphhUNJiloZeQ5C3b+MTamY1STQuX3UFuW7fr1GP6syVSqC4WVNVKU2TGDO7Zqw0IfTSQ
        NY5xrjNlrcbNQkgjrzOHe7c520hzUFS5e4MMj0Ii4DBSguzyuRFfEfS3tZ941L7ljBk09l
        6ttkKx2SnA9/XYkEVNQtr0/KttWgMR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-DQRgzL-ANoKUyfMoPXUJIQ-1; Tue, 21 Jan 2020 04:09:20 -0500
X-MC-Unique: DQRgzL-ANoKUyfMoPXUJIQ-1
Received: by mail-wm1-f69.google.com with SMTP id c4so360560wmb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 01:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcizW7prnwG3DUhwFU76Cl1Qf4//rkB+ABdaxXIm62c=;
        b=dlLGJtf46FfJGoazBxFriywq2jQ6Os7nD96se8ErVhO7v+4dDvfFALyhISXBevUrVD
         uleUea7PeHYz2G3Cxxtg0rMP9CWnaVMTTs/lIju5W8n+hq1gsEtmP0D2xu8xb0YjEVHA
         T1bir4TYqZzodlmRonVZ6oV3RK7oPnpUHHebU6XaELB/g0pJTVv93pf26yR9ryuE4I6l
         5u0N7vBqyG7ptluqpuKi/ZNGyEcBAoc02w2rPF3nZ4NzTI1X61Tm8kAg5CNH1QkVqKJy
         n7SS23taQ6jehej3SGS5Q9MRhBSI3YMTFqGqhRAMBcInoBOJFlBAf97AHZIFwmLlZrIR
         uEqg==
X-Gm-Message-State: APjAAAX79k8DByM0Etg8CTNXR7I9lhLXg17HQYOYFcuyvWM3ITr1LlFk
        Y+TUMKL20wBECuIutmsZhsXIcPatZ2M9/+OrD/awwoWXCoctSkTThwyBhCNJgncAeKQzvle72l4
        5JPDg4sbImLMsCXH134zKAJWBxw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4188621wrq.64.1579597759486;
        Tue, 21 Jan 2020 01:09:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfSpYEa6lTef5AK+vWXp5bjHIFh/3sGBy4l1JE9N8S4A0ChbvCwt07BwHz/d6lbQO5yrGZvA==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4188596wrq.64.1579597759268;
        Tue, 21 Jan 2020 01:09:19 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id k13sm51089606wrx.59.2020.01.21.01.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 01:09:18 -0800 (PST)
Subject: Re: [PATCH v19 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20191212140914.21908-1-hdegoede@redhat.com>
 <ae314c55-905a-fce0-21aa-81c13279c004@redhat.com>
 <20200121010837.GH8904@ZenIV.linux.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b38f3609-c3cd-7bee-d8b5-799ca4954520@redhat.com>
Date:   Tue, 21 Jan 2020 10:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121010837.GH8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 21-01-2020 02:08, Al Viro wrote:
> On Sat, Jan 11, 2020 at 12:46:30PM +0100, Hans de Goede wrote:
>> Hi All,
>>
>> On 12-12-2019 15:09, Hans de Goede wrote:
>>> Hello Everyone,
>>>
>>> Here is the 19th version of my cleaned-up / refactored version of the
>>> VirtualBox shared-folder VFS driver.
>>>
>>> This version addresses all remarks from Al Viro's review of v18.
>>>
>>> I believe that this is ready for upstream merging now, if this needs
>>> more work please let me know.
>>>
>>> Changes in v19:
>>> - Misc. small code tweaks suggested by Al Viro (no functional changes)
>>> - Do not increment dir_context->pos when dir_emit has returned false.
>>> - Add a WARN_ON check for trying to access beyond the end of a
>>>     vboxsf directory buffer, this uses WARN_ON as this means the host has
>>>     given us corrupt data
>>> - Catch the user passing the "nls" opt more then once
>>
>> Ping? Can I please either get some feedback on this patch, or can we get
>> this merged / queued up for 5.6 please ?
> 
> Merged and pushed into #for-next

Great, thank you.

Regards,

Hans

