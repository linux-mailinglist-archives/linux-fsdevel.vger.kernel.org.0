Return-Path: <linux-fsdevel+bounces-2975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B67EE654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAEC1C20999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE546555;
	Thu, 16 Nov 2023 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz12So7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BC4654D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 18:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECFCC433C7;
	Thu, 16 Nov 2023 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700157722;
	bh=kyf6uYIa2rKHq1Ny4L/ltR39Hvgb2Q0eYVoy7wnSfW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz12So7K03qo27YzyGcWgKCJVOjhaBxRj/biyvEQQQqRZnnfXe52aQWt9rfWzb9VW
	 7yVFrKm+ueq94KciM0FGMvV0CK2kb76pwOlSbu3M89cf2wuR8WtNL+rFy2e/Jdjt6J
	 8aIgfoWTx7wPQEU0SbTTubiOCG85rXL8gZ3VDSybmQUEv7bhj0YrL/H3Psej9DnW9Q
	 Eutn5dbj8M83rrs6IiVio9uyzrCirF8IFfew5FYV364+7VWXOoUS1Dggwo7UoTNgdA
	 1lNZpFHce3wmiiPx1qTRZy4TfNaClAq+NwDOw82Wltxb9Olqpi5DIbBNpVKOd6gTAg
	 AA5ihaA5M/GpQ==
Date: Thu, 16 Nov 2023 13:02:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Sargun Dhillon <sargun@sargun.me>, Serge Hallyn <serge@hallyn.com>,
	Jann Horn <jannh@google.com>,
	Henning Schild <henning.schild@siemens.com>,
	Andrei Vagin <avagin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.14 2/4] binfmt_misc: cleanup on filesystem
 umount
Message-ID: <ZVZZGEYCi0exWsbK@sashalap>
References: <20231106231728.3736117-1-sashal@kernel.org>
 <20231106231728.3736117-2-sashal@kernel.org>
 <202311061605.4B418CD7@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202311061605.4B418CD7@keescook>

On Mon, Nov 06, 2023 at 04:05:46PM -0800, Kees Cook wrote:
>And just to be clear, please drop this (and the binfmt_elf change) from
>all -stable versions, not just 6.6. :)

ack, thanks!

-- 
Thanks,
Sasha

