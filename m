Return-Path: <linux-fsdevel+bounces-31715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB299A566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E8F1F2417E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C410219C87;
	Fri, 11 Oct 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7JdSSVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9C1E501C;
	Fri, 11 Oct 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654646; cv=none; b=R7moz1SbzVTDGOFtzq5VRTX5nnVF13fwz/x8dvzVXHKytZlSbTOUTlnt2wr+edC5EIv6svwZZas+8k+2KE495CFJCyD3xUQ2jk2LeXAPZOCBHQj6bCQz/frX/waDXlUhxJY/+nuMr2NKPIJsPS/gCAq9ESeBZ31ePc+b6iUbuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654646; c=relaxed/simple;
	bh=wuxUEsvaJi7KnJOd4mK0B/RGGL3X6g4msSOnRDdoiik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUwDMessYD/q+8gfO51KrTHIqwkhjfhZ9lb1VJ6+V7FPWybVM0Hzwygy1a7H4V36p1DhXd9y1sHj02Wvj7qvRmrVZas/jeG2AdAZMwQzTyEZ27rAFpn/gGTo8qLfSUhqnnVM0YwbPMMXOADFDga1Ho9kKT5MQ9E1XZ7vOBdYoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7JdSSVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8B5C4CEC3;
	Fri, 11 Oct 2024 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728654646;
	bh=wuxUEsvaJi7KnJOd4mK0B/RGGL3X6g4msSOnRDdoiik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7JdSSVDMGjVi4QlM8Wf2Ptn6rohggPoFtDYCrCY1mDWwXAFWB3GQaOT/vjiVqJaj
	 TLukmBw2E3jOjv3sLaJpCON05bv5gDoHWpE3bP+iMtbpbymCMHAvz1v0M5t2lGtl8J
	 VIl7PNmZ4ls+fzycBj66fdpTzQG/UApqHqfFJcl4ajDeu0+EMOnSq4GzV/KVDE2u2q
	 QXlAW7bIeNyB9yie0pnoAC4wjAUXKhMcdlDXMnHJxQ8K6snCT1p82VQFlIua9bRcvA
	 NOharb2bkW9sHAm3hbwhkHbvjrI+6vKW1noeiMdhG+k2vkMRatMbwjPaj7l5A5AQrI
	 5cdgIUAz9ybWw==
Date: Fri, 11 Oct 2024 09:50:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 45/70] fuse: handle idmappings properly in
 ->write_iter()
Message-ID: <ZwktND4nnNHntKSb@sashalap>
References: <20241004182200.3670903-1-sashal@kernel.org>
 <20241004182200.3670903-45-sashal@kernel.org>
 <CAJfpegumr4qf7MmKshr0BuQ3-KBKoujfgwtfDww4nYbyUpdzng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJfpegumr4qf7MmKshr0BuQ3-KBKoujfgwtfDww4nYbyUpdzng@mail.gmail.com>

On Mon, Oct 07, 2024 at 12:05:06PM +0200, Miklos Szeredi wrote:
>On Fri, 4 Oct 2024 at 20:23, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>
>> [ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]
>>
>> This is needed to properly clear suid/sgid.
>>
>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>AFAICS, this commit shouldn't be backported to any kernel.
>
>Hopefully it would do nothing, since idmapped fuse mounts are not
>enabled before v6.12, but still...

Dropped, thanks!

-- 
Thanks,
Sasha

