Return-Path: <linux-fsdevel+bounces-10761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CA84DD2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8D286865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68D6D1C5;
	Thu,  8 Feb 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpxVjdGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EA6D1B1;
	Thu,  8 Feb 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385447; cv=none; b=YJUIUcnZ1RzeJxdc6AqKhHcWSSfLOqwwTnNaxrSgK9+DSqrY3FxMx9EtWV4Ofrgg7Qt8GzEhBMl+eYK7XSNsTH7ykBZ7OW19rytFkJiKo5x36oFf0uTeKrIIsUmv0hdNMdPO7XmaTuu4j/2ljq1EzzhWfOn8OV4cYi84vBd+y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385447; c=relaxed/simple;
	bh=Dy3ct1S1iz9as9mhua7IJlSG6fMWTOOp7Gw6g7wh7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P+R5k2tELdSFMWn1bYRonXBWnJ9VtTfdQqtn4Zp8O1tVcmPU25ZAyfhz8cq8mlaGb57L9/AeUrxKF9RuolV6IdWZ4Y7zTCBqfp0KZVjYhulhumwAwrU0yf52d0mWgoESpMHI94L31KRD6LtBLAAm0msFbk8JMAQnctQHDnh0q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpxVjdGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E8C433F1;
	Thu,  8 Feb 2024 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707385446;
	bh=Dy3ct1S1iz9as9mhua7IJlSG6fMWTOOp7Gw6g7wh7cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EpxVjdGO2No3smUG8F3c5+D58RN5EfDWDESxERXDQvHWnddlNiTxesoJlWSJ3zo77
	 HabUaO4PdTgN8n/U6qWEU5+LxaKyJ6+yQDET4RNDGq8WXis0pzkn0wFnb8sd96MDf5
	 goLxU80zkTRVwmlFJNI5TFttR/xV8/0l7KQP5s/uRLiJwKaDiXCRUN4TxJwSbVaJ14
	 fFY7QC04Hovq/iQhfo6tTBucHKr3PRzHwVx2zAPfCVYL62epGs4XIZdw7sLDhYXMut
	 vB3DgWSo4iECDWPqaEcOhcO8zfcQ0dzOsfk4cRPPY5PKh5WRaHhDxvEnNfY0jfKJoP
	 5kV0fVKXWJHcQ==
Date: Thu, 8 Feb 2024 10:44:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH v3 3/7] fs: FS_IOC_GETUUID
Message-ID: <20240208-allenfalls-abfuhr-a6a815da4e93@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi-nBzm+h0MkF_P8Efe9tA1q72kBWPWZsrd+owHTf8enQ@mail.gmail.com>
 <CAOQ4uxhroGgtbXuhoSzk6tMRML4QnVpbvsFcikdLZxR7+ATrkQ@mail.gmail.com>

> Please move that to the end of FS_IOC_* ioctls block.

Done by me during applying.

> typo in list address.

Fixed.

