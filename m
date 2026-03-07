Return-Path: <linux-fsdevel+bounces-79674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPh6E156q2kSdgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 02:07:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0632293DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 02:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BE6E30D06BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E95283CB5;
	Sat,  7 Mar 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neM2S6GU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1C15CD7E
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845534; cv=pass; b=S8MrKzSVSraED3/cAp/R3h7ObDmcfHkIgrO+EjYwKZzs6WMOyARWIpc1GpgDK7oGZ9WFJizvzmBVMWGRLy2CGayRICUjc+zeE890gWiERSXG3tbalWYOpCoZ6HKTYlNgzCfsJGPzvwU+tqT2vHjS99NANGSMHzj7CqujpX1+BZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845534; c=relaxed/simple;
	bh=vjcZoew26bNxPZScv29B1/eR+uaWRsDMTKP3R8wOe9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsshjAROIMBOYCJbeXhv2HiLv+iiK+Crj2jW0kHPiMJK091Uk3Nh1qvd8v+2ziKPkqCgdr1u9jO0zhf43TwoFpKoJiJOrU7y3mSHiI60XD0qyb8L97wr1B9m+/mUDk5bUzWtQTL5fAEhfClrT33ts81XXJHF+m7SfFPkAoqZttA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neM2S6GU; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7da9so91161187b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 17:05:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772845533; cv=none;
        d=google.com; s=arc-20240605;
        b=K80Dn8jhq70flnSfkcMWjMsQmS7rQkTGuN7501aZIlZbEbghaIVYKelwxg4nSeXWrm
         Dymr0fqtrG05EQcaIctx2Gb0+GW4PH2KC8mz7VPTyApIisRH0XBHOkgLbScez28rTqkd
         Br4yrLpASnS31+4Ylknj/Pq/Y1fYK6Ncdp2cQY3tJhCW81iDObbj7IR+OioGeccKms+X
         2BYiHthKiNtCjwTt1aK8JDFMiutA9qC1wKye2Xc9ij1zfYBPpkhoOKaGaKFbX5gIgwMK
         Frl5VP2N91LsmDUI6IjBoD+SKSR4Pr6r9dgHt9CVNcL+kNZX5TkYmhEvJUuQXMW3d7ap
         zplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjcZoew26bNxPZScv29B1/eR+uaWRsDMTKP3R8wOe9w=;
        fh=2VdYNjHPalINEr/W1Kr/+aW66rXwAXoAyweIfVu1PkM=;
        b=lKw49d4TLW0Cmx7HuSURWN1qEQ+9KjnF8g2S3tbT1wN3E0PyDxdLfZZ7zYfYcU32Mn
         mINJ9kD/eiwzR78RO1Apv+rnsECNSrc83EJ2g6FZNTr5TbCqQove5U7U7h/SL9vQ9Ftg
         9n9YRD0nHrIucwbbf3htdFZ4pW6QOfViH/j/KC9ClyQsQ7mFb+SBptquar5xAgwHZcZw
         LWtSYD0wkUlM2BwTEHDHci9RSfMVf4WeCOu2MbqkFI5OQTxCQ3ugc5Yb4Atp2T2H7nxz
         bpiCmmHFo4jT1Vo7h39LKEE71vsYZ9TqH71CSePvM931pb2AKsmCrQEXPCs4nNYcy9m5
         1EXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845533; x=1773450333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjcZoew26bNxPZScv29B1/eR+uaWRsDMTKP3R8wOe9w=;
        b=neM2S6GUKxWiSarcfuHIstJNmB/TKDvzqqu0o8E3AaZeYCKimXGS9YsrM0wGGxv31l
         CtDzEBDVwKeQPby7RIfd2pRXnea6TCApBiRKNoaHfuOTg++CltZLHAz0rm7RIbcnQCj9
         Q8WXNS6ZUNmEAjqUpAsfkYOMsAJRFy8kJ6G7zC2CVLbq1kY17i1mXmP8dUCxo5FzfiXq
         Ha38a0w/SKY8eoErIzwyPCMznQKykSFDa3Te39jIwB5zwwczCxMcP45xI4PoBfQjXlqZ
         dMrbnD/zfvLdYOMXu55f8iBdTL3qBS4+EZtEp7b+ZJIme4sLD589Z1vSiK6URaBplXSd
         lLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845533; x=1773450333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjcZoew26bNxPZScv29B1/eR+uaWRsDMTKP3R8wOe9w=;
        b=JkhhKNUZqMpUr3jR6gsSDQmLxsOFfGRZhdc9rs8KLII4b9Rl+ZRqOkqijWoYdWUmHq
         0dk+UxqcjOFwrWp5jL+3oXRZuOZ6PZXULw6CeAQ5rq3BjsoIxgRQhGiZZikViplDQHZS
         W2HqtSV5nCWda/YCbUSIRn5hPgeCfkhRhvtg4Fl0hIdcrRkdB34Y9eoCLCOiBQnVz8/5
         bmbFZpXb9k14dHyr7MzxPndBDcLGlUXkUM4io7tOc/imjBW7479S1hcbdpd4Vs9apDU9
         ZaeBjtsEcA4rfzg+zon/a9Xs4pLgNbc/vS8ZZWFLwLe3jLepNcTzaehBnmDHcxO8gRsw
         B3cg==
X-Forwarded-Encrypted: i=1; AJvYcCVLtCzSK4s6T7i+WbxjchO3nOMUjJerTFe8Pgd7sdS0g4uweWe4rZ5IMDK3cIsDYafc3og1RlAZE1zv1JIi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrqz6nEqWvbF+2IDFIC1j+/IviOWtCRDM4vGp/K5HRVFwJs0MJ
	vAklPJLNFmtQjyuphW3GRezdoM/KpYEwAgMW8TSD6Z4xuzjgdqCHaFCm8Jy3vRV7XqAV+A55kNU
	Oef6GE0CXP8AnST8p9TH8g+8dMjB6JIc=
X-Gm-Gg: ATEYQzzli4hX2DmSW0qQ0TSgQ0+bMOwtVAQEAZiG4Unuc12nwVb+L6leta/A1QZjfoE
	4F/tVvne6aaLGUSpCNmuafvyniwZgDhihs3GcMwRU5vaEXEWH//0c6dODmM2AZ9PvkUKhXvviCS
	ifuv8JMpS2ARB4yvPKlXfdLeJoPg4S9kj1zfG88rUvLxNRmUDQd7uGPU67g+cQmYyELCoabJJLA
	hgkRN4p5Pz+yHSlHkkFrEt6Eja941mDhRnNtazMlzmRZ2hYjUk0paLffVty0rKgM/4VROxMe58M
	1p2r88LZr3h9igpT5a5CmI78/ahURJr+ijnjiXEPJFVcAmMDTT0EQCaDUsh8SN+gekfkssrD
X-Received: by 2002:a05:690c:6b01:b0:794:d887:7257 with SMTP id
 00721157ae682-798dd6b069bmr41471177b3.21.1772845532703; Fri, 06 Mar 2026
 17:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221061626.15853-1-kartikey406@gmail.com> <9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
 <CADhLXY4Of=3ekg86ggi68_VEtYh6qDr-OtfP-D3=4mc9xm0i+Q@mail.gmail.com>
 <87pl5ua2iv.fsf@posteo.net> <f2aeba13de5dc8ad493972ca1f8e35a251d97a93.camel@ibm.com>
In-Reply-To: <f2aeba13de5dc8ad493972ca1f8e35a251d97a93.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 7 Mar 2026 06:35:20 +0530
X-Gm-Features: AaiRm52Zai_bjRkpRzbTF04gh3LnQqDwzKaRy-xYwgB6LrH3cFEYfY130yyZHus
Message-ID: <CADhLXY4XQW5RyspdSQ43y3UVM8D6z6HuB21V20A5sD-M9itg=g@mail.gmail.com>
Subject: Re: [PATCH v5] hfsplus: fix uninit-value by validating catalog record size
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "charmitro@posteo.net" <charmitro@posteo.net>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AD0632293DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79674-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:23=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
>
> It was my expectation to see the check with HFSPLUS_MIN_THREAD_SZ constan=
t. And
> it was the reason of my confusion. :) I completely agree with the point. =
It is
> very important to have the clean, simple and easy understandable code.
>
> Thanks,
> Slava.

I have sent the v6 patch.

Thanks !

