Return-Path: <linux-fsdevel+bounces-78734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEYSC1e4oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:29:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A631B9C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0471307448F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80836312834;
	Fri, 27 Feb 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VblWcR57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8741C2FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205829; cv=pass; b=HchpHRKBwahsCXXhKwCuYMgyb71+L/JiMgqgJZVZ2a0sxw+YfKv8qL8lzqyZvUPU3+UDCyxYGBSzcirxs7PpgmtxcYbwxIyspGZa7qBXYnJ86cI3wzzaOYq0gH8k70YBi8sz53cO8jlejteBMAzjyAseYU2FLrFXBJJVtLA1XCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205829; c=relaxed/simple;
	bh=uotwpilcOm6eLw810YFolPuoHWSHu/NQz1CxqH++rLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcO/xWdEb/TcHhdDyha+cvv6OLOvsTz5r2lmI2env8RJaPKRlvlJ4rT+on76kOC3ZyUkXIpypSUQx8Lx0Z9ondLjStfAPXFgoIocVHK3L/J51t62k6k/vtnG/Dgif847wX5mIKzp7EsbNpdhLFgNruqMRedUfPjfKxDNOsU2Ftc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VblWcR57; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8954a050c19so25236406d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:23:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772205827; cv=none;
        d=google.com; s=arc-20240605;
        b=kfQF6xwwElPqMgmqZYPq3Uk/lEAN3zz2Dh4+iUztMjWiwhdM1FJ4JX0Z20qmIZ5U6N
         Hon1J2lsuFMvOvXq61cMJJW6nTlyPTvQkC37sQOU76eqVSbu9+uCHrUtrmKzu3Uo8ev5
         2sq4GYRaH5xC/zBzJk734GbN9pyd/7fv3RB6zHBtHAqsQqnLB6J+XWdfZC2aemCfA2+2
         roUZf33NQdDHGeEHZe1fE8HQk7Toj5eWw8WjlHaLjZ9WbXqV5hLJHTCTy39/+iqP9c5/
         aeMzAj7Fi7e1lY12Y9SNmnDijhNFOcqjUY8Uw8XEHHJdo/yWvBS6Jp/akvUO8FUkR4wO
         trwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RWykH1VKjJ0+tQ9BziQ6DTgQHZVX93ZWpnJrLsd4AEA=;
        fh=50zgNv101Q4UEvJpwlD7IRGGnDPphu+pW9P3S44SUKY=;
        b=Fb9Uz8mT2cjvXKcG2999frNMA5lT7UQ39o5XgOUH18vTbejtkjTKKlVrSMk3/NXa5j
         XkW+nN5aSnhKi81VXzlvDS+LT9bOduPQk1UPBDCCYyi2jSkS6AEi9F4feJSQtKA4F7lg
         Yvy6yBXMdPO/TFlKhmmZW/3hnCtJjkIPZjWD6bxdDo78XbrKM6FFfQtRm4e8apWujneJ
         FIfueiflJswPvdhufQwr9Hr4zfSN98ku+n9rjX2SQ76jm+N18Sj2qtmVaQyqLQXeOEe9
         nj4jAsAMKlKZxnnLjH+3fkQKiO/zE3Ohun3ev/VjXsozWb6EOTlLOUO0fKc74ntJbvyt
         9TGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772205827; x=1772810627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RWykH1VKjJ0+tQ9BziQ6DTgQHZVX93ZWpnJrLsd4AEA=;
        b=VblWcR574HAk3YFDPvCfCxHPKS3dTbBlWTb+xZHYBDc55D1WIg7Ok5wAwHDmnqrXhx
         cXIS+uffH1laBTAMsRdHqhd5421e1SqA7VNiD9WaY83Rqii6XrmPjxAlgOgp9rvA5gl9
         7Lwlwkh0xTAdVKVrIbA2rsBGX1j9BHcv0r70Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772205827; x=1772810627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWykH1VKjJ0+tQ9BziQ6DTgQHZVX93ZWpnJrLsd4AEA=;
        b=U4F1Xa1FzwUouOeYJDY54URDMA3DoJ3fEmkZCg3CU2A3uC5hAag/3F8qWL0fmLhLj5
         5HZu+ZzDOqxPrt94i7E0bC0cqamU3iIpyyWlASwY/Xo7FZeu2i7jcSGD6itwdeookr2C
         QS6ljf5G0aC/GcUvPqEf03wfpSVOBuS8KUCOGJmsnh9J/gIYMi62YVQ6HT4T+A+2jjVM
         NXIPyiQXxsk6ty6nXTHgXmKBL9G/9vorcmpAmKuDZkpdOWSH6s+QautyIY4W1mFCP5+K
         Nu0V3SDQnFyJOVUKunyyO1mz22SROtAsH3Ui/O+/H9dtFRY6QTk/Dw29TVkTJeMpGmyG
         96iw==
X-Gm-Message-State: AOJu0Ywj+9pVXstdwqjfj3HpVE8dKesVPHfRDSSxyybEkUn0jONlMmko
	QRhvI8l3Vst7kEze9F3BcsftFnFohAH6drVzMp1SwntSwmoYmjkNCp3qNDDc4IdFnGbBm10f6R+
	gTCLGB++qXPpmTDw0Sk4LDHtC/tZkB+SYd1b2P97vsQ==
X-Gm-Gg: ATEYQzwvcnhPa1zuULGcNfrDUh9RgBGQ2XmYq4YlUlAMM6tGJ57GTakqk2Qs3PtjajI
	hASg1N00GDnz2Q+CaSor1147UeuZcAN/33cYVcJK9Yk/6mcFecVkzrz9YS51Pq4cD5/y8lHddyJ
	2u+svWZ+OHB3tJ0e6JJMHc5nlXmRn+D2YFKtbAKYA6No3k4JvBWBbVtOsP1CT8jjIzSh55ShvwJ
	FdFVKCHUKe4H4QeqNLDYBaeVylg/reIQ6vHxSiYb4NVdj+l1ZeaPewGtIeLrQzSNo0vEPzv29Jl
	SudB/w==
X-Received: by 2002:a05:622a:87:b0:501:1795:9d52 with SMTP id
 d75a77b69052e-5075290c36fmr41798241cf.33.1772205826895; Fri, 27 Feb 2026
 07:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115023607.77349-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20260115023607.77349-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:23:35 +0100
X-Gm-Features: AaiRm52_D9bGlidCd8LznbS5U79XqZexpDSMuESIpIURqCF9-MEsGPF7s7rPbC4
Message-ID: <CAJfpegts6NiEokGSC7t+bXKHWHadYhxjYZDZ0+PabNSTnWVDLg@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: fix premature writetrhough request for large folio
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, 
	linux-kernel@vger.kernel.org, horst@birthelmer.de, 
	joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78734-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,birthelmer.de,linux.alibaba.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ddn.com:email,szeredi.hu:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C2A631B9C87
X-Rspamd-Action: no action

On Thu, 15 Jan 2026 at 03:36, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
>
> Fix this by eliminating page offset entirely and use folio offset
> instead.
>
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Applied, thanks.

Miklos

