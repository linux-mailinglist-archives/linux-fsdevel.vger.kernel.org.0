Return-Path: <linux-fsdevel+bounces-51063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8AAD264A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C2B188754A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7B21CC49;
	Mon,  9 Jun 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="M9ZgFiQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90F20EB;
	Mon,  9 Jun 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495693; cv=none; b=UTUK7lEzYNmhMH2amQd71OE6pKBJWXz45dQn9w2lWjxPZTnDrrgPhyfA5WS97+sWj8PfEOJM2MXyi8ypPVBglTF3xdn1YYYKMwSbAqieNDq+KRfUmtsa945MzcRzagcWNUIzgfnzB6umiYGUa3K/90JMd06eV6lY6kImwMq2x48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495693; c=relaxed/simple;
	bh=1wc8PZm241F7cKj+uTzuco+49PSDsgN1GcF/gYEm6i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmCZd8s6KuC5MOgeQlC/N/GQepua9K10bvGyawG7TFlJCNDga3GVOtljiqXrM+Rd7Jji+dP7Ks3ejs3PvL04AUqKhyDx4+N7/MXZKaXXuoEHyUaFFqmxL2zn2xalfyTXN+BhXZEPDRs3Wv4sQihq6RyFs8sY6kQZxXkBRBF8Bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=M9ZgFiQF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA6B044256;
	Mon,  9 Jun 2025 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1749495688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pdKGZj6gAdwS30Qy+w1qOXXPpm/9GXYPaFvzdj4k7M=;
	b=M9ZgFiQFxtBoYrYUu04XOdRbFccfa7n2eCuv8IWqwNXqsQWxtVY1ZZ9AbMzN4VZNGxENz5
	XQjP8KoKEkm983uLOeCXNai47q6uZ8o3T61AWI4EA6oV9Pvasy118OK2BlIdMbqsE0Wtia
	kV1iLToLd74m5ZLP9gw6f1nXzkMcEEWOpU8/cREuVzjgWvfwvDo+rtIsX2ABvw7oRsKnTc
	oBseVnmD0NO/SWMRbk6W+mIJQJ3OC/lIi93/aNpQe6e4x7RgpVAfiKI7rHh69Z8xvoIj1f
	oqzEKYP+g0b0Gm7xsSui9QCrwLTt4ARRcz28JAe8JjVyT25V0Lof7CjpZ3tbVA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: linux@treblig.org
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utf8: Remove unused utf8_normalize
In-Reply-To: <20250609011921.378433-1-linux@treblig.org> (linux@treblig.org's
	message of "Mon, 9 Jun 2025 02:19:21 +0100")
References: <20250609011921.378433-1-linux@treblig.org>
Date: Mon, 09 Jun 2025 15:01:26 -0400
Message-ID: <87tt4oyc1l.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfffgveeiuedvgfduveeivdejveefvdekvdfghffhhfefteehvdevfefhuedugfetnecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: gabriel@krisman.be

linux@treblig.org writes:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> utf8_normalize() was added in 2019 as part of
> commit 9d53690f0d4e ("unicode: implement higher level API for string
> handling")
> but has remained unused.

FWIW, the original implementation made use of it, but the
normalization-only support was rightfully dropped before merging. Then,
there was an intention to enable it later but it never materialized.  It
clearly can go away.

> (I think because the other higher level routines added by that patch
> normalise as part of their operations)

Correct.

I'll queue it for next.

Thank you,

-- 
Gabriel Krisman Bertazi

