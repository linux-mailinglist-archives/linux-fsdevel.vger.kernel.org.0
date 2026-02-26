Return-Path: <linux-fsdevel+bounces-78656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMmDBrrRoGlHnAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:05:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152A1B0BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6676C3031834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8A38BF81;
	Thu, 26 Feb 2026 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MngdCyGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E2326942
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147113; cv=pass; b=IB4IXXNRoK581wrKhp1AE8Wxl9bILmUC1WXqVhsiRVjLS+9J7OdfCoeg5UgVclnO3NixOr6rhdlJ8b+21ax3he6R7E9iQsIPSON81rD0C+gj58liwA1NBY5jUZACBLZuURt9wnxRL2tRevdIwcJsT7SObEPyLn3rpz+9tofhKaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147113; c=relaxed/simple;
	bh=4K5YGPabkZvQyZy58tkV2oQCb8c6qZD03nIR4wIrckU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLTJQmiFuVNL01U9z93PsCBg7c3v/LhNxGLFCMfQ75qSqPxdjR5QSOsHfxmv2FYlGRP59TEhACzSX9YQNbakytstMz1TyuEkchpevQ6XqlVwwJ7aejPSetnVvbCS+GguihgPqg3m+sjcjcHaW8++AoFtrLvYMXTRfWabBBBYK1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MngdCyGN; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-503347dea84so16797671cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 15:05:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772147111; cv=none;
        d=google.com; s=arc-20240605;
        b=QSSxxrh83FB2mGgGHksIYgbrO8/kXjLGGxVaGGpccHl066N2UciYeTemINPXDH3LT0
         7MroQZsyHbGrTsy2Goy/5gQezQN/LazwlOdH/H/tezkc2zm1rOX4xuH0biaZyUsCVCG3
         PDeQKUjXQnspbGKHmEc7Q8pRXo5Ln18xr+U5tHx3pfM/y0+fYxzGMPbLOWiUdB5wfiX2
         A3TC0gqSeFgMDZvaYY0TOwcvbvb/XWye9tTvKqAhgXYYpgPTy7ljvqqqC3BANfb3zXhA
         vUXpNXHtyiLVot75Xh1wPRYJNjDLsW52j0+7kjQ0QtVyTVtft+hZ1jI19G7azI8yFy+M
         VjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMT1crbYSBRFZxDVhGHICXjBW8vvKEYJ0DTMCQDicec=;
        fh=aKY6jYYzH7gRtQ2cCK++3DP1G5IeT3WPmpiOmdCKNnM=;
        b=CCNOk4OHqLkaDLULooSiK9fTk3NDnurEMRL6i8UMsgHV0H99gQFtSqYYmVDQEJgPUa
         s9FFT4Hkn+k2jRd1AhTQ/Xe8NB5RDd1tOX/2CdrrTBshVn7d3QeSLMnNqDCff1JNYRpY
         jB2ARBqQQ/5d3hg6fL8GUASsNDftSjYWPeR0lt1UpNX8YEkoDf1sr1LERCT1MjTfTowq
         cro7d/kQqlH/hn2QXrO4tGuLfSl4ep/KbrQTj4osbdaFcSdJp9pCeucxYXW8LMOKzDd4
         Vis4oap+kX8z3XnKdTYcT+SQyMfFesNU1i8zEKCqqB5SB0QzQ5Ln5GDWQBYGRDLfOWWK
         ZWdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147111; x=1772751911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMT1crbYSBRFZxDVhGHICXjBW8vvKEYJ0DTMCQDicec=;
        b=MngdCyGNQmcmohkeCeGKzQn24YXYFR0Z2rVtZgQVp8spRsNWJTh3ue9HdxBZapvTjc
         ouh8arcDe2VI88nHWfglK5nNnFOAv5lNeqo304mkuR/FtR+g296ijrw6Zz566vLUhZMZ
         1YGYq6in2VHFzVGwgXJ08rbaV8TW4MOMMC+PCYrYoBFeuE+B2RIper/uPFRKwoUHTj3X
         zDFksnXx+OjSNI6QvONDOnsPXn2K6VjVYaRVq13Klyoi1SgbQCw0Zk1r6fksr0aELyzN
         viHGBzy+nYmXtACWamCJQJk4lDrcLjgOQcOn3vz7XFWsmLqBOb5lyiB6dOl2+D601wEW
         WfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147111; x=1772751911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMT1crbYSBRFZxDVhGHICXjBW8vvKEYJ0DTMCQDicec=;
        b=nh1QH/AA4WUzAa7R8Vg/cgtzxcTzHDD57Z5d1YW/NXWIE7Myrjs7K4Laj7jETaM9lz
         ZpllJb75of31U5WnvmgcIfRGjLIEez+DC6UojjeXr4NkQJtbxHG8nV0Btyrnwc4ZGIkK
         9P18mY47oE9J9pZk6II4gfIaP3whpDBM2XmKQBkZj6Uxge+vy6CljdqcO7RG/pX+4J+6
         STJDsNMMBdUv8TBF8YSx/IOTqGS4CpMZdL8+16LFfhgqnmGIHe1BJrvoeDvyH+R6Kd+g
         3maF1OT8tQDHezCiMcAlpUT3mlczEJjHhPzUO1VyyiiT4raPluYHTrxF1Cuy94+QgJ8v
         +Wmw==
X-Forwarded-Encrypted: i=1; AJvYcCXRC5zKjvNyeCgrBE2DQ8jw7S6TxlYt+sEiT5e9UjEjzD9Wwgh6TvPh8jJgeQS6xM2EPmqjZM6NEut/mPZ5@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/nF7J3zgi7H+ja0ghsPHbrOpxFwAiViQ1iUXa0cDKYfJLnte
	/13wGmMOV6FgIIJ06iia9pxzdbXkBqslndLI6jzocmlW6Mgp2d9We/hx/wEZcectOGm81wRrSwG
	/gCJPtJwypznJ6tCHu1nWyqfDV764rUY=
X-Gm-Gg: ATEYQzxVhN6tFiFx0AioUkBlJfixKgHULDTSbixJ0s1uH6kWIqqD0MVcQs/V12lG3PO
	1xDOkudSVVy7fboYtijsMDmJgpN47tQAV3k43MzwE/L1hxl2XLUbEpHrHxfExomihnStkC7Fazw
	ssxPpypuRzi3X77bjs07oyXtl9nyU5uBn01Hu/WVyX2RpSRizGYjgt5FbDAghx4F4mN7kSN0Efa
	vx46CSYBjUy2TSYi7b2+1dfSjDIZ5WdVS77Jy0RDqi0a4X1grq6bMXOflWTqxXxIWtkKZTCXLJf
	L8D7Ew==
X-Received: by 2002:a05:622a:a70a:b0:506:1c3b:c8a3 with SMTP id
 d75a77b69052e-507527824a5mr7777371cf.27.1772147111405; Thu, 26 Feb 2026
 15:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com> <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Feb 2026 15:05:00 -0800
X-Gm-Features: AaiRm52oMarlGwA-25EIYUYWoBhU-RrlGtCF3if3tR068hAdRZ_kfa9nMFRlfFc
Message-ID: <CAJnrk1ZjhgGtZY556C3wptdw7uJoo8kuakfTvkQ-D3LzV4BkHg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78656-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.com:email,ddn.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7152A1B0BB9
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> +{
> +       struct fuse_conn *fc =3D compound->fm->fc;
> +       struct fuse_args args =3D {
> +               .opcode =3D FUSE_COMPOUND,
> +               .in_numargs =3D 2,
> +               .out_numargs =3D 2,
> +               .out_argvar =3D true,
> +       };
> +       unsigned int req_count =3D compound->count;
> +       size_t total_expected_out_size =3D 0;
> +       size_t buffer_size =3D 0;
> +       void *resp_payload_buffer;
> +       char *buffer_pos;
> +       void *buffer =3D NULL;
> +       ssize_t ret;
> +       unsigned int i, j;
> +
> +       for (i =3D 0; i < req_count; i++) {
> +               struct fuse_args *op_args =3D compound->op_args[i];
> +               size_t needed_size =3D sizeof(struct fuse_in_header);
> +
> +               for (j =3D 0; j < op_args->in_numargs; j++)
> +                       needed_size +=3D op_args->in_args[j].size;
> +
> +               buffer_size +=3D needed_size;
> +
> +               for (j =3D 0; j < op_args->out_numargs; j++)
> +                       total_expected_out_size +=3D op_args->out_args[j]=
.size;
> +       }
> +
> +       buffer =3D kzalloc(buffer_size, GFP_KERNEL);
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       buffer_pos =3D buffer;
> +       for (i =3D 0; i < req_count; i++) {
> +               if (compound->op_converters[i]) {
> +                       ret =3D compound->op_converters[i](compound, i);

Can you explain why this is needed? The caller has all the information
up front, so why can't it just set this information before calling
fuse_compoudn_send() instead of needing this to be done in the
->op_converters callback?

> +                       if (ret < 0)
> +                               goto out_free_buffer;
> +               }
> +
> +               buffer_pos =3D fuse_compound_build_one_op(fc,
> +                                                       compound->op_args=
[i],
> +                                                       buffer_pos, i);
> +       }
> +
> +       compound->compound_header.result_size =3D total_expected_out_size=
;
> +
> +       args.in_args[0].size =3D sizeof(compound->compound_header);
> +       args.in_args[0].value =3D &compound->compound_header;
> +       args.in_args[1].size =3D buffer_size;
> +       args.in_args[1].value =3D buffer;
> +
> +       buffer_size =3D total_expected_out_size +
> +                     req_count * sizeof(struct fuse_out_header);
> +
> +       resp_payload_buffer =3D kzalloc(buffer_size, GFP_KERNEL);
> +       if (!resp_payload_buffer) {
> +               ret =3D -ENOMEM;
> +               goto out_free_buffer;
> +       }
> +
> +       args.out_args[0].size =3D sizeof(compound->result_header);
> +       args.out_args[0].value =3D &compound->result_header;
> +       args.out_args[1].size =3D buffer_size;
> +       args.out_args[1].value =3D resp_payload_buffer;
> +
> +       ret =3D fuse_simple_request(compound->fm, &args);
> +       if (ret < 0)
> +               goto fallback_separate;
> +
> +       ret =3D fuse_handle_compound_results(compound, &args);
> +       if (ret =3D=3D 0)
> +               goto out;
> +
> +fallback_separate:
> +       /* Kernel tries to fallback to separate requests */
> +       if (!(compound->compound_header.flags & FUSE_COMPOUND_ATOMIC))
> +               ret =3D fuse_compound_fallback_separate(compound);

imo it's libfuse's responsibility to handle everything correctly and
if the compound request cannot be handled by libfuse for whatever
reason, the kernel should just fail it instead of retrying each
request separately. I don't see it being likely that if the compound
request fails, then sending each request separately helps. This would
also let us get rid of the FUSE_COMPOUND_CONTINUE flag which imo is a
bit confusing.

Thanks,
Joanne

> +
> +out:
> +       kfree(resp_payload_buffer);
> +out_free_buffer:
> +       kfree(buffer);
> +       return ret;
> +}

