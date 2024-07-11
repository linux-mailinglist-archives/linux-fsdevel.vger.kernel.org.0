Return-Path: <linux-fsdevel+bounces-23540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280D92DFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68331C222D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 06:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4D82899;
	Thu, 11 Jul 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="onZ0lg4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7F20E3;
	Thu, 11 Jul 2024 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720677651; cv=none; b=FLZU2wSoKW6a+OMN6qEsc16miloDxVtQAv1IxKs528aWx6nSh2Q1bxoR2f3yraBfrSbBSfTDAJtM0WtrLa5Q1ZpQF3qW22gikgXVB5COll4ou+6A5G6I3x4/ib/DvKN098Lcknomr36IftcgLX/d5+YpG33+d4AI3EQnGf+T/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720677651; c=relaxed/simple;
	bh=15yJgavZmfHOIomQLcsyf8HlH0B8GycDnNaojP2vIFw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cO1ZbQljcHxnlnZw7alTc2dI6HOHXpPU3UkglMgMatua1hTVqmCh9NYm1m7uwDRn61cuJdEKwQms1jer2ich1iIIPKl4m5s5XdJ5CblDvMEm5YoKHGbypfKYDZCoW7VLmtOspZPqvo7WFZEgrxUhv22EiDWAMP/cBel8bEV/+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=onZ0lg4L; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720677636; x=1721282436; i=markus.elfring@web.de;
	bh=c5z5eE89ZdgKIAIW2hKoAi6mxSiJBE0HAuchu+r3jpE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=onZ0lg4LU/P7TTOlP2WIBvLsLNPG+qhcOwQWg78btNLs2wt71SxLJSDBEdqjPMWt
	 6lqzetMVvdlpbBCsyYQmROJNNRkNkekp489199Vh3e7XyI9SoPFqKNfk2t/NGuGp2
	 DXm8NgI3bQQxvpj9juGLR2RkWHdxhiBFm5ImhnxQ3dtRLJbsoEJPRVuteFPQuEaVF
	 nm8EwvxjGk6LKcIwBxSZ0MOiuewCqIVta5u8pxdyS1Uju1iw5pc39cnm5NyvdbFVh
	 ywDfhXdc6M98noslQEE72n5gaYNR+dOSCkrP5kvOlRsyXqZ2SHc1DcnWsnrg3MmG+
	 7D2RI/mW/ItEXe4X2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHYA-1sCRu02gwq-00x2l5; Thu, 11
 Jul 2024 08:00:36 +0200
Message-ID: <eb0374b3-d040-4263-96c8-d0dce88432d6@web.de>
Date: Thu, 11 Jul 2024 08:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
To: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JrQvtCy0LDQu9C10LI=?=
 <kovalevvv@basealt.ru>, linux-fsdevel@vger.kernel.org,
 lvc-patches@linuxtesting.org,
 syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, dutyrok@altlinux.org
References: <20240710191118.40431-2-kovalev@altlinux.org>
 <8fd93c4e-3324-49b6-a77c-ea9986bc3033@web.de>
 <cd942b65-b6d7-0e0f-be4d-c3b950ee008f@basealt.ru>
Content-Language: en-GB
In-Reply-To: <cd942b65-b6d7-0e0f-be4d-c3b950ee008f@basealt.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:86ZKGI08fjNtBWXHY9MnuWMqn3PBSvK2+nPyLSxvjz7M9h1fSDI
 lqLtoPG/Hx7oyVpjV20sdIdX+ejpKssu3fPi69yn1P9fW+P5JPlpi4/0vutt+u3s8+95324
 NMXBNsXa7we7bDoAjKtOKq4idAobG4YjKjL5Vo1l/+KCd0WXmfhNgZq+DmlM1zKCWgMbq53
 stj82fY+93Lgp4jQXEAJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:POb5WFD1nyk=;cgbCI0MOffS3c4AuoLKqyh9y493
 3TX7eB0IgQmMXJdTH3o8PjBXI1Yg0ASIN7LeyoaYXlGtyuG6dLSLoCHzZM19AJCUqUnFKYcbL
 S5t1AH/+UtyFelSxU+5f3Mo9/xa0gjC2Ms8DUeSizaaQYoJsdzKbZ0q/WZowTZePAMf0yVO0M
 OPGOYGcup2kDbNfQEZadB6uQGqIb6VjOnDvE9+vcJFocFJHGIzNek28A+wEQ0LSKSkVG6W0F1
 EMm9HvGAgPYvpt7Muam67osu9vXMPqF08LNU3xCJSE5Yg327Hw/RZeLRs8rKp5HXbFV48lsof
 tOsqMsxOchMAtbEuL9J0y8IhgRbugHT/1+h5hSU3kGClaTnJmACw/cOnuG+Mtgd4IwQOwoPAv
 P7oZJXqOvyr0sbdTeKdoo4byuEg9pt6LfpFauYCYLtZWf79W5MU2JLZdfEOtazeHCFZ88tjLS
 Jmk7760Wxy2RsKJRHYELcnojIPtTmRFThKtx9QpCQzbU1f536Uy0YscspnaKXC20wm9js9u3+
 qUNy1X0rqSRnyTSrLYwidLI9pgV3AnLw2aIjPqIqt45s2HUVoqWuz8na297mlzzrgWW1wSyMO
 uXNSni+RbRjL6WRpOTqIA58YZXKfN7PsM+4xPsUixSrx2f07BMic4qA2TSjb6N+J3+oqTGdDy
 k1QKtpVkEZOTP/opnlRk5BbSIcvUp5WU4/Ib4qjIw2zIz6A+OrpDHJCmX1C6idSCSd9HdSGn5
 Zy2yeo7w75hNiiYZLAfeGvHL2V/idQ4hx2iicJbqZGHhjqd5nrqibgARnJ64Xvl3ZztTekhkF
 5B9IFOLhyNYsvrBYnWLRunBA==

> Add a check to ensure that a sb_getblk() call did not return NULL before copying data.

How do you think about another refinement for such a change description?

   Detect a failed sb_getblk() call (before copying data)
   so that null pointer dereferences should not happen any more.


Regards,
Markus


