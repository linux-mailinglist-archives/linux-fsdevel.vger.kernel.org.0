Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4624FDE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHXMcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 08:32:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXMcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:32:53 -0400
Date:   Mon, 24 Aug 2020 14:32:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598272369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr6lUHBkLuLxAPZNmigB/IH+DYgyFTNeFwwb/3iSrGU=;
        b=E6ZKWqWp00DLUq6qhieA0ftDeXWlXvoGZp+Ms2MXHBT9cykq4O2bVe1ZFTAFq+xhHIxbsE
        4RTPpH8VY8i3Y4neiCBBTEYGypzpAK8ZaZUwkCLV0s01pohlTwnP+vQ5gn1tZamJ7vj7XZ
        kFVmie62X2ToAlH+1Gqgu8S+CVN1vh+G6KuvzzA+PWF70quvEDHYJHfvBTk6i7VusoHRTA
        EGO3YcAgdG2j0mrmdppr9UEUK3GqgRHSFSo8SI0VrKUncAxostzkcwu90gHOChanM4PaT8
        GTZu/XBUDc2UNlOqRKpQJ+P3gbxXV/yUfOT1dfwN6I8EDnorpJ9ZP2uTAHiTwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598272369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr6lUHBkLuLxAPZNmigB/IH+DYgyFTNeFwwb/3iSrGU=;
        b=SvhkcAV3b9DAe/L8n9ay7Sewgu+Z90tVOc5pxatliy7JT9kFlC2JIzVvEZY4GbOBMnBC9g
        Dnxts6GdoyqYGMAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20200824123247.finquufqpr6i7umb@linutronix.de>
References: <20200822014018.913868-1-lokeshgidra@google.com>
 <20200822014018.913868-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200822014018.913868-2-lokeshgidra@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-08-21 18:40:17 [-0700], Lokesh Gidra wrote:
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  
>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	static const int uffd_flags = UFFD_USER_MODE_ONLY;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
Why?

Sebastian
