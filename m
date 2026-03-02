Return-Path: <linux-fsdevel+bounces-78933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BEmHEmwpWkiEgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:44:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6F1DC125
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 692B5301A7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06516411626;
	Mon,  2 Mar 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dVXSb9xZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A5283FE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466244; cv=pass; b=VW3TI/S6j2+ra4bfZ+uMYbB7a45naY/3cSuIrcmXJGKfgHzgCXfBUX89ES13se8yQnNIucemON91OPpPUTdBBFc/OICEthgqF57ifnhgDm5jnq+B7MCjscxAWlPP54HXIL3qc3L9H9G2yKu2D1UuSfSBaj2JJmq3h+Ya/t9TmFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466244; c=relaxed/simple;
	bh=y5jmz51OP11F2w1N6J8Q0eekBLPergcwDQ8lUfOts2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPUU6lQoMAS93hfOcAjyMuR3mBjkAMvcdISFNH/jb+NKzdN1f9poju3Hx7ugR9B7NwCkn25NGlU0/dAw89bjQFz1VnGhspvJFoE62krKwa7YyyANU+eRdCUSyJOdREAaJ6G1GEHKQG/z2by7PofTDuzbeIPFwERm0IKOqF4+W34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dVXSb9xZ; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fb2b94c1so18731066d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 07:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772466242; cv=none;
        d=google.com; s=arc-20240605;
        b=j19yXMLEmyUSxxNxvIqjS6L1EABgFIDFGHJ6BmAzWqVtfodmlvWpE1yWT26zYRyxjp
         Yrf7vd4Ih3YnzxwQ7PkcUPMiA6nUe19VoyPiXMJcb1wJcf7VaWHKC/er07F0X9pOnyTw
         LZ3J7kNcFWAfdMTgbQ0szB+pXg1ztJ1IzjojShR3DF1eKHbHj72vt1cA+VY4mI7IPpZk
         pqhY1Md0qrTvzA+FPml7sZnI+fLXTeYXNwuABd6GpCp+12AcJtjicFkMfveKSoXcMrET
         k+0rp2+g18N2j8a0Omz8YetTUiVlitg+Lk1JF/CaX7TYjNcCVQTX+tkmh5VMbSKO7PaT
         +X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y5jmz51OP11F2w1N6J8Q0eekBLPergcwDQ8lUfOts2g=;
        fh=VCFDIVV9IRaoAgt5xBAQyLAnJoCZItWw3w58hCNWbEk=;
        b=brpHjpeyxrC3FaW0DC7EKEPIox20z2Y/cjkxEddwwRVZ3ko3KJKTMfNi6OYtEfpb+p
         H3ivK9gXFz8pue5AO+o/UbXuqO7S5GT8EVcIhDqMqWHz2B7eFDy+i+KAlWBeSADh7XpZ
         vCD4Kbzj8+7ek09IDZ5OC+VdI23O+/MZ9mRc5W9F3Z/nKhilq1ybN0+0Uc7yf3ZVn1+i
         sqWjJt1LuI7bEDWOx8PinLV90umGLJThpkj+IwU+KtgBDT76aEYhRe1/rNez9ilkVG+c
         dl2E3d285eJPgpcpLzniyQ87VDWuIZjXmmMJfmEFbhji5FPLfwyVm+is3fRBKnq+m+7B
         3KZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772466242; x=1773071042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5jmz51OP11F2w1N6J8Q0eekBLPergcwDQ8lUfOts2g=;
        b=dVXSb9xZH7/O63OLyxLFdThVmd59GxJWwZhGwcR98q85RAhJGT0HtTzvQFCAt40tPL
         WpT4KAFDu7GcVNcMhDe21cS6rtXU6HGohM4eeZ0s4KXsUKNuSz0tQ8STOk67E3V1T5yt
         LTl3mF7kNyXR1H8BqB5AwRmI77q+KxNiUQJc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466242; x=1773071042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5jmz51OP11F2w1N6J8Q0eekBLPergcwDQ8lUfOts2g=;
        b=cPzyQI60uOp1sS6raknHMZeXTTgtW9LkkDRLL7jfFQqoxSbgVTeC8dVRaAga1HqIav
         ZvMbPm41bhK5imM/+Gvqq7yZAVTNHJsCdDEM1h2PX7gAkaJphsnLa0rlO5tj3wGEWUk6
         oTe2UrEHHhop97l2no84QU5zpuMXU7i4IcoVWgNI/wsyWlmYEjyluPZ8L8BRPKrWBb8l
         myr0vzeRSZpzAnR5xBbeh0sGdcmSqnCXbqQTTfGxFTT+uGMqatzdcZzC9b1icRqb8aVb
         cwwd+wExCt4/PiTTsYcusRKqIQ3GqvAzO/h5MTQnL6WeYkwxG0JWQ4n1g7Z3AfiQbae8
         mXTA==
X-Gm-Message-State: AOJu0YzDBkjF4S3D1126u9DdA6+aj9r2K6bRTqgOBjeJktk8FxqMW7K/
	0jnWz9Lt3DTpIiJrd8tlWSOv8rP4KXXtPzyG9i7u84vRNSfHfN8Xk/eZde7WCg3GR7P7bNikRbe
	eyK53DIbQ0nd9+yxCp3HWQJ2P1G0yLkA91bjsCFQPZQ==
X-Gm-Gg: ATEYQzxd8lDs4c+c7S0hsquB55z+viqekYbJG5NCwHNzQFwYUx03nMt3neJn7zSymai
	o1H/438Bi0NxXYfOkZFR7VGNJIEAfHrBP21KJIL0LVLKd9a1+K1is5E9QU2xh68Tg7pn5hbLS42
	h5v5y3fxbONUV96gTfgOGXhxq5X9MS0L29um7h69bmLOIs/6tQfukI22o2/J2sYQEfTC7pGnVcX
	lvHlwboihHuaWPAz0RzxdHcBJqYKBxMvMgaOKxu98MGdOeMTnkcEGzVsGbKX3NDq2eOkpD/KP05
	rdYYSK0WeQ==
X-Received: by 2002:a05:622a:15ca:b0:506:be2c:a96e with SMTP id
 d75a77b69052e-507528c4502mr157339771cf.67.1772466242357; Mon, 02 Mar 2026
 07:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224115606.4249-2-ytohnuki@amazon.com>
In-Reply-To: <20260224115606.4249-2-ytohnuki@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 16:43:51 +0100
X-Gm-Features: AaiRm50xyOkRKWQBZRjdCFZt9afxqRbv3oGTAFQrcGtizwGYCrliNO7thtUr08g
Message-ID: <CAJfpegsvMOyTwaAB8KydKpJOT_JuhmvY=CeGk8FCgT_khdd5qg@mail.gmail.com>
Subject: Re: [PATCH] fuse: replace BUG_ON with WARN_ON and -EBUSY in fuse_ctl_fill_super
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0AB6F1DC125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78933-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 at 12:56, Yuto Ohnuki <ytohnuki@amazon.com> wrote:
>
> Replace BUG_ON(fuse_control_sb) with WARN_ON() that returns -EBUSY.
>
> Currently get_tree_single() prevents duplicate calls to
> fuse_ctl_fill_super(), making this condition unreachable in practice.
> However, BUG_ON() should not be used for conditions that can be handled
> gracefully. Use WARN_ON() to log the unexpected state instead of
> crashing.

NAK, I don't want to add complexity where it has zero benefit.

Thanks,
Miklos

