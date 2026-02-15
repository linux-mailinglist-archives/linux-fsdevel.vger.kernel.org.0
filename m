Return-Path: <linux-fsdevel+bounces-77246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGnBNixrkWkJigEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 07:43:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC113E247
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D3053026AB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0227B347;
	Sun, 15 Feb 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=dirk.behme@gmx.de header.b="kxYs6qEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C74C97;
	Sun, 15 Feb 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771137784; cv=none; b=Ex9SixDSK4nkrTcoq044famr0e5WY3Do2/whVLwQnckdAaOZQDs59vKN60TgrCUi8kutD2yGo3eLWLYQVGV2wTayLSL77tWhnvzxgZXvX3dxVWVfhY1MwE2qMsgyJyXI+NLvrfELEz7qJlPPjKjfPiSld3EgAVmXBzvZz9ioDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771137784; c=relaxed/simple;
	bh=7cFx0wxiBt2oOL6vallIz5WVa9qyZze8EQtIXIrvi3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z88etidK5uXXch8R+6Cs1VBqbF1AebyGb3gzJudEV47EO3QK/bj2oEM1rVhviO3+aE2jr0ShFJ6T9POxJx4tMQSYaoPhAMXkr6dDDXIlkUPZs+YXFJt9DTQkndJLdpVCfVoqOxv/jRrLxER9tB+CMuazNKGsQiWUCHxFywHpO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=dirk.behme@gmx.de header.b=kxYs6qEq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771137759; x=1771742559; i=dirk.behme@gmx.de;
	bh=AdcHYF4G/k6Zrjgfn4uMhaEygzOQ4eiFPqSXvL8Shyw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kxYs6qEqggL4ULenD08/H++rJS0Qa/he2vbgbQgsRcdvarSVx5NCEuvol5nZwqF1
	 gMmKWgicGg4pKMqidqBV9UV9zpqaX4hWeJ/okoQKhAXHSFzRaNopdmIEt/7T5nsPf
	 P6Zn6sCQjN5LXQ6Ki/BZY2JqtYZIIH4rDUFAQzWdw00Po45heUOMN1R7uaTRpt4KD
	 LFsXG6c25x4RjQb8bDxc9Wj/uJv5oDgu42hMlr0sqZuP1sf1bjpK1eLbG5GsRhiLq
	 rwbDKh3cMZ2k1p/mz3PK56xYvZyaEtSslfwY3WbwIdo0k1DijkkubS+3volbhR5Tk
	 L6HHLjNGIwoifE21sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.42] ([84.129.20.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1wKXx63E5K-00OJ5P; Sun, 15
 Feb 2026 07:42:39 +0100
Message-ID: <ab0b9f9c-3a05-42f3-b4a7-ddb6ab0d37a4@gmx.de>
Date: Sun, 15 Feb 2026 07:42:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 31/42] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
 netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com,
 corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, wangkefeng.wang@huawei.com, broonie@kernel.org,
 kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
 ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
 baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-32-byungchul@sk.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmx.de>
In-Reply-To: <20251205071855.72743-32-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aWhWMgelEECPmC8s4cDGobXX6S7QtiNME6Biy1AWp+3e//5sbQ5
 y9wEC0GO6LExJy0TTxPgi7hn9knznFwU+a3hirtKlPOCAxJAmR+f4VZcqBi5p6St8Nc30fU
 oiV/7SpKGjIQCoOsBc01ZMd0fVmfFXBllNez+QIS6oLVPBXw4NlthHwsLkGV+AXk0sSs7K4
 GRT5XuyhIHBhQJdzZpoIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OmiIocz3wZw=;W0wkBau9AOTYHToDyhFSvTXvQnG
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77246-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_GT_50(0.00)[166];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dirk.behme@gmx.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sk.com:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 5EAC113E247
X-Rspamd-Action: no action

On 05.12.25 08:18, Byungchul Park wrote:
> wait_for_completion() can be used at various points in the code and it's
> very hard to distinguish wait_for_completion()s between different usages=
.
> Using a single dept_key for all the wait_for_completion()s could trigger
> false positive reports.
>=20
> Assign unique dept_key to each distinct wait_for_completion() caller to
> avoid false positive reports.
>=20
> While at it, add a rust helper for wait_for_completion() to avoid build
> errors.
>=20
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
>  kernel/sched/completion.c  |  60 +++++++++++-----------
>  rust/helpers/completion.c  |   5 ++
>  3 files changed, 120 insertions(+), 45 deletions(-)
>=20
...
> diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> index b2443262a2ae..5bae5e749def 100644
> --- a/rust/helpers/completion.c
> +++ b/rust/helpers/completion.c
> @@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
>  {
>  	init_completion(x);
>  }
> +
> +void rust_helper_wait_for_completion(struct completion *x)

Please add `__rust_helper`:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/rust/helpers/completion.c?h=3Dnext-20260213&id=3D1c7a6f48f7eeb3014584d2fc=
55fc67f0cbaeef69

Best regards

Dirk


