Return-Path: <linux-fsdevel+bounces-45230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D603A74E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF48176DB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4AB1DA11B;
	Fri, 28 Mar 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGADO0lV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45174A935;
	Fri, 28 Mar 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179044; cv=none; b=U4HlNm0vnA9T7wlRbgMiY/Occf7qpIfxf5bj6CpKB0WJC7q8talWtHzq6O/M0G3MfhgVt8JfaQ9SmHN0qXQwEErmUHZbGEwnVtgWc0SAazUi8AoLyu13li41DhCoKhd5WH+DfAPyb5xQmpXG0DTw9j+y7uSWUf72F0rriHcA4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179044; c=relaxed/simple;
	bh=gKn8zSvs2hl2MmkMAfqrfBw5wLaI4VX8+FPYwNx8mBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzG1GlPiib1MghmJsPKldY0qDHJko1tj83SQfWej4idkbkb62WjrVjsO+vDxr9QM16uxKs685Y1GTngXgs8iWRSUoqTSZfOREdsz0KPUCCeXGX1QEZ8FlpgXDHZvmodW7gc3mBD4ZifoQfHw7G28Wu9D+ryKWyvYhEAwbziZbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGADO0lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D1BC4CEE4;
	Fri, 28 Mar 2025 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743179043;
	bh=gKn8zSvs2hl2MmkMAfqrfBw5wLaI4VX8+FPYwNx8mBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iGADO0lVv1lQOVLrc2HuLAuxGC27aijlbpqIQnk4YmG6J85J8iTAIVi/J718k25nm
	 hHYEVTkexd2P4Cn41iDTRY/a5z7UEdrnkqhlS4Upn7aJTao04u38uX83D+oDkH27rt
	 Ca+H93ie/VK4ZVxXtJsgqokTaPbLk4A4uanQ6Js2u137WzOGbVNXmR08TBMomwN4Uc
	 MjhcJsVPEYrS3rszAWIybNAEPZtOTNMcwKY8ogWe1yRyBV/OzOnBGxlE9GQPgW4ug5
	 4s72xo4J72Dy2XbNOCfgzokUW1Q6NA7uCxsbgO5nibo85RHg9Sz7baKz3bpBONEAZV
	 rlF2iJdti1/PQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Breno
 Leitao" <leitao@debian.org>,  "Joel Becker" <jlbec@evilplan.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
In-Reply-To: <Z-aDV4ae3p8_C6k7@infradead.org> (Christoph Hellwig's message of
	"Fri, 28 Mar 2025 04:09:11 -0700")
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
	<Z-aDV4ae3p8_C6k7@infradead.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Mar 2025 17:23:56 +0100
Message-ID: <87frix5dk3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Christoph,

"Christoph Hellwig" <hch@infradead.org> writes:

> On Wed, Mar 26, 2025 at 05:45:30PM +0100, Andreas Hindborg wrote:
>> As recommended in plenary session at LSF/MM plenary session on March 25 2025.
>> Joel is no longer active in the community.
>
> I'm not sure who decided that, but that's an exceptionally offensive move.

It was a recommendation given by several people in the plenary session I
had 10 AM local time on March 25 at LSF. There was agreement in the
sense that several people recommended this course action and nobody
objected.

> Joel has helped actually reviewing configfs patches even when I as running
> the tree, and I explicitly confirmed with him that he is willing to
> maintain it alone when I dropped the maintainership.  You've not even
> Ced him to tell him about how you force him out of the subsystem he
> created.

I am deeply sorry for not Cc'ing Joel, that is a mistake. I did not do
it out of disrespect or ill intent, I simply did not think about it.
Thank you for correcting this, I appreciate that.

I have sent emails to Joel at least 4 times since the first rust
configfs series was sent, and I have offered my assistance in
maintaining configfs if that is the reason of no response.

Best regards,
Andreas Hindborg



