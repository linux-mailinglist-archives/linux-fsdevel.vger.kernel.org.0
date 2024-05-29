Return-Path: <linux-fsdevel+bounces-20486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7AF8D3FC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A291B25BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0F1C8FB1;
	Wed, 29 May 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="BzpZ688i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA321667DC;
	Wed, 29 May 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015429; cv=none; b=BPv8xjFUGYZy3YLPCw4875ZblQ1P7gqlSBl2F0SGyeHmDCA+1SicyBPc3VxXBEfyWCzrj8dr05G8ajppEMJUArqlZBF6+yf5F0/b58RVOzscq6795L8NEIMwgZO94yLGXqizayO90znpj7srKJvhvNdw9iX9j4mtaGMsma+sP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015429; c=relaxed/simple;
	bh=oxKOEzuTFXm+4u/4nCbPs7Ta/eea2srIh+KxcoBneUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ+soEkCTYs4ZrppZzOYYkLTuT/ad7TBa4/PNHg6zSsFgzsjgl3F9f7yhMzG66c6+NzizAl1uQ2Yp+hieTZezYGfsQAZpBi/KJkZ6u5H6ngowxO36d2RsBqTXeoLvUv5ToB1++CJjkf1/3r7RTjAGvXMMTP6+rvj8p1K/OdRV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=BzpZ688i; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id DA89A11656;
	Wed, 29 May 2024 15:43:45 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net DA89A11656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717015426;
	bh=E7QKq0WCihw1WClMAD9nDcjIQtM+P0EUnUc0UH+E07Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzpZ688iwlrOfMIzxTCsgUc1XGaOfaqs3Sd/EdvJlFcIKV7Gknh9QXIoL2Sg6FM/Y
	 BVyv25Ej1IY6mplO+O277lZIyaxNGtRB6D+AcGphQnm+0tHbqYJgzBRI8efS3Vme3k
	 w93CKi6Kl15LQ6lEjidDUW11pNogi1iIUW67XOeGw7cyJoArKjC10LulLCKHc6sYyl
	 MC9hrt//yfoNTyp1pL9EAc5+iBQRT4qKtObOhyNjMPxDRgui/5NTjdm/ESzKecy+Eh
	 mLxXvWEs2fvev8Kl+J1H7wss0jpSDAkX1xGLHtP1n/y412dTOA/AKAZW2vBSwQZlEG
	 EZGFdzzCEqfbw==
Message-ID: <39a2d0a7-20f3-4a51-b2e0-1ade3eab14c5@sandeen.net>
Date: Wed, 29 May 2024 15:43:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
To: Christian Brauner <brauner@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 8:55 AM, Christian Brauner wrote:
> On Wed, May 22, 2024 at 10:38:51AM +0200, Wolfram Sang wrote:
>> The 'noauto' and 'auto' options were missed when migrating to the new
>> mount API. As a result, users with these in their fstab mount options
>> are now unable to mount debugfs filesystems, as they'll receive an
>> "Unknown parameter" error.
>>
>> This restores the old behaviour of ignoring noauto and auto if they're
>> given.
>>
>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>
>> With current top-of-tree, debugfs remained empty on my boards triggering
>> the message "debugfs: Unknown parameter 'auto'". I applied a similar fix
>> which CIFS got and largely reused the commit message from 19d51588125f
>> ("cifs: ignore auto and noauto options if given").
>>
>> Given the comment in debugfs_parse_param(), I am not sure if this patch
>> is a complete fix or if there are more options to be ignored. This patch
>> makes it work for me(tm), however.
>>
>> From my light research, tracefs (which was converted to new mount API
>> together with debugfs) doesn't need the same fixing. But I am not
>> super-sure about that.
> 
> Afaict, the "auto" option has either never existent or it was removed before
> the new mount api conversion time ago for debugfs. In any case, the root of the
> issue is that we used to ignore unknown mount options in the old mount api so
> you could pass anything that you would've wanted in there:
> 
> /*
>  * We might like to report bad mount options here;
>  * but traditionally debugfs has ignored all mount options
>  */
> 
> So there's two ways to fix this:
> 
> (1) We continue ignoring mount options completely when they're coming
>     from the new mount api.
> (2) We continue ignoring mount options toto caelo.
> 
> The advantage of (1) is that we gain the liberty to report errors to
> users on unknown mount options in the future but it will break on
> mount(8) from util-linux that relies on the new mount api by default. So
> I think what we need is (2) so something like:

Argh, sorry I missed this thread until now.

FWIW, I think the "ignore unknown mount options" was a weird old artifact;
unknown options were only ignored originally because there were none at all,
hence no parser to reject anything.

Still, it seems odd to me that "auto/noauto" were ever passed to the kernel,
I thought those were just a hint to userspace mount tools, no?

And why wouldn't every other filesystem with rejection of unknown options
fail in the same way?

And indeed, if I add this line to my fstab on a fedora rawhide box with the
latest upstream kernel that has the new mount API debugfs patch present

debugfs /debugfs-test debugfs auto 0 0 

and strace "mount -a" or "mount /debugfs-test" I do not see any "auto" options
being passed to the kernel, and both commands succeed happily. Same if I change
"auto" to "noauto"

@Wolfram, what did your actual fstab line look like? I wonder what is actually
trying to pass auto as a mount option, and why...

-Eric

> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index dc51df0b118d..713b6f76e75d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -107,8 +107,16 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
>         int opt;
> 
>         opt = fs_parse(fc, debugfs_param_specs, param, &result);
> -       if (opt < 0)
> +       if (opt < 0) {
> +               /*
> +                * We might like to report bad mount options here; but
> +                * traditionally debugfs has ignored all mount options
> +                */
> +               if (opt == -ENOPARAM)
> +                       return 0;
> +
>                 return opt;
> +       }
> 
>         switch (opt) {
>         case Opt_uid:
> 
> 
> Does that fix it for you?
> 


