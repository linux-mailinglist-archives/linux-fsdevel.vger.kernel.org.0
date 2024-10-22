Return-Path: <linux-fsdevel+bounces-32614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396899AB66A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B897FB222FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0C1CB309;
	Tue, 22 Oct 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6EXzXHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D312F5B3;
	Tue, 22 Oct 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624000; cv=none; b=uzEUWcN9D9cUF8uwWW05f4n4+FO0LoMSiI8MGCP9T3g1lWHa1b+mb0KWbRDyRHs4DSaXiM+sLyRwlN/9p1RkBRHc46j+Xd/ccHvQsWDcUSzoXoU3pTnlJ0JtVUIjnCG4/hpvohBoV0fGnxohxaWAfaIQPuOQ1fE1zlOrVsyBDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624000; c=relaxed/simple;
	bh=2r8dbf+RtDRpeSNbb/i/tnd/Q2HwhxAktt5rsBh//Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuIBjHfMKLLTUlvgf4VMVKAMM+uGssfUPe2KPaC1pY18MY9V9NTbiQGAxA2/rTToZWv0W6a+Fne9pZnTynjahX5aINZz0zSGm4/AdWIeW/0lGuJi5BeruZos/UwtIMOxpiYI8mDSkd0lsmX0hjLq8YmEriD8EvpQG1k3LSiXBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6EXzXHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B918C4CEC3;
	Tue, 22 Oct 2024 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729623999;
	bh=2r8dbf+RtDRpeSNbb/i/tnd/Q2HwhxAktt5rsBh//Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6EXzXHkmzJfXvqwR0odji6s7x0VG8I4jxa8KaSCLN1NltJuOyGzquOkk5qDEQNzn
	 gVWEalspVP4gugAkdN/mnwbrB9QlRTSBfblGbrWR03PmOzHnftGMKHHu8iGm1LifBe
	 iBlj7JhN2itiXxEIz6K9od8qMN/7xI00/kYdOMSpCi529MfAkIeEDTVrs1YWsYM6pI
	 MBwdBRdA+7PKDZOMENAZnskJ6m0I7VpvFeUXbgVWWC9/5SqKgi0TCQiRWIiuKPxDok
	 M3FNpdrGSSJ+XylDUOOyslVupuTaddOfOc1dIKi2kRMgC2vA1ZXUuGVU+wsHFbC7jw
	 mWJMqZ/qp3JWg==
Date: Tue, 22 Oct 2024 15:06:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, hch@infradead.org,
	broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <Zxf3vp82MfPTWNLx@sashalap>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>

On Tue, Oct 22, 2024 at 01:39:10PM -0400, Kent Overstreet wrote:
>
>The following changes since commit 5e3b72324d32629fa013f86657308f3dbc1115e1:
>
>  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)
>
>are available in the Git repository at:
>
>  https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22

Hi Linus,

There was a sub-thread on the linus-next discussion around improving
telemetry around -next/lore w.r.t soaking time and mailing list reviews
(https://lore.kernel.org/all/792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org/).

I've prototyped a set of scripts based on suggestions in the thread, and
wanted to see if you'd find it useful. A great way to test it out is with
a random pull request you'd review anyway :)

Is the below useful in any way? Or do you already do something like this
locally and I'm just wasting your time?

If it's useful, is bot reply to PRs the best way to share this? Any
other information that would be useful?

Here it goes:


Days in -next:
----------------------------------------
  0  | ███████████ (5)
  1  |
  2  | █████████████████████████████████████████████████ (21)
  3  |
  4  |
  5  |
  6  |
  7  |
  8  |
  9  |
10  |
11  |
12  |
13  |
14+ |

Commits that didn't spend time in -next:
--------------------
a069f014797fd bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path
e04ee8608914d bcachefs: Mark more errors as AUTOFIX
f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
3956ff8bc2f39 bcachefs: Don't use wait_event_interruptible() in recovery
eb5db64c45709 bcachefs: Fix __bch2_fsck_err() warning


Commits that weren't found on lore.kernel.org/all:
--------------------
e04ee8608914d bcachefs: Mark more errors as AUTOFIX
f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
bc6d2d10418e1 bcachefs: fsck: Improve hash_check_key()
dc96656b20eb6 bcachefs: bch2_hash_set_or_get_in_snapshot()
15a3836c8ed7b bcachefs: Repair mismatches in inode hash seed, type
d8e879377ffb3 bcachefs: Add hash seed, type to inode_to_text()
78cf0ae636a55 bcachefs: INODE_STR_HASH() for bch_inode_unpacked
b96f8cd3870a1 bcachefs: Run in-kernel offline fsck without ratelimit errors
4007bbb203a0c bcachefS: ec: fix data type on stripe deletion

-- 
Thanks,
Sasha

