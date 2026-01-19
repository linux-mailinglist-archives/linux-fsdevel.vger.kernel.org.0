Return-Path: <linux-fsdevel+bounces-74518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55CD3B5C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 611C73008C7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709E32BF55;
	Mon, 19 Jan 2026 18:26:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDA274B5C;
	Mon, 19 Jan 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847164; cv=none; b=Mt54s3c0/+ebLagpwn7X13BtNOChPzhOaoQV7nSIn+2YAAf0ZGiU/Wwv1Uurj5lfdT5B91isDs57YZqeE5E3qcbCGPSprVihL129EVbgLlJet+85V6wCiVQ7VKT9cXdZww73GUtKsQj0lITXwsGLtpN5h2NvVvCEyG2lj0vTN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847164; c=relaxed/simple;
	bh=LYuCM7//SMRFX+/88l1dlOq7IXJoQBrwiO/q8CCzAUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0YBwgKsZiXI1e9F+k1aCOF+IFKczIAh0/iC3ShVWsxt1PdCE3I+LyfZBiNgkZYDlcZa5F5QN+Xl38nnfXewVwTxWGRLZLv9oFiM6WI814a4GS8kM+mHqhBmUDr/MLnmsWDWr70haGLyMfUOVR1XEp1iohnfocHfDNnHpgdSc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53288497;
	Mon, 19 Jan 2026 10:25:54 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289433F694;
	Mon, 19 Jan 2026 10:25:58 -0800 (PST)
Date: Mon, 19 Jan 2026 18:25:55 +0000
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
Subject: Re: [PATCH v2 05/17] firmware: arm_scmi: Add Telemetry protocol
 support
Message-ID: <aW53M5EsXDGvYzfp@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-6-cristian.marussi@arm.com>
 <20260119162932.00006e6c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119162932.00006e6c@huawei.com>

On Mon, Jan 19, 2026 at 04:29:32PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 11:46:09 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add basic support for SCMI V4.0 Telemetry protocol including SHMTI,
> > FastChannels, Notifications and Single Sample Reads collection methods.
> > 

Hi Jonathan,

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> >  - Add proper ioread accessors for TDCF areas
> >  - Rework resource allocation logic and lifecycle
> >  - Introduce new resources accessors and res_get() operation to
> >    implement lazy enumeration
> >  - Support boot-on telemetry:
> >    + Add DE_ENABLED_LIST cmd support
> >    + Add CONFIG_GET cmd support
> >    + Add TDCF_SCAN for best effort enumeration
> >    + Harden driver against out-of-spec FW with out of spec cmds
> >  - Use FCs list
> >  - Rework de_info_lookup to a moer general de_lookup
> >  - Fixed reset to use CONFIG_GET and DE_ENABLED_LIST to gather initial
> >    state
> >  - Using sign_extend32 helper
> >  - Added counted_by marker where appropriate
> > ---
> >  drivers/firmware/arm_scmi/Makefile    |    2 +-
> >  drivers/firmware/arm_scmi/driver.c    |    2 +
> >  drivers/firmware/arm_scmi/protocols.h |    1 +
> >  drivers/firmware/arm_scmi/telemetry.c | 2671 +++++++++++++++++++++++++
> 
> Ouch. Might be worth splitting this up into more bite sized pieces.
> 
> It's a bit of a take a deep breath before diving in patch at the moment.
> So the following is rather superficial.

Yes, indeed this has to be split..usually I post the protocol unit in
one patch...but telemetry is rather big...I will split this on V3 once I
had some mofre feedback especially on the FS part and its supposed
location in the siource tree (now lives all in drivers and I suppose/guess
is frowned upon...also FS is a bit more split..but it can be further
split)

> 
> >  include/linux/scmi_protocol.h         |  188 +-
> >  5 files changed, 2862 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/arm_scmi/telemetry.c
> > 
> 
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> > new file mode 100644
> > index 000000000000..16bcdcdc1dc3
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/telemetry.c
> > @@ -0,0 +1,2671 @@
> 
> > +static void scmi_telemetry_free_tde_put(struct telemetry_info *ti,
> > +					struct telemetry_de *tde)
> > +{
> > +	guard(mutex)(&ti->free_mtx);
> > +
> > +	list_add_tail(&tde->item, &ti->free_des);
> > +}
> 
> > +static int iter_de_descr_update_state(struct scmi_iterator_state *st,
> > +				      const void *response, void *priv)
> > +{
> > +	const struct scmi_msg_resp_telemetry_de_description *r = response;
> > +	struct scmi_tlm_de_priv *p = priv;
> > +
> > +	st->num_returned = le32_get_bits(r->num_desc, GENMASK(15, 0));
> > +	st->num_remaining = le32_get_bits(r->num_desc, GENMASK(31, 16));
> > +
> > +	/* Initialized to first descriptor */
> > +	p->next = (void *)r->desc;
> 
> No need to cast to a void *
> C always lets you do this implicitly if the target type is a void *.

Indeed...I think I recall that (as usual) is because I have to drop the
const part from r without upsetting the compiler...and next is just a
reference to iterate the payload so it is fine to be non const

> 
> > +
> > +	return 0;
> > +}
> > +
> 
> 
> > +static int scmi_telemetry_initial_state_lookup(struct telemetry_info *ti)
> > +{
> > +	struct device *dev = ti->ph->dev;
> > +	int ret;
> > +
> > +	ret = scmi_telemetry_config_lookup(ti, SCMI_TLM_GRP_INVALID,
> > +					   &ti->info.enabled,
> > +					   &ti->info.active_update_interval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (ti->info.enabled) {
> 
> I'd flip logic to reduce indent
> 	if (!ti->info.enabled)
> 		return 0;

Yep, I will do.

> 
> 	/*
> 	 *...
> 
> > +		/*
> > +		 * When Telemetry is found already enabled on the platform,
> > +		 * proceed with passive discovery using DE_ENABLED_LIST and
> > +		 * TCDF scanning: note that this CAN only discover DEs exposed
> > +		 * via SHMTIs.
> > +		 * FastChannel DEs need a proper DE_DESCRIPTION enumeration,
> > +		 * while, even though incoming Notifications could be used for
> > +		 * passive discovery too, it would carry a considerable risk
> > +		 * of assimilating trash as DEs.
> > +		 */
> > +		dev_info(dev,
> > +			 "Telemetry found enabled with update interval %ux10^%d\n",
> > +			 SCMI_TLM_GET_UPDATE_INTERVAL_SECS(ti->info.active_update_interval),
> > +			 SCMI_TLM_GET_UPDATE_INTERVAL_EXP(ti->info.active_update_interval));
> > +		/*
> > +		 * Query enabled DEs list: collect states.
> > +		 * It will include DEs from any interface.
> > +		 * Enabled groups still NOT enumerated.
> > +		 */
> > +		ret = scmi_telemetry_enumerate_des_enabled_list(ti);
> > +		if (ret)
> > +			dev_warn(dev, FW_BUG "Cannot query enabled DE list. Carry-on.\n");
> > +
> > +		/* Discover DEs on SHMTis: collect states/offsets/values */
> > +		for (int id = 0; id < ti->num_shmti; id++) {
> > +			ret = scmi_telemetry_shmti_scan(ti, id, 0, SCAN_DISCOVERY);
> > +			if (ret)
> > +				dev_warn(dev, "Failed discovery-scan of SHMTI ID:%d\n", id);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> }
> 
> > +static int iter_intervals_update_state(struct scmi_iterator_state *st,
> > +				       const void *response, void *priv)
> > +{
> > +	const struct scmi_msg_resp_telemetry_update_intervals *r = response;
> > +
> > +	st->num_returned = le32_get_bits(r->flags, GENMASK(11, 0));
> > +	st->num_remaining = le32_get_bits(r->flags, GENMASK(31, 16));
> > +
> > +	/*
> > +	 * total intervals is not declared previously anywhere so we
> > +	 * assume it's returned+remaining on first call.
> > +	 */
> > +	if (!st->max_resources) {
> > +		struct scmi_tlm_ivl_priv *p = priv;
> > +		bool discrete;
> > +		int inum;
> > +
> > +		discrete = INTERVALS_DISCRETE(r->flags);
> > +		/* Check consistency on first call */
> > +		if (!discrete && (st->num_returned != 3 || st->num_remaining != 0))
> > +			return -EINVAL;
> > +
> > +		inum = st->num_returned + st->num_remaining;
> > +		struct scmi_tlm_intervals *intrvs __free(kfree) =
> > +			kzalloc(sizeof(*intrvs) + inum * sizeof(__u32), GFP_KERNEL);
> 
> Unless this is going to get more complex, the __free() isn't doing anything useful
> as there are no other error paths before the no_free_ptr().

Yes indeed...I was trying to be consistent...but here makes no sense.

> 
> > +		if (!intrvs)
> > +			return -ENOMEM;
> > +
> > +		intrvs->num = inum;
> > +		intrvs->discrete = discrete;
> > +		st->max_resources = intrvs->num;
> > +
> > +		*p->intrvs = no_free_ptr(intrvs);
> > +	}
> > +
> > +	return 0;
> 
> > +static int
> > +scmi_tlm_enumerate_update_intervals(struct telemetry_info *ti,
> > +				    struct scmi_tlm_intervals **intervals,
> > +				    int grp_id, unsigned int flags)
> > +{
> > +	struct scmi_iterator_ops ops = {
> > +		.prepare_message = iter_intervals_prepare_message,
> > +		.update_state = iter_intervals_update_state,
> > +		.process_response = iter_intervals_process_response,
> > +	};
> > +	const struct scmi_protocol_handle *ph = ti->ph;
> > +	struct scmi_tlm_ivl_priv ipriv = {
> > +		.dev = ph->dev,
> > +		.grp_id = grp_id,
> > +		.intrvs = intervals,
> > +		.flags = flags,
> > +	};
> > +	void *iter;
> > +
> > +	iter = ph->hops->iter_response_init(ph, &ops, 0,
> > +					    TELEMETRY_LIST_UPDATE_INTERVALS,
> > +			     sizeof(struct scmi_msg_telemetry_update_intervals),
> This alignment is unusual.  Given the length of that type name I'd do this as:
> 
> 	iter = ph->hops->iter_response_init(ph, &ops, 0,
> 		TELEMETRY_LIST_UPDATE_INTERVALS,
> 		sizeof(struct scmi_msg_telemetry_update_intervals),
> 		&ipriv);
> 

Ok.

> > +					    &ipriv);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> 
> > +static const struct scmi_telemetry_de *
> > +scmi_telemetry_de_lookup(const struct scmi_protocol_handle *ph, u32 id)
> > +{
> > +	struct telemetry_info *ti = ph->get_priv(ph);
> > +	struct scmi_telemetry_de *de;
> > +
> > +	ti->res_get(ti);
> > +	de = xa_load(&ti->xa_des, id);
> > +	if (!de)
> > +		return NULL;
> > +
> > +	return de;
> 
> 	return xa_load(&ti->xa_des, id);

Agreed.

> 
> > +}
> 
> 
> > +static struct payload *
> > +scmi_telemetry_nearest_blk_ts(struct telemetry_shmti *shmti,
> > +			      struct payload *last_payld)
> > +{
> > +	struct payload *payld, *bts_payld = NULL;
> > +	struct tdcf __iomem *tdcf = shmti->base;
> > +	u32 *next;
> > +
> > +	/* Scan from start of TDCF payloads up to last_payld */
> > +	payld = (struct payload *)tdcf->payld;
> 
> casting away the __iomem is usualy a bad idea.
> Shouldn't a readl or similar be used to get next below.

Yes I still have to properly rework a bit of these __iomem access paths
in a more consistent way (sparse/smatch still screams a lot)...

..all the below accessors macros are defined to use transparently an
ioread32() or similar...next is just a reference to track the payld
is only payload that is effectly accessed and needs proper iomem
accessors...

> 
> 
> > +	next = (u32 *)payld;
> > +	while (payld < last_payld) {
> > +		if (IS_BLK_TS(payld))
> > +			bts_payld = payld;
> > +
> > +		next += USE_LINE_TS(payld) ?
> > +			TS_LINE_DATA_PAYLD_WORDS : LINE_DATA_PAYLD_WORDS;
> > +		payld = (struct payload *)next;
> > +	}
> > +
> > +	return bts_payld;
> > +}
> > +
> > +static struct telemetry_block_ts *
> > +scmi_telemetry_blkts_lookup(struct device *dev, struct xarray *xa_bts,
> > +			    struct payload *payld)
> > +{
> > +	struct telemetry_block_ts *bts;
> > +
> > +	bts = xa_load(xa_bts, (unsigned long)payld);
> > +	if (!bts) {
> > +		int ret;
> > +
> > +		bts = devm_kzalloc(dev, sizeof(*bts), GFP_KERNEL);
> 
> I'd not normally expect to see xa_insert using devm allocated memory
> because you sort of hand ownership to the xa with that call so I'd expect
> on exist we'd see a walk of the xa clearing out everything it is tracking.

Good point...I have to say, though, to my excuse, that this part of the protocol
code related to Block Timestamp (_blt_ts_) is knowingly very poorly curated and
reworked since V1 given that it has been deeply changed at the spec level in the
latest BETA spec (a few weks ago) so it will be changed substantially in the
next V3 when BETA will be supported...

...anyway...my bad I should have warned about this in the inline comments...now it
is only generically mentioned in the cover letter that the series is still implementing
ALPA_0 spec.

> 
> > +		if (!bts)
> > +			return NULL;
> > +
> > +		refcount_set(&bts->users, 1);
> > +		bts->payld = payld;
> > +		bts->xa_bts = xa_bts;
> > +		mutex_init(&bts->mtx);
> > +		ret = xa_insert(xa_bts, (unsigned long)payld, bts, GFP_KERNEL);
> > +		if (ret) {
> > +			devm_kfree(dev, bts);
> > +			return NULL;
> > +		}
> > +	}
> > +
> > +	return bts;
> > +}
> 
> > +
> > +static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> > +					   struct payload __iomem *payld,
> > +					   struct telemetry_shmti *shmti,
> > +					   enum scan_mode mode)
> > +{
> > +	bool ts_valid = TS_VALID(payld);
> > +	struct telemetry_de *tde;
> > +	bool discovered = false;
> > +	u64 val, tstamp = 0;
> > +	u32 de_id;
> > +
> > +	de_id = PAYLD_ID(payld);
> > +	/* Is thi DE ID know ? */
> 
> That comment needs a rewrite.
> 

Yes.

> > +	tde = scmi_telemetry_tde_lookup(ti, de_id);
> > +	if (!tde) {
> > +		if (mode != SCAN_DISCOVERY)
> > +			return;
> > +
> > +		/* In SCAN_DISCOVERY mode we allocate new DEs for unknown IDs */
> > +		tde = scmi_telemetry_tde_get(ti, de_id);
> > +		if (IS_ERR(tde))
> > +			return;
> > +
> > +		tde->de.info->id = de_id;
> > +		tde->de.enabled = true;
> > +		tde->de.tstamp_enabled = ts_valid;
> > +		discovered = true;
> > +	}
> > +
> > +	/* Update DE location refs if requested: normally done only on enable */
> > +	if (mode >= SCAN_UPDATE) {
> > +		tde->base = shmti->base;
> > +		tde->eplg = SHMTI_EPLG(shmti);
> > +		tde->offset = (void *)payld - (void *)shmti->base;
> > +
> > +		dev_dbg(ti->ph->dev,
> > +			"TDCF-updated DE_ID:0x%08X - shmti:%pX  offset:%u\n",
> > +			tde->de.info->id, tde->base, tde->offset);
> > +	}
> > +
> > +	if (discovered) {
> > +		if (scmi_telemetry_tde_register(ti, tde)) {
> > +			scmi_telemetry_free_tde_put(ti, tde);
> > +			return;
> > +		}
> > +	}
> > +
> > +	scoped_guard(mutex, &tde->mtx) {
> > +		if (tde->last_magic == shmti->last_magic)
> > +			return;
> > +	}
> > +
> > +	/* Data is always valid since we are NOT handling BLK TS lines here */
> > +	val = LINE_DATA_GET(&payld->l);
> > +	/* Collect the right TS */
> > +	if (ts_valid) {
> > +		if (USE_LINE_TS(payld)) {
> > +			tstamp = LINE_TSTAMP_GET(&payld->tsl);
> > +		} else if (USE_BLK_TS(payld)) {
> > +			if (!tde->bts) {
> > +				/*
> > +				 * Scanning a TDCF looking for the nearest
> > +				 * previous valid BLK_TS, after having found a
> > +				 * USE_BLK_TS() payload, MUST succeed.
> > +				 */
> > +				tde->bts = scmi_telemetry_blkts_bind(ti->ph->dev,
> > +								     shmti, payld,
> > +								     &ti->xa_bts);
> > +				if (WARN_ON(!tde->bts))
> > +					return;
> > +			}
> > +
> > +			tstamp = scmi_telemetry_blkts_read(tde->last_magic,
> > +							   tde->bts);
> > +		}
> > +	}
> > +
> > +	guard(mutex)(&tde->mtx);
> > +	tde->last_magic = shmti->last_magic;
> > +	tde->last_val = val;
> > +	if (tde->de.tstamp_enabled)
> 
> ternary perhaps
> 	tde->last_ts = tde->de.tstamp_enabled ? tstamp : 0;
> 

Yes much better.

> 
> > +		tde->last_ts = tstamp;
> > +	else
> > +		tde->last_ts = 0;
> > +}
> 
> 
> 
> 
> > +static inline void scmi_telemetry_de_data_fc_read(struct telemetry_de *tde,
> > +						  u64 *tstamp, u64 *val)
> > +{
> > +	struct fc_tsline __iomem *fc = tde->base + tde->offset;
> > +
> > +	*val = LINE_DATA_GET(fc);
> > +	if (tstamp) {
> > +		if (tde->de.tstamp_support)
> > +			*tstamp = LINE_TSTAMP_GET(fc);
> > +		else
> > +			*tstamp = 0;
> 
> 		*tstamp = tde->de.tstam_support ? LINE_TIMESTAMP_GET(fc) : 0;

Indeed.

> 
> > +	}
> > +}
> > +
> > +static void scmi_telemetry_scan_update(struct telemetry_info *ti, u64 ts)
> > +{
> > +	struct telemetry_de *tde;
> > +
> > +	/* Scan all SHMTIs ... */
> > +	for (int id = 0; id < ti->num_shmti; id++) {
> > +		int ret;
> > +
> > +		ret = scmi_telemetry_shmti_scan(ti, id, ts, SCAN_LOOKUP);
> > +		if (ret)
> 
> Might as well simplify given value of ret only used here.
> 
> 		if (scmi_telemetry_shmti_scan(ti, id, ts, SCAN_LOOKUP)) {
> 			dev_warn();

I'll do.

> 
> > +			dev_warn(ti->ph->dev,
> > +				 "Failed update-scan of SHMTI ID:%d\n", id);
> > +	}
> > +
> > +	if (!ti->info.fc_support)
> > +		return;
> > +
> > +	/* Need to enumerate resources to access fastchannels */
> > +	ti->res_get(ti);
> > +	list_for_each_entry(tde, &ti->fcs_des, item) {
> > +		u64 val, tstamp;
> > +
> > +		if (!tde->de.enabled)
> > +			continue;
> > +
> > +		scmi_telemetry_de_data_fc_read(tde, &tstamp, &val);
> > +
> > +		guard(mutex)(&tde->mtx);
> > +		tde->last_val = val;
> > +		if (tde->de.tstamp_enabled)
> > +			tde->last_ts = tstamp;
> > +		else
> > +			tde->last_ts = 0;
> > +	}
> > +}
> > +
> > +/*
> > + * TDCF and TS Line Management Notes
> > + * ---------------------------------
> > + *  (from a chat with ATG)
> 
> That's probably not a detail we want in the long term record, nice
> and helpful as they are :)

Mmmm....it was to keep track of somehow of these discussions, the
reasons and the origin of the (supposed) truth...but yes I can strip
down the details :P ... especially because some of these clarifications
indeed have now been merged into the BETA spec so the wording around
this should be less ammbiguos in BETA...

> 
> 
> > + *
> > + * TCDF Payload Metadata notable bits:
> > + *  - Bit[3]: USE BLK Tstamp
> > + *  - Bit[2]: USE LINE Tstamp
> > + *  - Bit[1]: Tstamp VALID
> > + *
> > + * CASE_1:
> ...
> 
> 
> > +static int
> > +scmi_telemetry_samples_collect(struct telemetry_info *ti, int grp_id,
> > +			       int *num_samples,
> > +			       struct scmi_telemetry_de_sample *samples)
> > +{
> > +	struct scmi_telemetry_res_info *rinfo;
> > +	int max_samples;
> > +
> > +	max_samples = *num_samples;
> > +	*num_samples = 0;
> > +
> > +	rinfo = ti->res_get(ti);
> > +	for (int i = 0; i < rinfo->num_des; i++) {
> > +		struct scmi_telemetry_de *de;
> > +		u64 val, tstamp;
> > +		int ret;
> > +
> > +		de = rinfo->des[i];
> > +		if (grp_id != SCMI_TLM_GRP_INVALID &&
> > +		    (!de->grp || de->grp->info->id != grp_id))
> > +			continue;
> > +
> > +		ret = scmi_telemetry_de_cached_read(ti, de, &tstamp, &val);
> > +		if (ret)
> > +			continue;
> > +
> > +		if (*num_samples == max_samples)
> > +			return -ENOSPC;
> > +
> > +		samples[*num_samples].tstamp = tstamp;
> > +		samples[*num_samples].val = val;
> > +		samples[*num_samples].id = de->info->id;
> Maybe worth doing
> 		samples[(*num_samples)++] = (struct scmi_telemetry_de_sample) {
> 			.tstamp = tstamp,
> 			.val = val,
> 			.id = de->info->id,
> 		};
> so that it is immediately obvious you are filling whole record in (or zeroing
> any other fields though not relevant here)

wow...that is defintely a construct I would not have come up with :P
..thanks for the hint..

> 
> > +
> > +		(*num_samples)++;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > +
> > +static int scmi_telemetry_des_sample_get(const struct scmi_protocol_handle *ph,
> > +					 int grp_id, int *num_samples,
> > +					 struct scmi_telemetry_de_sample *samples)
> > +{
> > +	struct telemetry_info *ti = ph->get_priv(ph);
> > +	struct scmi_msg_telemetry_config_set *msg;
> > +	struct scmi_xfer *t;
> > +	bool grp_ignore;
> > +	int ret;
> > +
> > +	if (!ti->info.enabled || !num_samples || !samples)
> > +		return -EINVAL;
> > +
> > +	grp_ignore = grp_id == SCMI_TLM_GRP_INVALID ? true : false;
> > +	if (!grp_ignore && grp_id >= ti->info.base.num_groups)
> > +		return -EINVAL;
> > +
> > +	ret = ph->xops->xfer_get_init(ph, TELEMETRY_CONFIG_SET,
> > +				      sizeof(*msg), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msg = t->tx.buf;
> > +	msg->grp_id = grp_id;
> > +	msg->control = TELEMETRY_ENABLE;
> > +	msg->control |= grp_ignore ? TELEMETRY_SET_SELECTOR_ALL :
> > +		TELEMETRY_SET_SELECTOR_GROUP;
> > +	msg->control |= TELEMETRY_MODE_SINGLE;
> > +	msg->sampling_rate = 0;
> > +
> > +	ret = ph->xops->do_xfer_with_response(ph, t);
> > +	if (!ret) {
> > +		struct scmi_msg_resp_telemetry_reading_complete *r = t->rx.buf;
> 
> Feels like that type might benefit form a shorter name
> 		struct scmi_msg_resp_telemetry_rd_comp
> maybe?

Yes...we try to stick to some standard msg/reply struct naming across protocols
definition ... but this leads to awfully long names...

> 
> > +
> > +		/* Update cached DEs values from payload */
> > +		if (r->num_dwords)
> > +			scmi_telemetry_msg_payld_process(ti, r->num_dwords,
> > +							 r->dwords, 0);
> > +		/* Scan and update SMHTIs and FCs */
> > +		scmi_telemetry_scan_update(ti, 0);
> > +
> > +		/* Collect all last cached values */
> > +		ret = scmi_telemetry_samples_collect(ti, grp_id, num_samples,
> > +						     samples);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> 
> > +
> > +static int scmi_telemetry_reset(const struct scmi_protocol_handle *ph)
> > +{
> > +	struct scmi_xfer *t;
> > +	int ret;
> > +
> > +	ret = ph->xops->xfer_get_init(ph, TELEMETRY_RESET, sizeof(u32), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	put_unaligned_le32(0, t->tx.buf);
> > +	ret = ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		struct telemetry_info *ti = ph->get_priv(ph);
> > +
> > +		scmi_telemetry_local_resources_reset(ti);
> > +		/* Fetch agaon states state from platform.*/
> 
> Not sure what that comment means.

That there was a problem between the screen and the keyboard :D ...
..I will fix...the meaning was simply...

	Fetch again the states from the platform.

... but seemed more gaelic from my mis-spelling :P 

> 
> > +		ret = scmi_telemetry_initial_state_lookup(ti);
> > +		if (ret)
> > +			dev_warn(ph->dev,
> > +				 FW_BUG "Cannot retrieve initial state after reset.\n");
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> 
> > +static void *
> > +scmi_telemetry_fill_custom_report(const struct scmi_protocol_handle *ph,
> > +				  u8 evt_id, ktime_t timestamp,
> > +				  const void *payld, size_t payld_sz,
> > +				  void *report, u32 *src_id)
> > +{
> > +	const struct scmi_telemetry_update_notify_payld *p = payld;
> > +	struct scmi_telemetry_update_report *r = report;
> > +
> > +	/* At least sized as an empty notification */
> > +	if (payld_sz < sizeof(*p))
> > +		return NULL;
> > +
> > +	r->timestamp = timestamp;
> > +	r->agent_id = le32_to_cpu(p->agent_id);
> > +	r->status = le32_to_cpu(p->status);
> > +	r->num_dwords = le32_to_cpu(p->num_dwords);
> > +	/*
> > +	 * Allocated dwords and report are sized as max_msg_size, so as
> > +	 * to allow for the maximum payload permitted by the configured
> > +	 * transport. Overflow is not possible since out-of-size messages
> > +	 * are dropped at the transport layer.
> > +	 */
> > +	if (r->num_dwords)
> > +		memcpy(r->dwords, p->array, r->num_dwords * sizeof(u32));
> 
> This needs le32 magic as you are copying from an array of those to an array
> of unsigned int (if you do this as a memcpy that should be u32 to make the
> size explicit).
> 
> memcpy_from_le32() should do what you need here.

So...this is the usual per-protocol events handler that is used to parse
the notification payload and build a notification report for the users
interested in this notification to use...

...in this series this report is really used by this protocol itself in
scmi_telemetry_msg_payld_process() to cache the received DE data...and
in this last routine all teh LE32 handling happens ...
...this is the only protocol indeed that makes use and process notifcation
reports from within...

...so it works properly at the end ...BUT is wrong as you pointed out since
any other user interested in these generic notification support will not
enjoy these post-processing conversion and also the report itself uses
u32 fields already so....no excuses..

I will fix...and sparse/smatch will scream a little less..

> 
> 
> > +
> > +	*src_id = 0;
> > +
> > +	return r;
> > +}
> 
> 
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index c6efe4f371ac..d58b81ffd81e 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> 
> > +
> > +/**
> > + * struct scmi_telemetry_proto_ops - represents the various operations provided
> > + *	by SCMI Telemetry Protocol
> > + *
> > + * @info_get: get the general Telemetry information.
> > + * @de_lookup: get a specific DE descriptor from the DE id.
> > + * @res_get: get a reference to the Telemetry resources descriptor.
> > + * @state_get: retrieve the specific DE or GROUP state.
> > + * @state_set: enable/disable the specific DE or GROUP with or without timestamps.
> > + * @all_disable: disable ALL DEs or GROUPs.
> > + * @collection_configure: choose a sampling rate and enable SHMTI/FC sampling
> > + *			  for on demand collection via @de_data_read or async
> > + *			  notificatioins for all the enabled DEs.
> > + * @de_data_read: on-demand read of a single DE and related optional timestamp:
> > + *		  the value will be retrieved at the proper SHMTI offset OR
> > + *		  from the dedicated FC area (if supported by that DE).
> > + * @des_bulk_read: on-demand read of all the currently enabled DEs, or just
> > + *		   the ones belonging to a specific group when provided.
> > + * @des_sample_get: on-demand read of all the currently enabled DEs, or just
> > + *		    the ones belonging to a specific group when provided.
> > + *		    This causes an immediate update platform-side of all the
> > + *		    enabled DEs.
> > + * @config_get: retrieve current telemetry configuration.
> > + * @reset: reset configuration and telemetry data.
> > + */
> > +struct scmi_telemetry_proto_ops {
> > +	const struct scmi_telemetry_info __must_check *(*info_get)
> > +		(const struct scmi_protocol_handle *ph);
> > +	const struct scmi_telemetry_de __must_check *(*de_lookup)
> > +		(const struct scmi_protocol_handle *ph, u32 id);
> > +	const struct scmi_telemetry_res_info __must_check *(*res_get)
> > +		(const struct scmi_protocol_handle *ph);
> > +	int (*state_get)(const struct scmi_protocol_handle *ph,
> > +			 u32 id, bool *enabled, bool *tstamp_enabled);
> > +	int (*state_set)(const struct scmi_protocol_handle *ph,
> > +			 bool is_group, u32 id, bool *enable, bool *tstamp);
> > +	int (*all_disable)(const struct scmi_protocol_handle *ph, bool group);
> > +	int (*collection_configure)(const struct scmi_protocol_handle *ph,
> > +				    unsigned int res_id, bool grp_ignore,
> > +				    bool *enable,
> > +				    unsigned int *update_interval_ms,
> > +				    enum scmi_telemetry_collection *mode);
> > +	int (*de_data_read)(const struct scmi_protocol_handle *ph,
> > +			    struct scmi_telemetry_de_sample *sample);
> > +	int __must_check (*des_bulk_read)(const struct scmi_protocol_handle *ph,
> 
> I'm curious. What about this one makes it suitable for a __must_check?
> Seems a bit random.

So some of these read functions will return -EINVAL when called with an
invalid setup while in some other cases could return simply an empty buffer

e.g.:

	de_data_read () -> a single DE read...-EINVAL if the DE is NOT
			   enabled

	des_bulk_read() - > returns only the enabled DEs and so it can
			    return an empty buffer when NO DEs are enabled
			    BUT it returns -EINVAL if called when Telemetry
			    is disabled as a whole

	des_sample_get() -> same logic as des_bulk_read() BUT with async
			    messages

..so I would say..it is NOT random...but needs to be reviewed when the
__must_check is applied...since as an example is probably missing in
de_data_read()

> 
> > +					  int grp_id, int *num_samples,
> > +					  struct scmi_telemetry_de_sample *samples);
> > +	int __must_check (*des_sample_get)(const struct scmi_protocol_handle *ph,
> > +					   int grp_id, int *num_samples,
> > +					   struct scmi_telemetry_de_sample *samples);
> > +	int (*config_get)(const struct scmi_protocol_handle *ph, bool *enabled,
> > +			  int *mode, u32 *update_interval);
> > +	int (*reset)(const struct scmi_protocol_handle *ph);
> > +};
> 

Thanks a lot Jonathan for having a look at this series.
It still needs some work to cleanup and split as you could see.

Thanks,
Cristian

