Return-Path: <linux-fsdevel+bounces-76841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMegGN4xi2kFRgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:25:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE111B321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E5130117F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B9320CAA;
	Tue, 10 Feb 2026 13:25:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6C207A32
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729945; cv=none; b=Yw5eOwPmnj5nMJBZDNbPOT9lRojF/FvLCe8dr17LsYPgErwbFbQ09o0A+BxLrJyoUrYaEyP2ZPV6jwHcTinA0Kh6rpibkHGqG5Lv3q2h+TmwpGUbOzQiRR5w0BboE5gS9fd+VzPv65n79PFVFCnTN3VOaRuv4emlkZK7FVdTMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729945; c=relaxed/simple;
	bh=kCck4bWenzpFWu4MANkgYFOOEpLKXUtX5H/gM2879Cg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PdKonv+GhhzC/+rneTZV15boU7sfv1aAz2/UGOUTlzz3O4QrYm+9VxxtF2c/9YwsB5e4Gq63kInoBFMN/e3UAqeB7msxXwkFwHLWgabCNPo5yWy1+t/CkhUQFEM/ApViNfpwM4b5Fmeym+HE/HXPQIQARozgYlJbX4mkdcSyn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61ADPZjD075429;
	Tue, 10 Feb 2026 22:25:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61ADPZtM075426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Feb 2026 22:25:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c6feb632-53a8-4f8d-887d-ac256c222cd5@I-love.SAKURA.ne.jp>
Date: Tue, 10 Feb 2026 22:25:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] HPFS changes for 6.20
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
References: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com>
 <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
 <0a4797ab-07a5-11ef-074f-19ad637f84ea@redhat.com>
 <a6c8ffeb-9e82-4cb9-b79c-2ab9dc330994@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a6c8ffeb-9e82-4cb9-b79c-2ab9dc330994@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76841-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ABE111B321
X-Rspamd-Action: no action

On 2026/02/10 21:49, Tetsuo Handa wrote:
> I posted "hpfs: make check=none mount option excludable" because syzbot is not
> the only fuzzer. Making it possible to exclude using kernel config option is
> beneficial to all fuzzers, and we can check whether the kernel config for fuzz
> testing purpose is appropriate.
> 
> But if you can accept making check=none to behave as if check=normal, I would
> suggest the following change.
> 

Hmm, since the reconfigure path does not emit "You are crazy..." message,
fuzzers might have already reported bugs after silently modifying
an error=normal mount to error=none behavior...

 fs/hpfs/super.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 371aa6de8075..a6ad9a12f239 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -442,7 +442,8 @@ static int hpfs_reconfigure(struct fs_context *fc)
 	sbi->sb_uid = ctx->uid; sbi->sb_gid = ctx->gid;
 	sbi->sb_mode = 0777 & ~ctx->umask;
 	sbi->sb_lowercase = ctx->lowercase;
-	sbi->sb_eas = ctx->eas; sbi->sb_chk = ctx->chk;
+	sbi->sb_eas = ctx->eas;
+	sbi->sb_chk = ctx->chk ? ctx->chk : 1;
 	sbi->sb_chkdsk = ctx->chkdsk;
 	sbi->sb_err = ctx->errs; sbi->sb_timeshift = ctx->timeshift;
 
@@ -615,7 +616,11 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 		if (sbi->sb_err == 0)
 			pr_err("Proceeding, but your filesystem could be corrupted if you delete files or directories\n");
 	}
-	if (sbi->sb_chk) {
+	if (!sbi->sb_chk) {
+		sbi->sb_chk = 1;
+		pr_info("check=none was obsoleted. Treating as check=normal.\n");
+	}
+	{
 		unsigned a;
 		if (le32_to_cpu(superblock->dir_band_end) - le32_to_cpu(superblock->dir_band_start) + 1 != le32_to_cpu(superblock->n_dir_band) ||
 		    le32_to_cpu(superblock->dir_band_end) < le32_to_cpu(superblock->dir_band_start) || le32_to_cpu(superblock->n_dir_band) > 0x4000) {
@@ -632,8 +637,7 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 			goto bail4;
 		}
 		sbi->sb_dirband_size = a;
-	} else
-		pr_err("You really don't want any checks? You are crazy...\n");
+	}
 
 	/* Load code page table */
 	if (le32_to_cpu(spareblock->n_code_pages))


