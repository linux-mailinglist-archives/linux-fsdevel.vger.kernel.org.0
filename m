Return-Path: <linux-fsdevel+bounces-2747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED87E8994
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 07:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996D9B20BDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE477498;
	Sat, 11 Nov 2023 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="udEvQdrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C76FA7;
	Sat, 11 Nov 2023 06:55:06 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DF111;
	Fri, 10 Nov 2023 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699685689; x=1700290489; i=quwenruo.btrfs@gmx.com;
	bh=Z/yMQVtlmfvx60UqgtCWtgn1md3kTutFJEuE9ZbaY7A=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=udEvQdrOhTZfkrDScyKONhS0Zt1IC9naxG2OPVx/ehbdyeM5NLPUh5sEa0zvKxQD
	 iRA2ffUbRF2J27j12GRagF3FFAVzP/3fbkR10bHcodBar5hZOIc57GrwSw97Gpwl0
	 viDlNwC9uP6rC0UMS7fefamPLZp5xVNGJDwlDtwGESMbqITr1gPz7fsI5BJsv2yNL
	 mL9O8U+g37oHu23GJ3UP4a4SckXYi9YjcD9lEFPoPkee3hN5KvgktCgVSfpMOWuMD
	 AEQaVlkbHsjo04O6tBI8OQOZyOTOebW4UbfKmsFJIwPqoYvg3aZkT8a1Y4EZ2d1+Z
	 HlUa5umxe/VbE8Fv4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1qmfLL2eJj-00O0Cy; Sat, 11
 Nov 2023 07:54:49 +0100
Message-ID: <8800d890-e16c-4388-97c6-e55fd3ca7515@gmx.com>
Date: Sat, 11 Nov 2023 17:24:42 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix warning in create_pending_snapshot
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000001959d30609bb5d94@google.com>
 <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1l30kIq/YQdCcM5jK1zccgSQvIQpBUaGRl66qg3vrnBkBPCPCG0
 pVVL3+f0oBR3eXn6s+xmv6/ecSnHwkxe2zvhCb70FUmWcrvWLVN67AcGG1Aa1l3trXU0IE+
 5IxuBJ5B+UpArcycvcRrDiK/CuvRrVIO+pUiEqZETpQRMC+KBbL5zR6y5/VY22ghLYOBFaU
 mFjgG0Znh5/vqBa5nDBFg==
UI-OutboundReport: notjunk:1;M01:P0:OefP0VUvbjs=;0Wo0jL/1Zw4/X3nbiSNMCm/aYTo
 OzzLCjD3mf37rlszWDU2120L4KXiOdc8WD0W9x3BpPbZ0vtJ58ihaLdglGRwTGZrUz8QgXKy9
 5vKj+/WI76j9v6TqOIArRCSc+aDajqYYZ1D+7XYekE8yu0IOW//YR6nnYZZXcWytZLgBrhW8+
 4fueDRsfhjBms/aTGvYcE+xyEyjpAFKfXEHLkS3yc7kvF4GYwLtAITnjkwvP39Uq3rBDAMzGL
 RY2xDHq0Q4zRqp7E27sL5CaILP8vc3Z2iYY4D7baQnENKKtjHjt4W0aexD9VAxtAmO/twi7dL
 ZzpeueWbWiE3SCOHYMaVSvUKKkCzaOgYFfH0pZBhom/y5uaMRA2lTmsQEqFmM9YGOIkZn9CLx
 KO2Hm+sN3paasrtgLIbkahJz86ttUk9PRZE73N8qxflNAdGYZI6OEwpRmxH4YzjKHjkHuqY0C
 lYUFtOvMEu65PtUS3DAbSc6M8Oesc0OvToJHbVtFbti0Gb5ZD/xl8llhieUGwHnJbhhqjElgX
 L643NG7c85CGOj/7/hC3ST5dYLUuliPiMGSHBcbiunkf9wRR+RyOCMYUT839EwZVeIJGk0rq4
 6Jqi1lnqyPM2v9BNRr7BsWtk/9+OWYAslMh8B06F0T5HCgw5SukvI9YAA9xC+I3WazGy+wlm1
 nQ0mcAYLiY6CV/oJEUmZ3Sb9EYSyBZB6Zb5ghIw2EHcAnYi50GkcB9D536MnIV5UHMPfcg2Ci
 glf4rGaMJumopKUpoUGUPFC9A/95h6uzE3O5aUC3Kx1BBaJqyXLmL2FRS8uhum5IxO2S2c839
 wdxDqKj/+LPscUc+XZcflNSxHpA0pb5hwVqo/2U2lQlWid8C+GHGKFY8lRbsWW1lBfopf913r
 gqwk8sdO8ApooidMU7tzsfRkPe0QDj6KgvZ6C+jahyC9gE2CfRjRPdy8DkUBQCnCnGBhwFb5i
 EnKSYscdx7MdLQpjtIA1g4zAXpk=



On 2023/11/11 15:36, Edward Adam Davis wrote:
> The create_snapshot will use the objectid that already exists in the qgr=
oup_tree
> tree, so when calculating the free_ojectid, it is added to determine whe=
ther it
> exists in the qgroup_tree tree.
>
> Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmai=
l.com
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation"=
)
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/btrfs/disk-io.c | 3 ++-
>   fs/btrfs/qgroup.c  | 2 +-
>   fs/btrfs/qgroup.h  | 2 ++
>   3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 401ea09ae4b8..97050a3edc32 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *roo=
t, u64 *objectid)
>   		goto out;
>   	}
>
> -	*objectid =3D root->free_objectid++;
> +	while (find_qgroup_rb(root->fs_info, root->free_objectid++));

I don't think this is correct.

Firstly you didn't take qgroup_ioctl_lock.

Secondly, please explain why you believe the free objectid of a
subvolume is related to the qgroup id?


For any one who really wants to fix the syzbot bug, please explain the
bug clearly before doing any fix.

If you can not explain the bug clearly, then you're doing it wrong.

Thanks,
Qu

> +	*objectid =3D root->free_objectid;
>   	ret =3D 0;
>   out:
>   	mutex_unlock(&root->objectid_mutex);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index edb84cc03237..3705e7d57057 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -171,7 +171,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u6=
4 progress_objectid,
>   static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info)=
;
>
>   /* must be called with qgroup_ioctl_lock held */
> -static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_inf=
o,
> +struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
>   					   u64 qgroupid)
>   {
>   	struct rb_node *n =3D fs_info->qgroup_tree.rb_node;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 855a4f978761..96c6aa31ca91 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -425,4 +425,6 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs=
_info);
>   int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>   			      struct btrfs_squota_delta *delta);
>
> +struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
> +                                            u64 qgroupid);
>   #endif

