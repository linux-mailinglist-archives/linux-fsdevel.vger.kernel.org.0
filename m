Return-Path: <linux-fsdevel+bounces-45816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69670A7CD7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9798C3AECA1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CA1A08DB;
	Sun,  6 Apr 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXUe2Wr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C0380;
	Sun,  6 Apr 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931706; cv=none; b=ju9yykiUnEkXqN85zm58Oc29Lo1OwBoi8EInA2MvUVmQcCEq2R+YDaSgimtBH7izjm0b+phUUNF5Lhl019sI1fs0VLlm3sIM4CRwQivMBnehifbW+PQWlpTIRr7B9WkWszm7R3UnmWSflYFh+EFnEx99WmxXtz9zLN0XSzjOWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931706; c=relaxed/simple;
	bh=tv/XKtzE84bfEwG93vmPkQR34gA4snTu06MHF+O50a0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIlGT0rCyDfZmSyliF+rpktV3MXlch0n0gdXkMZnBumSEynMNkiVhRaSSRhlBBoHXH44DSdLJ5Tk9C+kgeJSnYKZX+8R45QCpkE6sLn7IzQZxurGfEcA/MOlHTuE0cYqpJWgNqa4llFUaqG4OQjC116qWgPX8kczXcrCi1bbtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXUe2Wr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B89C4CEE3;
	Sun,  6 Apr 2025 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743931706;
	bh=tv/XKtzE84bfEwG93vmPkQR34gA4snTu06MHF+O50a0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nXUe2Wr49C2PKBjf3LbSQUSjcb7AiZGOmBcOKp+KX0nXFE9ZiQd+zhuphTgngPCkd
	 XKTmfsw21URdz5chZHPwpoczRTnl9aYYwUmhYFH/RJfQkj5LUOuekqNCsH9AMx0zBO
	 Is97X+hsAJVkNAsSlUVT2j/6/nkdYY9UTat92KFE3ccOgMtByHNbQbdt1OPT5wi/8k
	 sV/64sK50L5s2cY12EoNAjaT3sSRwscN9PNOlYeh8EHIZPYiDsQU7KZ7PW+pK1JQQw
	 144xxa0jque5kBBuNWWbk4Yk95quUaHE3KN/Gm4S3hus6AWdDhN87SV6+RuZqeD/77
	 arlt47b44PuwA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
In-Reply-To: <Z_GSpcn3bMRStzf4@google.com> (Joel Becker's message of "Sat, 05
	Apr 2025 13:29:25 -0700")
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
	<Z-aDV4ae3p8_C6k7@infradead.org> <87frix5dk3.fsf@kernel.org>
	<20250403-sauer-himmel-df90d0e9047c@brauner>
	<Z--Ae5-C8xlUeX8t@infradead.org>
	<20250404-komodowaran-erspielen-cc2dcbcda3e3@brauner>
	<SA4Crt0QV7AKViqF1UCGYRtpvL-BX9dKVY0rAB0VrZuyA6IY2KBUfS8JJ3sNGn46Fb9SoqIQUPA-p2h1HfvvUQ==@protonmail.internalid>
	<Z_GSpcn3bMRStzf4@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 06 Apr 2025 11:28:15 +0200
Message-ID: <871pu5vdu8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Joel,

"Joel Becker" <jlbec@evilplan.org> writes:

> On Fri, Apr 04, 2025 at 10:42:29AM +0200, Christian Brauner wrote:
>> On Thu, Apr 03, 2025 at 11:47:23PM -0700, Christoph Hellwig wrote:
>> > On Thu, Apr 03, 2025 at 01:27:27PM +0200, Christian Brauner wrote:
>> > > There's no need to get upset. Several people pointed out that Joel
>> > > Becker retired and since he hasn't responded this felt like the right
>> > > thing to do. Just send a patch to add him back. I see no reason to not
>> > > have Andreas step up to maintain it.
>> >
>> > Removing someone just because they have retired feels odd, but hey who
>> > am I to complain.  I did reach out to him when giving maintainership
>> > and he replied although it did indeed take a while.
>>
>> I mean, we can surely put Joel back in. My take would be to remove
>> that person from the maintainer entry because people will get confused
>> when they don't receive a reply. But I'm totally fine if we should leave
>> Joel in.
>
> Howdy folks,
>
> I do apologize for my delayed responses.  I try to review patches as I
> find them, but I haven't yet set up a dedicated tree -- a bit out of
> practice.

How would you like the maintainer entry to look:

 - Are you OK with me taking up maintenance of configfs?
   - If yes,
     - would you like to be added as a reviewer?
     - would you prefer to be listed as co-maintainer?
   - If no,
     - would you have me as a co-maintainer?
     - or would you have me as a reviewer?

I set up a tree according to the patch I submitted. I did not switch out
linux-next yet, but I was about to send a request to do that. I will
stall that pending your response on the above.

> The Rust patches gave me pause.  I have no context to review them --
> even the little Rust I am familiar with looks nothing like the complex
> stuff the kernel bindings are doing.  For that part, all I can do is
> hope someone other than I knows what the Rust should be doing.

That job is part of what I just signed up for, so we have that covered.
If you do not want/need my help in maintaining the C part of configfs,
we can add a sub-entry for the rust parts.


Best regards,
Andreas Hindborg



