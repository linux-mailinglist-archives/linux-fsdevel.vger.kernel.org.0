Return-Path: <linux-fsdevel+bounces-33566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3419BA253
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7731F2351E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C141AB6F1;
	Sat,  2 Nov 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjRm6AY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBB14F12F;
	Sat,  2 Nov 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577474; cv=none; b=jQ5jOqLdITQUIu/p4yZ/e/PUK3m95AUg8kuRTU47fDb7AH/HZRsFti6rqm8vdpwgBGunrSFYJMSlnRP5T6TbOK3XKmC0TacT/5PWa8JgMtZuDFjqj9ux42jyEIUvrGLAVJ2kxM2WcpuzOGK7U1XsOKQL1Q+aPAji91cYZGBxkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577474; c=relaxed/simple;
	bh=VQkQ6eqn3lKYZ9PZGrZj3JkJvhLneLYLOahSdo+ggGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrYbXy56wSipcE/v8+0yW6/7eE/o42GBLMRXH0fOXxk3C9yzuasE649Wl17k5Ag6Fif9JIAuWTZ+azQMtQwnRWL+9a57mKjQUY6om7ygazKuTbv4Ijp/Uo6afpg2NWUgysAM4wA+EyA/NVj/NsIsRK5Fls290sJc2vv+OHhVLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjRm6AY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63C4C4CEC3;
	Sat,  2 Nov 2024 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730577473;
	bh=VQkQ6eqn3lKYZ9PZGrZj3JkJvhLneLYLOahSdo+ggGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjRm6AY/KC4plGbaIlusY45e+8yDejb10OeFI2XG537ykrUZ24KeHeKIR8o5M2hkH
	 YDiN8ARkJo/9KKd0krJSlNfk07pQSszSl1VFS7Zq0LL2adSU9mkanjTxxHErVLh32C
	 m3hcCWGgaLcEss2Iu0Ii34tCfuSunzN/Bsd64elDx8wPYjX7BWqyQktwt/2xv3GjBW
	 tUxIzJXHmYVOMQ2K+j8enpQVQuh5CNvLv0kf9vXf0qfMh9PmyxHDCYQGq3VeLbhU+N
	 1nbVbzl3sc49T1l+iQdTGlfPfxAb9KXRk/0OwGuEa+hGeHJZLyUNd1Li4ATP8DhxcN
	 Z7WltnfxFTkww==
From: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] fs: binfmt: Fix a typo
Date: Sat,  2 Nov 2024 12:57:48 -0700
Message-Id: <173057745524.2381983.7254184868178566960.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <34b8c52b67934b293a67558a9a486aea7ba08951.1730539498.git.christophe.jaillet@wanadoo.fr>
References: <34b8c52b67934b293a67558a9a486aea7ba08951.1730539498.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 02 Nov 2024 10:25:04 +0100, Christophe JAILLET wrote:
> A 't' is missing in "binfm_misc".
> Add it.
> 
> 

Applied to for-next/execve, thanks!

[1/1] fs: binfmt: Fix a typo
      https://git.kernel.org/kees/c/2b9635cb6cf3

Take care,

-- 
Kees Cook


