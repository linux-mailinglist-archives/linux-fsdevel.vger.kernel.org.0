Return-Path: <linux-fsdevel+bounces-72692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D615D006E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 392713005318
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959739FD9;
	Thu,  8 Jan 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu7hqLGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A088460
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830472; cv=none; b=ddoAoMUaTv5Ia+FRneCl2QLIz96EjJznAF1j3gxJ9/0M8opA9tlyqT4vMAQYWbLzmbkAVe2+QS9ljWFSJ2OtzVby7K54ixeH/s2nDhiRhveE4eajTTuFOTyzKFmGXLIzzNC1wCcLP72gUpalH+H1mLJls9cCIUeQzQBzOLJ4ofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830472; c=relaxed/simple;
	bh=pynmrahh3bVOjrYhvTMf6gHKrEmyrfssPuuu6yJ4v40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3F9/E4KOkRsyZ4KNB0TAmVBGtOABN3ZNVTE5WvWwCBL6jdhL34PEImtOnLUxV7EjP6GNOT473utHHxHFXByQLjI9OZUmYi9q+s+VB+FN0bKSxdNN/HaFuRw5hrmANVbW2QrkrPQrs4Nd5KDDxkYd0sYaZzg47PoH8nChtj+8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu7hqLGa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f822b2df7aso33951431cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767830469; x=1768435269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pynmrahh3bVOjrYhvTMf6gHKrEmyrfssPuuu6yJ4v40=;
        b=Tu7hqLGatZj9iehfH18eL0KwQhs91jDF/F6LoRdikiS2l6fBFw/Av3Hw6c6M04Y5EU
         TDo2ZBDgQn1oFzHxoX9Yw3bck3WeDyryTyHZ4wGBBHJOWkYeZz4SUtUTYZKbLCufzqmv
         B4uNzCOOtaQhvlA39Zo982Dw1rj5ClZhxqeH3uCCpardkR6K9S6ZMgilKqjK4N+VNKNe
         WTRyVGj6bimySMroTSfDLs6iF++1/XLWt+gEMSXpWG+Jj6NakqGe0QE8YsuqX6RmzHPK
         EetNq0jC5lkmp9pd1XQyoMTm9ETiDwaXhZWqzb5LH5RFtJMm9NpfFybQedlwnGq+Gw27
         y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767830469; x=1768435269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pynmrahh3bVOjrYhvTMf6gHKrEmyrfssPuuu6yJ4v40=;
        b=llHZrC5KG2Y0pJFeUJYUbmK2hFsqfLyftLGiiOvU+IxYm7vvW2iZs69bf3b+qaiq0U
         4AFq1RSgjOov9E+NU/j2p2QBRbayrkRNVJaQ0fP/VNjjwVlY/t6LeROZI9MHtW7wTVHh
         SvvNgNXPXfJJxWgL9O8TlMx1QYndmQMNcRLN+Qm3NFKKWnYOkAjb0oliCCjOcqQTwZAB
         +2MapNDzzAszuIMcQQhax/LnXw86EJrnCEbYwqCXdMxMs1ZqRl8KuogTVAhxY04+uDBb
         V8vu5w5JAgCZ8qqSlrjBytiHhuJM2VqDcybb5hODDY+oKIdFBkPlseENIub38yStIe2Y
         FAhg==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ5UZoXVQ0vHrIQQP48N+np9H1ncX237RBbJ2KtEvBHlBKltZuEsK4BuW++0kNMBSN8n6SlMR0h8UobE4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xFRhOnlW4s7fa0w8N94huwM8VPYa59l+EDTDMQ9FSoqA7cNT
	Y7GUCMJ1V/joR4Nf91a2+ajzh+qH8YxlYXZrxzbjltL4/nlO7a55q5hZnoTqsPcwtCFn1GOVhyI
	RSP9xfkHq9+XrIzkqAIgrYm4fEL3IOVs=
X-Gm-Gg: AY/fxX40pAPI+4pQDF07fH2nfOmY9RdLu6QZio3sfIu4UTOXJyM7RjU9Ui7uZ1KOal7
	13VCR3Tktcil7WvCRNTKVJv82V+rgCpCO0eC/P13w02cfUTfhcjCJp8vfqZkWee4lLlCoDH6wGZ
	NgcFqLtg3orAkPeRhVKmaWWfKQWF2+mB1scT/BKhYjNcJ+ofwnHyE5ad2zPIo0fQnVCHn8X6mN5
	Pf7VWvqgijl+6qsfF9bVFtqN6xr9Pr0Fz2HIkwIh8slsX9CGNfTyJRmSiZimx66GMi3jimDEwy7
	xdyJ
X-Google-Smtp-Source: AGHT+IENFb5Sl8PjXY2lrmgT0U/o4A27Uo7Ad4bceuMxSnavb23+MGwALRDrL2f+XviH76yGtMmnwNHDcC7bMRGXwN0=
X-Received: by 2002:a05:622a:244a:b0:4f1:b9b4:6a7a with SMTP id
 d75a77b69052e-4ffb48a8d72mr56124111cf.27.1767830469181; Wed, 07 Jan 2026
 16:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
 <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
 <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
 <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com> <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com>
In-Reply-To: <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 7 Jan 2026 16:00:58 -0800
X-Gm-Features: AQt7F2pCAdr30F6iXQqBCSO7cD97VNQR9XZ-xPaLh5wch7P1osQusbDG4D4dFuY
Message-ID: <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:43=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi Joanne=EF=BC=8C
>
> > imo it's possible to check whether the kernel itself is affected just
> > purely through libfuse changes to fuse_lowlevel.c where the request
> > communication with the kernel happens. The number of requests ready by
> > the kernel is exposed to userspace through sysfs, so if the daemon is
> > deadlocked or cannot read fuse requests, that scenario is detectable
> > by userspace.

Hi Tianci,

>
> Yes, checking in libfuse/fuse_lowlevel.c is feasible, but it depends on
> the running state of FUSEDaemon(if FUSEDaemon is in a process exit state,
> this check cannot be performed), I think we do need this approach,
> but it cannot fully cover all scenarios. Therefore, I believe it
> should coexist with this patch.
>
> The content of the /sys/fs/fuse/connections/${devid}/waiting interface
> is inaccurate;
> it cannot distinguish between normal waiting and requests that have been =
hanging
> for a period of time.

I think if the fusedaemon is in a process exit state (by "process exit
state", I think you're talking about the state where
fuse_session_exit() has been called but the daemon is stuck/hanging
before actual process exit?), this can still be detected in libfuse.
For example one idea could be libfuse spinning up a watchdog monitor
thread that has logic checking if the session's mt_exited has been set
with no progress on /sys/fs/fuse/.../waiting requests being fulfilled.

Thanks,
Joanne

>
> Thanks,
> Tianci

