Return-Path: <linux-fsdevel+bounces-66470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836BC2037F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7086403EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F27285042;
	Thu, 30 Oct 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGGLPi0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E82DE71A;
	Thu, 30 Oct 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830587; cv=none; b=gw3LwRvoR+G2qsb1xRr3YhqQuV/7IP1A5saxCdy8K0nkPWzxy9iGdY3H2+1oZdfRHTnjsi6wJZvfMGutOA0tS5NWDTZK2u+DSIHgAFou+Gm3J2oHBZAXjK63+ccaKH7NK4b4oeRv4W8/r5eM0Hya8rAQBw9hYTEAP+x2hyobIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830587; c=relaxed/simple;
	bh=Gwj/eP0Azj/+Fhb2IdX59uBZbrbTocsS6hJCH0RirAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOlqoj6tPrKEBFUTSrnkj5dx3OWVf41swy6z3FGSQSEMUtdiGG9Alj8739ntIEXz736WDwhZ4KBjnBIhA5ip5pmW2g8reVCrAV+jUQzo4r6i1oxeSFZfypgqQ+PO2fiHF7lY1S0p7q0BccxFiPWkjtLqdJDUkwl4YvjsqmdHVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGGLPi0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32136C4CEFF;
	Thu, 30 Oct 2025 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761830586;
	bh=Gwj/eP0Azj/+Fhb2IdX59uBZbrbTocsS6hJCH0RirAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGGLPi0yM5LWkgN61LGvqflN1Mt1ZMc6YtT+w7e+khB4MrY2AtjBA7AiuJQem6s5K
	 c2ZCeC9XKlGWNV4HHx8T9/yYoRQDUS65erYeky9iASxJWenGJmsyrSN33+S+0UQnUU
	 0mnN4VC2Q0EJ2LMJ2rHLEPu9CKJ3xXgALhiF/qJ8iKl75XLsmdNjaKunSFdm1P3o7q
	 R7pSnaEMdnaCplNGSyho1BDAfEPI3+sJCLXutitnKYpZUkj03I/SWjF27yexBZd0sg
	 TKvDoBoc509Ko20+Ry59YzgrXQjRosKg5IPKaPuPOWirG7s/yJ6UAd9Lcq1ejQxm3n
	 e0xp5Ep3V2X1w==
Date: Thu, 30 Oct 2025 14:23:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Subject: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
 <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029233057.GA3441561@ax162>

On Wed, Oct 29, 2025 at 04:30:57PM -0700, Nathan Chancellor wrote:
> On Thu, Oct 30, 2025 at 12:13:11AM +0100, Christian Brauner wrote:
> > I'm fine either way. @Nathan, if you just want to give Linus the patch
> > if it's small enough or just want to give me a stable branch I can pull
> > I'll be content. Thanks!
> 
> I do not care either way but I created a shared branch/tag since it was
> easy enough to do. If Linus wants to take these directly for -rc4, I am
> fine with that as well.
> 
> Cheers,
> Nathan
> 
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-ms-extensions-6.19

Thanks, I pulled this and placed it into a branch that I can base other
branches on.

_But_, I'm already running into problems. :)

I'm changing a struct ns_common in ns_common.h (struct ns_common) and
wanted to make use of the fms extensions. ns_common.h is heavily
included by virtue of the namespace stuff. So we get an include chain
like the following:

In file included from ./include/linux/cgroup.h:23,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/asm-generic/tlb.h:15,
                 from ./arch/x86/include/asm/tlb.h:8,
                 from ./arch/x86/include/asm/efi.h:7,
                 from drivers/firmware/efi/libstub/x86-stub.c:13:
./include/linux/ns_common.h:132:31: error: declaration does not declare anything [-Werror]
  132 |                 struct ns_tree;
      |                               ^
./include/linux/ns_common.h: In function '__ns_ref_active_read':
./include/linux/ns_common.h:228:31: error: 'const struct ns_common' has no member named '__ns_ref_active'
  228 |         return atomic_read(&ns->__ns_ref_active);
      |                               ^~
In file included from ./arch/x86/include/asm/bug.h:108,
                 from ./arch/x86/include/asm/alternative.h:9,
                 from ./arch/x86/include/asm/segment.h:6,
                 from ./arch/x86/include/asm/ptrace.h:5,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:13,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/efi.h:17,
                 from drivers/firmware/efi/libstub/x86-stub.c:9:

Because struct cgroup_namespace embeddds struct ns_common and it
proliferates via mm stuff into the efi code.

So the EFI cod has it's own KBUILD_CFLAGS. It does:

# non-x86 reuses KBUILD_CFLAGS, x86 does not
cflags-y			:= $(KBUILD_CFLAGS)

<snip>

KBUILD_CFLAGS			:= $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
				   -Os -DDISABLE_BRANCH_PROFILING \
				   -include $(srctree)/include/linux/hidden.h \
				   -D__NO_FORTIFY \
				   -ffreestanding \
				   -fno-stack-protector \
				   $(call cc-option,-fno-addrsig) \
				   -D__DISABLE_EXPORTS

which means x86 doesn't get -fms-extension breaking the build. If I
manually insert:

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 94b05e4451dd..4ad2f8f42134 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -42,6 +42,8 @@ KBUILD_CFLAGS                 := $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
                                   -ffreestanding \
                                   -fno-stack-protector \
                                   $(call cc-option,-fno-addrsig) \
+                                  -fms-extensions \
+                                  -Wno-microsoft-anon-tag \
                                   -D__DISABLE_EXPORTS

The build works...

I think we need to decide how to fix this now because as soon as someone
makes use of the extension that is indirectly included by that libstub
thing we're fscked.

