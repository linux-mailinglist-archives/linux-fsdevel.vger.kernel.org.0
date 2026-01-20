Return-Path: <linux-fsdevel+bounces-74623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ8jHhcpcGmyWwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:17:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49B4EF44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1E9B664A70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86242669B;
	Tue, 20 Jan 2026 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJZ18D4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017D426D3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910808; cv=pass; b=NrssSvSxAa56h3xWcAzk6PFwddB6gS8ZE9/7+8k82t/gRy6Dl6F+QkLU6hWDlxqPzqSPU1S8qrnunyPnjdNwIGfX9nu6h1gPEDzOQ/nPRwCi+UsapoQv5Vns+IrlFZpRO6bYkhKwV7liy3TDqWtFum0bzFA1PxP416sgPxGnLXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910808; c=relaxed/simple;
	bh=3Vox8sUqdvyMoX5ez/d84qwixLdnuFz/gR3TKKzvbxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1CDitY26nUEnStJYR+tOZ06f+Q6duYLuUcmAFwUwhsYHwliNIdPSnl7ZLeS75/vs43QdczknayyQgy/lGLE662aYy4t5CT1HUpLQuG5SJNWAFdZprkuleuOCD1r5iZpBUwGSIt5wnEU5+alxMK5ft2WQWIhQ/di6vWTSttNiso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJZ18D4E; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b87cc82fd85so369106766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768910804; cv=none;
        d=google.com; s=arc-20240605;
        b=C1a2QfhW9/Ob/EgpOevs6bedgP9/BLbivbCd7/Vr0GpLfj2oUTafj1U2imbfgG0EfZ
         /lCgZ6IURCDszNpYWY4l2PtgsAdCrgs63XOrBhXEXmLff+aT5ppFZOl7yHG94Fx7atxL
         I1gUz6uZHy+b8Q5Y2HicZpF3fWysVHQrCXHtqL7it6Wnwg2LGKjnkxOnw2XlZLKYZY2e
         mqrOHsWIg3l8OQWFQQUC6125ab2ixkZUAGn19ryQT4k89BWpo8CtThJE6lWo5KLQatnC
         GwovDGri/Npob3Lj2oNSriCpqTFbyFpYUtKN/4IzR0KRyrGtGmW71E8rQxFOT3XXV8fm
         d45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSywwt4H1geCSedrIayFN5F6XxP6agCqH0/96lR02Ac=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=YMNY14K9JaWOA6fexDsWNTrhHVZcdNj/yHXLTL3XHvmzjbTJ3Ob66CWpwulr+GEMT9
         zmPnt6bxUUqpyOn2EuE6ImHq3QuCMjZrOI5+EPlYGhmiTVxRJiArjaBcjerNFHAXzJAJ
         5d42zyCovVk7jaIpTO5pFL8q+We0R+JiqCMJFtNiFzpPPtOtET/jANcK6Wt/l9aDOmTW
         Ee400UkJ6dOYdxkOUX+7Yrl+kiG5pcN/zLTKxabLEOSPtJo+gGazokE7B0ZH1brb4eih
         /Y1LeZDlxk9tnu7Y0f9asoUhWPxV3WGiHlWl4JXydqIU1nzLXHDtcgIHqFVD5K5fU7tx
         uUug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910804; x=1769515604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSywwt4H1geCSedrIayFN5F6XxP6agCqH0/96lR02Ac=;
        b=JJZ18D4ESqrWCEJ1d/pfLwCLYz2TEy1xu1ksHGQ/U/GykgsNEHKQnKXNBvFymp/pHf
         b+M4MStp5MQM5KUVnQvJO33DElejtIHFUerjJAtKxociwnbZiZQ+vyEvErNzlq8Pn2pt
         rTklxPXipPeLeDtocUhrH8oujE/96ftaCEOo00dvWD2T0uH+vMBv312MifegxLR70DU0
         xXYiRlsD16SwNqAPcQTliqew4si60b2nIPKPbp8WigANqrapdO7KPf53Cd82YBrEBuoP
         o29DYrU1Fx85J4zF88WStL6KCzRsoB1f6DWBPsfXcephtoQue0ikS6mf2OlmfSJiLJIM
         MsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910804; x=1769515604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSywwt4H1geCSedrIayFN5F6XxP6agCqH0/96lR02Ac=;
        b=RGI8DOOtLdjppJLSuyLOBqCxd2R30t3CMuhZtGPAZnjquabgNXjgg10XDktNOrxWhg
         HFA7Dd390b4yqJXrsITnK6KGl/OYWZUtDouW7pHKx0jeWFW70E8ErahAKLqrBbT9woqh
         w/kpt5LRIAVvHPtXdesILKUFreV+/KXOqdSzyjKlvFPzz3tPbDpUlPs4UnaPXX7x7X4T
         UCs8vqPky6nv2o9ijcTrZuLva1AwmMrzSKcRoymoQY0Rvcv+T0EGOkxlxyfo/ZGBgHm1
         EC58vsSOlC1zFMmNXRSn7k8d6FA964w1CiLMVAfmQBP5sF1ubqhlYD+/uSKuG8RkF2K5
         iTfg==
X-Gm-Message-State: AOJu0YxHw//KQa1xaDM1cufI6T2Iy63bnTWZlCxtE6hnEZh9/1MR3N9S
	R9R9hYjYwDd9k+huvnYPWBxlJkPpvvKfQYdwJFiU2bVJepH1KJ48VzAkzOneaOAwfc5oJZLziOd
	Rp1IzW/xA84O/l/emYaUNZNizm9ViXksc3gqG13C/nQ==
X-Gm-Gg: AY/fxX4mMMPyTwAUYaz44T/MPTG8OpShVfalkXNFTKhJGYRSYRLagBNtA6OyYYve8fz
	9GwF6fg/Nf0tsgAaytLeXVkv1G0nFHLcRY+99RWDqG0swJE1CZVywEDbV8Nd6fLxmD+pcFtEqjv
	mK/i5JYjzkSv6h4ReIDjSF5jHwDRCKemSLSRq9jDck/HYpHGM2+5PlF2sxsTGmyMRsajKFfvz0G
	E11birrlxJAVGlOpBFMSHHdFGU0MR8iWjOnJ5aVYpzbarNs7sRBegRArH+WpbTvXrQR/NrwJVit
	/Jiy+59duFVmnb0KEhPNXxcoyNhWBg==
X-Received: by 2002:a17:907:1c1a:b0:b87:17d1:a988 with SMTP id
 a640c23a62f3a-b879691c392mr1304928466b.20.1768910803916; Tue, 20 Jan 2026
 04:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119161505.26187-1-jack@suse.cz> <20260119171400.12006-5-jack@suse.cz>
 <CAOQ4uxje6rMQGNHKYjjO9_Bw3nZuOTyephS=wcOBJSv+Kh27yQ@mail.gmail.com> <56pt2kjxhxhki2vwed4pme4dwefq3uz3pqktb25zekcs2in6nk@mmlns7qnmhxf>
In-Reply-To: <56pt2kjxhxhki2vwed4pme4dwefq3uz3pqktb25zekcs2in6nk@mmlns7qnmhxf>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 13:06:32 +0100
X-Gm-Features: AZwV_QjnVqBcA5rErC6qyM7ZuMcIXho-0_ZjLZgE-t30P4ir37n66wL9njFxHtI
Message-ID: <CAOQ4uxjCz3X8pV=SgXJLN1A7kWfbH4DnX0R4Q_+CWv2jz03gOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsnotify: Use connector hash for destroying inode marks
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74623-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1D49B4EF44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 1:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 20-01-26 12:43:26, Amir Goldstein wrote:
> > On Mon, Jan 19, 2026 at 6:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Instead of iterating all inodes belonging to a superblock to find ino=
de
> > > marks and remove them on umount, iterate all inode connectors for the
> > > superblock. This may be substantially faster since there are generall=
y
> > > much less inodes with fsnotify marks than all inodes. It also removes
> > > one use of sb->s_inodes list which we strive to ultimately remove.
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/notify/fsnotify.c | 74 +++++++++++++++---------------------------=
--
> > >  1 file changed, 25 insertions(+), 49 deletions(-)
> > >
> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index 706484fb3bf3..16a4a537d8c3 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -34,62 +34,38 @@ void __fsnotify_mntns_delete(struct mnt_namespace=
 *mntns)
> > >  }
> > >
> > >  /**
> > > - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watche=
d inodes.
> > > - * @sb: superblock being unmounted.
> > > + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched=
 inodes.
> > > + * @sbinfo: fsnotify info for superblock being unmounted.
> > >   *
> > > - * Called during unmount with no locks held, so needs to be safe aga=
inst
> > > - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock a=
nd CAN block.
> > > + * Walk all inode connectors for the superblock and free all associa=
ted marks.
> > >   */
> > > -static void fsnotify_unmount_inodes(struct super_block *sb)
> > > +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
> > >  {
> > > -       struct inode *inode, *iput_inode =3D NULL;
> > > -
> > > -       spin_lock(&sb->s_inode_list_lock);
> > > -       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > > -               /*
> > > -                * We cannot __iget() an inode in state I_FREEING,
> > > -                * I_WILL_FREE, or I_NEW which is fine because by tha=
t point
> > > -                * the inode cannot have any associated watches.
> > > -                */
> > > -               spin_lock(&inode->i_lock);
> > > -               if (inode_state_read(inode) & (I_FREEING | I_WILL_FRE=
E | I_NEW)) {
> > > -                       spin_unlock(&inode->i_lock);
> > > -                       continue;
> > > -               }
> > > -
> > > -               /*
> > > -                * If i_count is zero, the inode cannot have any watc=
hes and
> > > -                * doing an __iget/iput with SB_ACTIVE clear would ac=
tually
> > > -                * evict all inodes with zero i_count from icache whi=
ch is
> > > -                * unnecessarily violent and may in fact be illegal t=
o do.
> > > -                * However, we should have been called /after/ evict_=
inodes
> > > -                * removed all zero refcount inodes, in any case.  Te=
st to
> > > -                * be sure.
> > > -                */
> > > -               if (!icount_read(inode)) {
> > > -                       spin_unlock(&inode->i_lock);
> > > -                       continue;
> > > -               }
> > > +       int idx;
> > > +       struct fsnotify_mark_connector *conn;
> > > +       struct inode *inode;
> > >
> > > +       /*
> > > +        * We hold srcu over the iteration so that returned connector=
s stay
> > > +        * allocated until we can grab them in fsnotify_destroy_conn_=
marks()
> >
> > fsnotify_destroy_marks()
> >
> > > +        */
> > > +       idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> > > +       spin_lock(&sbinfo->list_lock);
> > > +       while (!list_empty(&sbinfo->inode_conn_list)) {
> > > +               conn =3D fsnotify_inode_connector_from_list(
> > > +                                               sbinfo->inode_conn_li=
st.next);
> > > +               /* All connectors on the list are still attached to a=
n inode */
> > > +               inode =3D conn->obj;
> > >                 __iget(inode);
> > > -               spin_unlock(&inode->i_lock);
> > > -               spin_unlock(&sb->s_inode_list_lock);
> > > -
> > > -               iput(iput_inode);
> > > -
> > > -               /* for each watch, send FS_UNMOUNT and then remove it=
 */
> > > +               spin_unlock(&sbinfo->list_lock);
> > >                 fsnotify_inode(inode, FS_UNMOUNT);
> > > -
> > > -               fsnotify_inode_delete(inode);
> > > -
> > > -               iput_inode =3D inode;
> > > -
> > > +               fsnotify_destroy_marks(&inode->i_fsnotify_marks);
> > > +               iput(inode);
> > >                 cond_resched();
> > > -               spin_lock(&sb->s_inode_list_lock);
> > > +               spin_lock(&sbinfo->list_lock);
> >
> > The list could be long.
> > Do we maybe want to avoid holding srcu read for the entire list walk?
> >
> > Anyway, with or without, feel free to add:
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks for review! Actually now that I think about it sbinfo->list_lock i=
s
> enough to protect lifetime of the connector so we don't need srcu at all
> here. I'll remove it for the next revision.

OK, in that case, without the need for the comment about
fsnotify_destroy_marks(), I was going to suggest using the nicer wrapper

fsnotify_clear_marks_by_inode(inode);

Thanks,
Amir.

