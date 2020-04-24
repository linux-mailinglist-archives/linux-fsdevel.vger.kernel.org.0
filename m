Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241901B801F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgDXUKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:10:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11DC09B048
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so11274569ljb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us5X4azLjqT5LS7IyRZRPdJayxqObn6u8xzpAkfnwDc=;
        b=A5AthDZQNsd/qaWi9a+AaUpSV7lp1t+8zpiQR1H5sACnEyGZGyTH4e/qwyOvh++pW4
         S9TJ5QXcQSjexXy9a96AUfqiizRvDtAlGo9lHDJmjNJU1k5LKp8JrCBXulrQvfXSPm1Y
         yh+HTwV/c1L69ePMr7sr9Q8ydvhDLtCVvfRWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us5X4azLjqT5LS7IyRZRPdJayxqObn6u8xzpAkfnwDc=;
        b=QitDq00q0nOVwLqNmzbTM5ZC/P6ydlU00M4HaW4J6tUvY5Qbcwh9rmtx0CXxj3YVtw
         ui+bS/YoOt/263yjKFrOl6mxPESF/iuisghFQefCDZ0aIMb6L4m0p0SOo7gQpYqQbKxd
         BIphJSv3LEkj7nMYo+FyknJXOC/NvHFNbDeoBqQkpWO7jX4/8LoVHHA4kUduzsbF4PR5
         pmdMCqQSN2IFU9TxWtyh4pABoYaoN3ZmEobm4hDKEVphQ6bxUkCHRQ8bKu58y06eTrfn
         xmkLEopjCJNLiIBZzwxrG8PtHCAHd674u86hXGUtWayJgH+YUtNbBHc4imXr/FCXrZ5a
         XvMg==
X-Gm-Message-State: AGi0PuaxTDcLMSSVljplyqyRSTH5RYn6ME1pJq+0mfhCmcy7vOPRUqo2
        33VJjYXR3gNMvN1U9UuRR4jmqSC0MOM=
X-Google-Smtp-Source: APiQypJIFLEuJ/TZpGvUXQZHRCNlm2cj3TKhTeVg02dEtrWxKQFQo1Gaw616BIJciFmDhjEwR5xOxw==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr7049581lji.279.1587759050997;
        Fri, 24 Apr 2020 13:10:50 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a28sm5045927lfr.4.2020.04.24.13.10.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f11so6674946ljp.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr5169817ljj.265.1587759049344;
 Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
 <87tv19tv65.fsf@x220.int.ebiederm.org> <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
 <87mu70psqq.fsf@x220.int.ebiederm.org>
In-Reply-To: <87mu70psqq.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 13:10:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE3JpLqKdwEzce6PyfqT3DVKccuK0H7ixY28CwOUNdmg@mail.gmail.com>
Message-ID: <CAHk-=wgE3JpLqKdwEzce6PyfqT3DVKccuK0H7ixY28CwOUNdmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:54 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> The problem with
>
> remove
> remove
> add
> add
> is:
>
> A lookup that hit between the remove and the add could return nothing.

Argh. Because that thing doesn't actually _search_ the list, it just
wants to pick any (first) entry. So it doesn't actually care what it
gets, just that it gets something.

Ok, I see.

> For PIDTYPE_PID and PIDTYPE_TGID these practically aren't lists but
> pointers to the appropriate task.  Only for PIDTYPE_PGID and PIDTYPE_SID
> do these become lists in practice.

Yeah, that's what confused me. Ok, please add a comment about the
"single-entry list" issue, and I'm happy.

            Linus
