Return-Path: <linux-fsdevel+bounces-46942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7BCA96CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC723BDBEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9DB283C87;
	Tue, 22 Apr 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjc3CEnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B18283684;
	Tue, 22 Apr 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328414; cv=none; b=eV3osiF/TLCdEDUGKQR/tlN7CeWJzQIhZKQumZEvRRiU0ABwgoSG58nDBN4j81EOuq+6DcE9ClH/C8N35kaBOwfL/g7tUqdMMsgrGHLOJP452mvnzmIHuJgMyV0j/Ei0afOOVdbmVEDCrbtOq1gbQ43tB9aD+K77P7Zcxa7Elkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328414; c=relaxed/simple;
	bh=OrnCZxS+iHOuq2RV9EN8sUBJCDi/vIe+MYux5FGlJrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIdYGtCfyjkzEdJFncVrlh1UdP6GbE0Mtub3uLiOJBi0prrvz2NT95T8ltRNArF4Bi5F2iAMv1zYqtP7MhgdLTLnA+VjPBARkKnkyjnDSNf2e/Yp3HNZjpoWDQCBNz12zmOMRJZV0UubuEEVXROUpblJfCPkCaLylUlzOrHubV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjc3CEnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC01C4CEE9;
	Tue, 22 Apr 2025 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328412;
	bh=OrnCZxS+iHOuq2RV9EN8sUBJCDi/vIe+MYux5FGlJrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hjc3CEnVZg+dYilU/nvEXtKsO+isKJLPex10Vb/7vTTnYWaK2L0pLk2dGaFgYimU3
	 0Fzz58OyStxgeBbh/LtQVaghBK0UtL2iwvndv1RvRsZ9yFLPZJEG4MjfBf/R8l7Bu2
	 YaE0goFFGPiu78PmfATyk5pgqhtD5BLfbMNr48S6IhIkKqC939xDhTxf76pPT74aF+
	 ORTd+4WFrEbpGzDwwk7Nx2Lz7jitPgGk5vVZlWOGO5W5UoKnhXqwtRXRrcHT6zMToK
	 y+Cp5qB7jzzhBvG4RNQ8qksjnO+mA293UsfPowL2p7VWm1svQa2hcwePQgPWFL5Cij
	 oqMpzq/h2XLCw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
In-Reply-To: <871pu5vdu8.fsf@kernel.org> (Andreas Hindborg's message of "Sun,
	06 Apr 2025 11:28:15 +0200")
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
	<Z-aDV4ae3p8_C6k7@infradead.org> <87frix5dk3.fsf@kernel.org>
	<20250403-sauer-himmel-df90d0e9047c@brauner>
	<Z--Ae5-C8xlUeX8t@infradead.org>
	<20250404-komodowaran-erspielen-cc2dcbcda3e3@brauner>
	<SA4Crt0QV7AKViqF1UCGYRtpvL-BX9dKVY0rAB0VrZuyA6IY2KBUfS8JJ3sNGn46Fb9SoqIQUPA-p2h1HfvvUQ==@protonmail.internalid>
	<Z_GSpcn3bMRStzf4@google.com> <871pu5vdu8.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 22 Apr 2025 15:26:39 +0200
Message-ID: <878qns9vjk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi All,

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Hi Joel,
>
> "Joel Becker" <jlbec@evilplan.org> writes:
>
>> On Fri, Apr 04, 2025 at 10:42:29AM +0200, Christian Brauner wrote:
>>> On Thu, Apr 03, 2025 at 11:47:23PM -0700, Christoph Hellwig wrote:
>>> > On Thu, Apr 03, 2025 at 01:27:27PM +0200, Christian Brauner wrote:
>>> > > There's no need to get upset. Several people pointed out that Joel
>>> > > Becker retired and since he hasn't responded this felt like the right
>>> > > thing to do. Just send a patch to add him back. I see no reason to not
>>> > > have Andreas step up to maintain it.
>>> >
>>> > Removing someone just because they have retired feels odd, but hey who
>>> > am I to complain.  I did reach out to him when giving maintainership
>>> > and he replied although it did indeed take a while.
>>>
>>> I mean, we can surely put Joel back in. My take would be to remove
>>> that person from the maintainer entry because people will get confused
>>> when they don't receive a reply. But I'm totally fine if we should leave
>>> Joel in.
>>
>> Howdy folks,
>>
>> I do apologize for my delayed responses.  I try to review patches as I
>> find them, but I haven't yet set up a dedicated tree -- a bit out of
>> practice.
>
> How would you like the maintainer entry to look:
>
>  - Are you OK with me taking up maintenance of configfs?
>    - If yes,
>      - would you like to be added as a reviewer?
>      - would you prefer to be listed as co-maintainer?
>    - If no,
>      - would you have me as a co-maintainer?
>      - or would you have me as a reviewer?
>
> I set up a tree according to the patch I submitted. I did not switch out
> linux-next yet, but I was about to send a request to do that. I will
> stall that pending your response on the above.

Since I got no response on the above, I am going to continue setting up.


Best regards,
Andreas Hindborg



