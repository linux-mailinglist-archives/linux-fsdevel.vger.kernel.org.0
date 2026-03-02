Return-Path: <linux-fsdevel+bounces-78954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAQ5C9TdpWkvHgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:58:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CE1DE86D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A0330776A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718213382DC;
	Mon,  2 Mar 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj9a6+cA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DA352FBA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477788; cv=pass; b=V+eUblkc/KC65SIQDooc7CvDgT8CxwtJbzx248HjmwtNMZ8usV8paFAcLpok6Aj5Ow+9o3ykZfv1/zrLY5qP42QvuVisfZ54SjLU2xSeUFrZ3OBx+9CKkvxN3USNdFML3lPd8XNFAlGfBcDOblvRi5Cihqe4lAEHgYyLBmqOxPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477788; c=relaxed/simple;
	bh=8fr4INm59soVJXMZYq4tEiPCbdWuEDQzSa7zWhpSznw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXxLGSMg1Eq7LXoyuzpd6hFX1pSHXBTl3tQDw2EDdy8u5Pjhkl7NFpdLpUWAEEyzZtP8CtVMN65nUg7SKdkrny/IA0nagBpwoa3MNmW/n1UvEa9LOqHFSlkxUzTuzKsStDQODUtrtm5PFVisR9n6qCMoBygLY4IxYzwvs4weajI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj9a6+cA; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-503347dea84so54640311cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 10:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772477786; cv=none;
        d=google.com; s=arc-20240605;
        b=bRLcGomavSB8ozAtZo4D/F/xVwBMc1D3UJj0iaa2fjplHpkxNxDtT4asVK9ahKeAto
         VVnHazjQ35HHrEElnJMBnOgtXSWxDr70LDSpY2P51A7ULgyc0gKhQ8Sh8HovZfl89jWC
         B84s26fX3UnIrBQpIb4RP+JwRPsODcqpBwLf2ZaVXtKOjF9AfnOQ89gAfYRr3QHDiWmv
         DtNdQQLFhej/MwrglpV6Ee9mGFAA6CTyYBQJBu9pis2ZQDcVh1nzlRu4U5szrnkINR6Y
         u1zYf56ZFk1qgOLT9cEprkmsIiuy6JcY5FpbDtrYYk5dpi5pci2s7ZWC1IAVUYiAGqeR
         tvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8fHH5DyF872uVGh2NNo+m/l4T7JuRj9DPqyoy7Zp9M=;
        fh=QT2t8xuv3/SGBMl1+87lN3y5KWWZ3ceddTAjk9+HCAE=;
        b=IneXjriJkdJIDbhdkElvDifWj2CSe+IC+ENCCEANcXP7WglBn34TU79GTUHLVp99Ho
         4Pd11ds6IUZJXtoBflIZzfG5DTsDpofRdY0kTPGj6SGvy2zFVN0uHOSPFG0EDivtFKlj
         ggIpQQK0ESKufNTFR+/tPE7/TkzebKFawV3xCCs0455h1uc1uhBfnseeWxey5eFOOCYd
         7sy5n36r3NLM8HI9MfBjqrWMns+mxqfjBs5XEyodq24sApVyB00HdDFFu2FSBG0u5ott
         30uehCbBOl/BM/q3EYD5gE9h6u2S0C9aBbt6eI08OztSwVCimGCOu+4wIEQVBGxa5cEy
         l8tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477786; x=1773082586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8fHH5DyF872uVGh2NNo+m/l4T7JuRj9DPqyoy7Zp9M=;
        b=Sj9a6+cANFSes3ygBvswK63+topvq65fRseJALIg9tHX2YcqE1Czdn4i5DnNUcthar
         z9NcyxmdVPctEWsXoc1oA3YpbISEoTMVNRDhVLY1F/sM+RfcU3LN6lgXOKiIPUgDrsXH
         PBi1GXmz+N3kNkD8I9Co81daa0FQ/4CWTK+shKk73Xq7Lj/tIWjy05qD1web1b2Dz4gp
         M0ynmuWklfFbhxxlkUzaw7RDskpQY/0WTQ3Bq/NhgbY9gLCMq3S0v2WwcgKKnpTC6t7P
         Vdg61AiFB41YAjhWsrSe28vbQ32oiIVCYAL2ZrJi+3T8m3QF1LFTGQt6BGHQ5jFG9u5v
         G8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477786; x=1773082586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8fHH5DyF872uVGh2NNo+m/l4T7JuRj9DPqyoy7Zp9M=;
        b=xL0EJiD1S2eKdClSkgAJuFnf8EwlJfeWIJWXtXfh7MHsCe2wugHhT2SWPYs/ciG25N
         q0ViLzUBX8vvaviRiqLYL9uJJ7L0PLucdNigGxGBCBRGX0iiQLJn0eCgvQjWuEU0Y/W7
         15UhBILp/L1RdVC2q5DErIefKWsJiqheSihC8JOzqTCuuqymMG2idQ0yGtHsI3hw4vMM
         eme7GnWCMevr0PJJSPC1TV1L5YNtzi18A0eSDAiJGAK/YaMMmP3vtipg+vggoUBPwl6Z
         MCtbs3TeQlRZ6at3C64/O7Y/id+ar5DJG/PqJVCfGkK/H+VLDwUapevccV+IeED1Bd2t
         JrWg==
X-Forwarded-Encrypted: i=1; AJvYcCU1luIIeYdoLxD8ifPhSEzeB4DtoP657shtMpdeLDm5rHTPTin4bxlr4Mu4ykToTlbBKdH95WiTi4IxSzgo@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVXNwE1rPA78Jkd/ji5eCa7ZYJaEGu+YGwSUs7UedpFSsO1Af
	0q18wFsRRghP9TjjQ7B8AN/qKr1o/Me0tbzQbbzggo0pSohH4cvsGrLotEJcX/UaEv8EGQZMrVm
	DJcDc9Zm0dqSm9KYWZ5Ek0FscjP67Tig=
X-Gm-Gg: ATEYQzwECuARMIIvCOrHudd9yoPniBbozt6HsmkHworLYJkfUivDbqoiPiGojAhro/U
	imSwy0/Vkk7VFy7/GqFIRs+3HtajSJpnl6WgGuwUKqdfy2CGSgg0R5Eh3tHvQRLWzNv4KV3QC+X
	FyGwzQ3t2kydAN3eMj6IjYPAa9Xs4VlWDjzZqKR0L0JVQN0MFU3q+ibDp9apkbeKMi5sbEsEmSQ
	87Herwl1D+WJ7Z2UMvavJs/kogCUGRAJFr7kwRqLUG83WHtzMVQqcjGyvoD7J7NtdmcOTudrJAd
	mNdSAg==
X-Received: by 2002:a05:622a:148b:b0:4f1:ac12:b01b with SMTP id
 d75a77b69052e-5075284a74dmr190049091cf.38.1772477785564; Mon, 02 Mar 2026
 10:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com> <aaKiWhdfLqF0qI3w@fedora.fritz.box>
In-Reply-To: <aaKiWhdfLqF0qI3w@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Mar 2026 10:56:14 -0800
X-Gm-Features: AaiRm50vERCGtiuMWuMPZjCW6HmoF_ZA406YZwxgiJgISH0mCxqHjf0L6H1wISI
Message-ID: <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 984CE1DE86D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78954-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,birthelmer.de:email,ddn.com:email]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:14=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Fri, Feb 27, 2026 at 10:07:20AM -0800, Joanne Koong wrote:
> > On Fri, Feb 27, 2026 at 9:51=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Thu, Feb 26, 2026 at 11:48=E2=80=AFPM Horst Birthelmer <horst@birt=
helmer.de> wrote:
> > > >
> > > > On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> > > > > On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Horst Birthelmer <horst@b=
irthelmer.com> wrote:
> > > > > >
> > > > > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > > >
> > > > > > The discussion about compound commands in fuse was
> > > > > > started over an argument to add a new operation that
> > > > > > will open a file and return its attributes in the same operatio=
n.
> > > > > >
> > > > > > Here is a demonstration of that use case with compound commands=
.
> > > > > >
> > > > > > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > > > ---
> > > > > >  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++=
++++++++--------
> > > > > >  fs/fuse/fuse_i.h |   4 +-
> > > > > >  fs/fuse/ioctl.c  |   2 +-
> > > > > >  3 files changed, 99 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > > index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc=
393241bdf727e00a2bc714f35 100644
> > > > > > --- a/fs/fuse/file.c
> > > > > > +++ b/fs/fuse/file.c
> > > > > >  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 no=
deid,
> > > > > > -                                unsigned int open_flags, bool =
isdir)
> > > > > > +                               struct inode *inode,
> > > > >
> > > > > As I understand it, now every open() is a opengetattr() (except f=
or
> > > > > the ioctl path) but is this the desired behavior? for example if =
there
> > > > > was a previous FUSE_LOOKUP that was just done, doesn't this mean
> > > > > there's no getattr that's needed since the lookup refreshed the a=
ttrs?
> > > > > or if the server has reasonable entry_valid and attr_valid timeou=
ts,
> > > > > multiple opens() of the same file would only need to send FUSE_OP=
EN
> > > > > and not the FUSE_GETATTR, no?
> > > >
> > > > So your concern is, that we send too many requests?
> > > > If the fuse server implwments the compound that is not the case.
> > > >
> > >
> > > My concern is that we're adding unnecessary overhead for every open
> > > when in most cases, the attributes are already uptodate. I don't thin=
k
> > > we can assume that the server always has attributes locally cached, s=
o
> > > imo the extra getattr is nontrivial (eg might require having to
> > > stat()).
> >
> > Looking at where the attribute valid time gets set... it looks like
> > this gets stored in fi->i_time (as per
> > fuse_change_attributes_common()), so maybe it's better to only send
> > the compound open+getattr if time_before64(fi->i_time,
> > get_jiffies_64()) is true, otherwise only the open is needed. This
> > doesn't solve the O_APPEND data corruption bug seen in [1] but imo
> > this would be a more preferable way of doing it.
> >
> Don't take this as an objection. I'm looking for arguments, since my defe=
nse
> was always the line I used above (if the fuse server implements the compo=
und,
> it's one call).

The overhead for the server to fetch the attributes may be nontrivial
(eg may require stat()). I really don't think we can assume the data
is locally cached somewhere. Why always compound the getattr to the
open instead of only compounding the getattr when the attributes are
actually invalid?

But maybe I'm wrong here and this is the preferable way of doing it.
Miklos, could you provide your input on this?

>
> What made you change your mind from avoiding the data corruption to worry
> about the number of stat calls done? Since you were the one reporting the
> issue and even providing a fix.

imo I think the O_APPEND fix should be something like:

if ((open_flags & O_APPEND) || time_before64(fi->i_time, get_jiffies_64()))
   send FUSE_OPEN + FUSE_GETATTR compound
else
   send FUSE_OPEN only

since the O_APPEND case specifically needs accurate file size for the
append offset.

Thanks,
Joanne

>
> ATM I would rather have data consistency than fewer requests during open.
>
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20240813212149.1909627-1-joan=
nelkoong@gmail.com/
> >
> > >
> > > Thanks,
> > > Joanne
> >

