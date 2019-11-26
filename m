Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDCD10A6F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 00:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfKZXNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 18:13:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKZXNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:13:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id b10so9784181pgd.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 15:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xSdUXjteBaphnHhRVYPIlnexJspIHTPfIj7oTmOOWqw=;
        b=ykizGoPowPRvzlrjQj+ToVpf+pjLi7FwSGkw5E+soY/g/azPWXFYfuqR0kJiysIeyg
         aJpTkvd2bF6O743iR2cOQQwYnAuczqhVJx/2FazepSYURNSfGC31qu0XRnlW050VuPdO
         1C5g2JstnKnP3eHJHNI3qfY/5wQV/gqj9+GiN/uC0lU5AYNcheWvWQ9VnQZMs933NXRj
         U8gMr85pLeYWLzaqtKk08Rp5c8+WVIQNziQreEPSROTGq9Ji2kiXxp+1+7PzNs/0H8XL
         04cQEkjtEuK/p8EsZh1hYh1yaIh7odJwI4ENbg9KCoKMuQsfPT5JSPzZvQuF1ZIsc0L1
         9sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSdUXjteBaphnHhRVYPIlnexJspIHTPfIj7oTmOOWqw=;
        b=ZNDJMp3hNJaSwyfIHd49KfdEhT6jR1Xe0jug7PBMw8tNjWuZi5l8UoJ9FYm99UcWgf
         n7V+3M203mp8A+QbAhPiDe2h+O8cqnqwI7PWwmY0oud1d6o2MZ4Xj98jIoPVwgHASpZQ
         k/aa0EvjmHvlsMOHGK8QJDw4PuPur8ekzzVm1TAb18AtHW8NLuOg4trcmeLkhxJQeFF7
         IllQseCtlD3VUajtM291EQc5Aeel3fM401t0Ax0kdnJv8O/nCitWTi5i9hBTX5rqVwCG
         IdNmjLPHlljx2/UbjAdFCjaMV1EI5L6wwxroTgkk/LH3t/XmUHxCPfl+t6/2pno2PZgc
         5sdA==
X-Gm-Message-State: APjAAAUxadU+YcvZbBvJEutZRSOjyqGCIzv07PQriS6lHQY8vTyRadlx
        Qxw26sEG/0gmPxFpIY2EItt/0A==
X-Google-Smtp-Source: APXvYqwTWZaVXuwFAks7r0KChnenItR97uS8QY0CqtfzkX1MG5v1WKjms2vTNvIhhMq9UxM1j8rZcA==
X-Received: by 2002:a62:528d:: with SMTP id g135mr44527972pfb.172.1574810016976;
        Tue, 26 Nov 2019 15:13:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id o14sm14606693pfp.5.2019.11.26.15.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 15:13:35 -0800 (PST)
Subject: Re: [PATCH v4 rebase 00/10] Fix cdrom autoclose
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
References: <cover.1574797504.git.msuchanek@suse.de>
 <c6fe572c-530e-93eb-d62a-cb2f89c7b4ec@kernel.dk>
 <20191126202151.GY11661@kitsune.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08bcfd0a-7433-2fa4-9ca2-ea008836b747@kernel.dk>
Date:   Tue, 26 Nov 2019 16:13:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126202151.GY11661@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/19 1:21 PM, Michal Suchánek wrote:
> On Tue, Nov 26, 2019 at 01:01:42PM -0700, Jens Axboe wrote:
>> On 11/26/19 12:54 PM, Michal Suchanek wrote:
>>> Hello,
>>>
>>> there is cdrom autoclose feature that is supposed to close the tray,
>>> wait for the disc to become ready, and then open the device.
>>>
>>> This used to work in ancient times. Then in old times there was a hack
>>> in util-linux which worked around the breakage which probably resulted
>>> from switching to scsi emulation.
>>>
>>> Currently util-linux maintainer refuses to merge another hack on the
>>> basis that kernel still has the feature so it should be fixed there.
>>> The code needs not be replicated in every userspace utility like mount
>>> or dd which has no business knowing which devices are CD-roms and where
>>> the autoclose setting is in the kernel.
>>>
>>> This is rebase on top of current master.
>>>
>>> Also it seems that most people think that this is fix for WMware because
>>> there is one patch dealing with WMware.
>>
>> I think the main complaint with this is that it's kind of a stretch to
>> add core functionality for a device type that's barely being
>> manufactured anymore and is mostly used in a virtualized fashion. I
>> think it you could fix this without 10 patches of churn and without
>> adding a new ->open() addition to fops, then people would be a lot more
>> receptive to the idea of improving cdrom auto-close.
> 
> I see no way to do that cleanly.
> 
> There are two open modes for cdrom devices - blocking and
> non-blocking.
> 
> In blocking mode open() should analyze the medium so that it's ready
> when it returns. In non-blocking mode it should return immediately so
> long as you can talk to the device.
> 
> When waiting in open() with locks held the processes trying to open
> the device are locked out regradless of the mode they use.
> 
> The only way to solve this is to pretend that the device is open and
> do the wait afterwards with the device unlocked.

How is this any different from an open on a file that needs to bring in
meta data on a busy rotating device, which can also take seconds?

-- 
Jens Axboe

