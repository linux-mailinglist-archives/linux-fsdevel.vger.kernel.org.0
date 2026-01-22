Return-Path: <linux-fsdevel+bounces-75009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E6xIML9cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:36:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0111165577
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF193883D09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C6348880;
	Thu, 22 Jan 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6cRDpqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3733F381
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077731; cv=pass; b=lRinwhw5IAY6+REPEa/naabijUG+JSmoLAzJhIcHsJ646OVr6MmdXqfikAULpm204QtujiRIobzTSC89DmvG9JM3ztHA5htNuLolYZbE/hPQuaGgjZZ9W4gP+08OXlAN3+PNEvsqTLCLUbFxyygo6kWZxXV1hw42yNcGtAn8FOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077731; c=relaxed/simple;
	bh=gKJmrBsUqx2+A46136j2lxEJrIvyRMSSJzhz89pr7IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sN0r1O10oh6sSiAEnqhiT2BL5U69U7IRpd0oOwCc1sK0jlpyi1OgMSLU6gpFpb1YLy5MUjYdld7JrbBo6g5KilGlqTZpCORp46ceX+rtJenQITBMu3vtevIziVz+SfpD+ssdgBHBKCJOTTwBbm6roG8qKjDj0op0hPLMXQYm6O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6cRDpqp; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so1242482a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 02:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769077728; cv=none;
        d=google.com; s=arc-20240605;
        b=EWS+pynrkJI3kz/m8zuXznqhTAk6IWgeS3hGp5mGr4K0cWbZzJMY0H9oXkgjeSeFcl
         8kdumpzOqf1gBNAIEQqsRloWQ/2/t8AuqVVAv4iQG+Soa72sIF9bHDiqwgH92SDqh14K
         R8Fzk+X6/ZC6tJDEgeJH8hiqREm8sS+2pJJ1Eh9PV0OfRhFo45aflh0W2AZJy4QiBeVE
         lXs3KbSWim/T5YHlSz5IpSNXj7Q3WE7jzlH1W1SD+uqX4qgjam5j4aUp+dITXXiCGcpx
         LMqJEFxoWls5Pbyw70xIptWcRY+tMYuGDrRh/UkZeFrRW3b+Whfb36dSisJwGRxDDw56
         ePUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D0l9dGMRQk7QZMTMljOZdJ7B30V4/dSDbqUsdJsP9f0=;
        fh=Je4uwNyJTBnWekdzHnrRVNrBE/QEW0fOwM0ldTowuDM=;
        b=iUYEb0hh685Kb3FFQTIWG2S3Xgv6yruya8ltbmu4WkdcjpB+HffEyxpiLH1ntw4TX1
         fXB6YtdijAxInOCy4eye0Hsa7Rq4m4/g3akNiPUGBGLlXYBInCA80fBnol48JtpYIIAE
         q1ggklb9mvOiyK8HSQu6i5hJSydJ70ZRYwnWb7TbiH6rX8SZd6k1PbjSWm6Nh7tqRjV3
         LK9ZrRNSpGdCr0xQ8JQQ5bKMsyoglZlwvcVGeBDYeOqEzLjVosZCZWFKp64ISdjHTdKJ
         M8UTFP+UK72rk0fLmYHAd1HNHDngBXUQqZGe7JRVxCMuIS6Bi3tARduIUmHItttI75pb
         mwlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769077728; x=1769682528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0l9dGMRQk7QZMTMljOZdJ7B30V4/dSDbqUsdJsP9f0=;
        b=Z6cRDpqpEhlX8GAhHT3dF/SC3zAAwBJy/BDwNCLO9xUusk5br0gT2hgj5zzX1k51hm
         EV23zwhIlrFjBTcegbmECAcB+PBqW5UdVoqSF/M8Q1q5MUE18/3fok3DXadBGUOHGnP8
         QoPLMhfXHg51hGIphl9BdbOBI5ZEGQTefV2Sum6lyHRq4XtXRavOM5Bs9ho2kUKomMMa
         xjbQbmSFyb2vtzoSHAMGrsyW4axAEMlMz/w2XRiTUcTzWNGbvW/u5WU1UBpl4aybLW0i
         q0h2QaU8o4JHvRGy+Xsw9CRSIY0Flj2EpuP3u1hZC5eMDynpXkyQ2rmKN7P3tqh9xBsE
         IcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769077728; x=1769682528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D0l9dGMRQk7QZMTMljOZdJ7B30V4/dSDbqUsdJsP9f0=;
        b=qrlt94l2mUqfLK61rWcIBQAsZCaFIDSUEEbJUklSoGHx7IJVOLUSdD9+W//jU1pkwf
         jKSAKxF0HXsDbG2eHTs5kMQEwD2ERDoCo4jbkSYTU7SbVJ/Gag/5GZZ4wuRIiF4wTymu
         Pw3aToGhAFre22ERy2BLL/eD2o1sz0YdkVHCYN16713h8VSlbmh4IMUDoHrDm5qOjRg5
         cq5zi7X6koI4cuT8ecM9C445gNDASbat7jQsCxzfnmtkIrkp/YJmBIv2npBMYZnKH1XN
         vDBbgg8ySPZKZAti2RnZ2cGZ15NpZm861r5xPvsAj1B4f8IveBkCscsIv89iGd2fEEl6
         gHCQ==
X-Gm-Message-State: AOJu0YzJvW9odkAwGTBttUWZ8jsNtXXxwFWfItxXstpyg5Q1PRuivvkL
	R+EGYfoyyJOGvTQuu5T6tY1lkQXnpm4krbzY72W+QFDBarV4XRUafrT2GmAz5mBWyvjbNrmEEeZ
	fJHo4vQ8vYtfSRzpjcBRuVMBV7TA92lcMvH/F3kNG+A==
X-Gm-Gg: AZuq6aLV28NdbqBrckA1PeLeZCOzVYdgy3HEBCwP22JKGPSYaaKDsm9EXpT6Ugk878A
	/scLAk0GyGGZR5rbDicaAZxrWsxdzCcfq/MuV1zddhg4z2d9HjvYFGA4lWp2VnV7FT/Ajn4inTY
	nTLzFHbP+8GgIhSThACrowxJf/00T7hLUuSSUK19Sqnd46XGns4bhqghqoltyNt0QOdk7I62GMA
	kQ/eLxpNvM9YpS8xAM5gU2rwA8YwYwYGBoxXIKNnEMllpOlTS/OSkd9LC3wZN9hTKil3l07PpT6
	ybh2fjaP56k6uvip4LFhwPIjPOu1VVajt4TbAA==
X-Received: by 2002:a05:6402:40c3:b0:650:854c:4558 with SMTP id
 4fb4d7f45d1cf-65452acd8aemr15379034a12.22.1769077728127; Thu, 22 Jan 2026
 02:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135513.12008-1-jack@suse.cz> <20260121135948.8448-5-jack@suse.cz>
 <CAOQ4uxg4HrLqizEdgc8TUaZOUbBTR1if0SBSwxeu5VKAwU5FBA@mail.gmail.com> <zx4boczfwcbu5a6vcmalup6ogcqlqg2sbn5ex7rbidd3rdwr7s@2exh6w7hypi3>
In-Reply-To: <zx4boczfwcbu5a6vcmalup6ogcqlqg2sbn5ex7rbidd3rdwr7s@2exh6w7hypi3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Jan 2026 11:28:37 +0100
X-Gm-Features: AZwV_QgfkSbUBcdjQHArNjwyvGdQg4Rb9wJDy4KmCYSdhh_EBTEGmXXpRpD7ZO0
Message-ID: <CAOQ4uxiwqerdbR=TrMZwhfCSOn=D-6D6Bx_0Djw1j05WLfzK=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fsnotify: Use connector list for destroying inode marks
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75009-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 0111165577
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:04=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 21-01-26 17:27:45, Amir Goldstein wrote:
> > On Wed, Jan 21, 2026 at 3:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > +               spin_lock(&inode->i_lock);
> > > +               if (unlikely(
> > > +                   inode_state_read(inode) & (I_FREEING | I_WILL_FRE=
E))) {
> > > +                       spin_unlock(&inode->i_lock);
> > > +                       continue;
> > > +               }
> > > +               __iget(inode);
> > > +               spin_unlock(&inode->i_lock);
> > > +               spin_unlock(&sbinfo->list_lock);
> > > +               fsnotify_inode(inode, FS_UNMOUNT);
> > > +               fsnotify_clear_marks_by_inode(inode);
> > > +               iput(inode);
> > > +               cond_resched();
> > > +               goto restart;
> > > +       }
> >
> > This loop looks odd being a while loop that is always restarted for
> > the likely branch.
> >
> > Maybe would be more clear to add some comment like:
> >
> > find_next_inode:
> >        /* Find the first non-evicting inodes and free connector and mar=
ks */
> >        spin_lock(&sbinfo->list_lock);
> >        list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list)=
 {
> >
> > Just a thought.
>
> I agree the loop is perverse and I'm not happy about it either (but at
> least it works :)). With a fresh mind: What about the attached variant?

This is waaay nicer :)

I think that we don't need to worry about a hung task warning in
fsnotify_get_living_inode(), because a long list of evicting inodes
would be unexpected. Right?

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

