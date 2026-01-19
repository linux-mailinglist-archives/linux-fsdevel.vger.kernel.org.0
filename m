Return-Path: <linux-fsdevel+bounces-74433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFBD3A6A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFE0F30C7B01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E322EAB61;
	Mon, 19 Jan 2026 11:18:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A502D979C;
	Mon, 19 Jan 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821512; cv=none; b=A2/XcPeyUeKJm9wXkv7l6eQEtgYeJJOpcE4j00ZgHO4K63pSIejLEyZDLoTNXbB7C17Zr9/iKMGFXYX1Q/9zOJneKAmDECHs+SLXWJKUIZLxBNXRW8LIJdOejZrW1aoXLMk4eQheiSvFY/yv3Asl21Z0WYUnablGWP4PlAo17G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821512; c=relaxed/simple;
	bh=eIo99rlD9Wx9sQQi8w/hFXG9Chudp3vEC6CGHELuuXY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSqcHolCOeSH9ED7q039onha4VcmySdxdIk+qvTAAB2Jqr48Kim59AnREvBdr8+P/QbQRGljf+sTjct/nc5j/3aCowqvAfVNKNAueJSLkzVike6DYtDC+xmivaF3ULdTGQ7bWfWo34enfDp3iqAhZU7LDiMzHinXvkHHRQY1jCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvnxh1ms2zHnHFg;
	Mon, 19 Jan 2026 19:18:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E139E40570;
	Mon, 19 Jan 2026 19:18:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 11:18:28 +0000
Date: Mon, 19 Jan 2026 11:18:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<sudeep.holla@arm.com>, <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <dan.carpenter@linaro.org>,
	<d-gole@ti.com>, <elif.topuz@arm.com>, <lukasz.luba@arm.com>,
	<philip.radford@arm.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 01/17] firmware: arm_scmi: Define a common
 SCMI_MAX_PROTOCOLS value
Message-ID: <20260119111827.00001704@huawei.com>
In-Reply-To: <20260114114638.2290765-2-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
	<20260114114638.2290765-2-cristian.marussi@arm.com>
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

On Wed, 14 Jan 2026 11:46:05 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add a common definition of SCMI_MAX_PROTOCOLS and use it all over the
> SCMI stack.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Hi Cristian,

Mention the introduction of SCMI_PROTOCOL_LAST in the patch description
and probably say why it takes that value (which is much less than
the SCMI_MAX_PROTOCOLS value).

Jonathan

> ---
>  drivers/firmware/arm_scmi/notify.c | 4 +---
>  include/linux/scmi_protocol.h      | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index dee9f238f6fd..78e9e27dc9ec 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -94,8 +94,6 @@
>  #include "common.h"
>  #include "notify.h"
>  
> -#define SCMI_MAX_PROTO		256
> -
>  #define PROTO_ID_MASK		GENMASK(31, 24)
>  #define EVT_ID_MASK		GENMASK(23, 16)
>  #define SRC_ID_MASK		GENMASK(15, 0)
> @@ -1673,7 +1671,7 @@ int scmi_notification_init(struct scmi_handle *handle)
>  	ni->gid = gid;
>  	ni->handle = handle;
>  
> -	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
> +	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTOCOLS,
>  						sizeof(char *), GFP_KERNEL);
>  	if (!ni->registered_protocols)
>  		goto err;
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index aafaac1496b0..c6efe4f371ac 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -926,8 +926,11 @@ enum scmi_std_protocol {
>  	SCMI_PROTOCOL_VOLTAGE = 0x17,
>  	SCMI_PROTOCOL_POWERCAP = 0x18,
>  	SCMI_PROTOCOL_PINCTRL = 0x19,
> +	SCMI_PROTOCOL_LAST = 0x7f,
>  };
>  
> +#define SCMI_MAX_PROTOCOLS	256
> +
>  enum scmi_system_events {
>  	SCMI_SYSTEM_SHUTDOWN,
>  	SCMI_SYSTEM_COLDRESET,


