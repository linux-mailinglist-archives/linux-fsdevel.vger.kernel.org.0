Return-Path: <linux-fsdevel+bounces-74462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B907ED3AFA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8889B3047914
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B238B7AF;
	Mon, 19 Jan 2026 15:51:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2A21FF2A;
	Mon, 19 Jan 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837890; cv=none; b=a0hRpHNkwjtQ5okcKKWG3HubwRXrTsi8utsQ8JOgPAdas1eEZtVJnt/QwmOFv5qNflxqPHIK9GisEFr1JCRrnmIeZShx0GAQA4PWi5dHBZbDSSL7Bs6lUSPwVkfq6J98iVdoqnDvh1WWySNzxOUacqQavPPxEJP7BiYgEVZhRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837890; c=relaxed/simple;
	bh=E6FaM+VC0Z+UCsnZ4NecshJrgz3zT/xfvy9B0lYu6TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8b5CCbl4CcJ6pEQ7FNbHYgEbXS4IIc35/4qU4QPCmHgMJJganXPxzcB+f9RZVd4LK6GL7zcaLZSL2AW02kzdK0K3XKNA9Ur9m4cO6UgG+naECURRty3W+2yLayWCDJVUQWhyhgZBE+KVfOosxjEhDVg2f0+yPqohxwT6rHnDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96EDFEC;
	Mon, 19 Jan 2026 07:51:21 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202AB3F694;
	Mon, 19 Jan 2026 07:51:26 -0800 (PST)
Date: Mon, 19 Jan 2026 15:51:23 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, d-gole@ti.com, elif.topuz@arm.com,
	lukasz.luba@arm.com, philip.radford@arm.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 04/17] uapi: Add ARM SCMI definitions
Message-ID: <aW5S--P1EoV3y9kU@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-5-cristian.marussi@arm.com>
 <20260119114343.00003f07@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119114343.00003f07@huawei.com>

On Mon, Jan 19, 2026 at 11:43:43AM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 11:46:08 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add a number of structures and ioctls definitions used by the ARM
> > SCMI Telemetry protocol.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> A few drive by comments.

Hi,

> 
> > diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
> > new file mode 100644
> > index 000000000000..e4e9939a1bf8
> > --- /dev/null
> > +++ b/include/uapi/linux/scmi.h
> > @@ -0,0 +1,287 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2026 ARM Ltd.
> > + */
> > +#ifndef _UAPI_LINUX_SCMI_H
> > +#define _UAPI_LINUX_SCMI_H
> > +
> > +/*
> > + * Userspace interface SCMI Telemetry
> > + */
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> 
> 
> > +/**
> > + * scmi_tlm_intervals  - Update intervals descriptor
> > + *
> > + * @discrete: Flag to indicate the nature of the intervals described in
> > + *	      @update_intervals.
> > + *	      When 'false' @update_intervals is a triplet: min/max/step
> > + * @pad: Padding fields to enforce alignment.
> > + * @num: Number of entries of @update_intervals
> > + * @update_intervals: A variably-sized array containing the update intervals
> > + *
> > + * Used by:
> > + *	RW - SCMI_TLM_GET_INTRVS
> > + *
> > + * Supported by:
> > + *	control/
> > + *	groups/<N>/control
> > + */
> > +struct scmi_tlm_intervals {
> > +	__u8 discrete;
> > +	__u8 pad[3];
> > +	__u32 num;
> 
> Trivial but this seems a little inconsistent. In other
> 'num' entries (e.g. num_des) below a more specific name
> is used.

Yes, agreed. I will fix.

> 
> > +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_LOW	0
> > +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_HIGH	1
> > +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_STEP	2
> > +	__u32 update_intervals[] __counted_by(num);
> > +};
> 
> > +
> > +/**
> > + * scmi_tlm_des_list  - List of all defined DEs
> > + *
> > + * @num_des: Number of entries in @des
> > + * @des: An array containing descriptors for all defined DEs
> > + *
> > + * Used by:
> > + *	RW - SCMI_TLM_GET_DE_LIST
> > + *
> > + * Supported by:
> > + *	control/
> > + */
> > +struct scmi_tlm_des_list {
> > +	__u32 num_des;
> > +	struct scmi_tlm_de_info des[] __counted_by(num_des);
> > +};
> > +
> > +/**
> > + * scmi_tlm_de_sample - A DE reading
> > + *
> > + * @id: DE identifier
> > + * @tstamp: DE reading timestamp (equal 0 is NOT supported)
> > + * @val: Reading of the DE data value
> > + *
> > + * Used by:
> > + *	RW - SCMI_TLM_GET_DE_VALUE
> > + *
> > + * Supported by:
> > + *	control/
> > + */
> > +struct scmi_tlm_de_sample {
> > +	__u32 id;
> 
> Packing issues maybe if this ever ends up on 32 bit machines.
> Even more so once it's in an array below.
>

Oh yes, I missed this...
 
> > +	__u64 tstamp;
> > +	__u64 val;
> > +};
> > +

Thanks,
Cristian

