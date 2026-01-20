Return-Path: <linux-fsdevel+bounces-74687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMScDiqvb2lBGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:36:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D112B47B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06F28804E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EFD43C05E;
	Tue, 20 Jan 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7OV7Cq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193E436374
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923819; cv=pass; b=XxfDzIhxoJdK585WD4cL1r4YR/OHdp7nh+fiUrpE/ig0u/d7ZdBHkf+6ElX154VkOmT8WaupddqHH+9AKB04iGEa5RAuhdqwqpGAiLvsur/JRZOuwcXK1+aPc1CU45SNC7b1gbzHzaRAUmuc2WFNG6b37v8OcAVEGkyvbq46JeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923819; c=relaxed/simple;
	bh=TNuwznjYBwdyNdNPVK+an91iow43835amtDXjy/8naY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WffFbJ0iPlQgVglsOGWu4FsKuc7YDQUbk28O3aeCGPBdK+8hW1/blK7Iizf+2motKLkK05WI3rQcm6gppPc2/dAPeHG9ldVxG8wqQUsAvf+MzW0ugbop57XKjK3kyVg9RCwdFFBK/+t1OJQJSR3NrX6YEXQDmCAJbLl4a/5otjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7OV7Cq0; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b87124c6295so762790966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768923816; cv=none;
        d=google.com; s=arc-20240605;
        b=dwxySkdNWmauUWVSuBlpjwYNi7JA6ruGmxP36a89M73JyrsfoZwP2WomO1ezKTTFTk
         TgMYxgsoxfqZhmfe+58sF2mBh6L22Vy5oCJEbIEm1rNE5JnkBbEBrqq6L7Tl7TyFbqLt
         X8//ZgVX83cJZutPxLI4BQaslmdN2Os7FmJCf7tsmJENmCpkGuKHFW44PkazdWC+eSWY
         anrcCvypMH5+vJwOLq0allTo7l7daBFHqPF7B+CKKqvwhwoYHe5eHNRwK/nc8mCPtloW
         mFoQryr41cG7A5lwXJybfN3AwDp6y0gpG7YwqdgV/blkR0t8oZ8WG8KdJ7RpjTE1ZPTl
         Y5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNuwznjYBwdyNdNPVK+an91iow43835amtDXjy/8naY=;
        fh=0U0878Fl8/fFdIont3iCxsjY3tfSQBQQNoyEcwyuxAk=;
        b=Z6EKqxv5IEaD9XFrBlv1fPeWJjfR0sdqOIj+sNmqXh4l0zVCIRlLjFgXXwK+SzNFZZ
         LWSs8hr8Z65XSNKR3gP5fcnR9C+pVMkBdFDfP2+JhxiSQ+Guy5EHv7slpiR0kR5PFK9W
         fRbYSatPXwtnqjz/GKV/sdqHHiLuAVwfRb88q4NLbS66LeVHevROgXoLjCmHb7J/6IN0
         pIwixf+/pT05w6WnXahsnMVR8vxVM4dxncrp+lTGYvoHEOTECwVgdzVCSvXm+UcL2x2g
         Htx9fKNPMf3jlIwOf3dr954wrAE2uAhvfAYfWnqiqlWCMNDrTaqZCigtOUBcYb9WDhmB
         AqSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768923816; x=1769528616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNuwznjYBwdyNdNPVK+an91iow43835amtDXjy/8naY=;
        b=L7OV7Cq0EZIOseMkmGQUhAUUoQSk+tIKaxPHM4n0xUB29Xxeru+gazGaVon8BJaht2
         hC2i9bv5us3x5xDE7sxsUOW3t+hZ9OvrRW0Wp1gum6ywkaDtpCEjqcJv1JexetvxCn0d
         jJPStoDmYQeIqpql2rSg/9f/LXPuVyV96AMKWxXFt01pjBA1lnu4zIsa64LXhBBPInW0
         xTJgGvC7vblSuvtxzQXIADleu7Ma2GzE5VGVPA2kYOa0iv4Baj/nwjlkCVLvDhyKi5H9
         wbK9WcQxN3eCPOP5GAxMpUd6uwXQT1GrYBfC02wmwAF4R8tEgDAmfg9X8K0cWhuWzPbB
         b8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923816; x=1769528616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNuwznjYBwdyNdNPVK+an91iow43835amtDXjy/8naY=;
        b=byAayMuVElc8qcpDdjBXSihrnDM0YvfSo3Ze/nQHZUG/JNfDy5DAb0HSwlPYmFmZ+Z
         h8NYuottL1BmzG00fAcOBCW+EA7jZDok09eJ7khs/8N+tnvjVdf72BDpudBvEzkDihke
         9YE5AK09tcEXlBtGGo/PWtUYDKLJ3mxzR72SbdKFTC+eqiZiuACUjfikXkxpedirtNvi
         zhf4CndO6L5LQNq6IcLQTT4xqx2htnYNe+A75E6Y8cFTDE1h5UI8jcIh19HAWAOosXpt
         WKWuIYDMD30QuqcQIWw8qeW/8WpMcPBZuBjb0JxcCv+OMnnZxd0qSpTTyc0nyndowG8m
         bgvA==
X-Forwarded-Encrypted: i=1; AJvYcCWDe2EMXcok9SjQvxRloZMLr+QY9hT93XQO+s9sQ9HO0lxFnX+bCAciSOsJtT754GIgh9heXozKKsZoGoio@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrdRQWXG38Au1bp9+ySPn5jzpIJS2L+K5BeWVN/XQ6UOwuQ0l
	FhXSQRVWgj2hpzmkVNGa3nbhHwiOWTGXuEIs23ETaF1PeP14d7QuqU3jCSDW0S5xfe5qkaFqqpj
	7oAodZSAFXdTmvTi3Y8Jou+f0KnQMM/Q=
X-Gm-Gg: AZuq6aKukjZDIZ6nI6aC1aJSiw87dY5au/7mYQah5RT6GGPxCAFgHckuekZKGuMpAfq
	ylMrR5wIfWz0arPbtjTUPcEq0tWSVFxA+m4NWyhkfEXBoAYyddddot1FwOXo4Yp9iZVZERRvwDk
	GBOOdLrK6vhLTxELVbjB6+dvuw1RSdPtrRp/eVjLDXW1OlOlIc3kd9Yqhb1djpr2zFsrNc1h/sr
	bfRdhNKPxtWYce61eLRyQOaooCtWPV/MdUPbFPVoHWkqTqq4F2msI1lb7bkM8XAjkupFjxbJjSC
	g/SurhgksS+H331dSFBaY1vgGHs=
X-Received: by 2002:a17:907:7b9a:b0:b87:115:a724 with SMTP id
 a640c23a62f3a-b879324398bmr1338776566b.34.1768923815697; Tue, 20 Jan 2026
 07:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
In-Reply-To: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 20 Jan 2026 16:43:23 +0100
X-Gm-Features: AZwV_QhuW3Imd9gW4DvPyCgMoHO_4lsh_rTPkooqGBlVpaWOz0bA6GKNfxlNkS4
Message-ID: <CAGudoHFuhbkJ+8iA92LYPmphBboJB7sxxC2L7A8OtBXA22UXzA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74687-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D112B47B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 3:52=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Mateusz reported performance penalties [1] during task creation because
> pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> rhashtable to have separate fine-grained locking and to decouple from
> pidmap_lock moving all heavy manipulations outside of it.
>

FYI I have a WIP patch to address the cgroup problem. With that thing
in place the pidmap lock is back at the top of the profile, finally
followed by tasklist_lock.

After I sort that out, with pidmap lock back on top I'll implement the
lockless allocation scheme.

