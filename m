Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718D728D4DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgJMTpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 15:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgJMTpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:45:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EBEC0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 12:45:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l24so698966edj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zz37D07nBex4LXRsGO0eeoEF5U7Zs7MdOvVJudSqras=;
        b=QVCTfmGMkYn1oWoGZZpsGwjnyAgSJvogqrPoMtEQB9Cw4phzdyL69I9T4OkhHTJqa6
         a2fe37CLNljzqeSkUEGEmzMStvdcqrsFj+qdkHBoS+9hrDgEDRfWtJ0MQZ+X5yXeBhCa
         1zGsJCYgsaQvAZ1B8SQOis1XtgWOgMJCDL/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zz37D07nBex4LXRsGO0eeoEF5U7Zs7MdOvVJudSqras=;
        b=iK8nvN/v3jbW7f/2rZa3q49w8mbHwfOYzZxvhOljAwf5INekB1vLY03JkK9Ycl8rJB
         FM7UPykxcXDfJL0Bmveoc1rivlE/XoT8NXeMfUcWPi65ySoq4Cj6umfDEMAWCKf9JMoi
         /5GcTFNSlIIfPwQUN3WJ5zfB3mJbjs0lSPSszOEm6snJt82xZdc4tk1pXuXePYQqUood
         jolq0Rbh3zHRavAbEt5EWNEaejV0VQuhUDyVsteXAVqa8CinsBoq0CQEbpxz2gBXySKU
         KWhUyubrSe5onDllNN7fA5XmqTEmshOPInTR9c498pA3YdjREjSVyRSq6kZHGIzAWrWx
         NQwQ==
X-Gm-Message-State: AOAM533mzBKHzJEShbC1CNIYrCx5xomyFy01NrFSEtzyQUjbDlFLdz6W
        g8jY4FskfrxS/T4KU1xc//+T4Q==
X-Google-Smtp-Source: ABdhPJxCrmFOwGq3qX7GfcYdHiczoNdh4mmaHubZt8CgKaHIAmUtY8CUbLj46QYhjPDpp81Nts0ffA==
X-Received: by 2002:a05:6402:a4f:: with SMTP id bt15mr1260487edb.345.1602618342320;
        Tue, 13 Oct 2020 12:45:42 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id bx24sm459542ejb.51.2020.10.13.12.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:45:41 -0700 (PDT)
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
To:     Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
 <20200710155719.GN12769@casper.infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20a80bdc-7a5d-c08b-e27b-bea38c378b6c@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 21:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710155719.GN12769@casper.infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/07/2020 17.57, Matthew Wilcox wrote:
> On Fri, Jul 10, 2020 at 09:56:31AM +0200, Rasmus Villemoes wrote:
>> The ability to check open file descriptions for equality (without
>> resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
>> useful outside of the checkpoint/restore use case - for example,
>> systemd uses kcmp() to deduplicate the per-service file descriptor
>> store.
>>
>> Make it possible to have the kcmp() syscall without the full
>> CONFIG_CHECKPOINT_RESTORE.
> 
> If systemd is using it, is it even worth making it conditional any more?
> Maybe for CONFIG_EXPERT builds, it could be de-selectable.
> 

[hm, I dropped the ball, sorry for the necromancy]

Well, first, I don't want to change any defaults here, if that is to be
done, it should be a separate patch.

Second, yes, systemd uses it for the de-duplication, and for that reason
recommends CONFIG_CHECKPOINT_RESTORE (at least, according to their
README) - but I'm not aware of any daemons that actually make use of
systemd's file descriptor store, so it's not really something essential
to every systemd-based system out there. It would be nice if systemd
could change its recommendation to just CONFIG_KCMP_SYSCALL.

But it's also useful for others, e.g. I have some code that wants to
temporarily replace stdin/stdout/stderr with some other file
descriptors, but needs to preserve the '0 is a dup of 1, or not' state
(i.e., is the same struct file) - that cannot reliably be determined
from fstat()/lseek(SEEK_CUR)/F_GETFL or whatever else one could throw at
an fd.

Rasmus
