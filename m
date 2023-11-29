Return-Path: <linux-fsdevel+bounces-4213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94807FDD4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AD8B20D57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB813B2AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECEDD;
	Wed, 29 Nov 2023 07:19:53 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:41778)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r8MLv-00Cf3p-Sp; Wed, 29 Nov 2023 08:19:51 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49158 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r8MLu-005gWB-Nk; Wed, 29 Nov 2023 08:19:51 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  jaegeuk@kernel.org,  linux-ext4@vger.kernel.org,
  Miklos Szeredi <miklos@szeredi.hu>,  Gabriel Krisman Bertazi
 <gabriel@krisman.be>
In-Reply-To: <20231129045313.GA1130947@ZenIV> (Al Viro's message of "Wed, 29
	Nov 2023 04:53:13 +0000")
References: <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
	<20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
	<20231127063842.GG38156@ZenIV> <20231129045313.GA1130947@ZenIV>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 29 Nov 2023 09:19:41 -0600
Message-ID: <87v89kio36.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r8MLu-005gWB-Nk;;;mid=<87v89kio36.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/b6JS6EkjAv/7bqf1Ls+CX0i6iy1ZrEtE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 555 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.8%), parse: 1.33
	(0.2%), extract_message_metadata: 18 (3.2%), get_uri_detail_list: 3.1
	(0.6%), tests_pri_-2000: 12 (2.2%), tests_pri_-1000: 3.6 (0.6%),
	tests_pri_-950: 1.52 (0.3%), tests_pri_-900: 1.28 (0.2%),
	tests_pri_-90: 133 (23.9%), check_bayes: 130 (23.5%), b_tokenize: 8
	(1.5%), b_tok_get_all: 69 (12.5%), b_comp_prob: 5 (0.9%),
	b_tok_touch_all: 44 (7.8%), b_finish: 0.86 (0.2%), tests_pri_0: 354
	(63.8%), check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 2.8
	(0.5%), poll_dns_idle: 0.80 (0.1%), tests_pri_10: 3.1 (0.6%),
	tests_pri_500: 12 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Nov 27, 2023 at 06:38:43AM +0000, Al Viro wrote:
>
>> > FWIW, I suspect that the right answer would be along the lines of
>> > 	* if d_splice_alias() does move an exsiting (attached) alias in
>> > place, it ought to dissolve all mountpoints in subtree being moved.
>> > There might be subtleties,
>
> Are there ever...  Starting with the "our test for loop creation
> (alias is a direct ancestor, need to fail with -ELOOP) is dependent
> upon rename_lock being held all along".
>
> Folks, what semantics do we want for dissolving mounts on splice?
> The situation when it happens is when we have a subtree on e.g. NFS
> and have some mounts (on client) inside that.  Then somebody on
> server moves the root of that subtree somewhere else and we try
> to do a lookup in new place.  Options:
>
> 1) our dentry for directory that got moved on server is moved into
> new place, along with the entire subtree *and* everything mounted
> on it.  Very dubious semantics, especially since if we look the
> old location up before looking for new one, the mounts will be
> dissolved; no way around that.
>
> 2) lookup fails.  It's already possible; e.g. if server has
> /srv/nfs/1/2/3 moved to /srv/nfs/x, then /srv/nfs/1/2 moved
> to /srv/nfs/x/y and client has a process with cwd in /mnt/nfs/1/2/3
> doing a lookup for "y", there's no way in hell to handle that -
> the lookup will return the fhandle of /srv/nfs/x, which is the
> same thing the client has for /mnt/nfs/1/2; we *can't* move that
> dentry to /mnt/nfs/1/2/3/y - not without creating a detached loop.
> We can also run into -ESTALE if one of the trylocks in
> __d_unalias() fails.  Having the same happen if there are mounts
> in the subtree we are trying to splice would be unpleasant, but
> not fatal.  The trouble is, that won't be a transient failure -
> not until somebody tries to look the old location up.
>
> 3) dissolve the mounts.  Doable, but it's not easy; especially
> since we end up having to redo the loop-prevention check after
> the mounts had been dissolved.  And that check may be failing
> by that time, with no way to undo that dissolving...

To be clear this is a change in current semantics and has a minuscule
change of resulting in a regression.  That should be called out in the
change log.

If we choose to change the semantics I would suggest that the new
semantics be:

If a different name for a directory already exists:
	* Detach the mounts unconditionally (leaving dentry descendants alone).
	* Attempt the current splice.
          - If the splice succeeds ( return the new dentry )
	  - If the splice fails ( fail the lookup, and d_invalidate the existing name )

Unconditionally dissolving the mounts before attempting the rename
should simplify everything.

In the worst case a race between d_invalidate and d_splice_alias will
now become a race to see who can detach the mounts first.

Eric

