Return-Path: <linux-fsdevel+bounces-3952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9C7FA581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3958D2817AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4334CFC;
	Mon, 27 Nov 2023 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B3B4;
	Mon, 27 Nov 2023 08:01:45 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:53182)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7e3M-00Ahie-5g; Mon, 27 Nov 2023 09:01:44 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:51768 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7e3K-006NOb-0n; Mon, 27 Nov 2023 09:01:43 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org,  Miklos Szeredi <miklos@szeredi.hu>
References: <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
	<20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
	<20231127063842.GG38156@ZenIV>
	<87jzq3nqos.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Nov 2023 10:01:34 -0600
In-Reply-To: <87jzq3nqos.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 27 Nov 2023 09:47:47 -0600")
Message-ID: <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r7e3K-006NOb-0n;;;mid=<878r6jnq1t.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18LzyKBjPL9+mOeggwlTuuNaPzk+DvVEcQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1572 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 12 (0.8%), b_tie_ro: 10 (0.6%), parse: 1.54
	(0.1%), extract_message_metadata: 48 (3.1%), get_uri_detail_list: 1.85
	(0.1%), tests_pri_-2000: 66 (4.2%), tests_pri_-1000: 3.9 (0.2%),
	tests_pri_-950: 1.64 (0.1%), tests_pri_-900: 30 (1.9%), tests_pri_-90:
	340 (21.6%), check_bayes: 337 (21.5%), b_tokenize: 15 (1.0%),
	b_tok_get_all: 65 (4.1%), b_comp_prob: 2.9 (0.2%), b_tok_touch_all:
	201 (12.8%), b_finish: 1.20 (0.1%), tests_pri_0: 1017 (64.7%),
	check_dkim_signature: 0.73 (0.0%), check_dkim_adsp: 18 (1.2%),
	poll_dns_idle: 15 (0.9%), tests_pri_10: 4.2 (0.3%), tests_pri_500: 43
	(2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> I am confused what is going on with ext4 and f2fs.  I think they
> are calling d_invalidate when all they need to call is d_drop.

ext4 and f2f2 are buggy in how they call d_invalidate, if I am reading
the code correctly.

d_invalidate calls detach_mounts.

detach_mounts relies on setting D_CANT_MOUNT on the top level dentry to
prevent races with new mounts.

ext4 and f2fs (in their case insensitive code) are calling d_invalidate
before dont_mount has been called to set D_CANT_MOUNT.

Eric


