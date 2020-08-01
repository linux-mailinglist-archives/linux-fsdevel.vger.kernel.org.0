Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966823519B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgHAKO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAKOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:14:23 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17909C06174A;
        Sat,  1 Aug 2020 03:14:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so20022962ejc.9;
        Sat, 01 Aug 2020 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Acn0jSIh9NBRILU7W8oPVuEq6OOoEX0D3oLMOLxMsqA=;
        b=lDzeCWP8xKVae2lw65X9s16ZXugWowHQBAcMWj7TiCGG12D1HquXzQ9NphUg7tABEY
         l6q56394LBhSQ50+5p3396cdylq7ERbN08FXcMTfHRHWgCUHwhfEvsIn+lPT7/XwVIZR
         JyvrnrhvCIWjTHr/ex277wdHjsmnTsAoTNEz5EUJSa2MOacX8KDTTYp0PEy0dRSH9q/6
         wsk8DjN3pWsDCbpG+HV/jTayRb7rvXm/4knFhe6tOMIh2Fl5MtaD28U+Bf9UT+GPgA8P
         o+tPFcB20L389sfxsoznZe8LBEGfbyVoA5efplLNpxPWYEKyxNoE4Ut6ThzElZyxKPdy
         /ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Acn0jSIh9NBRILU7W8oPVuEq6OOoEX0D3oLMOLxMsqA=;
        b=o40PeAO+QVB+VD1aeMftr9zQ+kx9jMttWAt5jkUywJJ3LRFPam7rMI0xOIcKDO/gYD
         j93tF3OGP9CRk5Ghe3bkOTh5rcMqhxFKwzpP5lgmMfh7JrjO/bP6OWezutZObYLsudP6
         8cHTHm4X9XnVAPJiK6jIItNKw5tPM1Kf5ntIbYOCm7+J7mnVLr9ghcsG7d/SJMSJAkcI
         HBPYfoSC+0cqVWhVrNIDz2vJ9fls2/tvv9lwQF6Et1cx/dgIFJXo/tFRC8GvwGmTFIpz
         xZWxW586C9ARVgjH0yCj142OVXj30GvId0mh4UCQXSRK3EKH37EjRZ81INY0ArsWhmw1
         2TTA==
X-Gm-Message-State: AOAM532Vj2QMCNmII4D4aoxtiJzN9K6sI3d/IPw+/CZpkFWXyHuWNDP/
        VTIfjDnVlDGvc8yYj0PSn79ssKMK
X-Google-Smtp-Source: ABdhPJzNLu0YP9rY7XFeRZXEl2ID2rpI1R2jmhYLfUyJdG3u8u0ixOFTwv+BHcjzUP5KuMwMd3Uelw==
X-Received: by 2002:a17:906:7a16:: with SMTP id d22mr8205695ejo.478.1596276860281;
        Sat, 01 Aug 2020 03:14:20 -0700 (PDT)
Received: from [192.168.43.105] ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id b18sm11000606ejc.41.2020.08.01.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 03:14:19 -0700 (PDT)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
 <20200130165425.GA8872@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] splice: direct call for default_file_splice*()
Message-ID: <0618f315-7061-c3fd-15d3-c19cea48cc4c@gmail.com>
Date:   Sat, 1 Aug 2020 13:12:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130165425.GA8872@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/01/2020 19:54, Christoph Hellwig wrote:
> On Mon, Jan 20, 2020 at 11:49:46PM +0300, Pavel Begunkov wrote:
>> Indirect calls could be very expensive nowadays, so try to use direct calls
>> whenever possible.

Hah, I'm surprised to find it as
00c285d0d0fe4 ("fs: simplify do_splice_from").

Christoph, even though this one is not a big deal, I'm finding the
practice of taking others patches and silently sending them as yours
own in general disgusting. Just for you to know.


> 
> ... and independent of that your new version is much shorter and easier
> to read.  But it could be improved a tiny little bit further:
> 
>>  	if (out->f_op->splice_write)
>> -		splice_write = out->f_op->splice_write;
>> +		return out->f_op->splice_write(pipe, out, ppos, len, flags);
>>  	else
>> -		splice_write = default_file_splice_write;
>> -
>> -	return splice_write(pipe, out, ppos, len, flags);
>> +		return default_file_splice_write(pipe, out, ppos, len, flags);
> 
> No need for the else after an return.
> 
>>  	if (in->f_op->splice_read)
>> -		splice_read = in->f_op->splice_read;
>> +		return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>  	else
>> -		splice_read = default_file_splice_read;
>> -
>> -	return splice_read(in, ppos, pipe, len, flags);
>> +		return default_file_splice_read(in, ppos, pipe, len, flags);
> 
> Same here.
> 

-- 
Pavel Begunkov
