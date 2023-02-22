Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8154569ECD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 03:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBVCdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 21:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBVCc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:32:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102128A6D;
        Tue, 21 Feb 2023 18:32:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e5so8269494plg.8;
        Tue, 21 Feb 2023 18:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cDSGjsZLxrrxEWh0LEAOx0oKYxUvAtDpQKo93C1IX8=;
        b=hXtiawoKnL/qVSN+y9Grm7UP6aFZ8wR5vr7shuKHWJmOEp+ymU9ZL0Oprc4lGfPgo0
         DAvR2n+wvi3bDvW1Yrhqaf1jh8VWuR4k8TqzMbaed5W4bDuDw9Y7QkcmQ/GNxh9cKRt8
         LBrho171SdCVr3FaZ2hSsAk5c/FTP4BsQpG7LJxg+DaPOUwbD0cYitYL53tMcVrfv4px
         Fd8S183ABH7mYNl3jYNrXJwj+JGgB8ehZyhldCoFAfrIyh4M6ozY+Tza7zQVd89LNGxi
         S4vExBOdjpnlAy8fX50Url7Vus1AV+r+/2XE6nplaVCkEOUPftJ53wlV6IR7uOZM1ucX
         WRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cDSGjsZLxrrxEWh0LEAOx0oKYxUvAtDpQKo93C1IX8=;
        b=HyzdArXLVJsZRScG4fYwd16XpJkd3SMGhx4RMtfVG2kxg6VYkS81e1SvNse7P1+fQE
         b/AKanq+/GxUTUZLVN6h3XKZjskrXidwWOAAqtM9heLNnhqHLGTuJkCr2jaMO63Wv3wH
         3iQB3Ub+Ek5ZzCbFRQRuQLx1NaHSUrJgVkGynRBQn7rHQsrbvOAsZBsofo5W2HYVXG9p
         ez/JVTxrIlt+MBRHDrzo1eV8SiCOaqWeIEeBi7+fO0O1Zm659ZYG6WfQIEIRminI7LQk
         KnlC8CMjGbktt9qg/YFCwYJXaRqqKuIZW6TR57YDP/wDm5C9EWw3vcW2uWLG89DRERpq
         96MQ==
X-Gm-Message-State: AO0yUKXrPK7TVNbykeAmvPW1mURU1fe3g2UNGndLkcBb0gwdRAtCX/Mz
        eTax0VevN7WYxIKSvzsXkTof/9QPbkA=
X-Google-Smtp-Source: AK7set+CH4IPKvPhCyIUAZh8En9SGRNdOZNRv7oO+4wZHHyuwrtzZArEZpbhWgKKKvMxLZNr4mObYQ==
X-Received: by 2002:a17:903:234b:b0:19a:7f4b:3ef6 with SMTP id c11-20020a170903234b00b0019a7f4b3ef6mr8627410plh.3.1677033178474;
        Tue, 21 Feb 2023 18:32:58 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-13.three.co.id. [116.206.28.13])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902a5c900b00196896d6d04sm4245747plq.258.2023.02.21.18.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 18:32:58 -0800 (PST)
Message-ID: <a1635643-a4a8-61e1-7798-af7455668878@gmail.com>
Date:   Wed, 22 Feb 2023 09:32:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Update documentation of vfs_tmpfile
Content-Language: en-US
To:     "Hok Chun NG (Ben)" <me@benbenng.net>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20230221035528.10529-1-me@benbenng.net>
 <01000186721d17f8-ab0c64f0-a6ae-4e43-99a3-a44e6dba95b6-000000@email.amazonses.com>
 <Y/TFdmhvrLu1h8Kl@debian.me>
 <346A4D50-E68E-4D03-B06B-4949F5640197@benbenng.net>
 <0100018676b0882f-5895463a-0af2-4fae-9e0b-8d4676347b1f-000000@email.amazonses.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0100018676b0882f-5895463a-0af2-4fae-9e0b-8d4676347b1f-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/22/23 08:15, Hok Chun NG (Ben) wrote:
> Hi Bagas,
> 
>> On Feb 21, 2023, at 8:21 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On Tue, Feb 21, 2023 at 03:55:54AM +0000, Hok Chun NG (Ben) wrote:
>>> On function vfs_tmpfile, documentation is updated according to function signature update.
>>>
>>> Description for 'dentry' and 'open_flag' removed.
>>> Description for 'parentpath' and 'file' added.
>>
>> What commit did vfs_tmpfile() change its signature?
> 
> Changes of the function signature is from 9751b338656f05a0ce918befd5118fcd970c71c6
> vfs: move open right after ->tmpfile() by Miklos Szeredi mszeredi@redhat.com
> 

Nice.

The preferred git pretty format when referring to existing commit is
"%h (\"%s\")". Make sure that you set core.abbrev to at least 12.
 
>>
>> For the patch description, I'd like to write "Commit <commit> changes
>> function signature for vfs_tmpfile(). Catch the function documentation
>> up with the change."
> 
> I agree. Thank you for the suggestion.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

