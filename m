Return-Path: <linux-fsdevel+bounces-63327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F422BB599A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 01:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39E719E7441
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E02BDC34;
	Thu,  2 Oct 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UlZXQBIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPWCT2uX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD99288530;
	Thu,  2 Oct 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447213; cv=none; b=p2bQPuwC/u9KevDZ3EAXC4W+J4uwW1Jb3j8nFmg1oV0NH5+wpRUJZ1kRHKR00OTa1w3a6IccgPOevQafD6J8mDa+Z5vuFdXSukCrzfYZrogWsqj4OC1+EUHZNDzCEiVNQyhjy7m+18AwkLyQaGkwOzcP1I5o84PonqJlhpM1IvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447213; c=relaxed/simple;
	bh=BR/jqWo92itmdMH1ocfUuKDAP7WulChibnIwAiSXhT4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=As55O0BgHHu7XadPt6rE8gWYgT1KYrbqPzeVZGWgC5JFMIasraf95uQ+Xd16EXZcK4J5Z1KOPYSUcJZhHASyGrDj5IfenDbmLy4YpVNuJ7mk1Frg/O0JkIGOztW6eK+6l2sWg+PLUHk+LTAtWw4lg/mSmQe2zIAawEffjygT5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UlZXQBIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPWCT2uX; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id DB1F41300343;
	Thu,  2 Oct 2025 19:20:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 19:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759447209;
	 x=1759454409; bh=8eLJoj9XRO384G/VvXT2HeFOAWEdoc6vPNt14uKR73A=; b=
	UlZXQBIHPI3UaJe+qvjb/0azu1Oe5qtfVSOgfR9F74ejhfdVcoLT5yCscAFxGXg8
	pwym4mpSChHvERlZa3eyvyx08BV44zMw3YGN0tM+vPnhSUz76Sq/1sLgdMvN//1t
	MgHWqimhr0AzYrwUzdnliiWe0Dm9Z34Ogn+/sldz60VOggZ3d7nAO9W0sjAS+ODa
	YJDWUIJqUD3rBGsCWCRyC9s7i9AA9pS/qByHexvhH8G1gQsu2dD8k1LeI24HGUWh
	/03Dje8K6N7L4VyDIt3NIojzwr6tdgIOBwfeBK5umF7roU56mWwwY3FulE7R0j2n
	QUpOkKf5lBp7bdgkzhLbPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759447209; x=
	1759454409; bh=8eLJoj9XRO384G/VvXT2HeFOAWEdoc6vPNt14uKR73A=; b=U
	PWCT2uXT/GxiygPtmHbccRddiUfCEYjhtJdXJccb/5YerEHrZjTt4d9N2RDQu1Wk
	qyOu+HowFfq+mSzSu4jBKZpxK4j61odikvauJS62BQvPo05HzMc2V0Q02lDG/KuV
	xFOFsUSRnUOVxEuk/jp9b7DJX/6hFCwfMhDmrQ+Gjgp+bzUnTy9kM9MFcHK3eQR5
	T9dRhCCh7CnFM2shDd7H9AIA40TS7O85KP3muQgcpbkTId7BGzFMnUMJQzEW6cKC
	RXT0xfdCbnheksb/9HE80aFjG/+J9g7pqLK4D083rrfitbbZ+Xq2jg/7x8JM1H12
	rJ7EgoklB90Zb+f1OtOPw==
X-ME-Sender: <xms:pwjfaGV4JN0Ma44cNnMBrUtL97DgMZmD0pMjmYN8l-menv5GZtsfLg>
    <xme:pwjfaNbUXFszpshl1sBUhW_dmCbyy6ss_a2I-2pSkgussU5ZHyuAg_MFZejD8O402
    j78984Anpb1DwJaQlM1svAPgMii0eUG1MbwQfJ4GQa5C5t5JGIzwDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhoph
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnrghrohdqmhhmqdhsihhgse
    hlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthdquggv
    vhgvlheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslh
    ifnhdrnhgvthdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohep
    jhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopeiiihihsehnvh
    hiughirgdrtghomhdprhgtphhtthhopegurghmihgvnhdrlhgvmhhorghlsehophgvnhhs
    ohhurhgtvgdrfigutgdrtghomh
X-ME-Proxy: <xmx:pwjfaJ2BSQWnOhQ8IplrbbGK-gyE5_grSXYP3j9439lOC_jvlo5zZA>
    <xmx:pwjfaGp-w5NGLIBr_AoLUes9YDJp8xiczs-IYhNS4F_HgHxvLrrzZA>
    <xmx:pwjfaHE7EXWw8nb_0yF2EO6HFQilk8UVSNu6kLKe14icznmhBIcCwA>
    <xmx:pwjfaI62HivFrwmWVnm93cq4CY8LYM9QpIUA5yL17t5fpoJyAMu_1w>
    <xmx:qQjfaCYKV7n5Om4PDcHknSXz-bYbngxY5RgrPIa40VVrCIhGD4C03q0Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38369700065; Thu,  2 Oct 2025 19:20:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aghr8S2aY07B
Date: Fri, 03 Oct 2025 01:19:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
 linux-ide@vger.kernel.org, "Andreas Dilger" <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Sasha Levin" <sashal@kernel.org>,
 "Daniel Vetter" <daniel.vetter@ffwll.ch>, duyuyang@gmail.com,
 "Johannes Berg" <johannes.berg@intel.com>, "Tejun Heo" <tj@kernel.org>,
 "Theodore Ts'o" <tytso@mit.edu>, "Matthew Wilcox" <willy@infradead.org>,
 "Dave Chinner" <david@fromorbit.com>,
 "Amir Goldstein" <amir73il@gmail.com>, kernel-team@lge.com,
 linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Minchan Kim" <minchan@kernel.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
 "SeongJae Park" <sj@kernel.org>, jglisse@redhat.com,
 "Dennis Zhou" <dennis@kernel.org>, "Christoph Lameter" <cl@linux.com>,
 "Pekka Enberg" <penberg@kernel.org>,
 "David Rientjes" <rientjes@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, ngupta@vflare.org,
 linux-block@vger.kernel.org, "Josef Bacik" <josef@toxicpanda.com>,
 linux-fsdevel@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Darrick J. Wong" <djwong@kernel.org>, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com,
 "Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>,
 max.byungchul.park@gmail.com, "Boqun Feng" <boqun.feng@gmail.com>,
 "Waiman Long" <longman@redhat.com>, yunseong.kim@ericsson.com,
 ysk@kzalloc.com, "Yeoreum Yun" <yeoreum.yun@arm.com>,
 Netdev <netdev@vger.kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, her0gyugyu@gmail.com,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, gustavo@padovan.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, da.gomez@kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, qiang.zhang@linux.dev,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, neil@brown.name,
 okorniev@redhat.com, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, trondmy@kernel.org,
 "Anna Schumaker" <anna@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Mark Brown" <broonie@kernel.org>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Zi Yan" <ziy@nvidia.com>,
 "Yu Zhao" <yuzhao@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, usamaarif642@gmail.com,
 joel.granados@kernel.org, "Wei Yang" <richard.weiyang@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 tim.c.chen@linux.intel.com, linux <linux@treblig.org>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 lillian@star-ark.net, "Huacai Chen" <chenhuacai@kernel.org>,
 francesco@valla.it, guoweikang.kernel@gmail.com, link@vivo.com,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Oleg Nesterov" <oleg@redhat.com>, "Mateusz Guzik" <mjguzik@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-modules@vger.kernel.org, rcu <rcu@vger.kernel.org>,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Message-Id: <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
In-Reply-To: <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
 <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to types.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 2, 2025, at 15:53, Mathieu Desnoyers wrote:
> On 2025-10-02 04:24, Greg KH wrote:
>> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:
>>> llist_head and llist_node can be used by some other header files.  For
>>> example, dept for tracking dependencies uses llist in its header.  To
>>> avoid header dependency, move them to types.h.
>> 
>> If you need llist in your code, then include llist.h.  Don't force all
>> types.h users to do so as there is not a dependency in types.h for
>> llist.h.
>> 
>> This patch shouldn't be needed as you are hiding "header dependency" for
>> other files.
>
> I agree that moving this into a catch-all types.h is not what we should
> aim for.
>
> However, it's a good practice to move the type declarations to a
> separate header file, so code that only cares about type and not
> implementation of static inline functions can include just that.
>
> Perhaps we can move struct llist_head and struct llist_node to a new
> include/linux/llist_types.h instead ?

We have around a dozen types of linked lists, and the most common
two of them are currently defined in linux/types.h, while the
rest of them are each defined in the same header as the inteface
definition.

Duplicating each of those headers by splitting out the trivial
type definition doesn't quite seem right either, as we'd end
up with even more headers that have to be included indirectly
in each compilation unit.

Maybe a shared linux/list_types.h would work, to specifically
contain all the list_head variants that are meant to be included
in larger structures?

    Arnd

