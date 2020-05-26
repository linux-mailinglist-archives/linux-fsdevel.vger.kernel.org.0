Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C041C3B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEDNnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgEDNnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:43:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A9C061A10
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 06:43:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so3879812pjw.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QAn+2RM7soSoqdOBHN+11VsA1mCP/YaXzCZebzqANzo=;
        b=TE0iYyWaTh8bQ7IhHQUx/YbRFRnMkI4YDJatk7J/aBL01J5cQhnQxteoR6dI47x2WM
         9w6GKjsw2MxaEcoWrmr/sfBb3M1hW9o+V38nO1wdEs99XhLm+b2sfzz39ExcH7Z7lrZ8
         3hh+1EqtCInJBgFUsAjijAZjvXJGKLf9i3PXhKlPubiiU6+tfcNv7UkM+PY/8BPiU/+d
         0CoCZeT/EiobAGwHu4cy1D0QsKI5zVK1WHzdEKSvmisLf2zRy7QYw/rrIHiUOHZ8dhxs
         uJZKIS6sSR+EKs2QnO8trbgF6u3PH7lG36bjbej6xNQnma4QOJvC2lWBsb9KM2jn0a0+
         JAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAn+2RM7soSoqdOBHN+11VsA1mCP/YaXzCZebzqANzo=;
        b=ULlnFQ0c96SvRrNlEFGw6P4PDo1wkHo+oEgVuweRPXKvzLKGvL4Nwu30e5XYeYV0vT
         q+s48EV+DrlUkPbjZv1d5Kb6sBt7JFc5MbBpjzajyrc7UFrMZ1Qxkl2iqBKa9SQODr1K
         JjKvCMUoXuM4MhhfM0a8xMkebkLDptxR0Rwe9DxBVtEXHdfaUtOgT+QKglLd1fDVeVpW
         YtPyAAi3KtljLWW8Esc0MjcdHgr4kmiKSBzE+qjmUafQYfJcpnq/2H0IF4ZvL/IBSDg5
         tIBEMsnJQZxMWYXkayo8AXB5/Z9Uajd76cfhiJOo4ieNVu/F7b9F5jGFdlKMydAFF7OV
         B9Ug==
X-Gm-Message-State: AGi0PuZd5BwvcDlCOA1PLEjtjgwf3cX95g0YJJFMKxuLnTTXOESsi4J5
        qBSlafJDWgSY+I7Pr7krSm5+TO+Q8HaHeA==
X-Google-Smtp-Source: APiQypKVxfCwaRhwua444a4sKxbwU/GHLXZIu8GXcoaQjL6NbjBrUVGGq7g2rF/uM+Rfwd9g0kYMdA==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr18232346plp.277.1588599791407;
        Mon, 04 May 2020 06:43:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a23sm8908180pfo.145.2020.05.04.06.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:43:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] splice: export do_tee()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Clay Harris <bugs@claycon.org>
References: <cover.1588421219.git.asml.silence@gmail.com>
 <56e9c3c84e5dbf0be8272b520a7f26b039724175.1588421219.git.asml.silence@gmail.com>
 <CAG48ez0h6950sPrwfirF2rJ7S0GZhHcBM=+Pm+T2ky=-iFyOKg@mail.gmail.com>
 <387c1e30-cdb0-532b-032e-6b334b9a69fa@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b62d84b0-c5a8-402f-d62e-e0b8d41221bb@kernel.dk>
Date:   Mon, 4 May 2020 07:43:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <387c1e30-cdb0-532b-032e-6b334b9a69fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/4/20 6:31 AM, Pavel Begunkov wrote:
> On 04/05/2020 14:09, Jann Horn wrote:
>> On Sat, May 2, 2020 at 2:10 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>> export do_tee() for use in io_uring
>> [...]
>>> diff --git a/fs/splice.c b/fs/splice.c
>> [...]
>>>   * The 'flags' used are the SPLICE_F_* variants, currently the only
>>>   * applicable one is SPLICE_F_NONBLOCK.
>>>   */
>>> -static long do_tee(struct file *in, struct file *out, size_t len,
>>> -                  unsigned int flags)
>>> +long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
>>>  {
>>>         struct pipe_inode_info *ipipe = get_pipe_info(in);
>>>         struct pipe_inode_info *opipe = get_pipe_info(out);
>>
>> AFAICS do_tee() in its current form is not something you should be
>> making available to anything else, because the file mode checks are
>> performed in sys_tee() instead of in do_tee(). (And I don't see any
>> check for file modes in your uring patch, but maybe I missed it?) If
>> you want to make do_tee() available elsewhere, please refactor the
>> file mode checks over into do_tee().
> 
> Overlooked it indeed. Glad you found it

Yeah indeed, that's a glaring oversight on my part too. Will you send
a patch for 5.7-rc as well for splice?

-- 
Jens Axboe

