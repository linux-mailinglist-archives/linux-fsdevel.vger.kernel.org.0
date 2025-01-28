Return-Path: <linux-fsdevel+bounces-40210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8EA2072A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A02518858B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB511DF99F;
	Tue, 28 Jan 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="bcKhzTh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502601DEFE9;
	Tue, 28 Jan 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055977; cv=none; b=rr+I+INf3yc8I3DmxWHK6o6Lh7KsZ5AM3/nsKIVIlYNnF/w1kMIEtkcdWTonATryapRUTviuTzzPVfJrcoqzrFdM1T2xYcUXJdLt/1B9I8MzCJrarJvOI5IpUKHLeB2v5nUFf23pYLWb/utEUxm9xwtRpB43PGKPtmBPUBuIGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055977; c=relaxed/simple;
	bh=G0IYIPruK8FJGb1qnPS8pft12oH93nV7sm6DrKWuEoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUMjCUtqZmLVGjb93169h+lPMLPCD8XNOeqb9zd61jgvVWltVZbHpckxKoUOuKHT6if9QbXePx6vmK5GXgCt7dIDDE1Vz10Xp5IuAd25TkbArNRIhwbithbOizhEPxYTZ8GlZqM8X1rWwDbz/bqpHNovJg+RLLe21jSoYktPxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=bcKhzTh1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E68CC000D;
	Tue, 28 Jan 2025 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1738055969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqmawlmBPTzK6rsXa4fts2SY1kwgVYQnTT/l6s8w8TM=;
	b=bcKhzTh1ZT8iUOfgExF4S2DIbomL7PDkNTBhfsQ6aT+w5jvGzceZgtpvqbAjf9w+ET7Wse
	aD6YYHF9Ba9CaICxe5ipN8jgJWHTFE/of/am42OsJzd9OAju8TF8Lhgd0uYuLCZmXdoJ26
	HowqMNlRxl4eso0/RL37sJeRw5NWsmkh3D1qIquhL2XHcgzHe90pc+avXVtQIcxjXX2WI5
	j4BgxXUC635tBXCbtjUtm+47HbvBV6JY0FG/TNhhsLxu3z+uRR1wKlFdYwdB9MOOqunvm4
	G4+hmlwMT1LgEzKmPET7t9q7G1SqHKLQYyBjIa2I4z6ZqqjpmnXn6IINLWTIUg==
Message-ID: <fe0ff3c2-b010-46f0-8916-5b471f5506c3@gtucker.io>
Date: Tue, 28 Jan 2025 10:19:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] d_revalidate pile
To: Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
Content-Language: en-US
From: Guillaume Tucker <gtucker@gtucker.io>
In-Reply-To: <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io



On 27/01/2025 9:38 pm, Mark Brown wrote:
>> But let's see if it might be an option to get this capability. So I'm
>> adding the kernelci list to see if somebody goes "Oh, that was just an
>> oversight" and might easily be made to happen. Fingers crossed.
> The issue with KernelCI has been that it's not storing the vmlinux, this
> was indeed done due to space issues like you suggest.  With the new
> infrastructure that's been rolled out as part of the KernelCI 2.0 revamp
> the storage should be a lot more scaleable and so this should hopefully
> be a cost issue rather than actual space limits like it used to be so
> more tractable.  AFAICT we haven't actually revisited making the
> required changes to include the vmlinux in the stored output though, I
> filed a ticket:
> 
>     https://github.com/kernelci/kernelci-project/issues/509
> 
> The builds themselves are generally using standard defconfigs and
> derivatives of that so will normally have enough debug info for
> decode_stacktrace.sh.  Where they don't we should probably just change
> that upstream.

One approach that was suggested a while ago was to do extra debug
builds in automated post-processing jobs whenever a failure is
detected.  This came as an evolution of the automated bisection
which had checks for the good and bad revisions: if a stacktrace
was found while testing the "bad" kernel then it could easily be
decoded since bisections do incremental builds and keep the
vmlinux at hand.

As Sasha mentioned in his email, some particular configs are
required in order to decode the stacktrace (IIRC this is enabled
with arm64_defconfig but not x86).  Debug builds also make larger
binaries and affect runtime behaviour, as we all know.  So one
post-processing check would be to do a special debug build with
the right configs for decoding stacktraces as well as maybe some
sanitizers and extra useful things to add more information.

Builds from bisections or any extra jobs should still be uploaded
to public storage so they would be available for manual
investigation too.  That way, the impact on storage costs and
compute resources would be minimal without any real drawback - it
might take 30min to get the post-processing job to complete but
even that could be optimized and it seems a lot more efficient
than doing debug builds and uploading large vmlinux images all
the time.

Hope this helps!

Cheers,
Guillaume

