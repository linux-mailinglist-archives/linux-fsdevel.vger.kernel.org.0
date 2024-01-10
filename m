Return-Path: <linux-fsdevel+bounces-7679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9FC829344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 06:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD65CB26046
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4957DF59;
	Wed, 10 Jan 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="itkeBpRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3485D52E;
	Wed, 10 Jan 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704863994; bh=ZFqJsHdUI55hZBkYEEzJTLuXuujls9l7aLJuiNvXYvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itkeBpRyBldc5BwBIwvwq3eHCZsDPB1XNpj2nMDZzsGZiKmvwyebmXcrGZbA0dAuQ
	 bKBAniHgUHxw8+U9cntFFo2N4ySJFCbG4LO1UPQUkC8KngHgFjkiaSHs1JTsGoNBcI
	 hKV/HA9p0nC6+FyAy+bFpk5NJAKslLKWaXIjgtgk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 4F126403; Wed, 10 Jan 2024 13:19:49 +0800
X-QQ-mid: xmsmtpt1704863989t1hb59c8w
Message-ID: <tencent_CF4FEF0D9B25A08DD7920E5D93DDBC194E07@qq.com>
X-QQ-XMAILINFO: MZ7OTbK+3aE5TCbKEFvzpcN4VOjdtmedTp3tsflDm/vs4acK0ZgGHjxaNrtBmh
	 uJ7JI8So0335T3YKjrBw6EHdb2wCnhu+TgFoHzeErnf+CHF3+eICZ6KkQ1MNwJZGHkGs8+yL+xaC
	 t8sFv+5Kf3o5RvvG05JMLp5UG8ZWS2XEg4yo1AxW4tB0KTAd/8/kygTi1PZJOj3SDQVxLJsG0J1X
	 UGB1S47pWyzAX10DnpQeeSiyNYyR5UjjEaNfV2WLYr7Wm+DkfCH/kmtkx95UstQWfebnAblJc3c5
	 ISZSJWTVkbpY1JMJOzHw35rMsJGRNTc3KfIF8XvlWsim9Vmm7tt8PTYHWZFZO9KnYvW50W6jfBK0
	 hoWPIWKTpVBDlaBKaSR6VmuGPk6cFfijsMZ2jUg538TS29wrgDIxjuBM1Qz8gAw+ondU4XpYah5X
	 cOgn7kQ7Oy4VLSUP+bW3W/Ihh3BI6vdbZet4OfdvvSKmtSsGE3lEs4a5adCZTj60sFfJDDWoukCM
	 516qnGZc2gVjeFFhDhlOTJ3pawF1WjOxV6uxJjGywDj6s5GEw7XljqNC/OiOQe6/UsMLInRHuKqr
	 hZRfsCLeXKgpUHGk0AHUNHPeFK4FqSmWJhNk8GwYpFDBWFyEwkWCerNl/dAN50MpmJKtjE5Hs7J2
	 g33bbVr9HUzUEhLNhOPFqUTdVQJxmEhe0q0XiUqEMU2pV5nwZgCQA7jpkTGeJGwy9Z6y3sQvogVi
	 phLyQ5acuP0nnAC043zaJ9BrCbs2SFgbVTSeWgqJiBcAmNdLO3j8Pi4qPhnxByr+YN9C8CqqPr3B
	 /OiOP3tss+bTQYGXgBJYR1UTRPgDHwLoPKb7NzgA/hBXPLNHi3qCkclgnH3NNhXz7IPAnhNB2KN0
	 jE8cMy0UhlJe19uwzd/2MCZM6pMtnMQc1rYbW+QTG9W6imwALv63rAJZT1VrhTq9gnTav+VWUOEK
	 U8N6VdiSzV1xmldGTsaw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: pengfei.xu@intel.com
Cc: ceph-devel@vger.kernel.org,
	davem@davemloft.net,
	dhowells@redhat.com,
	eadavis@qq.com,
	edumazet@google.com,
	heng.su@intel.com,
	horms@kernel.org,
	jaltman@auristor.com,
	jarkko@kernel.org,
	jlayton@redhat.com,
	keyrings@vger.kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	marc.dionne@auristor.com,
	markus.suvanto@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	smfrench@gmail.com,
	torvalds@linux-foundation.org,
	wang840925@gmail.com
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
Date: Wed, 10 Jan 2024 13:19:49 +0800
X-OQ-MSGID: <20240110051948.1546934-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 12:40:41 +0800, Pengfei Xu wrote:
> > Hi Linus, Edward,
> >
> > Here's Linus's patch dressed up with a commit message.  I would marginally
> > prefer just to insert the missing size check, but I'm also fine with Linus's
> > approach for now until we have different content types or newer versions.
> >
> > Note that I'm not sure whether I should require Linus's S-o-b since he made
> > modifications or whether I should use a Codeveloped-by line for him.
> >
> > David
> > ---
> > From: Edward Adam Davis <eadavis@qq.com>
> >
> > keys, dns: Fix missing size check of V1 server-list header
> >
> > The dns_resolver_preparse() function has a check on the size of the payload
> > for the basic header of the binary-style payload, but is missing a check
> > for the size of the V1 server-list payload header after determining that's
> > what we've been given.
> >
> > Fix this by getting rid of the the pointer to the basic header and just
> > assuming that we have a V1 server-list payload and moving the V1 server
> > list pointer inside the if-statement.  Dealing with other types and
> > versions can be left for when such have been defined.
> >
> > This can be tested by doing the following with KASAN enabled:
> >
> >         echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p
> >
> > and produces an oops like the following:
> >
> >         BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> >         Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
> >         ...
> >         Call Trace:
> >          <TASK>
> >          __dump_stack lib/dump_stack.c:88 [inline]
> >          dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> >          print_address_description mm/kasan/report.c:377 [inline]
> >          print_report+0xc3/0x620 mm/kasan/report.c:488
> >          kasan_report+0xd9/0x110 mm/kasan/report.c:601
> >          dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> >          __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
> >          key_create_or_update+0x42/0x50 security/keys/key.c:1007
> >          __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
> >          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >          do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >          entry_SYSCALL_64_after_hwframe+0x62/0x6a
> >
> > This patch was originally by Edward Adam Davis, but was modified by Linus.
> >
> > Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> > Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Tested-by: David Howells <dhowells@redhat.com>
> > cc: Edward Adam Davis <eadavis@qq.com>
> > cc: Simon Horman <horms@kernel.org>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > cc: Jarkko Sakkinen <jarkko@kernel.org>
> > cc: Jeffrey E Altman <jaltman@auristor.com>
> > cc: Wang Lei <wang840925@gmail.com>
> > cc: Jeff Layton <jlayton@redhat.com>
> > cc: Steve French <sfrench@us.ibm.com>
> > cc: Marc Dionne <marc.dionne@auristor.com>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: linux-afs@lists.infradead.org
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-nfs@vger.kernel.org
> > cc: ceph-devel@vger.kernel.org
> > cc: keyrings@vger.kernel.org
> > cc: netdev@vger.kernel.org
> > ---
> >  net/dns_resolver/dns_key.c |   19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > index 2a6d363763a2..f18ca02aa95a 100644
> > --- a/net/dns_resolver/dns_key.c
> > +++ b/net/dns_resolver/dns_key.c
> > @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
> >  static int
> >  dns_resolver_preparse(struct key_preparsed_payload *prep)
> >  {
> > -	const struct dns_server_list_v1_header *v1;
> > -	const struct dns_payload_header *bin;
> >  	struct user_key_payload *upayload;
> >  	unsigned long derrno;
> >  	int ret;
> > @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
> >  		return -EINVAL;
> >
> >  	if (data[0] == 0) {
> > +		const struct dns_server_list_v1_header *v1;
> > +
> >  		/* It may be a server list. */
> > -		if (datalen <= sizeof(*bin))
> > +		if (datalen <= sizeof(*v1))
> >  			return -EINVAL;
> >
> > -		bin = (const struct dns_payload_header *)data;
> > -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> > -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> > +		v1 = (const struct dns_server_list_v1_header *)data;
> > +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> > +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
> >  			pr_warn_ratelimited(
> >  				"dns_resolver: Unsupported content type (%u)\n",
> > -				bin->content);
> > +				v1->hdr.content);
> >  			return -EINVAL;
> >  		}
> >
> > -		if (bin->version != 1) {
> > +		if (v1->hdr.version != 1) {
> >  			pr_warn_ratelimited(
> >  				"dns_resolver: Unsupported server list version (%u)\n",
> > -				bin->version);
> > +				v1->hdr.version);
> >  			return -EINVAL;
> >  		}
> >
> > -		v1 = (const struct dns_server_list_v1_header *)bin;
> >  		if ((v1->status != DNS_LOOKUP_GOOD &&
> >  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
> >  			if (prep->expiry == TIME64_MAX)
> >
> 
> Hi Edward and kernel experts,
> 
>   Above patch(upstream commit: 1997b3cb4217b09) seems causing a keyctl05 case
> to fail in LTP:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/keyctl/keyctl05.c
> 
> It could be reproduced on a bare metal platform.
> Kconfig: https://raw.githubusercontent.com/xupengfe/kconfig_diff/main/config_v6.7-rc8
> Seems general kconfig could reproduce this issue.
> 
>   Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 failed)
> is in attached.
> 
> keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
> by strace:
> "
> [pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> [pid 863106] <... alarm resumed>)       = 30
> [pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
The reason for the failure of add_key() is that the length of the incoming data
is 5, which is less than sizeof(*v1), so keyctl05.c failed.
Suggest modifying keyctl05.c to increase the length of the incoming data to 6 
bytes or more.
> "
> 
> Passed behavior in v6.7-rc7 kernel:
> "
> [pid  6726] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> [pid  6725] rt_sigreturn({mask=[]})     = 61
> [pid  6726] <... add_key resumed>)      = 1029222644
> "
> 
> Do you mind to take a look for above issue?
Edward,
BR


