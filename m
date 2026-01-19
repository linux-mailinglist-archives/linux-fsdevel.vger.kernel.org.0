Return-Path: <linux-fsdevel+bounces-74457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2ED3AF5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E9E2300252B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780E538BDA3;
	Mon, 19 Jan 2026 15:43:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826738B9A3;
	Mon, 19 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837419; cv=none; b=SlMi0z3wM5/AHI7DSqqJSDE7RWuKBTFRFkg5jYqqtVg1tffcz8HzqZ/RvyoS6V8fl5q7Tgt6XClHSi3/1XvL5/Kun+JXZlIbw2C0zCAa1piXDB7eJ7Bdd08ESIbIMKkEqOi/aoxdFGc7HeBjnjwPrS2yRRewmXswvntlPEsUK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837419; c=relaxed/simple;
	bh=MPjOyINpfQZXqbO9V0iDd+Uo33hIU1fUW/ZEltS13QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU5Ro5VX7OMlxd13OkiHQ7bJX1qil/Kg4ukqRhMsO8z+NVMMhia8LgsemsCNOnX4tB9+T3/o1graxOLiCESGfkXOlq/Jl5l+kwiHL1GRuIaneSetzJDbQHCe1NWekJQ/VU2fVeGDM56SqiS32VfL9ZBk9FDibZokqF77jYrOlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AA8497;
	Mon, 19 Jan 2026 07:43:30 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF4A3F694;
	Mon, 19 Jan 2026 07:43:34 -0800 (PST)
Date: Mon, 19 Jan 2026 15:43:32 +0000
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
Subject: Re: [PATCH v2 01/17] firmware: arm_scmi: Define a common
 SCMI_MAX_PROTOCOLS value
Message-ID: <aW5RJGz0ashv4txN@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-2-cristian.marussi@arm.com>
 <20260119111827.00001704@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119111827.00001704@huawei.com>

On Mon, Jan 19, 2026 at 11:18:27AM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 11:46:05 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add a common definition of SCMI_MAX_PROTOCOLS and use it all over the
> > SCMI stack.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Hi Cristian,
> 
> Mention the introduction of SCMI_PROTOCOL_LAST in the patch description
> and probably say why it takes that value (which is much less than
> the SCMI_MAX_PROTOCOLS value).

I'll do.

Thanks,
Cristian

