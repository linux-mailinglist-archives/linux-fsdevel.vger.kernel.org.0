Return-Path: <linux-fsdevel+bounces-77321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3GxyLiaak2m36wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:28:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF85147ED9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDFA3018292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748C2DE701;
	Mon, 16 Feb 2026 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjvBPdCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E57236A73
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771280928; cv=pass; b=JIIbSxdN/0yQsJG+Zx73Getg8R65YshL9xC4yjJC46GU71Mto/+/g79dl37LGGl10Bq7tiG/V8V//w923pZNOtfNA3JoEKsVsg5SwQyp3G/qjPfJ75Sx5NdfUr25j+jUDq2sReFo5rKUjDWikoOzmJmCUE4WJQ24Co6w067sO+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771280928; c=relaxed/simple;
	bh=Mk4eVkR6hpYMOnrThwwCLQ/HCos6LFfwtaVhTi2FLMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExaQFPkzY+ct68nFKxpmBd1x0R7xaLW+cKNDuEkHRVyWhHh3IM5Go1Q1TfYrrxsyOjVVFSm+SH/3bh2ny8PbOBQhwE28lrHmzQcSCSHIaoqJYZUYWcZ8EOj/F+Y8J2n99vje6tFZXkWQfFyEswm7pg3cptVaxUSuTPQTqvvs1hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjvBPdCb; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1325717fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 14:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771280926; cv=none;
        d=google.com; s=arc-20240605;
        b=DED+oPpkWue4byDiiO4nuLtD9h4Qeh43VTYQ37LLz5MP6j6/ctwqOWIcskVlAdNvbg
         0JbRYlbFgx4Z3xRlYMDLd9U8JLFUfXrcJFCtdOWcvwjAFe/8KQDnKBXdwAJ4s5P+pOuY
         PFbRiNX61z/Vg2o+nN7nbcZW2BxineoQu82CXf/Iwf+Ofj34SNTgdO/s+j1CUA6wWFdv
         XsikEmsWJ2YAjtUwROoqysJy5MOv1l9/l/P3eOE62CxsimocpzbS646DQ5xCk67TUS/1
         bmzrkZBTrnSBBP1Xub0/Ntt6veIfIObInIvvZZ35ACrxx56Y5AipNgEUmJmCunWhwxiV
         I5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zOYcy9YsuBOtQgWHelbI9NmQ8Mb/IFJJK0B+KdXK1Hw=;
        fh=bDzWyKNbhkFemLwwP/HubTw7IgmqTfz8dIku3dE4gPs=;
        b=BajxnwJJ6e95DL/NTxE8DNIjoCS65tUHBk5LAZIAAOheOwHvT193Wb+I4+FvBAWNKu
         IaGo0lYesIRbLA15VDlVTNzUR6GWRc0TW+xTz5og8N/yqFqRSdhPfSckLwwVdz3DrVn1
         ct9BJpABzVv9O4SlGkuwJrRqtm0Gm8GWYhnl3QuaLWWGK8Rm+7FAzt8gEiTkqIZtzIAm
         nlfWVFnVABOESgH6ha1UCwMKf7xC/GSOkwyh1iTiESM28lm3QwIt3ZcSuT4dYWACrtrQ
         r3NIUCX5K3cFIk08FFUTMX63oN1/L9fNf25Ob5BzNIcIzV5UYRp414ze4YjuhBgtgZzD
         6RAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771280926; x=1771885726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOYcy9YsuBOtQgWHelbI9NmQ8Mb/IFJJK0B+KdXK1Hw=;
        b=SjvBPdCbgNSsIoBlOgR21x1GUI8NLyG7fL0UkqiyzwKERYIphlcrX1n6e00TuOTP6c
         pW3VBMoN/MYMGmWDTqDG/hZ0RdkznR6pJBti8Yk5od0WhfEpXdX8UBV8qdKTUYJeniwk
         WO4iWpQaWmdX/qyvPSurBduNv/VlS0SOKxIkXNrsFnDrvVUeO+78QrL8Prp73qAfk97j
         seebqwciRCs/BMKCc5z/YQHr3n/k2+EO7RObQd3OWQItDTF5IACumCt5ETOdQZzNYjDY
         P3HHoTLMooooAKbKqtPmM1AiQq0cjxuEr0JczKxwrifJhCoRJfXc3g30iPO7La9j5N8n
         /cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771280926; x=1771885726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zOYcy9YsuBOtQgWHelbI9NmQ8Mb/IFJJK0B+KdXK1Hw=;
        b=qGOTQnEJa1wT5Q86RlvrINKrWU1c9i+WZXTMhESafDnvKX/+51jJDG4bHpNbFVuHtf
         PMB8u7an+rYW7+7WAW0s3G9YuXLj+l9fWBIizqOODSIS6xyPiEiwkIgWEqoAgINpBZsF
         ebG35rugy6fO8sUq7o8e1N4zWX7IpeNamPopIYiRVE8CCVGehG5DYRUBVLYZT2c6j26Z
         1b4uIVB4Hwsfs+H6JyiS1zYKCiOeCcpR5bgV3zeAVlw6MYsVG2FhyHhD4o7WPz1oA6AD
         pmX0FTGLE3ykGhZdNd5xT05Nsfbz1u438JRc/JEusGHbFhjImeK3+o4m05phiNgpa/By
         2lQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXUnNFMFzTadjdvb+mM+9AI45UMUIKRVvmK8AIc/LMIl8kLT9Mf68K+SAdQzYFUl42TlW2kwyRPgJ+s3Lw@vger.kernel.org
X-Gm-Message-State: AOJu0YzJRaV9fNq4VNnh4lrMrdJZIBColY+yPBvxqPy+pHmbyoGkeAGL
	6s7uZIca2ptxzIocHubneksynmjVJVITI2Mbyuv31A+bAZ4nK4Rl8SX5ZuyzmAXIk/0XgWnMhXC
	TaBJqe7o2otnMa83OtwuOwRDnY4Kak/M=
X-Gm-Gg: AZuq6aI+Q5M14Wa4yK/3lQbZLOHYvXX+D3cZX2mKsdMGU0H3+Buk7ucDskf+sWR6pvL
	RuOJMpJRS5N8q4uf+gmoTLrDwyh/yqDuCKDlYE6GYhbyEEYJMGjkTWgruEhf45DoqmSi2lY/opO
	2GHqacQ1rYBvWk3MxaiNiRnIeXEDv1QciTqfzHkfitjM5Sd+OCKDerN+k61fkS6SEoCDaOnP86i
	GE10HBzuZKZEMkM3+LIRAy0Rvu75RoYhjy3JGflK5/5rYFTsS8/1t6mSp+sU+CoQ/SdHOejTOex
	2KQQa88=
X-Received: by 2002:a05:6870:84c7:b0:40e:95b9:40e6 with SMTP id
 586e51a60fabf-40ef40a3a4emr6072324fac.40.1771280925725; Mon, 16 Feb 2026
 14:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213103006.2472569-1-wangqing7171@gmail.com>
In-Reply-To: <20260213103006.2472569-1-wangqing7171@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Mon, 16 Feb 2026 14:28:33 -0800
X-Gm-Features: AaiRm50Ry8U6xj5MYGkQjJwBvb7p1TkGU1nlSPNcXsC7tFFtvdnAjoqnyz4qmPc
Message-ID: <CANaxB-ysnKo++y8QR1ONdoXEC=kx+Ehxd0FHqz1fc1Tqvu1EDA@mail.gmail.com>
Subject: Re: [PATCH v3] statmount: Fix the null-ptr-deref in do_statmount()
To: Qing Wang <wangqing7171@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77321-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 2AF85147ED9
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 2:30=E2=80=AFAM Qing Wang <wangqing7171@gmail.com> =
wrote:
>
> If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
> defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
> of mount by IS_ERR() and return.
>
> Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
> Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@goo=
gle.com/
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  fs/namespace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a67cbe42746d..90700df65f0d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5678,6 +5678,8 @@ static int do_statmount(struct kstatmount *s, u64 m=
nt_id, u64 mnt_ns_id,
>
>                 s->mnt =3D mnt_file->f_path.mnt;
>                 ns =3D real_mount(s->mnt)->mnt_ns;
> +               if (IS_ERR(ns))
> +                       return PTR_ERR(ns);

nit: EINVAL is overused in the kernel. ENODEV seems like a better fit
for this case.

Otherwise, the patch looks good to me:
Reviewed-by: Andrei Vagin <avagin@gmail.com>

>                 if (!ns)
>                         /*
>                          * We can't set mount point and mnt_ns_id since w=
e don't have a
> --
> 2.34.1
>

