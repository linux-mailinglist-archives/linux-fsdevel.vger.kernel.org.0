Return-Path: <linux-fsdevel+bounces-76594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDPEKS4HhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:22:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801EFFB03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC773055BFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26535DD0C;
	Fri,  6 Feb 2026 15:20:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A75395247;
	Fri,  6 Feb 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.13.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391218; cv=none; b=ReGr+XL21PL+qtYjsngK8oD7tlUTNELvilquxdUjuWLQhQGYYo8yWcBXK2PjF75TbsL37TGJC0v+WqgfhAj5Vs4Jk6OPw8K8gtiIhzH1gUsEUzjR3lnEtchCigj+hH+YUG4LM+TBC5rE3fSK9kgT27ELl7T8L+k5ji+HkYuYaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391218; c=relaxed/simple;
	bh=f/+yWBn1FLl5XdChkJD1jPYZj7i5IyJjy2+4/F5Wzd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9dJaVqkLU5zshTUx4Brtj65PWgtdaeixVRTP8Ymz0H+ax+v1mG+jNwfFh4+AkVsRvqEKvjceqDUSMhMmICWeBx4QoMoyP8PlyVJvmOwW4DtS2RESXgBND1jihCB8diTuzPaYvH8CwNw3P4XBqK0fm/H5gbZTHC+lAceqkChv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=140.77.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.99.1)
	(envelope-from <vincent@vinc17.net>)
	id 1voNW2-000000007WV-0YSB;
	Fri, 06 Feb 2026 16:13:02 +0100
Date: Fri, 6 Feb 2026 16:13:02 +0100
From: Vincent Lefevre <vincent@vinc17.net>
To: Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260206151302.GB2951@cventin.lip.ens-lyon.fr>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.net>,
	Rich Felker <dalias@libc.org>, Alejandro Colomar <alx@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250517133251.GY1509@brightrain.aerifal.cx>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3+4 (71f3e314) vl-169878 (2026-01-27)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	NEURAL_HAM(-0.00)[-0.942];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_NA(0.00)[vinc17.net];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent@vinc17.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-76594-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2801EFFB03
X-Rspamd-Action: no action

On 2025-05-17 09:32:52 -0400, Rich Felker wrote:
> On Fri, May 16, 2025 at 04:39:57PM +0200, Vincent Lefevre wrote:
> > On 2025-05-16 09:05:47 -0400, Rich Felker wrote:
> > > FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> > > issue, and later changed it to returning 0 since applications
> > > (particularly, any written prior to this interpretation) are prone to
> > > interpret EINPROGRESS as an error condition rather than success and
> > > possibly misinterpret it as meaning the fd is still open and valid to
> > > pass to close again.
> > 
> > If I understand correctly, this is a poor choice. POSIX.1-2024 says:
> > 
> > ERRORS
> >   The close() and posix_close() functions shall fail if:
> > [...]
> >   [EINPROGRESS]
> >     The function was interrupted by a signal and fildes was closed
> >     but the close operation is continuing asynchronously.
> > 
> > But this does not mean that the asynchronous close operation will
> > succeed.
> 
> There are no asynchronous behaviors specified for there to be a
> conformance distinction here. The only observable behaviors happen
> instantly, mainly the release of the file descriptor and the process's
> handle on the underlying resource. Abstractly, there is no async
> operation that could succeed or fail.

Sorry, this is old. But a consequence may be memory leak if something
unexpected occurred during what was done asynchronously. There is no
guarantee that *every* resource has been released.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)

