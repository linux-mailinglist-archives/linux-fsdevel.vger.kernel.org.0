Return-Path: <linux-fsdevel+bounces-79079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDmoChgHpmkzJAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:54:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9428B1E4421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B651A31D69F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4138375F76;
	Mon,  2 Mar 2026 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Y/Zqtb2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270093750A0
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486916; cv=pass; b=cGgb6q6KCgtODjF9dIeFR2GmlpPn8SNwqZXYB257oMnk55EcNVLGTgg3iq4Qm58PJPQkBDiWPuQq1oOZcH6HX3+Ocz5/os6hHBPGHPXYyuZLQ0aPsW2ciM5/MT0Soqq7xnkhM+2iiuEmVjNGTjHgLBEo8m/Hc/CfIAJa+NGgCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486916; c=relaxed/simple;
	bh=TWXIfliD4HePeuAkL1QceXfZ47727zMyGVbatTCgV2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edw/G3EAdHy4beCEz8EQI9SX35f+QMqw37JXFA8TGGfANuB/ZV6CbltceEY7nv9Kb6ndE4hzoVDyNwXOjXuuS4k1zVIdp/YRSCxs75dy/ZRTZvJGIQQ7QExrmF90o5w+wufGHEl+xXlWi8uwzgMbhfLe9HionDKnqBlbolL4P9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Y/Zqtb2V; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5033387c80aso74843291cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 13:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772486914; cv=none;
        d=google.com; s=arc-20240605;
        b=D55SklMBlcFc7A28nXpiTwGtZbgul/1jfHLxI5rnJPucYKNePlEjrdfYFdoIo8x6qf
         HgCTyRsjSfrMMRidQFzDqjNIdUGTjgFC4uvqdY5iX2Wi5HUtNgQmIIACKf0FtzHZfjBF
         DMarjunmm11Z0D4gm9xybSFwZmxEa/1NcyIUYd7MujF/WOAvH6Se+upmORlFhNv21OBZ
         0J0L0Mrg3XOeIgWuh7paLd9WceaQXrWw3CHptE9s4pR9k0m9Wb3f+q/eL//zPWasXLUr
         tlQYu/K9QUzrRbANgDoM6XRcuhOdj7QflBnVrtkTRPfcQ9YAfyIFNR8xZp3X+fGahSUz
         g2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uGBvMb5jButFNK2bC4L9h/sjzQwoy7Gigwuik/d7Ygw=;
        fh=SVnuInzCVpD/W/Gl5emHUYTU1B22vFAu8BRsmxv4+tY=;
        b=WNktmhn7kXnZon602+E+9cHBPM6nS/5TKj/61+w3IE7pGXbA6js0MLfEGmKhPT7ipV
         G31lFTy+SaS0Wc424Nz+Xo5c/+Xc7bZf5HN9l46s9uMa2kPF4F5e1zyk08rKbzsOtfn3
         C5ppXSCVd+UDSvqiQulIRW18FL5FqCKbq07OLxQjeOZqCFba89nlQ5OVOop23bt0eSbS
         gExTgTldGLanT/ws3oDQT+9YfSuQiK/ZMDifhB8qDJJlMWNMSbVUpdxqkUDy7h8FXtWl
         BEQ5cKgqeD96g/gHkasSoAboeO+HpT6kSMsAft3RdXdArS7YwZlznCi22RwraP07DGfj
         YtCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772486914; x=1773091714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGBvMb5jButFNK2bC4L9h/sjzQwoy7Gigwuik/d7Ygw=;
        b=Y/Zqtb2V+S5Z848qrtn9QU2CUrksQT6FNxbESMHvJmCZSFsh4CX5AHzQTGzrlfZvGk
         GZpVO0vJ3RnsHXJN9uMJ9cH8NkbNV9jZHri0exrHb3GFGWyuDrqbEb8XB345SzAxoyLj
         4r6bMRzq/SIyHQuq78uoNYbtL9UKMKH//UCV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772486914; x=1773091714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGBvMb5jButFNK2bC4L9h/sjzQwoy7Gigwuik/d7Ygw=;
        b=OSImne2HFoK3RkJ++lx6RlyCjgB1XshH5P2ITAmjsRFoqNsQnpz3DzvIPHHSI4E4eB
         zE5ZQCdwokBrjS6sMmfYf55zeBQZhvSaTVt20+GT3kFuSmGcRvlP2XPvtWX6ottEpn2w
         mHHFjHRvnXfdEZtXXrjdE05BvDJOop6mapOBRH9fLoLhoBJTF4J3UdKZCRcuPeITw1Ye
         vEUj4JCpVZaUSjlvh69Xxu1UE3RD5oeZRqUD1BttOGK/eSpgPPSErGNjtUCeMCbJEIcM
         7zSdiLcinjfFo1lRW/7+ygAswPrG/s0ci/15oZfeiWpZqgjKwHek6lDbwKwdv1FBBuRb
         xQWw==
X-Forwarded-Encrypted: i=1; AJvYcCXdFS5W008xA9Q0E36de57/hTBeZTQQuOvuUrWf65r8Mo/PHuzlldNkgNU0Keh0cNhcjOBXukOrZWyokDMP@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHcEHtxOGBrhvS2eKKn/qC1DyyngZavyyJBKRXEaAmCuFG54s
	o9uPN1Lt/1DGLkgkzasxMZGZSUPcti5ObTVjSyF3kcoj/tPDXYQbupRDcmYZvA4vsstQjQDZtNJ
	JRrufevpIlRn5S3PiHD9MsYcNvex7F0kJZ5Eaj2E4iIbslTJHsdIZ
X-Gm-Gg: ATEYQzxK/0h5t/u2f1nJHriDalXi1qSC9iMbj5x9VV4w/WK7XWuRIBg8PHOINc+8C3M
	gIC/wN8CGWEvBvpieOVR3ipmD5xjvy/uX8EhBXrtsGRaSJQT5EGjQU71aRNMFY6vpyXfpSw/bai
	YWhi0qJWu2VAPNyHiEKZJSp975KbChUVZuzbglq1bAIKaKTWu/sAh2cNf4mYppJ1FjBg1FZrCid
	lIrwyAqfKXhZLozv3/YDQISYNhTyPpwhWUAC9bfZRSsS2bk5/JQGRvNmc9kjbgT6WsZel8Xo1tU
	LfV8/xacvQ==
X-Received: by 2002:ac8:5846:0:b0:4ee:210d:32d0 with SMTP id
 d75a77b69052e-507524890bdmr171145651cf.37.1772486914047; Mon, 02 Mar 2026
 13:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
 <CAJfpegtS+rX37qLVPW+Ciso_+yqjTqGKNnvSacpd7HdniGXjAQ@mail.gmail.com>
 <f7903a99-c8c3-4dd6-8ec4-a1b1da8f20e0@bsbernd.com> <e57c91ac-09b1-4e28-9a92-d721dc314dfd@bsbernd.com>
In-Reply-To: <e57c91ac-09b1-4e28-9a92-d721dc314dfd@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 22:28:23 +0100
X-Gm-Features: AaiRm530cBGHQZ9sRgPMBrocF6m3f7SNns-kGC_7NxxigZEhyDsSz1KNl1N0wMU
Message-ID: <CAJfpegs1CRoLu3vnxqheZrOgv=cE-p3cYdRv+BqFkxy_rqsgOQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, linux-kernel@vger.kernel.org, Cheng Ding <cding@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9428B1E4421
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79079-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bsbernd.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,szeredi.hu:dkim]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 22:20, Bernd Schubert <bernd@bsbernd.com> wrote:

> Hmm, maybe in the short term maybe the better solution is to update the
> patch (not posted to the list) that Cheng made and to use
> i_sb->s_dio_done_wq similar to what iomap_dio_bio_end_io() does.

Sure.  Thanks for the heads up.

Miklos

