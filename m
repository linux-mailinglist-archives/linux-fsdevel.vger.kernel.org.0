Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B03B7EAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391538AbfISP7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 11:59:45 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:38262 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391530AbfISP7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:59:44 -0400
Received: by mail-lf1-f53.google.com with SMTP id u28so2771429lfc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8LYnz1vv5tI3GZ6Lq+k6CmiHNbJUTHYO30ZgPVV0WU=;
        b=T/6gIwbfpiXV3L6bav6DhQetuAMBXy/Bqgt8Bn//Ktv5A0ZlOwwdqUFvu2JOVs5YAL
         GW7fhEsoQl3YTPl3Lrs/5T4hqdFZPN1ThISPa9aW4ffAKtyS96xs7iMX8oXz1SyBa6v/
         ZT+WNN1O02jjgKM8I1ZCBJsBj3YxaAZ5oaDws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8LYnz1vv5tI3GZ6Lq+k6CmiHNbJUTHYO30ZgPVV0WU=;
        b=RvQ/8Qil7pK7/peV5oNBuM7c61S5zmjkZ2AZqPeKgiLq5zdpJNvkDO0i1jg7IQjwSX
         N83EsxB1aeQvTs7e3RiGlFXWT0fF/LCaRW9S6awQ+UkLegDoAjMa0l/XhRAOuBNVgFdj
         bEJX5VPpyblGIrVMnynq64WfPkSaqxOmhxbrrq2ld2GiU1mY6OgPBWZ0zi85uvopUZXT
         u+VP0oVE3CzqC/sVjoZ/LpP/O9boBYjVtsb6BcbqYz0Qp4eb0IuwBQZq8XqxKHpkHvw7
         GxTIS/iVAfGm9/xHXewcdKeJ3JzxO6qFbfTtQaEsz00a38ce35aO27HRULBy6k3PZ/9R
         dOeQ==
X-Gm-Message-State: APjAAAVb2HPxr/kR3Fxpg3ikcyztSv3DcwjLzEHOVk93hPI9PQAtF9e+
        UqkJCmos/5Kul184h98bodxhcj+NSX8=
X-Google-Smtp-Source: APXvYqz5yIJYRFEBZSXM06M5E+k3g/JmRlof7vTUXuGdJthOpLjaqFRqls1iDqIXB6lZtupmU6WNSQ==
X-Received: by 2002:ac2:5463:: with SMTP id e3mr5388148lfn.117.1568908780897;
        Thu, 19 Sep 2019 08:59:40 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 202sm1741681ljf.75.2019.09.19.08.59.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:59:39 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 7so4130134ljw.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 08:59:39 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr5927834lji.52.1568908779394;
 Thu, 19 Sep 2019 08:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk> <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck> <15228.1568821380@warthog.procyon.org.uk>
 <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com> <5385.1568901546@warthog.procyon.org.uk>
In-Reply-To: <5385.1568901546@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 08:59:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigULuTe-c15nEv5661fRxX-7xTmCZ5y6KmqPoWtX7E3g@mail.gmail.com>
Message-ID: <CAHk-=wigULuTe-c15nEv5661fRxX-7xTmCZ5y6KmqPoWtX7E3g@mail.gmail.com>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
To:     David Howells <dhowells@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 6:59 AM David Howells <dhowells@redhat.com> wrote:
>
> But I don't agree with this.  You're missing half the barriers.  There should
> be *four* barriers.  The document mandates only 3 barriers, and uses
> READ_ONCE() where the fourth should be, i.e.:
>
>    thread #1            thread #2
>
>                         smp_load_acquire(head)
>                         ... read data from queue ..
>                         smp_store_release(tail)
>
>    READ_ONCE(tail)
>    ... add data to queue ..
>    smp_store_release(head)

The document is right, but you shouldn't do this.

The reason that READ_ONCE() is possible - instead of a
smp_load_acquire() - is that there's now an address dependency chain
from the READ_ONCE to the subsequent writes of the data.

And while there isn't any barrier, a data or control dependency to a
_write_ does end up ordering things (even on alpha - it's only the
read->read dependencies that might be unordered on alpha).

But again, don't do this.

Also, you ignored the part where I told you to not do this because we
already  have locking.

I'm not goign to discuss this further. Locking works. Spinlocks are
cheap. Lockless algorithms that need atomics aren't even cheaper than
spinlocks: they can in fact scale *worse*, because they don't have the
nice queuing optimization that our spinlock have.

Lockless algorithms are great if they can avoid the contention on the
lock and instead only work on distributed data and avoid contention
entirely.

But in this case the lock would be right next to the data anyway, so
even that case doesn't hold.

               Linus
