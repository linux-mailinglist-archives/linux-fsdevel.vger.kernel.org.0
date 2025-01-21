Return-Path: <linux-fsdevel+bounces-39751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C1A17544
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 01:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB37A22DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 00:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB3C13D;
	Tue, 21 Jan 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Z0fzP7Nb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C96EBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737419987; cv=none; b=I68AJ/v7FPVMfb4AIPba32r/aoh7L1v3Az0ZViaA2XU8R6SWYEiMsB8IQLE3aiKNArZSAHj3JhTaHrB0OfBFgw1RkCjlaVGJzAs+LPCWldxZ4oceBGKay1xEYlfOU+fjuWSG+H7xPze4H96FZzJTiFMgaJHMnafNQ7Y28aXf2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737419987; c=relaxed/simple;
	bh=KnSjXMmCUkqvr5kxnJNOEq51fuG8cdrrxxa0ojHLblA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pcYn481ekUNIB8nZVw9xx7xmcGrXi9z64cUZqbcsEBJswybBoaKp6YTKwLfD3/37l+MrByK6ylpw1JjUG12YQLxpSCc2beh/J7xlUtY6cx8ddik999doWn1N+NoG+vrYpcwlc/GdqzuDxRXFiAfHxl2CVSgoL/N7J8egEnnW9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Z0fzP7Nb; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KLnltI028689
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	20180315; bh=KnSjXMmCUkqvr5kxnJNOEq51fuG8cdrrxxa0ojHLblA=; b=Z0f
	zP7NbDT/jSb2thTlm/JSGodqH31TtW/BOHU/ILbcjZby6Ec1Gw1jJMp0n1ecifM7
	EDXTEsnQeEU51xePp8q4W2HMmyK6q5VqpkY9keYlmFBhARSoyiuse/mnv/XeyTAD
	ZNr0iFkJB2CBz3+bcr1Dcb0mJvoY9mUIQGWh0jD6omcxngZzfxqZI+v5z9Q0NgpL
	nSNw8x3En2HARIA/b4M7EWrb/1Gn01FomC11v8oONX/XoUSV2CFdQzHDl0Rfy9nF
	pvZjIGDpsUgEEMCF5RMVZxoIMjbEAOS6SviGGUxl6gi6nB1UI4+IVgZR0hUvDw6d
	zU0uRjlggc5LhvL5nNw==
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4486c1cv6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:08:56 -0500 (EST)
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5402939428aso2523858e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 16:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737418134; x=1738022934;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnSjXMmCUkqvr5kxnJNOEq51fuG8cdrrxxa0ojHLblA=;
        b=bVS7c0xLlmv+5ibejvsZIRkR4LRo9P3Tid/GZLDqni+lYg+4LVIm4aVjDQL600FgZB
         3I3I7jlOF1HxJ+kkiac9Gar8iRRbxkERXCZuaU6qSJ8FkSxW8H0mSTc32hokSYJuD1qT
         rQRv2HDCX1lC5ZjoQQzBCflTxHzw5fFeMURK9UipPlETRain78Qli9Lyl11EdJpTQbrm
         dKl+ozeIDdx75HoelL+k4SfoLN8nhK9xbT2s3tPCq+//o2RC9BnlHH7IEScC+XrELhyT
         XapuLOe5vNR+Z28g/BiTLSW9Ot+Lg2BO0u8vJ/veKBOYnrK9AjB71s/EqlMfSwB8Af3N
         fPNA==
X-Gm-Message-State: AOJu0Yx2ClDFuVlgXQW7D/fFs5sNyO5FPu5cUciCGxgKeJrqK2O/R/tx
	3wuM2is8pDck489Xya9XXZoRzPaG3WtODPTeOnTg6Fz3ZtDBd9PvofxRhQsBS0z8PGL7mRNlZPE
	rWxWXIHO+u8oOJyXo4GKxvZSsdRW4VtWHfuhqn34bDqebXdVqToxmZ3fuYOpuOOmhx57CZZjrMt
	R7rN4WMjS6c7yh0vKrbWdZLl0kslmRkbr7U7tosIvl1V8=
X-Gm-Gg: ASbGncudLX+7ZyjOU0BarGebnkKnTRgPVfTcMtZ06F/sMT3/r1LT+6Jg+OthTVRf5tC
	koc15DxGoQlxivpfAyP+n4nvMp1/4UxonhwgRTZyhj0qbb0ENFfhJoU+L1LbAGTdvlIziqT2/J6
	mkvdcqVexpMQ==
X-Received: by 2002:a05:6512:3195:b0:540:269d:3017 with SMTP id 2adb3069b0e04-5439c224a96mr4946383e87.18.1737418134167;
        Mon, 20 Jan 2025 16:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHADwMLGl2iUx9AjapFaaoKx00abXS6Lry6FotcKyR3hxDnOaDjQ//bDPKlQ9I6JDvVhxNMhrnovS8T9JVUK14=
X-Received: by 2002:a05:6512:3195:b0:540:269d:3017 with SMTP id
 2adb3069b0e04-5439c224a96mr4946380e87.18.1737418133818; Mon, 20 Jan 2025
 16:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Renner <nr2185@nyu.edu>
Date: Mon, 20 Jan 2025 19:08:43 -0500
X-Gm-Features: AbW1kvYeFvHa9Z3Lv7xUKkIdLrHUwhDCJHPvUPQOMHnrrdcYwnxfbn1ifNE72ps
Message-ID: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
Subject: Mutex free Pipes
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 5DBwEt5Lh0hYOcruAAZnNQsaHboDRbp3
X-Proofpoint-GUID: 5DBwEt5Lh0hYOcruAAZnNQsaHboDRbp3
X-Orig-IP: 209.85.167.71
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=9 suspectscore=0
 adultscore=0 mlxlogscore=100 bulkscore=1 priorityscore=1501 clxscore=1011
 malwarescore=0 spamscore=9 lowpriorityscore=1 mlxscore=9 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200197

Hi,

I've been conducting research using a libraryOS that I've designed
that uses a mutex free FIFO to implement pipes while adhering to
Linux's API. I found that this can increase throughput by close to 3X,
and that most of the overhead is due to the pipe's mutex preventing
concurrent writes and reads. I see that there is a similar
implementation to this used in the kernel provided in kfifo.h which
could possibly be used to improve this.

I couldn't find much information about why Linux doesn't employ a
strategy like this and was hoping for some feedback. This is my first
time posting here, appreciate any responses!

Thanks!

