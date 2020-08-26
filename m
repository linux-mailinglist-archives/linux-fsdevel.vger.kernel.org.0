Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2283D252877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHZHba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHZHb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:31:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0AFC061574;
        Wed, 26 Aug 2020 00:31:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so714472wmi.5;
        Wed, 26 Aug 2020 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iugUDxAIQnsl/7ZTyF/vSE3EIH4/fyRR8BQQUZWp5EQ=;
        b=Z2eetczZorq1PwBzNArWIukQAkQr+paPOisqwgvveDDD3GU3KOHoDs/79J2caxqSz1
         iO1GLncjUMrj7RwcK1kbLNigUHVYYnWwVF39f+w41H2Gr86d6pu0j4f4j5sVlJwkXlq6
         SwaV6AE3U4Nn31pMY3y96WnIM7ZXc+amAEGdWaIlzIAQDTfd6Hd29krGLP1RJoNaunW5
         qD7saoAmwowVM9j+mV3naqQYj5d8wTTLpBtAMevaOQ6ggdOzMLCdUkmU3BGAbZzuuAX7
         Bcj451PyKs6PK7CZlx+woOjvfOIWkTNTQUo8zrHw9cqGCnYtD3b+XGwsAMc/hDMC+3xH
         DLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iugUDxAIQnsl/7ZTyF/vSE3EIH4/fyRR8BQQUZWp5EQ=;
        b=UH4TroUE770PKmbH68Ob3UExd6LU3WTsKiZFnWl++wwj9dXX3LkrTe42V1Dg996+3T
         nMxZXH3nVPCTHVw9xCMhOO1xEh8CZ+0BrD03CINHwEt7BCXGW9+9A7GQz+rtWwZmsv3w
         2BeKXLmCp4TwOv1mvpXXmikej3mJR+gdrXfywvxNK7YU3/G5L6CpL4mmwHeu8e7lcjTm
         VOugwbEarfrHnwuOOG4GhEQgsAIBGuFi1JrE2KQDq4rtpW72TUIQhPguFEhD/Q8QY4Cw
         EyImptqkwnpPZIJzTF68pOFZZi6zvLSeLw9gDYd/ZqwL+/P0sBvmBWj79XqUPZxbXdCJ
         58bw==
X-Gm-Message-State: AOAM5325U9xD55NoSTSEjqq9SZxY/2LG+V+dlGJVccAEQEusLhRnSYuu
        5aTWXx3C7Id3Pj8vVP1gZ38=
X-Google-Smtp-Source: ABdhPJy68Qvq8AcZg5rqsHqIO4qYh0hH2z1tsgQ09aHUGpv1lVQhmf9NzotCzkFjNfZwGbmAnPUEAA==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr5057597wmg.181.1598427087731;
        Wed, 26 Aug 2020 00:31:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:4c01:2cf1:7133:9da2:66a9? ([2001:a61:253c:4c01:2cf1:7133:9da2:66a9])
        by smtp.gmail.com with ESMTPSA id f6sm4390016wme.32.2020.08.26.00.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 00:31:26 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/5] Add manpages for move_mount(2) and open_tree(2)
To:     David Howells <dhowells@redhat.com>
References: <CAKgNAkjHcxYpzVohhJnxcHXO4s-4Ti_pNsmTZrD-CMu-EUCOoA@mail.gmail.com>
 <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
 <159680894741.29015.5588747939240667925.stgit@warthog.procyon.org.uk>
 <287644.1598263702@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <91c4ada9-5b5d-e93e-0bf6-b0a36b240880@gmail.com>
Date:   Wed, 26 Aug 2020 09:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <287644.1598263702@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 12:08 PM, David Howells wrote:
> Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> 
>>> +To access the source mount object or the destination mountpoint, no
>>> +permissions are required on the object itself, but if either pathname is
>>> +supplied, execute (search) permission is required on all of the directories
>>> +specified in
>>> +.IR from_pathname " or " to_pathname .
>>> +.PP
>>> +The caller does, however, require the appropriate capabilities or permission
>>> +to effect a mount.
>>
>> Maybe better: s/effect/create/
> 
> The mount has already been created.  We're moving/attaching it.  

Ahh -- then the verb was wrong.

to effect == to cause, bring about
to affect == to change, have an impact on

> Maybe:
> 
> 	The caller does, however, require the appropriate privilege (Linux:
> 	the CAP_SYS_ADMIN capability) to move or attach mounts.

Yes, better.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
