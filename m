Return-Path: <linux-fsdevel+bounces-12427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B337285F35C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69628281B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D252BD01;
	Thu, 22 Feb 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVA7AOrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2423754;
	Thu, 22 Feb 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591520; cv=none; b=eU1DaUA0ufLuVuYCrURvQxGATaFy4U7mVhn16G3b8t/PCns8r/k3xKHt/HAOGJxRMmVsB410AH+tJqKw9HgzQmAttht+tPkNGxluHgiAnwLG/tjCYy9ehNvm38SHqTeVoeUsxQwwMS/5SESkl1IwyQQ1xVexW7agt7DTWIZuA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591520; c=relaxed/simple;
	bh=YlNKIwFTPZOJF27McRRhZyY+cPAVqwgESlnlds8SH30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlkvuyiOwm5fQYw4oWTqOqhCoIPodUflrAIUEKKBodaJSXRxWVgRcCSsXn4fwCZtf1PlQ7hX1p89DvdQr8NqhIdA8JUAoI2NjftVufziIIWzZbytqlrzcg/G7/+beqm3oQbnDAFrR1KwflnbSewp2u7CP7aS/TSrsP7wzA3h+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVA7AOrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849D7C433C7;
	Thu, 22 Feb 2024 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708591520;
	bh=YlNKIwFTPZOJF27McRRhZyY+cPAVqwgESlnlds8SH30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVA7AOrrjg45gz1Rc+1ywpUuS3xKQyR+onxIGn6CR8JvLctTUNWNsKTHKqK5ZO4JL
	 w/Kp/CUilPNvOiZPpz/ccANAuYXXp9DZzWyxS2g0/OdUgnYZNbPiP9299aMgXaSNGW
	 gM5iigsSy1YhGWkYbR2Ui0XcChxsuiTTsw0WGCV0UHpzVDuVtTibwxD/MIhxwSIxFz
	 IVFc6hhdqIwqImC1dU63eOghP2coRAk6jPIj0Y7ua9N5MQQvhTI9yixF9Qity2Po11
	 FAAYFc4e13AsXVHEMW+Mx9YlokgjsbOwM2Xn931plUz8sKgokZ03oUnM4JETBG/fn6
	 pviNr8niQHFsQ==
Date: Thu, 22 Feb 2024 09:45:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] pidfd: make pidfs_dentry_operations static
Message-ID: <20240222-badeanstalt-belustigen-f7a6e44f4b0b@brauner>
References: <20240222083604.11280-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222083604.11280-1-jiapeng.chong@linux.alibaba.com>

Already fixed. Thanks.

