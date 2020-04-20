Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16FF1B1820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDTVOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTVOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:14:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47531C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 14:14:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so1209303wmc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NAulTysQBFtR68qPZ0m2iZ5pjwCCHBTIxhmw9tr1qow=;
        b=WfHr0abJY9WK4R3n5w9I1fbRXt/wV0VVmqV56e5Jicswk7IFi2190o7+55tI8cK4Xa
         FzwclF1tAnBdb3ZX5vJaqwZmDgZaQHQCzG8kOXFk2AJwS1rsWGCvY33LXoLS8qnky+rq
         L2HMNG+FVjYN9JIqlmgmJ/xboSTJDiWHceOCsAqRJpjvaNosV+V2DQ0SNktCx6g6j9u0
         NrPclX2mr0JuXtWokAGrfShjktb1oc6qozoA5BT5ckIOJxAjcVxSyb21VmkJzFgZwmYx
         b+OGcskGDetKCcueHIDhkJSRNycoqqfz/ohPT5oVJgVpj9k9zEEC1/eJk60nVJSfGDfK
         q3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NAulTysQBFtR68qPZ0m2iZ5pjwCCHBTIxhmw9tr1qow=;
        b=jwolqwRozzD9d4hlL/cPM6QRdws3234joSIR3f79IZVQ8DsO4T0JxhJxqafRjNvDF5
         cymGMb3B6jTPfo+yN5Jjb3Ww9Kp0sRzjlk7vaTJZHozW/oXSRHHwWVX9uBG32qSOWVPq
         oPHAkT+DG696N5RUzfP1ATbpDboJpUEUB5Q9vaMoCupKo94dhpE7zodRXPQnKwLRBxxp
         WNuC//iVRfbzNwHhH5wpUSr7a3d6llLwJwyz4ZMFDIDSlG68myY5j8eaH/Fa1vaStVIM
         BHWbaf/9nCDUfQ/HFh7gl02yOofJ7lUKDCtAIJM4fJfc5jhbUuDjpff1sLRuKXR43GgF
         ++9A==
X-Gm-Message-State: AGi0Puae5VvDKwyeCnEDwxaNZJw3xQvPVUVGLIQsaXP/2l2lLZ7g9gQn
        Opkx71yO0ftxgewJvGqSmwBL5DwUHl2e4g==
X-Google-Smtp-Source: APiQypJFX+O4iZvIjwDh/03KC5rd26Ffx497WdEjSPmxcYp6QdtLfMtYLM5sVggkGnb2ys3NItYKbQ==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr1272476wmg.7.1587417277148;
        Mon, 20 Apr 2020 14:14:37 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48ef:dc00:34d4:fc5b:d862:dbd2? ([2001:16b8:48ef:dc00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id a1sm894226wrn.80.2020.04.20.14.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:14:36 -0700 (PDT)
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <20200419232046.GC9765@dread.disaster.area>
 <20200420003025.GZ5820@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e889cb45-486b-118c-d087-90fed5353460@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 23:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420003025.GZ5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.04.20 02:30, Matthew Wilcox wrote:
> On Mon, Apr 20, 2020 at 09:20:46AM +1000, Dave Chinner wrote:
>> On Sat, Apr 18, 2020 at 08:14:43PM -0700, Matthew Wilcox wrote:
>>> On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
>>>> When reading md code, I find md-bitmap.c copies __clear_page_buffers from
>>>> buffer.c, and after more search, seems there are some places in fs could
>>>> use this function directly. So this patchset tries to export the function
>>>> and use it to cleanup code.
>>> OK, I see why you did this, but there are a couple of problems with it.
>>>
>>> One is just a sequencing problem; between exporting __clear_page_buffers()
>>> and removing it from the md code, the md code won't build.
>>>
>>> More seriously, most of this code has nothing to do with buffers.  It
>>> uses page->private for its own purposes.
>>>
>>> What I would do instead is add:
>>>
>>> clear_page_private(struct page *page)
>>> {
>>> 	ClearPagePrivate(page);
>>> 	set_page_private(page, 0);
>>> 	put_page(page);
>>> }
>>>
>>> to include/linux/mm.h, then convert all callers of __clear_page_buffers()
>>> to call that instead.
>> While I think this is the right direction, I don't like the lack of
>> symmetry between set_page_private() and clear_page_private() this
>> creates.  i.e. set_page_private() just assigned page->private, while
>> clear_page_private clears both a page flag and page->private, and it
>> also drops a page reference, too.
>>
>> Anyone expecting to use set/clear_page_private as a matched pair (as
>> the names suggest they are) is in for a horrible surprise...

Dave, thanks for the valuable suggestion!

>> This is a public service message brought to you by the Department
>> of We Really Suck At API Design.
> Oh, blast.  I hadn't noticed that.  And we're horribly inconsistent
> with how we use set_page_private() too -- rb_alloc_aux_page() doesn't
> increment the page's refcount, for example.
>
> So, new (pair of) names:
>
> set_fs_page_private()
> clear_fs_page_private()

Hmm, maybe it is better to keep the original name (set/clear_page_private).
Because,

1. it would be weird for other subsystems (not belong to fs scope) to 
call the
function which is supposed to be used in fs, though we can add a wrapper
for other users out of fs.

2. no function in mm.h is named like *fs*.

> since it really seems like it's only page cache pages which need to
> follow the rules about setting PagePrivate and incrementing the refcount.
> Also, I think I'd like to see them take/return a void *:
>
> void *set_fs_page_private(struct page *page, void *data)
> {
> 	get_page(page);
> 	set_page_private(page, (unsigned long)data);
> 	SetPagePrivate(page);
> 	return data;
> }

Seems  some functions could probably use the above helper, such as
iomap_page_create, iomap_migrate_page, get_page_bootmem and
  f2fs_set_page_private etc.

> void *clear_fs_page_private(struct page *page)
> {
> 	void *data = (void *)page_private(page);
>
> 	if (!PagePrivate(page))
> 		return NULL;
> 	ClearPagePrivate(page);
> 	set_page_private(page, 0);
> 	put_page(page);
> 	return data;
> }
>
> That makes iomap simpler:
>
>   static void
>   iomap_page_release(struct page *page)
>   {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct iomap_page *iop = clear_fs_page_private(page);
>
>   	if (!iop)
>   		return;
>   	WARN_ON_ONCE(atomic_read(&iop->read_count));
>   	WARN_ON_ONCE(atomic_read(&iop->write_count));
> -	ClearPagePrivate(page);
> -	set_page_private(page, 0);
> -	put_page(page);
>   	kfree(iop);
>   }
>

Really appreciate for your input though the thing is a little beyond my
original intention ;-), will try to send a new version after reading more
fs code.

Best Regards,
Guoqing

