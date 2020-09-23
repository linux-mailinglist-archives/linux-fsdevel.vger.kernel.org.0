Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F62274EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIWBqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIWBqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:46:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D437C061755;
        Tue, 22 Sep 2020 18:46:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so10608530qvp.6;
        Tue, 22 Sep 2020 18:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ssYhrlHCw7Ub9xPyJrNfDQfuZKnG7yNmanf9qk5D/30=;
        b=uhilotA2RIu/i3TSt6riD62hHewNX0HCYmMAm6Yecx7s6wLqAfVdwPC94TV27TBtq4
         +0q0YajK8JyGTHcprchBDFv2ayV59vk0oXGyJlBiFXIqPW4j7qGv0v4IRsopqpngRSr1
         Sy4HfLiaqVt6AkHeytLRBjGlCNtInHzH2aFM4TGr3Pn3QrgB/tRSBLBkE+o0ihGxfUiX
         dhbC8CXns3F1amdB7aenJ/Cxc4yWDSvifq4ZHXkuT03S+tFjT5yxE/eAMet3CHs3A7Hk
         OXdUPZQvllLZfjnidcNs42c0LsQ0538v8PzsgpNJMClW1XGO0YSC62irz5h/fviXUgUI
         YbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ssYhrlHCw7Ub9xPyJrNfDQfuZKnG7yNmanf9qk5D/30=;
        b=N3H6UYz/F43n73Oq3O6ceVIQmEvcsb4CmiFo8SgdK18Dd+qlW/5d46j6nUf38Ld3ef
         8kAmw1PTEsB2Xpc6jrLTrkrvDHgtbC1O+bAjpPspQo+z9IIfS8kqcmcDO4xc23QKT4/n
         WCkpTZne7dBxteu9ByhBJbeifBXJEtCeMtAe98Zw0W5Tr/n8DykBZu6GXLFCdk6nsXo4
         q4nquK6gJ0wayAJFmFlFtWx6fqooOBiWpupTxK/Fj2kTdHH3QmklhNoVkR8h/rpbGvMJ
         4XMslm1g7dEbD4ZGEsAGCE11AtWJeIo2PfssdELOpd4Z1Cu5LGtG3tWYXBBWNKnA9Afl
         Yq5w==
X-Gm-Message-State: AOAM533WRUwqBoOaNYmGnSDwKK7yFFE2Q21an85szWr1zPTeSaCTdyS0
        66xRKz+45aUeHEPY/SZ18y3CQJthSgg=
X-Google-Smtp-Source: ABdhPJx+f5G7LH8pGHaNrTcMRrb4zK95unM48fxm9EqaXus2Z/Ijl+3SuFhTwPqbe2UA1MqvfJS/1Q==
X-Received: by 2002:a0c:cdc4:: with SMTP id a4mr9110819qvn.31.1600825579406;
        Tue, 22 Sep 2020 18:46:19 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g4sm13248370qth.30.2020.09.22.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:46:18 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 22 Sep 2020 21:46:16 -0400
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923014616.GA1216401@rani.riverdale.lan>
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:36:02AM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 9/16/20 8:04 PM, Florian Weimer wrote:
> > * madvenka:
> > 
> >> Examples of trampolines
> >> =======================
> >>
> >> libffi (A Portable Foreign Function Interface Library):
> >>
> >> libffi allows a user to define functions with an arbitrary list of
> >> arguments and return value through a feature called "Closures".
> >> Closures use trampolines to jump to ABI handlers that handle calling
> >> conventions and call a target function. libffi is used by a lot
> >> of different applications. To name a few:
> >>
> >> 	- Python
> >> 	- Java
> >> 	- Javascript
> >> 	- Ruby FFI
> >> 	- Lisp
> >> 	- Objective C
> > 
> > libffi does not actually need this.  It currently collocates
> > trampolines and the data they need on the same page, but that's
> > actually unecessary.  It's possible to avoid doing this just by
> > changing libffi, without any kernel changes.
> > 
> > I think this has already been done for the iOS port.
> > 
> 
> The trampoline table that has been implemented for the iOS port (MACH)
> is based on PC-relative data referencing. That is, the code and data
> are placed in adjacent pages so that the code can access the data using
> an address relative to the current PC.
> 
> This is an ISA feature that is not supported on all architectures.
> 
> Now, if it is a performance feature, we can include some architectures
> and exclude others. But this is a security feature. IMO, we cannot
> exclude any architecture even if it is a legacy one as long as Linux
> is running on the architecture. So, we need a solution that does
> not assume any specific ISA feature.

Which ISA does not support PIC objects? You mentioned i386 below, but
i386 does support them, it just needs to copy the PC into a GPR first
(see below).

> 
> >> The code for trampoline X in the trampoline table is:
> >>
> >> 	load	&code_table[X], code_reg
> >> 	load	(code_reg), code_reg
> >> 	load	&data_table[X], data_reg
> >> 	load	(data_reg), data_reg
> >> 	jump	code_reg
> >>
> >> The addresses &code_table[X] and &data_table[X] are baked into the
> >> trampoline code. So, PC-relative data references are not needed. The user
> >> can modify code_table[X] and data_table[X] dynamically.
> > 
> > You can put this code into the libffi shared object and map it from
> > there, just like the rest of the libffi code.  To get more
> > trampolines, you can map the page containing the trampolines multiple
> > times, each instance preceded by a separate data page with the control
> > information.
> > 
> 
> If you put the code in the libffi shared object, how do you pass data to
> the code at runtime? If the code we are talking about is a function, then
> there is an ABI defined way to pass data to the function. But if the
> code we are talking about is some arbitrary code such as a trampoline,
> there is no ABI defined way to pass data to it except in a couple of
> platforms such as HP PA-RISC that have support for function descriptors
> in the ABI itself.
> 
> As mentioned before, if the ISA supports PC-relative data references
> (e.g., X86 64-bit platforms support RIP-relative data references)
> then we can pass data to that code by placing the code and data in
> adjacent pages. So, you can implement the trampoline table for X64.
> i386 does not support it.
> 

i386 just needs a tiny bit of code to copy the PC into a GPR first, i.e.
the trampoline would be:

	call	1f
1:	pop	%data_reg
	movl	(code_table + X - 1b)(%data_reg), %code_reg
	movl	(data_table + X - 1b)(%data_reg), %data_reg
	jmp	*(%code_reg)

I do not understand the point about passing data at runtime. This
trampoline is to achieve exactly that, no? 

Thanks.
