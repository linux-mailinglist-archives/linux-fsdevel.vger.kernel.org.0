Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402822B59BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 07:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKQG0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 01:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgKQG0s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:26:48 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA86E20855;
        Tue, 17 Nov 2020 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605594406;
        bh=ie0VlDH/vj4hY7eKDBRc8yNlYb8JMMI+sECKmsJ0SAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZ37+aP7qsQAQGaQgrviuuTES+oK/KF+aENGZoDR9HzBV3Jaqk/mPUi4s8TouHZcb
         Gxna9F5Fo/vt3rqRFavtJK/inbQFHR4ChVg6L8bs7emdbKfZ/wDPWS7H2oALG9KgBR
         199CMDQwY+Gu5iEF24GqZcZyZFpnnDE7wlV7JG9Y=
Date:   Tue, 17 Nov 2020 08:26:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     mtk.manpages@gmail.com, Mike Rapoport <rppt@linux.ibm.com>,
        akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, colomar.6.4.3@gmail.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com,
        idan.yaniv@ibm.com, jejb@linux.ibm.com, kirill@shutemov.name,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org, shuah@kernel.org,
        tglx@linutronix.de, tycho@tycho.ws, viro@zeniv.linux.org.uk,
        will@kernel.org, willy@infradead.org, x86@kernel.org
Subject: Re: [PATCH v2] memfd_secret.2: New page describing memfd_secret()
 system call
Message-ID: <20201117062630.GC370813@kernel.org>
References: <20201005073242.GA4251@kernel.org>
 <20201116210136.12390-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116210136.12390-1-alx.manpages@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:01:37PM +0100, Alejandro Colomar wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cowritten-by: Alejandro Colomar <alx.manpages@gmail.com>
> Acked-by: Alejandro Colomar <alx.manpages@gmail.com>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> Hi Mike,
> 
> I added that note about not having a wrapper,
> fixed a few minor formatting and wording issues,
> and sorted ERRORS alphabetically.

Thanks, Alejandro!

> Cheers,
> 
> Alex
> 
>  man2/memfd_secret.2 | 178 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 man2/memfd_secret.2
> 
> diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
> new file mode 100644
> index 000000000..4e617aa0e
> --- /dev/null
> +++ b/man2/memfd_secret.2
> @@ -0,0 +1,178 @@
> +.\" Copyright (c) 2020, IBM Corporation.
> +.\" Written by Mike Rapoport <rppt@linux.ibm.com>
> +.\"
> +.\" Based on memfd_create(2) man page
> +.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
> +.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
> +.\"
> +.\" %%%LICENSE_START(GPLv2+)
> +.\"
> +.\" This program is free software; you can redistribute it and/or modify
> +.\" it under the terms of the GNU General Public License as published by
> +.\" the Free Software Foundation; either version 2 of the License, or
> +.\" (at your option) any later version.
> +.\"
> +.\" This program is distributed in the hope that it will be useful,
> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +.\" GNU General Public License for more details.
> +.\"
> +.\" You should have received a copy of the GNU General Public
> +.\" License along with this manual; if not, see
> +.\" <http://www.gnu.org/licenses/>.
> +.\" %%%LICENSE_END
> +.\"
> +.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
> +.SH NAME
> +memfd_secret \- create an anonymous file to map secret memory regions
> +.SH SYNOPSIS
> +.nf
> +.B #include <linux/secretmem.h>
> +.PP
> +.BI "int memfd_secret(unsigned long " flags ");"
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call; see NOTES.
> +.SH DESCRIPTION
> +.BR memfd_secret ()
> +creates an anonymous file and returns a file descriptor that refers to it.
> +The file can only be memory-mapped;
> +the memory in such mapping
> +will have stronger protection than usual memory mapped files,
> +and so it can be used to store application secrets.
> +Unlike a regular file, a file created with
> +.BR memfd_secret ()
> +lives in RAM and has a volatile backing storage.
> +Once all references to the file are dropped, it is automatically released.
> +The initial size of the file is set to 0.
> +Following the call, the file size should be set using
> +.BR ftruncate (2).
> +.PP
> +The memory areas obtained with
> +.BR mmap (2)
> +from the file descriptor are exclusive to the owning context.
> +These areas are removed from the kernel page tables
> +and only the page table of the process holding the file descriptor
> +maps the corresponding physical memory.
> +.PP
> +The following values may be bitwise ORed in
> +.IR flags
> +to control the behavior of
> +.BR memfd_secret (2):
> +.TP
> +.BR FD_CLOEXEC
> +Set the close-on-exec flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.PP
> +.TP
> +.BR SECRETMEM_UNCACHED
> +In addition to excluding memory areas from the kernel page tables,
> +mark the memory mappings uncached in the page table of the owning process.
> +Such mappings can be used to prevent speculative loads
> +and cache-based side channels.
> +This mode of
> +.BR memfd_secret ()
> +is not supported on all architectures.
> +.PP
> +See also NOTES below.
> +.PP
> +As its return value,
> +.BR memfd_secret ()
> +returns a new file descriptor that can be used to refer to an anonymous file.
> +This file descriptor is opened for both reading and writing
> +.RB ( O_RDWR )
> +and
> +.B O_LARGEFILE
> +is set for the file descriptor.
> +.PP
> +With respect to
> +.BR fork (2)
> +and
> +.BR execve (2),
> +the usual semantics apply for the file descriptor created by
> +.BR memfd_secret ().
> +A copy of the file descriptor is inherited by the child produced by
> +.BR fork (2)
> +and refers to the same file.
> +The file descriptor is preserved across
> +.BR execve (2),
> +unless the close-on-exec flag has been set.
> +.PP
> +The memory regions backed with
> +.BR memfd_secret ()
> +are locked in the same way as
> +.BR mlock (2),
> +however the implementation will not try to
> +populate the whole range during the
> +.BR mmap ()
> +call.
> +The amount of memory allowed for memory mappings
> +of the file descriptor obeys the same rules as
> +.BR mlock (2)
> +and cannot exceed
> +.BR RLIMIT_MEMLOCK .
> +.SH RETURN VALUE
> +On success,
> +.BR memfd_secret ()
> +returns a new file descriptor.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EINVAL
> +.I flags
> +included unknown bits.
> +.TP
> +.B EMFILE
> +The per-process limit on the number of open file descriptors has been reached.
> +.TP
> +.B EMFILE
> +The system-wide limit on the total number of open files has been reached.
> +.TP
> +.B ENOMEM
> +There was insufficient memory to create a new anonymous file.
> +.TP
> +.B ENOSYS
> +.BR memfd_secret ()
> +is not implemented on this architecture.
> +.SH VERSIONS
> +The
> +.BR memfd_secret (2)
> +system call first appeared in Linux 5.X;
> +.SH CONFORMING TO
> +The
> +.BR memfd_secret (2)
> +system call is Linux-specific.
> +.SH NOTES
> +The
> +.BR memfd_secret (2)
> +system call provides an ability to hide information
> +from the operating system.
> +Normally Linux userspace mappings are protected from other users,
> +but they are visible to privileged code.
> +The mappings created using
> +.BR memfd_secret ()
> +are hidden from the kernel as well.
> +.PP
> +If an architecture supports
> +.BR SECRETMEM_UNCACHED ,
> +the mappings also have protection from speculative execution vulnerabilties,
> +at the expense of increased memory access latency.
> +Care should be taken when using
> +.B SECRETMEM_UNCACHED
> +to avoid degrading application performance.
> +.PP
> +Glibc does not provide a wrapper for this system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR fcntl (2),
> +.BR ftruncate (2),
> +.BR mlock (2),
> +.BR mmap (2),
> +.BR setrlimit (2)
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
