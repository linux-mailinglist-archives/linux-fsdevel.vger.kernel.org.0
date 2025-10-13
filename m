Return-Path: <linux-fsdevel+bounces-63904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38102BD1605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 06:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EFAA4E461D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F528E571;
	Mon, 13 Oct 2025 04:28:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F425233D9E;
	Mon, 13 Oct 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329700; cv=none; b=ZJSsqMAXfpo0wBCFE+8LJ7JyKJw/m/Lws7j36fbnH/tlXctl2grgOkPpmi15GrF9760mcL3rLosyKFIVbr2E2BkbMLCovaKjzMUdo9uDjQ9MNZUWUZgHem3N3j+6opAXZT5t//lrYV52YvqjAN7gS6xpq79QT2lmwrK66RJhiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329700; c=relaxed/simple;
	bh=D2j4VRk7a14GHI55HmxdAs/3Rt4Jbr/RtZrqE5xz2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEQBo6GGcOPzD5Wg5lv5ZDEQT6Iw86NMXRHy2kw6t6YZHBAAuZkaQ/hO7Y1LlG58AzqK8csuXm6IeiJKJUnew+tzhbrbWEnCTCaVFar29JQzE+Gns2Vpiz4bTn1+RHRkq1x8RnFPhMBXhSOBGPtWHY1XN+6Q/JZmCZ8hsFyBA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-b9-68ec7fdcf266
Date: Mon, 13 Oct 2025 13:28:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 09/47] arm64, dept: add support
 CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Message-ID: <20251013042807.GB6925@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-10-byungchul@sk.com>
 <aN_fel4Rpqz6TPsD@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_fel4Rpqz6TPsD@J2N7QTR9R3>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0zMcRzH9/39v+P069R8k82cNVsbyWx9NmZ4YL8HTGYzfx5w9ONu6til
	KLPKvw6xnA3dLXXoOlzkGpLiRKVLKUs7UbhocTl13TWqu7k7M569vu/3Z6/v58GHI+U99GxO
	rTkgajXKdAUjpaTfp5sW9uUNqxbf1UVBT4Gdgs7btxAE9M0sXOzSk+B+5kXww1yEwDBoZOGz
	vRBB2dUaBibbX5EwVB16NliOMvCl+B4JpUY9gmPX7jDQ5Z4i4IN5kALjpSECzPkJ4LIYWHAP
	6hnwdX8iQFfnp8B08joF9Q2tFOgCPgTNtS4Ciqrv0dBpb6OhrfkFBZ8+OmmoaX9JQpXnKgNm
	/w8WWs7aCajweUhw9I2xcOF1OQMTlU0IHBMOArylQRpudYW+LjiHQPd8nISf1QM0lPqSoSrQ
	g8DY1M+uXCxYr1iRMDmhR0JF2zAjTPjfMML59oXCQ0MfK5TbsoQaS6Jwrf4rIZi8flqw3TzF
	CO976hnB09HBCldaNwhPSq2s8C44QKbGbZUuTxPT1dmiNmnFDqnKNWin9ttiDllOnafz0feo
	00jCYX4prnpnoP9y2YPjVJgpPgFXjldGmOEXYKfzFxnmmBAX1flCuZQjeVM8brB2RoqZ/HY8
	daObCLOMT8HvbaNEeEjOH0U4/46O/FNE49aSzxErySdiZ/BraIgLcTyuDHLhWBKKTQ9HIgvF
	8vOx/X5LxIP5fgke9ZxAfzaNw08tTqoY8Yb/tIb/tIZ/2nJE3kRytSY7Q6lOX7pIlaNRH1q0
	a1+GDYWuzXxkalst8nZubEQ8hxTTZapHbpWcVmZn5mQ0IsyRihhZyuFhlVyWpszJFbX7tmuz
	0sXMRhTPUYpZsiXjB9Pk/B7lAXGvKO4XtX9bgpPMzkdz8ua6O3rT6Nje1MliY7Sidtqcg7uS
	e+PPRu+8VFaM512uS3a4StpXeJ6ht99a/IWP+198SPLG0Zq3qbnB4bGMgb7AWFKMI6r2zTqj
	ZXzNlnm5uw+vPlMyYimQxCqzRtZLt03rrl43P88y5C0MrBqdYUipcEna/Gs3LysY2WRtalJQ
	mSplciKpzVT+BqaXzE1pAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89z73Bc6ul07jDeQJUs3Y8SoM7p4Msxi/KB3LDP7sMTMxGAz
	b2zDm2kRxcUIFCI6o7SzdLSKFEep0AkWlCHpJBjrgFWpVGWOipgKVNoxWYtDSvGWZZlfTn7n
	/3LyfHhYUpGg0llNQZGoLVDlKWkZlu3M0q8dORZWf/T7i9XwoKwHQyxaheFcq5OGKlctBYOX
	WxCMxqoQvJy3klDZtYhhwehhIDr3BwOLbg+CGp+RBGdHGQF/tyVomLo5g8A0FqTBHCrDMG0/
	hcAybmUgdGsHREa7KVgMTBDwcDaMwB5MEBDsOY5goSYXLjS00zDvvUuC2TSIwDYWIGGyTTI7
	PI8RuB3lNDyrvkrCUPBt8MemaegzfUdDxHeOgD/baKgvd1Nw3mpEoL/YSkPNeReGrifXGfBN
	xQkYqTES0OL6Akbt4xgGqhsI6X1S6soKsJr1hDQmCTD91E3AnL2Zgd8ujmCwl64Eq3eIgqcO
	CwPxsQ2wWF8InpYJBgJnTBguR+5SW01IeFl5GgvN7dcIofLeAi0465xImH9lREK0UU8KldXS
	ejM8TQoV7YeExoEwLbyK3acF92w9FvobeMHgXSt0WQKMUPHLI+bLT3bLtuwT8zTFonb9p3tl
	6qfjPfiAK+2w44SBKkWRd06iFJbnNvEXOitwkjG3km+abVpimlvFDw/PkUlOk/jU9aiky1iS
	s2XwbufgkvEul8PHL/mJJMu5zfyI6wWRDCm4csSXtlaR/xrL+L7a4NJVksvkhxMhKcRKnME3
	JdiknCLJtq6/qCQv5z7ge67dJqqR3PJG2/JG2/J/ux6RzShNU1Ccr9LkfbxOl6suKdAcXvdN
	Yb4LSb/SfjRu+BlFh3b0Io5FylS5untKraBUxbqS/F7Es6QyTb7527BaId+nKjkiagtztAfz
	RF0vymCxcoU8e5e4V8HtVxWJuaJ4QNT+5xJsSnopavznkR+fyDkZOHtcf+f5j1lnFRMtX7X2
	RTfKfP2h9DX+eXJLaNuRnbHs3u3esgann+Ft34/1v0cdelY3MGNYvudewKCd+GxyTXnEQXm3
	vu/+nMlMXWa+6nqr88YuWx16/uuxBarzccfMDxXZDl+7L27+8ODXp4n81LmsGY/PXlukxDq1
	akMmqdWpXgMpcDDEkQMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 03:36:42PM +0100, Mark Rutland wrote:
> On Thu, Oct 02, 2025 at 05:12:09PM +0900, Byungchul Park wrote:
> > dept needs to notice every entrance from user to kernel mode to treat
> > every kernel context independently when tracking wait-event dependencies.
> > Roughly, system call and user oriented fault are the cases.
> >
> > Make dept aware of the entrances of arm64 and add support
> > CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  arch/arm64/Kconfig          | 1 +
> >  arch/arm64/kernel/syscall.c | 7 +++++++
> >  arch/arm64/mm/fault.c       | 7 +++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e9bbfacc35a6..a8fab2c052dc 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -281,6 +281,7 @@ config ARM64
> >       select USER_STACKTRACE_SUPPORT
> >       select VDSO_GETRANDOM
> >       select VMAP_STACK
> > +     select ARCH_HAS_DEPT_SUPPORT
> >       help
> >         ARM 64-bit (AArch64) Linux support.
> >
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index c442fcec6b9e..bbd306335179 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/randomize_kstack.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/dept.h>
> >
> >  #include <asm/debug-monitors.h>
> >  #include <asm/exception.h>
> > @@ -96,6 +97,12 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >        * (Similarly for HVC and SMC elsewhere.)
> >        */
> >
> > +     /*
> > +      * This is a system call from user mode.  Make dept work with a
> > +      * new kernel mode context.
> > +      */
> > +     dept_update_cxt();
> 
> As Mark Brown pointed out in his replies, this patch is missing a whole
> bunch of cases and does not work correctly as-is.
> 
> As Dave Hansen pointed out on the x86 patch, you shouldn't do this
> piecemeal in architecture code, and should instead work with the
> existing context tracking, e.g. by adding logic to
> enter_from_user_mode() and exit_to_user_mode(), or by reusing some

I will consider it.  However, I need to check if there are not any waits
and events before enter_from_user_mode(), or after exit_to_user_mode()
since those functions aren't the outmost functions for kernel mode C
code anyway.

	Byungchul

> existing context tracking logic that's called there.
> 
> Mark.

