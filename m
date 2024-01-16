Return-Path: <linux-fsdevel+bounces-8080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327282F374
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E61F23FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F31CD1A;
	Tue, 16 Jan 2024 17:46:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F41CD03;
	Tue, 16 Jan 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427214; cv=none; b=GV2AhIkO9COVMbU9c0fJOYJz4BZ9m/V0tKjYclTvkkukupjh0s+TeZMnoRaQCocgf1bzL6H8f1FTDt9PlD0PIbvpNpPjWDFB5ZZi/7z99JazSN6qBTzqGqWv5v0W6rK/eYW9tr05IBs/QbQ/dfSUkdkPTf/Z+GOEu8LTPwKQoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427214; c=relaxed/simple;
	bh=mF2Pcx1Y6XgufEDdf9co/hay79iWlLKl5sHlCbZwenI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=cb+kC0R9+wLaagsz40givE4Zt0BXox2oMH6Qnbl7CuJtBDxJdWDAxwwOsDgD3I+16FA121d8jVp9rH3MXy0QqDmNvHePIFCQcdNCmaOX0dW/78hxp38vQ1jEceLf/BZP3eqcT1LaewRHAis1J7uZLNLSln/97G2Vp9XczaednI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6db786df38dso2173306b3a.0;
        Tue, 16 Jan 2024 09:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427212; x=1706032012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUjnNd4KLAllztA1i10ulcFfvTiNTtL3QQRXVBrw52s=;
        b=oThB6qatXfgRhWzra0FSJz4A7osiurevKX7P7QRrLEaC7o1uh22F6VLgt3LN9a6kgo
         SOSpdcf2eFs4L5hjhoL9tELH73gl5EdOOTGVeMZmkjwoM+5CbyjLqGnVPkULKiPqezbq
         RnbJ/hVIObK4l+JyWS0DChdINFakw10Edk11op2DMM1wzI0Hq7NK2dwpYsPtTxGMHcR8
         mUXqhGgJmB9ltxYtXy8sV50fs8QJLUM23fq1dWTlcoeK153cou9yGRPzk9uyU1SAoG33
         hd89r/W9+vjWfUXMX7Grlb8u1QWIHphIdX4Fef162/SCOl0tfv5ccIdWXvLNEEniFZIh
         UwQw==
X-Gm-Message-State: AOJu0YyZnGY2+gZ7BvWxU/W1jtTfXPS+4VTCfocB7gKwLjZc0z0LeQMm
	U1lw5RWpmcjFQV3K1OkNTnQ=
X-Google-Smtp-Source: AGHT+IGC5ymJUoEXajQx59WFe1SfIYFFXKe2mConqsnNsIcfim0Zl3BJ+3BliR2GEHkcT6BXFo9qlw==
X-Received: by 2002:a62:5b45:0:b0:6d9:acc8:98da with SMTP id p66-20020a625b45000000b006d9acc898damr8338102pfb.2.1705427212349;
        Tue, 16 Jan 2024 09:46:52 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:bf53:62d5:82c4:7343? ([2620:0:1000:8411:bf53:62d5:82c4:7343])
        by smtp.gmail.com with ESMTPSA id f11-20020a63510b000000b005cd8ada89e5sm10422488pgb.70.2024.01.16.09.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 09:46:52 -0800 (PST)
Message-ID: <ebe78689-df8a-46ad-9593-05a2f7840f5f@acm.org>
Date: Tue, 16 Jan 2024 09:46:50 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 a.manzanares@samsung.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 slava@dubeiko.com, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/24 09:54, Javier González wrote:
> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>> How soon FDP API will be available for kernel-space file systems?
> 
> The work is done. We will submit as Bart's patches are applied.

Since the FDP users need the data lifetime patch series, how about helping
with a review of this patch series?

Thanks,

Bart.


