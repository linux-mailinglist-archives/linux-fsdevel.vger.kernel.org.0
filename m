Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EC30B166
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 21:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhBAUIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 15:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232888AbhBAUI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612210020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfxwGnD+dy8umn1NYGcjVPYpHw77B9r85fxRnvKqVIE=;
        b=Maan9w27IcYibL5YxbreY8x/KO9s5dEoL3R4LjK02aNMT301H8bmSviqQIX+pNLqFYexyO
        OnvopLoUwI5w+D3jp3xnLda7V3hTmOuimyfRUExPQOQ712Sp9fNrFWf1hsoa1iyboZyuLi
        D4qltanbkdTjdsOm2FP7cWPhDhAc+1w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-IBIn7F3MM_mpTxNFvr26Nw-1; Mon, 01 Feb 2021 15:06:58 -0500
X-MC-Unique: IBIn7F3MM_mpTxNFvr26Nw-1
Received: by mail-qk1-f199.google.com with SMTP id e187so14185203qkf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 12:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfxwGnD+dy8umn1NYGcjVPYpHw77B9r85fxRnvKqVIE=;
        b=E9ZXOZJbb8ouMYZoXmXATtHqwQZySxcof8opS11ctSKU0CFa+l3HBLK0Nm/YyOpTXd
         6EIjQPvlFbtApdyPPV9SLcATuAe2UKePv2/fXr3h1wQ/2WraHVyIsUpHzS0/5FHf4A/n
         9YRujkrhIQ/YRd6NuIuGTw/y1Eo5nq2AiPdcxM4C2+GJGKlF4GKM8p9WKVpgqzpBoVTK
         F4+CguBkjAx14HnfoCg+hUx/wWGUbqdeppAZ8HpqN/+sPQ8o3G7+B+Uit39s8HDx8FjT
         qU4c30YvRpMXJaHFuX12gdkGd0AKgJ7Xu8z8WUdG6L9cxF/J/Lrksx/uknuZxm3/KeUP
         pHAw==
X-Gm-Message-State: AOAM53229880yG9zM43EKHNor7Uh7JQAkUyCLjGWw+55Qjh4u8+t/2Ya
        uhx1o0HE9n3+9iGgRbsBHAvQ7Dkx/ieJteaxYGqQRmYEicVKbaCXSZYqiR7Bq9zUrntrpOUq4Ie
        O87XEcciUyEdhC7mCVTfGbcjUvw==
X-Received: by 2002:ad4:48c8:: with SMTP id v8mr16720962qvx.38.1612210018056;
        Mon, 01 Feb 2021 12:06:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHHxydcBEc3CJJbewLgzu9DZ1H4bSs28KW+16tXmuMDdFdnbUkwBL/eKC15pCMhCXHwbCWyw==
X-Received: by 2002:ad4:48c8:: with SMTP id v8mr16720926qvx.38.1612210017772;
        Mon, 01 Feb 2021 12:06:57 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id z8sm14666242qtu.10.2021.02.01.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 12:06:57 -0800 (PST)
Date:   Mon, 1 Feb 2021 15:06:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 8/9] userfaultfd: update documentation to describe
 minor fault handling
Message-ID: <20210201200654.GI260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-9-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128224819.2651899-9-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:48:18PM -0800, Axel Rasmussen wrote:
> Reword / reorganize things a little bit into "lists", so new features /
> modes / ioctls can sort of just be appended.
> 
> Describe how UFFDIO_REGISTER_MODE_MINOR and UFFDIO_CONTINUE can be used
> to intercept and resolve minor faults. Make it clear that COPY and
> ZEROPAGE are used for MISSING faults, whereas CONTINUE is used for MINOR
> faults.

Bare with me since I'm not native speaker.. but I'm pointing out things that
reads odd to me.  Feel free to argue. :)

[...]

> +Resolving Userfaults
> +--------------------
> +
> +There are three basic ways to resolve userfaults:
> +
> +- ``UFFDIO_COPY`` atomically copies some existing page contents from
> +  userspace.
> +
> +- ``UFFDIO_ZEROPAGE`` atomically zeros the new page.
> +
> +- ``UFFDIO_CONTINUE`` maps an existing, previously-populated page.
> +
> +These operations are atomic in the sense that they guarantee nothing can
> +see a half-populated page, since readers will keep userfaulting until the
> +operation has finished.
> +
> +By default, these wake up userfaults blocked on the range in question.
> +They support a ``UFFDIO_*_MODE_DONTWAKE`` ``mode`` flag, which indicates
> +that waking will be done separately at some later time.
> +
> +Which of these are used depends on the kind of fault:

Maybe:

"We should choose the ioctl depending on the kind of the page fault, and what
 we'd like to do with it:"

?

> +
> +- For ``UFFDIO_REGISTER_MODE_MISSING`` faults, a new page has to be
> +  provided. This can be done with either ``UFFDIO_COPY`` or

UFFDIO_ZEROPAGE does not need a new page.

> +  ``UFFDIO_ZEROPAGE``. The default (non-userfaultfd) behavior would be to
> +  provide a zero page, but in userfaultfd this is left up to userspace.

"By default, kernel will provide a zero page for a missing fault.  With
 userfaultfd, the userspace could decide which content to provide before the
 faulted thread continues." ?

> +
> +- For ``UFFDIO_REGISTER_MODE_MINOR`` faults, an existing page already

"page cache existed"?

> +  exists. Userspace needs to ensure its contents are correct (if it needs
> +  to be modified, by writing directly to the non-userfaultfd-registered
> +  side of shared memory), and then issue ``UFFDIO_CONTINUE`` to resolve
> +  the fault.

"... Userspace can modify the page content before asking the faulted thread to
 continue the fault with UFFDIO_CONTINUE ioctl." ?

-- 
Peter Xu

