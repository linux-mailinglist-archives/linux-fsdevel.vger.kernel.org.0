Return-Path: <linux-fsdevel+bounces-29314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7C97805D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244AC1F235FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452E1DA61A;
	Fri, 13 Sep 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G82PGEUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F71DA2EC;
	Fri, 13 Sep 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231692; cv=none; b=QIWaevhZNf9Wcoj1vJesivY4PLuW0cZVYgu6m9NvEf1NXt5pCJ+zf//8pRdxXUTyhDRUEUCe3BPXI9a0ZxtWBLb4RhKD8MgTCruYc2XZgZfhWSkbibuoKtBt55D03K+4GhhtLD/+BwmSPFcqQSIzJeggA7DmyLa+nxwhMD9Pq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231692; c=relaxed/simple;
	bh=e9S9i9QQI/XDuIRSS2IngfaMXYAjmP3OpnTXkfYc3Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef2/lOeyrYv9QocZNbwPUXy8p1bKh1J7VC45VYYQRhD6F6tZhqZFprzQoowgnokdHuiso0eCRduh3wA+OPQA06hD/iEkTSB6OA49VvsRvf1FDb677KbhUnwuJxG03NrVlzJOqfGa35eIuYGqii/79oac3lEr2Rhfyu4kmuE5mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G82PGEUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72DBC4CEC0;
	Fri, 13 Sep 2024 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231692;
	bh=e9S9i9QQI/XDuIRSS2IngfaMXYAjmP3OpnTXkfYc3Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G82PGEUWHzaflbrOQoAl9dNlsNf/F0Vw6pOEtOBlR2M9kyt/CyZXG2mdv0hWCE21D
	 CrQGVqAfGJbLQePsWK2MCuvTERqpt6Ef7RqathEDlf4G48AGKltlvZ+jGCTklEqKtr
	 ho2kMbx/YKWQSKcw3xLOCF5Ym01l1+MejYRvcg0U=
Date: Fri, 13 Sep 2024 14:48:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.10.y
Message-ID: <2024091347-ranking-handbook-7c19@gregkh>
References: <6ykag7fdhv7m4hr2urwlhlf2owm3keq7gsiijeiyh6gd45kcxr@jfmqoqrfqqfa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ykag7fdhv7m4hr2urwlhlf2owm3keq7gsiijeiyh6gd45kcxr@jfmqoqrfqqfa>

On Tue, Sep 10, 2024 at 03:05:54PM -0400, Kent Overstreet wrote:
> Hey Greg, couple critical fixes for you:
> 
> The following changes since commit 1611860f184a2c9e74ed593948d43657734a7098:
> 
>   Linux 6.10.9 (2024-09-08 07:56:41 +0200)
> 
> are available in the Git repository at:
> 
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-v6.10.9-fixes

Now queued up.

Nit, you misspelled "Upstream" in your first commit, I fixed it up :)

thanks,

greg k-h

