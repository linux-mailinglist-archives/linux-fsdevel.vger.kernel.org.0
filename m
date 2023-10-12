Return-Path: <linux-fsdevel+bounces-147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20F7C6251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 03:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AC41C20E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DE57E4;
	Thu, 12 Oct 2023 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IKoc788u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06662F;
	Thu, 12 Oct 2023 01:35:30 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502EFA9;
	Wed, 11 Oct 2023 18:35:28 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231012013526epoutp01e59c89fc5af0668280e12fe8ba3ce97b~NOEpGtKlD0928309283epoutp01W;
	Thu, 12 Oct 2023 01:35:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231012013526epoutp01e59c89fc5af0668280e12fe8ba3ce97b~NOEpGtKlD0928309283epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697074526;
	bh=1xR0xaUS2PUNErqIs6W8I7g/oXEvEzevloTiZHy7yn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKoc788ucqoX+1rYZ1cY79eSmMcmVwS0eghHQhGqrR/HLWyyIXB8MuWCfmDrDLXOj
	 8PMkLIgpnrHuEowSQRnCS5VVp08w3N/TXJuIlc+g+cHn/f3WnbyspdTGHjKAmE4SOC
	 ntvhf0gBRuAolhMEHXfV4saUNE2DtPAg/JK10oDY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231012013525epcas2p3158e15e50f4fb96596c22fc76dae8717~NOEoglMye0540305403epcas2p3J;
	Thu, 12 Oct 2023 01:35:25 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4S5XJY0dVXz4x9QB; Thu, 12 Oct
	2023 01:35:25 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.32.08583.C5D47256; Thu, 12 Oct 2023 10:35:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5~NOEndJu9D1929519295epcas2p4N;
	Thu, 12 Oct 2023 01:35:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231012013524epsmtrp2cfd5db0903a76b3b9fcc369c220eaacb~NOEnbUrc43128231282epsmtrp2s;
	Thu, 12 Oct 2023 01:35:24 +0000 (GMT)
X-AuditID: b6c32a43-96bfd70000002187-a4-65274d5c25e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.BE.18916.C5D47256; Thu, 12 Oct 2023 10:35:24 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231012013524epsmtip227567c21b1e8eee7135c8fd96d927019~NOEnEBABz1669816698epsmtip2l;
	Thu, 12 Oct 2023 01:35:24 +0000 (GMT)
Date: Thu, 12 Oct 2023 10:25:11 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <20231010074823.GA2536665@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230823131350.114942-7-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3pvb0sTumvBeYaJIXXqYANapPSAwIzAch2QgMvQ6Axr6A1F
	Sun62HQjoRAQ0A0ZpgqMsRIdoIJgeUl5KaCAypYgYHjpBoK8n2FOGWylF7f99znf8/2d7znn
	lx8XE3RznLixKh2tUcmUQoKH17a5SNw+C9tHi8anDqCCijICXb72mEDNndFoPec+B/WM9Vml
	qWQcLRR/C9BqxWsMjWfXYOiuaR5H48tZOHrWXMJCIxeMOKqbmGOh6eo2HGVYVnFkHutno8am
	Lhw9thQQ6GnZ32zUXtGNo/qCLja6OD8B0JWSvajnjomFjK9mCXRh+AmBOr67w0LNGb+xrN46
	FkpuXyBQ3tAQQBntf2CoaeMVjmruveSg1GEJGvi5knNwD1VWWAaotdc5gEptHuRQJrOeSm2f
	Y1NVpa6U+XomQZmXczjUcH8jQXXmruFUkcGIUVVXk6jJqjxALTT3EVTVw2+oFfOucPJ4nJ+C
	lslpjTOtik6Qx6pi/IUhn0QFRkm8RWI3sQ+SCp1VsnjaXxgUGu72UazS+plC5y9lSr1VCpdp
	tUKPAD9Ngl5HOysStDp/Ia2WK9VStbtWFq/Vq2LcVbTOVywSeUqsxs/jFJaLtUB9aedpSwbX
	AFa3nwN2XEh6wd97zWCTBeRtALP6decAz8rLAE49qGcxG9bFYvfhNwU9lZUEY6oH8HmKkc0s
	xgGsXMvlbLpwcg8sMI4Qm0yQ+2BndbEtwpH0gKM102CzACMfEHDkh0e2CAdSCbNHLTaTPekO
	W7PmOAxvg115z/FNtiM/hDNLf9miIXmWB8cKmTRIBsGmzCWcYQc43VG9pTvBlfkmguE4OLKU
	vcU6ePORYcuzH+ZPpFuDudYbKaCpO3QTIbkbtg/aTsRIPsxoW+cwsj3MOCtgCnfDluLCrdB3
	4Gh5OpuxUDBzKYn5kg4AM42DrGywK/9/j8n/LyvfFvABNDUsE4y8E5ZscBl0gRUWDxNgXwdv
	02ptfAwd7akW/9vc6IR4M7DNlWvgbdD704Z7K2BxQSuAXEzoaD8a+y4tsJfLznxNaxKiNHol
	rW0FEmtnvsectkcnWAdTpYsSe/mIvLy9xVJPiUgq3GH/NO1HuYCMkenoOJpW05o3dSyunZOB
	5SBfS2MTjZPPTmyDR05Lje8VNZCWW8eM5MmlTs6LxSMpEYlKrM2X6j9O7TBQQe6Xk+07Hatm
	Fg0rupwrkHbm3wvyIw6FGX4dDPX99OCZimD5QuRXwZaBMJNvPD/U2IGZGgRAa6o6WvrWbEpg
	QOL77BLtjL712LB5PqnQf7jRYsZCr37cGEnrr5UfmjNdcldgL2dv8UL5ATWzJ57c7d2YLsiq
	jR7ha8Gk6gCo5aV7hPxSF+K9l1P653yDS9EXN+r289J8F7x7X8hC1k92HvWtuHl+JmKjzzlR
	Whw2JDt/eGA3P6unJXj1lCIy0Gfh4Sw3Kxc7dSPifkuwuIVXXibEtQqZ2BXTaGX/AFs19Azg
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG956vHliqx8L0nXWydMMiycpIMHuzzIlblpwsjk2iZJtk0rQn
	pdBi0wrhYxHIuoHNVrHarTRoOkUKtQvsQCkSbRDqBlhnVhCnImztagTlY6Dd0NmNQpb57859
	3Vfy/HhoXHSM3EirSw5y+hK5RkIlEt0DkpRX8t+Tcq/23FiHmtrdFPqmbYRCvkEFemL5QYCC
	4WvL1VQtgeZavgToYfsjHEUaPDi66JglUGTBTKBJnxNDt49YCeS9M4Oh6a4BAtX3PiQQHx4j
	0fkLQwQa6W2i0IT7HxL5268Q6FzTEImOzd4B6LRzCwr2OTBkXbpPoSPj1yn041d9GPLV/4ot
	b70YqvXPUajx1i2A6v1RHF2ILRHIc+lPATKOb0M3znQIslNZ90k3YB8/sgDW6LspYB18KWv0
	z5BsZ2s6y7sOUyy/YBGw42PnKXbQ9phgv62x4mxnczV7t7MRsHO+axTbebmKXeQ3f8B8nPiG
	ktOoyzh9xpsFiYWOyGdANwbL+6KqGvBTkgkk0JDJgsGODsoEEmkR4wXQ5blKrILnoX1xCFvN
	SXDS6CdXR2EAb85PgTggmFTYZL1NxTPFSOFgV8tKn8xkwJBnGsQFnAlQ0HzWTsZBEqOBDaHe
	lZGQkcF+84wgnkWMAX5+L0yu9uvgUOPvK1fgTDr8JTa1fAW9nMXQGaPjdQKzA97742+qATD2
	pwz7U4b9f8MBcBd4jtMZtCqtQpcpM8i1htISlUxxQMuDlb9Jz+0BLe1PZP0Ao0E/gDQuSRaG
	1C9zIqFSXlHJ6Q/s15dqOEM/ENOEZIPwJc1hpYhRyQ9yxRyn4/T/UYxO2FiDvaBaU2dV9dhO
	qH/md7UqLdrtRdHgiUlX0akPd1bkGPeMDgtHy5Nbs2XBurVdWe+kVRcETp/c7XWuZz6qzNvm
	lZpYbuG747ni78ttgRyxdkC8Q2jc8G7bpipTYJdLPV+Zs9dtya0K6B/MVsSyj4+WpfmmhdZD
	EzUdfHHGdl01H322+be1qVcv54+4wLBh59ZP9+ZtKjokPWqyQOWL643Jadr58i1V+e8X21Js
	EQqv80zEIsSain1vXSkuMF1PUf/V5/Wnut4uM0dLqz3I8/pdUvHa+NjwGZLmpebMpcI9D+o2
	Lz6zX5EX+uToF+F9Z53M/e7uUG3z1/WZzW3dWTMSwlAoz0zH9Qb5v3q2daWmAwAA
X-CMS-MailID: 20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_d8fad_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<20230823131350.114942-7-alexandru.elisei@arm.com>
	<CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_d8fad_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Aug 23, 2023 at 02:13:19PM +0100, Alexandru Elisei wrote:
> pcp lists keep MIGRATE_METADATA pages on the MIGRATE_MOVABLE list. Make
> sure pages from the movable list are allocated only when the
> ALLOC_FROM_METADATA alloc flag is set, as otherwise the page allocator
> could end up allocating a metadata page when that page cannot be used.
> 
> __alloc_pages_bulk() sidesteps rmqueue() and calls __rmqueue_pcplist()
> directly. Add a check for the flag before calling __rmqueue_pcplist(), and
> fallback to __alloc_pages() if the check is false.
> 
> Note that CMA isn't a problem for __alloc_pages_bulk(): an allocation can
> always use CMA pages if the requested migratetype is MIGRATE_MOVABLE, which
> is not the case with MIGRATE_METADATA pages.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  mm/page_alloc.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 829134a4dfa8..a693e23c4733 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2845,11 +2845,16 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	if (likely(pcp_allowed_order(order))) {
>  		/*
> -		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> -		 * we need to skip it when CMA area isn't allowed.
> +		 * PCP lists keep MIGRATE_CMA/MIGRATE_METADATA pages on the same
> +		 * movable list. Make sure it's allowed to allocate both type of
> +		 * pages before allocating from the movable list.
>  		 */
> -		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> -				migratetype != MIGRATE_MOVABLE) {
> +		bool movable_allowed = (!IS_ENABLED(CONFIG_CMA) ||
> +					(alloc_flags & ALLOC_CMA)) &&
> +				       (!IS_ENABLED(CONFIG_MEMORY_METADATA) ||
> +					(alloc_flags & ALLOC_FROM_METADATA));
> +
> +		if (migratetype != MIGRATE_MOVABLE || movable_allowed) {

Hi!

I don't think it would be effcient when the majority of movable pages
do not use GFP_TAGGED.

Metadata pages have a low probability of being in the pcp list
because metadata pages is bypassed when freeing pages.

The allocation performance of most movable pages is likely to decrease
if only the request with ALLOC_FROM_METADATA could be allocated.

How about not including metadata pages in the pcp list at all ?

Thanks,
Hyesoo Yu.

>  			page = rmqueue_pcplist(preferred_zone, zone, order,
>  					migratetype, alloc_flags);
>  			if (likely(page))
> @@ -4388,6 +4393,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		goto out;
>  	gfp = alloc_gfp;
>  
> +	/*
> +	 * pcp lists puts MIGRATE_METADATA on the MIGRATE_MOVABLE list, don't
> +	 * use pcp if allocating metadata pages is not allowed.
> +	 */
> +	if (metadata_storage_enabled() && ac.migratetype == MIGRATE_MOVABLE &&
> +	    !(alloc_flags & ALLOC_FROM_METADATA))
> +		goto failed;
> +
>  	/* Find an allowed local zone that meets the low watermark. */
>  	for_each_zone_zonelist_nodemask(zone, z, ac.zonelist, ac.highest_zoneidx, ac.nodemask) {
>  		unsigned long mark;
> -- 
> 2.41.0
> 
> 

------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_d8fad_
Content-Type: text/plain; charset="utf-8"


------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_d8fad_--

