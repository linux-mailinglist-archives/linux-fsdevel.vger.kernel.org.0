Return-Path: <linux-fsdevel+bounces-78295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOIqDDPunWncSgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:30:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5EF18B64E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 269343078157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CED313534;
	Tue, 24 Feb 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="X7YXt1Lf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953F28F949
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957645; cv=none; b=LV944vJRa7arPA2X0BOT17VDIRDhvv8JDp2rjtkO7MPsLjMid+LSLXdtDnuy1YtUMCHnNdBrCD2FtMEDnWRKYbhATl0m6J0fv5f2+xl7UBmPrc4Pfc7+TNjo2ibFTVxscz0AoXFGLitSOthX80kPGvQj4p/YxazlHkz5zRisoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957645; c=relaxed/simple;
	bh=hMYpabWw/+kcwdGJaT+0xk9AyLdYMAk2LirLPDxorfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFZd/xpZn9OepVSVzEwApBowtoPgRHW9bHFvD7dI+xLsThNkOesUTEXLlTMlXnN8ORNBSfOXrr84JzUTNtHBJtZqhbUeeaHb5FB1avMowvELxBXtto+KuTrrgddp0Xi0DCWefQER8RYxhb+zS7MMuk3YOlskLgDpFlG2XbuoRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=X7YXt1Lf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBB3A3EC37;
	Tue, 24 Feb 2026 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1771957636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8bUM/ZaZYsLwGdRNtZF081c7oajcagvCnOgp5cHx4A=;
	b=X7YXt1LfyT3el1HCt/PgQpdLkzATxU3eGBmsI6xr1PfXwMkRBqJ5MpC5rqcesLJ/WIIyV3
	Te181inRSBp8EeJjYk9GLu+kVPpeRnQSpHelcBtA5U58ZRdjkt4IeUGGEJqem46Xg5LpBr
	fS6QJRooyq7MpGEBJCvygnRl1lfvPMTCRyfzMEImJuVP60zICFTXkFBDGjjRKw1aa92i75
	zBwQ2RlP/1Yh5hwlb9G1DVLXbX39UCLyur2zyVtL1ZmX9G8CCIDP8QXEtJc04qu5csqZyu
	EE2sj0Fd+55HzJpghPu59o1FeNcSVwUcAhArBUOLCFKmWGuqYbYZAW2Twj87bQ==
Message-ID: <049730d5-b33b-4053-b423-02920c233258@gtucker.io>
Date: Tue, 24 Feb 2026 19:27:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make_task_dead() & kthread_exit()
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
 <9aa90f39-2c13-4e81-94ac-e2f61970b85b@sirena.org.uk>
Content-Language: en-GB
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <9aa90f39-2c13-4e81-94ac-e2f61970b85b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhohgjtgfgsehtjeertddtvdejnecuhfhrohhmpefiuhhilhhlrghumhgvucfvuhgtkhgvrhcuoehgthhutghkvghrsehgthhutghkvghrrdhioheqnecuggftrfgrthhtvghrnhepvdeihfekhfejtdfgueevieffkeduhfejhfettdetudetteejieduveevueeugefgnecukfhppedvtddtudemkeeiudemgegrgedtmeekiedvtdemiegvheehmegrvggrheemudgusgelmegtfhdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemgegrgedtmeekiedvtdemiegvheehmegrvggrheemudgusgelmegtfhdvtddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemgegrgedtmeekiedvtdemiegvheehmegrvggrheemudgusgelmegtfhdvtdgnpdhmrghilhhfrhhomhepghhtuhgtkhgvrhesghhtuhgtkhgvrhdrihhopdhqihgupeffueeufeetfefgveefjedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhjghhuiihikhesghhmrghilhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-GND-State: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gtucker.io:s=gm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78295-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gtucker.io];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[gtucker.io:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gtucker@gtucker.io,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gtucker.io:mid,gtucker.io:dkim,gtucker.io:email]
X-Rspamd-Queue-Id: BC5EF18B64E
X-Rspamd-Action: no action

On 24/02/2026 18:04, 'Mark Brown' via KUnit Development wrote:
> On Tue, Feb 24, 2026 at 05:25:21PM +0100, Christian Brauner wrote:
> 
>> Ugh, yuck squared.
> 
>> IIUC, the bug is a UAF in free_kthread_struct(). It wasn't easy
>> detectable until the pidfs rhashtable conversion changed struct pid's
>> size and field layout.
> 
> Eeew, indeed.  Thanks for figuring this out!
> 
>> Fix should be something like
> 
>>     void free_kthread_struct(struct task_struct *k)
>>     {
>>         struct kthread *kthread;
>>
>>         kthread = to_kthread(k);
>>         if (!kthread)
>>             return;
>>
>>     +   if (!list_empty(&kthread->affinity_node)) {
>>     +       mutex_lock(&kthread_affinity_lock);
>>     +       list_del(&kthread->affinity_node);
>>     +       mutex_unlock(&kthread_affinity_lock);
>>     +   }
>>     +   if (kthread->preferred_affinity)
>>     +       kfree(kthread->preferred_affinity);
>>
>>     #ifdef CONFIG_BLK_CGROUP
>>         WARN_ON_ONCE(kthread->blkcg_css);
>>     #endif
>>         k->worker_private = NULL;
>>         kfree(kthread->full_name);
>>         kfree(kthread);
>>     }
> 
>> The normal kthread_exit() path already unlinks the node. After
>> list_del(), the node's pointers are set to LIST_POISON1/LIST_POISON2, so
>> list_empty() returns false. To avoid a double-unlink, kthread_exit()
>> should use list_del_init() instead of list_del(), so that
>> free_kthread_struct()'s list_empty() check correctly detects the
>> already-unlinked state.
> 
> Confirmed that the above patch plus the list_del_init() change seems to
> fix the issue for me, the full patch I tested with is below to confirm.
> Feel free to add:
> 
> Tested-by: Mark Brown <broonie@kernel.org>


I second Mark's feedback.  I only used GCC 14.2 on x86_64 (see my
original email with a container image).  I confirm it is reproducible
on v7.0-rc1 and that the patch below fixes the issue.  So for what
it's worth, feel free to add:

Tested-by: Guillaume Tucker <gtucker@gtucker.io>

Cheers,
Guillaume


PS: It also happens to be a great first result for my new automated
bisection tool :)  I'll add some post-processing with debug configs
turned on to automate typical sanity checks e.g. KASAN and builds
with alternative compilers and architectures.


> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 20451b624b67..3778fcbc56db 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -147,6 +147,13 @@ void free_kthread_struct(struct task_struct *k)
>  	kthread = to_kthread(k);
>  	if (!kthread)
>  		return;
> +	if (!list_empty(&kthread->affinity_node)) {
> +		mutex_lock(&kthread_affinity_lock);
> +		list_del(&kthread->affinity_node);
> +		mutex_unlock(&kthread_affinity_lock);
> +	}
> +	if (kthread->preferred_affinity)
> +		kfree(kthread->preferred_affinity);
>  
>  #ifdef CONFIG_BLK_CGROUP
>  	WARN_ON_ONCE(kthread->blkcg_css);
> @@ -325,7 +332,7 @@ void __noreturn kthread_exit(long result)
>  	kthread->result = result;
>  	if (!list_empty(&kthread->affinity_node)) {
>  		mutex_lock(&kthread_affinity_lock);
> -		list_del(&kthread->affinity_node);
> +		list_del_init(&kthread->affinity_node);
>  		mutex_unlock(&kthread_affinity_lock);
>  
>  		if (kthread->preferred_affinity) {
> 


