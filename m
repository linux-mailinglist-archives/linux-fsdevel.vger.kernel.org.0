Return-Path: <linux-fsdevel+bounces-17523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF38AE9EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D81C209C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902913BAF1;
	Tue, 23 Apr 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Z54uW9zs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxmVZroF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63213BAEF
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884195; cv=none; b=mM6sVh6/WEDYvQ+H5joqXl28Hzj/7eSPgt5c5UZoyAM+zifZIbFbsFcTA1NHke1IHNBvzP1yAZt0wn+wcAjQ3lGysI70KAc4WxNtKQKPxYNkQUbFSmExdwOg6uk/UWA79PXechpzI2+XFgLZhfZDYDShtwu6bhXsI/Un6XgIEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884195; c=relaxed/simple;
	bh=MJXL+FfvAmPrqGOvMnyn+mKiUt8KGNaV9mFZIuqTj5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9h5DxMx+YSZxmu8v64lzA6bLtsg8HvUEC0udhkkyhJGeGNIJbBWc55lTOWQoOBF+T4FIawgH7rZCn5qu2uxBqZMfVrcYqCHIOxbLj6rUF5ZtEhnpfiIFbQLtphCtn9sTdMdGEMOzsPUups/9WJeRq78CoaBrWCF24dpPEj0KOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Z54uW9zs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxmVZroF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D43DC138016F;
	Tue, 23 Apr 2024 10:56:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Apr 2024 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1713884191;
	 x=1713970591; bh=uhgJIoTIrmLlnMxFN1ewlxnt4Q3pPQhMlR/wh68W9cc=; b=
	Z54uW9zsIlSAgwh00C6vzsF/fKcDS211y4hhe49dshuIk25Kpp3iBKxoIR/gAHkH
	GbvgPYrgFzl58nB3GgxkEzwbxILsIO6S196UxVCWKDMyL7cBnpDIs7KSB0QOKni/
	icz/QrD9cDsI4qEyuG7ZMd+VYivKhwo6DyJ+GVyMOnInAaEV8X6O9m/23I0RUshs
	yIAbdV1tub9k/FJyHE5vcAHICH5Lr/8eFx166jg8Su9SiFf+vug5IyeW6FXAgKST
	nsykyctyqHNiNhoDhUexc/xt4f87s6S/clK8xDzIeqULq4gB2hbDtiH6h3zxMMhs
	ry03f2H7IsarEHphkO5k6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713884191; x=
	1713970591; bh=uhgJIoTIrmLlnMxFN1ewlxnt4Q3pPQhMlR/wh68W9cc=; b=g
	xmVZroFJQ+qi1Rxin9KGiQCUzzW+mis8qf7iqk2cCZNWRzwyrlJq8tjbITnlbhSf
	2zZdzy4b/dHa3NCTZhxLhxCMjQdeGMgLRB1J89Kj2tCcLIKbpCsEhxf79dDzvePp
	loN8OggWZiooisgu/JoSgtdDoYsPJYEKnCrKg1kXAlBIUkyga8SLWAr+bdvzdbnc
	QrJmAOXK7mxYyanb7SyF6kq2Q4vPNx3ZzbS83EXckNE4VC3FZ+B43HP0ltSgFTGm
	6Avew7vCAozqhb+At/MkEbp4cDYXXvP7U5XbhRDH1LvkyDbdw9BMEvKkTGxs/3cg
	L/l1mi5wBV85q/MbTcrSw==
X-ME-Sender: <xms:H8wnZltcM0oHzHW0Tc2rmE2Y_wDZjlw9EOC_0UVEXlBwacjDKvLKDQ>
    <xme:H8wnZucwshJXiQeZA6SV31b-qVj2BMUp-dj0v7Lm_wf-QhZnAWqJ4UI_K6Oyhb4UK
    AMKIFjW6V90_0FP>
X-ME-Received: <xmr:H8wnZoy0ImzXN7ENqXswuR1CM_N4wpHIWyJxYNF67OsClRXxEtOtZECHLLAV68pz4ExKOQvBmfbJorVbqzm51uxUgdtkbknOEoRMNh6aVp2pOyAVcq1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepieekfedvleetgfffvdevfeelvdefffeghfet
    geegffduudehieeuteevuedukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:H8wnZsMT8FYzfgIpbM412GTY_rnYMiVKC3WlvJMb0Sy7GN09mwgSQA>
    <xmx:H8wnZl9gAUTEF5_WvzCXDC4kYAtLnU2kp9_vSJk-ZQ7mN0KHXQcaJw>
    <xmx:H8wnZsX-pes8Y1KujO1RVbxM8qSXyQttGtuLp54vPAVSfsLGQMLGlw>
    <xmx:H8wnZmcJzJ6pUchEmlilz9G4M6eS2-gHX9aoPa0_w3u7D9NH-3q-aQ>
    <xmx:H8wnZgaYw4zVXjJdDoVchLw-AjGso_dMcTncw_OfIVPQYNeVMb0SsWBn>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 10:56:30 -0400 (EDT)
Message-ID: <6dd4813b-16ef-4d72-9c66-e58e4d32d917@fastmail.fm>
Date: Tue, 23 Apr 2024 16:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: Avoid fuse_file_args null pointer dereference
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
References: <b923f900-3e09-4c6e-a199-05053376d7c2@fastmail.fm>
 <CAJfpegtQ9tFH=7vUtG+UCZnABYkhmHBRgWazrKGfGtYatHUvOw@mail.gmail.com>
 <7c22c836-2be4-49b6-90ac-afebe454c42e@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <7c22c836-2be4-49b6-90ac-afebe454c42e@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/24 14:23, Bernd Schubert wrote:
> 
> 
> On 4/23/24 12:46, Miklos Szeredi wrote:
>> On Mon, 22 Apr 2024 at 19:40, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>
>>> The test for NULL was done for the member of union fuse_file_args,
>>> but not for fuse_file_args itself.
>>>
>>> Fixes: e26ee4efbc796 ("fuse: allocate ff->release_args only if release is needed")
>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>
>>> ---
>>> I'm currently going through all the recent patches again and noticed
>>> in code review. I guess this falls through testing, because we don't
>>> run xfstests that have !fc->no_opendir || !fc->no_open.
>>>
>>> Note: Untested except that it compiles.
>>>
>>> Note2: Our IT just broke sendmail, I'm quickly sending through thunderbird,
>>> I hope doesn't change the patch format.
>>>
>>>   fs/fuse/file.c |    7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index b57ce4157640..0ff865457ea6 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -102,7 +102,8 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
>>>   static void fuse_file_put(struct fuse_file *ff, bool sync)
>>>   {
>>>         if (refcount_dec_and_test(&ff->count)) {
>>> -               struct fuse_release_args *ra = &ff->args->release_args;
>>> +               struct fuse_release_args *ra =
>>> +                       ff->args ? &ff->args->release_args : NULL;
>>
>> While this looks like a NULL pointer dereference, it isn't, because
>> &foo->bar is just pointer arithmetic, and in this case the pointers
>> will be identical.  So it will work, but the whole ff->args thing is a
>> bit confusing.   Not sure how to properly clean this up, your patch
>> seems to be just adding more obfuscation.
> 
> Hmm, right, I had actually thought about that and written a small test,
> before creating the patch. But then had it slightly different - caused
> the null-ptr deref.
> Updated code works, but UBSAN still complains.
> 
> 
> bschubert2@imesrv6 test>./test-union
> test-union.c:23:10: runtime error: member access within null pointer of
> type 'union bar'
> No ptr
> 
> 
> cat test-union.c
> 
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <assert.h>
> 
> union bar
> {
>     int foo;
>     int foo2;
> };
> 
> struct test
> {
>     union bar *bar;
> };
> 
> int main(void)
> {
>     struct test *test = calloc(1, sizeof(test));
>     assert(test);
> 
>     int *foo_ptr = &test->bar->foo;
> 
>     if (foo_ptr)
>         printf("Have ptr\n");
>     else
>         printf("No ptr\n");
> 
>     free(test);
> 
>     return 0;
> }

Tested with an UBSAN enabled kernel and libfuse-hacked-in-no-opendir. No
UBSAN warning - so sorry for the noise!
At least I learned that libfuse by default doesn't deactivate
open/opendir, I had never looked into that before.


Thanks,
Bernd


