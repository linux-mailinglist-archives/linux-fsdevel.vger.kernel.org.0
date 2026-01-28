Return-Path: <linux-fsdevel+bounces-75788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACy9AiJTemnk5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:19:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F9A7AD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A85311AB87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEE36F419;
	Wed, 28 Jan 2026 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqaRYaxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BF212F98
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623976; cv=pass; b=UdGagXncra7ywmM1aCRvQNFgLth18wPMh6e4gDeoLE3jtbGh01G/uiun9cmOeD4ilxwYA81cVCJtmmDa+QJFzxv19yDlWjU3LdIEPUhGRJ5Mz99d2iYLtFzeStJ0RAiYU8Fpq35F8XWa3QHdCPs4jmMexu6lhKYDAKZHXPMYnrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623976; c=relaxed/simple;
	bh=8S13+mwGrDe+fCW6wWPUOH5CZEl5aAEYbS5ftjBONh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AliyXn0h7T11zgm2G8sph2yhKB9aX0BJHQWHznvv3QaNBvUOPdxXf77b5cPdiR0sELFNhprP9oSD3EpBACnoPuUr+wrWgLSU2Je06Uv++BBvFj7R+wMpt9hxk4o2Dc6AU35ScT5PpgC2zOAzZyOXLYXJ4fTwsm7sm3xSyui+1+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqaRYaxF; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124a95e592fso55782c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 10:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769623974; cv=none;
        d=google.com; s=arc-20240605;
        b=Y937SqifNxg0ZunBsrBMxnTfSJz08pDc+vtVP44sxW3ur6rthVFzq4ZIs+fsudVI4e
         kVud1PkNnlrTDdqRf06Z6KAsV5mhT3OEgQU4lPhaJDJhOgv5aNvwQ5lk6tqctlzoCLqa
         4javRS53YOFRaKjUHz04aHcXv2DORqGgZP5GXtgRgyUNm8ZRjcCDuOS+mvZynZSsRfe9
         4rRttEnwhnhibFS2SvfN0Uq25IWOzxazkiBEr12YO+ssdAqmLXP9rNFlUFjpWSVAW/Ov
         MHSQwa0JWDnO4Z2aKorjWcOR2ysKeNMHT918v3eLaFOPJG+b6ct5F2GZgITLTWH0x7bm
         BRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        fh=lFlNdBBmtKuYBNMDdIM9FyAjiJxz01X4sa8CGf05d48=;
        b=Y0Bdzm7al8Le5ODS3D00+JiUIWPfq1+yS3cb4/orG2FlpEbzA5VMCjUUIkqCYRcOZ5
         lTnTr/H1achoFsqgcMaKM5SiBNb6xH8gMUG/BtRTyFU+iTWMqG3Y2G7G2ntPrVo+Pjmh
         y6gIoc8J0rJnNxOqZX5gnkJrfFkEF7UvS3EzTu0eTr5DKfJpGekV/xY27IbT9bAXAaj2
         5QlSRK9F/5ewj71RpXYERigqJ5VNSnxWHdE7z234x8Kko1tRVivdAlERUQBwXtxxHksp
         zgu+0TOOXACcY4K/Kgf3UAvCL3EQujlRYdoNUEeVAbWRjSt2HwHNqqD03fxiJOfyjbRq
         37wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769623974; x=1770228774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        b=bqaRYaxFPoEMdHoG+fbsx+vIpxGWxWCAj55MBUj8u3sscKLHWM1t96d+ZUV9Tfpe+9
         0nf3x3/4p+0zORl0BlG6EoLHK4gxhPrvbEdv+k2qCcwySpzjMZkRAnDTIXsfZITcWqYm
         kPdo9TA0hZlxwAPQO5lrKJIdoDv5cCz8+4BmDeeeCgiIE9BwBIEv1uhRo5mz9MYnR9b8
         k8mSPw0WTrjFvU81BeBx3a88B8+G6AbeO9VnExKiwW8wY58VYsIyMNdfE7jgWsnzp02y
         HW0igZQuXgoAe7onDIwK1Oc99YxujyKC5FWptm2aYSnIiBzLTya2R4SDL6+RzldQUOic
         BvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623974; x=1770228774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        b=d42hmWXYigQyY8RjaRnV3Msg4mHlQYq8NQn3mGuvhy7tOD+IRCctjmfJrZFRppVKk+
         iFT1JQ7AJ2xf67pcFbz0vSNuPkdSogLiAbK0Css6UBwEPFuxVw+8FRSIWSdXLt+Ok/Ik
         FLvgA8qGeQjuMgqc464jXOnDzQgT0F7Yi99pcQRzsE5cE3ruMI8v1pOZvEfLCcsJChpv
         rD9hh9B2AcRVdovTvWxftE0Fv7FGWzhsM0fVAXTl6UHsEIsnJIMC633eVpEE6bmvELaG
         ia7Qgr64h/lRGRENGwVlAJ4hk6g0xVXrBOfb8xNivbTCtsp3M3erGgthFUJHRxXKMphZ
         4GzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVO1VDVTGzQMKtocpLorx8v+3Cj8E14lXx81NUUWXOtAmdxEozFNxKhhm/3AM9DKTdK9dme6xCTi2fj2sY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4KNypYWM+1NidYKo2oYktDAZPilpFoIOALO2Q0IO1OYB8xyt
	n9sJFvuayAt5eztIoJU8FPf1P+4bD6rVzapHiy1b6VVABuCgEMF4eWruyHf5sW/xOb96uyd1H8v
	uztvBlNn8VB4V5LwOLG26W43vFsFZAlI=
X-Gm-Gg: AZuq6aLAGKJtdfzHF18rs0iDE9jr0ujQy5ATMStmlfGgAPLWK4l4dkW08s+WoGmt3Zt
	DkXF9YJwBygIyVArOrITy55HrhtZOI5kBIGnYRVQjpwXuje5z11kDCixBQJlpf5H/58+RwVg2Xe
	DQ1c4Iioe4/FEuf2thJhB+Bti9Gi1rOM+nryXh0hIhTWlHra9iZnyeWSKSFzcItMkbuOsujDWLC
	jmFR7VpfKa51hOW/Ac7V6Ml7V9eaKboU22fPKLYvPC8mtwYpi6klVJ14+hoxt9t0IS0ua8=
X-Received: by 2002:a05:7022:910:b0:11b:88a7:e1b0 with SMTP id
 a92af1059eb24-124a00b9151mr3453147c88.26.1769623973962; Wed, 28 Jan 2026
 10:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
In-Reply-To: <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 28 Jan 2026 19:12:42 +0100
X-Gm-Features: AZwV_Qg--eDgI3HAIGUqozTx6HLUMnHXncn-L46tWgP6Y4_IUBt5ZMyJU5pEpEE
Message-ID: <CAOi1vP8dtzUesBa0h8wLhh+gz66dgD2LRDhuhQP_28+X3Y7a9Q@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-75788-lists,linux-fsdevel=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A80F9A7AD8
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 6:15=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
>
> On Mon, Jan 26, 2026 at 7:36=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Hi Slava,
> >
> > How was this tested?  In particular, do you have a test case covering
> > an MDS auth cap that specifies a particular fs_name (i.e. one where
> > auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
> >
> > I'm asking because it looks like ceph_namespace_match() would always
> > declare a mismatch in that scenario due to the fact that NAME_MAX is
> > passed for target_len and
> >
> >     if (strlen(pattern) !=3D target_len)
> >             return false;
> >
> > condition inside of ceph_namespace_match().
>
> Yes, passing NAME_MAX looks like a bug. Is this parameter even useful?
> Why not just rely on string comparisons without any length
> restrictions?

I think this parameter came about because ceph_namespace_match() is
being forwarded to from namespace_equals() which needs it -- but this
forwarding is actually harmful and results in undesired behavior as
discussed in the adjacent sub-thread.  Once the forwarding goes away,
the parameter would become obviously redundant.

>
> >This in turn means that
> > ceph_mds_check_access() would disregard the respective cap and might
> > allow access where it's supposed to be denied.
>
> From what I can tell, it will always consider the cap invalid for the
> fsname. So it's the reverse?

Yes, the cap wouldn't be used but it appears that if no other cap
matches/gets used ceph_mds_check_access() would allow access:

    struct ceph_mds_cap_auth *rw_perms_s =3D NULL;
    bool root_squash_perms =3D true;
    ...
    for (i =3D 0; i < mdsc->s_cap_auths_num; i++) {
            struct ceph_mds_cap_auth *s =3D &mdsc->s_cap_auths[i];

            err =3D ceph_mds_auth_match(mdsc, s, cred, tpath);
            if (err < 0) {
                    put_cred(cred);
                    return err;
            } else if (err > 0) {
                    /* always follow the last auth caps' permission */
                    root_squash_perms =3D true;
                    rw_perms_s =3D NULL;
                    if ((mask & MAY_WRITE) && s->writeable &&
                        s->match.root_squash && (!caller_uid || !caller_gid=
))
                            root_squash_perms =3D false;

                    if (((mask & MAY_WRITE) && !s->writeable) ||
                        ((mask & MAY_READ) && !s->readable))
                            rw_perms_s =3D s;
            }
    }
    ...
    if (root_squash_perms && rw_perms_s =3D=3D NULL) {
            doutc(cl, "access allowed\n");
            return 0;
    }
    ...
    doutc(cl, "access denied\n");
    return -EACCES;

Thanks,

                Ilya

