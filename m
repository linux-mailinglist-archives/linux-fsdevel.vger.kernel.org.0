Return-Path: <linux-fsdevel+bounces-4890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1F805D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B37E1F212D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDC6A004
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WC7mZ97G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408491B6;
	Tue,  5 Dec 2023 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701796614;
	bh=KWkP8n96GGXrhKo85Rj+ALey16KlZtODcw3/5xOWFUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WC7mZ97GSAfwxIHjGKbWqUNzqRKjIzPKv4na8of1+OwLef5DrPCxhT+cUnDu6POxt
	 yJ67y2cWp9Z3RouyCc8hqX9EIgUPCF0RA41Sks/2Psj0iqfB1SACIzzM2rsPQ7EWnW
	 jWIiuWwR/Ud/4YsEqJUbAKEC3hNmnL1nhhqz4nac=
Date: Tue, 5 Dec 2023 18:16:53 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Granados <j.granados@samsung.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
 <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>

Hi Luis, Joel,

On 2023-12-05 09:04:08+0100, Thomas Weißschuh wrote:
> On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > > Tested by booting and with the sysctl selftests on x86.
> > 
> > Can I trouble you to rebase on sysctl-next?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> 
> Will do.

The rebased series is now available at
https://git.sr.ht/~t-8ch/linux b4/const-sysctl

Nothing much has changed in contrast to v2.
The only functional change so far is the initialization of
ctl_table_header::type in init_header().

I'll wait for Joels and maybe some more reviews before resending it.

> [..]

For the future I think it would make sense to combine the tree-wide constification
of the structs with the removal of the sentinel values.

This would reduce the impacts of the maintainers.


Thomas

