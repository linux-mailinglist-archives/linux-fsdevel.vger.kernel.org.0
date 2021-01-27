Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC13305360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 07:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhA0Goq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 01:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhA0GgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 01:36:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6AEC0613ED;
        Tue, 26 Jan 2021 22:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SawICNoa1kHyyeVtFqzgzTd8rQ75hzb8S4YXXAcpsPY=; b=QoOZvbdEU+hBFgpGiWadkcgzUE
        RW6FtKNpqlL/UxLfWddmBDCJjKIRQFKxV10LKmHRcP4Jxz0YhEqGn7hk9SvLysmavnuft2qPKBVu/
        xOuYYK+bq4hwZ98XxSFDlEGWHO/UkS/hVxjxyXejOm9Sg3ta5bycHlkso5gSbZKbQYqsRJ13foLyn
        bQJ/i70iCPLz5XWxJ4JuTQj5UeKjWQvGPwuyyDHBXV4ov59l2Oi8HsGcErKnSAHwHN8pe53yFX7gn
        yPaPH/B0yHZvhIBoGDboaa52vLSQ2+0TcmODS/HKctXeAvhfU0M7HI3x6CKcd0xsQEI/N8cNIztJj
        VE3RhdUA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4eQF-0003mB-Ck; Wed, 27 Jan 2021 06:35:23 +0000
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
 <5d005259-feec-686d-dc32-e1b10cf74459@infradead.org>
 <df3e21ea-1626-ba3a-a009-6b3c5e33a260@infradead.org>
 <CAE1WUT4qQ2=Qkz1xsTYCvxdr5NJp8wMKhV_AiXKdq_kwWw1mfg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b8f67a6-0f06-6bf6-2ecd-5a57693a64f8@infradead.org>
Date:   Tue, 26 Jan 2021 22:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT4qQ2=Qkz1xsTYCvxdr5NJp8wMKhV_AiXKdq_kwWw1mfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 9:13 PM, Amy Parker wrote:
> On Tue, Jan 26, 2021 at 7:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 1/26/21 7:46 PM, Randy Dunlap wrote:
>>> Hi Amy,
>>>
>>> What mail client did you use?
>>> It is breaking (splitting) long lines into shorter lines and that
>>> makes it not possible to apply the patch cleanly.
> 
> Was worried about that, thought I had all my settings straightened out.
> 
>>>
>>> You can see this problem below or on the web in an email archive.
>>>
>>> Possibly Documentation/process/email-clients.rst can help you.
> 
> Yeah, read that. Thought I had everything fixed up.
> 
>>
>> Also tabs in the source file have been converted to spaces.
> 
> Was this inconsistent throughout the patch? I can't really seem to
> tell. If it's consistent, bet it's probably my mail client - if it's
> inconsistent it could be my editor, I had to switch out temporarily
> for a different editor today.
> 

There are no tabs in the patch.

>>
>> It would be good if you could email a patch to yourself and then
>> see if you can apply cleanly it to your source tree (after removing
>> any conflicting patches, of course -- or use a different source
>> tree).
> 
> Yeah, I'll make sure to double check with that in the future.
> 
>>
>>
>> --
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> netiquette: https://people.kernel.org/tglx/notes-about-netiquette
> 
> Should I send in a v2 of this patchset, or just attach the patch here?
> If I should just attach it here, then I'll do the same for patch 2/2.

An attachment might be OK once but it would be better if you
could get inline patches to work. You'll need to do that...


-- 
~Randy

