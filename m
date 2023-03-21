Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09A6C3A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCUTdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCUTdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:33:16 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4B56538
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 12:32:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y85so1424366iof.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679427138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CeJzgGGkpz4OJNP+n2r4VhZEuuVOgz0h28luVhwWvM=;
        b=onBLdjuFW4OF9Ht5Rs2OEMX4aFQHB3mb67rib8Ag91iE4T2V0mEOeVtnbO60FtKxJi
         L1ZVDAdXzIBGc8uzGY9zUbtJqMNQ/JEzGufLkjl4q2W4gCNgOaaDnO/8rDzVvhIyKBt8
         zfAWpBfk9kKdRInXFn5Ve4KJNMfcDDXrl+//pEDel/TULKnCiMCBbg4jQY6Sg4G9Z2JT
         ctXDOrQLsenp00LY2dxVE1Z7BeOlwMY7psuC5OpAf1FTAsRMlhzt3MGbKFWtgA/OolIb
         ajafD0Eh3TgzjUbHPvPmc2uSjgk8UiukZdu23QCWLJP9yhMVywGUtmMI/zSwHNtcm6zu
         gDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CeJzgGGkpz4OJNP+n2r4VhZEuuVOgz0h28luVhwWvM=;
        b=cSxmcpyQkd1ZKIjvA3eguKBQCBEDVdQmM4sqOOjAGRdT+sGYO5q3Lndl4pgfye0ir+
         ydin//zYcJMLbVGD+GH4507sgfVIt3gUiBU8/kAxN6a8qlFGF3uVKbvpIg9eCGcWT8lN
         WSPwAig6kCBU5pmezh/QPjgaGMP4nr//Xn4yF3tYH6PgBpun1cbET7f5vtFuvicubAit
         sm28V8I0O1/E4XGXi4NoirKXpoPkueq7HWLqg0rTFvXgDIDR/T0PwS0f66MG9yWg/rcn
         uZ0huhKUKjlMCAzIXgqVIQV1yGZ/wNxlQHHFuOX9XvZDvzCpWEUIwvQGYGyUfnZzoI+m
         W9xQ==
X-Gm-Message-State: AO0yUKV+KAVn2KOj6jeknH8+SC6wOfWaMG90z6a58yD3Rhj8z/jigrHF
        XQvQTD+IAaJty1q9RfbwE62Ekg==
X-Google-Smtp-Source: AK7set+phMYJWl6sgVT+AVfG9ZZk7GsfTnjNYpV3+LVic3XR8FeoqngvOFzznh2XdWllptC2fYtjOQ==
X-Received: by 2002:a6b:5802:0:b0:758:5653:353a with SMTP id m2-20020a6b5802000000b007585653353amr1487525iob.0.1679427137979;
        Tue, 21 Mar 2023 12:32:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j189-20020a0263c6000000b0039deb26853csm4495686jac.10.2023.03.21.12.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:32:17 -0700 (PDT)
Message-ID: <3fcad89a-77ad-3369-cd8c-88a223758173@kernel.dk>
Date:   Tue, 21 Mar 2023 13:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851036.1679417029@warthog.procyon.org.uk>
 <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
 <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
 <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/23 1:21?PM, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 12:16?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I haven't seen the patch yet as it hasn't been pushed,
> 
> Well, it went out a couple of minutes before your email, so it's out now.

Yep I see it now, looks as expected.

>> It may make sense to add some debug check for
>> PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
>> matter, as that is generally not workable without doing something to
>> handle it explicitly.
> 
> Yeah, I guess we could have some generic check for that. I'm not sure
> where it would be. Scheduler?

Off the top of my head, two options, both in kernel/sched/core.c:

1) Add it to schedule_debug()

2) Add it to sched_submit_work(), adding PF_KTHREAD to the flags checked
   for PF_IO_WORKER | PF_WQ_WORKER to avoid adding any extra fast-path
   overhead.

Alternatively, I guess it could go in kthread_exit() as well. But for
workloads with a persistent kthread that doesn't really go away, that
won't catch it.

-- 
Jens Axboe

