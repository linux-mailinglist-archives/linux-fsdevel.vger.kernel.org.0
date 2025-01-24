Return-Path: <linux-fsdevel+bounces-40021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05010A1ADBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8613AC921
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FC1876;
	Fri, 24 Jan 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="qb0neKIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F5635
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737677262; cv=none; b=qpyAwSM4cCW5hfnltD7KlZ+4baXaqwpKCB91R3VzYIXwoSxHKpGPLna3n8Zbf0vFFER0KM+i3lORrf3zi26u11VgT3ITYwO+jE1c4meodg+jwOzqcHmTIu0PYKxpvgX7BuKTpQKGpWX8+cMN10YHSQgOsUpqCYeZFAKjiiZaUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737677262; c=relaxed/simple;
	bh=ge5uev0Veaj4DLFV9wiJBIHi1UbXozm+oih0noenQ+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBFrnlMzyMGduuGjv/hLyKIzJ6DbSlpioTyS3tHSO6+UMl7SSV2eAIJNcI1LzBcuHjpHpSEVFQw6igWYlTU+lZkLzMpgirxBfP3mzzplHA7dkZ+Lf3a7wdOK1vevk2lVAwlUFCF2ASGGhqrBo6gyrf3m1f1Fl9xJEeDL+a24Xk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=qb0neKIk; arc=none smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NMFekT035264
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=g
	e5uev0Veaj4DLFV9wiJBIHi1UbXozm+oih0noenQ+Q=; b=qb0neKIk2uYLRmv1S
	MZj7SxuFO6KwBX/KNwfSAImM8VojAb9BnzyMOOz25pBPCk/jhefWzFTr1QEqq0gg
	WEJ1l+o99V0fsgA+NYxTnbCjoWbXn11I6k6LX2C3DXMDDeibch02Fy7AomM1tSBR
	QuYOKCwsObssZuXAgQRSs7L8xbTS23y1+dhPL5x0uEYYS9uF+4l+c9ZTLFMrpE57
	+hFuAp5e9k/rKpzsG6+Rc8Uk3ITOHCNYF4hZyFvVzi8T/9JrPPX+brAH8M8hd3Vr
	blPMEyNoujFHiVT+l25WttsWWO63pZ84i75Epymscyc7PsudcrdPme9Qr1RCPZxp
	cgQDA==
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 44bm7wu22q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:07:38 -0500 (EST)
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5428d385b93so898429e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737677257; x=1738282057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge5uev0Veaj4DLFV9wiJBIHi1UbXozm+oih0noenQ+Q=;
        b=eGABm9D5m3tp6V/N+vE0WsluPeWoT/nsgGIyHiipkzTmZ77okwochNe+LBy30ZiSfy
         y8f22uQ/AI88a3dAypqJ7LRhueNB25yilPecJVCW8w5eJq2vlnTs3Uq/Mqbxh8HF+Id2
         rs8Pgnl30duZwLE8uDX2p0U664V+bjfKDXc30+jBt++tzp2pnEPsHqIPFWsiSjPmoZAT
         gkEaYUjxtWEH1l6nO95TZ5JFzft2J+fYb4/08oQR2OlTNwR1AKPK0mSl+IL+3XeeOIG9
         XvwaBGZJjLTtu8nWGuHoUdqQcKexNxqFI4aCungRsoUdr+QSw9iTfqwx6WTIchUdw1K0
         f9AA==
X-Gm-Message-State: AOJu0YxAZkOvLDV3vV4GCgfPko/g1Fs+F79b7pOuBcs874rE4a0bwDWG
	GJ32Y7NoChJD2FymbIsFQKzVNjkIhbI8uwjcHc8qF7EioE8TVSp48f+kKD5di4D7bw5mlWpFlCe
	FjVWW36XQUXz2qdii0u8o+LhFf2ZGGm4oojHk2sfUVVZ0pQP2TgXI68ZvVwTjztkf+pvsoIdtZ2
	Suvfh2RSSwk582tdwsJCH6iQvr5Xk5Dji5wRw=
X-Gm-Gg: ASbGncu6nav2FvPtrujYHzZmBXuJngUY2p4Flca6PnnxmkHXBJ3C/AAnR4hbJeBdVxZ
	VRn+WmKOhb8axmeRGhA3oeSzStZU9tFk00XitvU7ebk7CO9RpooU=
X-Received: by 2002:a05:6512:b83:b0:542:9883:26f with SMTP id 2adb3069b0e04-5439c27d314mr10883809e87.50.1737677256828;
        Thu, 23 Jan 2025 16:07:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyVf8AGU/7qYXHZ1+iE21S0PcsJ1Irw3O8vNXLASZC5Bwe5WhQQfUCRGxKB362JzBPgEz2di+xsqI3HsQKQhQ=
X-Received: by 2002:a05:6512:b83:b0:542:9883:26f with SMTP id
 2adb3069b0e04-5439c27d314mr10883804e87.50.1737677256450; Thu, 23 Jan 2025
 16:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
 <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
 <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com>
 <CAGudoHHWhUOcBNUu8WboxGFrb7nyBuRCruJ6=xT5DPaJ_xyd=A@mail.gmail.com>
 <CAPbsSE7QjCAtugQG=BH0n+nMUQUDnA7WznXCHqvkBfj304NpnQ@mail.gmail.com> <CAGudoHGkFhOZkrW6Kf+0Q-HMjDa1bCvT+JAtfS6F9PFiU=gorA@mail.gmail.com>
In-Reply-To: <CAGudoHGkFhOZkrW6Kf+0Q-HMjDa1bCvT+JAtfS6F9PFiU=gorA@mail.gmail.com>
From: Nick Renner <nr2185@nyu.edu>
Date: Thu, 23 Jan 2025 19:07:25 -0500
X-Gm-Features: AWEUYZlUsXV8o5ijKKUMAv4w6uDAYogKZcszIC6Qtd0mNznF4R-lOTTA9B_13_g
Message-ID: <CAPbsSE6dKge7kKFLk+jZ5MpTPj8Z-XHiUF8JtGKzRZ78e25AnQ@mail.gmail.com>
Subject: Re: Mutex free Pipes
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: r0-H7JtAuVz8nFKY78eKL_TPQfJOOiWa
X-Proofpoint-GUID: r0-H7JtAuVz8nFKY78eKL_TPQfJOOiWa
X-Orig-IP: 209.85.167.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=657 clxscore=1015 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230175

On Thu, Jan 23, 2025 at 10:11=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> Keeping all the capacity constantly allocated is just memory waste.
>
> On my laptop alone there is 277 pipes which are empty vast majority of
> the time. This translates to over 17MB of kernel memory which is not
> allocated just in case.
That's interesting and seems like a strong counter-argument here. I'm
having trouble finding references to how much physical memory the
kernel actually reserves for different systems/configurations. Do you
know of any sources for that?

> The real problem is the fact that the allocator is dog slow. Before
> even considering not allocating these pages as needed, one would want
> to fix that.
Also makes sense, seems like possibly a rabbit hole.

Thank you again for all these replies!

