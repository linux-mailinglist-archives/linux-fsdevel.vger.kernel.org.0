Return-Path: <linux-fsdevel+bounces-76703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJrgGfLUiWmBCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:37:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2710EC27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7652D3010DAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85837473E;
	Mon,  9 Feb 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ASg7GNXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAD366571
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640028; cv=pass; b=FC3ofRjOLsGhyytBuGLd0ZYrZ3CGFSf/m7LNQrMrv0EMjNLYjp2xrzhf51+WI/1GeEay+CiTceQLeENYZQvMyzSbtvQ+29dj2xvBHTS2VoUoZfqXuVUv7L7c1KoOyMUGcL09bayiBi7pNCtJNltf5EnPjp+fsGHTLx3XbvOKVjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640028; c=relaxed/simple;
	bh=jmJSIAHjW/ZE3aK860YMveWUZJCZq7MQeEOdmveoq18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osLa+gC1b6FjqMQ5fR0eW5xjfIsACo2Bc3E2k4v22bfpsrowQ20d58pEsg9tzvW1joCMihTBKtLGr2J4KKpqHT1XW5c/zO6j00/+ZtnM7kmzaVOsat+zrFS143hwNDUgH0zghdQQXaNIl8vHQEB3AlpVrSK91hQpc6VmJj/pX7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ASg7GNXk; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50335b926c2so40850851cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 04:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770640027; cv=none;
        d=google.com; s=arc-20240605;
        b=MW1kwNhgwJQ2gNum0f0Mx/AmhG5iEu4WL0hPuz7P0+mlAxW2uMBnuIaux4dYYpHAjV
         cklB06LiTFP0pqSG9LDjImZWVn7yMv3wZ08jqz813RmsIT9+ntFYr27Ev24OL4HVpouO
         dA7SGAIcb8j1ASSUhPwUwrmGILyZ+yoFt7vfFEo6ymVEq8ms1ibpQae9rLQd2YNiUa1E
         3sh1jNp3rwaxUcHEAF2G+YKWrPUu3uQjS3bscR98L9ZHaKB30+n3J0SElP4H2gapGPla
         2HroU/5pE5J8ma/gq2O8leTX/jvAAp5f8uIYqjOKBXlVBuoJIhCd89x6PGq+9onVoZfm
         Xk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0jDR9Z9XZFkuvZsBRmesOdlnfns+s15FYa5ik6TAHNs=;
        fh=9B/L/holaZ3avugmMHav+gg8zjKZdcYuTQy+pWfDpbw=;
        b=Ft8JsujNbo72Od5RelpwuMHLHOLSElP+T2xjgN3hh94JBkWzxKXggmEasAWwBXr5b4
         +zkMeOimm8Dkg3YMQKjknGk/0mSDAwzgKbHlgCLlImHYHJ9szfDa9KyX4AgO7YyXpxkG
         mFthHfpwQEhBnFEvpQEUnFA/bZdbWs6dCq2xpa3Zc08UU1FUI62Dt/e1D7bxFW5PILHY
         j8oS5QTm1jxzrUy3ikxX773oj1IKPaMW/cCJguqyuxlQTwir+SlqkgJlWmZMeEpYQc0Q
         OFwzyC4+6CzEFHQptzLogb0VYRmEJG+/+nHhjuylLAJlgr0LIzK0xdbPqeVPaVBXejRA
         vHuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770640027; x=1771244827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0jDR9Z9XZFkuvZsBRmesOdlnfns+s15FYa5ik6TAHNs=;
        b=ASg7GNXk/9yTmliatiEHtrXq+ggMYlMjdqyR5lWqNPXKJd5+mW44ERvhP0cjBQvXq8
         vrkt31wabjOgjPqNEk3+ipXeHMnPu+vd7rb4C5xHBKP9tHR4MKMQdcv4xqhXUsZnCfLx
         QI+FWEur+t0blWzmyUcNIci3laYk+tnHqfNHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640027; x=1771244827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jDR9Z9XZFkuvZsBRmesOdlnfns+s15FYa5ik6TAHNs=;
        b=vdQNVqqc57yQH86Fyc9KFGOtK+xaeVeEibgOXlqfN81KUf5fXsyuidNVGewfjR+wGu
         bgMG2YHf31I8JnnKW5bFO0RoqutM9pYqicGXl12IxWhv9bpX+QxzwZC1Wg6mC1Ycw456
         q4gr4eojWmZvWVxtemX+TQBpqQxQb7H1wapCUIV6ENMY1nzsEPWb00Rby3HBj8KdBI9A
         JtKs02SKC4wgCqtRWh5QhJBJfp0ZU5+G5+DRz0qnOnzVuXsps9AWFk6TFRdbLcRDYgN8
         U5Gae6Dc/5EPuBCIu7yolz9vYsJFGTuPf1aa8nehzF/TZrQL9ZkhtPlPt7hae0wwqiTm
         WGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWfXAS359S+o4sV9bFDx4giVbvpOtl10JzrsXwu8nkKjy1317Tqf39DXvkmJbOF3qd/XinmTzuGWsOhyBkl@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHMqj48JwUyusZpMIbSJVH8P5qiqVKBo+E8i5h5nWqLmFPCwu
	AURE4F/sNceXQx2QeSV3byCJREELucZe5vQNCHgEuoKX3Z/sx+mD6NCgiComczqNsklpevKmm7+
	B1tTKpdmiURTb4IUeukU8R5jQC6cJHRear7iSisi+Ug==
X-Gm-Gg: AZuq6aJZ/edU5Ccp0tU/mC3EqoOnn1A2912VQXgEUD6BYw5OJfpPiCkjgQtyK6K0e6o
	GMwRlRYX20vpvKwEOrZ4PFg7e7cvwMdJgXaGcbJWU6JcK5hzmzqYyxEwjToTZJa7/iCGfx5a34v
	1rxcQ1ACS7xDDrFISKiY8yiPn2ytcXjmpwF98ulgh+ENI1SxArNgLFI+CnLsP/YWf84nVL8xDbE
	9EB5MHjUaovgMeDxNelfJ8hTMSar0UN1pN9vzwzbMHDjn78l3BCsKOTl1GETHDlD4pvNw==
X-Received: by 2002:a05:622a:13ca:b0:501:147a:a215 with SMTP id
 d75a77b69052e-506399af94emr141986801cf.73.1770640026918; Mon, 09 Feb 2026
 04:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
 <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
In-Reply-To: <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 9 Feb 2026 13:26:54 +0100
X-Gm-Features: AZwV_QjlWYoFVM5VksJebwYdDgN2oeT-5JhqsKgKntThwhk0fQay5xVYrVKDbIE
Message-ID: <CAJfpegvjEzu_mgDaKgNQcnpES8vNu0d+UniS65UFQMsKcaH55w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] xattr caching
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	Linux NFS list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76703-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: B3E2710EC27
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 at 12:28, Jan Kara <jack@suse.cz> wrote:

> As you write below, accessing xattrs is relatively rare.

I was referring to large xattrs.   Small (<1k) sized xattrs are quite
common I think.

> Also frequently
> accessed information stored in xattrs (such as ACLs) are generally cached
> in the layer handling them.

Yes, that's true of most system.* xattrs.  But user (and trusted)
xattrs are generally not cached.

> Finally, e.g. ext4 ends up caching xattrs in
> the buffer cache / page cache as any other metadata. So I guess the
> practical gains from such layer won't be generally big?

For network fs and userspace fs caching would be a clear win.,

For local fs I guess it depends on a number of factors.  I'll do an
xattr benchmark.

> As I wrote above, I'm just not sure about the load that would measurably
> benefit from this. Otherwise it sounds as a fine idea.

I'm not saying all fs should be converted.  But NFS already has an
xattr cache, and fuse definitely would benefit from one, while tmpfs
"lives in the cache".  So there'd be at least three users and possibly
more.

Thanks,
Miklos

