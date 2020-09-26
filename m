Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D046279A87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgIZPzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZPzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 11:55:06 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A25C0613CE;
        Sat, 26 Sep 2020 08:55:06 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cr8so3074011qvb.10;
        Sat, 26 Sep 2020 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9K+TORI1qzRkLGrmcb8ynRXJgkPPOWq5NVEpME43Yt0=;
        b=DUBA2qNrcI62cN5SQKIfv4SMlznZeSGX1APD1Z6GvGlZWsGRrmUjq3uBadgEJErWBu
         zqpNK/U3O1V+njEbNCndeHQ7rld7GORTIYOijvJ82Ouq7Ziw+vvmmPDvF8fOR5eLm0H2
         5d/t92sr2C0UYwYYRVrOfhMN330RHnf6Z4aHyd6LhtdseZInb/ClO5LDp63lTdoUl+eT
         25p2sxuemk0CMSERnc2jUNIT5S8m+LmRMSIbXjCWsAevDaxm1CmBSm+8jq/aX8ANG01v
         sLr8mJNPkiFoOaJSHZ0X5OvIw0kFFYHUMrFLidYgNS5OivgrGaGrvIYGIBl4C4/ui5t6
         jV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9K+TORI1qzRkLGrmcb8ynRXJgkPPOWq5NVEpME43Yt0=;
        b=SmE6k9ZNT9ddq6JKTffEKPzsX2wZxwKjjwd5t4QO5glwGYxIRYSNuDal9HhteYP+PW
         LtLzU7Ie4FQGVg2SbjOW0U7TcTwgAT0awLCVHo4pb27uXH8RTgOxsOWv24yfvSD5lR1N
         T0YmwXvc+uBd0LisWIh66Uu3zjUavvXKjWkY5NPDVj+PJMbjjjl62I7ntPdGM8Iz/2P6
         jtDe6b7KINRVJ2B6xSLbNQTM3Zba/Uf0V3nxZ6SjlgqO7kQvpGxvIR9PYWqs8njVbUmo
         OMYOaewp0Mze/xUWkLdLyqt5n7WvHD4jWIN1AGfwAMT/QJXCXtZSUtTzT/MZAQX+Ucxk
         XtvA==
X-Gm-Message-State: AOAM530ayWMw6KK2pf2ILWD+pJAUop9ZUW2xCgJn5d6RPvTXyHK0xdxR
        lxEgikAhgOC8TVjW/HgnaLc=
X-Google-Smtp-Source: ABdhPJxfGgdFSQrEPU0DSDPMe2uIJ2q1rjb46XTTNZ8JMpjLFcZXIvIzBDa4vnln1Ydvdliysqgn2g==
X-Received: by 2002:a05:6214:a03:: with SMTP id dw3mr3963031qvb.44.1601135705190;
        Sat, 26 Sep 2020 08:55:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p29sm4635341qtu.68.2020.09.26.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 08:55:04 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 26 Sep 2020 11:55:02 -0400
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
Message-ID: <20200926155502.GA930344@rani.riverdale.lan>
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
 <20200923091125.GB1240819@rani.riverdale.lan>
 <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
 <20200923195147.GA1358246@rani.riverdale.lan>
 <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
 <20200924234347.GA341645@rani.riverdale.lan>
 <b9dfeea3-a36d-5b60-a37b-409363b39ffd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9dfeea3-a36d-5b60-a37b-409363b39ffd@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:44:56PM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 9/24/20 6:43 PM, Arvind Sankar wrote:
> > 
> > The source PC will generally not be available if the compiler decided to
> > tail-call optimize the call to the trampoline into a jump.
> > 
> 
> This is still work in progress. But I am thinking that labels can be used.
> So, if the code is:
> 
> 	invoke_tramp:
> 		(*tramp)();
> 
> then, invoke_tramp can be supplied as the calling PC.
> 
> Similarly, labels can be used in assembly functions as well.
> 
> Like I said, I have to think about this more.

What I mean is that the kernel won't have access to the actual source
PC. If I followed your v1 correctly, it works by making any branch to
the trampoline code trigger a page fault. At this point, the PC has
already been updated to the trampoline entry, so the only thing the
fault handler can know is the return address on the top of the stack,
which (a) might not be where the branch actually originated, either
because it was a jump, or you've already been hacked and you got here
using a ret; (b) is available to userspace anyway.

> 
> > What's special about these trampolines anyway? Any indirect function
> > call could have these same problems -- an attacker could have
> > overwritten the pointer the same way, whether it's supposed to point to
> > a normal function or it is the target of this trampoline.
> > 
> > For making them a bit safer, userspace could just map the page holding
> > the data pointers/destination address(es) as read-only after
> > initialization.
> > 
> 
> You need to look at version 1 of trampfd for how to do "allowed pcs".
> As an example, libffi defines ABI handlers for every arch-ABI combo.
> These ABI handler pointers could be placed in an array in .rodata.
> Then, the array can be written into trampfd for setting allowed PCS.
> When the target PC is set for a trampoline, the kernel will check
> it against allowed PCs and reject it if it has been overwritten.

I'm not asking how it's implemented. I'm asking what's the point? On a
typical linux system, at least on x86, every library function call is an
indirect branch. The protection they get is that the dynamic linker can
map the pointer table read-only after initializing it.

For the RO mapping, libffi could be mapping both the entire closure
structure, as well as the structure that describes the arguments and
return types of the function, read-only once they are initialized.

For libffi, there are three indirect branches for every trampoline call
with your suggested trampoline: one to get to the trampoline, one to
jump to the handler, and one to call the actual user function. If we are
particularly concerned about the trampoline to handler branch for some
reason, we could just replace it with a direct branch: if the kernel was
generating the code, there's no reason to allow the data pointer or code
target to be changed after the trampoline was created. It can just
hard-code them in the generated code and be done with it. Even with
user-space trampolines, you can use a direct call. All you need is
libffi-trampoline.so which contains a few thousand trampolines all
jumping to one handler, which then decides what to do based on which
trampoline was called. Sure libffi currently dispatches to one of 2-3
handlers based on the ABI, but there's no technical reason it couldn't
dispatch to just one that handled all the ABIs, and the trampoline could
be boiled down to just:
	endbr
	call handler
	ret

> >>
> >> In order to address the FFI_REGISTER ABI in libffi, we could use the secure
> >> trampoline. In FFI_REGISTER, the data is pushed on the stack and the code
> >> is jumped to without using any registers.
> >>
> >> As outlined in version 1, the kernel can push the data address on the stack
> >> and write the code address into the PC and return to userland.
> >>
> >> For doing all of this, we need trampfd.
> > 
> > We don't need this for FFI_REGISTER. I presented a solution that works
> > in userspace. Even if you want to use a trampoline created by the
> > kernel, there's no reason it needs to trap into the kernel at trampoline
> > execution time. libffi's trampolines already handle this case today.
> > 
> 
> libffi handles this using user level dynamic code which needs to be executed.
> If the security subsystem prevents that, then the dynamic code cannot execute.
> That is the whole point of this RFC.

/If/ you are using a trampoline created by the kernel, it can just
create the one that libffi is using today; which doesn't need trapping
into the kernel at execution time.

And if you aren't, you can use the trampoline I wrote, which has no
dynamic code, and doesn't need to trap into the kernel at execution time
either.

> 
> >>
> >> Permitting the use of trampfd
> >> -----------------------------
> >>
> >> An "exectramp" setting can be implemented in SELinux to selectively allow the
> >> use of trampfd for applications.
> >>
> >> Madhavan
> > 
> > Applications can use their own userspace trampolines regardless of this
> > setting, so it doesn't provide any additional security benefit by
> > preventing usage of trampfd.
> > 
> 
> The background for all of this is that dynamic code such as trampolines
> need to be placed in a page with executable permissions so they can
> execute. If security measures such as W^X are present, this will not
> be possible. Admitted, today some user level tricks exist to get around
> W^X. I have alluded to those. IMO, they are all security holes and will
> get plugged sooner or later. Then, these trampolines cannot execute.
> Currently, there exist security exceptions such as execmem to let them
> execute. But we would like to do it without making security exceptions.
> 
> Madhavan

How can you still say this after this whole discussion? Applications can
get the exact same functionality as your proposed trampfd using static
code, no W^X tricks needed.

This only matters if you have a trampfd that generates _truly_ dynamic
code, not just code that can be trivially made static.
