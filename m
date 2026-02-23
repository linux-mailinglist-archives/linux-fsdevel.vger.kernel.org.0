Return-Path: <linux-fsdevel+bounces-77975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKX1C5x3nGlfIAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:51:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51F17915E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BD8307CEB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA891301474;
	Mon, 23 Feb 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ygJLyenv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBE1DA23
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861819; cv=none; b=Xq/KMxi0AV6qAkB6T8i/+rzMde/KY781E/rESslzZTnSwsvhVTvHTyK4Qt7ava9wSGub+XRSpoIfYPz1A8mQclpMH/OBWnq1nfDei/1EBDs9r8/7oird97lsd29Xrg0PlOLynD0e9H2RAMe8X9oprD3u50v4NBiowGi+9Rx78w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861819; c=relaxed/simple;
	bh=1vjTuZcHDV2ZI5SRVhWRbwMJHuEsO54FiFp5P39C+S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud06fERWjbNF027QjsWXvLE+whycwVpwAAk5/oHZi5TAkFaV0/eGUF9foFBQe31K6v9nHM0peBh3sypS6ltAJ4XIcFUOMGYM/Odao9c5GeObhxWsrW0ALitRyBnCfxxexFTNnspIU83pArzRjoze7k8sI1JVQzYqjGgT3NEsZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ygJLyenv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4639279c7a6so1624881b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771861815; x=1772466615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqAPk0aOiGg92dWAUPS/2S8gLdQfQt81HHEYhcsPrJM=;
        b=ygJLyenv7e0UFXw+15gQSniho1h+X3G/G7MAFbnxyv7/QsLm/sTOtQ075dwU51PHEI
         d82DIAe6ghXizy/1haZENlMhWTJZFA7+p/3W+KVfUo9g/wvjpJOIPoVFabRVdmay1dZv
         diRHqL0ATkhsLVN/wD6XwwQOirvvYOMI7ub9xj1b5+AnP+dWjVRhvEi3SSawvBZL+pK5
         6BKftDGPRvprkJ273H88jJg838iXVs/+obrrc8dGX33pd6lerX9/uCHMFuWFU2WDQwL7
         yUnzKup+XqraYmKeXab41rqyc+Rd8xZwDKxZSMlfLeeeCDaHxfHec+/8Qz6V84Xure9B
         hIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861815; x=1772466615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqAPk0aOiGg92dWAUPS/2S8gLdQfQt81HHEYhcsPrJM=;
        b=V3WC0TXDgm/hyOfDgh/STl6+BQyqyanXZxi5nBYnVO6C/IPqXJDgAQ18kpZocOtWXh
         EgqyDLD2n/gAIbPD9v01BAQwgzI7FF+14JrkeAl2CrhQr/azOsFzZZb4QYYvyYZ7hPFc
         Vl6T050MtHuExNxxNovTZ11pmjl28/XIWTRj/FUc2xRNJx4A5N7W7ebgBFehdWT61uwf
         sBV43zAjU+f/JUpEjXM+tFKCZD7IhiWwshzbrsoXwFZ22dGLjC2vH+EDOJc06XPcRGGn
         4cIKRvd5pHkJx7vAtEjtjj8U6d+NG7IkMLfQK/YTVN79bFBL0dZEqlN5+RxfWOJhA80C
         uM0g==
X-Forwarded-Encrypted: i=1; AJvYcCXxQRZsGcSJNjsTWwvjhT/dB6zVwHUYdI0dDQKnw3KCAcARMuOX2A4LQMj+iXX+9bilP5UyS3xqbJASYJ54@vger.kernel.org
X-Gm-Message-State: AOJu0YyPl6PngBsjVFh5Bv15qzpU86nZDdzrSRT8QaI7p09DrXcs4Biu
	KnqD3fGXz7VeEIGzkLPwmhdJEJwKHj4iHS22ru+hDbp1t6duK2FG6EsK6FjQrQfOhil3MRvgedx
	r97CL
X-Gm-Gg: AZuq6aKEnqLO9TWzelNmArUbImz4InHtMcFcBT7yzpjQAscWoNBboNhd2nT0YW+TvGK
	I8MC+gZsdNYOZS3kz/a8ghzJ4zVRPhHLw1qEeiH6yBbdGl3YRAVRsGZIUpxpiT/VZP6zdm/2tpU
	lOAQOpEeDsWhQnlWe0nX421gCys5bT89AikF8mBCK8EYd58lokz7bvkBj0VaZ6wkeGE8L0xQNTt
	veash+ZJoCquqC5zLRlchQsF9Jm0KHfFyfw0WOHKfKeSMPfGjDakW3Sqm9u1Qn/+415yWBDeLSO
	ZmKYJe9X9eN91aNGJffUHfd9qufHeirnd4L63n7TVHBi1H74lNoDSDa2xyXJdWryKyAHu4+Y4rg
	AZ6KEj34r3eZp8qwrv2f3vD5UEOWr3xrioqwe+/ZD0rzFViS2KSvxEm9iJ4ZA6XikrszE+GSXxr
	NKVFTavcOQREgM+1bg65ZT5moxXB71vwHmFWBRAzyiTp7x2usF04hZVRj5cQ1flPHR/bvMf9NuP
	VFPHAbUBg==
X-Received: by 2002:a05:6808:4fe6:b0:45e:e8ee:192 with SMTP id 5614622812f47-464463d4960mr5082206b6e.56.1771861815273;
        Mon, 23 Feb 2026 07:50:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf78729sm7557583a34.6.2026.02.23.07.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:50:14 -0800 (PST)
Message-ID: <cd2153f1-098b-463c-bbc1-5c6ca9ef1f12@baylibre.com>
Date: Mon, 23 Feb 2026 09:50:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
References: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,suse.cz,gmail.com];
	TAGGED_FROM(0.00)[bounces-77975-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8A51F17915E
X-Rspamd-Action: no action

On 11/17/25 6:36 AM, Christian Brauner wrote:
> We have reworked namespaces sufficiently that all this special-casing
> shouldn't be needed anymore
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c | 75 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index db236427fc2c..78dee3c201af 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c

...

>  	case PIDFD_GET_USER_NAMESPACE:
> -		if (IS_ENABLED(CONFIG_USER_NS)) {
> -			rcu_read_lock();
> -			ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
> -			rcu_read_unlock();
> +		scoped_guard(rcu) {
> +			struct user_namespace *user_ns;
> +
> +			user_ns = task_cred_xxx(task, user_ns);
> +			if (!ns_ref_get(user_ns))
> +				break;

I think this code is a bit misleading and could lead to unintentional
mistakes in future changes.

scoped_guard() is implemented using a for loop, so this break statement
is only breaking out of the the scoped_guard() scope and not breaking
out of the case as one might expect.

I suggest to change the logic to avoid the break or at least add a
comment pointing out the unusual behavior.

> +			ns_common = to_ns_common(user_ns);
>  		}
>  		break;
>  	case PIDFD_GET_PID_NAMESPACE:
> -		if (IS_ENABLED(CONFIG_PID_NS)) {
> -			rcu_read_lock();
> +		scoped_guard(rcu) {
> +			struct pid_namespace *pid_ns;
> +
>  			pid_ns = task_active_pid_ns(task);
> -			if (pid_ns)
> -				ns_common = to_ns_common(get_pid_ns(pid_ns));
> -			rcu_read_unlock();
> +			if (!ns_ref_get(pid_ns))
> +				break;

Same situation here.

> +			ns_common = to_ns_common(pid_ns);
>  		}
>  		break;
>  	default:


