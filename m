Return-Path: <linux-fsdevel+bounces-33563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE00B9BA080
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D40B2172F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006818A956;
	Sat,  2 Nov 2024 13:23:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199D1E515;
	Sat,  2 Nov 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553835; cv=none; b=DuJqP4iIejIbbPzP8W4oci7veLzwFijLSsPF8v1dp7zdtgpkID2eSdqr+7UpB9ddZV1ouxb+fxwVf9t3MlSydZHzP7/D3Xuc1bxsLB5wCaxgmGELNDK9JIUCFHkJ+CyV7y6AaYpVLtfVmGpz3tEKRDuK+ZAkYWjm+M6gXwhihn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553835; c=relaxed/simple;
	bh=cnZgompK9DLpu0oUx4hd67geHcCcGIiOVdT4sPIWGek=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=SMOP6YWnaRm+ewKHa/C2aXL9IyGmo3w1dZMfFdPa1bY35DqeDCR/+QxtQL5gDHkSW2yYpdO8ptHWfUJN7QHGq+m/4Y4uHx9W6ejBwfG0zfemxNkYDOu5X02+K+rS1I51fdVtHWO02eBHSyup9HHJ4BkI6rkVBRIIS+D352ltl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:51330)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t7E6Z-00FGat-NV; Sat, 02 Nov 2024 07:23:51 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:43360 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t7E6Y-00EG20-Q8; Sat, 02 Nov 2024 07:23:51 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  linux-kernel@vger.kernel.org,
  kernel-janitors@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org
References: <34b8c52b67934b293a67558a9a486aea7ba08951.1730539498.git.christophe.jaillet@wanadoo.fr>
Date: Sat, 02 Nov 2024 08:23:31 -0500
In-Reply-To: <34b8c52b67934b293a67558a9a486aea7ba08951.1730539498.git.christophe.jaillet@wanadoo.fr>
	(Christophe JAILLET's message of "Sat, 2 Nov 2024 10:25:04 +0100")
Message-ID: <87jzdl3h2k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t7E6Y-00EG20-Q8;;;mid=<87jzdl3h2k.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+784bjb7XOAmC0ASw8osPUmENC1hfnnhw=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4998]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Spam-Relay-Country: 
X-Spam-Timing: total 303 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (3.8%), b_tie_ro: 10 (3.3%), parse: 0.99
	(0.3%), extract_message_metadata: 13 (4.2%), get_uri_detail_list: 1.02
	(0.3%), tests_pri_-2000: 13 (4.2%), tests_pri_-1000: 2.5 (0.8%),
	tests_pri_-950: 1.17 (0.4%), tests_pri_-900: 0.97 (0.3%),
	tests_pri_-90: 93 (30.6%), check_bayes: 91 (30.0%), b_tokenize: 5
	(1.7%), b_tok_get_all: 33 (11.0%), b_comp_prob: 2.2 (0.7%),
	b_tok_touch_all: 47 (15.6%), b_finish: 0.92 (0.3%), tests_pri_0: 153
	(50.6%), check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 3.1
	(1.0%), poll_dns_idle: 1.29 (0.4%), tests_pri_10: 2.9 (1.0%),
	tests_pri_500: 9 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs: binfmt: Fix a typo
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, christophe.jaillet@wanadoo.fr
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> A 't' is missing in "binfm_misc".
> Add it.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/binfmt_misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 31660d8cc2c6..df6a229b5e62 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -998,7 +998,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  		/*
>  		 * If it turns out that most user namespaces actually want to
>  		 * register their own binary type handler and therefore all
> -		 * create their own separate binfm_misc mounts we should
> +		 * create their own separate binfmt_misc mounts we should
>  		 * consider turning this into a kmem cache.
>  		 */
>  		misc = kzalloc(sizeof(struct binfmt_misc), GFP_KERNEL);

