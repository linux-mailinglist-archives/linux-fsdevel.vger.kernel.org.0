Return-Path: <linux-fsdevel+bounces-12963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE66869A7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7643A1C234EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FA145B2A;
	Tue, 27 Feb 2024 15:36:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D521DFF5;
	Tue, 27 Feb 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048181; cv=none; b=GCbw7/sUvCs7pE/3C50YKCxPshVEqqe9uuiUrMHlfpeWkNcjXeN/JP6boFaVKncCMRa9VJ9rX9e+GuBhPqQALd8VR7AXoMpTPWt9GypzLZFxg1MamPmjoUBGmvoBxWsmWklWHv18foZKX19vmcj5gh9Wt4D63BYGIp8eFxaF8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048181; c=relaxed/simple;
	bh=YrHLHMpFjmFGzgowBWH/3W3TMycwyDVhBWgkPqBFGzY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=t+ovZnKI8wQLto50ZC2p5GcKfxjDNLs1NVXswxwQjoGgi+8Y9fJEgBYtaL/0qmcwaqb6d1lEXaQJKJTdQm0JBjGYkz54HZQT5ky1E9UyqZfr2IQVS1wlVN6h2/UpgL1Ixjf5DOnjOxVIFEZA3QBx6zozRIft2QiJ04iyWSaLpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:55678)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rezV2-008pdi-Mz; Tue, 27 Feb 2024 08:36:08 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42208 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rezV1-009PTZ-Ga; Tue, 27 Feb 2024 08:36:08 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Bujak <j@exia.io>,  Pedro Falcato <pedro.falcato@gmail.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
	<CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
	<f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
	<202402261821.F2812C9475@keescook>
Date: Tue, 27 Feb 2024 09:35:39 -0600
In-Reply-To: <202402261821.F2812C9475@keescook> (Kees Cook's message of "Mon,
	26 Feb 2024 18:23:15 -0800")
Message-ID: <878r35rkc4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rezV1-009PTZ-Ga;;;mid=<878r35rkc4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+N1hetAe26OvEK48+xJsS4k19zKBNTClY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4092]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 392 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.0 (1.0%), b_tie_ro: 2.8 (0.7%), parse: 0.65
	(0.2%), extract_message_metadata: 11 (2.7%), get_uri_detail_list: 1.43
	(0.4%), tests_pri_-2000: 17 (4.3%), tests_pri_-1000: 1.85 (0.5%),
	tests_pri_-950: 0.99 (0.3%), tests_pri_-900: 0.75 (0.2%),
	tests_pri_-90: 112 (28.5%), check_bayes: 110 (28.0%), b_tokenize: 6
	(1.4%), b_tok_get_all: 8 (2.1%), b_comp_prob: 1.76 (0.4%),
	b_tok_touch_all: 91 (23.1%), b_finish: 0.75 (0.2%), tests_pri_0: 232
	(59.2%), check_dkim_signature: 0.37 (0.1%), check_dkim_adsp: 4.9
	(1.2%), poll_dns_idle: 3.2 (0.8%), tests_pri_10: 2.6 (0.7%),
	tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Kees Cook <keescook@chromium.org> writes:

> On Tue, Jan 23, 2024 at 12:23:27AM +0900, Jan Bujak wrote:
>> On 1/22/24 23:54, Pedro Falcato wrote:
>> > Hi!
>> > 
>> > Where did you get that linker script?
>> > 
>> > FWIW, I catched this possible issue in review, and this was already
>> > discussed (see my email and Eric's reply):
>> > https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com/
>> > 
>> > This was my original testcase
>> > (https://github.com/heatd/elf-bug-questionmark), which convinced the
>> > loader to map .data over a cleared .bss. Your bug seems similar, but
>> > does the inverse: maps .bss over .data.
>> > 
>> 
>> I wrote the linker script myself from scratch.
>
> Do you still need this addressed, or have you been able to adjust the
> linker script? (I ask to try to assess the priority of needing to fix
> this behavior change...)

Kees, I haven't had a chance to test this yet but it occurred to me
that there is an easy way to handle this.  In our in-memory copy
of the elf program headers we can just merge the two segments
together.

I believe the diff below accomplishes that, and should fix issue.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..01df7dd1f3b4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -924,6 +926,31 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {
+		case PT_LOAD:
+		{
+			/*
+			 * Historically linux ignored all but the
+			 * final .bss segment.  Now that linux honors
+			 * all .bss segments, a .bss segment that
+			 * logically is not overlapping but is
+			 * overlapping when it's edges are rounded up
+			 * to page size causes programs to fail.
+			 *
+			 * Handle that case by merging .bss segments
+			 * into the segment they follow.
+			 */
+			if (((i + 1) >= elf_ex->e_phnum) ||
+			    (elf_ppnt[1].p_type != PT_LOAD) ||
+			    (elf_ppnt[1].p_filesz != 0))
+				continue;
+			unsigned long end =
+				elf_ppnt[0].p_vaddr + elf_ppnt[0].p_memsz;
+			if (elf_ppnt[1].p_vaddr != end)
+				continue;
+			elf_ppnt[0].p_memsz += elf_ppnt[1].p_memsz;
+			elf_ppnt[1].p_type = PT_NULL;
+			break;
+		}
 		case PT_GNU_STACK:
 			if (elf_ppnt->p_flags & PF_X)
 				executable_stack = EXSTACK_ENABLE_X;

