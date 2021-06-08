Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7115E39EC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFHDBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 23:01:32 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:52966 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhFHDBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:01:32 -0400
Received: by mail-pj1-f48.google.com with SMTP id h16so11042499pjv.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjTn22JEF5eF51IArZrqTAQlrpfCjBS+72vaP/FnZN4=;
        b=u1Si2PDXN32VK9mmLPjVV9BGWqy7BIgjQB+IFo2m9NZZ4gMMy2QUVsR8SqS9CqKbcN
         3kLlP3QZ4a4k5dt4urxhkLABcREXaPq4XesQrhVmhOZKzGmOzDPOMxUUsSf8OPmyTXKP
         WBB12QAZyR3cBnAfa1gYhD40jVCMeiNdQ4D60bKLV9pvpydRbMiRY9yxWn7dNC08NYfI
         SFBQqUM+feqTPKmvUXBHHDWQ0mOainu7zlEqcWdOjhgvQZSoq5w05DqN9W5kUwllgl0C
         r/IxDLabbAkc1FRqOTM2sJt4RvJY4gWodxeAQex1N9iaDtlwxzhZzBQ9SvrGzk7NSK2y
         D3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjTn22JEF5eF51IArZrqTAQlrpfCjBS+72vaP/FnZN4=;
        b=ntNXCJh8J9WP506QLh5J/rx+SqDgWGbrO2CVkXPjZ/aiOixJKv43lsobfqsMpwPkGG
         mz/VRPzCm7KEG8ocdJENJj7wpZhMahGOKw/FMNmrsoH3L+9Re7XP1xX5veMACe21lsbT
         JqwCsRC4BTz3x4Zp9S87WzO7JXcb+i/F9gGLjWvr2eIR1XebPl64VWe3xcGqQNRbadsD
         xokAx2Xyu+mOytYbOS6+JMZw/usO4ajwXwUP9OkXZ8P1mObyiqR2Vmc8fJtW2HstLP6j
         akbLoPLwk5WTWRQZEatHvtBs0NT3fZgOYk7nwSd77ryiavTvaDbzszDWECfYa8iqHfLU
         dI1w==
X-Gm-Message-State: AOAM53278Z7CoRh3RnovfpPDdMex0mMWRzyPtfuDwQ5BxTlRRNOkOptK
        XnW8FbO8FysT2lVD4++lVyfFlYl7rECl649CKBk=
X-Google-Smtp-Source: ABdhPJxpU96SAI3REow9ORaHINwC+Oq841cKpMoJLXQshMVQlS0yr2kUAreRHTlugBSGJAz4H7wC9BWOAXAVku1AWD4=
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr2410447pjv.156.1623121115970;
 Mon, 07 Jun 2021 19:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
In-Reply-To: <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Tue, 8 Jun 2021 10:58:24 +0800
Message-ID: <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:34 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 02.06.21 17:50, Alessio Balsini wrote:
>
> >> A possible use case is fuse fd passthrough being developed
> >> by Alessio Balsini [1] where underlying file system fd can be saved in
> >> this file store.
>
> oh, this could be quite what I'm currently intending do implement
> (just considered 9p instead of fuse as it looks simpler to me):
>
> I'd like the server being able to directly send an already opened fd to
> the client (in response to it calling open()), quite like we can send
> fd's via unix sockets.
>
> The primary use case of that is sending already prepared fd's (eg. an
> active network connection, locked-down file fd, a device that the client
> can't open himself, etc).
>
> Is that what you're working on ?
If the server and client run on the same kernel, then yes, the current
RFC supports your use case as well, E.g.,
1. the server opens a file, saves the FD to the kernel, and passes the
IDR to the client.
2. the client retrieves the FD from the kernel

Does it match your use case?

Cheers,
Tao

-- 
Into Sth. Rich & Strange
