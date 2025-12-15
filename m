Return-Path: <linux-fsdevel+bounces-71329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B2CBDCE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BBD13020C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023B314B77;
	Mon, 15 Dec 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MFNtC9o7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A12C3255;
	Mon, 15 Dec 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801527; cv=none; b=WZEhER4SNUh1qzajpDxDY9oFeDT0E/KPmACPTicN2DD2hzdpd/f00p473Fw7JJ5GhgYqyhgq/0xxfSHcNwcb1LuC9iQz+M9c01OXJ6TcPhM0VT6Zd9O5mZs9OrWtKnF2FEOrJF+VnGDkSgCC3YEeTqfwAXF00uM0zCZh1h6SRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801527; c=relaxed/simple;
	bh=gJOFMp1/K+qQ0MSqjWn/CbbRaLJJuaP23xTo6CU3FMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUV/lgcB2eJ2IJmAml5mJz0QTSRGVh4PNPPI/o/rduv2kWDeABnr8spgPGdNvM6vmnC/vcOU2F6cBbGFS09TJlnJE/0V57MGNEaCbnzo6Xnkw0FecO+UhFCLe6hm8GntIYrldCKgohez8qqiwOp9YUgsR8j8ixMBEP3gsnW3RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MFNtC9o7; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dVK5Q3lJFz9scD;
	Mon, 15 Dec 2025 13:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765801514; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJOFMp1/K+qQ0MSqjWn/CbbRaLJJuaP23xTo6CU3FMU=;
	b=MFNtC9o7GDr77G4gP5pdlWOgQeeiKPzkDClg8L2DPLsenZjXbBPFNYiW+f7Yt3dIHPmQyP
	OJMvPnvOPIvbcMj8jkup2nPMtdqY9haLsfcz/IxOV2J03K4sDF356sDyQ23TsGQ07TViaD
	FhWOVrJMTFcJ9CeKh2BEanhmBKLu/puWhJkeqyz5IF7MKc0wDX6+LpZo37kPzrx07UbVHu
	/SrGIEw9Yb9k6R4DHidfnQwttDmp8t0gODXRNwKwn1DjYqW3hsQZd1gJ97ZgepaPr9lGGF
	Kb4b3/HsX4GoqvHqXz/IOEsaMsqC0j4WmS+EX3sDV8DayQFJEqKPzO/PssjTDQ==
Message-ID: <1f0fd860bf3466b9967d5a99ecd49eb93e0f7a19.camel@mailbox.org>
Subject: Re: [PATCH 12/14] drm/scheduler: Describe @result in
 drm_sched_job_done()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux AMDGPU
 <amd-gfx@lists.freedesktop.org>,  Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Linux Filesystems Development
 <linux-fsdevel@vger.kernel.org>,  Linux Media
 <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org,
 kasan-dev@googlegroups.com,  Linux Virtualization
 <virtualization@lists.linux.dev>, Linux Memory Management List
 <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, Linux
 Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Sumit Semwal <sumit.semwal@linaro.org>,  Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, George
 Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Sunil
 Khatri <sunil.khatri@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, David Hildenbrand <david@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Alexey Skidanov <alexey.skidanov@intel.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet
 <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, Harry
 Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown
 <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Roopa Prabhu
 <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, Shaomin Deng
 <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, Jilin Yuan
 <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 George Anthony Vernon <contact@gvernon.com>
Date: Mon, 15 Dec 2025 13:24:46 +0100
In-Reply-To: <20251215113903.46555-13-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
	 <20251215113903.46555-13-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: q9aiurnjorghwoz79fww7b6wqkkf5zeq
X-MBO-RS-ID: ca016de3dd37ac937be

nit about commit title:
We use "drm/sched:" as prefix nowadays

On Mon, 2025-12-15 at 18:39 +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
>=20
> WARNING: ./drivers/gpu/drm/scheduler/sched_main.c:367 function parameter =
'result' not described in 'drm_sched_job_done'
>=20
> Describe @result parameter to fix it
>=20

Thx for fixing this!

> .
>=20
> Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 1d4f1b822e7b76..4f844087fd48eb 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_s=
cheduler *sched)
> =C2=A0/**
> =C2=A0 * drm_sched_job_done - complete a job
> =C2=A0 * @s_job: pointer to the job which is done
> + * @result: job result

"error code for the job's finished-fence" would be a bit better and
more verbose.

With that:

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> =C2=A0 *
> =C2=A0 * Finish the job's fence and resubmit the work items.
> =C2=A0 */


