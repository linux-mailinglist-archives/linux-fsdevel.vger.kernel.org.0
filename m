Return-Path: <linux-fsdevel+bounces-3284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CCE7F24E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B9528288E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 04:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74406FA2;
	Tue, 21 Nov 2023 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4NMJkDES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ABAF4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 20:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hKYiu+FVIhC+U2KFjMkjr9lawiE5R4QF/5KmcU3mE/k=; b=4NMJkDESbgCIs51rhXLGh93ZZ8
	ISdJBDzN19V1me+T2Um2CQDkULNX+Z90dtatefJFvInEU+oQNUievUhtLU6AlgXIIu41soOiM3wpE
	0zWGF8Vr50z6KEjFtKivcmRugM5prwAR1F0Zfn2EcMnCJsAsfH46kqkSRyO0aT24sDhJWrV4EdJj5
	vQdf6iU4dWn1HVELnnMnMjSXQD+n/WD2W4/2HRKTZ3c7fkT5mSlO9LQBgzZbWweKvrQlgiOsVHPbF
	OF4RchrV2ztKY25PouLGQYvQbVFX2bueEPnwyGpYorGT4Jj0jRKqGAqNiHVx1Ff/BIue5EUfeXMYZ
	y6sJVosA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Ie9-00FcJc-07;
	Tue, 21 Nov 2023 04:46:01 +0000
Date: Mon, 20 Nov 2023 20:46:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Usama Arif <usama.arif@bytedance.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, nvdimm@lists.linux.dev, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Fam Zheng <fam.zheng@bytedance.com>,
	"liangma@liangbit.com" <liangma@liangbit.com>
Subject: Re: Conditions for FOLL_LONGTERM mapping in fsdax
Message-ID: <ZVw2CYKcZgjmHPXk@infradead.org>
References: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
 <454dbfa1-2120-1e40-2582-d661203decca@bytedance.com>
 <a0d67f2d-f66b-8873-7c11-31d90aae8e8c@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d67f2d-f66b-8873-7c11-31d90aae8e8c@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

We don't have any way to recall the LONGTERM mappings, so we can't
support them on DAX for now.


