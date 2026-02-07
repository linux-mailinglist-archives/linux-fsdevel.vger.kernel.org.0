Return-Path: <linux-fsdevel+bounces-76671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBqHG9Zfh2l+XQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 16:52:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C612F1066DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A7473018C1D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5C33557E;
	Sat,  7 Feb 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xM1CQ1rN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E42F3C37;
	Sat,  7 Feb 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479563; cv=none; b=ScTiSRzABYVpZTfhyOLwOOna7Cm3kaop++H/Iv6/pL/uxHJtMwMJF4RHq+oAZ8DF+TfrJmpMrZvx+TUflq1yzsQYt5mJoOgbZKFAIXOFj7iCa6dWX8xJa9K+CG5CNkdbw9uRY+rVs+R5sQ54z4p2AM6Ren7HfRCj9x5JAGG+nCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479563; c=relaxed/simple;
	bh=3caPt/SFdYRNTEo+dzqjdrsO13S53h4yikkUh2Rehmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRgP24Oj3dMCX++6DyE2+mA7HJTH/gzRL8Sh0pqsLuHXLVmGTE4/oKgXgqkwInXjKbF0KHDVxdyqWkMpruxBhhWRB6YDt4Fa1ygnuZDvM5a+UHi+7rSLWwZbD3zGs0Q4zU6plXYX0+2+dl6Fb3TxwJS6vRYCVuWHQ8GF4U53PdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xM1CQ1rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C912C116D0;
	Sat,  7 Feb 2026 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770479563;
	bh=3caPt/SFdYRNTEo+dzqjdrsO13S53h4yikkUh2Rehmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xM1CQ1rN5w+BCMNjOxhWt/xsRibe+1dr4kkrdTVWsqr3kymC2TxGJ9jXMjpd3nwVw
	 fcJ9ijERW5U0GBg6rjXZYP8lYikC6eAVig0J6HiUuavTx1SvqOi2tecEPAQJkOGaoE
	 rW0hm4ANXI3jYvp3ptUC5jtIjD/cUEeX5hb3Bl0E=
Date: Sat, 7 Feb 2026 16:52:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Slava.Dubeyko@ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] ml-lib: Introduce Machine Learning (ML)
 library declarations
Message-ID: <2026020756-remarry-declared-9187@gregkh>
References: <20260206191136.2609767-1-slava@dubeyko.com>
 <20260206191136.2609767-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206191136.2609767-2-slava@dubeyko.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76671-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C612F1066DB
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:11:33AM -0800, Viacheslav Dubeyko wrote:
> + * @kobj: /sys/<subsystem>/<ml_model>/ ML model object
> + * @kobj_unregister: completion state for <ml_model> kernel object
> + */
> +struct ml_lib_model {
> +	atomic_t mode;
> +	atomic_t state;
> +	const char *subsystem_name;
> +	const char *model_name;
> +
> +	struct ml_lib_subsystem *parent;
> +
> +	spinlock_t parent_state_lock;
> +	struct ml_lib_subsystem_state * __rcu parent_state;
> +
> +	spinlock_t options_lock;
> +	struct ml_lib_model_options * __rcu options;
> +
> +	spinlock_t dataset_lock;
> +	struct ml_lib_dataset * __rcu dataset;
> +
> +	struct ml_lib_model_operations *model_ops;
> +	struct ml_lib_subsystem_state_operations *system_state_ops;
> +	struct ml_lib_dataset_operations *dataset_ops;
> +	struct ml_lib_request_config_operations *request_config_ops;
> +
> +	/* /sys/<subsystem>/<ml_model>/ */
> +	struct kobject kobj;
> +	struct completion kobj_unregister;
> +};

Do NOT abuse sysfs for something like this.  Please make your own
filesystem or char device or something else, but this is not what sysfs
is for at all, sorry.

greg k-h

