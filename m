Return-Path: <linux-fsdevel+bounces-37392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D89F1916
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF0C188F10E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B71974EA;
	Fri, 13 Dec 2024 22:26:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8D194C77
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128773; cv=none; b=e0s9PE/yn0WqtLiKJuHGSiycfB/fXnkfSd4kDG1GIu+rZWGulFCF3KQyIpLvOw99P1LRQUyPIxrqZwHAuI9Cw4QhnOwhp8ySGxp4jdwSrlLTtY8HCO6K6LHapAaGatvZPWf/CFqYAta4DJGQadDBSHgCz4x6kkb7YI8hn6R7kNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128773; c=relaxed/simple;
	bh=/pxDjq4KnCgLn8TDXcPlo463CGfj/1Ny0bcP+c3ucao=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=q2gbNEdTjA9Au8Kt4bvMYctY1PiWRwh4M/P3tr8aWWYji+/er6ZWo+cPW6Nbw73wnUNQ4/GaeQ7ft/9wYwcaO0+baLtxN0Ug0pJLpf2rmKqOCqrW3tqmCSSq1ea+fvh5+IsJQdxIeMxq70UDuYmlrglLsXihhtHvVLNcN5Ubca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:56506)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMDbc-009pZC-L3; Fri, 13 Dec 2024 14:53:52 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:40456 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMDbb-00AZd8-G0; Fri, 13 Dec 2024 14:53:52 -0700
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
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
	<m2pllv5lb3.wl-thehajime@gmail.com>
Date: Fri, 13 Dec 2024 15:53:44 -0600
In-Reply-To: <m2pllv5lb3.wl-thehajime@gmail.com> (Hajime Tazaki's message of
	"Sat, 14 Dec 2024 06:23:44 +0900")
Message-ID: <87r06bz1uf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1tMDbb-00AZd8-G0;;;mid=<87r06bz1uf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19KAHdFFUi5cVQHGBC8QctGuBcxACTIOzs=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Hajime Tazaki <thehajime@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 531 ms - load_scoreonly_sql: 0.09 (0.0%),
	signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.43
	(0.3%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 3.0
	(0.6%), tests_pri_-2000: 6 (1.1%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.32 (0.2%), tests_pri_-900: 1.05 (0.2%),
	tests_pri_-90: 87 (16.4%), check_bayes: 85 (16.1%), b_tokenize: 11
	(2.0%), b_tok_get_all: 12 (2.2%), b_comp_prob: 4.2 (0.8%),
	b_tok_touch_all: 56 (10.4%), b_finish: 0.92 (0.2%), tests_pri_0: 391
	(73.6%), check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.06 (0.2%), tests_pri_10: 2.6 (0.5%),
	tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Hajime Tazaki <thehajime@gmail.com> writes:

> On Sat, 14 Dec 2024 05:01:58 +0900,
> Eric W. Biederman wrote:
>
>> >> Last time I looked the regular binfmt_elf works just fine
>> >> without an mmu.  I looked again and at a quick skim the
>> >> regular elf loader still looks like it will work without
>> >> an MMU.
>> >
>> > I'm wondering how you looked at it and how you see that it works
>> > without MMU.
>>=20
>> I got as far as seeing that vm_mmap should work.  As all of the
>> bits for mmap to work, are present in both mmu and nommu.
>
> hmm, at least MAP_FIXED doesn't work in current mm/nommu.c.
> # also documented at Documentation/admin-guide/mm/nommu-mmap.rst.

Yes, and that fundamentally makes sense.

>> > I also wish to use the regular binfmt_elf, but it doesn't allow me to
>> > compile with !CONFIG_MMU right now.
>>=20
>> Then I may simply be confused.  Where does the compile fail?
>> Is it somewhere in Kconfig?
>>=20
>> I could be completely confused.  It has happened before.
>
> If I applied to below in addition to my whole patchset,
>
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 419ba0282806..b34d0578a22f 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -4,7 +4,6 @@ menu "Executable file formats"
>=20=20
>  config BINFMT_ELF
>         bool "Kernel support for ELF binaries"
> -       depends on MMU
>         select ELFCORE
>         default y
>         help
> @@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && =
!MMU)
> +       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual l=
oad

You have my apologies I was most definitely confused.  BINFMT_ELF
currently does not work without an MMU.

> this is the output from `make ARCH=3Dum`.
>
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   CC      fs/binfmt_elf.o
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ../include/linux/compiler.h:317,
>                  from ../include/linux/build_bug.h:5,
>                  from ../include/linux/container_of.h:5,
>                  from ../include/linux/list.h:5,
>                  from ../include/linux/module.h:12,
>                  from ../fs/binfmt_elf.c:13:
> ../fs/binfmt_elf.c: In function =E2=80=98load_elf_binary=E2=80=99:
> ../include/asm-generic/rwonce.h:44:71: error: lvalue required as unary =
=E2=80=98&=E2=80=99 operand
>    44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(=
x) *)&(x))
>       |                                                                  =
     ^
> ../include/asm-generic/rwonce.h:50:9: note: in expansion of macro =E2=80=
=98__READ_ONCE=E2=80=99
>    50 |         __READ_ONCE(x);                                          =
       \
>       |         ^~~~~~~~~~~
> ../fs/binfmt_elf.c:1006:49: note: in expansion of macro =E2=80=98READ_ONC=
E=E2=80=99
>  1006 |         const int snapshot_randomize_va_space =3D READ_ONCE(rando=
mize_va_space);
>       |=20=20=20
>
> I avoided this issue (with nasty MAP_FIXED workaround) but there seems
> to be still a lot of things that I need to fix to work with nommu.

Yes, at a minimum all of the MAP_FIXED code would need to be
conditionalized on having an MMU.
>
>> I just react a little strongly to the assertion that elf_fdpic is
>> the only path when I don't see why that should be.
>>=20
>> Especially for an architecture like user-mode-linux where I would expect
>> it to run the existing binaries for a port.
>
> I understand your concern, and will try to work on improving this
> situation a bit.
>
> Another naive question: are there any past attempts to do the similar
> thing (binfmt_elf without MMU) ?

At this point what I would recommend is:

Merge your original patch.  Get nommu UML working with binfmt_elf_fdpic.c.
I think it is a proper superset of ELF functionality.

Then I would make it a long term goal to see about removing redundancy
between binfmt_elf.c and binfmt_elf_fdpic.c with a view to merging them
in the long term.

There is a lot of mostly duplicate code between the two and
binfmt_elf_fdpic.c does not get half the attention and use binfmt_elf.c
gets.

Eric


