Return-Path: <linux-fsdevel+bounces-71719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA7CCEF2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E08B300F653
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDD2E7657;
	Fri, 19 Dec 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFqc9JjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FE2FC86C;
	Fri, 19 Dec 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132006; cv=none; b=tDVGTFWDibIMC0qyBmkoVsUiHmLsHrldM+LlGHQnyb9Z6NJXm7qMAB7XZth45xBuZ1TsyDd9N+RNmRm7MeFttxbkI5PwFEiFIVVpXpLAsvyXryyqiRXSduIv45vppM7zYuALt+yHRnOnGlGZSLqb3Geo2YaiWwLJVTr2wQZUWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132006; c=relaxed/simple;
	bh=VFiTUqFKrbPqxZ9+NNyag6Ajy0uzkayrmpB0IcPZ4PU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MuEY1KiRF7TOPJqK1B4dwip8b3S6aP+k241zHqG6BB/WxDctvECxT75eqC1IzMn2gen5o1Sa7t/uu1mXEMRr+v81CmXQCmLdWl9iS924AhYuYYJoNV6TJyJ309Py2bGeGspmJIU0mTC9qouUm5+hMf7C+TJYXbdQWxZHr+KJBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFqc9JjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483C9C116D0;
	Fri, 19 Dec 2025 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766132006;
	bh=VFiTUqFKrbPqxZ9+NNyag6Ajy0uzkayrmpB0IcPZ4PU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFqc9JjXV4mr5LizAyAg0tm5CJ5+ZKRz2e441pHxsOiibmeY59xqgqo0crFansJqy
	 P4iE+LwFzjEO14DLRaSWWuqKz/n7erWqILtXs9Lv/MNRN1owKC0LAzXRhNgKAx58lp
	 tCR21R2Dw0bWznLJdN91LGXcdkvn7rx4jeDVemHE8IzxC1Y4JBCay11De2Xm5vEcbu
	 /4J0e8p+7t4L6eUrHmM/cZpJ3p6Ww14fgV6pv5nQ+0hOx32UTmjPSSI9YD07/Dl1O5
	 ++5+k0gllM3NNDpP4jmGzEK4n89hxvNhgOvvTI0omoe5NZ2P4gzH53HInU9C88e17j
	 c8ndEnoCuJn4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79F14380AA50;
	Fri, 19 Dec 2025 08:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch V6 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613181528.3684357.16950067300895090684.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:15 +0000
References: <877bweujtn.ffs@tglx>
In-Reply-To: <877bweujtn.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, ylavic.dev@gmail.com,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, lkp@intel.com,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org,
 palmer@dabbelt.com, hca@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org,
 mathieu.desnoyers@efficios.com, andrew.cooper3@citrix.com,
 david.laight.linux@gmail.com, Julia.Lawall@inria.fr, nicolas.palix@imag.fr,
 peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Wed, 29 Oct 2025 10:40:52 +0100 you wrote:
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:
> 
> bool foo(u32 __user *p, u32 val)
> {
> 	scoped_guard(pagefault)
> 		unsafe_put_user(val, p, efault);
> 	return true;
> efault:
> 	return false;
> }
> 
> [...]

Here is the summary with links:
  - [V6,02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
    https://git.kernel.org/riscv/c/3eb6660f26d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



