Return-Path: <linux-fsdevel+bounces-2088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DB7E2210
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB6FB20EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281018B00;
	Mon,  6 Nov 2023 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgsMwAQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190E18026
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD57C433C7;
	Mon,  6 Nov 2023 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699274704;
	bh=HSaUiAVebrbsMd+xq6U7XFe5Y4I2GnJ2M1PwNm8O9PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgsMwAQyrIesxM0LyeFIXrElXc21TxaHpSaDGLyA2aSz8DqqEmA/dalzNCdqYMw5Z
	 ybHr4LJkwMmqH9cmeM8rhxqZmvyGslrxh9Abx09PY6M96hzW5hcEYqFtBv6YEqgcB9
	 ogY6/v0QMsMDuT+IHjZjCsxYLx+dg6Ngjy9eKvTmWJvbpFeSH5if8AC2qYrxxUuYwn
	 VlnMXsa4idH1Uebcu8c91wY5kTmEdyxrZ2edQq+Oui/lpG0KUcfrDXUePp+guYsr2w
	 bv3pnoXWHgcGEc9I7yboI8etEdPTp1+/G54cDgXzbM5YMQrruNKjnupAkVX3wzrsy0
	 rcL09ezUE3Fgg==
Date: Mon, 6 Nov 2023 13:44:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH v2 2/2] fs: handle freezing from multiple devices
Message-ID: <20231106-vorpreschen-neuinfektionen-c8373d2e8f47@brauner>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
 <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>
 <20231106113048.f6qdsfma3scxikbq@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106113048.f6qdsfma3scxikbq@quack3>

> FREEZE_HOLDER_BDEV should be FREEZE_MAY_NEST I guess.

Yes, indeed.

> Just one more typo fix below. Feel free to add:

Thanks, I fixed both things.

