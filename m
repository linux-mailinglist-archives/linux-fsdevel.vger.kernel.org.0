Return-Path: <linux-fsdevel+bounces-1628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B720C7DCB4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CA8B20F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090419BB9;
	Tue, 31 Oct 2023 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHu5pvSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B319BAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF11C433C8;
	Tue, 31 Oct 2023 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698750173;
	bh=AUPbo52ebpfYsn9y2k1CRAadrJQ1kLwIo/nND/DXiUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHu5pvSCKVL1UpZ4Ih9+Rv/ffF0e4ucFFEHohvBxCQD4wws7SpkmrC84be7DL/hSV
	 BeRyNkaz7jqOkUcY0ZnNafcsMHsIkm59t8WBgWpT8jfLJiK/PIEAogssDwNttEXV7C
	 UXcuMhJ8GUPRJ7eN8JFFH4OdlN6TlWTrSF57zuNHxJMxMpDptjWQxleIuZL10938mm
	 WjHdCjqTlgg/93rj9r8eYNtV0Diiyv2KONn0eUuO2+4y0HEJrK9Kxt5Ru/jXMGwkeD
	 tUomc7YmmYRxcNjVaBfjiY06Gokcoa5OAxhYS+pJIE2U6JPUBzEvhqiQMNLJq7AzDh
	 2fH0hmH3yFHkQ==
Date: Tue, 31 Oct 2023 12:02:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Dave Chinner <dchinner@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231031-proviant-anrollen-d2245037ce97@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>

> The follow up including a statement about "being arsed" once more was
> to Christian, not you and was rather "tongue in cheek".

Fyi, I can't be arsed to be talked to like that.

> Whether the patch is ready for reviews and whatnot is your call to
> make as the author.

This is basically why that patch never staid in -next. Dave said this
patch is meaningless without his other patchs and I had no reason to
doubt that claim nor currently the cycles to benchmark and disprove it.

