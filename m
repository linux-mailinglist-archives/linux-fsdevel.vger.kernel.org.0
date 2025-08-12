Return-Path: <linux-fsdevel+bounces-57609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA70B23CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B430B681203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FA2EAB6C;
	Tue, 12 Aug 2025 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="tv5tSeLQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjktL8i4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0E2EA74F;
	Tue, 12 Aug 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043075; cv=none; b=OijpBFycHxHpfllKSkYA5tveuA5O30qYLng/EiPp1CSxtAc9UjzIpxy6LP5zyVPpZqE2jmMT6sm7bS52Nw1n2TdBOUlQBsS+8oBZqlBgaUqlvFDAwdySC6drs1/VUATfYu/a2fFiSInGbR8IzRXXflVoYeNXcpCFBH2BBaJT/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043075; c=relaxed/simple;
	bh=sMvhu4TdkpgakOTSi4x1spk9QG2rt6czlkpdGjm+6yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9yIL4w7IMQGsVBZPaFbO0engPreI+nSpy+rBH/k80UqlikhLDvpGp8acyUu5TyePUlTXtK3hQALD87x94OY5uMvGne1SIqz3Iyhhk/82KWQwBqKNWVoYY73bvp49z6NoFXihJhESFw4/YHs3mJv7f0cLcH3c+ecUpnRcRSQdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=tv5tSeLQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjktL8i4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C4DB1400064;
	Tue, 12 Aug 2025 19:57:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 12 Aug 2025 19:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755043072;
	 x=1755129472; bh=h3el4ckOyJ37LXsuVeXcfC9YiExy+og4FR7WaG0k+tE=; b=
	tv5tSeLQTi3ROiFlCDegxgVrLKTEF31aHc0r9ANZDr5RABM6wVNydE7cnolK3zv1
	2XEnHI07wRY5QCAUWSLVIpFHCasxVBUX6lpkFBfe+We2FX5FDvd/8I18LarjmDus
	AvQghHgpe55XLz3B815NjBjTqgZqU0kxUEhw8LwzQinG59Y2d40HaASM5KCEbTf/
	0vW72tHeDv07BnCBfvqK+WP8g+dNiNW+Pact3CSSvRi4gLbt2fCqYT2GZO5tX5j2
	n1z+sKVq0yr5f9zXBI7CUmywZRHHaFlGTrgbALfBteFSQhG9mMnKJu81h/HX08gg
	GYutiZSfiLha1wyu4RVygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755043072; x=
	1755129472; bh=h3el4ckOyJ37LXsuVeXcfC9YiExy+og4FR7WaG0k+tE=; b=H
	jktL8i4Zs0V1aAyODb5W9xLG1ZUxSuvUFji+kRBZQ7njiVc6rmxUB4qOO1LX+gtB
	JAhtoTuB/HbLK8VeDZY6k1H7rHUdD4/jrSv7nfx57VEkVcSb+8S3bgiVEaoTBOyt
	Z8g1npSgC2GsHTugK7rQQeAHaOxsswpONt6y767sQGo1dt7JEy6HWzUag2An4W1t
	XtHJUVTEPwbPyf7BCckL8bfUDZlhlE+jt/6Zy2vWmy1IKsYXtWIGq4ei4xkXF7nt
	DiMakigaMSuI5EkwqYtUojaM00sS/amhzJDrKFiZqu3WfxWguw5UCyfnIk1VkSV2
	WeFJzPoOboUPzYiIgqEQg==
X-ME-Sender: <xms:_9SbaO5B6I0s6fH2WEiEVFGUHnpma_BNm5Ccx3nJFd57XDAfwvYy0A>
    <xme:_9SbaGZu8mFia7mvU9pDBkWc7IYyiY4OtSvO88w34iDVFvvFIJOtHR2cc1nWmtLPX
    Weo0e6dq26EkIHcyuU>
X-ME-Received: <xmr:_9SbaI_kjlsLjAfQ-x677gGDMM9U5b6e_pkymdOGp-Me1HNovzerB5QPs5zDapXeAXmH2-4pjQhSUhKGcHTEBkWB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeijeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegrshhmrgguvghush
    estghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhi
    nhhugidrohhrghdruhhkpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhn
    uhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvhelfhhssehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_9SbaFRef_URq3Yo26rqICcr0m1hrRGph9F-qrmUucip0o0JGyiG9A>
    <xmx:_9SbaLIhSwQj4cpOArbxP13zM1WOwiq8EaDUDuPL6TzV_YVRiSCooA>
    <xmx:_9SbaPTVFgPrcFvU-dj90N24WDQW_hJBfnvEGXthkJAVWH-R_Ns7SA>
    <xmx:_9SbaLJlFzGJPupctVKgai8-DGflxEj1M4xkZcZM21HKbYeMTmjoPw>
    <xmx:ANWbaELsTLqGaC9v3TDZ9yuOVrot9bjT-1ITv5ZHumUNKj8GZU-s6CZg>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 19:57:50 -0400 (EDT)
Message-ID: <df6cb208-cb14-4ca5-bd25-cb0f05bfc6a1@maowtm.org>
Date: Wed, 13 Aug 2025 00:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org
References: <cover.1743971855.git.m@maowtm.org>
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
 <20250705002536.GW1880847@ZenIV>
 <b32e2088-92c0-43e0-8c90-cb20d4567973@maowtm.org>
 <20250808.oog4xee5Pee2@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250808.oog4xee5Pee2@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review :)  I will try to send a v2 in the coming weeks with
the two changes you suggested and the changes to cached mode as suggested
by Dominique (plus rename handling).  (will also try to figure out how to
test with xfstests)

On 8/8/25 09:32, Mickaël Salaün wrote:
> [...]
>> On 7/5/25 01:25, Al Viro wrote:
>>> On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
>>>> +bool ino_path_compare(struct v9fs_ino_path *ino_path,
>>>> +			     struct dentry *dentry)
>>>> +{
>>>> +	struct dentry *curr = dentry;
>>>> +	struct qstr *curr_name;
>>>> +	struct name_snapshot *compare;
>>>> +	ssize_t i;
>>>> +
>>>> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
>>>> +
>>>> +	rcu_read_lock();
>>>> +	for (i = ino_path->nr_components - 1; i >= 0; i--) {
>>>> +		if (curr->d_parent == curr) {
>>>> +			/* We're supposed to have more components to walk */
>>>> +			rcu_read_unlock();
>>>> +			return false;
>>>> +		}
>>>> +		curr_name = &curr->d_name;
>>>> +		compare = &ino_path->names[i];
>>>> +		/*
>>>> +		 * We can't use hash_len because it is salted with the parent
>>>> +		 * dentry pointer.  We could make this faster by pre-computing our
>>>> +		 * own hashlen for compare and ino_path outside, probably.
>>>> +		 */
>>>> +		if (curr_name->len != compare->name.len) {
>>>> +			rcu_read_unlock();
>>>> +			return false;
>>>> +		}
>>>> +		if (strncmp(curr_name->name, compare->name.name,
>>>> +			    curr_name->len) != 0) {
>>>
>>> ... without any kind of protection for curr_name.  Incidentally,
>>> what about rename()?  Not a cross-directory one, just one that
>>> changes the name of a subdirectory within the same parent?
>>
>> As far as I can tell, in v9fs_vfs_rename, v9ses->rename_sem is taken for
>> both same-parent and different parent renames, so I think we're safe here
>> (and hopefully for any v9fs dentries, nobody should be causing d_name to
>> change except for ourselves when we call d_move in v9fs_vfs_rename?  If
>> yes then because we also take v9ses->rename_sem, in theory we should be
>> fine here...?)
> 
> A lockdep_assert_held() or similar and a comment would make this clear.

I can add a comment, but there is already a lockdep_assert_held_read of
the v9fs rename sem at the top of this function.

> [...]
>> /*
>>  * Must hold rename_sem due to traversing parents
>>  */
>> bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
>> {
>> 	struct dentry *curr = dentry;
>> 	struct name_snapshot *compare;
>> 	ssize_t i;
>>
>> 	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
>>
>> 	rcu_read_lock();
>> 	for (i = ino_path->nr_components - 1; i >= 0; i--) {
>> 		if (curr->d_parent == curr) {
>> 			/* We're supposed to have more components to walk */
>> 			rcu_read_unlock();
>> 			return false;
>> 		}
>> 		compare = &ino_path->names[i];
>> 		if (!d_same_name(curr, curr->d_parent, &compare->name)) {
>> 			rcu_read_unlock();
>> 			return false;
>> 		}
>> 		curr = curr->d_parent;
>> 	}
>> 	rcu_read_unlock();
>> 	if (curr != curr->d_parent) {

Looking at this again I think this check probably needs to be done inside
RCU, will fix as below:

>> 		/* dentry is deeper than ino_path */
>> 		return false;
>> 	}
>> 	return true;
>> }

diff --git a/fs/9p/ino_path.c b/fs/9p/ino_path.c
index 0000b4964df0..7264003cb087 100644
--- a/fs/9p/ino_path.c
+++ b/fs/9p/ino_path.c
@@ -77,13 +77,15 @@ void free_ino_path(struct v9fs_ino_path *path)
 }
 
 /*
- * Must hold rename_sem due to traversing parents
+ * Must hold rename_sem due to traversing parents.  Returns whether
+ * ino_path matches with the path of a v9fs dentry.
  */
 bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
 {
 	struct dentry *curr = dentry;
 	struct name_snapshot *compare;
 	ssize_t i;
+	bool ret;
 
 	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
 
@@ -101,10 +103,8 @@ bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
 		}
 		curr = curr->d_parent;
 	}
+	/* Comparison fails if dentry is deeper than ino_path */
+	ret = (curr == curr->d_parent);
 	rcu_read_unlock();
-	if (curr != curr->d_parent) {
-		/* dentry is deeper than ino_path */
-		return false;
-	}
-	return true;
+	return ret;
 }

> 
> I like this new version.
> 

