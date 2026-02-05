Return-Path: <linux-fsdevel+bounces-76481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA2BJ4XxhGnR6wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:37:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A599F6E44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC0B3011048
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E1325735;
	Thu,  5 Feb 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnXythQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA53043DC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320253; cv=pass; b=gG2xiCmlqa1W/1C7jZpo8y31qfpWw9yOeshcRfqrC54L4SSo/B0pN+4XSFly9Ur7cX7/ZfFQIGgWHz4+1NkwjjMEk3Phr4vB7vlDOF6jhXHQvrxEQuPuV6pO5l3Ss5eMZVelOv2HKNIhTT0soELOuVaCezDPfh54sd0qfrMhnFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320253; c=relaxed/simple;
	bh=vFnqJ+55Lb7PwrdMeBmY/iKA1MVwH8D1tjgvR7EzywY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqiZ7LS5qB5h6SYdJNl4ulfiqtYlB88jTHBJQ5mo1/l7jd1/2wrCW1O838C4ragoPpdPchPgiwEiOUsQS2Np7YMlivI+vWz7siNyHAIOwrha4+/1n9j7XlTkcKnf2jFnRBUWnhgBL/D51ZKufwBTjNx1mgLH1kdcKMpo9mDMNQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnXythQE; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a26ce6619so15089066d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 11:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770320252; cv=none;
        d=google.com; s=arc-20240605;
        b=bOLDu41fApXNMTPHIp1+AJS4norEeri0etov8JJ3EVOTdZRYZCSFNoB+t172zU9L06
         waEpAfXTaOBAtTXCHEJWm2MyTsV7Mbh12iZMfEBYsyWk5blICJKuc9Bma74eH3uT17uN
         kWPk1C+VIlr0GM5TlhMiYuINtSh7CumX6YtkntZsSbHarbwsceFtNImZ2KYuwN40sZrK
         ORuTd158anwT1VuiBGRmKV5BoZixU8qZMvtwuwGSPvVed2TiMPZ9ePYBFY/L72N2FK2A
         HHatslTMzJmHSNG2R6a58Unky7zQvto+VqEKpyI8o8ZkL38qhTf6sl59VK8a2fnmjvJZ
         /oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bEKNdxw7GTbO88YUuQ0c5F/KKVxdOovyiGJQg56lElE=;
        fh=ZI+OvP6/uGegF0Qj1DrkgrCsIoa1l36LJkXEdJYoamg=;
        b=ih7nkxBjhnAE+ah+NMQB6yI9NZZwRLJikEOjWAd+EAdKmvHwXaChUU1RERhT1dp2B6
         4ZaatcBr747zWPvg2sOdhbXBECHxXpagt3RDaJf+ZR6+hX9b8FvbHTj+9ErWzWbr/UN/
         my4kwIxGsKyvEMqz03GGGxQB7itL5dfgSjtdQpHwmuWo0VKTPxpNX4rPZPk8kNBHHyFt
         K8UW36SejbxVdg1FWUdN4hgaWwKUwPnm0VKdRCQ+fB/S5rPDF8XbjNaTIEc4uMbbHgtq
         DB2HdkgJMs2Uej881KYAP8v71vPe09ZhRV6YJYxWJ81O8SZhrvdDPSrRNpf8pUmTpvbE
         0FoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770320252; x=1770925052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEKNdxw7GTbO88YUuQ0c5F/KKVxdOovyiGJQg56lElE=;
        b=cnXythQEp39dWqLPuQ1IUbeKH5j7jzzDCWz0zcp3x6jAKHR4GGVjN9wOAS+kDJxBxh
         GHoht9mshMEMpAtnYL4NLn1l4w4MtAcgMkJ9lY0az98AsTiBWvXx+0BwrxkI+pBPAKmL
         OD0VfbAjqVCYjsCYhCjkVtN4pr/8QMhmYtFPsBVbagIn87tE5oGErqK7DPJZgyC0AQVd
         mJf3ip31AmcjCOy2f6fqrFu3At/vs6Q0Nkzmt6XJcEXNTdQlkf0rDTjeWPgh50WrTEwy
         tzTwy6swKM+Vr+B1fiyWyqNHetzTfgHFIxcu9CUlxDyjD7nsxF4hpmRRGrNqeBt1Aoog
         H6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770320252; x=1770925052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEKNdxw7GTbO88YUuQ0c5F/KKVxdOovyiGJQg56lElE=;
        b=rUDFgu85v5uHZnzwKjsiMWOMFlMeN6idkVIpPuIj4uGoZVwY+baSXAqhkFZQeTAlFA
         GoPNi2a+eL5BB0nkzzmgA17OcBpWzLQt+ymRXPnOytYw5C6M/CWYY0Te8de/5LAFx+IR
         CO/7JUJOJxtQWr41t+l5RQqKjdGKo7DI2sD5yLTT78PknUnBC3GyOhEZ/b2k4+EKggbC
         5EtPDTHegrz8xyecaca0sXDedpYlk9QHGaCgKScrKHngKeSVkbBEFVc0BXgQTCCkOjLY
         vJ6fXTVwMfLqNRPXOZP781oFl+eT18JWLcoerozxU51xLQhh1tqfpB47fevX+NfCJJgH
         LA+A==
X-Forwarded-Encrypted: i=1; AJvYcCVACk2F6w234NQjfmdGaZjdi4VsCJzjVX/iNxOLR3pUI7KSIIkF41doB5Sfi6E8IC0rcB6fsQAndOUTehvL@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsd/ReAqGo+SqOAeOcdXL94STnUj7vP+N95ecpdKCYPf2g4F+
	DpruromI8KRGNzed/Pcdkj0q7IWcjN2vIdTbEIhPFKDrOxh5QaGwvZrN52vATgdayGH4BbREYMT
	J8fGJLtvL0HGQZ/R/V84Ylw9AOIde40E=
X-Gm-Gg: AZuq6aK0AjAxQsGIg6Hza2DinH7+Fuu2U3FGSv9evw0GP/GLQIn4TsHmjBl9ZmAhjkv
	JcfwnfdeHCtEDvpADmDV1/o7cdg3iFG3f+tYQrPfP9q9LG8ai48nIVnjh2RhxFz2DvhOemY0HjD
	Xk7l3wB/spQGE4xJFihi4qiqQ5oYLhmdmVAvT6iZmgFg2T5hdtCbIpPl42nx7QUg1AX+q07aOqJ
	rw7V2Sa5jc+J3xpucsDj2LdaxcrQZoKJynKvgFdbXDwVIccf0p3/IoE0J8Rb7d13k72sQ==
X-Received: by 2002:ac8:5841:0:b0:501:489d:f3f9 with SMTP id
 d75a77b69052e-5063994e652mr3738671cf.43.1770320252269; Thu, 05 Feb 2026
 11:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-7-joannelkoong@gmail.com> <9c32bd42-b935-48fa-80f8-d610f4085025@bsbernd.com>
In-Reply-To: <9c32bd42-b935-48fa-80f8-d610f4085025@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Feb 2026 11:37:21 -0800
X-Gm-Features: AZwV_QgZHssLF7mj_r-dU1lHXaRtROJHSPhxgkJfLJzCTUQ1YM0tZ6aAyf_pM4Y
Message-ID: <CAJnrk1YLyCD0XEgH7vpfKSHjx3-9x_JRBqROyB5Sxwqv-ooy_w@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, 
	csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org, 
	asml.silence@gmail.com, xiaobing.li@samsung.com, safinaskar@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76481-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bsbernd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,man7.org:url]
X-Rspamd-Queue-Id: 5A599F6E44
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:52=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 1/17/26 00:30, Joanne Koong wrote:
> > Add kernel APIs to pin and unpin buffer rings, preventing userspace fro=
m
> > unregistering a buffer ring while it is pinned by the kernel.
> >
> > This provides a mechanism for kernel subsystems to safely access buffer
> > ring contents while ensuring the buffer ring remains valid. A pinned
> > buffer ring cannot be unregistered until explicitly unpinned. On the
> > userspace side, trying to unregister a pinned buffer will return -EBUSY=
.
> >
> > This is a preparatory change for upcoming fuse usage of kernel-managed
> > buffer rings. It is necessary for fuse to pin the buffer ring because
> > fuse may need to select a buffer in atomic contexts, which it can only
> > do so by using the underlying buffer list pointer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 17 +++++++++++++
> >  io_uring/kbuf.c              | 48 ++++++++++++++++++++++++++++++++++++
> >  io_uring/kbuf.h              |  5 ++++
> >  3 files changed, 70 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 375fd048c4cb..702b1903e6ee 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -84,6 +84,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct i=
o_uring_cmd *ioucmd,
> >  bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
> >                                struct io_br_sel *sel, unsigned int issu=
e_flags);
> >
> > +int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group=
,
> > +                       unsigned issue_flags, struct io_buffer_list **b=
l);
> > +int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_gro=
up,
> > +                         unsigned issue_flags);
> >  #else
> >  static inline int
> >  io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> > @@ -126,6 +130,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(str=
uct io_uring_cmd *ioucmd,
> >  {
> >       return true;
> >  }
> > +static inline int io_uring_buf_ring_pin(struct io_uring_cmd *cmd,
> > +                                     unsigned buf_group,
> > +                                     unsigned issue_flags,
> > +                                     struct io_buffer_list **bl)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +static inline int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd,
> > +                                       unsigned buf_group,
> > +                                       unsigned issue_flags)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_r=
eq tw_req)
> > diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > index d9bdb2be5f13..94ab23400721 100644
> > --- a/io_uring/kbuf.c
> > +++ b/io_uring/kbuf.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/poll.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/io_uring.h>
> > +#include <linux/io_uring/cmd.h>
> >
> >  #include <uapi/linux/io_uring.h>
> >
> > @@ -237,6 +238,51 @@ struct io_br_sel io_buffer_select(struct io_kiocb =
*req, size_t *len,
> >       return sel;
> >  }
> >
> > +int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group=
,
> > +                       unsigned issue_flags, struct io_buffer_list **b=
l)
>
> I'm just looking at the fuse part and I'm actually not sure what the
> "buf_group" parameter is. I guess it is a the buffer group set up by
> userspace? Does io-uring have some documentation like fuse has under
> Documentation/filesystems/fuse/?

Hi Bernd,

Yes, buf_group is the id of the buffer group set up by userspace. I
don't see anything documentation related for it under Documentation/,
I think the closest equivalent is the man page for the buffer
registration API in [1] where it says " bgid is the buffer group ID
associated with this ring. SQEs that select a buffer have a buffer
group associated with them in their buf_group field".

Thanks,
Joanne

[1] https://man7.org/linux/man-pages/man3/io_uring_register_buf_ring.3.html
>
>
> Thanks,
> Bernd

