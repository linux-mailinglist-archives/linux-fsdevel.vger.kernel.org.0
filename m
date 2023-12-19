Return-Path: <linux-fsdevel+bounces-6482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864481847C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FADB23CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C814297;
	Tue, 19 Dec 2023 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyVZcOpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912D14270;
	Tue, 19 Dec 2023 09:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04D7C433C7;
	Tue, 19 Dec 2023 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978361;
	bh=GCHHuVGj4o50blV7H75S0nqk08CVt8om6FY4d7wdzcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyVZcOpYl7rLz4s1JFYlcfRzHk7UE/7wvmET9+KDzj4dNsYhJmYbheUxu7Zi/nKs1
	 sSyF79HSApJycxjXSTANfG7bHbu5WquObSgU5xrGg72xJTJJ2fzrQliCuz1/H0oeLC
	 l55Zn5Y5JEoVfjNzZ0QB16AbwQuAsfIK8GV9uCrp526nP7l2hWgizaC4YYqxZqiQOU
	 MopuZD5IucpHyzYaRH8sBg8UKBKm7Kz9C+rMjjSoMtWB6uhUQBTl5B5RLYbv/7KYHS
	 pvlUMwu3IG/CTgWwPNpah6nxhgsHOv+tytmb5V3oFITx6DPWoQexKbXIorQ/FFHaAj
	 yPQnsyVmz6OJw==
Date: Tue, 19 Dec 2023 10:32:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix doc comment typo fs tree wide
Message-ID: <20231219-spotten-zartheit-fe1ebd04de0a@brauner>
References: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
 <20231218231859.GV1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218231859.GV1674809@ZenIV>

On Mon, Dec 18, 2023 at 11:18:59PM +0000, Al Viro wrote:
> On Fri, Dec 15, 2023 at 02:09:27PM +0100, Alexander Mikhalitsyn wrote:
> > Do the replacement:
> > s/simply passs @nop_mnt_idmap/simply passs @nop_mnt_idmap/
>              ^^^                         ^^^
> > in the fs/ tree.
> 
> You might want to spell it correctly in the replacement string ;-)

Thanks. Fixed the commit message. :)

