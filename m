Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA627541B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIWJL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWJL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:11:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC42C0613CE;
        Wed, 23 Sep 2020 02:11:29 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so22094903qki.6;
        Wed, 23 Sep 2020 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vw57DoHZqWXx4xymzlnY2cv6nwjJilOmIUjotMaIXOw=;
        b=uGmOF57rr5ir3wAdlX8DbJUFQYeCyGRLwVLuZTKa/TMGKjwtHBeLRN092fsFJUBqBb
         SuUoCfSgVnnf4GLR7NZk09ipWP0t8tVVjaVv9fHjmkv+JNJNLFoaXROJ3JiqOMI+g7JI
         Cgu3TjFR+V/A2os/3tbtCaxBg8kG7KQuCFnlilzzDSPL2NjtzNsZqzJ694Gm63tCBOwM
         /sxKPIq+AzxrUpe0jfLXVERIDkSsHRDS+7YmD5oIK+G2hQPc0rcBC0JreyEHXYhuGtKs
         +edxK73xkevQqkuE+tXmnoaTeJNLfjsBQzEEG+Qpm98ZPXCiVlYr+n8Uq3H15ZH+f6pw
         noSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Vw57DoHZqWXx4xymzlnY2cv6nwjJilOmIUjotMaIXOw=;
        b=ViwBecK+R+Fi7fcp0+FYDRUMMSPXHVy+bZLpjYm1tQmnZaBrPu25MdZGu+bStO3ruh
         T/ILH721HLqJURl8OTOne5XaBUZwQbkPRuxU/GiSM8hI3rpNU5t4VUXaTtHneJtK6RJG
         xQn+U8dLzkGW7vE1T5ex4GUDTIcXxAjMgPJhMNVOVbXTsKti9PpuM0o1d5Y+hZQBaaL2
         Vk+pIw7DkvrxpBVcrZXcrQ3QDfHPcznFszGZWsJOaLsawyPlRBZVlMdSUX470uIz8J/b
         pfypqRegA0nsQ5lHwmHB8cvcd+G1/jrVVGIO5f5LzstxDmYl8yzFCWH98cQMVIcay6vn
         MFbQ==
X-Gm-Message-State: AOAM530fNjZWh2eC6oxQjD/a3dXsj7IYZh3ziUsp3twx3eOUl3gcTjCx
        mF7IvdH7DhUFxzzX6AFTMC1TaMsUpCs=
X-Google-Smtp-Source: ABdhPJz8KuC6aUCmaAzrq7TnqiwL4nJshKmmil9Y7NRnJ5NrQuLaaXEQ3bxRj/TVJoC2K9hOXX24yQ==
X-Received: by 2002:a05:620a:4fb:: with SMTP id b27mr9342851qkh.120.1600852288175;
        Wed, 23 Sep 2020 02:11:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z133sm13528802qka.3.2020.09.23.02.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:11:27 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 23 Sep 2020 05:11:25 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
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
Message-ID: <20200923091125.GB1240819@rani.riverdale.lan>
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923014616.GA1216401@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:46:16PM -0400, Arvind Sankar wrote:
> On Thu, Sep 17, 2020 at 10:36:02AM -0500, Madhavan T. Venkataraman wrote:
> > 
> > 
> > On 9/16/20 8:04 PM, Florian Weimer wrote:
> > > * madvenka:
> > > 
> > >> Examples of trampolines
> > >> =======================
> > >>
> > >> libffi (A Portable Foreign Function Interface Library):
> > >>
> > >> libffi allows a user to define functions with an arbitrary list of
> > >> arguments and return value through a feature called "Closures".
> > >> Closures use trampolines to jump to ABI handlers that handle calling
> > >> conventions and call a target function. libffi is used by a lot
> > >> of different applications. To name a few:
> > >>
> > >> 	- Python
> > >> 	- Java
> > >> 	- Javascript
> > >> 	- Ruby FFI
> > >> 	- Lisp
> > >> 	- Objective C
> > > 
> > > libffi does not actually need this.  It currently collocates
> > > trampolines and the data they need on the same page, but that's
> > > actually unecessary.  It's possible to avoid doing this just by
> > > changing libffi, without any kernel changes.
> > > 
> > > I think this has already been done for the iOS port.
> > > 
> > 
> > The trampoline table that has been implemented for the iOS port (MACH)
> > is based on PC-relative data referencing. That is, the code and data
> > are placed in adjacent pages so that the code can access the data using
> > an address relative to the current PC.
> > 
> > This is an ISA feature that is not supported on all architectures.
> > 
> > Now, if it is a performance feature, we can include some architectures
> > and exclude others. But this is a security feature. IMO, we cannot
> > exclude any architecture even if it is a legacy one as long as Linux
> > is running on the architecture. So, we need a solution that does
> > not assume any specific ISA feature.
> 
> Which ISA does not support PIC objects? You mentioned i386 below, but
> i386 does support them, it just needs to copy the PC into a GPR first
> (see below).
> 
> > 
> > >> The code for trampoline X in the trampoline table is:
> > >>
> > >> 	load	&code_table[X], code_reg
> > >> 	load	(code_reg), code_reg
> > >> 	load	&data_table[X], data_reg
> > >> 	load	(data_reg), data_reg
> > >> 	jump	code_reg
> > >>
> > >> The addresses &code_table[X] and &data_table[X] are baked into the
> > >> trampoline code. So, PC-relative data references are not needed. The user
> > >> can modify code_table[X] and data_table[X] dynamically.
> > > 
> > > You can put this code into the libffi shared object and map it from
> > > there, just like the rest of the libffi code.  To get more
> > > trampolines, you can map the page containing the trampolines multiple
> > > times, each instance preceded by a separate data page with the control
> > > information.
> > > 
> > 
> > If you put the code in the libffi shared object, how do you pass data to
> > the code at runtime? If the code we are talking about is a function, then
> > there is an ABI defined way to pass data to the function. But if the
> > code we are talking about is some arbitrary code such as a trampoline,
> > there is no ABI defined way to pass data to it except in a couple of
> > platforms such as HP PA-RISC that have support for function descriptors
> > in the ABI itself.
> > 
> > As mentioned before, if the ISA supports PC-relative data references
> > (e.g., X86 64-bit platforms support RIP-relative data references)
> > then we can pass data to that code by placing the code and data in
> > adjacent pages. So, you can implement the trampoline table for X64.
> > i386 does not support it.
> > 
> 
> i386 just needs a tiny bit of code to copy the PC into a GPR first, i.e.
> the trampoline would be:
> 
> 	call	1f
> 1:	pop	%data_reg
> 	movl	(code_table + X - 1b)(%data_reg), %code_reg
> 	movl	(data_table + X - 1b)(%data_reg), %data_reg
> 	jmp	*(%code_reg)
> 
> I do not understand the point about passing data at runtime. This
> trampoline is to achieve exactly that, no? 
> 
> Thanks.

For libffi, I think the proposed standard trampoline won't actually
work, because not all ABIs have two scratch registers available to use
as code_reg and data_reg. Eg i386 fastcall only has one, and register
has zero scratch registers. I believe 32-bit ARM only has one scratch
register as well.

For i386 you'd need something that saves a register on the stack first,
maybe like the below with a 16-byte trampoline and a 16-byte context
structure that has the address of the code to jump to in the first
dword:

	.balign 4096
	trampoline_page:

	.rept	4096/16-1
	0:	endbr32
		push	%eax
		call	__x86.get_pc_thunk.ax
	1:	jmp	trampoline
	.balign 16
	.endr

	.org trampoline_page + 4096 - 16
	__x86.get_pc_thunk.ax:
		movl	(%esp), %eax
		ret
	trampoline:
		subl	$(1b-0b), %eax
		jmp	*(table-trampoline_page)(%eax)

	.org trampoline_page + 4096
	table:
