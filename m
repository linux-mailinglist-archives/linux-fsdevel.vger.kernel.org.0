Return-Path: <linux-fsdevel+bounces-74436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE5D3A75C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3069B30C070C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB42314B90;
	Mon, 19 Jan 2026 11:43:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036711D5147;
	Mon, 19 Jan 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823031; cv=none; b=FgbooRxpqYSsYSMf+DINXkiK6kBWOZiwiHQ0NuBojyUZAiPqs6xhBe5YUQjyuV0Dqdq2TuAoecpHZzOGmIjlneFxxGbCAyKGNHRAyR3XtUjAZnfvTj39H6UD2ZwG9LTsqcJZyUxeq6W2Ejt23JpO8R/2QhwRkBbFI8vz6Gk5egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823031; c=relaxed/simple;
	bh=5sgE+g7Rv8h6aCm4guVJSiih+b9y4imi8KIOT18FKeo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjNX9yqy2SNUHzq7FlvJu+FkAVmHFEYeMdSGsGHhOT/czVbsYBou1oSYlVnyBu+xUijv0d/l3HN+legATtMXtjA05AY8DzaHyJp2SnE6VI4QmVnQMP6xKKSRnqx8iSnC4CMMh7ZThDldez2nBRSZGTH+aDQ40if02DEAG2pM6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvpVz2PSvzJ46mQ;
	Mon, 19 Jan 2026 19:43:23 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1719340569;
	Mon, 19 Jan 2026 19:43:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 11:43:45 +0000
Date: Mon, 19 Jan 2026 11:43:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<sudeep.holla@arm.com>, <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <dan.carpenter@linaro.org>,
	<d-gole@ti.com>, <elif.topuz@arm.com>, <lukasz.luba@arm.com>,
	<philip.radford@arm.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 04/17] uapi: Add ARM SCMI definitions
Message-ID: <20260119114343.00003f07@huawei.com>
In-Reply-To: <20260114114638.2290765-5-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
	<20260114114638.2290765-5-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 14 Jan 2026 11:46:08 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add a number of structures and ioctls definitions used by the ARM
> SCMI Telemetry protocol.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

A few drive by comments.

> diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
> new file mode 100644
> index 000000000000..e4e9939a1bf8
> --- /dev/null
> +++ b/include/uapi/linux/scmi.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2026 ARM Ltd.
> + */
> +#ifndef _UAPI_LINUX_SCMI_H
> +#define _UAPI_LINUX_SCMI_H
> +
> +/*
> + * Userspace interface SCMI Telemetry
> + */
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>


> +/**
> + * scmi_tlm_intervals  - Update intervals descriptor
> + *
> + * @discrete: Flag to indicate the nature of the intervals described in
> + *	      @update_intervals.
> + *	      When 'false' @update_intervals is a triplet: min/max/step
> + * @pad: Padding fields to enforce alignment.
> + * @num: Number of entries of @update_intervals
> + * @update_intervals: A variably-sized array containing the update intervals
> + *
> + * Used by:
> + *	RW - SCMI_TLM_GET_INTRVS
> + *
> + * Supported by:
> + *	control/
> + *	groups/<N>/control
> + */
> +struct scmi_tlm_intervals {
> +	__u8 discrete;
> +	__u8 pad[3];
> +	__u32 num;

Trivial but this seems a little inconsistent. In other
'num' entries (e.g. num_des) below a more specific name
is used.

> +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_LOW	0
> +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_HIGH	1
> +#define SCMI_TLM_UPDATE_INTVL_SEGMENT_STEP	2
> +	__u32 update_intervals[] __counted_by(num);
> +};

> +
> +/**
> + * scmi_tlm_des_list  - List of all defined DEs
> + *
> + * @num_des: Number of entries in @des
> + * @des: An array containing descriptors for all defined DEs
> + *
> + * Used by:
> + *	RW - SCMI_TLM_GET_DE_LIST
> + *
> + * Supported by:
> + *	control/
> + */
> +struct scmi_tlm_des_list {
> +	__u32 num_des;
> +	struct scmi_tlm_de_info des[] __counted_by(num_des);
> +};
> +
> +/**
> + * scmi_tlm_de_sample - A DE reading
> + *
> + * @id: DE identifier
> + * @tstamp: DE reading timestamp (equal 0 is NOT supported)
> + * @val: Reading of the DE data value
> + *
> + * Used by:
> + *	RW - SCMI_TLM_GET_DE_VALUE
> + *
> + * Supported by:
> + *	control/
> + */
> +struct scmi_tlm_de_sample {
> +	__u32 id;

Packing issues maybe if this ever ends up on 32 bit machines.
Even more so once it's in an array below.

> +	__u64 tstamp;
> +	__u64 val;
> +};
> +
> +/**
> + * scmi_tlm_data_read - Bulk read of multiple DEs
> + *
> + * @num_samples: Number of entries returned in @samples
> + * @samples: An array of samples containing an entry for each DE that was
> + *	     enabled when the single sample read request was issued.
> + *
> + * Used by:
> + *	RW - SCMI_TLM_SINGLE_SAMPLE
> + *	RW - SCMI_TLM_BULK_READ
> + *
> + * Supported by:
> + *	control/
> + *	groups/<N>/control
> + */
> +struct scmi_tlm_data_read {
> +	__u32 num_samples;
> +	struct scmi_tlm_de_sample samples[] __counted_by(num_samples);
> +};

