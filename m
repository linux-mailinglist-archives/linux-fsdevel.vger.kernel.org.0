Return-Path: <linux-fsdevel+bounces-75544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDQyCM3kd2k9mQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:03:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D88DCE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736FB3025D37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41CE2FFDFC;
	Mon, 26 Jan 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puk6Va9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723D2FDC30
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465029; cv=pass; b=okEQ4SYRZ4+6+xppUVs0H2MQdwGnNHyBX+umtrKGIo6qG5Ia+WNxdbWeZPF/Fh7B/XbfDXu8E0yLDC/BWvgFCcWPgowxcU8GF6XgE4K1xFjVIVey96JVKeYnZWFElvK4PaVGlAsv4Jd7hW4N+atTnuEqzkX9SEIDdkiU3xMPioU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465029; c=relaxed/simple;
	bh=vBeV35fwku9CnFe/OmA75ZrHPb5195tw3FhVtWb96Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAjJA/67RBwpkvlE/ae2TEWFhMXlgxz1s1eqSmV0eTeyUrW0XAnbQyU+vlNptynkF3km0pduENRJyKu2xoW6Jx2aojUB75v4asFHOe49nxwHRFYq+pT0EjVS58PkfvpZArOBWctFU/mzwiGLptFXYzuS2411GYzXJuwQvjzpaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puk6Va9w; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-502a2370e4fso40439091cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465027; cv=none;
        d=google.com; s=arc-20240605;
        b=XNam2NE2zMo5q8FCxispgrPtYbelt0sXfHOzZ98HFG1ZGFes9gOIpACKPH5qRWsEzf
         I48xMNTvBaoO8LM+3XjRcpAW2PNqXW0NLefS9QOW4Eqkjle3TuuVaA8GfudKTyYl/sLk
         CZgdQqgwYmqnh+Sxm7WWrAFttYNXrprRqC9SknhvF5zQ0hDEW8IAxehMPTVkUm174qAf
         h4/jiKjdLSSzoRQjnme+fGbM1V1ftBSnONs0mnvI8JTaW9jdm2h9fhDrwr/mB55Q5HF8
         Y2KUiUrCFEHTk3RkUVsSz1GS5BoknaI+bBHRKT4Wj43XZNBPxXFOoZF1yzhHYqPjV89K
         Gslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        fh=QrCDpLzYJHQ98+crV6cXBKTJT/58PuvfJx+89pmwmNk=;
        b=L9nLfdeVZvvgArPcklM33HDCDboeCEi6b1YMw5R1+Cb9VHxh7zBtf+Cqq5SVrF9Own
         racKPj8rnTAIWpTFcGSIRQj/kFk+DgudoSQeFEmBKYEFlYCuAkQg7EFijSACeLLaAgr9
         j9MjeLzkRSraTI3oh/sEEPZ79Yg1Dhi+pgBCxgcUA/AQXkuvW7ItD+rYNTImJW6L2XoD
         d7sQHGzPb00EUClbVvDxO0i0zflUj1Jw+dVmtlufnTll4OwionTq+Knj/DUxh1Kq9MXv
         o0z0eeZFPqDw0u9PS28exUbCjwGqVfwqZBUXQuYpjg4eRgpndGoyk2BhxueoMPnxH80y
         KVvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465027; x=1770069827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        b=Puk6Va9wl4NqmsOAmOdrkFQkn3AR21ONpytTHOViyZgzofVONMfJtQ2rj3Z8VoQdYZ
         2fZsXxTycFVI9kd27oy5SQVicje2zJ4eaZY2X5t3JkW7HVDazyvVNthm85MDZ2BXbpa3
         R7ULJL4wBlGpqCH13ESIsZgVPhXmlFZNKV7FdtvkBNc5E/BRmrYKN9ZuCSnbDU9UztFO
         KkxmKoYhdtUxe5qOXa4PM74PF5lD8WoZZZoEW/OYSvsobsyrJCEpkoBPVc5Nk3GK47Is
         ojLz1MRcW6jW0WZD+35GOWgUvxYfJJNPnmVaPLayIoqRfOcwsiGfyXPFs/HGzI55QCBS
         FqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465027; x=1770069827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        b=se9U9WE4ZjkjpP8zniUXIi+rE3CBEM5x+2LNJP0Kh8S7jU/IQEYzpfXLTXqCIID0tY
         JPOUtNMGmiOSDfGw8AdICHbLB01QJpaw0XBVSZDWKyWCz6/49OxTMBZqlA0BUhwwQHcv
         M8Yd72CetHXv4VPLW66aFLj/KhvEwMoa1zItDbEFu9woe9ThfVflay/nu19DAlX/p8Nw
         qAlHhcci2CGTlIREZUEbB7s3qBjHRa5NQ1nGpIgUacSW8S9huB6I7c+vwAYO0Vyk9abL
         viG3ITHqhWxIJnU+AvWQUWhQoYLXJEo+jH7U/KvORqp+wfEhC8zxCQgRadK7gh4q1L9s
         DvmA==
X-Forwarded-Encrypted: i=1; AJvYcCVX1vvXmNcsDmjthl1Hi++zahJi55pYpNa41H51ZjyqkDWVQ7Bo1HERbCC4+9luWdwcUu1QMj/ceYrc7C8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3g6nOSW/9AwkRAdGB2S7krp073vJUDLjncDeKiaFuc3NnFfX
	kFLF4demyNuQxb77r8bAW7fI3gADaSJfF7MJulTFxMMTLnAQRzLfHMhD37AFOH5QHjjymk4cVlM
	fPFxqZ2VYs1yYG1dh0E9hZRX3pWCYRI4=
X-Gm-Gg: AZuq6aLB/9X1pIRxRMqZKdMb3WX6M2i/ZTTi9keOOhGuDTjilB3f24GCbzxwy4bbDmS
	EESjWmumseGFIAtv6vIq5mM59+BWiNoikba4vo8YYrApnMQN6u095vbQMikNvF1e3LGLOjtCAeK
	SH3dNNTmoXRgfH/+ZMZQ/UM97Ni5zVi4xZPnzPOpZJTlsPPmN2dnvU0nIzjturTTFq69lKeZu1B
	PRb9VF3i9PvO+3nfTriyQ5rplLKzSSNZHt7zKMw6n2RjCY1ue6BQ+rqbFoV+ggUkPpQGLlCtDW2
	H1WgoJZP6Kc=
X-Received: by 2002:ac8:7e93:0:b0:4ec:f56c:afa5 with SMTP id
 d75a77b69052e-50314bad868mr71172071cf.22.1769465026709; Mon, 26 Jan 2026
 14:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 14:03:35 -0800
X-Gm-Features: AZwV_Qgm806vibKtJMMyXSlZpA5lFonExx42bXZM330YeqybgAAy-pL4OxB8GVg
Message-ID: <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with iomap
 pagecache io
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75544-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5D4D88DCE4
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> With iomap support turned on for the pagecache, the kernel issues
> writeback to directly to block devices and we no longer have to push all
> those pages through the fuse device to userspace.  Therefore, we don't
> need the tight dirty limits (~1M) that are used for regular fuse.  This
> dramatically increases the performance of fuse's pagecache IO.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 0bae356045638b..a9bacaa0991afa 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops=
 =3D {
>  void fuse_iomap_mount(struct fuse_mount *fm)
>  {
>         struct fuse_conn *fc =3D fm->fc;
> +       struct super_block *sb =3D fm->sb;
> +       struct backing_dev_info *old_bdi =3D sb->s_bdi;
> +       char *suffix =3D sb->s_bdev ? "-fuseblk" : "-fuse";
> +       int res;
> +
> +       /*
> +        * sb->s_bdi points to the initial private bdi.  However, we want=
 to
> +        * redirect it to a new private bdi with default dirty and readah=
ead
> +        * settings because iomap writeback won't be pushing a ton of dir=
ty
> +        * data through the fuse device.  If this fails we fall back to t=
he
> +        * initial fuse bdi.
> +        */
> +       sb->s_bdi =3D &noop_backing_dev_info;
> +       res =3D super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
> +                                  MINOR(fc->dev), suffix);
> +       if (res) {
> +               sb->s_bdi =3D old_bdi;
> +       } else {
> +               bdi_unregister(old_bdi);
> +               bdi_put(old_bdi);
> +       }

Maybe I'm missing something here, but isn't sb->s_bdi already set to
noop_backing_dev_info when fuse_iomap_mount() is called?
fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() does
this already before the fuse_iomap_mount() call, afaict. I think what
we need to do is just unset BDI_CAP_STRICTLIMIT and adjust the bdi max
ratio? This is more of a nit, but I think it'd also be nice if we
swapped the ordering of this patch with the previous one enabling
large folios, so that large folios gets enabled only when all the bdi
stuff for it is ready.

Thanks,
Joanne

>
>         /*
>          * Enable syncfs for iomap fuse servers so that we can send a fin=
al
>

