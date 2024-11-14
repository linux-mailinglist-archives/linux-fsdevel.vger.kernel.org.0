Return-Path: <linux-fsdevel+bounces-34781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDFB9C8A38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE871F23DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC351FA842;
	Thu, 14 Nov 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="FHNjT9BY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEPvwf9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455601F76C0;
	Thu, 14 Nov 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588153; cv=none; b=QVlBWRemelisFcCHKTUsOKdVLAtGahgEtPM1kcTwaGvp5V7fuN06wrKYCtX6TGkyuysQJrQxVJI5Z9LiYlQh7kwlbVrc5WyBU2iirdvc1fcudkn7CVHkDZLAEBA/w7GHy47doXk0bwmNfm02gRmIHGX6kyFjggc7nyG3TZ3AdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588153; c=relaxed/simple;
	bh=OBboteaVoVEj0REv8awAxGHD2xrdO890TrGuna7+otc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE8riimx1ZathBd5Yj7VgoiwmInubK+E8aAW8EKRsZtupb9S6hnt37HA1P9OdytkriW6vu1YhCC30ghSu91DUtBgS9eLmfRgn+m+S04ulAygTO9si8p28+IWIYnH78l4PHthI225Zppp0QBA5VmeB77WWR63MOlcBIJfRjLnuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=FHNjT9BY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEPvwf9U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31B6F11401E3;
	Thu, 14 Nov 2024 07:42:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 14 Nov 2024 07:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731588150;
	 x=1731674550; bh=GtrzjcC7xObwp3dBNxOSTrT96UKJvRh37T7T6adZp/0=; b=
	FHNjT9BYaVtM9w0a+1uJGrmRJhUQwmANVy8cCJG77YB003jNDo7iFZXZP1lFoNI4
	nywvAB5j5GFRPwiVioZ4dzDGPEvV89YY9gcl7wSOAWoKMf4UNk+fIH+qAP+rrMm3
	KLsAmMMP6gNMmppAmuJ5uez6LuP2SJfYoRGUvBiT7mW38JM7qmp1gzmpKW+XeO2q
	Dtdm8EigndM6VbwpzzqgnIU7l75rMXlEmti0NAljmlNgRtlCw/K9AAmAg9ZWCOT0
	uf4kU/LlGdYWbcMif5J/jP2afWKmIliZSi6ZtCpDPrHcw/KTWJJnmpXcgjmYd7RT
	GZE7VDG/I18lKGY/SMFQuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731588150; x=
	1731674550; bh=GtrzjcC7xObwp3dBNxOSTrT96UKJvRh37T7T6adZp/0=; b=F
	EPvwf9Ue5IHnb+4KGfqqsoqTlRC0xJDTtdYEOTdJoyx2LdcxC9q6g3agLgOoHIka
	y8Oy1QAsDWFdOSU7BM7Zr4o6Axw/sgz1IrOiLAwVLnu5MzoVVGFc1n1/tXJfa3Qt
	4adnXWCvFGHkn/tmfRQQCCsJ2DSl2gV0xKhv6hxK22BcfOZQYhVgOrdNmX2P6yy/
	hf3QUgJ7tKdVuAGwDLc2491IUX2iSHxqnAiGqldJ6aFmNmr3wmcO9be0Fd3AOCQD
	S4DyfIFhWHsindmxZpU+MJd93cue2vN4OhPlCHf1gtnjUrKrhu+O0K8JKq1hFujJ
	shSWXvcL92O6beWbhU0ow==
X-ME-Sender: <xms:NfA1Z0HybJ8KlCkdMvwafDcZ9VS6lgnlEP6YKZWOrWmlzwn9BfRj_A>
    <xme:NfA1Z9Wn67zKGq8wAmVzESj9yauZJr-D7upiNTz-rtzY5yRFD1d4yLTkic9XIrjWy
    yT0xyqbaONazv2L0Ug>
X-ME-Received: <xmr:NfA1Z-Ir3I67tZTh0WACYSVRf3ujXMWOpk-jwLYXbBBxrkMkhKub2rWerqZAyfttmmlbBbjl-LTG6wUMFb2ri7a81wX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnheptdeltdfhveehheekleefvddtffefgefg
    teelkeffudehkeeitdeljedvkeefheehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhi
    nhdrshhhvghphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirh
    hoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehjrggtkhesshhu
    shgvrdgtiidprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NfA1Z2EnZ1h8MfVVPiqtkWRX5JInjX2s3HwjDgCeP-nG8P6opxfK_g>
    <xmx:NfA1Z6Wu_Pg81gYDacYOPQN4q2gzePWLIYTbjUOoZqX7-uyK3XkDNw>
    <xmx:NfA1Z5M2gZ_9xu6oEeE_BFGpc-kU1ULXmfvyCWZtC7iCfhWmYj0ebQ>
    <xmx:NfA1Zx3gLT0o7p8KMRXrSwN0gSuXbC1JkeL1UEvY7vDziIr4hn-AIA>
    <xmx:NvA1Z2TiiJVLlCo8UNtqmte39oje-yQykN7U3o39n_V7Gk4UNrysXg9Y>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 07:42:27 -0500 (EST)
Message-ID: <600bbf1c-5225-4e24-8c93-26fa46fd7990@e43.eu>
Date: Thu, 14 Nov 2024 13:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
 <CAOQ4uxh2HWkVE_aMeYSTsYRO9_sKMPH7V2uksWFSo3ucWOoJ2g@mail.gmail.com>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <CAOQ4uxh2HWkVE_aMeYSTsYRO9_sKMPH7V2uksWFSo3ucWOoJ2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 14/11/2024 08:07, Amir Goldstein wrote:
> On Wed, Nov 13, 2024 at 7:11 PM Erin Shepherd <erin.shepherd@e43.eu> wrote:
>> On 64-bit platforms, userspace can read the pidfd's inode in order to
>> get a never-repeated PID identifier. On 32-bit platforms this identifier
>> is not exposed, as inodes are limited to 32 bits. Instead expose the
>> identifier via export_fh, which makes it available to userspace via
>> name_to_handle_at
>>
>> In addition we implement fh_to_dentry, which allows userspace to
>> recover a pidfd from a PID file handle.
> "In addition" is a good indication that a separate patch was a good idea..
>
>> We stash the process' PID in the root pid namespace inside the handle,
>> and use that to recover the pid (validating that pid->ino matches the
>> value in the handle, i.e. that the pid has not been reused).
>>
>> We use the root namespace in order to ensure that file handles can be
>> moved across namespaces; however, we validate that the PID exists in
>> the current namespace before returning the inode.
>>
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> This patch has changed enough that you should not have kept my RVB.
>
> BTW, please refrain from using the same subject for the cover letter and
> a single patch. They are not the same thing, so if they get the same
> name, one of them has an inaccurate description.
>
ACK to all three.


>> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
>> ---
>>  fs/pidfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/pidfs.c b/fs/pidfs.c
>> index 80675b6bf88459c22787edaa68db360bdc0d0782..0684a9b8fe71c5205fb153b2714bc9c672045fd5 100644
>> --- a/fs/pidfs.c
>> +++ b/fs/pidfs.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/anon_inodes.h>
>> +#include <linux/exportfs.h>
>>  #include <linux/file.h>
>>  #include <linux/fs.h>
>>  #include <linux/magic.h>
>> @@ -347,11 +348,69 @@ static const struct dentry_operations pidfs_dentry_operations = {
>>         .d_prune        = stashed_dentry_prune,
>>  };
>>
>> +#define PIDFD_FID_LEN 3
>> +
>> +struct pidfd_fid {
>> +       u64 ino;
>> +       s32 pid;
>> +} __packed;
>> +
>> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>> +                          struct inode *parent)
>> +{
>> +       struct pid *pid = inode->i_private;
>> +       struct pidfd_fid *fid = (struct pidfd_fid *)fh;
>> +
>> +       if (*max_len < PIDFD_FID_LEN) {
>> +               *max_len = PIDFD_FID_LEN;
>> +               return FILEID_INVALID;
>> +       }
>> +
>> +       fid->ino = pid->ino;
>> +       fid->pid = pid_nr(pid);
>> +       *max_len = PIDFD_FID_LEN;
>> +       return FILEID_INO64_GEN;
>> +}
>> +
>> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>> +                                        struct fid *gen_fid,
>> +                                        int fh_len, int fh_type)
>> +{
>> +       int ret;
>> +       struct path path;
>> +       struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
>> +       struct pid *pid;
>> +
>> +       if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
>> +               return NULL;
>> +
>> +       scoped_guard(rcu) {
>> +               pid = find_pid_ns(fid->pid, &init_pid_ns);
>> +               if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0)
>> +                       return NULL;
>> +
>> +               pid = get_pid(pid);
>> +       }
>> +
>> +       ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
>> +       if (ret < 0)
>> +               return ERR_PTR(ret);
> How come no need to put_pid() in case of error?

This one confused me at first too, but path_from_stashed frees it (via
stashed_ops.put_data) on error. You can see the same pattern in
pidfs_alloc_file.

(It already needs to know how to free it for the case where a stashed
dentry already exists)

>> +
>> +       mntput(path.mnt);
>> +       return path.dentry;
>> +}
>> +
>> +static const struct export_operations pidfs_export_operations = {
>> +       .encode_fh = pidfs_encode_fh,
>> +       .fh_to_dentry = pidfs_fh_to_dentry,
>> +       .flags = EXPORT_OP_UNRESTRICTED_OPEN,
>> +};
>> +
>>  static int pidfs_init_inode(struct inode *inode, void *data)
>>  {
>>         inode->i_private = data;
>>         inode->i_flags |= S_PRIVATE;
>> -       inode->i_mode |= S_IRWXU;
>> +       inode->i_mode |= S_IRWXU | S_IRWXG | S_IRWXO;
> This change is not explained.
> Why is it here?

open_by_handle_at eventually passes through the may_open permission check.
The existing permissions only permits root to open them (since the owning
uid & gid is 0). So, it was necessary to widen them to align with how
pidfd_open works.

If I stick with this approach (see [1]) I'll ensure to document this change
better in the commit message.

[1] https://lore.kernel.org/all/6a3ed633-311d-47ff-8a7e-5121d6186139@e43.eu/



