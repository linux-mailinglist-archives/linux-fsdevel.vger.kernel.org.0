Return-Path: <linux-fsdevel+bounces-37735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DC9F6752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6695D164DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948A1B0423;
	Wed, 18 Dec 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meFJfkHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996617C219;
	Wed, 18 Dec 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528760; cv=none; b=tDEzuWTcGInaCBGQrlqbAW+712DsH28bLkWNlNsjcVLrrc4t4c2ugt+U8+NOk312Ua69KleQXtUTNf38yZZrH4WcM7f/WbS9/5FIy7GvP0BpNphvCe2tK07wr9LKXyrbZCMtrp9n1Nb1DHSHlaP5k+nNB8JfCpdN2EsgwNh8kCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528760; c=relaxed/simple;
	bh=Jjd8N6+2GR2EE6mk+TX/lS/tT1fcxYGZfra8llYttAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4VFWvQNDIZn19N8u1o4vMCZ2jqQdhsVB+49GMjJFle9UWLCSVIqrunVuBfHwEQZw25v8H7aOPbr356QvGdecz2qBttzk97y15zUTnxabKApMtaSJRT74NmPNTQmuGzvINWSbbBNMaEbRjCCwrzAbUb+Qvum2qw9gfr8Qct52YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meFJfkHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B1C4CECE;
	Wed, 18 Dec 2024 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734528759;
	bh=Jjd8N6+2GR2EE6mk+TX/lS/tT1fcxYGZfra8llYttAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meFJfkHlncZeORgh4ABJSYi/Eb/ubsB1THwdqnCUyDwXsEcjHxVuMIVb3Q8D7FynA
	 v+p7qVqWHIqsIJlTYA1HR+lLij0pAwMAf6m+ONPyQ1jRVkuO5Osr4nVMocikGpqs80
	 Z6xMkkkwgg9aG6AloqLFnhAHstKQY/i9r6gCF0bnoV5KGTnnygY2izUQOYYBbprZ2u
	 BC5Rg9r3jQ6rK+07tKyDUZKTLUn4iM87Gggg8LI6OeHKkNqZc9uUkLaEZzIwIwZ+Zu
	 9NnCnk4riSym39JcRIC32KTXx7Qak8FXjOFi2xtz1IKy9dJRDAZ3H/pmzxVoIZ0val
	 voZ2p6yPBNo7Q==
Date: Wed, 18 Dec 2024 14:32:34 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Re: [PATCH v2 2/3] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <gqmqk4wqbyvktq3qfjte6dmo5pb2ydeulqzwsxc6zat7scj5md@er2gwfgcmw2d>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
 <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>
 <4ietaibtqwl4xfqluvy6ua6cr3nkymmyzzmoo3a62lf65wtltq@s6imawclrht6>
 <c3e800d2-0aff-478e-906a-18f8fc6d756a@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e800d2-0aff-478e-906a-18f8fc6d756a@clip-os.org>

On Tue, Dec 17, 2024 at 02:57:51PM +0100, Nicolas Bouchinet wrote:
> Hi Joel,
> 
> I've pushed patchset version 3 :
> https://lore.kernel.org/all/20241217132908.38096-1-nicolas.bouchinet@clip-os.org/.
> 
> On 11/20/24 13:53, Joel Granados wrote:
> > On Thu, Nov 14, 2024 at 05:25:51PM +0100, nicolas.bouchinet@clip-os.org wrote:
> >> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >>
> >> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
> >> vm_table") fixes underflow value setting risk in vm_table but misses
> >> vdso_enabled sysctl.
> >>
> >> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> >> avoid negative value writes but the proc_handler is proc_dointvec and not
> >> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> >>
> >> The following command thus works :
> >>
> >> `# echo -1 > /proc/sys/vm/vdso_enabled`
> > It would be interesting to know what happens when you do a
> > # echo (INT_MAX + 1) > /proc/sys/vm/vdso_enabled
> >
> > This is the reasons why I'm interested in such a test:
> >
> > 1. Both proc_dointvec and proc_dointvec_minmax (calls proc_dointvec) have a
> >     overflow check where they will return -EINVAL if what is given by the user is
> >     greater than (unsiged long)INT_MAX; this will evaluate can evaluate to true
> >     or false depending on the architecture where we are running.
> >
> > 2. I noticed that vdso_enabled is an unsigned long. And so the expectation is
> >     that the range is 0 to ULONG_MAX, which in some cases (depending on the arch)
> >     would not be the case.
>  From my observations, vdso_enabled is a unsigned int. If one wants to
> convert to an unsigned long, proc_doulongvec_minmax should be used
> instead.
Yep, 100% agree, I miss-read and commented incorrectly. Just ignore my
previous comment; I don't know what I was smoking...

> 
> IMHO, the main issues are that .data variable type can differ from the
> return type of .proc_handler function. This can lead to undefined
> behaviors and eventually vulnerabilities.
I totally agree that it can lead to unexpected behavior. Would have to
look at a specific case to see if it is really "undefined". 

> 
> .extra1 and .extra2 can also be used with proc_handlers that do not
> uses them.
In this case they are just silently ignored. Leading the developer to
believe that they are range checked, when they are really not.

> I think sysctl_check_table() could be enhanced to control
> this behavior.
This might be the case. I can review a proposal if you send it out.

Best

-- 

Joel Granados

