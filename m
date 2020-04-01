Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9175F19AF4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgDAQFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 12:05:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44722 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgDAQFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:05:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so659593wrw.11;
        Wed, 01 Apr 2020 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=x0iGf5X4LVYTv3/i+3RQO+ppyXBQZXoUL8LL0fm5I0w=;
        b=EXpjA8rTQUsKE+qdZqP/OdGd6eCxiipdusbCGRdMgrzSFDoTFfrG8GcWy5dSL+FGAu
         ZmAiMwADAOV9LvQ0JMLfaxNcfPTrWpQPuPaPxkK5bZQwQt4WNNGxNy2baRVZYXVIP5rT
         6UR1mJoZ5uwMwQR09xEaxeei29Umc1sb9HHkqSPRgThc+AkTmVWz8YPHKtYWLcItT0IF
         rv4j9Om54xQbV/ZQtczS930PXJ/ze/EcF3UEvLj0otsGO+DW7cena5EZ7doG/84pnfO+
         CO4Dlu39M6co2U7plhwPYNFD+2FDjGLuLuk7vU057+iIupH64dmPnABgUU6YlwoYav9W
         x7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=x0iGf5X4LVYTv3/i+3RQO+ppyXBQZXoUL8LL0fm5I0w=;
        b=E2ezo9q0H6eKqlm34YpZYkwP88sl6PEfMO0c1MDcgSvVlcldNCMdpuBnL+s7w26HeA
         UxGNvQ0qXX68JjEKzaQaSUP8VkNlW2WNUKxz70Su6OfSw3D2E2QfZqs5gqNngNGFmkgl
         OOC5kz6SZnhXjyac9RxhQf2/Obtp/b+ClVMoamJHAQaSe7CjPcYvXomzimI7AiCE+bM3
         ZZbFx+wcjzVmbjb+KSgfcQzjS79LrLIPw+j342ZtvjrmtqHT/5KoQNB134fRnJB7epYv
         Zhtnohvrv9YxQckEJw+OrJyPFoC6tpuevOCm/XvKnL7CBc82q+48pKgNVyWb2xRgC11e
         OSjA==
X-Gm-Message-State: ANhLgQ0DfYFa5NRUQsHf2vRZTs9zFQbab2IZB+GLvU7luYpynSYA3Z7p
        1o27bHZNXvo7fuG/17JHGg==
X-Google-Smtp-Source: ADFU+vsGgsO5O4k/Oz4y3nId5ruptaNQ0NK34qLOhjZcXf6pDS0gcYHgxF/Tk6yhVtQY7TgTs81tYg==
X-Received: by 2002:a5d:460f:: with SMTP id t15mr26748856wrq.413.1585757108643;
        Wed, 01 Apr 2020 09:05:08 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id i21sm3321949wmb.23.2020.04.01.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:05:08 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <djed@earth.lan>
Date:   Wed, 1 Apr 2020 17:04:54 +0100 (BST)
To:     Jan Kara <jack@suse.cz>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:FILESYSTEM DIRECT ACCESS (DAX)" 
        <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 3/7] dax: Add missing annotation for
 wait_entry_unlocked()
In-Reply-To: <20200401100125.GB19466@quack2.suse.cz>
Message-ID: <alpine.LFD.2.21.2004011702002.25676@earth.lan>
References: <0/7> <20200331204643.11262-1-jbi.octave@gmail.com> <20200331204643.11262-4-jbi.octave@gmail.com> <20200401100125.GB19466@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 1 Apr 2020, Jan Kara wrote:

> On Tue 31-03-20 21:46:39, Jules Irenge wrote:
>> Sparse reports a warning at wait_entry_unlocked()
>>
>> warning: context imbalance in wait_entry_unlocked()
>> 	- unexpected unlock
>>
>> The root cause is the missing annotation at wait_entry_unlocked()
>> Add the missing __releases(xa) annotation.
>>
>> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>> ---
>>  fs/dax.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 1f1f0201cad1..adcd2a57fbad 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>>   * After we call xas_unlock_irq(), we cannot touch xas->xa.
>>   */
>>  static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>> +	__releases(xa)
>
> Thanks for the patch but is this a proper sparse annotation? I'd rather
> expect something like __releases(xas->xa->xa_lock) here...
>
> 								Honza
>
>>  {
>>  	struct wait_exceptional_entry_queue ewait;
>>  	wait_queue_head_t *wq;
>> --
>> 2.24.1
>>
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
Thanks for the kind reply. I learned and changed. If there is a further 
issue, please do not hesitate to contact me.
Thanks,
Jules
