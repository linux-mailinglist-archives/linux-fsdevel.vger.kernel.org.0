Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBAE361B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502969AbfJXPBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:01:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502933AbfJXPBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:01:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so2198417wmf.0;
        Thu, 24 Oct 2019 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9OIRMBAMD/IGNv6LdXwINxw42BZ8L0+aAzrRbp7Nb0M=;
        b=UoVP/lMjO0q8d6tSI+3LsoD8CBnAJKfLt1vflnsZg9pKFQ2eZP7gLYZ0TidaP1se+K
         ImsXu2+3HTONlVnw+CjIETwWA1CHriCAPO3tJnlSAwQyf0YDY5NVOzvySJe4WVJGj0Ex
         8gQNGpiyN67S77owCm0Nsm7pw5a7v3jW/H0JJM5vHystoNhf1oWYGQkTDSSfNkIFxrR9
         7DNEy0tmPaD65x7UGA7EfwlQxY5aedul3xqRU1BGuT+tqgFszH56jSFeOske7cmiB+z3
         oBWjulsnB06Zny3vXiwyZSEgkETuGB5V2KVzbWL+uYdYLAYWmpI2a7SZf1S281v90v96
         Ytpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9OIRMBAMD/IGNv6LdXwINxw42BZ8L0+aAzrRbp7Nb0M=;
        b=ofRFE6FMiAhhbNCtI+lUs/e68VCBi/Lbt0g7cP62osO6M91kLJHLYbDyfVMQ8RTzuS
         +OMI+BeJiwvMjNjV703KlRqmLVnyKS6d8Fuue0ynqPlf0OKMuJkTXAnUj7JeGD7l46/m
         suGcB3qg+VQQ5FXATd6dL2VuqZUvf1JuqwscMR7xF/9PBI0LJEbgOrV4eCtGIV2wgKzm
         caY1Z0CIn7mlE8/gQA8ipGDNtgYEPs+ZfnACQFxyOpkptO5ndC4KbzP3Yx3TldCAoVFh
         ZXkRY+fJ1YMB5UHTugSGLCZy9V2vL4HxdGIZRoybnqNuBwHnPR2VlNzf2jm6HVsAlYdS
         nZ6A==
X-Gm-Message-State: APjAAAUUv1/5el+IHALjIDBj4GMZu5Mu9t7HMD9uAEQdynD5lZxA4n7S
        ZcwVEfCh4UymU3VLoVpYggw=
X-Google-Smtp-Source: APXvYqw1zRG4DrgTfQvcuF6g42B7nb/pJgiuLBfEHO25QU3txybg2ydt3lrhCnQsyP1SSS0KPCiLzQ==
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr5545214wml.86.1571929268442;
        Thu, 24 Oct 2019 08:01:08 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id l18sm35809016wrn.48.2019.10.24.08.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 08:01:07 -0700 (PDT)
Subject: Re: File system for scratch space (in HPC cluster)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
 <20191024145504.GD1124@mit.edu>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <70755c40-b800-8ba0-a0df-4206f6b8c8d4@gmail.com>
Date:   Thu, 24 Oct 2019 18:01:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191024145504.GD1124@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/10/2019 17:55, Theodore Y. Ts'o wrote:
> On Thu, Oct 24, 2019 at 12:43:40PM +0200, Paul Menzel wrote:
>>
>> In our cluster, we offer scratch space for temporary files. As
>> these files are temporary, we do not need any safety
>> requirements – especially not those when the system crashes or
>> shuts down. So no `sync` is for example needed.
>>
>> Are there file systems catering to this need? I couldn’t find
>> any? Maybe I missed some options for existing file systems.
> 
> You could use ext4 in nojournal mode.  If you want to make sure that
> fsync() doesn't force a cache flush, you can mount with the nobarrier
> mount option.
> 

And open the file with O_TMPFILE|O_EXCL so there is no metadata as well.

I think xfs for O_TMPFILE|O_EXCL does not do any fsync, but I'm
not sure

> 					- Ted
> 

