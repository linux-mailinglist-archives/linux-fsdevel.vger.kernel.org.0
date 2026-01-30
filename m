Return-Path: <linux-fsdevel+bounces-75937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFNvJtJdfGkYMAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 08:29:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB8B7EA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C58663019F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9AC30F924;
	Fri, 30 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UVDvGyZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C38227EA8;
	Fri, 30 Jan 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758151; cv=none; b=V1mp/cWfeZiFGAnTFH1RMnepfIOe6RwnY7HZwS090MWsiCZchnNRCI4/vAcPKHRZb6dOaSL7VmxWOsjOxOAIO7zWZIAauJmJUe0dozwMH+JE8eSDqLP5/DQKFuSJ/Y0vXShcV3xzCtgzE0oi30oWxtYsvVZZIHvAE7xftLRK1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758151; c=relaxed/simple;
	bh=o5da8QxWmeJYkmuZnhHP8pj+K8KJXN8lvPlxHUw+eMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coTKTDvHWK25s32dm1iWk9dPEez6t0N/8kFk8ZZvrtM4NRFiKqIAKIIBWHcfz0h6nNzrkDiKvNITHUecGXDn9vZiiu+qyavl5MrpwcqBQa8794NYoMOcjR6h7THb1pPj3d0XKG3KiEBdJ/iolkZ0ZXfIetcXe9rUKQUmSsEEZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UVDvGyZu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769758146; x=1770362946; i=quwenruo.btrfs@gmx.com;
	bh=GISiKvrm7FdFipwVI2Bl4TXsiwE/xa3948Vip8DOewo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UVDvGyZuX8yMUSa8/v+aHnQZfR1TQJ6edJovgHdvq8GDOK7pF0GFQe83j4iJr4b7
	 51+049apNDn7mfY1kjpNoha+S6haHRebJt5zSoewJnRebEs1G+2yifoPAqedjjWrh
	 YkDNMRil1xryODvTENZziM93I1o7UEeTKTEDBV9xW9vR2ZaWspxtfqKVHVXPYzjd9
	 DgCkHHuYCJ61NDTpN6QvZKxXjc91Ma90NrTWrC0FQxIs/WHH01cKqBmQOEHsvE2Mv
	 +zJdRWdNc/j8+xZV8D/rfyNARhppfBmAQ1ZErwtV2BAJ35T8uPVfuKEmlsRDdL/nv
	 jzDNbVdqM+ChG+4Gbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1vYoeO3O7t-00FZQW; Fri, 30
 Jan 2026 08:29:06 +0100
Message-ID: <84623da6-3248-437d-9f01-e3fe57e282db@gmx.com>
Date: Fri, 30 Jan 2026 17:59:01 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: Boris Burkov <boris@bur.io>
Cc: JP Kobryn <inwardvessel@gmail.com>, clm@fb.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <20260130063403.GB863940@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20260130063403.GB863940@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3+SGc+V21d6bLVgDfb/4MzFkWvDaOfCZoLG6S5s0Dz4itNkDDBB
 NT8HpP3B+gyxpqNhctZ1w0IN1Wt1YL031jaw/Xf3+b7EbWzPZqPZtfEB8TaBv+K4XUjpKLK
 KadaRTTqteeJam+a7nwjpX2t57SEb/Wa9G89O1N7oEwXxsBlPVP3LzIfcthtVJt2qJl17zw
 OpsA4cT+Y0mN/6xtf7MgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j5OpYlSGrUc=;/UPs6X3A5R8EcvABZTCTse8ZFLp
 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
 9jSEFnB4Ib/8fdHDwMdL
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75937-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmx.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DDB8B7EA5
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/30 17:04, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2026/1/30 09:38, JP Kobryn =E5=86=99=E9=81=93:
>> [...]
>>> The patch also might have the advantage of being easy to backport to t=
he
>>> LTS trees. On that note, it's worth mentioning that we encountered a k=
ernel
>>> panic as a result of this sequence on a 6.16-based arm64 host (configu=
red
>>> with 64k pages so btrfs is in subpage mode). On our 6.16 kernel, the r=
ace
>>> window is shown below between points A and B:
>>>
>>> [mm] page cache reclaim path        [fs] relocation in subpage mode
>>> shrink_folio_list()
>>>     folio_trylock() /* lock acquired */
>>>     filemap_release_folio()
>>>       mapping->a_ops->release_folio()
>>>         btrfs_release_folio()
>>>           __btrfs_release_folio()
>>>             clear_folio_extent_mapped()
>>>               btrfs_detach_folio_state()
>>>                 bfs =3D folio_detach_private(folio)
>>>                 btrfs_free_folio_state(folio)
>>>                   kfree(bfs) /* point A */
>>>
>>>                                      prealloc_file_extent_cluster()
>>>                                        filemap_lock_folio()
>>
>> Mind to explain which function is calling filemap_lock_folio()?
>>
>> I guess it's filemap_invalidate_inode() -> filemap_fdatawrite_range() -=
>
>> filemap_writeback() -> btrfs_writepages() -> extent_write_cache_pages()=
.
>>
>=20
> I think you may have missed it in the diagram, and some of the function
> names may have shifted a bit between kernels, but it is relocation.
>=20
> On current btrfs/for-next, I think it would be:
>=20
> relocate_file_extent_cluster()
>    relocate_one_folio()
>      filemap_lock_folio()

Thanks, indeed the filemap_lock_folio() inside=20
prealloc_file_extent_cluster() only exists in v6.16 code base, which=20
does partial folio invalidating manually.

That code is no longer there, and gets replaced with a much healthier=20
solution.

>=20
>>>                                          folio_try_get() /* inc refcou=
nt */
>>>                                          folio_lock() /* wait for lock=
 */
>>
>>
>> Another question here is, since the folio is already released in the mm
>> path, the folio should not have dirty flag set.
>>
>> That means inside extent_write_cache_pages(), the folio_test_dirty() sh=
ould
>> return false, and we should just unlock the folio without touching it
>> anymore.
>>
>> Mind to explain why we still continue the writeback of a non-dirty foli=
o?
>>
>=20
> I think this question is answered by the above as well: we aren't in
> writeback, we are in relocation.

I see the problem now. And thankfully it's commit 4e346baee95f ("btrfs:=20
reloc: unconditionally invalidate the page cache for each cluster")=20
fixing the behavior.

And yes, the old code can indeed hit the problem.

But still, the commit 4e346baee95f ("btrfs: reloc: unconditionally=20
invalidate the page cache for each cluster") itself shouldn't be that=20
hard to backport.

Thanks,
Qu

>=20
> Thanks,
> Boris
>=20
>>>
>>>     __remove_mapping()
>>>       if (!folio_ref_freeze(folio, refcount)) /* point B */
>>>         goto cannot_free /* folio remains in cache */
>>>
>>>     folio_unlock(folio) /* lock released */
>>>
>>>                                      /* lock acquired */
>>>                                      btrfs_subpage_clear_updodate()
>>
>> Mind to provide more context of where the btrfs_subpage_clear_uptodate(=
)
>> call is from?
>>
>>>                                        bfs =3D folio->priv /* use-afte=
r-free */
>>>
>>> This exact race during relocation should not occur in the latest upstr=
eam
>>> code, but it's an example of a backport opportunity for this patch.
>>
>> And mind to explain what is missing in 6.16 kernel that causes the abov=
e
>> use-after-free?
>>
>>>
>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>> ---
>>>    fs/btrfs/extent_io.c |  6 ++++--
>>>    fs/btrfs/inode.c     | 18 ++++++++++++++++++
>>>    2 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 3df399dc8856..d83d3f9ae3af 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -928,8 +928,10 @@ void clear_folio_extent_mapped(struct folio *foli=
o)
>>>    		return;
>>>    	fs_info =3D folio_to_fs_info(folio);
>>> -	if (btrfs_is_subpage(fs_info, folio))
>>> -		return btrfs_detach_folio_state(fs_info, folio, BTRFS_SUBPAGE_DATA)=
;
>>> +	if (btrfs_is_subpage(fs_info, folio)) {
>>> +		/* freeing of private subpage data is deferred to btrfs_free_folio =
*/
>>> +		return;
>>> +	}
>>
>> Another question is, why only two fses (nfs for dir inode, and orangefs=
) are
>> utilizing the free_folio() callback.
>>
>> Iomap is doing the same as btrfs and only calls ifs_free() in
>> release_folio() and invalidate_folio().
>>
>> Thus it looks like free_folio() callback is not the recommended way to =
free
>> folio->private pointer.
>>
>> Cc fsdevel list on whether the free_folio() callback should have new
>> callers.
>>
>>>    	folio_detach_private(folio);
>>
>> This means for regular folio cases, we still remove the private flag of=
 such
>> folio.
>>
>> It may be fine for most cases as we will not touch folio->private anywa=
y,
>> but this still looks like a inconsistent behavior, especially the
>> free_folio() callback has handling for both cases.
>>
>> Thanks,
>> Qu
>>
>>>    }
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index b8abfe7439a3..7a832ee3b591 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -7565,6 +7565,23 @@ static bool btrfs_release_folio(struct folio *f=
olio, gfp_t gfp_flags)
>>>    	return __btrfs_release_folio(folio, gfp_flags);
>>>    }
>>> +/* frees subpage private data if present */
>>> +static void btrfs_free_folio(struct folio *folio)
>>> +{
>>> +	struct btrfs_folio_state *bfs;
>>> +
>>> +	if (!folio_test_private(folio))
>>> +		return;
>>> +
>>> +	bfs =3D folio_detach_private(folio);
>>> +	if (bfs =3D=3D (void *)EXTENT_FOLIO_PRIVATE) {
>>> +		/* extent map flag is detached in btrfs_folio_release */
>>> +		return;
>>> +	}
>>> +
>>> +	btrfs_free_folio_state(bfs);
>>> +}
>>> +
>>>    #ifdef CONFIG_MIGRATION
>>>    static int btrfs_migrate_folio(struct address_space *mapping,
>>>    			     struct folio *dst, struct folio *src,
>>> @@ -10651,6 +10668,7 @@ static const struct address_space_operations b=
trfs_aops =3D {
>>>    	.invalidate_folio =3D btrfs_invalidate_folio,
>>>    	.launder_folio	=3D btrfs_launder_folio,
>>>    	.release_folio	=3D btrfs_release_folio,
>>> +	.free_folio =3D btrfs_free_folio,
>>>    	.migrate_folio	=3D btrfs_migrate_folio,
>>>    	.dirty_folio	=3D filemap_dirty_folio,
>>>    	.error_remove_folio =3D generic_error_remove_folio,
>>


