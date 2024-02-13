Return-Path: <linux-fsdevel+bounces-11496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C8D853FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1CA1F2236E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A9629FA;
	Tue, 13 Feb 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="jleKe4w/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D4629E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865891; cv=none; b=Y/H52FNFfX9QP7mZSH2dIOM+tNf3TKcBSOOFe7f+2ScKrK8Kzc6f7xLq9asq6j5Jzq280QZfG7yR5Rb2wAb06rg8ZxvA7mBbxxUdVW9lUm9bg50LxBWKxKCNgyGcutYNrd/AZ6qpu/PYdbtsI3LAzpl209e3VxF464X4zRBMHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865891; c=relaxed/simple;
	bh=6GgBZp2b0JdUpy+KCwsIDxNbSGXoJ7c06JhVdileA0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKCoEUp6Cw451yHbJWaF97Xcbjv+wnfhhBGX03ZRn956kGA5OESn7ykpYuXEHLrvc3+5ueGok3Ykpy8QltJejmWbjf+mMKs6vWsfPqSIJZv1BFH1VUW5chOJRsqDnV+QnnJgEimiaoXKr06ZaUiP+2BVJ8rlyfAnEWoLuizJiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=jleKe4w/; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 7663E33505B;
	Tue, 13 Feb 2024 17:11:28 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 7663E33505B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1707865888;
	bh=SqOA29FiEcosyTGHVSyG0WnTn9ex0aq855MZHtmH66o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jleKe4w/9Fb8ZvYZ7JfD8ZvQMxQLJf+MOAzlyqGDpwgjaHyJ4DNoxlWfSTi9XID/T
	 o4H0GohWiyUHVErdyNTku45Ck3E17Jglju+yaHz7mduJkHfc0S8yFbWdzHc8PWSOp9
	 XaOoVRkCfZuHwAfOenPX+Jsh/O030m4b4B9Jaw80ZszMNUc8lgM6TvHzgN4g7n6GTl
	 irRO7B/CE85n9ez47DUqi4YbnbcISKshMuRieNIImeZ7YPjU3MkLf75U0qJuhWxUYB
	 8zYVsD6fJZQHlADW8ulTFWqYJPw0frxeivXytftnJDmf8niuCvLMRB7iTI8VELwEDE
	 EGGw0rjVhrudg==
Message-ID: <af9f80ae-3ecf-4efd-a0e2-e0f3b2520950@sandeen.net>
Date: Tue, 13 Feb 2024 17:11:27 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udf: convert to new mount API
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
 <20240213124933.ftbnf3inbfbp77g4@quack3>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240213124933.ftbnf3inbfbp77g4@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 6:49 AM, Jan Kara wrote:
> On Fri 09-02-24 13:43:09, Eric Sandeen wrote:
>> Convert the UDF filesystem to the new mount API.

...

>> +static void udf_init_options(struct fs_context *fc, struct udf_options *uopt)
>> +{
>> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
>> +		struct super_block *sb = fc->root->d_sb;
>> +		struct udf_sb_info *sbi = UDF_SB(sb);
>> +
>> +		uopt->flags = sbi->s_flags;
>> +		uopt->uid   = sbi->s_uid;
>> +		uopt->gid   = sbi->s_gid;
>> +		uopt->umask = sbi->s_umask;
>> +		uopt->fmode = sbi->s_fmode;
>> +		uopt->dmode = sbi->s_dmode;
>> +		uopt->nls_map = NULL;
>> +	} else {
>> +		uopt->flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
>> +		/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */
> 
> Nit: Please wrap these two lines.

Done, noticed that after sending, sorry!

>> +static void udf_free_fc(struct fs_context *fc)
>> +{
>> +	kfree(fc->fs_private);
>> +}
> 
> So I think we need to unload uopt->nls_map in case we eventually failed the
> mount (which means we also need to zero uopt->nls_map if we copy it to the
> sbi).

Hmm let me look into that - I guess there are ways for i.e. udf_fill_super
can fail that wouldn't free it before we got here.

>> +static const struct fs_parameter_spec udf_param_spec[] = {
>> +	fsparam_flag	("novrs",		Opt_novrs),
>> +	fsparam_flag	("nostrict",		Opt_nostrict),
>> +	fsparam_u32	("bs",			Opt_bs),
>> +	fsparam_flag	("unhide",		Opt_unhide),
>> +	fsparam_flag	("undelete",		Opt_undelete),
>> +	fsparam_flag	("noadinicb",		Opt_noadinicb),
>> +	fsparam_flag	("adinicb",		Opt_adinicb),
> 
> We could actually use the fs_param_neg_with_no for the above. I don't
> insist but it's an interesting exercise :)

good idea, done.

...

>> +	switch (token) {
>> +	case Opt_novrs:
>> +		uopt->novrs = 1;
> 
> I guess we can make this just an ordinary flag as a prep patch?

Sorry, not sure what you mean by this?

Oh, a uopt->flag. Ok, I can do that.

>> +		break;
>> +	case Opt_bs:
>> +		n = result.uint_32;;
> 				  ^^ one is enough ;)
> 
>> +		if (n != 512 && n != 1024 && n != 2048 && n != 4096)
>> +			return -EINVAL;
>> +		uopt->blocksize = n;
>> +		uopt->flags |= (1 << UDF_FLAG_BLOCKSIZE_SET);
>> +		break;
>> +	case Opt_unhide:
>> +		uopt->flags |= (1 << UDF_FLAG_UNHIDE);
>> +		break;
>> +	case Opt_undelete:
>> +		uopt->flags |= (1 << UDF_FLAG_UNDELETE);
>> +		break;
> 
> These two are nops so we should deprecate them and completely ignore them.
> I'm writing it here mostly as a reminder to myself as a work item after the
> conversion is done :)

ok ;)
 
>> +	case Opt_noadinicb:
>> +		uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
>> +		break;
>> +	case Opt_adinicb:
>> +		uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
>> +		break;
>> +	case Opt_shortad:
>> +		uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
>> +		break;
>> +	case Opt_longad:
>> +		uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
>> +		break;
>> +	case Opt_gid:
>> +		if (0 == kstrtoint(param->string, 10, &uv)) {
> Nit:
> 		    ^^ I prefer "kstrtoint() == 0"

No problem.

-Eric

> Otherwise looks good.
> 
> 								Honza


