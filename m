Return-Path: <linux-fsdevel+bounces-40662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA6A2642C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D53A424B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DE20B7F4;
	Mon,  3 Feb 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSoH8pm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A62C859;
	Mon,  3 Feb 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612801; cv=none; b=KxZPbwj4u3zWOoTZlkQcVNT9V6E+PvsnERYp+flllVGKyD0YWQbINh/pTh9eK3f6siQHree4iDPgJ3kbpeZvqfXBgLdJq2ZkypickbbAWRMabVC2RC2jzNNik0BlgjN1LW6M5faBzEHl/wJs6rsdW3DzJ7h/+K8mzoVZLXSIxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612801; c=relaxed/simple;
	bh=8DyhvIJF6DSx5+OopDaU2BEOqUyGUVSWVwCXDYw+TdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMf8tAUfqKQNrHdEBq/oezJ5bTozy6hKCupi0cPGAXfwaMmcAsS2ojsvqzyUBXjBTH4YhOyyeJ3+5XxixTgCjtjHNa55TWNsUy0Y6dfO8ycx9cfRbeQlczcUd3mti2hvmfzT5IqrLVH3mXPDgFiJXXsfwMMoEb9lwqM6MQL+aB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSoH8pm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A99BC4CED2;
	Mon,  3 Feb 2025 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612800;
	bh=8DyhvIJF6DSx5+OopDaU2BEOqUyGUVSWVwCXDYw+TdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSoH8pm2LQEU5jZUs08TTx+3CvW1lttl3ZV13sJffJ4DuYY+RSVu8UikSwWuQdN1W
	 TM2DvMlfD7xsZKxxNQP6xQZnKHtMEMNIbauu7h1Rsnq/RRl0uWq82Q7MWYsrRUBah8
	 n9PSUDXXHanGbTBB5OFKG/vf1kiDNIGNvM8+Wygyk8KWn1xnrXsfso8oXJJZtXH+A8
	 eedt0dVZd7Qe/a5IRJe+cS3FwolRHl3TK6Ck2Is4V5JjcGd66vdnH1OtjY/1/qN0KK
	 R5LDx1T/MXTA6GQFy06vzpdOk+8zoCO322U8CahYnODHA9JCceg9ZxX8njJF/3HB2x
	 +aCq0mzCYE7Rg==
Date: Mon, 3 Feb 2025 11:59:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs docs: SubmittingPatches.rst
Message-ID: <20250203195958.GB134490@frogsfrogsfrogs>
References: <20250201175834.686165-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201175834.686165-1-kent.overstreet@linux.dev>

On Sat, Feb 01, 2025 at 12:58:34PM -0500, Kent Overstreet wrote:
> Add an (initial?) patch submission checklist, focusing mainly on
> testing.
> 
> Yes, all patches must be tested, and that starts (but does not end) with
> the patch author.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  .../bcachefs/SubmittingPatches.rst            | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/filesystems/bcachefs/SubmittingPatches.rst

You might want to link to this in MAINTAINERS with:

P:      Documentation/filesystems/bcachefs/SubmittingPatches.rst

--D

> 
> diff --git a/Documentation/filesystems/bcachefs/SubmittingPatches.rst b/Documentation/filesystems/bcachefs/SubmittingPatches.rst
> new file mode 100644
> index 000000000000..5e4615620c4a
> --- /dev/null
> +++ b/Documentation/filesystems/bcachefs/SubmittingPatches.rst
> @@ -0,0 +1,76 @@
> +Submitting patches to bcachefs:
> +===============================
> +
> +Patches must be tested before being submitted, either with the xfstests suite
> +[0], or the full bcachefs test suite in ktest [1], depending on what's being
> +touched. Note that ktest wraps xfstests and will be an easier method to running
> +it for most users; it includes single-command wrappers for all the mainstream
> +in-kernel local filesystems.
> +
> +Patches will undergo more testing after being merged (including
> +lockdep/kasan/preempt/etc. variants), these are not generally required to be
> +run by the submitter - but do put some thought into what you're changing and
> +which tests might be relevant, e.g. are you dealing with tricky memory layout
> +work? kasan, are you doing locking work? then lockdep; and ktest includes
> +single-command variants for the debug build types you'll most likely need.
> +
> +The exception to this rule is incomplete WIP/RFC patches: if you're working on
> +something nontrivial, it's encouraged to send out a WIP patch to let people
> +know what you're doing and make sure you're on the right track. Just make sure
> +it includes a brief note as to what's done and what's incomplete, to avoid
> +confusion.
> +
> +Rigorous checkpatch.pl adherence is not required (many of its warnings are
> +considered out of date), but try not to deviate too much without reason.
> +
> +Focus on writing code that reads well and is organized well; code should be
> +aesthetically pleasing.
> +
> +CI:
> +===
> +
> +Instead of running your tests locally, when running the full test suite it's
> +prefereable to let a server farm do it in parallel, and then have the results
> +in a nice test dashboard (which can tell you which failures are new, and
> +presents results in a git log view, avoiding the need for most bisecting).
> +
> +That exists [2], and community members may request an account. If you work for
> +a big tech company, you'll need to help out with server costs to get access -
> +but the CI is not restricted to running bcachefs tests: it runs any ktest test
> +(which generally makes it easy to wrap other tests that can run in qemu).
> +
> +Other things to think about:
> +============================
> +
> +- How will we debug this code? Is there sufficient introspection to diagnose
> +  when something starts acting wonky on a user machine?
> +
> +- Does it make the codebase more or less of a mess? Can we also try to do some
> +  organizing, too?
> +
> +- Do new tests need to be written? New assertions? How do we know and verify
> +  that the code is correct, and what happens if something goes wrong?
> +
> +- Does it need to be performance tested? Should we add new peformance counters?
> +
> +- If it's a new on disk format feature - have upgrades and downgrades been
> +  tested? (Automated tests exists but aren't in the CI, due to the hassle of
> +  disk image management; coordinate to have them run.)
> +
> +Mailing list, IRC:
> +==================
> +
> +Patches should hit the list [3], but much discussion and code review happens on
> +IRC as well [4]; many people appreciate the more conversational approach and
> +quicker feedback.
> +
> +Additionally, we have a lively user community doing excellent QA work, which
> +exists primarily on IRC. Please make use of that resource; user feedback is
> +important for any nontrivial feature, and documenting it in commit messages
> +would be a good idea.
> +
> +[0]: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> +[1]: https://evilpiepirate.org/git/ktest.git/
> +[2]: https://evilpiepirate.org/~testdashboard/ci/
> +[3]: linux-bcachefs@vger.kernel.org
> +[4]: irc.oftc.net#bcache, #bcachefs-dev
> -- 
> 2.45.2
> 
> 

