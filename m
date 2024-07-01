Return-Path: <linux-fsdevel+bounces-22892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6AE91E6BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E623E1C21C38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB516EB57;
	Mon,  1 Jul 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="X+/pziMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937BF2C6A3
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855327; cv=none; b=thhaMnMHBR67THVJr74bsFGFtDF7/RaCsp8ZzL5OkkRqXS1qh3Gs1lPSaaQcO+SX+ELcC4mbx+5lo7OSiMmwoaQmVBnmKem3MJlT3PzZRBZHzGmRRuVPnXPWh5vsdYc6yYa4FVXazgjDxTnIvcIvre7hh7GTd15GzDrBc/NU2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855327; c=relaxed/simple;
	bh=uZhKCpd0rpUE00LabatTP20LqHYjyIudM4ooCpSwFhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYEQpE0+Sc9vxt+Om4M4Hmt1JzSj/6nNJfsLWLf/2S/CvfpoSgKdhJ3SpBko9XqeotYyF6vnVDHV3cTjCllEOTdleCMVOU9idqE8yBfVb0jvPwSVXyJ38OSvXsot6+BnT/MwTDoE/L1ma9o6hfMoZOxiFH7SsEvj8GwczhBlNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=X+/pziMk; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 5A19D1210;
	Mon,  1 Jul 2024 12:35:18 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 5A19D1210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1719855318;
	bh=TNLnQ4F1368Z1Mf4Gz2lG5AYgm9+H5/YqZubS9SYHSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X+/pziMkUt5L3EpRy9xQ2X2S10vNxIAzuGYr6LgKKE+QkYVqjpwtpFI5NEt9zTOAg
	 /pcPaBMw10e+zI86D13xI1nNCcI0EuS88do/fsRRKJJ/TUChNakVOGSJmu7KsKZJ74
	 A0GCUwIhMqcfH+1l4kDBxYwgUTjdXG9CGOHnk/wQ0Htsh3M3+hZERPn1+/9Ht+lxAw
	 f1JqFUQVgAMFc5a9gGvEl2pLSiasZqf1dgnDwjaXafxOuGRytn5BFbYnq6hGlfft98
	 8NeS43oKVv3BQ40MbEL2jIs7GxGKiFoPKemMvTxpz9n4durSVBWGizXa4fTPnCy8Kj
	 yuWGyc/vOs3KQ==
Message-ID: <216b2317-cec3-4cfd-9dc2-ed9d29b5c099@sandeen.net>
Date: Mon, 1 Jul 2024 12:35:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 V2] fat: Convert to new mount api
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
 <2509d003-7153-4ce3-8a04-bc0e1f00a1d5@redhat.com>
 <72d3f126-ac1c-46d3-b346-6e941f377e1e@redhat.com>
 <87v81p8ahf.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <87v81p8ahf.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 9:15 AM, OGAWA Hirofumi wrote:
> Eric Sandeen <sandeen@redhat.com> writes:
> 
> [...]
> 
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> V2: Ignore all options during remount via
>>
>> 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
>> 		return 0;
> 
> Thanks, basically looks good. However I tested a bit and found a bug,
> and small comments.

Thanks!

>> +extern const struct fs_parameter_spec fat_param_spec[];
>> +extern int fat_init_fs_context(struct fs_context *fc, bool is_vfat);
>> +extern void fat_free_fc(struct fs_context *fc);
>> +
>> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>> +		    int is_vfat);
>> +extern int fat_reconfigure(struct fs_context *fc);
> 
> Let's remove extern from new one.

ok

>> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>> +			   int is_vfat)
> 
> Maybe better to use bool (and true/false) instead of int for is_vfat?

Ok - I think I just followed the lead of the ints in parse_options() today
but bool does make more sense.

>> +{
>> +	struct fat_mount_options *opts = fc->fs_private;
>> +	struct fs_parse_result result;
>> +	int opt;
>> +	char buf[50];
> 
> [...]	
> 
>> +	case Opt_codepage:
>> +		sprintf(buf, "cp%d", result.uint_32);
> 
> "buf" is unused.

whoops, you are right. thanks.

>> +	/* obsolete mount options */
>> +	case Opt_obsolete:
>> +		infof(fc, "\"%s\" option is obsolete, not supported now",
>> +		      param->key);
>> +		break;
> 
> I'm not sure though, "Opt_obsolete" should use fs_param_deprecated?

Ah, that's probably smart. And I will switch this back to fat_msg() so that it's
logged in dmesg as it was before.

>> +	default:
>> +		return -EINVAL;
> 
> I'm not sure though, "default:" should not happen anymore?

That's right. However, even conversions done by dhowells (for example
ec10a24f10c8 vfs: Convert jffs2 to use the new mount API) retain the
default: case. Happy to do this however you like, though keeping the default:
seems reasonably defensive?

>>  	}
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(fat_parse_param);
> 
> [...]
> 
>> +	/* If user doesn't specify allow_utime, it's initialized from dmask. */
>> +	if (opts->allow_utime == (unsigned short)-1)
>> +		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
>> +	if (opts->unicode_xlate)
>> +		opts->utf8 = 0;
> 
> Probably, this should move to fat_parse_param()?

In my conversions, I have treated parse_param as simply handling one option at
a time, and not dealing with combinations, because we don't have the "full view"
of all options until we are done (previously we parsed everything, and then could
"clean up" at the bottom of the function). So now, I was handling this sort of
checking after parsing was complete, and fill_super seemed an OK place to do it.

But sure - I will look at whether doing it in fat_parse_param makes sense.

>> +	/* Apply pparsed options to sbi */

<typo here too>

>> +	sbi->options = *opts;
> 
> 	/* Transfer ownership of iocharset to sbi->options */
> 	opts->iocharset = NULL;
> 	opts = &sbi->options;
> 
> opts->iocharset is freed by both of opts and sbi->options, we should fix
> it like above or such.

Ah, good catch.

>> -	sprintf(buf, "cp%d", sbi->options.codepage);
>> +	sprintf(buf, "cp%d", opts->codepage);
> 
> [...]
> 
>>  	/* FIXME: utf8 is using iocharset for upper/lower conversion */
>>  	if (sbi->options.isvfat) {
>> -		sbi->nls_io = load_nls(sbi->options.iocharset);
>> +		sbi->nls_io = load_nls(opts->iocharset);
>>  		if (!sbi->nls_io) {
>>  			fat_msg(sb, KERN_ERR, "IO charset %s not found",
>> -			       sbi->options.iocharset);
>> +			       opts->iocharset);
>>  			goto out_fail;
> 
> Revert above to remove opts usage to not touch after ownership transfer
> if we fix the bug like that way.

ok

>> +static int msdos_parse_param(struct fs_context *fc, struct fs_parameter *param)
>> +{
>> +	return fat_parse_param(fc, param, 0);
> 
> If we changed int to bool, 0 to false.

*nod*

>> +static int msdos_init_fs_context(struct fs_context *fc)
>> +{
>> +	int err;
>> +
>> +	/* Initialize with isvfat == 0 */
>> +	err = fat_init_fs_context(fc, 0);
> 
> If we changed int to bool, 0 to false.

*nod*

>> +static int vfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
>> +{
>> +	return fat_parse_param(fc, param, 1);
> 
> If we changed int to bool, 0 to true.

*nod*

>> +static int vfat_init_fs_context(struct fs_context *fc)
>> +{
>> +	int err;
>> +
>> +	/* Initialize with isvfat == 1 */
>> +	err = fat_init_fs_context(fc, 1);
> 
> If we changed int to bool, 0 to true.

*nod* :)

Thanks for the review, and sorry for the errors.

-Eric

> Thanks.


