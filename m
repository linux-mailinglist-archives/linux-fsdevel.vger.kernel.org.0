Return-Path: <linux-fsdevel+bounces-31772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC199AC5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D111F210F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C61D0DE1;
	Fri, 11 Oct 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="N+9K3pNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104B1BD4E7;
	Fri, 11 Oct 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673425; cv=none; b=nLuwBkcUphriYW8NC9INgPJ6EoEOSa4o4x3k/goc4I3NfME+p81TMfg2cM1cGbLP3kuS/0D+1c+9qMBpjoi/IUuFYCtystuX6Fjgfq8nExRH3eFkO6yze1FDc7tNqaqXRP6wgi7eMLC3DDPle2OdbcEExR7II+3UhTu9efpIWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673425; c=relaxed/simple;
	bh=AwJF2VvZfj2BBywGYG+O3l7hzRVfm+WUR1zfbAelgZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIEkmARyBCW3sLc7wwm3ibdsA3u0yxIAu5e27Kvbp6tWSeB4ZZ2oNNz+pMHtoU7EUXt1P4xfQo8IDy1JkHHRLOLuy/I2hCkbsLcSdZuV2hQwzOdth0BhyIlOq6D1wing9W9RQezlifIdN30QG9VuaWifjyKpq7cwhR9Krq4qV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=N+9K3pNq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E50DE0003;
	Fri, 11 Oct 2024 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728673420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwJF2VvZfj2BBywGYG+O3l7hzRVfm+WUR1zfbAelgZg=;
	b=N+9K3pNqz7ahbQR1EFy7SkWnfhCfUPvMRVonC6gslzgmJRbE3VLfRZPbB5+kEAr08RdoxM
	CuIG7AaiuBKRqq8k6kUj8veuVX0wnUUboQpJsa/ca3g5XzXVeiYVzKUfUgqqLN/ksTG1Nu
	6YAc2nWIclSwuw6fyoNpT7fzTUcjdp7LObcWvvwneig8wo6Efgd6nl4C23ZlQqGgidPsTR
	vLHbiwoLpK5Dsz5p1RQEss5HEq3OL8fq3vfr2d0K2XRIhIm99T1vyWK3+pNRy9nncScKD4
	UQwQOCPYaqWoPZCdc26ToDDZaOa+c4GkjvDGHyq6Z1f5rR6k0cL7HaCfKxkkUw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com
Subject: Re: [PATCH] MAINTAINERS: Add Unicode tree
In-Reply-To: <20241010200242.119741-1-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 10 Oct 2024 17:02:42 -0300")
References: <20241010200242.119741-1-andrealmeid@igalia.com>
Date: Fri, 11 Oct 2024 15:03:38 -0400
Message-ID: <87set2tqb9.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Unicode subsystem tree is missing from MAINTAINERS, add it.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Thanks, applied.


--=20
Gabriel Krisman Bertazi

