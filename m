Return-Path: <linux-fsdevel+bounces-78463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDZdK+0goGkDfwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:31:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1097F1A446A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD5F1308822C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4523A7F54;
	Thu, 26 Feb 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PLELvequ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E53316190
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101798; cv=pass; b=Sv3EVywCXggju6uZVeP3nIS7rqMujelRTR7FilAttyLt0k3lcGCQaTuxfqHvpyGJeLip9zuXeeg2wMYJGYE423a0of1ZeR0enK/35iuakenpyXsZuC/PKajmA5z0uQf1ONGNzhSr/+FHRiXo8VoESXoWsm/jrbarFEKNdHWFwzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101798; c=relaxed/simple;
	bh=hjsN5//5jsVAZeRSuT5WNNeYNRaiZIQYQtWlnsr+Z6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvqOCUBCjTVvf8WTl9c/e9vRZ9baLiAw7WjtYu/PpQoAyedkqAYIZ5w12WX/ak7zF7/0gwIT6Z6Q7niIq48JrWCR3ecxIZibLu+zkSxKVzbHfUacz0vC9YnpWtC9/rZB57ylngIkx35aF6oUmGR64QpIRSGfs7J6vbjxNlfI6XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PLELvequ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506c02ec1b3so8329271cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:29:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772101794; cv=none;
        d=google.com; s=arc-20240605;
        b=NTcHpcUmDEjV/sUAc73xvx7/fah0uleFN+sy5/Kge1F+y3oYIaiAUauBRc8kBFWhJg
         v71gZk5IRxIpEr6Z12cHXlVTNrNZrGNQ3p+Ii/U7ZiyKNgPkuHfsKH/hYwIMdamOOsR5
         GAi5pKbXH27gs+0HBDGVU29n2xJR23UYxcWjTMlfE/VbrCKmXQPVpy028ylKPLpZS2Pz
         BSCz5KCe4MqEVmv6dwXERaM2BNAzuvo0f198aJxIRt2J31p5npO25UVI1vpLLntHaspR
         G4p8Xh5yDDMQEloawiEQhtCR1udL5fgvL89u2+EtHwWNpAnM0CstI8rcf3ZWejzO8mNs
         JPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rzYc//p4H41oTH8p4tNC0vhAA0rjUA0WVHYr2lMVuzM=;
        fh=7ehCKw/yM9k+pxQJ4h/Vo0Rjo+7Kct7m1lSNs2GZbVA=;
        b=BHBKvFhsAGvqquORL3M6iYsS/MdH22lI9HEMJteVHx5X4PpdU0q2PGD5dkeOYExLJU
         /avvFU6oBGjllWLefikTLYZaOQsBIjCuwK8UWwVURk9Pe0yHEChvErRmBpSXeKJHKUSQ
         Fev2dyjVTayjlJjfb1B5kL4IkY32u2kWy00rPoYjZrLu3IcDdBALOd0jsF5hhZZI5VTI
         2DAP9DPrE7P+EvnBS2JMstEXIoIAOdJJaVjEXSs4TXrjSw6NlMi7cBpgkyyEttPNVa/c
         KUdc1doma/fsG2JjaN5on2zcnE4VFaD0i/O3RXWFpKH3E+/ZzzJYANWKyQKp8fBF9HHB
         aV4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772101794; x=1772706594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzYc//p4H41oTH8p4tNC0vhAA0rjUA0WVHYr2lMVuzM=;
        b=PLELvequ1kGcS/osnxh4OGGbbI70qTmBlf273FZCykrBbdd5oLX7hKTxnsY7FoMgGd
         EQtrgHVVmJT3WbbzvL41NnNtR9uOB+BzjSk6dtPj8TSXIl78XbP2ufx5vb6Wwe50SWnG
         T3bGKTUVDLAyz9NxvN2vE3axTe7NDKtjN2PGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772101794; x=1772706594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzYc//p4H41oTH8p4tNC0vhAA0rjUA0WVHYr2lMVuzM=;
        b=rmLM5pS+KQO6/CAT2M/oCMm+tMkhg5YguZGGHpY8CucU5r7qR9hMisb52Qzzo8jbiz
         YXsDPIR+GVjgQ0Oy9MWapmQ9IGswA8qdfVepH939OCsNbDUWvsAu3+9YIT3fVn/aKd57
         pGe8OQWtKMbb8fd+EFCx8YFANBhJeFJDmjwnGqF0Hxq1WTONoO6SJR4g5ST3HUsRfoPT
         Qyuoh1irSfLv6lNiCPKW+6U719Op4vnAFW6g9TRIg3slxnYQ7Ex7jMMdv75NCT4f4dNU
         1fLP+5tNd5iKFn2uWyIuMqnhrPT/KCQTxmO8vNCvAqJRgW0xZhMvbTDW6dfUM5Zfs+GW
         JlZg==
X-Forwarded-Encrypted: i=1; AJvYcCV+5f9f48Fp7pOa0GyY4iIkddRGfIn69JVE3lQ66yrB8E5yZN5DXfbsF89fhv+xX0Ojvmsqc/fkwzzvrZCI@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZCXyT0yqpqYWolhnZFu9BGPh+Q0delgSPgwIw4oZ01PD30n/
	LuuuYMuioPLUHmLOYXZEotH6CeiuoVC6qfpC0tuFatOVM1Wjk0JMEqzqLWO2AABL0aDK6nbvw54
	BsWZB2fhWQLejoPjCb5eYX1fwmxEP8SRzyBiINhK26Q==
X-Gm-Gg: ATEYQzyZYCjGqlIxqwAs5r4+k/Jl6wMpdJDt8mLzYGKSem4iCUGEByd6m3iYRSqp/RG
	HzSh/BB3kYeBSoitS8QS3THDz6il0zdi8T2JazOfMC+ohvSxzXWa8ZW+HwyTTW/0Le4OPTNY+KZ
	/EIlVeNkZKlTQ9n3IpLrhtpKsiyZeTCuEnkHoznRsyuTIdUaRV0vOjpzvqCZwsZdx0RGoZ219qD
	qZ63AKiSd543Uu+0oUFSxQhkQMGwv6neelHHObiQ+jKudt5bTC2Iok8Vg39YgmAkCssdFW4tNwK
	eskVPA==
X-Received: by 2002:a05:622a:1348:b0:4f1:c1fe:ba3d with SMTP id
 d75a77b69052e-5074433f0fdmr28518441cf.7.1772101793679; Thu, 26 Feb 2026
 02:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
 <87zf4v7rte.fsf@wotan.olymp> <CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Feb 2026 11:29:42 +0100
X-Gm-Features: AaiRm50Ulg_iMjnkrAypdNuMWdG_oVdUjateStJKADh1WLijKmsSpl4CeCOLAO4
Message-ID: <CAJfpegspUg_e9W7k5W7+eJxJscvtiCq5Hvt6CTDVCbijqP0HyA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78463-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[igalia.com,ddn.com,bsbernd.com,kernel.org,gmail.com,vger.kernel.org,jumptrading.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 1097F1A446A
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 11:08, Amir Goldstein <amir73il@gmail.com> wrote:

> file handle on stack only makes sense for small pre allocated size.
> If the server has full control over handle size, then that is not relevant.

I thought the point was that the file handle is available in
fi->handle and doesn't need to be allocated/copied.   Instead
extensions could be done with an argument vector, like this:

--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -326,6 +326,12 @@ struct fuse_folio_desc {
        unsigned int offset;
 };

+struct fuse_ext_arg {
+       u32 type;
+       u32 size;
+       const void *value;
+};
+
 struct fuse_args {
        uint64_t nodeid;
        uint32_t opcode;
@@ -346,6 +352,7 @@ struct fuse_args {
        bool is_pinned:1;
        bool invalidate_vmap:1;
        struct fuse_in_arg in_args[4];
+       struct fuse_ext_arg ext_args[2];
        struct fuse_arg out_args[2];
        void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
        /* Used for kvec iter backed by vmalloc address */

Thanks,
Miklos

