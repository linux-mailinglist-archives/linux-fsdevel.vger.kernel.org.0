Return-Path: <linux-fsdevel+bounces-75147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHFMJp2DcmkrlwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:07:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C26D552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 701DD300FB63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150B39CEFF;
	Thu, 22 Jan 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/lWqrLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB33803EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112466; cv=pass; b=VI3nlsqO4xT5alOhyReVfzpuCeeLLBU/kQmEQ/V8XnNn6rweXSLEDLI/8rx2s8NKvvwfHaK4nrKEYnAtebQaypSoe/K3R37WdyukTYZj0VWNJlBQ0vNj1ZR0ItD3dKGCbeQft8NBm7U1+uecf8P9yuKyGH7W0RqaiDp2LZQsgO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112466; c=relaxed/simple;
	bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZEIoSMfOfvx923nabwpjJJSdaPcKc5DyftGwmSAfM9xgXPLNqM57srDferk1d2NCTbWg2UD9EKE0M8MkytXBea49iH0iFwC67JfOi477qGQk31aW34pH9f6uWzV+KmKbZGSPa7Vl8efi1rNJRgciIwZFwmTQYW6XlouybLL1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/lWqrLz; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so1828331a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 12:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112459; cv=none;
        d=google.com; s=arc-20240605;
        b=N+VIcK5eKa09Aur8+vdBdoa0KhHDDTrzHTuoOuxhlZY8+IyJE9zDjd4g7S7RdsxBpg
         1sjlkvSdPs1yBs6om1nyX7kEDSVIWzDf7floI5ZQqaXhE+fH/+4YnehXT3QbUn8ixBlw
         lbfkWcmxHttWx5hVYv17+XHuAazzhUWB3Ym4WKyynDfrPnGI2E+R8KO3CVpuuXW/yeG7
         ViWu2QrSX7rDXXL8lxwFAtXZwxoyMabZCMnU8JPsCWLDQtnQLcJr6DZUrKnAS5HCCno+
         u8b90f0GsopBXVH5tOjwEJ7VSQZCdi85yQ8G95afbJLIOOPd12OdJ29cMznywWtrjVSN
         oWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        fh=tsQ8BOCYLBiO2Qh5vl0FT7LwMDxJ3ZIYexd5zyRCcz4=;
        b=hG1+TQLw/BvPVtO+cq0/DJ7fF8hhenaMcMXWk++/5HcfEfYIDjN0B2YNrYGRjF9N6w
         OI7M0dn2FRqBCuWFKO+NstFSPoOi1ZF8wPDE8aWsR6OP3a5CpclQjk0AEPa9it8DIqK9
         f5HJvKMJh+T9pJ/aEYppVxdKFu90bs0ZkMPbyQsBqaJiqBcflq9oj75KTj+rHmWoArYR
         2XolQz4acBofQJyfNGOl9QjDfwW+DWzLWRBoi+Rq74LhTn23O4FeApomH9R8AVrbDOgb
         +MUtmQJ1J1EnJdrvoXsyU4csBkDC1lummIrKctVmGa5IHy6/zx68TOb+ZIw8S1Gpbln/
         Zujg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112459; x=1769717259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=X/lWqrLz2bQ6qvlxMp7/4e7A3KNMkcvHPGvJrXvIoIFpAaXIC/J52gb0mTswrvGFCP
         qSSVd1czapsgBn9o4IwsRwvrzkDyZFQx/Q7wv1QR4ekmsTMySm+kz1F5NgHYxohKdeQW
         9UBy+879Kpi1tgCxNhjuYt8DS45VfiBkOyHJO/2HCOK97WnN26k3ENKaWBrgHO+JG8UL
         BEq6qWIJt7oQcNqg684IBIHDoze+DmC0pRYl6PWRXWVulbGGtM+GXeZOX3icPwGLoZvy
         F8yBwJU6ABDv/T7C8paHIdvH8dD98D8xBTj2IE6kxogY0Puri6AgRf99EEFaozcudOgy
         Dzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112459; x=1769717259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=NXexBjvwdt3tGAjtUoJG2pHTYbVC7mi5eHdAcRh8Akd0gw3AOv9GY6Pip8nEK+Ehw0
         J32J31Jp8k8IjxROqnpxxK6LQeJkBJfstdBkomMUqz1LN81veUbQlFvbVum0Wa7k+h8/
         m4JC5wr/M3BjzD7KQw2v0gGOfOJnbjp8ZrRlT5uBGVBWkfHonIZGBlTFde5dJ3TVRcjH
         sCSL5x9Fy3gJ0yYBxy6ROTJxbU2Yp0+AxLBiPHQxUh1AjWMHb+BuWBWdG/PF20njUlaV
         LpXFXGbseyoW/9+DsG1F05qzktPsYi2Khl4vW10u0nsN4wDvv42cx7EFU/cl1PcG6Csj
         BlFA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwgded0hd8m5h7prBORiEAs5BysyEnK7E5QRk1TOhZ9NT2Uhc0WiDGq04z40OVTiJYmh7dX55wGAGUieG@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQb3bsU3y9TQaOkgDmbU/p9Bpk/syKj47b1pa+mlH2KvCGzNt
	O+Hxle7QCVaQ8zpBgeOzz3bctWHUAWH8qtWdvNZvrEJwLfZ2Vs2HWsO5EPX6lJZ/5VaBqVyv7/k
	Bg7pLSqqK7P6lC9ShOhfQBqgm8dNC9R4=
X-Gm-Gg: AZuq6aIo8/TEhubozT0+38Vk6qO0PTX9EIQQQ7Ap946p4MCGTqeebs3CXgHHLdDPpFS
	1NZboneJqV8zfS1KEwc6GQjFWqHh2m2HOQeyd8rZ5RaHOZhT87Yp4wv9E6lIMDaoLYZ345VrTzh
	Sm63ITKZf1xKZ3zwe8aqKvh6/5PIG4seVQHzVK37FRnufYVdlghcXQqWv5hMgeyAU4QC42FdorZ
	+qQQbotGhpc6wfW18VUs+D8oVySd5nv+eiOgwT8Uc+J+8svlWwXhgr2cQJ/Qhz8Uu40lsGzxVlP
	P22j8tHXnyycjHRUOBUZHE357dBnBn6KdP5USjDB
X-Received: by 2002:a17:907:70a:b0:b84:42e5:2b7e with SMTP id
 a640c23a62f3a-b885ae682a6mr30056466b.51.1769112458391; Thu, 22 Jan 2026
 12:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
In-Reply-To: <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Jan 2026 21:07:27 +0100
X-Gm-Features: AZwV_Qj-Pre4XZbhvcFXr13YDWLuhkhhzBZFRQumTLtcoMVU1rOesRZLphknff4
Message-ID: <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75147-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5D3C26D552
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
...
> > Actually they are not in the same fs, upper and lower are coming from
> > different fs', so when trying to mount I get the fallback to
> > `uuid=3Dnull`. A quick hack circumventing this check makes the mount wo=
rk.
> >
> > If you think this is the best way to solve this issue (rather than
> > following the VFS helper path for instance),
>
> That's up to you if you want to solve the "all lower layers on same fs"
> or want to also allow lower layers on different fs.
> The former could be solved by relaxing the ovl rules.
>
> > please let me know how can
> > I safely lift this restriction, like maybe adding a new flag for this?
>
> I think the attached patch should work for you and should not
> break anything.
>
> It's only sanity tested and will need to write tests to verify it.
>

Andre,

I tested the patch and it looks good on my side.
If you want me to queue this patch for 7.0,
please let me know if it addresses your use case.

Thanks,
Amir.

