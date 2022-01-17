Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796E8490041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiAQCev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 21:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiAQCeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:34:50 -0500
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1523C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 18:34:50 -0800 (PST)
Received: by mail-ot1-x362.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso18111233otj.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 18:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:references:content-disposition:in-reply-to:user-agent;
        bh=OIuBfc7zAPYkZAy85GHXR3lNnSGWQNOSPGFnL140mf0=;
        b=MwcG6u6x5xyBAJl+QUeBz3pPU6lbQcgcy9QEdNl+0rVsAcNZsmhk+t+ZLR8Q2rWRWm
         VsbGhm3D97utLSRnWog4eCL0jXY4MLbVPaUnJulXJ9Ne5EE53bjKqr4ODHWJCP/Er5y1
         YPUjS4Sh0s9ipJDSFrOJwoE45/bFPQlvOzmmHfMB5rhglxEC1dnNWcA+EDcRN1cyvc9E
         t8atc/qdHq8j2fupLzNUtC9TiGDddJ1J3rI5WUIkLlJgqogI+qMoB1waTeoKo/4/yIe/
         ywMWBau4YgdxiM3luokQ4A/cimZPqy2u0sSyC9LtyUBtXwUEx3pYJnF9Pw6MaM788lr+
         /jig==
X-Gm-Message-State: AOAM530im+1eJsZFhjNLAOJS2hX418HU4fncfSPGGlsuMZYoGZnbJ8xJ
        6zNuOlkRlmW+T1phPn9p4D4YPj7uHg0d8r9DJQ3xGRt+n391
X-Google-Smtp-Source: ABdhPJwPyRcVZsA4g5JHkKOeqDeIJCIr2ZyyZK8+06zZ4CZ/IZ9uXqAYdSCL3NkVYUUXMhegYxPmT6qKMF7o
X-Received: by 2002:a05:6830:168c:: with SMTP id k12mr3694040otr.100.1642386889915;
        Sun, 16 Jan 2022 18:34:49 -0800 (PST)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id y15sm1947155oov.17.2022.01.16.18.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 18:34:49 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from visor (unknown [10.95.68.127])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 1C30140187B;
        Sun, 16 Jan 2022 18:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1642386889;
        bh=OIuBfc7zAPYkZAy85GHXR3lNnSGWQNOSPGFnL140mf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xiDD0OX7H/IeydzNUa5UAWD88MUcIcsbzgxlKbJ2uFARjrgzMviuJS8wRQ+PJ79JS
         sdVGeUMc4uHlXkQ9BkbYgaQBr24Cy85cj8gc8YvWkMuZ+/vzLxOLn0eGIde90FcLwZ
         Ni0f6PcN7Tu3LCFJ4J98vLM9h6r/XCC+G+bdTQ9bvU9WIX4SfQn8elof5Sz0CM81Nj
         h/0WzS7ULyIPTs6UczLMu/e+yLTlck/1lwNEtHpJg5p0vJu3x9YteMYKdg0v14PVNQ
         gI8F1bsbIDdrIwL0xzb4XCQw3EsULy04ZWVd6KpncHUhV4hn8t+d1z9DLGz5pGYtlR
         /xQ0ntHnseqow==
Date:   Sun, 16 Jan 2022 18:34:47 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
Message-ID: <YeTVx//KrRKiT67U@visor>
References: <YeI7duagtzCtKMbM@visor>
 <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor>
 <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 16, 2022 at 12:14:01PM +0200, Amir Goldstein wrote:
> On Sun, Jan 16, 2022 at 3:20 AM Ivan Delalande <colona@arista.com> wrote:
>> On Sat, Jan 15, 2022 at 09:50:20PM +0200, Amir Goldstein wrote:
>>> On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
>>>> Sorry to bring this up so late but we might have found a regression
>>>> introduced by your "Sort out fsnotify_nameremove() mess" patch series
>>>> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
>>>> reproduced on v5.16.
>>>>
>>>> Some of our processes use inotify to watch for IN_DELETE events (for
>>>> files on tmpfs mostly), and relied on the fact that once such events are
>>>> received, the files they refer to have actually been unlinked and can't
>>>> be open/read. So if and once open() succeeds then it is a new version of
>>>> the file that has been recreated with new content.
>>>>
>>>> This was true and working reliably before 5.3, but changed after
>>>> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
>>>> d_delete()") specifically. There is now a time window where a process
>>>> receiving one of those IN_DELETE events may still be able to open the
>>>> file and read its old content before it's really unlinked from the FS.
>>>
>>> This is a bit surprising to me.
>>> Do you have a reproducer?
>>
>> Yeah, I was using the following one to bisect this. It will print a
>> message every time it succeeds to read the file after receiving a
>> IN_DELETE event when run with something like `mkdir /tmp/foo;
>> ./indelchurn /tmp/foo`. It seems to hit pretty frequently and reliably
>> on various systems after 5.3, even for different #define-parameters.
>>
> 
> I see yes, it's a race between fsnotify_unlink() and d_delete()
> fsnotify_unlink() in explicitly required to be called before d_delete(), so
> it has the d_inode information and that leaves a windows for opening
> the file from cached dentry before d_delete().
> 
> I would rather that we try to address this not as a regression until
> there is proof of more users that expect the behavior you mentioned.
> I would like to provide you an API to opt-in for this behavior, because
> fixing it for everyone may cause other workloads to break.
> 
> Please test the attached patch on top of v5.16 and use
> IN_DELETE|IN_EXCL_UNLINK as the watch mask for testing.
> 
> I am assuming that it would be possible for you to modify the application
> and add the IN_EXCL_UNLINK flag and that your application does not
> care about getting IN_OPEN events on unlinked files?
> 
> My patch overloads the existing flag IN_EXCL_UNLINK with a new
> meaning. It's a bit of a hack and we can use some other flag if we need to
> but it actually makes some sense that an application that does not care for
> events on d_unlinked() files will be guaranteed to not get those events
> after getting an IN_DELETE event. It is another form of the race that you
> described.
> 
> Will that solution work out for you?

Yeah, sounds perfect for us, and adding IN_EXCL_UNLINK to our
applications is fine indeed. I've tested the 5.16 patch on my laptop
with the reproducer and can't reproduce the issue. I've also tried the
5.10 patch on our products and also stop seeing the issue both with
the reproducer but also with our internal applications and test cases
that made us look into this initially. So this looks like a good fix on
our side at least.

>>>> I'm not very familiar with the VFS and fsnotify internals, would you
>>>> consider this a regression, or was there never any intentional guarantee
>>>> for that behavior and it's best we work around this change in userspace?
>>>
>>> It may be a regression if applications depend on behavior that changed,
>>> but if are open for changes in your application please describe in more details
>>> what it tries to accomplish using IN_DELETE and the ekernel your application
>>> is running on and then I may be able to recommend a more reliable method.
>>
>> I can discuss it with our team and get more details on this but it may
>> be pretty complicated and costly to change. My understanding is that
>> these watched files are used as ID/version references for in-memory
>> objects shared between multiple processes to synchronize state, and
>> resynchronize when there are crashes or restarts. So they can be
>> recreated in place with the same or a different content, and so their
>> inode number or mtime etc. may not be useable as additonnal check.
>>
>> I think we can also have a very large number of these objects and files
>> on some configurations, so waiting to see if we have a following
>> IN_CREATE, or adding more checks/synchronization logic will probably
>> have a significant impact at scale.
>>
>> And we're targeting 5.10 and building it with our own config.
>>
> 
> I am not convinced that this is needed as a regression fix for stable
> kernels, but since you are building your own kernel I can help you do the
> backport - attached *untested* patch for v5.10 that also backport of
> "fsnotify: pass dentry instead of inode data".

Thanks a lot for making the backport too, actually later 5.10.y have
your 950cc0d2bef0 and fecc4559780d changes, so I think we should just
use the same fsnotify.c patch hunk as your 5.16 patch (but yeah still
need the fsnotify_data_dentry bit). That's what I tested on our product,
and as mentionned above seems to be working great.

And we do carry a few custom patches and mainline backports so it's
perfectly fine if you prefer not to submit it to stable.

Thanks again,

-- 
Ivan Delalande
Arista Networks
