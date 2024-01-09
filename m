Return-Path: <linux-fsdevel+bounces-7651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF7828C87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEC928ED08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEA3C493;
	Tue,  9 Jan 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vJrGJgA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAC3C47E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso28797039f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704824630; x=1705429430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jaxGUEyjjT70AazpMXdW6VMfirVxDk0pDKSZssr9mo=;
        b=vJrGJgA2gk5KwElyW5DCfyurlXx/IugLDqZr+MZK25GuvWVrGqG1GXs5bBshQGfiub
         cQha7JDabv8sDv4xxbzUXeNA7hkGUXEZ7+s8xm3vhtk9+6OKX73oCKxbRFkGRfRnsR3e
         75Si2kevOQjXnNymMGb+gZt0migOU/Uh0iNECEO09Vxgl2OJFLBZ/m6pZyl2V3I6sGHa
         rsDcpC95SZNL7n4F3ZV8Ce1Mr/hWyj+RFRh8ZlDCYYgfqBWd39ETNWZ387OVbxNIprMS
         C1pp61l++Cc+giW8/CoyNRdo3b3cELJvJb/8cx15tKjPwdG8r6qSEUVdhXLTXiaq4vg9
         kEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824630; x=1705429430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jaxGUEyjjT70AazpMXdW6VMfirVxDk0pDKSZssr9mo=;
        b=sNKkLURC+OySUeSFvvJlrQZ/KtjXU6DHhgJi6kDZMr3XyzxLMk4qY9cyByRlpIPf0Z
         TdAtmo5szQndVEiZO/IqmLS3nYPaWjCT5wh+QOM/wRpq1z+afJ5V6dUiOdOOpPCoEQkd
         v16gzgQOxWvq23wlBfLlqlpNk+q56aEBVgycDXuR18Q+FlOE5d0Cf0xUxF3SF+51otn2
         1W5TrDyJfl//JIvwjp6I8fNMRmdXwddXmOGBChaNjEV4PJFdW5GCe8g1Ucs7fU5T30eZ
         /An/PFAjrmCVr9mp1HN43g4N/C8Mn52XglF5HFdl+e58Gc8ijdOpvxxciMD3f7GThAEp
         5J6w==
X-Gm-Message-State: AOJu0Yx+Nzt/zCfRfsgYzdvTdtzvb8WjXwKFJr3nMFrREkMtoODL5tbZ
	erTlZw8ziUcnFKNNtpPhrI3l6sV80Jcp3Q==
X-Google-Smtp-Source: AGHT+IFFCQMLSDOG5NBcY/9LEUqUcy7x+GcZ7Aal+Z46ARZgIE547EEu7WF6JTCDRI69BQh876TLMA==
X-Received: by 2002:a5d:8b4c:0:b0:7bc:32b9:2142 with SMTP id c12-20020a5d8b4c000000b007bc32b92142mr8660434iot.1.1704824630618;
        Tue, 09 Jan 2024 10:23:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fw18-20020a0566381d9200b00468ecf31973sm796684jab.67.2024.01.09.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 10:23:50 -0800 (PST)
Message-ID: <ee847921-2b4e-4d81-8cfd-9ca5960ac00f@kernel.dk>
Date: Tue, 9 Jan 2024 11:23:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsnotify: compile out fsnotify permission hooks if
 !FANOTIFY_ACCESS_PERMISSIONS
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <20240109182245.38884-1-amir73il@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240109182245.38884-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 11:22 AM, Amir Goldstein wrote:
> The depency of FANOTIFY_ACCESS_PERMISSIONS on SECURITY made sure that

dependency

> the fsnotify permission hooks were never called when SECURITY was
> disabled.
> 
> Moving the fsnotify permission hook out of the secutiy hook broke that

security

> optimisation.

Patch obviously looks good to me, as I already tested it :-)

Thanks for fixing this up.

-- 
Jens Axboe



