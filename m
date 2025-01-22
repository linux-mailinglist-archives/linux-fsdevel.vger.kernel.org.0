Return-Path: <linux-fsdevel+bounces-39816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C9A189E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 03:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8770D188C445
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75013E03A;
	Wed, 22 Jan 2025 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="QHc7FBKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231D7B3E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512865; cv=none; b=cLnUiyQuqmPlWCdJl6Z3+ne+sAk/7/GvD7cbGplQRVqm5+57oW+SEJfEmcMcsaq57OUfoIrVqAoWOPNj4Y0hw16pvrUjhiBDBvQ0PeEfvzkp1dSDSBGb3Cw6uC7b5z4fE7I8d93CtK8eLaG6Sid7kzLKvKEh2AaHGNfMyz7Uzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512865; c=relaxed/simple;
	bh=A80RYz+ULTQWb1EhqiFvaplTGLBWc9zBE4XBy7HVutQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmFB2syRD9/8Jl8gF7nBpuwKBp/+WMMx57U0Xu9OzNmnhKkKYTghFjfRlr1RhInOoxshodlIVR0rQjEB6R5uDIUoargJ0mjOwqeNDNarlfB7Cjit6StRSQeW/NUCN9Gavxt4jkbZuqksf8dgt5fvuHNmEwFX7MR77gPcglmKG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=QHc7FBKg; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LLtiCm017477
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 21:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=A
	80RYz+ULTQWb1EhqiFvaplTGLBWc9zBE4XBy7HVutQ=; b=QHc7FBKggEhRhBJSe
	T9Hf4SRgzz8oIzOuqb+dKD7EjsBboMs19ek+IHQRgJlnAHlnqfMFvhkfSrgF+ZoZ
	kvWkWWpgQBAbn1fFmLhcs5GbS6FN/fZ07F/buhXFWqoL+QBf38ml1bMDTzdATprZ
	wPbcsAD5qGd8hRjk22deASPt8ygQ/m6sw9h0H1a3qY1PdbDxaGQbWDdxpexX5IK7
	daI33sFQPBqIu/QplVmdlRWOUmoLFAxp+znR+WM7DlwmNd5YMayr1mkyPmlyIJrk
	NcXFVovtwBAh3oNta7b2scvDDDZQxJk5na3QQc4haAiK8JXwbM4ZuqqZ+4D5kI1c
	exFDw==
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 44ac5jm983-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 21:27:33 -0500 (EST)
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5426f59d5c0so3659040e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 18:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737512851; x=1738117651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A80RYz+ULTQWb1EhqiFvaplTGLBWc9zBE4XBy7HVutQ=;
        b=rYMwHJimpbHiSX96YksdzekzaPCJhtkQ+8bWEhmLcUiMXYLYeHueaCYegUNlh2Rio2
         wgGBHMTWX2/8WO7SAVoN0nhpq4qz40u7HxSynEKZ/vkFywSL1dzfunEPewp7qaweSJfT
         TIEkJ0qM9r4RfPeX81kcrVxvUW6KrNQuK8yDM5PDEEddWo3y81tI/aRtrbN7+a4GiDKr
         aJFV/gWYpQdGHr5ZQuTR+sfMLbNI6AhiH/XWQL+Uk4xhPZWFeadk35L3ZEWNI2kfY0l2
         rn7Xd4hmo86ridcq0zyF6cTssNyCIfExlUkEaF3YsvdSUf7+YSDqXaJLf1BZBfQofu+t
         rLVA==
X-Gm-Message-State: AOJu0YzCBGSRjMYQbEs5Zb93DEl1AfFKXo0KL4/FrgYmIm5a3bdMuV4W
	YObPPWhngx87kljfTsJuR8ZYLgFGuXUf+QrynpMNX9JdWkQUULBl3S1pdPyBeRQglGVoEijF+Qc
	Otf82Q2w6fmBwUQdJLD957jCLunb/rcEFBLYO4/DA0xet+/Qu2y56aq6lzBB4/UQGUWfs42Bivk
	A31xNMf6l2qIIsqKLNfr7id4ZFop9uYPpvx0dpXGVv8iG58A==
X-Gm-Gg: ASbGncvkDtdp7E9Ux3gSQVnogqS7S7N5xLmLYUTvvGSCkh/cVBliR/3AYWw4+UkiJyF
	pPEbHSwXmASYj23rQpvS4gJda9EdCvgS0OTDEWwmpWa/8G4jSypjVUGYPtzDbkN/S9BKbeT/RT/
	ECfv37BdnmRg==
X-Received: by 2002:a05:6512:b9a:b0:540:1fae:b355 with SMTP id 2adb3069b0e04-5439c281128mr6591387e87.52.1737512850729;
        Tue, 21 Jan 2025 18:27:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF28o7EmzKKkHTmLsC0VESnWxUY9tibXk3kfl2o+6ANGu08bJPBBfaD1QrLZhFNzjsKjWF3GYM5G1b+OtsOEPM=
X-Received: by 2002:a05:6512:b9a:b0:540:1fae:b355 with SMTP id
 2adb3069b0e04-5439c281128mr6591382e87.52.1737512850330; Tue, 21 Jan 2025
 18:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
 <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
In-Reply-To: <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
From: Nick Renner <nr2185@nyu.edu>
Date: Tue, 21 Jan 2025 21:27:19 -0500
X-Gm-Features: AbW1kvZjhfeULgJQAhlhPW4R9EnFZeuEF8Yitrhd4ylDyiWVQxzhdoyFzIHj9xU
Message-ID: <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com>
Subject: Re: Mutex free Pipes
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: UB_SS9fIcTQ-qUxZScY2fUQTwlpL2cBZ
X-Proofpoint-ORIG-GUID: UB_SS9fIcTQ-qUxZScY2fUQTwlpL2cBZ
X-Orig-IP: 209.85.167.72
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=546 priorityscore=1501
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220015

On Tue, Jan 21, 2025 at 3:34=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Most of the time when something was done it is either because it's a bad
> idea or (more likely) nobody sat down to do it.
Ok thanks for this. Realistically seeing if theres a real answer here
was the main hope of my post, but I'm assuming you're probably correct
here.

>
> Note that pipes allow for an arbitrary number of readers and writers.
> This is used in practice by make for example.
>
> kfifo code you are mentioning explicitly requires locking for that to
> work.
>
> Also note that consumers are allowed to perform arbitrarily sized ops.
>
> Maybe some hackery could be done to speed things up on this front
> (per-buffer locking or somehow detecting there can't be more than one
> reader and writer?), but I don't see a good way here.
>
My understanding of kfifo is that read and write operations have to be
locked at their respective end when there is more than one reader or
writer, but the data structure doesn't have to be globally locked.
This could be accomplished with spinlocks for both ends similar to use
in kfifo_in_spinlocked etc. Pipes already keep track of the number of
readers or writers, and could use the non-spinlocked path in SPSC
situations. My assumption is that a majority of pipe usage is in SPSC
situations so allowing for this much faster version seems desirable.

>
> Can you show your code?
I don't have this mocked out in the kernel yet but my plan is to
attempt this over the next week or so.

Thank you for your comments!

