Return-Path: <linux-fsdevel+bounces-77869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKfzADCummmUfwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 08:20:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717E16E966
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 08:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D77B3014430
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768281D9663;
	Sun, 22 Feb 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtvKFVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E1C84D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744796; cv=pass; b=s884WRF4vXGspaCnINHtXS71hVN4YklLEgLOZMpHWfJz5paTcrfoQqH3gF1PHlZsi4r/FZ6ODtG3F3SJdh9glDlyBzPrpiz5V9W0tj04jF3Cin1NmIsSsnyOtfbyHsdkCJIByNuVPW7lDw7dTQxCHmxqRrbBXjfCnJowQJRRWk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744796; c=relaxed/simple;
	bh=0lDfK3AuaNxxPB1Mx5JPD44YULX91cix/sE9XtEee8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdobE2f49SmPRRSGPjrUB2uGZU9+5EIYVxLPKfWcrPZtcBO93acWtv9mUcbr4owAudTUvK4e0utsD8lppXfDmsoMOYJk8xkQTgeVBxFnlFCruAj1e2aKIZkaXKX88sUUuJvANJjBuxguomLZbuwgoTGpWBdOFJ0/lKFdRqdHpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwtvKFVx; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5663724e4daso3399092e0c.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 23:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771744794; cv=none;
        d=google.com; s=arc-20240605;
        b=S1TZ3zSLxs4UTYs/OFJSMOYBJGLSrcR0oej+IEy597r5YrDdXIxaZ5e6AKtGr0CsOS
         j7yNwLbrdEEnwkHtOrSJE2e1WdNpboeVnt+hmiJBGZIU6jJ5jyn+0DZxPH8Qbgj7QwtU
         pnxIZo4935RgC5OSbXMRcqT8QIWr8uH3zfdjGDTXkxO2ncuMqtel+gMqLD0hRg3R2qNl
         K/3rBkA+oJ8TH6XYOk4/ZtyOPpYs5ZCsQC2M4wphIP1cokNw5ioCiexXxXniooPA3Xml
         sZGNlVyxLtCxvtGfmU6Zyyj9N7uvTUJOxF7+pXRKhDz/k+w3qsEBOyqv1H2v4sbesGU2
         08Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        fh=3YSR2/Ytq55m137y+AsNojh9bx31MWdepkJtWiYTQyw=;
        b=heXpGp6Q9DSadaSIrID5j6PkN54To+YPXIHBybCVVdQQD/NkOMmB3Bu0jCoLuKad41
         LYpRFI1U5IOrbWkhSTGGFh2dgQR++Gw4n1firFftd48xogW0NDlawr01Gzsm+WfV0K8M
         f+W++DdCFe5j9ON6GLVNC/G+G1m33CYMCfkddt1LRM/Z5blIt61ewOLJUmdKYPpnu6sX
         L8L8AsjAcD43+AneDQp8E+UKxLG4QPuTgLRu+jbklYyggbCUenYfro9Hl5rPCM/eaghI
         kwmxosrlnvPVzhWqZabsOxOCEVmgIaAziMZ8frbFkJRGW/kUH+pEuBS22THhH+rHwqOv
         9nFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771744794; x=1772349594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=iwtvKFVxJY411/9ogEeNuKuIL+swHngOLh4yrtBI6Td3Zvrhz9GAxS6djLXc2BeeOf
         nwptn4OPwALolDkNO4yfUKWVGz6BTUQ/ZjsrhDkQelUcEp3u211ABAUwyaGfWUa3xyIl
         8TncN5e/ul82aK3psRyH0mTUkoioWE7HxKEG5Tl+V4ZPPo1duell20yNXLiz/uGQbSYH
         7yGlXL3++eZgdVawMupcKZlupPjYixQ8Rl23W+szYf64S6Jow0ieM/ciHxBMW07CFwOu
         mPqgTy21kVuM+pHA2DPgrWsLpiGUpwbZYMi/pXNbvGHP1UIGZhLEeFn1TM96mjwZUN8t
         bpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771744794; x=1772349594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=PQXAnuqS0FGv+FslNSkJay8/hqeLM6WUvIyjqd2H60i113p61v81+/YRuN0T9MD+NY
         O2Qn2ZM3dUpvHHgimpG5zMN0BW3w1DNKb4g/qXAnHqXBIVuYjZEodl+y7BO/3GdUXiii
         bTAjmtn2vOIyuf03DQtiVP4R7CNPk91nJ59etg2PW9ha/EzlyxHp06cgkCGlBUNKi/i9
         ITxb+wh1Dj7he4Cx6KK1c1EuB2Dy8xVxV0Bj+eoBeI2klfHz2NrjCtNJjPmzx+yN82o2
         PTbUyGaCEUCtwbtcZYCfGg5pcdHY1QDMgE2XJTUw3rw63gs1sHUgRQm7Ib8brDaZ/fU4
         5zsw==
X-Forwarded-Encrypted: i=1; AJvYcCWrasPCOEs6f2ktYB3b5loaRUi+ewG59//wTmmLqnhS8DVRCVSoMbM+XscQATbGs3mVbQSaUgJRt2fNeGpB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv07Hg2dbpmYi+izc2DMJsfWOhXXI4o7PIZbW1r3Ky1aeqDE8+
	oZ9rbymVs2gN/jXJvXyFrfmmOgWWwZIF6fHNfkwwI8X9JCp6pWu7noeaSgo7cg56vX+Wx12R/zj
	hpBYstDvFjCd+AT+TbeyUrpnNtp2KTeA=
X-Gm-Gg: AZuq6aK01+amoROe8SjmhJCry8b0/qM5R8usstFCaYcZEmrKoryKSfpEg7UspItulbg
	l334lVicPbE5lQB8NEFwZwJO5UNHOvHWnqgjvUkVlE9MvRujGDOuNPTQ0tojYfmQvR8CS5I5fnU
	/LdJoNInBpBB+S70vS+uXeT0x9BzLckhoJts6dip4EguYgLJE9gGsNnlcTe4fldG7nNjXVTHQ0B
	iz4tI3z9wsE8nSHdtUA7TbQIHug1vP/IYz04SyOB4s4PEc4KgtupoYPmypdsTJXw319MCslIvug
	eTiPPSxDfkWStTT+sLNK716yBWbTa1xE5EPDYrCc5eWDXvaYGJkZnQ==
X-Received: by 2002:a05:6123:2c6:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-568e489e04bmr2702083e0c.13.1771744793575; Sat, 21 Feb 2026
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
 <20260221234553.2024832-1-safinaskar@gmail.com>
In-Reply-To: <20260221234553.2024832-1-safinaskar@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Feb 2026 13:19:42 +0600
X-Gm-Features: AaiRm51yAd7WZH0JTtET-y37usKeLDtT6X5Vgs22uOg_jqenzkdmMaQOnOQPf2k
Message-ID: <CAFfO_h4dNydbmKSTP8uD9X6ouEZTyJUGoTBXrEHWeHtD1B=p5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: Askar Safin <safinaskar@gmail.com>
Cc: ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77869-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7717E16E966
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 5:46=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > I am not sure if my patch series made it properly to the mailing
> > lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> > series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> > The patch series does have a big cc list (what I got from
> > get_maintainers.pl excluding commit-signers) and I used git send-email
> > to send to everyone. It's also showing properly in my gmail inbox. Is
> > it just the website that's not showing it properly? Should I prune the
> > cc list and resend? is there any limitations to sending patches to
> > mailing lists with many cc-s via gmail?
>
> I see all 5 emails on
> https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-=
sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .
>

Yes, indeed. They showed up after a while.

> So this was some temporary problem on lore.kernel.org .
>
> Sometimes gmail indeed rejects mails if you try to send too many emails
> to too many people. So I suggest adding "--batch-size=3D1 --relogin-delay=
=3D20"
> to your send-email invocation. I hope this will make probability of
> rejection by gmail less. I usually add these flags.
>

Understood. I did not know about these flags.

> If you still expirence some problems with gmail, then you may apply
> for linux.dev email (go to linux.dev). They are free for Linux contributo=
rs.
>

Alright.

Thank you!

Regards,
Dorjoy

