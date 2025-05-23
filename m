Return-Path: <linux-fsdevel+bounces-49750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC38AC1F35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C70F3A7E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E12248BB;
	Fri, 23 May 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBBddXGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2F2236EB;
	Fri, 23 May 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990994; cv=none; b=TIutPAXPNJgpJqVEUUD9BmvxkMTYbWoRPkVOeyMKsS9vH+FIPWzzUHFJBvIgjCG1vcjmUvhCiZYKbCoRNmgj0a2QOoKMdYrPCxrPTddehuDrn+40k6ET2JrdyrX8Q8VJRRyWywt5EUs4k4H073FYoDua/dYr/AnNJiHjeCEsUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990994; c=relaxed/simple;
	bh=fgNdYJ6Icfxm1rufblmWWRmhDfarblHEjveCv2W+a0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNwcLI2HgF70lJc+5+6fXKea7fzEm76QBR70B/dvyngMu4P9ZEDJoUdOzVDYcUl18TS/GA++NHuLiqSymYCQiF+CvHiFgpi7bZlpjvZ4ue8fGU7zegYoKRd7++U7eqRcrzwSq9rhlmhdyZNAsvMyDQxeb36M0ehK17kP7DaoYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBBddXGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9612CC4CEE9;
	Fri, 23 May 2025 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747990994;
	bh=fgNdYJ6Icfxm1rufblmWWRmhDfarblHEjveCv2W+a0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBBddXGLSkGmKOnmELz/5WhFuBXe0qFz98yo/sL3VR/jY3YKPUjJLiPs4J60cICJS
	 15W+zbxLlX5Xt7IcrIDVw8DwIDDA1S8Q+Sx8bHTjMjyDxBZFEuIJrm0WuOUXJAjEsF
	 TKloFbxJANvIEF/VpNrVLyi1kxeAkz9y3eMV9ShtcRejhK8aMDdRXWQNFBfttDizjK
	 +PX3HGhgczz9V18sAFnaKjhxAArqDTEo0K+1i/Lo74i8Ibv85mGJHLqx9XC/VPbX+E
	 HDcD6ltsNrpYqSoE3Cgf1484Q5Zl4vvIu6WIF+8g/8BTcuUwQ/2RBXLMKGa0LxqZzf
	 taReSpOAAriBg==
Date: Fri, 23 May 2025 11:03:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	linux-fsdevel@vger.kernel.org, linux-mips@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: mips gcc-12 malta_defconfig 'SOCK_COREDUMP' undeclared (first
 use in this function); did you mean 'SOCK_RDM'?
Message-ID: <20250523-genannt-anwalt-7c1f3c6bc4e1@brauner>
References: <CA+G9fYsZPSJ55FQ9Le9rLQMVHaHyE5kU66xqiPnz6mmfhvPfbQ@mail.gmail.com>
 <70d46cd3-80f4-4f5e-b0fc-fa2a6f284404@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zlqp6i2j7vfr5zzm"
Content-Disposition: inline
In-Reply-To: <70d46cd3-80f4-4f5e-b0fc-fa2a6f284404@app.fastmail.com>


--zlqp6i2j7vfr5zzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, May 22, 2025 at 04:01:53PM +0200, Arnd Bergmann wrote:
> On Thu, May 22, 2025, at 15:22, Naresh Kamboju wrote:
> 
> > ## Build log
> > net/unix/af_unix.c: In function 'unix_find_bsd':
> > net/unix/af_unix.c:1152:21: error: 'SOCK_COREDUMP' undeclared (first
> > use in this function); did you mean 'SOCK_RDM'?
> >  1152 |         if (flags & SOCK_COREDUMP) {
> 
> SOCK_COREDUMP should be defined outside of ARCH_HAS_SOCKET_TYPES.
> How about reducing the scope of that check like this?
> 
>       Arnd

I applied the appended patch.

--zlqp6i2j7vfr5zzm
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mips-net-ensure-that-SOCK_COREDUMP-is-defined.patch"

From 4e83ae6ec87dddac070ba349d3b839589b1bb957 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 May 2025 10:47:06 +0200
Subject: [PATCH] mips, net: ensure that SOCK_COREDUMP is defined

For historical reasons mips has to override the socket enum values but
the defines are all the same. So simply move the ARCH_HAS_SOCKET_TYPES
scope.

Fixes: a9194f88782a ("coredump: add coredump socket")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/mips/include/asm/socket.h | 9 ---------
 include/linux/net.h            | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/socket.h b/arch/mips/include/asm/socket.h
index 4724a563c5bf..43a09f0dd3ff 100644
--- a/arch/mips/include/asm/socket.h
+++ b/arch/mips/include/asm/socket.h
@@ -36,15 +36,6 @@ enum sock_type {
 	SOCK_PACKET	= 10,
 };
 
-#define SOCK_MAX (SOCK_PACKET + 1)
-/* Mask which covers at least up to SOCK_MASK-1.  The
- *  * remaining bits are used as flags. */
-#define SOCK_TYPE_MASK 0xf
-
-/* Flags for socket, socketpair, paccept */
-#define SOCK_CLOEXEC	O_CLOEXEC
-#define SOCK_NONBLOCK	O_NONBLOCK
-
 #define ARCH_HAS_SOCKET_TYPES 1
 
 #endif /* _ASM_SOCKET_H */
diff --git a/include/linux/net.h b/include/linux/net.h
index 139c85d0f2ea..f60fff91e1df 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -70,6 +70,7 @@ enum sock_type {
 	SOCK_DCCP	= 6,
 	SOCK_PACKET	= 10,
 };
+#endif /* ARCH_HAS_SOCKET_TYPES */
 
 #define SOCK_MAX (SOCK_PACKET + 1)
 /* Mask which covers at least up to SOCK_MASK-1.  The
@@ -83,8 +84,6 @@ enum sock_type {
 #endif
 #define SOCK_COREDUMP	O_NOCTTY
 
-#endif /* ARCH_HAS_SOCKET_TYPES */
-
 /**
  * enum sock_shutdown_cmd - Shutdown types
  * @SHUT_RD: shutdown receptions
-- 
2.47.2


--zlqp6i2j7vfr5zzm--

