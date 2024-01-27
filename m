Return-Path: <linux-fsdevel+bounces-9189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6E83EB41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 06:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831D5B23D44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938C13FFB;
	Sat, 27 Jan 2024 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HAHvAryw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1F14A89;
	Sat, 27 Jan 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332652; cv=none; b=YDjBLJpUvwOT9afyZgAXdtmiKAFZ/AIdseZtuWglO0A2kx82LVk7Fn4uZBetm4yTlePJH67W6Oav5jVJUWsCnrFnggTl5nFC2iwXZ6JpFS8n4zsJmnVBL05a50vZt7pn6ErbaN95gv5A2I2vmswz/Zl5rb4uwkmGkrdE9eb1rGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332652; c=relaxed/simple;
	bh=dU8fqx8M8vbi+SwP7PEPAYOiaD41B/qN7tDKilT3zj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmiOh/yPE452t8toBkXqbFssQGK6vybCFbzf42jnQQC34RBxQM5843kncvL4+WlRKY8kI+peLO42DDGOr9apfaf17cW3yICrUxzAl4ngqqySwRvyFhNJfya79DVEjCOFja50rpTGVDZr8x4ZeABoj3kHVmrbJ9tCQDJFp7gybX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HAHvAryw; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BC6573FFCB;
	Sat, 27 Jan 2024 05:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706332647;
	bh=RGdmLwVJaeGh5hPc5pI57XxhUQN2/0dpo4aenb9lXl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=HAHvArywcoUyZ+eBuafvECo7LZ4BCBvkD/ANxor/PnWy6F0HVR1EGQ5lhiaFKUCM2
	 ZqNYkQv3UThEoEUFpvnKFjlmD/5+pbB1x+iTN+huq2UE6gl8Qz3O2bXfm6/SBx0tlC
	 VM6g1SktDlIAVy+JuOYo3y/WYOdAHe/3JNSLiKD51n9QDVpYI34isEqAWFU0CCpMel
	 XEKIYzVpNmhKoSpLNN4sgO/YfXqvxWzC3MDM8sWxTem82PrnT7BaVMu7UqyTz3wUEI
	 D/PxZZaSYoCHs6Q0ZK5xhDh1BatUaVH1K4i9RA7m4QCo8zDxYGaI3AAulRFlExbObG
	 2qkwYTw8h06+g==
Message-ID: <ff9a525e-8c39-4590-9ace-57f4426cbe74@canonical.com>
Date: Fri, 26 Jan 2024 21:17:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240958.8D9A11E8E@keescook>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <202401240958.8D9A11E8E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 10:57, Kees Cook wrote:
> On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
>> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> Hmm. That whole thing is disgusting. I think it should have checked
>>> FMODE_EXEC, and I have no idea why it doesn't.
>>
>> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
>> think it would be even better if we had the 'intent' flags from
>> 'struct open_flags' available, but they aren't there in the
>> file_open() security chain.
> 
> I've tested AppArmor, and this works fine:
> 
thanks. I also ran it through the regression test suit, to double
check so that Murphy doesn't bite.

that this even tripped a regression is a bug that I am going to
have to chase down. The file check at this point should just be
redundant.

thanks for the quick fix

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 7717354ce095..ab104ce05f96 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -470,7 +470,7 @@ static int apparmor_file_open(struct file *file)
>   	 * implicit read and executable mmap which are required to
>   	 * actually execute the image.
>   	 */
> -	if (current->in_execve) {
> +	if (file->f_flags & __FMODE_EXEC) {
>   		fctx->allow = MAY_EXEC | MAY_READ | AA_EXEC_MMAP;
>   		return 0;
>   	}
> 
> Converting TOMOYO is less obvious to me, though, as it has a helper that
> isn't strictly always called during open(). I haven't finished figuring
> out the call graphs for it...
> 


