Return-Path: <linux-fsdevel+bounces-75268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNL2JgZfc2l3vAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:44:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4475480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 752D73004D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D43126A3;
	Fri, 23 Jan 2026 11:44:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192430E0D1;
	Fri, 23 Jan 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168642; cv=none; b=BvcKcpeZsbl8HQP/WRl4yxswSCWdIHq0dGe0Ya8NUgR9NFAhRumbtYcDlMY5jNI6dgizXIQg97nTKa1KJwZmVhFQjlETsx4R/cvD95JW+9TVwq9C5Z47gJOKUZcXQlrRpqVmo/UIM6dN/KDjcfncZkajvNXBWqB28ABdULstGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168642; c=relaxed/simple;
	bh=RRgI10KOGT/uUrrk2t0+sW81QffSTCCG7/X2ZpsJt3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9F6F2KwhbOq1CS+vPb4DIIQEyDwrrYefW87Za2hBNVUm0H7goOHgyM0p9JHRI1GXYgOoBEfzKHU8VIArZOwdKfZrAZ9LG8y/3IAVLXHiVG+iGqiAcMjL6zRATeJZ7RrnknHNZflQpkNYEbLKnDc2rs6zMcv+gL2iT2n5pHieqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C041C1476;
	Fri, 23 Jan 2026 03:43:52 -0800 (PST)
Received: from [10.57.52.8] (unknown [10.57.52.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2637C3F632;
	Fri, 23 Jan 2026 03:43:54 -0800 (PST)
Message-ID: <3c6bddfd-a674-486c-add4-35ef93ec88c4@arm.com>
Date: Fri, 23 Jan 2026 11:43:37 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] firmware: arm_scmi: Use new Telemetry traces
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, dan.carpenter@linaro.org, d-gole@ti.com,
 jonathan.cameron@huawei.com, lukasz.luba@arm.com, philip.radford@arm.com,
 souvik.chakravarty@arm.com, elif.topuz@arm.com
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-8-cristian.marussi@arm.com>
Content-Language: en-US
From: Elif Topuz <elif.topuz@arm.com>
In-Reply-To: <20260114114638.2290765-8-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,broadcom.com,gmail.com,linaro.org,st.com,oss.nxp.com,amd.com,ti.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-75268-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elif.topuz@arm.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EA4475480
X-Rspamd-Action: no action


Hi Cristian,

On 14/01/2026 11:46, Cristian Marussi wrote:
> Track failed SHMTI accesses and received notifications.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/telemetry.c | 57 ++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> index 16bcdcdc1dc3..443e032a3553 100644
> --- a/drivers/firmware/arm_scmi/telemetry.c
> +++ b/drivers/firmware/arm_scmi/telemetry.c
> @@ -25,6 +25,8 @@
>  #include "protocols.h"
>  #include "notify.h"
>  
> +#include <trace/events/scmi.h>
> +
>  /* Updated only after ALL the mandatory features for that version are merged */
>  #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
>  
> @@ -1366,8 +1368,10 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
>  
>  	/* Check for spec compliance */
>  	if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
> -	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0))
> +	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0)) {
> +		trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
>  		return;
> +	}
>  
>  	/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
>  	bts = scmi_telemetry_blkts_lookup(ti->ph->dev, &ti->xa_bts, payld);
> @@ -1376,6 +1380,9 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
>  
>  	/* Update the descriptor with the lastest TS*/
>  	scmi_telemetry_blkts_update(shmti->last_magic, bts);
> +
> +	trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
> +			       bts->last_magic, "SHMTI_BLK_TS");
>  }
>  
>  static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> @@ -1393,8 +1400,10 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
>  	/* Is thi DE ID know ? */
>  	tde = scmi_telemetry_tde_lookup(ti, de_id);
>  	if (!tde) {
> -		if (mode != SCAN_DISCOVERY)
> +		if (mode != SCAN_DISCOVERY) {
> +			trace_scmi_tlm_access(de_id, "DE_INVALID", 0, 0);
>  			return;
> +		}
>  
>  		/* In SCAN_DISCOVERY mode we allocate new DEs for unknown IDs */
>  		tde = scmi_telemetry_tde_get(ti, de_id);
> @@ -1462,6 +1471,8 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
>  		tde->last_ts = tstamp;
>  	else
>  		tde->last_ts = 0;
> +
> +	trace_scmi_tlm_collect(0, tde->de.info->id, tde->last_val, "SHMTI_DE_UPDT");

tde->last_ts instead of 0?

>  }
>  
>  static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
> @@ -1507,8 +1518,10 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
>  		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
>  
>  		startm = TDCF_START_SEQ_GET(tdcf);
> -		if (IS_BAD_START_SEQ(startm))
> +		if (IS_BAD_START_SEQ(startm)) {
> +			trace_scmi_tlm_access(0, "MSEQ_BADSTART", startm, 0);
>  			continue;
> +		}
>  
>  		/* On a BAD_SEQ this will be updated on the next attempt */
>  		shmti->last_magic = startm;
> @@ -1520,18 +1533,25 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
>  
>  			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
>  								     shmti, mode);
> -			if (qwords < used_qwords)
> +			if (qwords < used_qwords) {
> +				trace_scmi_tlm_access(PAYLD_ID(next),
> +						      "BAD_QWORDS", startm, 0);
>  				return -EINVAL;
> +			}
>  
>  			next += used_qwords * 8;
>  			qwords -= used_qwords;
>  		}
>  
>  		endm = TDCF_END_SEQ_GET(eplg);
> +		if (startm != endm)
> +			trace_scmi_tlm_access(0, "MSEQ_MISMATCH", startm, endm);
>  	} while (startm != endm && --retries);
>  
> -	if (startm != endm)
> +	if (startm != endm) {
> +		trace_scmi_tlm_access(0, "TDCF_SCAN_FAIL", startm, endm);
>  		return -EPROTO;
> +	}
>  
>  	return 0;
>  }
> @@ -1923,6 +1943,8 @@ static void scmi_telemetry_scan_update(struct telemetry_info *ti, u64 ts)
>  			tde->last_ts = tstamp;
>  		else
>  			tde->last_ts = 0;
> +
> +		trace_scmi_tlm_collect(ts, tde->de.info->id, tde->last_val, "FC_UPDATE");

tde->last_ts instead of ts?

>  	}
>  }
>  
> @@ -2001,8 +2023,11 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
>  		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
>  
>  		startm = TDCF_START_SEQ_GET(tdcf);
> -		if (IS_BAD_START_SEQ(startm))
> +		if (IS_BAD_START_SEQ(startm)) {
> +			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_BADSTART",
> +					      startm, 0);
>  			continue;
> +		}
>  
>  		/* Has anything changed at all at the SHMTI level ? */
>  		scoped_guard(mutex, &tde->mtx) {
> @@ -2018,11 +2043,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
>  		if (DATA_INVALID(payld))
>  			return -EINVAL;
>  
> -		if (IS_BLK_TS(payld))
> +		if (IS_BLK_TS(payld)) {
> +			trace_scmi_tlm_access(tde->de.info->id,
> +					      "BAD_DE_META", 0, 0);
>  			return -EINVAL;
> +		}
>  
> -		if (PAYLD_ID(payld) != tde->de.info->id)
> +		if (PAYLD_ID(payld) != tde->de.info->id) {
> +			trace_scmi_tlm_access(tde->de.info->id, "DE_INVALID", 0, 0);
>  			return -EINVAL;
> +		}
>  
>  		/* Data is always valid since NOT handling BLK TS lines here */
>  		*val = LINE_DATA_GET(&payld->l);
> @@ -2046,10 +2076,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
>  		}
>  
>  		endm = TDCF_END_SEQ_GET(tde->eplg);
> +		if (startm != endm)
> +			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_MISMATCH",
> +					      startm, endm);
>  	} while (startm != endm && --retries);
>  
> -	if (startm != endm)
> +	if (startm != endm) {
> +		trace_scmi_tlm_access(tde->de.info->id, "TDCF_DE_FAIL",
> +				      startm, endm);
>  		return -EPROTO;
> +	}
>  
>  	guard(mutex)(&tde->mtx);
>  	tde->last_magic = startm;
> @@ -2230,6 +2266,9 @@ scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
>  			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
>  		else
>  			tde->last_ts = 0;
> +
> +		trace_scmi_tlm_collect(timestamp, tde->de.info->id, tde->last_val,
> +				       "MESSAGE");

tde->last_ts instead of timestamp? If I understand correctly, tde->last_ts
corresponds to the time coming from the platform. We have kernel time anyway
coming from ftrace format.

>  	}
>  }
>  

Thanks,
Elif

