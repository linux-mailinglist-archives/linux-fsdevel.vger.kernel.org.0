Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C34C48D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiBYP2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 10:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiBYP2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:28:40 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E512036EC;
        Fri, 25 Feb 2022 07:28:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v28so7854073ljv.9;
        Fri, 25 Feb 2022 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EAGZgY5SPdT1cVkvJoh2QfrN+7asBE1KRK8S40gaDQ=;
        b=fRej6ns/ZWUEzUvxNGbQZNAT0BSw4zJppp4g8vJ12SjSS7/PKWYqWh+qGLnO51O8iL
         xYfz41lSy7g9p5dFSX/Vhn9G1iI4DI42ZpPD98CNT4CIVD+KHqAMGHjPeFAxtW7r4OWJ
         Bt24gJWuMtOlAENd3MxdHU1fclGI3Ej7waj6TqxJBGC+e5Plc8MWVww3O23yMZN5MEai
         +v5oPQeRV/Ecda+PFN2Fi3sqCicKjkSIcXNayKhRTQKBSKzcFg6VPMXnJJl+dWQ+yZ2I
         Us39X3Lp2huMeqYZOnP4q4WORoar2kNDCdTWI8b0htO7xg8iaNf+S0vFGZcd7nT8mqH5
         YvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EAGZgY5SPdT1cVkvJoh2QfrN+7asBE1KRK8S40gaDQ=;
        b=e/pMh0ERo9zeLe7Plgh6uI5/hPKEzI5VttLGDzkP2q4RgNNKM8RQvteO3sAY/9mefi
         1eWNXUzgXbXnPi6kkQYDlRxiIlpl+oTAJowSbcgId2H5bPVUbT3GpX8/mT5KtHjN1sJp
         mSQsDHrEG+HHkCeL1oG0t47zLX+Xs05Z59o6JNlYPUqw9A6IUuTw3vDTJ1my43xip37A
         P+CCAov6mLEoXM2spSrd/a/JQhhSXFQVW7nNapjSGtyDtLhU2hr5HmmDFYiSXxBwHtmu
         FlGeG9Zyc8T6jHRgZ8L5Z+MyQkvTn+mTU8AO72H4dvpAQmkkE2X6Uz7Xg/PpTIag5y06
         hsyA==
X-Gm-Message-State: AOAM532AZbdtveSY4Q7UY8n9VHmouzS1A8s4vyL8+KJaBns3Yltl3Qfr
        BCoC80v2vrHSH6g2+t2kgVhCq+S0o9vyKDvaaqQ=
X-Google-Smtp-Source: ABdhPJwxd5AOIZzj1xHVv9ZDVXsnGHmJoUs7e6+bgciCEyzgPU77fjeFtutgvognPrXU36YRHWEpujkFHRb8BSzbEgE=
X-Received: by 2002:a2e:b014:0:b0:23c:9593:f7 with SMTP id y20-20020a2eb014000000b0023c959300f7mr5517803ljk.209.1645802886225;
 Fri, 25 Feb 2022 07:28:06 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com> <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com> <YhjeX0HvXbED65IM@casper.infradead.org>
In-Reply-To: <YhjeX0HvXbED65IM@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 25 Feb 2022 09:27:55 -0600
Message-ID: <CAH2r5mt9EtTEJCKsHkvRctfhMv7LnT6XT_JEvAb7ji6-oYnTPg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 7:49 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Feb 25, 2022 at 08:23:20AM -0500, Vivek Goyal wrote:
> > What about local events. I am assuming you want to supress local events
> > and only deliver remote events. Because having both local and remote
> > events delivered at the same time will be just confusing at best.
>
> This paragraph confuses me.  If I'm writing, for example, a file manager
> and I want it to update its display automatically when another task alters
> the contents of a directory, I don't care whether the modification was
> done locally or remotely.
>
> If I understand the SMB protocol correctly, it allows the client to take
> out a lease on a directory and not send its modifications back to the
> server until the client chooses to (or the server breaks the lease).
> So you wouldn't get any remote notifications because the client hasn't
> told the server.

Directory leases would be broken by file create so the more important
question is what happens when client 1 has a change notification on writes
to files in a directory then client 2 opens a file in the same directory and is
granted a file lease and starts writing to the file (which means the
writes could get cached).   This is probably a minor point because when
writes get flushed from client 2, client 1 (and any others with notifications
requested) will get notified of the event (changes to files in a directory
that they are watching).

Local applications watching a file on a network or cluster mount in Linux
(just as is the case with Windows, Macs etc.) should be able to be notified of
local (cached) writes to a remote file or remote writes to the file from another
client.  I don't think the change is large, and there was an earlier version of
a patch circulated for this

-- 
Thanks,

Steve
