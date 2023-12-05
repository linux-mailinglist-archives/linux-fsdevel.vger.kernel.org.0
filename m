Return-Path: <linux-fsdevel+bounces-4856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A37804CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F80628171E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918E3D97D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="toBtk2dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DDD83;
	Tue,  5 Dec 2023 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701763449;
	bh=uVveZGVaZUbRnOAutlrO+8dx/i4swMQhmAWYmf7MjJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toBtk2dg3zME3NTivyV0eIcnfHFayW+Sj63QXxP2KybGsXPcb/EP9BYJDDBdYy+C2
	 qJqStQ03416apxhNdj0VmgT1esI/H0K4OO4HGu0Ks+pTM9G5ih/ZzDAgRvZD9VtB4j
	 7r1MiRQPUt/QOE1kSP3fmQgtpoV4QvN9atqH1MpU=
Date: Tue, 5 Dec 2023 09:04:08 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Granados <j.granados@samsung.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW66FhWx7W67Y9rP@bombadil.infradead.org>

On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > Tested by booting and with the sysctl selftests on x86.
> 
> Can I trouble you to rebase on sysctl-next?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

Will do.

Note:

I noticed that patch "sysctl: move sysctl type to ctl_table_header" from
this series seems to be the better alternative to
commit fd696ee2395755a ("sysctl: Fix out of bounds access for empty sysctl registers")
which is currently on sysctl-next.

The patch from the series should only depend on
"sysctl: drop sysctl_is_perm_empty_ctl_table" from my series.

Thomas

