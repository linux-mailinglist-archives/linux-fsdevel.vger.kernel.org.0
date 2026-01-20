Return-Path: <linux-fsdevel+bounces-74611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIqyKiplcGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:33:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685F518E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17F705C6A58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B6407562;
	Tue, 20 Jan 2026 10:55:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734B3F23CF;
	Tue, 20 Jan 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906524; cv=none; b=sn8X6qp+D5yzgGKtdz+TDuCp5SacKMNsjZWI5H+CR4i1R6gjgK6b6Auozl90H3tbxjIxLcRKuxjCH1ERczIsOV5hNzgEP3CkXkG+p5a8p7fMBMEiaQxGINyb55jrYPN7F5CP1Yo+HS+hIO93rnXGvFarKZmsS9p+ohs9BWD0fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906524; c=relaxed/simple;
	bh=6+pPwXHlFX1BGBFJH8uIIbTzaPO8Ld5/hGZ0KRmVdbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkYIadrBKXDQzAPXmz3XgPUwt4LC03tyhwVZx+64NiBu3eU5yPp81XNCo9sTtMeNbr9rIMUcPPSc02y4mDGfED92Mv+exB7qxG2uY3d1Zxu8zf3epTHQzFTwAb4d2mb83QVrCwsFRNdVtS1Q/LSMt78MedcTN8rdh8gDagCxzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAAE31476;
	Tue, 20 Jan 2026 02:55:14 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F293F740;
	Tue, 20 Jan 2026 02:55:19 -0800 (PST)
Date: Tue, 20 Jan 2026 10:55:12 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, elif.topuz@arm.com, lukasz.luba@arm.com,
	philip.radford@arm.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 01/17] firmware: arm_scmi: Define a common
 SCMI_MAX_PROTOCOLS value
Message-ID: <aW9fEESMiTAgp34Y@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-2-cristian.marussi@arm.com>
 <20260119111827.00001704@huawei.com>
 <20260120064419.by4nvmdgdybwe76q@lcpd911>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064419.by4nvmdgdybwe76q@lcpd911>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74611-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,arm.com,vger.kernel.org,lists.infradead.org,broadcom.com,gmail.com,linaro.org,st.com,oss.nxp.com,amd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cristian.marussi@arm.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: 5685F518E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:14:19PM +0530, Dhruva Gole wrote:
> On Jan 19, 2026 at 11:18:27 +0000, Jonathan Cameron wrote:
> > On Wed, 14 Jan 2026 11:46:05 +0000
> > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > 
> > > Add a common definition of SCMI_MAX_PROTOCOLS and use it all over the
> > > SCMI stack.
> > > 
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > Hi Cristian,
> > 
> > Mention the introduction of SCMI_PROTOCOL_LAST in the patch description
> > and probably say why it takes that value (which is much less than
> > the SCMI_MAX_PROTOCOLS value).
> 
> Rather I wonder why even add it? Is it just like a documentation/ marker
> or is some other usage even planned for it?

It was a cleanup related to some changes that I then dropped from this
public series...I kept it since it seemed fine, but I will definitely drop
it in V3 since it is no more related or needed by anything in this
series.

Thanks,
Cristian

