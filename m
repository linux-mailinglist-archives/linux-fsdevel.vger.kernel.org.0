Return-Path: <linux-fsdevel+bounces-7322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801D823954
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 00:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAAC1C249FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BB200A0;
	Wed,  3 Jan 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCutLSyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F931F92C;
	Wed,  3 Jan 2024 23:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A26C433C8;
	Wed,  3 Jan 2024 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704325751;
	bh=cUarsV5K7rtfBiinAm/BN0fcxETDoo+FWgQiikIPl9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCutLSyV4EjpIjniXtTwSQaUS4wVbobUfJfosT5b1zXpwM+4u1VOivaKSdtDhbKXY
	 uzsgJXKVrR47NA+K1s6bIc0LajGGwxRpP0RtsZT+O3LGzwhGYRbc+gKVRaYlCT7pL9
	 77Wf1bJ7dr11d5/oaMeM/nsNDxnY2tSQEtLBURqA4GNBDy+ZzZYosXBKCJgWQxhGvZ
	 tTv6RflfdJhGoemwJeJ5XV5pMe/ykk7Hd+FgQ8BZ1ekpS+gRBW1HkAlh12aNoWdEwR
	 DV7PNfJuPYzFwee3dMW7w5kDzc9LC8+y6I7UCl4qxtlerUgoGUHwRgng46Nl180pvk
	 Zu2iEa7REll5w==
Date: Wed, 3 Jan 2024 15:49:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
 <brauner@kernel.org>, <torvalds@linuxfoundation.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 00/29] BPF token
Message-ID: <20240103154910.50d31c39@kernel.org>
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 14:20:05 -0800 Andrii Nakryiko wrote:
> Subject: [PATCH bpf-next 00/29]

bpf-next? It should go directly to Linus, right?
The merge window starts in 4 days.

