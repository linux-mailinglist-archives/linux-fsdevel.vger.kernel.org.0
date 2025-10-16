Return-Path: <linux-fsdevel+bounces-64330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30224BE1227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733B219C1366
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAE1A9FA3;
	Thu, 16 Oct 2025 00:46:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B16187332;
	Thu, 16 Oct 2025 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575613; cv=none; b=pcwaAx+ut2Buh4diMqq3rGFSzPHcC3uE93vIYntrh5MImwbW+o5ZB+bCLSZ26qjwQmw/B8N/OsZx0soQsBA2mPzai2kz4uNrsw46lJBaH68QFa8QQWbmz6wu2VOHo9TD4kEW0XKCtU9Uzmt65Ptv56OSjw8oxobdweQAeK24rHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575613; c=relaxed/simple;
	bh=bOKJ6TkZJV7OT6XeerMfxJtiPz1ZRcgBwgHMoF0YAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+/mwXNGdZ9yl1vvpgnKkvNmM82jQi0Uy7CaQU05urpe+nChaPueD3HfWLiIri/y6SL73nR8s8Iy6EVxUIsuCkqjds/HjKedi4UoilrL7cZskS6ZODwvnNfyv6A006gNEHCGDi00MhMi8oeCGaNIkrVfgJEoe/OlR6ok7vsGEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-3a-68f040753fb9
Date: Thu, 16 Oct 2025 09:46:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, duyuyang@gmail.com,
	Johannes Berg <johannes.berg@intel.com>, Tejun Heo <tj@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, kernel-team@lge.com,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
	SeongJae Park <sj@kernel.org>, jglisse@redhat.com,
	Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, hamohammed.sa@gmail.com,
	harry.yoo@oracle.com, chris.p.wilson@intel.com,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	max.byungchul.park@gmail.com, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, yunseong.kim@ericsson.com,
	ysk@kzalloc.com, Yeoreum Yun <yeoreum.yun@arm.com>,
	Netdev <netdev@vger.kernel.org>,
	Matthew Brost <matthew.brost@intel.com>, her0gyugyu@gmail.com,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, gustavo@padovan.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, da.gomez@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	Josh Triplett <josh@joshtriplett.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, qiang.zhang@linux.dev,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, neil@brown.name,
	okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, trondmy@kernel.org,
	Anna Schumaker <anna@kernel.org>, Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, usamaarif642@gmail.com,
	joel.granados@kernel.org, Wei Yang <richard.weiyang@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	tim.c.chen@linux.intel.com, linux <linux@treblig.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	lillian@star-ark.net, Huacai Chen <chenhuacai@kernel.org>,
	francesco@valla.it, guoweikang.kernel@gmail.com, link@vivo.com,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, wangfushuai@baidu.com,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-modules@vger.kernel.org, rcu <rcu@vger.kernel.org>,
	linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to
 types.h
Message-ID: <20251016004640.GB2948@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
 <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
 <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUybZRSG87wfT18aal7rFh5BY6wSCTh0ZgnHxRh+qHtjJCG6ZAkz0WZU
	21DK1jI+/Ih12UeFJmK1TFqCXWEdoR1j7dgGWyNjUGQ4LWUbRdtZpMLIWmsIXTNYmZS5uH9X
	7vucK+fH4WipDedyKk2tQquRq2VYzIjj2fYtdaX/KF+e6cqB5LKBgfZTLgwGdxsL/l4ngtSq
	lYa0ySeC+14fgtZJEw2uM19ScPvyEgLzbBRDwmFEYJm3iiD+xwUW7ocXKJi+E0PgiK5REB06
	giDdWgU/2D0YVq/+SsNRsx/Brb71/IzvJgJv9wEMf7X00zAVfQyuJRMYxs3NGOKT7RT83YfB
	dsDLwkBkUAShVhMFTncZTLTYKTi6iMF88gIFP3eGGHDo88F6dYqFe7NbwedcEEH4azMD5/QR
	EbhnRhEsX5ulwGWcp8EwmGTAPXeDBe9vRXDscBcDbR0hDBe94wwY0ssIfOf/pGBqsB2Dsa+f
	Bb01xULA6Wfg1EKQggnfTwwcn56kYDYSZEsrhR7PWUo4FEhjwdXhQsLqigkJl2MJWjjoqReO
	T8SwsJK8joUrdiIMWMIiwebeLxwcibOCp7tQ6Ly4SAnHlpKs4O75CpcXVYhfq1SoVXUK7Uuv
	fyhW2m6nqb29fIPvykmsR7HsJpTFEX4bGZvz44fsCRvoDDN8PplaTjEZxvwLJBi8u5Fv4p8l
	5lvzG0zz8wXkO78uw0/wO8kNZ8/GvIQvIfam0XUWc1J+BZHe2Cr7oHicjLdFmQfLhSS4tkg1
	IW6d88iJNS4TZ/FvkNj1Ixv3bOafI0Nnx6iMh/A3s8iYPfTfoU+SS91BpgXxlke0lke0lv+1
	NkT3IKlKU1ctV6m3FSsbNaqG4j011W60/reOz+/tPo+W/O8NI55DsmxJpDuhlLLyOl1j9TAi
	HC3bJCn5NKaUSirljZ8otDUfaPerFbphlMcxshzJK3fqK6X8x/JaRZVCsVehfdhSXFauHuF9
	sY9kQ9PfW3tLJrd/mzfX8JbTOCFqT9U3n+4vM7xbXRxs/mbU9eqi9M3SnNRAUUFxWWizsbzq
	felnu+4qq57f+cuuiq78hu3P7AvvyC344nCgeaQLNEudnU8HlE7HU5GKt0VbEocC8XPlv4/U
	BuzvqE271yIzNZdeHJ/bIf2xtCMsY3RK+dZCWquT/wuiuOeyswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87uP37001txVjDeSLKEb6EzwtRlPlCnJJF5NYPsDddlitJGb
	tQLFtIqgceMZCW4TO9uGVl0HsRIKBQGRihiCo4s6ItipnVqxpvKQMhZpIVBK12LM/Ofkc76P
	5PxxWFIWpleyKvVRUaNW5MqxhJJkbi1LOZb2r3J958gn8Kikh4JgoJKCC82NGCpba2gYsNsQ
	DAUrEcyEzCRUOCIUhHVOBgKzTxmIdDsRGAZ1JDS2lxAw1bKAYfz2GwR6rw+DcayEgknrjwhM
	w2YGxvp2wsRQFw0RzwgBj6f9CKy+BQJ8PacRhA058GttG4ZQ/30SjPoBBL95PSSMtkTNdudz
	BN31pRheVV8jweVbCn8FJzHc0Z/BMDF4gYB/WjBYSrtpuGjWISira8ZguNhKgePFDQYGx+cJ
	eGbQEWBrzYAh6zAF96prieh90dTVFWA2lhHRMUqAvqmLgFlrAwN/1j2jwFqcBOZ+Fw0v600M
	zHs3QMSSD07bCAOes3oK7BP36TQ9EmYqfqaEhrYOQqh4EMZC46VGJITmdEgIXC4jhYrq6Hrb
	P0kK5W3Hhcv3/FiYCz7EQve0hRLu1vLCuf4UwWHyMEL5rSfMV1u+kaRmi7mqAlGzbttBidIy
	HiaO2LlC590mXIz8S6pQHMtzn/FtnkoyxhSXxLsCM1SMMbeKd7tnF/V4LpHXjw4vMskNr+bP
	D2hjvIzL4h/ZGhbzUm4zX1vVF2UJK+PmEG/3h+i3xgf8nRof9ba8hncvjBFViI1yAn9lgY3J
	cdwO3v/wNI7xcu4jvqfjD6IaSU3vtU3vtU3/ty2IbEDxKnVBnkKVu2mtNkdZpFYVrj2Un9eK
	ok9pPTV/rhMFXDt7Ecci+RLpi/pJpYxWFGiL8noRz5LyeOnmk36lTJqtKDohavIPaI7litpe
	lMBS8hXS3fvEgzLuO8VRMUcUj4iady7Bxq0sRvG7iY+nBgO3nExhnnq9p+VA35Wp1Kb6oo2v
	p9+k7/82/dOUr8O+mj1fRpy/nEwJ9m5JXv75aM7Zpemp7r3N0sc/7BO/KPcmlzrcrw/HaQe8
	icmO8/aqzKEe+3xId8a1/SfjhyP6XRldaXRC/6q9x/GrrN9P/W30J9pu3PxescuQVHJdTmmV
	ig1rSI1W8R8ELch0kAMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 01:19:33AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 2, 2025, at 15:53, Mathieu Desnoyers wrote:
> > On 2025-10-02 04:24, Greg KH wrote:
> >> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:
> >>> llist_head and llist_node can be used by some other header files.  For
> >>> example, dept for tracking dependencies uses llist in its header.  To
> >>> avoid header dependency, move them to types.h.
> >>
> >> If you need llist in your code, then include llist.h.  Don't force all
> >> types.h users to do so as there is not a dependency in types.h for
> >> llist.h.
> >>
> >> This patch shouldn't be needed as you are hiding "header dependency" for
> >> other files.
> >
> > I agree that moving this into a catch-all types.h is not what we should
> > aim for.
> >
> > However, it's a good practice to move the type declarations to a
> > separate header file, so code that only cares about type and not
> > implementation of static inline functions can include just that.
> >
> > Perhaps we can move struct llist_head and struct llist_node to a new
> > include/linux/llist_types.h instead ?
> 
> We have around a dozen types of linked lists, and the most common
> two of them are currently defined in linux/types.h, while the
> rest of them are each defined in the same header as the inteface
> definition.
> 
> Duplicating each of those headers by splitting out the trivial
> type definition doesn't quite seem right either, as we'd end
> up with even more headers that have to be included indirectly
> in each compilation unit.
> 
> Maybe a shared linux/list_types.h would work, to specifically

I found a way to resolve my issue, but I thought it's good idea
regardless of my issue and took a quick look.  However, it seems like
there's an overwhelming amount of work since it might require to replace
all the existing include <linux/types.h> for use of list things with the
new one :-).

	Byungchul

> contain all the list_head variants that are meant to be included
> in larger structures?
> 
>     Arnd

