Return-Path: <linux-fsdevel+bounces-30049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C098562C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E801F2428C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586015B111;
	Wed, 25 Sep 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNOLF2Hw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66015F330;
	Wed, 25 Sep 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255644; cv=none; b=eUUozVI5aLD2ju+31cOn8sttZoppiC7ZgoeOjJkuAnSy20hrWuAfxUb42GNJx096ZwfSIc/Ojural3Rf5t9c2pEAcxvp8K7cnCcD4J8Ry7sqZuUAmnqUO2cDgz+oNLvbLxFH49RExr0vJxQDXAj5XGIrlomMNan58riD19qJtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255644; c=relaxed/simple;
	bh=Glx4C8r3synfg89xbVV4Cc4uhGlDMDHKIlpfjZsQ+us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TniPqug6g132bTPhvVJBFe9/cYhpRDV1+JdcdlQOnEy3sqrrox31D5i0aILTa5AH9hvqxczZFDOfTLYRfp8MoqtFW+Vu7I09+/a71cLDM2vvC1aRe75O9U6fuQOZBnmxqts2tQiDxBPn9EJQQlHq6BY1HhoTmM3sv2FTOm0kOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNOLF2Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBCDC4CEC7;
	Wed, 25 Sep 2024 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727255642;
	bh=Glx4C8r3synfg89xbVV4Cc4uhGlDMDHKIlpfjZsQ+us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNOLF2HwgUh1uCxRdEcRPhwIbXFDFI00dTgdqkQwKH3Jb8QpZ8zVKMrEiyovlcAVe
	 ujwnwIcpj6OSY2PU7PBYIJLp9hlv+TZfmFESTQYg482V/q5g1YTMS8MQoNZ2m7Dno6
	 pHDL57JsKMYgu2WCr8vUmPe8YM9MrQ2SyjPqG0TbKK78CEtgjVLxusGv+nF2clRMSO
	 j6Ved13ECjA5aC+7v89W5HmdBB0joJp5ghoEimY9TiZY+rAC9O3SzGX2gdJ/ZfJlae
	 ddYZYDAgOLN3r5V5bxszaxoM4KR/WgMyZOhmzhJGVLFhhT5lcMCUGV1Il2EonTSzBN
	 XGkZ5xGpRex3A==
Date: Wed, 25 Sep 2024 11:13:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to
 userspace
Message-ID: <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
References: <20240923082829.1910210-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923082829.1910210-1-amir73il@gmail.com>

> open_by_handle_at(2) does not have AT_ flags argument, but also, I find
> it more useful API that encoding a connectable file handle can mandate
> the resolving of a connected fd, without having to opt-in for a
> connected fd independently.

This seems the best option to me too if this api is to be added.

