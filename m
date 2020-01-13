Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9693139C3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAMWO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:14:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45385 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:14:28 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so11572984ioi.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3jxPdxctH3gjmgvKoEg2bKxuIvelTYH6Q+ZM3PsZ3k=;
        b=lj5RRJoZfPwRy6oZz2O93HCBq3PxUrgOq6BdkLKPlC83YJaPi7sNZPOei8azx+dYMR
         eJ0rR0FEUFNHgOhXb+D+t+xRaO65jLtbdhVWfVlgVbU/YEOk5w+WN7KA7Y83bSa8abi7
         mQNzORXhimT/iPlS+FaPTGPC5fPTZWPf/sg7WEmUPaxQVz0CVtsLE5ujdqRr+13P+Zi4
         6HfPQ2IIzk/xk9TyMY0A+Yut5DnTwoSuIVehLU1PsJUTjU1kMVUiVkzoFGhTaXxBPsxX
         st4ebl0LzXeHQtmcU7W4sc4MHORyz5QSpquoVg1Lb+JYizQOglbJg8AaJqWlF1f7LDAd
         VAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3jxPdxctH3gjmgvKoEg2bKxuIvelTYH6Q+ZM3PsZ3k=;
        b=MVlDwNdsUDO05BHZVw1Yup/DzkryAVxiqSx76OqCAhrY/zzh7MC2ILtAQoG6+AAuYb
         IywYmISAziukAxgl3s9VsDktZzqIVmGEJdnH8jQlwExEPx1C3RxVPiYmKdJq6t9R/D9p
         IfIDSFc4ZaRIYYHMK/W/8Acd154eBx3LU/obREpXgyp1p9aeg6fm6bN6WNRdy9Ui/LFz
         ngFkfPz3LItSquF470uNPpk4DLww6S64iE087TRxPx/FIDCAWNPvG1zawU5UXTUD/Z8T
         5N+srj9PReFzOu20dk+AWgBz+5R+kCPMuRVrxakP1+kJgsGkry/AUdrXSdXEME4Z5/Bu
         Gt7w==
X-Gm-Message-State: APjAAAVu4PsfW8DRXzobUg+gcwBAzPfkFSTuXeAKZ7rJO3mOINOp06Tw
        0tWIDFincl+IXZen3gljuh6XvL1onnQ=
X-Google-Smtp-Source: APXvYqzz0dLuKLzCRxGBrNM8rm9zXK7exeR0GvUTkfEWTSObLmu665gejwa+6LM/WYT9vqgzIJ6Yqg==
X-Received: by 2002:a6b:1443:: with SMTP id 64mr13769256iou.116.1578953667850;
        Mon, 13 Jan 2020 14:14:27 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p69sm4245770ilb.48.2020.01.13.14.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 14:14:27 -0800 (PST)
Subject: Re: [RFC 0/8] Replacing the readpages a_op
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
Date:   Mon, 13 Jan 2020 15:14:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113221047.GB18216@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/20 3:10 PM, Matthew Wilcox wrote:
> On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
>> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
>>> On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
>>>> This is true, I didn't explain that part well ;)  Depending on 
>>>> compression etc we might end up poking the xarray inside the actual IO 
>>>> functions, but the main difference is that btrfs is building a single 
>>>> bio.  You're moving the plug so you'll merge into single bio, but I'd 
>>>> rather build 2MB bios than merge them.
>>>
>>> Why don't we store a bio pointer inside the plug?  You're opencoding that,
>>> iomap is opencoding that, and I bet there's a dozen other places where
>>> we pass a bio around.  Then blk_finish_plug can submit the bio.
>>
>> Plugs aren't necessarily a bio, they can be callbacks too.
> 
> I'm thinking something as simple as this:
> 
> @@ -1711,6 +1711,7 @@ void blk_start_plug(struct blk_plug *plug)
>  
>         INIT_LIST_HEAD(&plug->mq_list);
>         INIT_LIST_HEAD(&plug->cb_list);
> +       plug->bio = NULL;
>         plug->rq_count = 0;
>         plug->multiple_queues = false;
>  
> @@ -1786,6 +1787,8 @@ void blk_finish_plug(struct blk_plug *plug)
>  {
>         if (plug != current->plug)
>                 return;
> +       if (plug->bio)
> +               submit_bio(plug->bio);
>         blk_flush_plug_list(plug, false);
>  
>         current->plug = NULL;
> @@ -1160,6 +1160,7 @@ extern void blk_set_queue_dying(struct request_queue *);
>  struct blk_plug {
>         struct list_head mq_list; /* blk-mq requests */
>         struct list_head cb_list; /* md requires an unplug callback */
> +       struct bio *bio;
>         unsigned short rq_count;
>         bool multiple_queues;
>  };
> 
> with accessors to 'get_current_bio()' and 'set_current_bio()'.

It's a little odd imho, the plugging generally collect requests. Sounds
what you're looking for is some plug owner private data, which just
happens to be a bio in this case?

Is this over repeated calls to some IO generating helper? Would it be
more efficient if that helper could generate the full bio in one go,
instead of piecemeal?

-- 
Jens Axboe

