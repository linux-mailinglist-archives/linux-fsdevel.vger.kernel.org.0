Return-Path: <linux-fsdevel+bounces-75618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK9TNoXWeGmOtgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:15:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876A96766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0C330E4782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15F35CBD6;
	Tue, 27 Jan 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkJCOcjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACD35CBBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525839; cv=pass; b=RcH03quP5Oe5DMuUssEkDcMTM+j4VuM5UznvcKAsztiibYbyXoqx+V1TFp4f6N4yO3VBenFAQjMssfqQm2G3M13aPziG6iEoRI3xQ5iQlzRfoVE34dUqq02WgHCzEez187dBWI0wQee6fJtfPCFIxY/AmVYRjaEy9RWK74B2c90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525839; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecgeuyd2BajS6St0QwMHyhCeA5347zgarkr/yMaZSezsgbeIOC31yUTnj55ULm8tX5FY4cxfNbKQ7/+4JTO1tscj8GJb/jlukQPeb6opQapDy8GeqiY6/FYxZe6Z5qK34mu0m5/bsRpIziYdOxqs+9B6loQyiosEIYe7KkJ/lGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkJCOcjr; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8838339fc6so1095983666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525836; cv=none;
        d=google.com; s=arc-20240605;
        b=RGOD6WxP4cAVzYUq9XbstqpIQBvmY20fe3gXEHnOb2zE8SYuGE3SvLZeqETJebmdgr
         tgaaFSy1aXvbhv+5fHtj2k+U35M+gTIOSD/zcy0TYxZZ5nojpHozXtmiyE/mNRRMskge
         hOFYZKqDkZHPk7MCAaCqqKYuChA96NiOHOFfcexuLlzzaelP2a8P3KlzMsfGvXo5Jeng
         pjhgsbdF9Lw3ar6EvNesTP1lWpWBSysnefbohzXgaOezoRv+BbO7eMPHJKxW2Eq2daqf
         w2wjlGozuL5s665nGvBtBrT2Jrgt2xuy8bQH7w8UgD5fylDQc1MckT0M+muesbpdZXb2
         Stsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=Ga6ejFeBC6/xuBVZC4/cHMM3eyB3f9PYGH38/XlZqUA=;
        b=dhlV3gOHYA6XVf2H8Ab6WTGtOfnM6yCm1ezLBCzGULi4NOQ7F0MN164djjm5eI5+jo
         7wGDOZsAfq2ggmKPqJG0IwQK4WW9JwvLxzU/KPwPm0Ch6MvImYCbHRcXnFwKDjt41ltm
         UVLOwH6xDJHRBWvBsbQb7hdEVZXKqKnBIU4IwkhszbxylEU0QeIo0T3v4zB+qk6RFncR
         06MEZGX+HXtuqm4KU4YBdMGV7m7L7221RPgNbrIYpySGJnTpXDW0Tac0JuaF3lqroTpw
         4TYafoX0l5u1MG2J6mdB6AtI3PFXl2aZ3PNnCyLnKN47Zm26I7/zUHw9dmZv3wGT4VXg
         ymqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525836; x=1770130636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=GkJCOcjr7X6KtcJY30ZuRa7/aqsS/tRsv4aPAPpaAiZMpEVLO9XG6pGd1y8SdczMQh
         48lapHpLy5vrAlwftRyXgbyLbQcKKsaSXQbfwWt6Kxmqzd/wh+EX8sFvSj3y/Aue/laF
         bb0bOnlBVkLoY9FW0D/z6hnvYseVG5ZQ3WaQ+Cki+krMSnAYAI6jr+vj2O6vJYEJSJPN
         ZGSSpHo8KY4IcPo15gm9nnDfwafNPcnpQ9/Q51lugcNdmuTOuIB3LTP8urRE2l8e/UtV
         qaCO+HITT1EK8JGVGZYVVKVsMJ3/j5VMH5zmptVF5TlqtMzAfzttrbMVGycHzDXTIccu
         Gy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525836; x=1770130636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=su0pSatDUG1lyXjPWl4ZttzaBG0tpqc3Zibrslg4GL/JEi5PSj2PudQwkoECxzHsJK
         RTKhgOf699LxC+lpOLm0ve8nDBvQqYbDshBdzd4jfTkUfy3Bzl7g4EHllJo7xcRngnDB
         cAdtCTfD2I4J7e6VAcwvqNO0nVvl9mFNexRufuw2lK33JN+S+39a+7NgDJpQvWlyrscW
         gIe0ZFixjRnE2E5NUPzfQpJJDgqITasaAVbgJlb5JIcv3sVpWYZQOzUj7FYMzfye8Tpg
         W7AFCyLGMwrsxx52ngCusdZsx7FOnXon3RDygDFdmWEirkAbX9P1HIrXwIfq2aN1CNRf
         Te7w==
X-Forwarded-Encrypted: i=1; AJvYcCX062VYC6FJm38uDRdqhvAIRNz9GAzpl8tzxW2VlNEGyyPeE94Xge1SCjjxE6MkQNcxL+WWjjkLddEU0p3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoltn0VvfbWpPwg5GRsRnV65B3HXo/ycr7vcv56ltTkXBR4kr
	k9GSp1mVHIXrGaLX7mO8vNio3nnsOAtMDLeyrnTH7/NqtSnkXmHdcMf35aBJ/hsXp7j8/j9zpRr
	dOVvkCKLKnuNsrBj7BJvAGENNBTlZMg==
X-Gm-Gg: AZuq6aKodPRHTW/4K6ll8vJDL5FHdSCuYZNOmXePcdrZ6tRRORCwB3sgkRQyXdtu+En
	p7OTGLGLuMf/dPChG99eJXZqVzsvScpHNP3N4Ua+5zFB5FH229kRDcHhWWerMAjcyz8oQvUY1PI
	RrfbyDcuCNnpirvHFiioxb9mkXcVpY1xWbq5HvYEdTJV35mjemrSNUFJN+pRUE3fPOYB5z5qz56
	jH3YPjF6z3R/lC31PRdha8FTfa82AE7lusRw8yaRxhIfltLy1DkhjTfE/GmfSfO2/waaA/rFMIz
	SdFOfz8qjZt4Wdp2tSRiEmoKElfrQM49a7jpvDf79GXhvdgNv6oVWNUZ4A==
X-Received: by 2002:a17:907:3c94:b0:b88:4ff8:1300 with SMTP id
 a640c23a62f3a-b8daca89e5emr131696566b.26.1769525835895; Tue, 27 Jan 2026
 06:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-6-hch@lst.de>
In-Reply-To: <20260121064339.206019-6-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:26:37 +0530
X-Gm-Features: AZwV_Qh-bXQokozgO9CYibn8UPXNXVRECr1GxeaPZ8jRlXI3X_4jeQcXdNJkNL8
Message-ID: <CACzX3Avvr4e2LR9P_XDVtAXaU_KJqnO2SeUMc8Gh19H8-BpwgQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] block: make max_integrity_io_size public
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75618-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 5876A96766
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

