Return-Path: <linux-fsdevel+bounces-37369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B019F1758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5044D1682D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792919146E;
	Fri, 13 Dec 2024 20:25:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B918F2FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121527; cv=none; b=rTUo4/QhNq2rz9pv1CoYCNrR/YBopwlNO6ZHFBQrjBD1DgGUqXpGN8diN+q+bebgHcarROCEY+FgYzxb9l6JwY0TInzCrVcJghGU8VRFbWpQX9P1wM9AuK0b6vbfT6BwSEzzN0VcusOGteKUSDxP6sOu6eD568Q+88A60TXfITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121527; c=relaxed/simple;
	bh=bRbW3/CkZ7HOz58/+7/QtFWUdnC5YaUbGt9M9hIsQSo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=KFN7QDtKCyuEHvErdk7mR2qIQD2eFFrPgqFXOi4B1I/gk+jpbi5Bg0v04nf8czmJzDHIVO/vx7CqzbnZlmTrCjQAoGZujp+niCCsj5yxmHjjKQepB4ZCcC+38iVSo+Pw+DlGVvMjpS+nW3HQmdLYLgKQ+k7GeaYNBtEutf2Pmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:56908)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMBrx-001B4G-AP; Fri, 13 Dec 2024 13:02:37 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:35748 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMBrw-002tmk-00; Fri, 13 Dec 2024 13:02:36 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org,  ricarkol@google.com,
  Liam.Howlett@oracle.com,  kees@kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  jack@suse.cz,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
Date: Fri, 13 Dec 2024 14:01:58 -0600
In-Reply-To: <m2r06c59t9.wl-thehajime@gmail.com> (Hajime Tazaki's message of
	"Fri, 13 Dec 2024 16:19:46 +0900")
Message-ID: <87bjxf1he1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tMBrw-002tmk-00;;;mid=<87bjxf1he1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19sW1PHOHAP9tXVu8GxcVgFKkZKUriqvqM=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4885]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Hajime Tazaki <thehajime@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 10 (2.4%), b_tie_ro: 9 (2.1%), parse: 1.02 (0.2%),
	 extract_message_metadata: 3.6 (0.8%), get_uri_detail_list: 1.59
	(0.4%), tests_pri_-2000: 3.4 (0.8%), tests_pri_-1000: 2.6 (0.6%),
	tests_pri_-950: 1.38 (0.3%), tests_pri_-900: 1.13 (0.3%),
	tests_pri_-90: 118 (26.8%), check_bayes: 116 (26.3%), b_tokenize: 7
	(1.6%), b_tok_get_all: 25 (5.6%), b_comp_prob: 4.2 (1.0%),
	b_tok_touch_all: 76 (17.2%), b_finish: 0.99 (0.2%), tests_pri_0: 280
	(63.5%), check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 2.7
	(0.6%), poll_dns_idle: 0.58 (0.1%), tests_pri_10: 2.2 (0.5%),
	tests_pri_500: 9 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Hajime Tazaki <thehajime@gmail.com> writes:

> Hello Eric,
>
> thanks for the feedback.
>
> On Thu, 12 Dec 2024 23:22:47 +0900,
> Eric W. Biederman wrote:
>> 
>> Hajime Tazaki <thehajime@gmail.com> writes:
>> 
>> > As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
>> > loader, FDPIC ELF loader.  In this commit, we added necessary
>> > definitions in the arch, as UML has not been used so far.  It also
>> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
>> 
>> Why does the no mmu case need an alternative elf loader?
>
> I was simply following the way how other nommu architectures (riscv,
> etc) did.
>
>> Last time I looked the regular binfmt_elf works just fine
>> without an mmu.  I looked again and at a quick skim the
>> regular elf loader still looks like it will work without
>> an MMU.
>
> I'm wondering how you looked at it and how you see that it works
> without MMU.

I got as far as seeing that vm_mmap should work.  As all of the
bits for mmap to work, are present in both mmu and nommu.

>> You would need ET_DYN binaries just so they will load and run
>> in a position independent way.  But even that seems a common
>> configuration even with a MMU these days.
>
> Yes, our perquisite for this nommu port is to use PIE binaries so,
> ET_DYN assumption works fine for the moment.
>
>> There are some funny things in elf_fdpic where it departs
>> from the ELF standard and is no fun to support unless it
>> is necessary.  So I am not excited to see more architectures
>> supporting ELF_FDPIC.
>
> I understand.
>
> I also wish to use the regular binfmt_elf, but it doesn't allow me to
> compile with !CONFIG_MMU right now.

Then I may simply be confused.  Where does the compile fail?
Is it somewhere in Kconfig?

I could be completely confused.  It has happened before.

I just react a little strongly to the assertion that elf_fdpic is
the only path when I don't see why that should be.

Especially for an architecture like user-mode-linux where I would expect
it to run the existing binaries for a port.

> I've played a little bit with touching binfmt_elf.c, but not finished
> yet with a trivial attempt.
>
> sorry, i'm not familiar with this part but wish to fix it for
> nommu+ET_EYN if possible with a right background information.

Eric


