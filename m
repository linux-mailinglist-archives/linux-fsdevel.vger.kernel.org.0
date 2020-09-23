Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAF276167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgIWTvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:51:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC40C0613CE;
        Wed, 23 Sep 2020 12:51:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so934352qtv.12;
        Wed, 23 Sep 2020 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/pUtqEAd6FaTDCf00ujMgUqqETSXfPhUeGuKchWXUs=;
        b=YDuXTVEPUbAJafRqh/dypmyCmOtqDZ2dqQKZplay/eHegdSKIEI9B7GFZydCeewdM1
         F4y82sJPZZrXoXdu89i+v9LgMLfLO5dWf9qfjvTSJyJaARNyPQcUnI/xdfnZWaIeip+4
         IuGNV9+2rBKAd87bd/oKTVle2Y16/7RrJZgWLHmEvSY4vKB5y+il7B34hPUS0X/6OpZd
         gOmpExT9thdKpwF+eJKIOgmu/jncp8hF7T//iMWu+dOFW7m+WSZH5yMLDv/wBjTEAMW1
         XU3qN/29UsHna8AFr4iVe8VMhv03zG+KI/2MhWWWHNBqTHY70yRtXnOJOsK722s1fruS
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K/pUtqEAd6FaTDCf00ujMgUqqETSXfPhUeGuKchWXUs=;
        b=FqTUVIcnSTpBn2jRknUJBqwWDa7kgmy/e9P8FrbHNcbnj3pKaUdXUWXwlbk/cQTkQt
         4wvi4JzM4cnifS1SzPIGxbPCloPdWfDeuPSUuzy2cn7o2bsONjcJlEQTPTsywAkJo0Nc
         SfuXxJFXhzUp7OG4HuDrZbC1EJcAJNIoz0sLM7odXeI11esrCWJ+9jSEaWxG1vVx5aPS
         TVv5zlICC72qnDUBq97ImuA5v/RLwMI+In5Oy6e+SKaMg/5PGQgP+APkpm14x/3bhCCN
         CuDn6MiREkriwhiaFjrIMjKGbhhUml7+oEhvhnFwi2lTP4KYhRS2ko/3Nd1j5n2AlhUC
         I7rQ==
X-Gm-Message-State: AOAM530mX86XLxgLngrOA0pHdZ0W2VDHyl0giCHHTA8g3MrbgpbhJGFi
        whVejSG3rCjOpA86dsyrpeTc6lVeodY=
X-Google-Smtp-Source: ABdhPJzjUTxogU34ItSMJ0OdmM63Q03/ic99kwSF7ETgPXeMzfaQhO5sAjfKzolXALvtzOWcxGlwDw==
X-Received: by 2002:ac8:5d43:: with SMTP id g3mr1813055qtx.295.1600890710351;
        Wed, 23 Sep 2020 12:51:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n144sm648905qkn.69.2020.09.23.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 12:51:49 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 23 Sep 2020 15:51:47 -0400
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Florian Weimer <fw@deneb.enyo.de>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923195147.GA1358246@rani.riverdale.lan>
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
 <20200923091125.GB1240819@rani.riverdale.lan>
 <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 02:17:30PM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 9/23/20 4:11 AM, Arvind Sankar wrote:
> > For libffi, I think the proposed standard trampoline won't actually
> > work, because not all ABIs have two scratch registers available to use
> > as code_reg and data_reg. Eg i386 fastcall only has one, and register
> > has zero scratch registers. I believe 32-bit ARM only has one scratch
> > register as well.
> 
> The trampoline is invoked as a function call in the libffi case. Any
> caller saved register can be used as code_reg, can it not? And the
> scratch register is needed only to jump to the code. After that, it
> can be reused for any other purpose.
> 
> However, for ARM, you are quite correct. There is only one scratch
> register. This means that I have to provide two types of trampolines:
> 
> 	- If an architecture has enough scratch registers, use the currently
> 	  defined trampoline.
> 
> 	- If the architecture has only one scratch register, but has PC-relative
> 	  data references, then embed the code address at the bottom of the
> 	  trampoline and access it using PC-relative addressing.
> 
> Thanks for pointing this out.
> 
> Madhavan

libffi is trying to provide closures with non-standard ABIs as well: the
actual user function is standard ABI, but the closure can be called with
a different ABI. If the closure was created with FFI_REGISTER abi, there
are no registers available for the trampoline to use: EAX, EDX and ECX
contain the first three arguments of the function, and every other
register is callee-save.

I provided a sample of the kind of trampoline that would be needed in
this case -- it's position-independent and doesn't clobber any registers
at all, and you get 255 trampolines per page. If I take another 16-byte
slot out of the page for the end trampoline that does the actual work,
I'm sure I could even come up with one that can just call a normal C
function, only the return might need special handling depending on the
return type.

And again, do you actually have any example of an architecture that
cannot run position-independent code? PC-relative addressing is an
implementation detail: the fact that it's available for x86_64 but not
for i386 just makes position-independent code more cumbersome on i386,
but it doesn't make it impossible. For the tiny trampolines here, it
makes almost no difference.
