Return-Path: <linux-fsdevel+bounces-49271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC52AB9ECF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B62C1BC4D50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E919CCEA;
	Fri, 16 May 2025 14:42:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9517B425;
	Fri, 16 May 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406574; cv=none; b=UwKIcsNlfYnLTbPHXOSDRRWjU3NblYL/k8GYrZuwq3Ta4Ax8JDWKdk9UltE6VhPOe51au9aYokorPC9KjVOrujyEJJZNN/mawyBQMTfybV6cJgWwrNev241Gge8XgISj8i90nozW+WCo6lJoN+RXplSUnmU0ykh6I3BcEeCsatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406574; c=relaxed/simple;
	bh=9maDKHK0IoY1qIaWpDgHSh8NuUPo0s5Z94o6iLHhQHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEWI9aNmvc4ns+uzQ2hpl6pAwn1KhBsrC/Ga5Fzfu+r+E3pLhVT5aW3sK3AnQF9QNDrma7hTxAiAi4NV8caQOr95Jvh01Qr4AAMYSg7GidoPFifVktN/FUaRSGbNydnkwxOLhAZU0gVRbHWOkF3jsB50faWmam7DUPgOCX0k/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (135.197.67.86.rev.sfr.net [86.67.197.135])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 05076B5;
	Fri, 16 May 2025 16:39:57 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id C5D46CA01D9; Fri, 16 May 2025 16:39:57 +0200 (CEST)
Date: Fri, 16 May 2025 16:39:57 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250516143957.GB5388@qaa.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.net>,
	Rich Felker <dalias@libc.org>, Alejandro Colomar <alx@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516130547.GV1509@brightrain.aerifal.cx>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.13+86 (bb2064ae) vl-169878 (2025-02-08)

On 2025-05-16 09:05:47 -0400, Rich Felker wrote:
> FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> issue, and later changed it to returning 0 since applications
> (particularly, any written prior to this interpretation) are prone to
> interpret EINPROGRESS as an error condition rather than success and
> possibly misinterpret it as meaning the fd is still open and valid to
> pass to close again.

If I understand correctly, this is a poor choice. POSIX.1-2024 says:

ERRORS
  The close() and posix_close() functions shall fail if:
[...]
  [EINPROGRESS]
    The function was interrupted by a signal and fildes was closed
    but the close operation is continuing asynchronously.

But this does not mean that the asynchronous close operation will
succeed.

So the application could incorrectly deduce that the close operation
was done without any error.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)

